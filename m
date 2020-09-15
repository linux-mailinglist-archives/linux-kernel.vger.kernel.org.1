Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB026A031
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIOHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:52:50 -0400
Received: from smtp.h3c.com ([60.191.123.50]:65082 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgIOHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:52:42 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 08F7pZd1007266
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 15:51:35 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Sep 2020 15:51:38 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] ipmi: print current state when error
Date:   Tue, 15 Sep 2020 15:44:41 +0800
Message-ID: <20200915074441.4090-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08F7pZd1007266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print current state before returning IPMI_NOT_IN_MY_STATE_ERR,
we can know where this issue is coming from and possibly fix
the state machine.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/char/ipmi/ipmi_bt_sm.c   | 4 +++-
 drivers/char/ipmi/ipmi_kcs_sm.c  | 4 +++-
 drivers/char/ipmi/ipmi_smic_sm.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index f3f216cdf..2de0c6c30 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -213,8 +213,10 @@ static int bt_start_transaction(struct si_sm_data *bt,
 	if (bt->state == BT_STATE_LONG_BUSY)
 		return IPMI_NODE_BUSY_ERR;
 
-	if (bt->state != BT_STATE_IDLE)
+	if (bt->state != BT_STATE_IDLE) {
+		dev_warn(bt->io->dev, "BT is now in the state %d\n", bt->state);
 		return IPMI_NOT_IN_MY_STATE_ERR;
+	}
 
 	if (bt_debug & BT_DEBUG_MSG) {
 		dev_dbg(bt->io->dev, "+++++++++++++++++ New command\n");
diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
index 2e7cda08b..49ece4ba3 100644
--- a/drivers/char/ipmi/ipmi_kcs_sm.c
+++ b/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -268,8 +268,10 @@ static int start_kcs_transaction(struct si_sm_data *kcs, unsigned char *data,
 	if (size > MAX_KCS_WRITE_SIZE)
 		return IPMI_REQ_LEN_EXCEEDED_ERR;
 
-	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED))
+	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
+		printk(KERN_WARNING, "KCS is now in the state %d\n", kcs->state);
 		return IPMI_NOT_IN_MY_STATE_ERR;
+	}
 
 	if (kcs_debug & KCS_DEBUG_MSG) {
 		printk(KERN_DEBUG "start_kcs_transaction -");
diff --git a/drivers/char/ipmi/ipmi_smic_sm.c b/drivers/char/ipmi/ipmi_smic_sm.c
index b6225bba2..690d4f53e 100644
--- a/drivers/char/ipmi/ipmi_smic_sm.c
+++ b/drivers/char/ipmi/ipmi_smic_sm.c
@@ -126,8 +126,10 @@ static int start_smic_transaction(struct si_sm_data *smic,
 	if (size > MAX_SMIC_WRITE_SIZE)
 		return IPMI_REQ_LEN_EXCEEDED_ERR;
 
-	if ((smic->state != SMIC_IDLE) && (smic->state != SMIC_HOSED))
+	if ((smic->state != SMIC_IDLE) && (smic->state != SMIC_HOSED)) {
+		printk(KERN_WARNING, "SMIC is now in the state %d\n", smic->state);
 		return IPMI_NOT_IN_MY_STATE_ERR;
+	}
 
 	if (smic_debug & SMIC_DEBUG_MSG) {
 		printk(KERN_DEBUG "start_smic_transaction -");
-- 
2.17.1

