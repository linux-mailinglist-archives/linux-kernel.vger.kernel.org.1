Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B351A0144
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFWr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 18:47:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32970 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:47:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4017D20159F;
        Tue,  7 Apr 2020 00:47:55 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3356F200EDA;
        Tue,  7 Apr 2020 00:47:55 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 99470205A5;
        Tue,  7 Apr 2020 00:47:54 +0200 (CEST)
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
Subject: [PATCH v2 4/4] crypto: caam - fix use-after-free KASAN issue for RSA algorithms
Date:   Tue,  7 Apr 2020 01:47:28 +0300
Message-Id: <1586213248-4230-5-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
References: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the KASAN report:
BUG: KASAN: use-after-free in rsa_pub_done+0x70/0xe8
Read of size 1 at addr ffff000023082014 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc1-00162-gfcb90d5 #60
Hardware name: LS1046A RDB Board (DT)
Call trace:
 dump_backtrace+0x0/0x260
 show_stack+0x14/0x20
 dump_stack+0xe8/0x144
 print_address_description.isra.11+0x64/0x348
 __kasan_report+0x11c/0x230
 kasan_report+0xc/0x18
 __asan_load1+0x5c/0x68
 rsa_pub_done+0x70/0xe8
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
 rsa_edesc_alloc+0x2cc/0xe10
 caam_rsa_enc+0x9c/0x5f0
 test_akcipher_one+0x78c/0x968
 alg_test_akcipher+0x78/0xf8
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
 rsa_pub_done+0x68/0xe8
 caam_jr_dequeue+0x390/0x608
 tasklet_action_common.isra.13+0x1ec/0x230
 tasklet_action+0x24/0x30
 efi_header_end+0x1a4/0x370

The buggy address belongs to the object at ffff000023082000
 which belongs to the cache dma-kmalloc-256 of size 256
The buggy address is located 20 bytes inside of
 256-byte region [ffff000023082000, ffff000023082100)
The buggy address belongs to the page:
page:fffffe00006c2080 refcount:1 mapcount:0 mapping:ffff00093200c200 index:0x0 compound_mapcount: 0
flags: 0xffff00000010200(slab|head)
raw: 0ffff00000010200 dead000000000100 dead000000000122 ffff00093200c200
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000023081f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff000023081f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff000023082000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff000023082080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff000023082100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Fixes: bf53795025a2 ("crypto: caam - add crypto_engine support for RSA algorithms")
Cc: <stable@vger.kernel.org> # v5.6
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 4fcae37..2e44d68 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -121,11 +121,13 @@ static void rsa_pub_done(struct device *dev, u32 *desc, u32 err, void *context)
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	struct rsa_edesc *edesc;
 	int ecode = 0;
+	bool has_bklog;
 
 	if (err)
 		ecode = caam_jr_strstatus(dev, err);
 
 	edesc = req_ctx->edesc;
+	has_bklog = edesc->bklog;
 
 	rsa_pub_unmap(dev, edesc, req);
 	rsa_io_unmap(dev, edesc, req);
@@ -135,7 +137,7 @@ static void rsa_pub_done(struct device *dev, u32 *desc, u32 err, void *context)
 	 * If no backlog flag, the completion of the request is done
 	 * by CAAM, not crypto engine.
 	 */
-	if (!edesc->bklog)
+	if (!has_bklog)
 		akcipher_request_complete(req, ecode);
 	else
 		crypto_finalize_akcipher_request(jrp->engine, req, ecode);
@@ -152,11 +154,13 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct rsa_edesc *edesc;
 	int ecode = 0;
+	bool has_bklog;
 
 	if (err)
 		ecode = caam_jr_strstatus(dev, err);
 
 	edesc = req_ctx->edesc;
+	has_bklog = edesc->bklog;
 
 	switch (key->priv_form) {
 	case FORM1:
@@ -176,7 +180,7 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 	 * If no backlog flag, the completion of the request is done
 	 * by CAAM, not crypto engine.
 	 */
-	if (!edesc->bklog)
+	if (!has_bklog)
 		akcipher_request_complete(req, ecode);
 	else
 		crypto_finalize_akcipher_request(jrp->engine, req, ecode);
-- 
2.1.0

