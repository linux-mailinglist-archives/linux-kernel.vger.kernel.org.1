Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0B19EF7B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 05:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDFDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 23:14:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgDFDOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:14:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D6D53A88BACA08F62BBF;
        Mon,  6 Apr 2020 10:56:09 +0800 (CST)
Received: from huawei.com (10.175.112.70) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Apr 2020
 10:56:00 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <gregkh@linuxfoundation.org>, <sylphrenadin@gmail.com>,
        <c.cantanheide@gmail.com>, <navid.emamdoost@gmail.com>,
        <nishkadg.linux@gmail.com>, <mst@redhat.com>, <stephen@brennan.io>,
        <mchehab@kernel.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] staging: rtl8192u: Remove some set but not used variables
Date:   Tue, 7 Apr 2020 08:07:44 -0400
Message-ID: <1586261264-37576-1-git-send-email-wanghai38@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8192u/r8192U_core.c: In function rtl8192_hard_data_xmit:
drivers/staging/rtl8192u/r8192U_core.c:905:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
drivers/staging/rtl8192u/r8192U_core.c: In function rtl8192_commit:
drivers/staging/rtl8192u/r8192U_core.c:3418:6: warning: variable ‘reset_status’ set but not used [-Wunused-but-set-variable]

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index fcfb902..bb28670 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 				   int rate)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-	int ret;
 	unsigned long flags;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
@@ -915,7 +914,7 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 	*(struct net_device **)(skb->cb) = dev;
 	tcb_desc->bTxEnableFwCalcDur = 1;
 	skb_push(skb, priv->ieee80211->tx_headroom);
-	ret = rtl8192_tx(dev, skb);
+	rtl8192_tx(dev, skb);
 
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 }
@@ -3415,7 +3414,6 @@ int rtl8192_down(struct net_device *dev)
 void rtl8192_commit(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	int reset_status = 0;
 
 	if (priv->up == 0)
 		return;
@@ -3427,7 +3425,7 @@ void rtl8192_commit(struct net_device *dev)
 	ieee80211_softmac_stop_protocol(priv->ieee80211);
 
 	rtl8192_rtx_disable(dev);
-	reset_status = _rtl8192_up(dev);
+	_rtl8192_up(dev);
 }
 
 static void rtl8192_restart(struct work_struct *work)
-- 
1.8.3.1

