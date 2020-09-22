Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061EB27488D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIVSsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600800529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gQfhwcWAnYHtZ/yHf3Dz6iSnU3yX/5/+Y6j7Aqm8d/c=;
        b=MiLywZUyyVu5fi+lOfMLMDNFMSKMH7ZwLBH8Vg7tvh/NgCANsdTcAKxi2AQjhGqSNWRg0u
        e1Wjpg1bUZU37RSn8m7FoNzqvZCpwfOHaptwgpW5XXrp2AdSzWAJ3L4+9sL9aLnymd2gLd
        UODjeRum7ZSebPc/xjAUKBDYIhT29pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-slISxlm0PIuTou6g-oCiOg-1; Tue, 22 Sep 2020 14:48:47 -0400
X-MC-Unique: slISxlm0PIuTou6g-oCiOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840E61868423;
        Tue, 22 Sep 2020 18:48:45 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 513197367E;
        Tue, 22 Sep 2020 18:48:44 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        ying.huang@intel.com
Subject: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
Date:   Tue, 22 Sep 2020 14:48:38 -0400
Message-Id: <20200922184838.978540-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The swap area descriptor only gets struct swap_cluster_info *cluster_info
allocated if the swapfile is backed by non-rotational storage.
When the swap area is laid on top of ordinary disk spindles, lock_cluster()
will naturally return NULL.

CONFIG_THP_SWAP exposes cluster_info infrastructure to a broader number of
use cases, and split_swap_cluster(), which is the counterpart of split_huge_page()
for the THPs in the swapcache, misses checking the return of lock_cluster before
operating on the cluster_info pointer.

This patch addresses that issue by adding a proper check for the pointer
not being NULL in the wrappers cluster_{is,clear}_huge(), in order to avoid
crashes similar to the one below:

[ 5758.157556] BUG: kernel NULL pointer dereference, address: 0000000000000007
[ 5758.165331] #PF: supervisor write access in kernel mode
[ 5758.171161] #PF: error_code(0x0002) - not-present page
[ 5758.176894] PGD 0 P4D 0
[ 5758.179721] Oops: 0002 [#1] SMP PTI
[ 5758.183614] CPU: 10 PID: 316 Comm: kswapd1 Kdump: loaded Tainted: G S               --------- ---  5.9.0-0.rc3.1.tst.el8.x86_64 #1
[ 5758.196717] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.01.0002.082220131453 08/22/2013
[ 5758.208176] RIP: 0010:split_swap_cluster+0x47/0x60
[ 5758.213522] Code: c1 e3 06 48 c1 eb 0f 48 8d 1c d8 48 89 df e8 d0 20 6a 00 80 63 07 fb 48 85 db 74 16 48 89 df c6 07 00 66 66 66 90 31 c0 5b c3 <80> 24 25 07 00 00 00 fb 31 c0 5b c3 b8 f0 ff ff ff 5b c3 66 0f 1f
[ 5758.234478] RSP: 0018:ffffb147442d7af0 EFLAGS: 00010246
[ 5758.240309] RAX: 0000000000000000 RBX: 000000000014b217 RCX: ffffb14779fd9000
[ 5758.248281] RDX: 000000000014b217 RSI: ffff9c52f2ab1400 RDI: 000000000014b217
[ 5758.256246] RBP: ffffe00c51168080 R08: ffffe00c5116fe08 R09: ffff9c52fffd3000
[ 5758.264208] R10: ffffe00c511537c8 R11: ffff9c52fffd3c90 R12: 0000000000000000
[ 5758.272172] R13: ffffe00c51170000 R14: ffffe00c51170000 R15: ffffe00c51168040
[ 5758.280134] FS:  0000000000000000(0000) GS:ffff9c52f2a80000(0000) knlGS:0000000000000000
[ 5758.289163] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5758.295575] CR2: 0000000000000007 CR3: 0000000022a0e003 CR4: 00000000000606e0
[ 5758.303538] Call Trace:
[ 5758.306273]  split_huge_page_to_list+0x88b/0x950
[ 5758.311433]  deferred_split_scan+0x1ca/0x310
[ 5758.316202]  do_shrink_slab+0x12c/0x2a0
[ 5758.320491]  shrink_slab+0x20f/0x2c0
[ 5758.324482]  shrink_node+0x240/0x6c0
[ 5758.328469]  balance_pgdat+0x2d1/0x550
[ 5758.332652]  kswapd+0x201/0x3c0
[ 5758.336157]  ? finish_wait+0x80/0x80
[ 5758.340147]  ? balance_pgdat+0x550/0x550
[ 5758.344525]  kthread+0x114/0x130
[ 5758.348126]  ? kthread_park+0x80/0x80
[ 5758.352214]  ret_from_fork+0x22/0x30
[ 5758.356203] Modules linked in: fuse zram rfkill sunrpc intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp mgag200 iTCO_wdt crct10dif_pclmul iTCO_vendor_support drm_kms_helper crc32_pclmul ghash_clmulni_intel syscopyarea sysfillrect sysimgblt fb_sys_fops cec rapl joydev intel_cstate ipmi_si ipmi_devintf drm intel_uncore i2c_i801 ipmi_msghandler pcspkr lpc_ich mei_me i2c_smbus mei ioatdma ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg igb ahci libahci i2c_algo_bit crc32c_intel libata dca wmi dm_mirror dm_region_hash dm_log dm_mod
[ 5758.412673] CR2: 0000000000000007
[    0.000000] Linux version 5.9.0-0.rc3.1.tst.el8.x86_64 (mockbuild@x86-vm-15.build.eng.bos.redhat.com) (gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5), GNU ld version 2.30-79.el8) #1 SMP Wed Sep 9 16:03:34 EDT 2020

Fixes: 59807685a7e77 ("mm, THP, swap: support splitting THP for THP swap out")
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 mm/swapfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12f59e641b5e..37ddf5e5c53b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -324,14 +324,15 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
 
 static inline bool cluster_is_huge(struct swap_cluster_info *info)
 {
-	if (IS_ENABLED(CONFIG_THP_SWAP))
+	if (IS_ENABLED(CONFIG_THP_SWAP) && info)
 		return info->flags & CLUSTER_FLAG_HUGE;
 	return false;
 }
 
 static inline void cluster_clear_huge(struct swap_cluster_info *info)
 {
-	info->flags &= ~CLUSTER_FLAG_HUGE;
+	if (IS_ENABLED(CONFIG_THP_SWAP) && info)
+		info->flags &= ~CLUSTER_FLAG_HUGE;
 }
 
 static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
-- 
2.25.4

