Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5162CD118
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgLCIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:17:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8927 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgLCIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:17:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmpZ93lwYz782y;
        Thu,  3 Dec 2020 16:16:01 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 3 Dec 2020
 16:16:23 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid race condition for shinker
 count
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Light Hsieh <Light.Hsieh@mediatek.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <20201112053414.GB3826485@google.com> <20201112054051.GA4092972@google.com>
 <X8iAh7quYw77O6XC@google.com>
 <df364dab-6640-654b-c36e-3f84f4bcbc2b@huawei.com>
 <X8iaCHmmCQzzJdu3@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ff3e33df-f3d3-a8b9-6a19-8f95ee646c3f@huawei.com>
Date:   Thu, 3 Dec 2020 16:16:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X8iaCHmmCQzzJdu3@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/3 15:55, Jaegeuk Kim wrote:
> How about adding another variable to monitor it?

That makes more sense. :)

I've checked this, LGTM.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>From bdc5a805487f0210df7ef4e85ce5a4f0471bca72 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim<jaegeuk@kernel.org>
> Date: Fri, 6 Nov 2020 13:22:05 -0800
> Subject: [PATCH] f2fs: avoid race condition for shrinker count
> 
> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
> wrong do_shinker work. Let's avoid to return insane overflowed value by adding
> single tracking value.
> 
> Reported-by: Light Hsieh<Light.Hsieh@mediatek.com>
> Signed-off-by: Jaegeuk Kim<jaegeuk@kernel.org>
> ---
>   fs/f2fs/checkpoint.c |  2 +-
>   fs/f2fs/debug.c      | 11 ++++++-----
>   fs/f2fs/f2fs.h       | 10 ++++++++--
>   fs/f2fs/node.c       | 29 ++++++++++++++++++-----------
>   fs/f2fs/node.h       |  4 ++--
>   fs/f2fs/shrinker.c   |  4 +---
>   6 files changed, 36 insertions(+), 24 deletions(-)
> 
> =======================================
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 14ba1519639e..617d0f6b0836 100644
> 
> --- a/fs/f2fs/checkpoint.c
> 
> +++ b/fs/f2fs/checkpoint.c
> 
> @@ -1619,7 +1619,7 @@
> 
>   int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
> goto out;
> }
> - if (NM_I(sbi)->dirty_nat_cnt == 0 &&
> + if (NM_I(sbi)->nat_cnt[DIRTY_NAT] == 0 &&
> SIT_I(sbi)->dirty_sentries == 0 &&
> prefree_segments(sbi) == 0) {
> f2fs_flush_sit_entries(sbi, cpc);
> 
> =======================================
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index a8357fd4f5fa..197c914119da 100644
> 
> --- a/fs/f2fs/debug.c
> 
> +++ b/fs/f2fs/debug.c
> 
> @@ -145,8 +145,8 @@
> 
>   static void update_general_status(struct f2fs_sb_info *sbi)
> 
> si->node_pages = NODE_MAPPING(sbi)->nrpages;
> if (sbi->meta_inode)
> si->meta_pages = META_MAPPING(sbi)->nrpages;
> - si->nats = NM_I(sbi)->nat_cnt;
> - si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
> + si->nats = NM_I(sbi)->nat_cnt[TOTAL_NAT];
> + si->dirty_nats = NM_I(sbi)->nat_cnt[DIRTY_NAT];
> si->sits = MAIN_SEGS(sbi);
> si->dirty_sits = SIT_I(sbi)->dirty_sentries;
> si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID];
> 
> @@ -278,9 +278,10 @@
> 
>   static void update_mem_info(struct f2fs_sb_info *sbi)
> 
> si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID] +
> NM_I(sbi)->nid_cnt[PREALLOC_NID]) *
> sizeof(struct free_nid);
> - si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
> - si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
> - sizeof(struct nat_entry_set);
> + si->cache_mem += NM_I(sbi)->nat_cnt[TOTAL_NAT] *
> + sizeof(struct nat_entry);
> + si->cache_mem += NM_I(sbi)->nat_cnt[DIRTY_NAT] *
> + sizeof(struct nat_entry_set);
> si->cache_mem += si->inmem_pages * sizeof(struct inmem_pages);
> for (i = 0; i < MAX_INO_ENTRY; i++)
> si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
> 
> =======================================
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4417f791dbc6..78394ea91717 100644
> 
> --- a/fs/f2fs/f2fs.h
> 
> +++ b/fs/f2fs/f2fs.h
> 
> @@ -818,6 +818,13 @@
> 
>   enum nid_state {
> 
> MAX_NID_STATE,
> };
> +enum nat_state {
> + TOTAL_NAT,
> + DIRTY_NAT,
> + RECLAIMABLE_NAT,
> + MAX_NAT_STATE,
> +};
> +
> struct f2fs_nm_info {
> block_t nat_blkaddr; /* base disk address of NAT */
> nid_t max_nid; /* maximum possible node ids */
> 
> @@ -833,8 +840,7 @@
> 
>   struct f2fs_nm_info {
> 
> struct rw_semaphore nat_tree_lock; /* protect nat_tree_lock */
> struct list_head nat_entries; /* cached nat entry list (clean) */
> spinlock_t nat_list_lock; /* protect clean nat entry list */
> - unsigned int nat_cnt; /* the # of cached nat entries */
> - unsigned int dirty_nat_cnt; /* total num of nat entries in set */
> + unsigned int nat_cnt[MAX_NAT_STATE]; /* the # of cached nat entries */
> unsigned int nat_blocks; /* # of nat blocks */
> /* free node ids management */
> 
> =======================================
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 42394de6c7eb..e65d73293a3f 100644
> 
> --- a/fs/f2fs/node.c
> 
> +++ b/fs/f2fs/node.c
> 
> @@ -62,8 +62,8 @@
> 
>   bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
> 
> sizeof(struct free_nid)) >> PAGE_SHIFT;
> res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
> } else if (type == NAT_ENTRIES) {
> - mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >>
> - PAGE_SHIFT;
> + mem_size = (nm_i->nat_cnt[TOTAL_NAT] *
> + sizeof(struct nat_entry)) >> PAGE_SHIFT;
> res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
> if (excess_cached_nats(sbi))
> res = false;
> 
> @@ -177,7 +177,8 @@
> 
>   static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
> 
> list_add_tail(&ne->list, &nm_i->nat_entries);
> spin_unlock(&nm_i->nat_list_lock);
> - nm_i->nat_cnt++;
> + nm_i->nat_cnt[TOTAL_NAT]++;
> + nm_i->nat_cnt[RECLAIMABLE_NAT]++;
> return ne;
> }
> 
> @@ -207,7 +208,8 @@
> 
>   static unsigned int __gang_lookup_nat_cache(struct f2fs_nm_info *nm_i,
> 
> static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
> {
> radix_tree_delete(&nm_i->nat_root, nat_get_nid(e));
> - nm_i->nat_cnt--;
> + nm_i->nat_cnt[TOTAL_NAT]--;
> + nm_i->nat_cnt[RECLAIMABLE_NAT]--;
> __free_nat_entry(e);
> }
> 
> @@ -253,7 +255,8 @@
> 
>   static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> 
> if (get_nat_flag(ne, IS_DIRTY))
> goto refresh_list;
> - nm_i->dirty_nat_cnt++;
> + nm_i->nat_cnt[DIRTY_NAT]++;
> + nm_i->nat_cnt[RECLAIMABLE_NAT]--;
> set_nat_flag(ne, IS_DIRTY, true);
> refresh_list:
> spin_lock(&nm_i->nat_list_lock);
> 
> @@ -273,7 +276,8 @@
> 
>   static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> 
> set_nat_flag(ne, IS_DIRTY, false);
> set->entry_cnt--;
> - nm_i->dirty_nat_cnt--;
> + nm_i->nat_cnt[DIRTY_NAT]--;
> + nm_i->nat_cnt[RECLAIMABLE_NAT]++;
> }
> static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
> 
> @@ -2944,14 +2948,17 @@
> 
>   int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
> LIST_HEAD(sets);
> int err = 0;
> - /* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
> + /*
> + * during unmount, let's flush nat_bits before checking
> + * nat_cnt[DIRTY_NAT].
> + */
> if (enabled_nat_bits(sbi, cpc)) {
> down_write(&nm_i->nat_tree_lock);
> remove_nats_in_journal(sbi);
> up_write(&nm_i->nat_tree_lock);
> }
> - if (!nm_i->dirty_nat_cnt)
> + if (!nm_i->nat_cnt[DIRTY_NAT])
> return 0;
> down_write(&nm_i->nat_tree_lock);
> 
> @@ -2962,7 +2969,8 @@
> 
>   int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
> * into nat entry set.
> */
> if (enabled_nat_bits(sbi, cpc) ||
> - !__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
> + !__has_cursum_space(journal,
> + nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
> remove_nats_in_journal(sbi);
> while ((found = __gang_lookup_nat_set(nm_i,
> 
> @@ -3086,7 +3094,6 @@
> 
>   static int init_node_manager(struct f2fs_sb_info *sbi)
> 
> F2FS_RESERVED_NODE_NUM;
> nm_i->nid_cnt[FREE_NID] = 0;
> nm_i->nid_cnt[PREALLOC_NID] = 0;
> - nm_i->nat_cnt = 0;
> nm_i->ram_thresh = DEF_RAM_THRESHOLD;
> nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
> nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
> 
> @@ -3220,7 +3227,7 @@
> 
>   void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
> 
> __del_from_nat_cache(nm_i, natvec[idx]);
> }
> }
> - f2fs_bug_on(sbi, nm_i->nat_cnt);
> + f2fs_bug_on(sbi, nm_i->nat_cnt[TOTAL_NAT]);
> /* destroy nat set cache */
> nid = 0;
> 
> =======================================
> 
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 69e5859e993c..f84541b57acb 100644
> 
> --- a/fs/f2fs/node.h
> 
> +++ b/fs/f2fs/node.h
> 
> @@ -126,13 +126,13 @@
> 
>   static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
> 
> static inline bool excess_dirty_nats(struct f2fs_sb_info *sbi)
> {
> - return NM_I(sbi)->dirty_nat_cnt >= NM_I(sbi)->max_nid *
> + return NM_I(sbi)->nat_cnt[DIRTY_NAT] >= NM_I(sbi)->max_nid *
> NM_I(sbi)->dirty_nats_ratio / 100;
> }
> static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
> {
> - return NM_I(sbi)->nat_cnt >= DEF_NAT_CACHE_THRESHOLD;
> + return NM_I(sbi)->nat_cnt[TOTAL_NAT] >= DEF_NAT_CACHE_THRESHOLD;
> }
> static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
> 
> =======================================
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index d66de5999a26..dd3c3c7a90ec 100644
> 
> --- a/fs/f2fs/shrinker.c
> 
> +++ b/fs/f2fs/shrinker.c
> 
> @@ -18,9 +18,7 @@
> 
>   static unsigned int shrinker_run_no;
> 
> static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
> {
> - long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> -
> - return count > 0 ? count : 0;
> + return NM_I(sbi)->nat_cnt[RECLAIMABLE_NAT];
> }
> static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
> 
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
> .
> 
> 
> 
> 
> 
