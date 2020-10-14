Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD60428DE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgJNKPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 06:15:18 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:22136 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbgJNKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 06:15:03 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 06:15:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1602670501;
        s=strato-dkim-0002; d=reppi.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=uLKwufuwcqZ+8BtfB59wYxQjAx6AWfI1zl8kJJYchFg=;
        b=mvbKqA5oo5zlpwkA2q8Podmn9yrB1wbesHDV3Dw0SZy5GRNyYcaMhl9WcdOMsUmrrY
        DrIEcHzcMztFghwQsbK6YPeXRYuii9rLVWMRSuerYhulJbT4iocsWXVFjVu2P+p1OowN
        3wz0ibvt3eyJV6uRmKKlh367Zufcz/LbpEDooKUdaKYQxz56HqLLUXqhw9J6LsYBUX97
        eL4apkXUIi9QuH8z2Lvq9PvSyotCkwQcyTdHdAZsuCQeNhX88Xtp3OMKSon95ZLfIGky
        646vcZqf5OMTHUVzQ6yD9RPq3n8ikhgoPtfpE92c6lBIcx2WsnQnUkHCNdxbuwaRc7NS
        3hlQ==
X-RZG-AUTH: ":IGUKYFiIafrCz3nj8XPMVANjVvJHSViuyVt55IbRhHhgucmaTUEVv1qZaHsnwhsmwA=="
X-RZG-CLASS-ID: mo00
Received: from Linux.Reppenhagen
        by smtp.strato.de (RZmta 47.2.1 AUTH)
        with ESMTPSA id c0aee0w9EA2tXt4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 14 Oct 2020 12:02:55 +0200 (CEST)
From:   Reppenhagen <linux@reppi.de>
To:     marco.reppenhagen@smartmicro.de
Cc:     Marco Reppenhagen <linux@reppi.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix invalid reference to index variable of the iterator
Date:   Wed, 14 Oct 2020 12:04:45 +0200
Message-Id: <20201014100445.3258-1-linux@reppi.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Reppenhagen <linux@reppi.de>

Fixing the invalid reference to index variable ot the iterator.

Signed-off-by: Marco Reppenhagen <linux@reppi.de>
---
 drivers/mailbox/mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0b821a5b2db8..9d9e135f062c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -364,7 +364,7 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 		return chan;
 	}
 
-	if (chan->cl || !try_module_get(mbox->dev->driver->owner)) {
+	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
 		dev_dbg(dev, "%s: mailbox not free\n", __func__);
 		mutex_unlock(&con_mutex);
 		return ERR_PTR(-EBUSY);
-- 
2.17.1

