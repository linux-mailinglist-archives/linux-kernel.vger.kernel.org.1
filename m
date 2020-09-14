Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C850268718
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgINIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:21:23 -0400
Received: from smtp.h3c.com ([60.191.123.50]:43520 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgINIVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:21:21 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 08E8K6Lq075693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 16:20:06 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 16:20:08 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v2] ipmi: retry to get device id when error
Date:   Mon, 14 Sep 2020 16:13:13 +0800
Message-ID: <20200914081313.31450-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08E8K6Lq075693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't get bmc's device id with low probability when loading ipmi driver,
it caused bmc device register failed. When this issue happened, we got
below kernel printks:
	[Wed Sep  9 19:52:03 2020] ipmi_si IPI0001:00: IPMI message handler: device id demangle failed: -22
	[Wed Sep  9 19:52:03 2020] IPMI BT: using default values
	[Wed Sep  9 19:52:03 2020] IPMI BT: req2rsp=5 secs retries=2
	[Wed Sep  9 19:52:03 2020] ipmi_si IPI0001:00: Unable to get the device id: -5
	[Wed Sep  9 19:52:04 2020] ipmi_si IPI0001:00: Unable to register device: error -5

When this issue happened, we want to manually unload the driver and try to
load it again, but it can't be unloaded by 'rmmod' as it is already 'in use'.

We add below 'printk' in handle_one_recv_msg(), when this issue happened,
the msg we received is "Recv: 1c 01 d5", which means the data_len is 1,
data[0] is 0xd5(completion code), which means "bmc cannot execute command.
Command, or request parameter(s), not supported in present state".
	Debug code:
	static int handle_one_recv_msg(struct ipmi_smi *intf,
                               struct ipmi_smi_msg *msg) {
        	printk("Recv: %*ph\n", msg->rsp_size, msg->rsp);
		... ...
	}
Then in ipmi_demangle_device_id(), it returned '-EINVAL' as 'data_len < 7'
and 'data[0] != 0'.

We used this patch to retry to get device id when error happen, we
reproduced this issue again and the retry succeed on the first retry, we
finally got the correct msg and then all is ok:
Recv: 1c 01 00 01 81 05 84 02 af db 07 00 01 00 b9 00 10 00

So use retry machanism in this patch to give bmc more opportunity to
correctly response kernel when we received specific completion code.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 29 +++++++++++++++++++++++++----
 include/uapi/linux/ipmi_msgdefs.h   |  2 ++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 737c0b6b2..07d5be2cd 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -34,6 +34,7 @@
 #include <linux/uuid.h>
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
+#include <linux/delay.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
 
@@ -60,6 +61,9 @@ enum ipmi_panic_event_op {
 #else
 #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_NONE
 #endif
+
+#define GET_DEVICE_ID_MAX_RETRY	5
+
 static enum ipmi_panic_event_op ipmi_send_panic_event = IPMI_PANIC_DEFAULT;
 
 static int panic_op_write_handler(const char *val,
@@ -317,6 +321,7 @@ struct bmc_device {
 	int                    dyn_guid_set;
 	struct kref	       usecount;
 	struct work_struct     remove_work;
+	char		       cc; /* completion code */
 };
 #define to_bmc_device(x) container_of((x), struct bmc_device, pdev.dev)
 
@@ -2381,6 +2386,8 @@ static void bmc_device_id_handler(struct ipmi_smi *intf,
 			msg->msg.data, msg->msg.data_len, &intf->bmc->fetch_id);
 	if (rv) {
 		dev_warn(intf->si_dev, "device id demangle failed: %d\n", rv);
+		/* record completion code when error */
+		intf->bmc->cc = msg->msg.data[0];
 		intf->bmc->dyn_id_set = 0;
 	} else {
 		/*
@@ -2426,19 +2433,34 @@ send_get_device_id_cmd(struct ipmi_smi *intf)
 static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
 {
 	int rv;
-
-	bmc->dyn_id_set = 2;
+	unsigned int retry_count = 0;
 
 	intf->null_user_handler = bmc_device_id_handler;
 
+retry:
+	bmc->dyn_id_set = 2;
+
 	rv = send_get_device_id_cmd(intf);
 	if (rv)
 		return rv;
 
 	wait_event(intf->waitq, bmc->dyn_id_set != 2);
 
-	if (!bmc->dyn_id_set)
+	if (!bmc->dyn_id_set) {
+		if ((bmc->cc == IPMI_NOT_IN_MY_STATE_ERR
+		     || bmc->cc == IPMI_NOT_IN_MY_STATE_ERR_1
+		     || bmc->cc == IPMI_NOT_IN_MY_STATE_ERR_2)
+		     && ++retry_count <= GET_DEVICE_ID_MAX_RETRY) {
+			msleep(500);
+			dev_warn(intf->si_dev,
+				"retry to get bmc device id as completion code 0x%x\n",
+				bmc->cc);
+			bmc->cc = 0;
+			goto retry;
+		}
+
 		rv = -EIO; /* Something went wrong in the fetch. */
+	}
 
 	/* dyn_id_set makes the id data available. */
 	smp_rmb();
@@ -3245,7 +3267,6 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 		/* It's the one we want */
 		if (msg->msg.data[0] != 0) {
 			/* Got an error from the channel, just go on. */
-
 			if (msg->msg.data[0] == IPMI_INVALID_COMMAND_ERR) {
 				/*
 				 * If the MC does not support this
diff --git a/include/uapi/linux/ipmi_msgdefs.h b/include/uapi/linux/ipmi_msgdefs.h
index c2b23a9fd..46a0df434 100644
--- a/include/uapi/linux/ipmi_msgdefs.h
+++ b/include/uapi/linux/ipmi_msgdefs.h
@@ -70,6 +70,8 @@
 #define IPMI_REQ_LEN_INVALID_ERR	0xc7
 #define IPMI_REQ_LEN_EXCEEDED_ERR	0xc8
 #define IPMI_NOT_IN_MY_STATE_ERR	0xd5	/* IPMI 2.0 */
+#define IPMI_NOT_IN_MY_STATE_ERR_1	0xd1
+#define IPMI_NOT_IN_MY_STATE_ERR_2	0xd2
 #define IPMI_LOST_ARBITRATION_ERR	0x81
 #define IPMI_BUS_ERR			0x82
 #define IPMI_NAK_ON_WRITE_ERR		0x83
-- 
2.17.1

