
Row(
                    children: ['All', 'Block A', 'Block B', 'Block C'].map((block) {
                      final isSelected = provider.selectedBlock == block;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(block),
                          selected: isSelected,
                          onSelected: (selected) {
                            provider.setSelectedBlock(block);
                          },
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? AppColors.white : AppColors.textDark,
                          ),
                        ),
                      );
                    }).toList(),
                  )