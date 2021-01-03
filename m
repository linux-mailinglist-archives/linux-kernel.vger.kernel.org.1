Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5C2E8E36
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbhACU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:58:25 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:33505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbhACU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:58:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOao+mclTCWOJbj5/B5dzS0F5lrPGE5wYigqU7J9XeEFgE2zn7Dso6yaWSQ7j72tXMCfqxDoLh6+q2N6KfXMnPJRley85dsK82wjlQQ249XHBQhTTzsMoR25CJAnIO7uiixjgvYhx2M3nUhnDgICk0yKKWTCxra0mYE4uPnzex4Hnvbvitt2bhSdVfFCrmfaBM6XBklo6moRIzytCJpci2FFCOwJ/ZLgrQ1YfHsId1H0xBGsEmINQhVVqmbHZUWypPbsOFivfNrfMAUC2ie/Kr8/+LXs+Kj5RkNu75r4zIMWS4B2PDaIAbWcgFt4CvNQ6USAyBGFYHJiHelZ+S0T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnsTUBJwXV8fPaD7+bfBnVIJQRpRK0rNgJsvCabbMVQ=;
 b=VC0krS7Z+K7PJGj5t1YDtva0shI+mCN/M7Mj+K1fcQvRCDT8M2XP9pq84rLIj/8SxFyjaKIw0kAKveXIJqibC3mSB9g+kixaa6/NTqbuj27RhnpIlB0iomuSgAUV9pUpbAji3aX8FBKk38DjiFMH/Axtko4amItSv/VakQzdwJkWwLoHG6ZsMUNVWSDZcq3O8ZEQDmhF90Z8OXRm3YXbmT7TW2U25DAN/pPUYKmN2ap8nHVt6Nkd0srh2c2SsaVeESavpLpZkm7enT6HKP6MiB9vhRdqB+RlGGbLpccoUw3Hwq0s8hwWKGfcqPVooRZy2IsW92JdbwuQtphYn5/1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnsTUBJwXV8fPaD7+bfBnVIJQRpRK0rNgJsvCabbMVQ=;
 b=UZvRg7lRT6LaWaxZefzbZ3izGhB1RJNtX4nMMww1Z4waHp7p6Wh7DyVIKFVMmrf2N16mrbZ7IGAVXp9pHlOrLU7xNqxrDZe32xGKWcFB1V1/bdglYvoiULJv+jhHQO2act0i8uLoiEOqTHeVcZUvEnTpRiUosymTI1vJATN9djI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:48 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:48 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 5/6] mfd: iqs62x: Do not poll during ATI
Date:   Sun,  3 Jan 2021 14:56:08 -0600
Message-Id: <1609707369-11297-6-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609707369-11297-1-git-send-email-jeff@labundy.com>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: DS7PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::28) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeba6f0f-6fed-48d9-a8be-08d8b02a16a9
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB71523E1C19ECA44D44CDD89CD3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: si4wwDJeCnHGnHcd2qMkLxbX62Yl4tR4dDXKqp9qPRUx08+uBv6SunlHy0m1KsF3KRopxnBtyCFyMeLFYLzkPaG0xxY0ayCnTkHJI9B1wg+f81EDELeTxdpVQ4LtBMYuh/s2ei8Z6P78SwAH/gnbeqUH7B19hX/WV+Lq9mjrazJRthretzoR/QWgltpIk6gmCij5TbakYsbGx63Qc0sA8GVM9QTI9Cm6DtpAnJZPN8A1S96//PC/f1+BuNUDc1Ngvz8oJb2JaXEQPIJgbcb2jVRWos9CCOa0lAYYZ1wSaAlVaKQ5af0eB5mXg8MIpJ9H2MlHJcGQWmFfzcwU15F5z3WoevA3YqyNjkNPPr3wOgR4CeVAfGjnD7HkXAH+jwb3wta3HPxtbHFERQ8TRgmzoHKIPfVtZjJy9g1Iljp78gkqA5fUeLUsJkkY9FaqfR0ipmlGUfmhp9aNgypZR3yby83MZ/fgvRWakXSVTWBQ3Ro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(2616005)(956004)(5660300002)(8936002)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DzRNL5WhxxY9W3+tI+YCdI09XIDXpQ0x/+Jb4tQ/lD2uQFuw2weK2alNq6cO?=
 =?us-ascii?Q?gdn/3Z2gsmR+tJhNWjVk+33H4E++Yb2Std7/Mi5weqV4nwy/jSDvBlVuPIdM?=
 =?us-ascii?Q?wWzgxveUQSk5Z7wlw3FGVbzkoRkKtki0NqioWiXWFsM5Ah59BHq/UnQPL71E?=
 =?us-ascii?Q?QTdQfDcfB8RaV0OWR4byqTNbmIiWlKxvumAX8XrXhYapuiHfhrZa5+eWyj4l?=
 =?us-ascii?Q?qVXdAkE6LJM/3fusg2PggG3TGeJtqcqYpYy8BKkQ9soGtQbtpbURpwqw/QUe?=
 =?us-ascii?Q?+N+HpjkEXk2wQHUWGuKuYUEHKUooGeafUu52ykrJko9De2ii9PU/KjRprBNE?=
 =?us-ascii?Q?huforLKsKnWuGHW7xE34XvaXReI4HUZ3WBSb+BvYT+cE/LhgHnC4yQMRYTV9?=
 =?us-ascii?Q?LQwAYpAJiL/fDfjr8DKTHS2evSpO1Q5FFiOwbF6gL7Mc9VdT1cawBoY5E+hc?=
 =?us-ascii?Q?UNWRlnrOxBClDJbCHpMeKmkOLF8du8qJ6OAmzs2CKVSfym8xdhO7BhCo+svB?=
 =?us-ascii?Q?6Q5SFNMl9kdkc83CYcVddDcav1+tfGrjHyje0qbtKKwCg+eVhTYiUVaQAjQC?=
 =?us-ascii?Q?iK9SJrwP1ZrSfpRiDP7b0xzoJeU7RSQbsgJtykfDMv8o9haocFuQquxRhGbd?=
 =?us-ascii?Q?5AWsjEfeagPxZH/3QR3TqqGdWD6FSz1Xm0JvpUe6jnfLXvSvkAycKtmVp9YT?=
 =?us-ascii?Q?Yz2WbT2BSy0qBJ1exMv4nfeVDoolE27DvhXF0Ia65Y44qxOuKKVVTES5PCqq?=
 =?us-ascii?Q?/tGjEiDc1pvcQOgahKRyrMuV4a+0FOtd4tEciKmQrVC/5HXVg7mvKXVYUQd8?=
 =?us-ascii?Q?wOaqC930NNMTaYtwiF/rbvutOB/QzqvFmNlEVEuqSfPPx10rFgRkdcQrIx+e?=
 =?us-ascii?Q?pVX2GOgnOT3oUZOaJ6HyxlZg3SVATLYn/r2SsjDLPHa8OeWHbkaaOIuoNVor?=
 =?us-ascii?Q?gP55w+brWhP/BDtHNqNsb7bBDtL10g2U591saNoVbza6hoHSXAbFtbXi3O7R?=
 =?us-ascii?Q?ycPe?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:48.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba6f0f-6fed-48d9-a8be-08d8b02a16a9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7SF6Br8dIC0xaZTjaZ2RNgF0xDxWuv8PcwZwMj7ZIOqUE1TIstzoEHhG9rxf8RQxs1W3TxOGqzM64hB13u8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
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
 drivers/mfd/iqs62x.c       | 103 ++++++++++++++++++++++++++++++---------------
 include/linux/mfd/iqs62x.h |   6 ++-
 2 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 07c9725..9fdf32f 100644
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
@@ -763,7 +802,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.prox_settings	= IQS620_PROX_SETTINGS_4,
 		.hall_flags	= IQS620_HALL_FLAGS,
 
-		.clk_div	= 4,
 		.fw_name	= "iqs620a.bin",
 		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
 	},
@@ -784,7 +822,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.prox_settings	= IQS620_PROX_SETTINGS_4,
 		.hall_flags	= IQS620_HALL_FLAGS,
 
-		.clk_div	= 4,
 		.fw_name	= "iqs620a.bin",
 		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
 	},
@@ -808,7 +845,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.hall_flags	= IQS621_HALL_FLAGS,
 		.hyst_shift	= 5,
 
-		.clk_div	= 2,
 		.fw_name	= "iqs621.bin",
 		.event_regs	= &iqs621_event_regs[IQS62X_UI_PROX],
 	},
@@ -830,7 +866,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.als_flags	= IQS622_ALS_FLAGS,
 		.hall_flags	= IQS622_HALL_FLAGS,
 
-		.clk_div	= 2,
 		.fw_name	= "iqs622.bin",
 		.event_regs	= &iqs622_event_regs[IQS62X_UI_PROX],
 	},
@@ -845,7 +880,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.interval	= IQS624_INTERVAL_NUM,
 		.interval_div	= 3,
 
-		.clk_div	= 2,
 		.fw_name	= "iqs624.bin",
 		.event_regs	= &iqs624_event_regs[IQS62X_UI_PROX],
 	},
@@ -860,7 +894,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 		.interval	= IQS625_INTERVAL_NUM,
 		.interval_div	= 10,
 
-		.clk_div	= 2,
 		.fw_name	= "iqs625.bin",
 		.event_regs	= &iqs625_event_regs[IQS62X_UI_PROX],
 	},
@@ -890,6 +923,8 @@ static int iqs62x_probe(struct i2c_client *client)
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
 	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
+
+	init_completion(&iqs62x->ati_done);
 	init_completion(&iqs62x->fw_done);
 
 	iqs62x->regmap = devm_regmap_init_i2c(client, &iqs62x_regmap_config);
diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
index 043d3b6..0b71173 100644
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
@@ -119,7 +120,6 @@ struct iqs62x_dev_desc {
 	u8 interval;
 	u8 interval_div;
 
-	u8 clk_div;
 	const char *fw_name;
 	const enum iqs62x_event_reg (*event_regs)[IQS62X_EVENT_SIZE];
 };
@@ -130,8 +130,10 @@ struct iqs62x_core {
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

