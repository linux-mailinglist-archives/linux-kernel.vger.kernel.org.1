Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429B41A0142
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 00:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDFWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 18:47:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32876 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:47:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AA912002C9;
        Tue,  7 Apr 2020 00:47:49 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D8BC200220;
        Tue,  7 Apr 2020 00:47:49 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 90272204B1;
        Tue,  7 Apr 2020 00:47:48 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v2 3/4] crypto: caam - fix use-after-free KASAN issue for HASH algorithms
Date:   Tue,  7 Apr 2020 01:47:27 +0300
Message-Id: <1586213248-4230-4-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
References: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the KASAN report:
BUG: KASAN: use-after-free in ahash_done+0xdc/0x3b8
Read of size 1 at addr ffff00002303f010 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc1-00162-gfcb90d5 #59
Hardware name: LS1046A RDB Board (DT)
Call trace:
 dump_backtrace+0x0/0x260
 show_stack+0x14/0x20
 dump_stack+0xe8/0x144
 print_address_description.isra.11+0x64/0x348
 __kasan_report+0x11c/0x230
 kasan_report+0xc/0x18
 __asan_load1+0x5c/0x68
 ahash_done+0xdc/0x3b8
 caam_jr_dequeue+0x390/0x608
 tasklet_action_common.isra.13+0x1ec/0x230
 tasklet_action+0x24/0x30
 efi_header_end+0x1a4/0x370
 irq_exit+0x114/0x128
 __handle_domain_irq+0x80/0xe0
 gic_handle_irq+0x50/0xa0
 el1_irq+0xb8/0x180
 cpuidle_enter_state+0xa4/0x490
 cpuidle_enter+0x48/0x70
 call_cpuidle+0x44/0x70
 do_idle+0x304/0x338
 cpu_startup_entry+0x24/0x40
 rest_init+0xf8/0x10c
 arch_call_rest_init+0xc/0x14
 start_kernel+0x774/0x7b4

Allocated by task 263:
 save_stack+0x24/0xb0
 __kasan_kmalloc.isra.10+0xc4/0xe0
 kasan_kmalloc+0xc/0x18
 __kmalloc+0x178/0x2b8
 ahash_edesc_alloc+0x58/0x1f8
 ahash_final_no_ctx+0x94/0x6e8
 ahash_final+0x24/0x30
 crypto_ahash_op+0x58/0xb0
 crypto_ahash_final+0x30/0x40
 do_ahash_op+0x2c/0xa0
 test_ahash_vec_cfg+0x894/0x9e0
 test_hash_vec_cfg+0x6c/0x88
 test_hash_vec+0xfc/0x1e0
 __alg_test_hash+0x1ac/0x368
 alg_test_hash+0xf8/0x1c8
 alg_test.part.44+0x114/0x4a0
 alg_test+0x1c/0x60
 cryptomgr_test+0x34/0x58
 kthread+0x1b8/0x1c0
 ret_from_fork+0x10/0x18

Freed by task 0:
 save_stack+0x24/0xb0
 __kasan_slab_free+0x10c/0x188
 kasan_slab_free+0x10/0x18
 kfree+0x7c/0x298
 ahash_done+0xd4/0x3b8
 caam_jr_dequeue+0x390/0x608
 tasklet_action_common.isra.13+0x1ec/0x230
 tasklet_action+0x24/0x30
 efi_header_end+0x1a4/0x370

The buggy address belongs to the object at ffff00002303f000
 which belongs to the cache dma-kmalloc-128 of size 128
The buggy address is located 16 bytes inside of
 128-byte region [ffff00002303f000, ffff00002303f080)
The buggy address belongs to the page:
page:fffffe00006c0fc0 refcount:1 mapcount:0 mapping:ffff00093200c000 index:0x0
flags: 0xffff00000000200(slab)
raw: 0ffff00000000200 dead000000000100 dead000000000122 ffff00093200c000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00002303ef00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff00002303ef80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff00002303f000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff00002303f080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff00002303f100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Fixes: 21b014f038d3 ("crypto: caam - add crypto_engine support for HASH algorithms")
Cc: <stable@vger.kernel.org> # v5.6
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamhash.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 943bc02..27ff4a3 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -583,10 +583,12 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	int ecode = 0;
+	bool has_bklog;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = state->edesc;
+	has_bklog = edesc->bklog;
 
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
@@ -603,7 +605,7 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 	 * If no backlog flag, the completion of the request is done
 	 * by CAAM, not crypto engine.
 	 */
-	if (!edesc->bklog)
+	if (!has_bklog)
 		req->base.complete(&req->base, ecode);
 	else
 		crypto_finalize_hash_request(jrp->engine, req, ecode);
@@ -632,10 +634,12 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	int ecode = 0;
+	bool has_bklog;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = state->edesc;
+	has_bklog = edesc->bklog;
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
 
@@ -663,7 +667,7 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 	 * If no backlog flag, the completion of the request is done
 	 * by CAAM, not crypto engine.
 	 */
-	if (!edesc->bklog)
+	if (!has_bklog)
 		req->base.complete(&req->base, ecode);
 	else
 		crypto_finalize_hash_request(jrp->engine, req, ecode);
-- 
2.1.0

