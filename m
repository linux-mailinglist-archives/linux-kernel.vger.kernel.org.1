Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B372AA633
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKGPWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKGPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 10:22:12 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF9FC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 07:22:12 -0800 (PST)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5::979])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CA9895C1FF5;
        Sat,  7 Nov 2020 16:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1604762527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=90S2HQuQxNPuGlnJbbsFbCfJWrpfhbx3HtSCJ9DUcsk=;
        b=J8u/fVKnCRmBm6g2eyDZ4IoD9jRbuQ1cSOo/4+y4oF6CdQMDQYyIyz66O/E9TBZ201dbrI
        hx/qlEbsd0km1/uwjn8EcDEpfbav4vOIjRO8ela1kwgC3KEPMtyPhQ4bYFViPbv9uxJHjR
        EJ5/yYwgpVm2E4dWlT3/zMihAeSgfvk=
From:   Stefan Agner <stefan@agner.ch>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     akpm@linux-foundation.org, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, stefan@agner.ch,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Date:   Sat,  7 Nov 2020 16:22:06 +0100
Message-Id: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
the MAX_PHYSMEM_BITS define on all architectures.

This fixes a crash when accessing zram on 32-bit ARM platform with LPAE and
more than 4GB of memory:
  Unable to handle kernel NULL pointer dereference at virtual address 00000000
  pgd = a27bd01c
  [00000000] *pgd=236a0003, *pmd=1ffa64003
  Internal error: Oops: 207 [#1] SMP ARM
  Modules linked in: mdio_bcm_unimac(+) brcmfmac cfg80211 brcmutil raspberrypi_hwmon hci_uart crc32_arm_ce bcm2711_thermal phy_generic genet
  CPU: 0 PID: 123 Comm: mkfs.ext4 Not tainted 5.9.6 #1
  Hardware name: BCM2711
  PC is at zs_map_object+0x94/0x338
  LR is at zram_bvec_rw.constprop.0+0x330/0xa64
  pc : [<c0602b38>]    lr : [<c0bda6a0>]    psr: 60000013
  sp : e376bbe0  ip : 00000000  fp : c1e2921c
  r10: 00000002  r9 : c1dda730  r8 : 00000000
  r7 : e8ff7a00  r6 : 00000000  r5 : 02f9ffa0  r4 : e3710000
  r3 : 000fdffe  r2 : c1e0ce80  r1 : ebf979a0  r0 : 00000000
  Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
  Control: 30c5383d  Table: 235c2a80  DAC: fffffffd
  Process mkfs.ext4 (pid: 123, stack limit = 0x495a22e6)
  Stack: (0xe376bbe0 to 0xe376c000)
  ...
  [<c0602b38>] (zs_map_object) from [<c0bda6a0>] (zram_bvec_rw.constprop.0+0x330/0xa64)
  [<c0bda6a0>] (zram_bvec_rw.constprop.0) from [<c0bdaf78>] (zram_submit_bio+0x1a4/0x40c)
  [<c0bdaf78>] (zram_submit_bio) from [<c085806c>] (submit_bio_noacct+0xd0/0x3c8)
  [<c085806c>] (submit_bio_noacct) from [<c08583b0>] (submit_bio+0x4c/0x190)
  [<c08583b0>] (submit_bio) from [<c06496b4>] (submit_bh_wbc+0x188/0x1b8)
  [<c06496b4>] (submit_bh_wbc) from [<c064ce98>] (__block_write_full_page+0x340/0x5e4)
  [<c064ce98>] (__block_write_full_page) from [<c064d3ec>] (block_write_full_page+0x128/0x170)
  [<c064d3ec>] (block_write_full_page) from [<c0591ae8>] (__writepage+0x14/0x68)
  [<c0591ae8>] (__writepage) from [<c0593efc>] (write_cache_pages+0x1bc/0x494)
  [<c0593efc>] (write_cache_pages) from [<c059422c>] (generic_writepages+0x58/0x8c)
  [<c059422c>] (generic_writepages) from [<c0594c24>] (do_writepages+0x48/0xec)
  [<c0594c24>] (do_writepages) from [<c0589330>] (__filemap_fdatawrite_range+0xf0/0x128)
  [<c0589330>] (__filemap_fdatawrite_range) from [<c05894bc>] (file_write_and_wait_range+0x48/0x98)
  [<c05894bc>] (file_write_and_wait_range) from [<c064f3f8>] (blkdev_fsync+0x1c/0x44)
  [<c064f3f8>] (blkdev_fsync) from [<c064408c>] (do_fsync+0x3c/0x70)
  [<c064408c>] (do_fsync) from [<c0400374>] (__sys_trace_return+0x0/0x2c)
  Exception stack(0xe376bfa8 to 0xe376bff0)
  bfa0:                   0003d2e0 b6f7b6f0 00000003 00046e40 00001000 00000000
  bfc0: 0003d2e0 b6f7b6f0 00000000 00000076 00000000 00000000 befcbb20 befcbb28
  bfe0: b6f4e060 befcbad8 b6f23e0c b6dc4a80
  Code: e5927000 e0050391 e0871005 e5918018 (e5983000)

Fixes: 61989a80fb3a ("staging: zsmalloc: zsmalloc memory allocation library")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c36fdff9a371..260bd48aacd0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -40,6 +40,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/pgtable.h>
+#include <asm/sparsemem.h>
 #include <asm/tlbflush.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
-- 
2.29.1

