Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC132C6AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgK0RoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:44:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:38496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgK0RoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:44:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30D0CAC55;
        Fri, 27 Nov 2020 17:44:19 +0000 (UTC)
Subject: Re: [PATCH v3] mm/shmem.c: make shmem_mapping() inline
To:     Hui Su <sh_def@163.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201115165207.GA265355@rlk>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <89b2b0f5-a502-bd56-0234-bfcd72ef8765@suse.cz>
Date:   Fri, 27 Nov 2020 18:44:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201115165207.GA265355@rlk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/20 5:52 PM, Hui Su wrote:
> shmem_mapping() isn't worth an out-of-line call
> from any callsite.
> 
> So make it inline by
> - make shmem_aops global
> - export shmem_aops
> - inline the shmem_mapping()
> 
> and replace the direct call 'shmem_aops' with shmem_mapping()
> in shmem.c.
> 
> v1->v2:
> remove the inline for func declaration in shmem_fs.h
> 
> v2->v3:
> make shmem_aops global, and export it to modules.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   include/linux/shmem_fs.h |  6 +++++-
>   mm/shmem.c               | 16 ++++++----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a5a5d1d4d7b1..d82b6f396588 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -67,7 +67,11 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>   		unsigned long len, unsigned long pgoff, unsigned long flags);
>   extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
>   #ifdef CONFIG_SHMEM
> -extern bool shmem_mapping(struct address_space *mapping);
> +extern const struct address_space_operations shmem_aops;
> +static inline bool shmem_mapping(struct address_space *mapping)
> +{
> +	return mapping->a_ops == &shmem_aops;
> +}
>   #else
>   static inline bool shmem_mapping(struct address_space *mapping)
>   {
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..b7361fce50bc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -246,7 +246,7 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
>   }
>   
>   static const struct super_operations shmem_ops;
> -static const struct address_space_operations shmem_aops;
> +const struct address_space_operations shmem_aops;
>   static const struct file_operations shmem_file_operations;
>   static const struct inode_operations shmem_inode_operations;
>   static const struct inode_operations shmem_dir_inode_operations;
> @@ -1152,7 +1152,7 @@ static void shmem_evict_inode(struct inode *inode)
>   	struct shmem_inode_info *info = SHMEM_I(inode);
>   	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>   
> -	if (inode->i_mapping->a_ops == &shmem_aops) {
> +	if (shmem_mapping(inode->i_mapping)) {
>   		shmem_unacct_size(info->flags, inode->i_size);
>   		inode->i_size = 0;
>   		shmem_truncate_range(inode, 0, (loff_t)-1);
> @@ -1858,7 +1858,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>   	}
>   
>   	/* shmem_symlink() */
> -	if (mapping->a_ops != &shmem_aops)
> +	if (!shmem_mapping(mapping))
>   		goto alloc_nohuge;
>   	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
>   		goto alloc_nohuge;
> @@ -2352,11 +2352,6 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>   	return inode;
>   }
>   
> -bool shmem_mapping(struct address_space *mapping)
> -{
> -	return mapping->a_ops == &shmem_aops;
> -}
> -
>   static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>   				  pmd_t *dst_pmd,
>   				  struct vm_area_struct *dst_vma,
> @@ -3865,7 +3860,7 @@ static void shmem_destroy_inodecache(void)
>   	kmem_cache_destroy(shmem_inode_cachep);
>   }
>   
> -static const struct address_space_operations shmem_aops = {
> +const struct address_space_operations shmem_aops = {
>   	.writepage	= shmem_writepage,
>   	.set_page_dirty	= __set_page_dirty_no_writeback,
>   #ifdef CONFIG_TMPFS
> @@ -3877,6 +3872,7 @@ static const struct address_space_operations shmem_aops = {
>   #endif
>   	.error_remove_page = generic_error_remove_page,
>   };
> +EXPORT_SYMBOL(shmem_aops);
>   
>   static const struct file_operations shmem_file_operations = {
>   	.mmap		= shmem_mmap,
> @@ -4312,7 +4308,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>   	struct page *page;
>   	int error;
>   
> -	BUG_ON(mapping->a_ops != &shmem_aops);
> +	BUG_ON(!shmem_mapping(mapping));
>   	error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
>   				  gfp, NULL, NULL, NULL);
>   	if (error)
> 

