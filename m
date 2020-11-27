Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF02C6A91
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbgK0R0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:26:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:54924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgK0R0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:26:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2665CAE95;
        Fri, 27 Nov 2020 17:26:24 +0000 (UTC)
To:     Hui Su <sh_def@163.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201115174026.GA365412@rlk>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/shmem: use kmem_cache_zalloc in shmem_alloc_inode()
Message-ID: <416a0cb6-fe34-a7ff-6021-92b8dff24f0b@suse.cz>
Date:   Fri, 27 Nov 2020 18:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201115174026.GA365412@rlk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/20 6:40 PM, Hui Su wrote:
> in shmem_get_inode():
> new_inode();
>    new_inode_pseudo();
>      alloc_inode();
>        ops->alloc_inode(); -> shmem_alloc_inode()
>          kmem_cache_alloc();
> 
> memset(info, 0, (char *)inode - (char *)info);
> 
> So use kmem_cache_zalloc() in shmem_alloc_inode(),
> and remove the memset in shmem_get_inode().
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Looks correct, but now we clear also the inode part which seems to be handled by 
alloc_inode() well enough. So, unsure. btrfs and ext4 variants don't use kzalloc 
neither. It's also more obvious with the current way that the info is cleared. Hmm?

> ---
>   mm/shmem.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..b84adda45461 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2308,7 +2308,6 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>   		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>   		inode->i_generation = prandom_u32();
>   		info = SHMEM_I(inode);
> -		memset(info, 0, (char *)inode - (char *)info);
>   		spin_lock_init(&info->lock);
>   		atomic_set(&info->stop_eviction, 0);
>   		info->seals = F_SEAL_SEAL;
> @@ -3828,7 +3827,7 @@ static struct kmem_cache *shmem_inode_cachep;
>   static struct inode *shmem_alloc_inode(struct super_block *sb)
>   {
>   	struct shmem_inode_info *info;
> -	info = kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
> +	info = kmem_cache_zalloc(shmem_inode_cachep, GFP_KERNEL);
>   	if (!info)
>   		return NULL;
>   	return &info->vfs_inode;
> 

