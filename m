Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9206B2CCACA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgLCAAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgLCAAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:00:01 -0500
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] soc: mediatek: cmdq: Remove cmdq_pkt_flush()
Date:   Thu,  3 Dec 2020 07:58:55 +0800
Message-Id: <20201202235856.7652-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx_callback is a standard mailbox callback mechanism and could
cover the function of proprietary cmdq_task_cb, so it is better
to use the standard one instead of the proprietary one. But
register rx_callback should before mbox_request_channel(),
so remove cmdq_pkt_flush() and let client driver implement
its own synchronous flush.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 32 --------------------------
 include/linux/soc/mediatek/mtk-cmdq.h  | 12 ----------
 2 files changed, 44 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 505651b0d715..fd3bc39538a1 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -502,36 +502,4 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 }
 EXPORT_SYMBOL(cmdq_pkt_flush_async);
 
-struct cmdq_flush_completion {
-	struct completion cmplt;
-	bool err;
-};
-
-static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
-{
-	struct cmdq_flush_completion *cmplt;
-
-	cmplt = (struct cmdq_flush_completion *)data.data;
-	if (data.sta != CMDQ_CB_NORMAL)
-		cmplt->err = true;
-	else
-		cmplt->err = false;
-	complete(&cmplt->cmplt);
-}
-
-int cmdq_pkt_flush(struct cmdq_pkt *pkt)
-{
-	struct cmdq_flush_completion cmplt;
-	int err;
-
-	init_completion(&cmplt.cmplt);
-	err = cmdq_pkt_flush_async(pkt, cmdq_pkt_flush_cb, &cmplt);
-	if (err < 0)
-		return err;
-	wait_for_completion(&cmplt.cmplt);
-
-	return cmplt.err ? -EFAULT : 0;
-}
-EXPORT_SYMBOL(cmdq_pkt_flush);
-
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 960704d75994..2c6aa84c0e80 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -288,16 +288,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
 int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 			 void *data);
 
-/**
- * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
- * @pkt:	the CMDQ packet
- *
- * Return: 0 for success; else the error code is returned
- *
- * Trigger CMDQ to execute the CMDQ packet. Note that this is a
- * synchronous flush function. When the function returned, the recorded
- * commands have been done.
- */
-int cmdq_pkt_flush(struct cmdq_pkt *pkt);
-
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.17.1

