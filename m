Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD60F26BEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIPIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:12:45 -0400
Received: from smtp.h3c.com ([60.191.123.56]:57746 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPIMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:12:43 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 08G6TSk4066452
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 14:29:28 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08G6SMmp064082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 14:28:22 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Sep 2020 14:28:24 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] ipmi: add retry in try_get_dev_id()
Date:   Wed, 16 Sep 2020 14:21:29 +0800
Message-ID: <20200916062129.26129-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08G6SMmp064082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use retry machanism to give device more opportunitys to correctly response
kernel when we received specific completion codes.

This is similar to what we done in __get_device_id().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/char/ipmi/ipmi_msghandler.c |  2 --
 drivers/char/ipmi/ipmi_si_intf.c    | 17 +++++++++++++++++
 include/uapi/linux/ipmi.h           |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index b9685093e..75cb7e062 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -62,8 +62,6 @@ enum ipmi_panic_event_op {
 #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_NONE
 #endif
 
-#define GET_DEVICE_ID_MAX_RETRY	5
-
 static enum ipmi_panic_event_op ipmi_send_panic_event = IPMI_PANIC_DEFAULT;
 
 static int panic_op_write_handler(const char *val,
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 77b8d551a..beeb705f1 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1316,6 +1316,7 @@ static int try_get_dev_id(struct smi_info *smi_info)
 	unsigned char         *resp;
 	unsigned long         resp_len;
 	int                   rv = 0;
+	unsigned int          retry_count = 0;
 
 	resp = kmalloc(IPMI_MAX_MSG_LENGTH, GFP_KERNEL);
 	if (!resp)
@@ -1327,6 +1328,8 @@ static int try_get_dev_id(struct smi_info *smi_info)
 	 */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_DEVICE_ID_CMD;
+
+retry:
 	smi_info->handlers->start_transaction(smi_info->si_sm, msg, 2);
 
 	rv = wait_for_msg_done(smi_info);
@@ -1339,6 +1342,20 @@ static int try_get_dev_id(struct smi_info *smi_info)
 	/* Check and record info from the get device id, in case we need it. */
 	rv = ipmi_demangle_device_id(resp[0] >> 2, resp[1],
 			resp + 2, resp_len - 2, &smi_info->device_id);
+	if (rv) {
+		/* record completion code */
+		char cc = *(resp + 2);
+
+		if ((cc == IPMI_DEVICE_IN_FW_UPDATE_ERR
+		    || cc == IPMI_DEVICE_IN_INIT_ERR
+		    || cc == IPMI_NOT_IN_MY_STATE_ERR)
+		    && ++retry_count <= GET_DEVICE_ID_MAX_RETRY) {
+			dev_warn(smi_info->io.dev,
+				"retry to get device id as completion code 0x%x\n",
+				 cc);
+			goto retry;
+		}
+	}
 
 out:
 	kfree(resp);
diff --git a/include/uapi/linux/ipmi.h b/include/uapi/linux/ipmi.h
index 32d148309..bc57f07e3 100644
--- a/include/uapi/linux/ipmi.h
+++ b/include/uapi/linux/ipmi.h
@@ -426,4 +426,6 @@ struct ipmi_timing_parms {
 #define IPMICTL_GET_MAINTENANCE_MODE_CMD	_IOR(IPMI_IOC_MAGIC, 30, int)
 #define IPMICTL_SET_MAINTENANCE_MODE_CMD	_IOW(IPMI_IOC_MAGIC, 31, int)
 
+#define GET_DEVICE_ID_MAX_RETRY		5
+
 #endif /* _UAPI__LINUX_IPMI_H */
-- 
2.17.1

