Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14C82F986E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbhAREAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:00:00 -0500
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:26509
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732003AbhARD7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:59:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8W6zN9zGmaBZzD3dTaPLw+FiSXb2GnwVLnfDezjOPZbcawMTD/lPgd57T3Fcxju1w9g7G6oDro1Bn+HdSNZHZw+yVbR02voTLPte42RZnSkaISCNAhz69K2AHWdOLlvCo1anTG79fXXEWTgDvK6foIAmDqflKkO3cW6aGxjEVA+uLq575CrVaOLizrLallYGpJRs/tZEQfl0h+zzAt5rN3JRcXH4s5Xpz185+foctIVdl9RqiXBkseqjiUbGkaoCtMjGi7jwbYj9qwOO+SK3VKAF2rj2sjjD3AcHEcU7bros6IiZd7jytTKekXv/vYl38805apWcPbMvJPP6xBQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reY/aWevE3QpOvZ4PF66H8Lirm0QH5mPy7UCizZ24Mk=;
 b=KfHvZI0/EdALh2V6Kj6qPd5+AP847oc5o9gbu8brCeQz+R1yPpRxlKzWTIeGUZuXgHIsXZ3k4u3LxWxj9cMDLwXc4cgdTXLeMEYnbgrFzi0hRuQh+xW3jLo7zfIxN7MFWE3fq4j5Ab+Y9VMVZY2A22dyn0071xzH9ppn7wSohmutiM0/X3zbkEOkKn69xgQgVtP8CRun1ioLLzuno94oT6AHml7hrMdrhCTkQnJuqCoZhc7BDWZHde9nh9rGo4R+MfL7+voRZicNgd/9KmgdKGpsoN5lWPY1OmJPmiZlfGG0RZ/Fl9zXyqHcpRpz1CzOfy0nbRTp5y+KqG2kwTXfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reY/aWevE3QpOvZ4PF66H8Lirm0QH5mPy7UCizZ24Mk=;
 b=S3ganRW04R69T9JYIc4yT8340EA2wyu78C8jsaJbD5dG3TkOOLRqdpH6Ay1e5CZFKAceyfKRvJLxovLd8bIQWvqUQzw487Z11YpfJLfZ2mnR0F+zD+ZE9KmMBSssOte4I3apky69aCxYNfjATZYMuiAt/qJHcmU4etQ68r4+tck=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:57:56 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:57:56 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 5/6] mfd: iqs62x: Do not poll during ATI
Date:   Sun, 17 Jan 2021 21:57:07 -0600
Message-Id: <1610942228-7275-6-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610942228-7275-1-git-send-email-jeff@labundy.com>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:57:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffaf92b6-4196-45c0-1287-08d8bb653d47
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB4878B1EEA656A288532C9AD2D3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYINwys2iA/cBPewd0Huln+RxYFlwzv1vIOrOjPi/C4GXB++zMsV6mqUhTWHYakBkUFL5yygkHT+hRXJZ9TYQzRghdgxOkgMS6IV8QL4DeE8iIGg70eMwgPJv6NqEPMuy/vL/WgGTf8iVkySA5IbEx4jCBeI8BYGb9Er53PzyJOOD992q/6sBzzus5YHYVTj6CYBmhc26DF+Duesl2Es1mXyGojtLV7U6HA6jgaNdv3t/sN1VtC1OBMVGbaHATKzM5vZaotRUHaSEFmm4zxLUKZPVRJwboDEVT9TzOl8pg4MbPIXpJclXU6OUXtZvUW75NhZ93Wo7+ee64qs+pSx7S+oV/RmFtUqx5RArKV5yuPzPKdbsvER9sD67uqyvkBdsib399bGwsfmmpbQfPxAYSY//WYfe9UgCktk22GEvOYaF026TSIEdoH9hBBtfiKbqu+ovdfHofKTZY9C/rss+3x+zpQMEh1QwqCpK8e0M8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(6666004)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(30864003)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YPkJLxpRuEfJgm39DtflYoewYGn16MGJyq1nQtNZo0EjHY7Pr5gh1KcNakP7?=
 =?us-ascii?Q?gO+VSEe+MT1177qG6s8okHqyJp6nTzR609JnJcwc7GH82HBEXJJaUdCX6jeV?=
 =?us-ascii?Q?JK9eG1B4WmUjpKX1g8B+PvUGJGCKXUWUJ2ZY3JT8EQpJBklxIQR9Yzd+wnV5?=
 =?us-ascii?Q?tUGR9tiMsLn+iWV6KL+hEIwGRqqKQTbe+3YviHn8U2VdUgDgIZ6MxMJdmZ2M?=
 =?us-ascii?Q?Nh7e9irUAHBMBjMrvI8KrHW8GF9wgaZPAY0bb0mvZAjFPGPWY51RUR+cVwWU?=
 =?us-ascii?Q?+Ba4XowAZf0L6oiTaaCN1M9aOWBRZjVGfqoGhUIWuyP9R+Ahz0dHDCvzTgiE?=
 =?us-ascii?Q?VFxFo6rnpSRIZh9E0+05/XtEDr/wpDb4BtxD5yDZmQGYCD/+Rjca0cLEXCfW?=
 =?us-ascii?Q?0SchxJ5lA3vAy6IJny34avz/JCGTiVydKplYQEY277lXSpU/wMRWRhWpvovV?=
 =?us-ascii?Q?phQsbgrvS8iy9hFhMjGjd2OUJxO4EBP+Ghl2r+1DAHggHoNtvxLm8qhp2aLR?=
 =?us-ascii?Q?6KPm19tPiGMDo2E/gjDYM4E6yv2I50dY62MHfr12L4LHnQwK7J31SD+yOEWZ?=
 =?us-ascii?Q?glgdD/AWKprjduf1Q0jDMslRV/ZHtslHe77sO0gNqTbWw6N6unZnidtTlRKk?=
 =?us-ascii?Q?/x1ZcfvephrVIkIbe6tqfQxjyugmWJwTBGlLuAY9MyFs+fCuF4JgTBo0JjAD?=
 =?us-ascii?Q?9HPSnzhnxAxKiHFxAm3D0EdUWl6yZcngGEquX4pIfhMPuXlvGktuAKptdbpt?=
 =?us-ascii?Q?VBODjeNyg3YC4/IsQereluV4Y31D6AKRJAovaXHRaAX41Fzs003bGLlHEgJH?=
 =?us-ascii?Q?Wzdp2zt+//SefGV8tJdOI157ELYMOI4eNmu8umH/aAiLS3d/QlwXl2ahdpAM?=
 =?us-ascii?Q?gHnKF4V9FPR6I+0A46w3KbeIBqxICv5kBwRs4MAMWiw6uXgwSg83OtaBl0a1?=
 =?us-ascii?Q?PYtdWbsKwHA+RsBUUyzdMbOAWJnBbt6yHUV3GB6zrUpdflIwnF6eXWKjoYf9?=
 =?us-ascii?Q?mYzS?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf92b6-4196-45c0-1287-08d8bb653d47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:57:56.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ESgYq84GY1SUr34qX9uoNd/QftTMuWjymRXfIaB6RrjKT/4InTSjd29ue+K8xjSDDRqM4YqQ2F2qG15PGjBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After loading firmware, the driver triggers ATI (calibration) with
the newly loaded register configuration in place. Next, the driver
polls a register field to ensure ATI completed in a timely fashion
and that the device is ready to sense.

However, communicating with the device over I2C while ATI is under-
way may induce noise in the device and cause ATI to fail. As such,
the vendor recommends not to poll the device during ATI.

To solve this problem, let the device naturally signal to the host
that ATI is complete by way of an interrupt. A completion prevents
the sub-devices from being registered until this happens.

The former logic that scaled ATI timeout and filter settling delay
is not carried forward with the new implementation, as it produces
overly conservative delays at lower clock rates. Instead, a single
pair of delays that covers all cases is used.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
  - Removed superfluous newlines throughout all iqs62x_dev_desc structs

 drivers/mfd/iqs62x.c       | 125 +++++++++++++++++++++++++--------------------
 include/linux/mfd/iqs62x.h |  11 ++--
 2 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 07c9725..9b5c389 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -36,7 +36,6 @@
 #define IQS62X_PROD_NUM				0x00

 #define IQS62X_SYS_FLAGS			0x10
-#define IQS62X_SYS_FLAGS_IN_ATI			BIT(2)

 #define IQS620_HALL_FLAGS			0x16
 #define IQS621_HALL_FLAGS			0x19
@@ -60,6 +59,7 @@
 #define IQS62X_SYS_SETTINGS_ACK_RESET		BIT(6)
 #define IQS62X_SYS_SETTINGS_EVENT_MODE		BIT(5)
 #define IQS62X_SYS_SETTINGS_CLK_DIV		BIT(4)
+#define IQS62X_SYS_SETTINGS_COMM_ATI		BIT(3)
 #define IQS62X_SYS_SETTINGS_REDO_ATI		BIT(1)

 #define IQS62X_PWR_SETTINGS			0xD2
@@ -81,9 +81,7 @@
 #define IQS62X_FW_REC_TYPE_MASK			3
 #define IQS62X_FW_REC_TYPE_DATA			4

-#define IQS62X_ATI_POLL_SLEEP_US		10000
-#define IQS62X_ATI_POLL_TIMEOUT_US		500000
-#define IQS62X_ATI_STABLE_DELAY_MS		150
+#define IQS62X_FILT_SETTLE_MS			250

 struct iqs62x_fw_rec {
 	u8 type;
@@ -111,7 +109,6 @@ static int iqs62x_dev_init(struct iqs62x_core *iqs62x)
 	struct iqs62x_fw_blk *fw_blk;
 	unsigned int val;
 	int ret;
-	u8 clk_div = 1;

 	list_for_each_entry(fw_blk, &iqs62x->fw_blk_head, list) {
 		if (fw_blk->mask)
@@ -181,28 +178,32 @@ static int iqs62x_dev_init(struct iqs62x_core *iqs62x)
 			return ret;
 	}

-	ret = regmap_read(iqs62x->regmap, IQS62X_SYS_SETTINGS, &val);
-	if (ret)
-		return ret;
-
-	if (val & IQS62X_SYS_SETTINGS_CLK_DIV)
-		clk_div = iqs62x->dev_desc->clk_div;
-
-	ret = regmap_write(iqs62x->regmap, IQS62X_SYS_SETTINGS, val |
-			   IQS62X_SYS_SETTINGS_ACK_RESET |
-			   IQS62X_SYS_SETTINGS_EVENT_MODE |
-			   IQS62X_SYS_SETTINGS_REDO_ATI);
-	if (ret)
-		return ret;
-
-	ret = regmap_read_poll_timeout(iqs62x->regmap, IQS62X_SYS_FLAGS, val,
-				       !(val & IQS62X_SYS_FLAGS_IN_ATI),
-				       IQS62X_ATI_POLL_SLEEP_US,
-				       IQS62X_ATI_POLL_TIMEOUT_US * clk_div);
+	/*
+	 * Place the device in streaming mode at first so as not to miss the
+	 * limited number of interrupts that would otherwise occur after ATI
+	 * completes. The device is subsequently placed in event mode by the
+	 * interrupt handler.
+	 *
+	 * In the meantime, mask interrupts during ATI to prevent the device
+	 * from soliciting I2C traffic until the noise-sensitive ATI process
+	 * is complete.
+	 */
+	ret = regmap_update_bits(iqs62x->regmap, IQS62X_SYS_SETTINGS,
+				 IQS62X_SYS_SETTINGS_ACK_RESET |
+				 IQS62X_SYS_SETTINGS_EVENT_MODE |
+				 IQS62X_SYS_SETTINGS_COMM_ATI |
+				 IQS62X_SYS_SETTINGS_REDO_ATI,
+				 IQS62X_SYS_SETTINGS_ACK_RESET |
+				 IQS62X_SYS_SETTINGS_REDO_ATI);
 	if (ret)
 		return ret;

-	msleep(IQS62X_ATI_STABLE_DELAY_MS * clk_div);
+	/*
+	 * The following delay gives the device time to deassert its RDY output
+	 * in case a communication window was open while the REDO_ATI field was
+	 * written. This prevents an interrupt from being serviced prematurely.
+	 */
+	usleep_range(5000, 5100);

 	return 0;
 }
@@ -433,6 +434,11 @@ const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS] = {
 		.mask	= BIT(7),
 		.val	= BIT(7),
 	},
+	[IQS62X_EVENT_SYS_ATI] = {
+		.reg	= IQS62X_EVENT_SYS,
+		.mask	= BIT(2),
+		.val	= BIT(2),
+	},
 };
 EXPORT_SYMBOL_GPL(iqs62x_events);

@@ -521,12 +527,39 @@ static irqreturn_t iqs62x_irq(int irq, void *context)
 				"Failed to re-initialize device: %d\n", ret);
 			return IRQ_NONE;
 		}
+
+		iqs62x->event_cache |= BIT(IQS62X_EVENT_SYS_RESET);
+		reinit_completion(&iqs62x->ati_done);
+	} else if (event_flags & BIT(IQS62X_EVENT_SYS_ATI)) {
+		iqs62x->event_cache |= BIT(IQS62X_EVENT_SYS_ATI);
+		reinit_completion(&iqs62x->ati_done);
+	} else if (!completion_done(&iqs62x->ati_done)) {
+		ret = regmap_update_bits(iqs62x->regmap, IQS62X_SYS_SETTINGS,
+					 IQS62X_SYS_SETTINGS_EVENT_MODE, 0xFF);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to enable event mode: %d\n", ret);
+			return IRQ_NONE;
+		}
+
+		msleep(IQS62X_FILT_SETTLE_MS);
+		complete_all(&iqs62x->ati_done);
 	}

-	ret = blocking_notifier_call_chain(&iqs62x->nh, event_flags,
-					   &event_data);
-	if (ret & NOTIFY_STOP_MASK)
-		return IRQ_NONE;
+	/*
+	 * Reset and ATI events are not broadcast to the sub-device drivers
+	 * until ATI has completed. Any other events that may have occurred
+	 * during ATI are ignored.
+	 */
+	if (completion_done(&iqs62x->ati_done)) {
+		event_flags |= iqs62x->event_cache;
+		ret = blocking_notifier_call_chain(&iqs62x->nh, event_flags,
+						   &event_data);
+		if (ret & NOTIFY_STOP_MASK)
+			return IRQ_NONE;
+
+		iqs62x->event_cache = 0;
+	}

 	/*
 	 * Once the communication window is closed, a small delay is added to
@@ -567,6 +600,12 @@ static void iqs62x_firmware_load(const struct firmware *fw, void *context)
 		goto err_out;
 	}

+	if (!wait_for_completion_timeout(&iqs62x->ati_done,
+					 msecs_to_jiffies(2000))) {
+		dev_err(&client->dev, "Failed to complete ATI\n");
+		goto err_out;
+	}
+
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 				   iqs62x->dev_desc->sub_devs,
 				   iqs62x->dev_desc->num_sub_devs,
@@ -748,22 +787,17 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.dev_name	= "iqs620at",
 		.sub_devs	= iqs620at_sub_devs,
 		.num_sub_devs	= ARRAY_SIZE(iqs620at_sub_devs),
-
 		.prod_num	= IQS620_PROD_NUM,
 		.sw_num		= 0x08,
 		.cal_regs	= iqs620at_cal_regs,
 		.num_cal_regs	= ARRAY_SIZE(iqs620at_cal_regs),
-
 		.prox_mask	= BIT(0),
 		.sar_mask	= BIT(1) | BIT(7),
 		.hall_mask	= BIT(2),
 		.hyst_mask	= BIT(3),
 		.temp_mask	= BIT(4),
-
 		.prox_settings	= IQS620_PROX_SETTINGS_4,
 		.hall_flags	= IQS620_HALL_FLAGS,
-
-		.clk_div	= 4,
 		.fw_name	= "iqs620a.bin",
 		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
 	},
@@ -771,20 +805,15 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.dev_name	= "iqs620a",
 		.sub_devs	= iqs620a_sub_devs,
 		.num_sub_devs	= ARRAY_SIZE(iqs620a_sub_devs),
-
 		.prod_num	= IQS620_PROD_NUM,
 		.sw_num		= 0x08,
-
 		.prox_mask	= BIT(0),
 		.sar_mask	= BIT(1) | BIT(7),
 		.hall_mask	= BIT(2),
 		.hyst_mask	= BIT(3),
 		.temp_mask	= BIT(4),
-
 		.prox_settings	= IQS620_PROX_SETTINGS_4,
 		.hall_flags	= IQS620_HALL_FLAGS,
-
-		.clk_div	= 4,
 		.fw_name	= "iqs620a.bin",
 		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
 	},
@@ -792,23 +821,18 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.dev_name	= "iqs621",
 		.sub_devs	= iqs621_sub_devs,
 		.num_sub_devs	= ARRAY_SIZE(iqs621_sub_devs),
-
 		.prod_num	= IQS621_PROD_NUM,
 		.sw_num		= 0x09,
 		.cal_regs	= iqs621_cal_regs,
 		.num_cal_regs	= ARRAY_SIZE(iqs621_cal_regs),
-
 		.prox_mask	= BIT(0),
 		.hall_mask	= BIT(1),
 		.als_mask	= BIT(2),
 		.hyst_mask	= BIT(3),
 		.temp_mask	= BIT(4),
-
 		.als_flags	= IQS621_ALS_FLAGS,
 		.hall_flags	= IQS621_HALL_FLAGS,
 		.hyst_shift	= 5,
-
-		.clk_div	= 2,
 		.fw_name	= "iqs621.bin",
 		.event_regs	= &iqs621_event_regs[IQS62X_UI_PROX],
 	},
@@ -816,21 +840,16 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.dev_name	= "iqs622",
 		.sub_devs	= iqs622_sub_devs,
 		.num_sub_devs	= ARRAY_SIZE(iqs622_sub_devs),
-
 		.prod_num	= IQS622_PROD_NUM,
 		.sw_num		= 0x06,
-
 		.prox_mask	= BIT(0),
 		.sar_mask	= BIT(1),
 		.hall_mask	= BIT(2),
 		.als_mask	= BIT(3),
 		.ir_mask	= BIT(4),
-
 		.prox_settings	= IQS622_PROX_SETTINGS_4,
 		.als_flags	= IQS622_ALS_FLAGS,
 		.hall_flags	= IQS622_HALL_FLAGS,
-
-		.clk_div	= 2,
 		.fw_name	= "iqs622.bin",
 		.event_regs	= &iqs622_event_regs[IQS62X_UI_PROX],
 	},
@@ -838,14 +857,10 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.dev_name	= "iqs624",
 		.sub_devs	= iqs624_sub_devs,
 		.num_sub_devs	= ARRAY_SIZE(iqs624_sub_devs),
-
 		.prod_num	= IQS624_PROD_NUM,
 		.sw_num		= 0x0B,
-
 		.interval	= IQS624_INTERVAL_NUM,
 		.interval_div	= 3,
-
-		.clk_div	= 2,
 		.fw_name	= "iqs624.bin",
 		.event_regs	= &iqs624_event_regs[IQS62X_UI_PROX],
 	},
@@ -853,14 +868,10 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.dev_name	= "iqs625",
 		.sub_devs	= iqs625_sub_devs,
 		.num_sub_devs	= ARRAY_SIZE(iqs625_sub_devs),
-
 		.prod_num	= IQS625_PROD_NUM,
 		.sw_num		= 0x0B,
-
 		.interval	= IQS625_INTERVAL_NUM,
 		.interval_div	= 10,
-
-		.clk_div	= 2,
 		.fw_name	= "iqs625.bin",
 		.event_regs	= &iqs625_event_regs[IQS62X_UI_PROX],
 	},
@@ -890,6 +901,8 @@ static int iqs62x_probe(struct i2c_client *client)

 	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
 	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
+
+	init_completion(&iqs62x->ati_done);
 	init_completion(&iqs62x->fw_done);

 	iqs62x->regmap = devm_regmap_init_i2c(client, &iqs62x_regmap_config);
diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
index 043d3b6..5ced55e 100644
--- a/include/linux/mfd/iqs62x.h
+++ b/include/linux/mfd/iqs62x.h
@@ -28,7 +28,7 @@
 #define IQS620_GLBL_EVENT_MASK_PMU		BIT(6)

 #define IQS62X_NUM_KEYS				16
-#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 5)
+#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 6)

 #define IQS62X_EVENT_SIZE			10

@@ -78,6 +78,7 @@ enum iqs62x_event_flag {

 	/* everything else */
 	IQS62X_EVENT_SYS_RESET,
+	IQS62X_EVENT_SYS_ATI,
 };

 struct iqs62x_event_data {
@@ -97,12 +98,10 @@ struct iqs62x_dev_desc {
 	const char *dev_name;
 	const struct mfd_cell *sub_devs;
 	int num_sub_devs;
-
 	u8 prod_num;
 	u8 sw_num;
 	const u8 *cal_regs;
 	int num_cal_regs;
-
 	u8 prox_mask;
 	u8 sar_mask;
 	u8 hall_mask;
@@ -110,16 +109,12 @@ struct iqs62x_dev_desc {
 	u8 temp_mask;
 	u8 als_mask;
 	u8 ir_mask;
-
 	u8 prox_settings;
 	u8 als_flags;
 	u8 hall_flags;
 	u8 hyst_shift;
-
 	u8 interval;
 	u8 interval_div;
-
-	u8 clk_div;
 	const char *fw_name;
 	const enum iqs62x_event_reg (*event_regs)[IQS62X_EVENT_SIZE];
 };
@@ -130,8 +125,10 @@ struct iqs62x_core {
 	struct regmap *regmap;
 	struct blocking_notifier_head nh;
 	struct list_head fw_blk_head;
+	struct completion ati_done;
 	struct completion fw_done;
 	enum iqs62x_ui_sel ui_sel;
+	unsigned long event_cache;
 };

 extern const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS];
--
2.7.4

