-- Properly fixed markview.nvim configuration
return {
    "OXY1DEV/markview.nvim",
    lazy = false,
    ft = "markdown",
    
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    
    config = function()
        require("markview").setup({
            -- Use preview namespace for modes and callbacks
            preview = {
                modes = { "n", "no", "c" },
                hybrid_modes = { "n" },
                
                callbacks = {
                    on_enable = function(_, win)
                        vim.wo[win].conceallevel = 2
                        vim.wo[win].concealcursor = "nvc"
                    end,
                    on_disable = function(_, win)
                        vim.wo[win].conceallevel = 0
                        vim.wo[win].concealcursor = ""
                    end
                }
            },

            -- Use markdown namespace for markdown elements
            markdown = {
                headings = {
                    enable = true,
                    shift_width = 1,
                    
                    heading_1 = {
                        style = "icon",
                        icon = "# ",
                        hl = "MarkviewHeading1"
                    },
                    heading_2 = {
                        style = "icon", 
                        icon = "## ",
                        hl = "MarkviewHeading2"
                    },
                    heading_3 = {
                        style = "icon",
                        icon = "### ",
                        hl = "MarkviewHeading3"
                    },
                    heading_4 = {
                        style = "icon",
                        icon = "#### ",
                        hl = "MarkviewHeading4"
                    },
                    heading_5 = {
                        style = "icon",
                        icon = "##### ",
                        hl = "MarkviewHeading5"
                    },
                    heading_6 = {
                        style = "icon",
                        icon = "###### ",
                        hl = "MarkviewHeading6"
                    }
                },

                list_items = {
                    enable = true,
                    shift_width = 2,
                    
                    marker_minus = {
                        add_padding = true,
                        text = "•",
                        hl = "MarkviewListItemMinus"
                    },
                    marker_plus = {
                        add_padding = true,
                        text = "▸",
                        hl = "MarkviewListItemPlus"
                    },
                    marker_star = {
                        add_padding = true,
                        text = "★",
                        hl = "MarkviewListItemStar"
                    }
                },

                horizontal_rules = {
                    enable = true,
                    parts = {
                        {
                            type = "repeating",
                            text = "─",
                            hl = "MarkviewHorizontalRule"
                        }
                    }
                },

                block_quotes = {
                    enable = true,
                    default = {
                        border = "▎",
                        border_hl = "MarkviewBlockQuoteBorder"
                    }
                },

                tables = {
                    enable = true,
                    use_virt_lines = true,
                    hl = "MarkviewTable"
                }
            },

            -- Use code_blocks with border_hl instead of hl
            code_blocks = {
                enable = true,
                style = "language",
                border_hl = "MarkviewCodeBlock",
                min_width = 60,
                pad_amount = 1
            },

            checkboxes = {
                enable = true,
                checked = {
                    text = "✓",
                    hl = "MarkviewCheckboxChecked"
                },
                unchecked = {
                    text = "○",
                    hl = "MarkviewCheckboxUnchecked"
                }
            },

            inline_codes = {
                enable = true,
                hl = "MarkviewInlineCode"
            },

            links = {
                enable = true,
                hyperlinks = {
                    icon = "🔗 ",
                    hl = "MarkviewHyperlink"
                },
                images = {
                    icon = "🖼 ",
                    hl = "MarkviewImage"
                }
            }
        })

        -- Simple highlight setup
        local function setup_highlights()
            local highlights = {
                MarkviewHeading1 = { fg = "#ff6b9d", bold = true },
                MarkviewHeading2 = { fg = "#c678dd", bold = true },
                MarkviewHeading3 = { fg = "#61afef", bold = true },
                MarkviewHeading4 = { fg = "#98c379", bold = true },
                MarkviewHeading5 = { fg = "#e5c07b", bold = true },
                MarkviewHeading6 = { fg = "#d19a66", bold = true },
                
                MarkviewListItemMinus = { fg = "#61afef" },
                MarkviewListItemPlus = { fg = "#98c379" },
                MarkviewListItemStar = { fg = "#e06c75" },
                
                MarkviewCheckboxChecked = { fg = "#98c379" },
                MarkviewCheckboxUnchecked = { fg = "#5c6370" },
                
                MarkviewCodeBlock = { bg = "#2c323c" },
                MarkviewInlineCode = { bg = "#2c323c", fg = "#e06c75" },
                
                MarkviewHyperlink = { fg = "#61afef", underline = true },
                MarkviewImage = { fg = "#98c379" },
                
                MarkviewBlockQuoteBorder = { fg = "#5c6370" },
                MarkviewHorizontalRule = { fg = "#5c6370" },
                MarkviewTable = { fg = "#abb2bf" }
            }
            
            for group, opts in pairs(highlights) do
                vim.api.nvim_set_hl(0, group, opts)
            end
        end

        -- Apply highlights
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = setup_highlights
        })
        setup_highlights()

        -- Key mappings
        vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
        vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "Toggle Split View" })

        -- Auto-enable for markdown files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.cmd("Markview enable")
            end
        })
    end
}
