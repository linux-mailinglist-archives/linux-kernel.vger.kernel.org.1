Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5B2F589E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhANCp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:45:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11097 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANCp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:45:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DGTCb4pQMzMK9m;
        Thu, 14 Jan 2021 10:43:55 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 14 Jan
 2021 10:45:13 +0800
Subject: Re: [f2fs-dev] [PATCH v3 1/5] f2fs: compress: add compress_inode to
 cache compressed blocks
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210107093126.116958-1-yuchao0@huawei.com>
 <X/we0NoUqAwuW82+@google.com>
 <6b0060b9-460a-617a-3778-e67f35d551f0@huawei.com>
 <cdd681ad-462d-cb37-2b4b-8f9d547bc718@huawei.com>
 <b44c2af4-d142-baff-387c-6b967f76065c@huawei.com>
 <X/0DxG+AcX54730W@google.com>
 <160f2cf9-73ca-18cd-6ad0-2498821b8db6@huawei.com>
 <X/4kYf11oyoMY8P+@google.com>
 <abc09f9f-561d-df8a-b835-6b5d7a15232c@huawei.com>
 <X/8UtJU9Dy30kC7I@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <37ba41db-2589-e155-c416-d0c8832026cb@huawei.com>
Date:   Thu, 14 Jan 2021 10:45:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X/8UtJU9Dy30kC7I@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/13 23:41, Jaegeuk Kim wrote:
> [58690.961685] F2FS-fs (vdb) : inject page get in f2fs_pagecache_get_page of f2fs_quota_write+0x150/0x1f0 [f2fs]
> [58691.071481] F2FS-fs (vdb): Inconsistent error blkaddr:31058, sit bitmap:0
> [58691.077338] ------------[ cut here ]------------
> [58691.081461] WARNING: CPU: 5 PID: 8308 at fs/f2fs/checkpoint.c:151 f2fs_is_valid_blkaddr+0x1e9/0x280 [f2fs]
> [58691.086734] Modules linked in: f2fs(O) quota_v2 quota_tree dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ppdev intel_rapl_msr intel_rapl_common sb_edac kvm_intel kvm irqbypass joydev parport_pc parport input_leds serio_raw mac_hid qemu_fw_cfg sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy asy
> [58691.120632] CPU: 5 PID: 8308 Comm: kworker/u17:5 Tainted: G      D    O      5.11.0-rc3-custom #1
> [58691.125438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
> [58691.129625] Workqueue: f2fs_post_read_wq f2fs_post_read_work [f2fs]
> [58691.133142] RIP: 0010:f2fs_is_valid_blkaddr+0x1e9/0x280 [f2fs]
> [58691.136221] Code: 3c 07 b8 01 00 00 00 d3 e0 21 f8 75 57 83 fa 07 75 52 89 f2 31 c9 48 c7 c6 20 6a a7 c0 48 89 df e8 bc d6 03 00 f0 80 4b 48 04 <0f> 0b 31 c0 e9 5e fe ff ff 48 8b 57 10 8b 42 30 d3 e0 03 42 48 39
> [58691.143142] RSP: 0018:ffffb429047afd40 EFLAGS: 00010206
> [58691.145639] RAX: 0000000000000000 RBX: ffff9c3b84041000 RCX: 0000000000000000
> [58691.148899] RDX: 0000000000000000 RSI: ffff9c3bbbd58940 RDI: ffff9c3bbbd58940
> [58691.152130] RBP: ffffb429047afd48 R08: ffff9c3bbbd58940 R09: ffffb429047afaa8
> [58691.155266] R10: 00000000001ba090 R11: 0000000000000003 R12: 0000000000007952
> [58691.158304] R13: fffff5cc81266ac0 R14: 00000000000000db R15: 0000000000000000
> [58691.161160] FS:  0000000000000000(0000) GS:ffff9c3bbbd40000(0000) knlGS:0000000000000000
> [58691.164286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [58691.166869] CR2: 00007f0fee9d3000 CR3: 000000005ee76001 CR4: 0000000000370ee0
> [58691.169714] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [58691.173102] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [58691.176163] Call Trace:
> [58691.177948]  f2fs_cache_compressed_page+0x69/0x280 [f2fs]
> [58691.180549]  ? newidle_balance+0x253/0x3d0
> [58691.183238]  f2fs_end_read_compressed_page+0x5a/0x70 [f2fs]
> [58691.188205]  f2fs_post_read_work+0x11d/0x120 [f2fs]
> [58691.192489]  process_one_work+0x221/0x3a0
> [58691.194482]  worker_thread+0x4d/0x3f0
> [58691.198867]  kthread+0x114/0x150
> [58691.202243]  ? process_one_work+0x3a0/0x3a0
> [58691.205367]  ? kthread_park+0x90/0x90
> [58691.208244]  ret_from_fork+0x22/0x30

Below patch fixes two issues, I expect this can fix above warning at least.

- detect truncation during f2fs_cache_compressed_page()
- don't set PageUptodate for temporary page in f2fs_load_compressed_page()

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
  fs/f2fs/compress.c | 20 +++++++++++++-------
  fs/f2fs/data.c     |  3 +--
  fs/f2fs/f2fs.h     |  6 +++---
  3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 0fec71e40001..f364c10c506c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1741,7 +1741,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
  	if (!test_opt(sbi, COMPRESS_CACHE))
  		return;

-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
  		return;

  	si_meminfo(&si);
@@ -1774,21 +1774,25 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
  		return;
  	}

-	memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
-	SetPageUptodate(cpage);
-
  	f2fs_set_page_private(cpage, ino);

+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
+		goto out;
+
+	memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
+	SetPageUptodate(cpage);
+out:
  	f2fs_put_page(cpage, 1);
  }

-void f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
+bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
  								block_t blkaddr)
  {
  	struct page *cpage;
+	bool hitted = false;

  	if (!test_opt(sbi, COMPRESS_CACHE))
-		return;
+		return false;

  	cpage = f2fs_pagecache_get_page(COMPRESS_MAPPING(sbi),
  				blkaddr, FGP_LOCK | FGP_NOWAIT, GFP_NOFS);
@@ -1797,10 +1801,12 @@ void f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
  			atomic_inc(&sbi->compress_page_hit);
  			memcpy(page_address(page),
  				page_address(cpage), PAGE_SIZE);
-			SetPageUptodate(page);
+			hitted = true;
  		}
  		f2fs_put_page(cpage, 1);
  	}
+
+	return hitted;
  }

  void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b3973494b102..3705c272b76a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2211,8 +2211,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  		blkaddr = data_blkaddr(dn.inode, dn.node_page,
  						dn.ofs_in_node + i + 1);

-		f2fs_load_compressed_page(sbi, page, blkaddr);
-		if (PageUptodate(page)) {
+		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
  			if (atomic_dec_and_test(&dic->remaining_pages))
  				f2fs_decompress_cluster(dic);
  			continue;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9f79a6825f06..b807970d67b1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3951,7 +3951,7 @@ struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
  void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
  void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
  						nid_t ino, block_t blkaddr);
-void f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
+bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
  								block_t blkaddr);
  void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
  #else
@@ -3990,8 +3990,8 @@ static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi,
  				block_t blkaddr) { }
  static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
  				struct page *page, nid_t ino, block_t blkaddr) { }
-static inline void f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
-				struct page *page, block_t blkaddr) { }
+static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
+				struct page *page, block_t blkaddr) { return false; }
  static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
  							nid_t ino) { }
  #endif
-- 
2.29.2

