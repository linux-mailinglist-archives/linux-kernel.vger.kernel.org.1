Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531F821F646
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGNPjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgGNPjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:39:19 -0400
Received: from embeddedor (unknown [201.162.240.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2393622285;
        Tue, 14 Jul 2020 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594741158;
        bh=415lbHSeClwZCtpjlS68bKbmwLWmlia7bSW5KCVq2Mc=;
        h=Date:From:To:Cc:Subject:From;
        b=L6gBkn/qS+Aaz8ESC53BwR7g+RF+HsoAypwMOJzMRDMgLjoGi76E+3PJLYCRUXi9X
         dQcjWjX/EkZ9Il7sc+7twvEjEBcCepeMiypNAubKVjJ/h1WRiJ6e4Qtf1TAJDPrQXU
         +oaE2ICT/CVvA9KcHgzeZgURrUq34B4F3qHiYNsI=
Date:   Tue, 14 Jul 2020 10:44:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] hpilo: Replace one-element array with flexible-array
 member
Message-ID: <20200714154449.GA26153@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

For this particular case, it is important to notice that the cachelines
change from 7 to 6 after the flexible-array conversion:

$ pahole -C 'fifo' drivers/misc/hpilo.o
struct fifo {
	u64                        nrents;               /*     0     8 */
	u64                        imask;                /*     8     8 */
	u64                        merge;                /*    16     8 */
	u64                        reset;                /*    24     8 */
	u8                         pad_0[96];            /*    32    96 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	u64                        head;                 /*   128     8 */
	u8                         pad_1[120];           /*   136   120 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u64                        tail;                 /*   256     8 */
	u8                         pad_2[120];           /*   264   120 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	u64                        fifobar[1];           /*   384     8 */

	/* size: 392, cachelines: 7, members: 10 */
	/* last cacheline: 8 bytes */
};

$ pahole -C 'fifo' drivers/misc/hpilo.o
struct fifo {
	u64                        nrents;               /*     0     8 */
	u64                        imask;                /*     8     8 */
	u64                        merge;                /*    16     8 */
	u64                        reset;                /*    24     8 */
	u8                         pad_0[96];            /*    32    96 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	u64                        head;                 /*   128     8 */
	u8                         pad_1[120];           /*   136   120 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u64                        tail;                 /*   256     8 */
	u8                         pad_2[120];           /*   264   120 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	u64                        fifobar[];            /*   384     0 */

	/* size: 384, cachelines: 6, members: 10 */
};

Lastly, remove unnecessary parentheses in fifo_sz() and fix the following
checkpatch.pl warning for the whole fifo structure:

WARNING: please, no spaces at the start of a line

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://github.com/KSPP/linux/issues/79

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/kernel-ci/hpilo-20200714.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/hpilo.c |  2 +-
 drivers/misc/hpilo.h | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 927309b86bab..10c975662f8b 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -207,7 +207,7 @@ static void ctrl_setup(struct ccb *ccb, int nr_desc, int l2desc_sz)
 static inline int fifo_sz(int nr_entry)
 {
 	/* size of a fifo is determined by the number of entries it contains */
-	return (nr_entry * sizeof(u64)) + FIFOHANDLESIZE;
+	return nr_entry * sizeof(u64) + FIFOHANDLESIZE;
 }
 
 static void fifo_setup(void *base_addr, int nr_entry)
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index 1aa433a7f66c..f69ff645cac9 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -160,23 +160,23 @@ struct ccb_data {
 #define ILO_START_ALIGN	4096
 #define ILO_CACHE_SZ 	 128
 struct fifo {
-    u64 nrents;	/* user requested number of fifo entries */
-    u64 imask;  /* mask to extract valid fifo index */
-    u64 merge;	/*  O/C bits to merge in during enqueue operation */
-    u64 reset;	/* set to non-zero when the target device resets */
-    u8  pad_0[ILO_CACHE_SZ - (sizeof(u64) * 4)];
+	u64 nrents;	/* user requested number of fifo entries */
+	u64 imask;  /* mask to extract valid fifo index */
+	u64 merge;	/*  O/C bits to merge in during enqueue operation */
+	u64 reset;	/* set to non-zero when the target device resets */
+	u8  pad_0[ILO_CACHE_SZ - (sizeof(u64) * 4)];
 
-    u64 head;
-    u8  pad_1[ILO_CACHE_SZ - (sizeof(u64))];
+	u64 head;
+	u8  pad_1[ILO_CACHE_SZ - (sizeof(u64))];
 
-    u64 tail;
-    u8  pad_2[ILO_CACHE_SZ - (sizeof(u64))];
+	u64 tail;
+	u8  pad_2[ILO_CACHE_SZ - (sizeof(u64))];
 
-    u64 fifobar[1];
+	u64 fifobar[];
 };
 
 /* convert between struct fifo, and the fifobar, which is saved in the ccb */
-#define FIFOHANDLESIZE (sizeof(struct fifo) - sizeof(u64))
+#define FIFOHANDLESIZE (sizeof(struct fifo))
 #define FIFOBARTOHANDLE(_fifo) \
 	((struct fifo *)(((char *)(_fifo)) - FIFOHANDLESIZE))
 
-- 
2.27.0

