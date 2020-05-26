Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32ED1CD16B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 07:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEKFvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 01:51:07 -0400
Received: from m15-113.126.com ([220.181.15.113]:57757 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgEKFvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 01:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VVIDTnJayPp7ynQcTv
        yLSNpQVf+58l1JIpEMGTe0U6A=; b=pBVmzxw5PZjs8M63LInyMBbBgsuBfkDNbt
        /E2zdKrRxR+po7J2SPUPFurINsuve6rXrmVGlVdmRc0Xg0cWpQbYxfrCQz0s+DE2
        2JufKe26XvooJ27jQ2rPfgVv5JYA7gX4VXxcFrJ1L3VU7DqZx3Q6FSc29UpNR/T7
        RP5ImzdvY=
Received: from coding1221.verisilicon.com (unknown [222.65.245.108])
        by smtp3 (Coremail) with SMTP id DcmowAAHTgW_57heZMonFA--.29754S2;
        Mon, 11 May 2020 13:50:56 +0800 (CST)
From:   joe_zhuchg@126.com
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Joe Zhu <Chunguang.Zhu@verisilicon.com>
Subject: [PATCH] mailbox: no error log in mbox_client_txdone() for tx done by irq
Date:   Mon, 11 May 2020 13:50:52 +0800
Message-Id: <20200511055052.23868-1-joe_zhuchg@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcmowAAHTgW_57heZMonFA--.29754S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw48GFW7Xr1DtrWftr4Dtwb_yoWftrb_Cr
        n5uFy7ur1UCFyFywnrAw4fJ34ayr45Xa1q9asrtF9xt34jvFyjqr1Dtrs3Aw18CF4Dur12
        y390vws7twn3AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUePCztUUUUU==
X-Originating-IP: [222.65.245.108]
X-CM-SenderInfo: pmrhs6xkxfxwa6rslhhfrp/1tbiVwghN1pEALSDZwAAsH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Zhu <Chunguang.Zhu@verisilicon.com>

client does not know and not care about how controller implement tx done.
mbox_client_txdone() may be called when controller uses irq method.

Signed-off-by: Joe Zhu <Chunguang.Zhu@verisilicon.com>
---
 drivers/mailbox/mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0b821a5b2db8..116124adf188 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -189,7 +189,9 @@ EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 void mbox_client_txdone(struct mbox_chan *chan, int r)
 {
 	if (unlikely(!(chan->txdone_method & TXDONE_BY_ACK))) {
-		dev_err(chan->mbox->dev, "Client can't run the TX ticker\n");
+		if (unlikely(!(chan->txdone_method & TXDONE_BY_IRQ)))
+			dev_err(chan->mbox->dev,
+			       "Client can't run the TX ticker\n");
 		return;
 	}
 
-- 
2.17.1

