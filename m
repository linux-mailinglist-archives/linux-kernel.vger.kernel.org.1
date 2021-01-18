Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038022F9870
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbhAREAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:00:21 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:60843
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732004AbhARD7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:59:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB9ZF1zCmq9rRMe4cPEbwuBDHAQYb/SiNEt4TXlD6cYzfpN86AnBETWxgfw+bSryQcah5Iy/caXiPfoRsGEGqIaAbXi6Y9+hvtFlG2IgGpQ4CJ1cLBkFbSLAhRIDXVa8nNMtLJMgA3LPBCkHsbWj5+cdmUWVqsB0gum/Si2xxDp1LbDTCKiZvwsiUfQauuFgFfyj7cLA9deeTn6G1O1MwAVX2XXMOj41YLuHqBWddrS8J0bsllN0vHQoSohNGY0JoNKC5cPoETwA3E/ioZ8JxMdprkyiLtLfuyP2Go9D1rZcK1rcPUK6aIfrcmBoX/7JN9uulVFjoXuRigfIEWJXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi0Dj7wo3sW+KLyZs1cForWgxA8h5XDeZwtBH0wsr6A=;
 b=fQYXzgKViFYaFRAnrES3xg2D2/JRCTEcwAmVPLSo2e3/mPG1tRqXVReiDRtTGRL2YRQR55JRtgQNK1rbSBuICjif3vzeaOkkTIzurP6COULwtch7ccU+LB6BsR4QtIBzu1KLjYUC5r8aj8dGpIta1n19wvVE4SM6ocvzcUXoH8vomf6eMjqPOtm0ubSayeCmrpGjoHA0A72BEKsCOwbJy14X/a8js+EcesyRAKr9E2D1LADOOnmApJFvcQ8y80BVJNAs7vIO/LK2d8qv7ACUN6kbdzt9BoYZtUT97dWx/AxkpYzFNcbKTsbSvIzCyii/TnyjQT8GlbIgaZwzf28CJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi0Dj7wo3sW+KLyZs1cForWgxA8h5XDeZwtBH0wsr6A=;
 b=zHUCBI+98H+/5j0omI1ZvEmGGky9ZF47ZdyrQ8GkU8XaGMZWhH8/Xox/Dxw5J20tMqycOxT6y8Vja2L2eg5dzMSFSij8cLDDW2bMwnTW8rxbWkmdHZo8K1YjHA4STb0a/NLxwqc89umUqvS7Ji1NtVvSxZLCP6EcJ+6kem8PjjY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:58:04 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:58:04 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 6/6] mfd: iqs62x: Do not change clock frequency during ATI
Date:   Sun, 17 Jan 2021 21:57:08 -0600
Message-Id: <1610942228-7275-7-git-send-email-jeff@labundy.com>
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
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:58:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e307cac-5916-4477-fed2-08d8bb65419c
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB4878A726E2306278C944D3F0D3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoAg7WtTOQ5tiMVFa39/2fVUL+2wMhWCfDRgpFGywopjdTRLofyYWZmN1/cAQ9OxJYpZgwQ3o5K8VkM4do6NWplQGUtFMp4W2AMKnu4h2CZSdTCtoBmRWYyhMaBC7nUY8aJs7jMbUw10yIBnjA2A4rbYo6g5gAD2GpSd4nzavARPwwLRwoqjIDoojLdOb148k6K5msf1tCj7EcAecqX5vZO/WYF/zBxWkk/pJ44O5VEeohAhI4tWkjes9IRLUGj1M0QHIkuQqZVd61a6ZDUORAikPIVB4edtJgnUwPaNmmBfFHGzg55s+AAxgFPu8z0H9La43CJHlmFEpZltR8MAOi06a3xmOccyQkZ5fiiXK7i4GGf3cIC2h2rlubOKjGFzWehEkG1ZM04Yrb8n2IpB/vjVoeLUTDISKKwrkAr0qH2ENw44e5fjp66mQA0j1CeF0mPsMYdVev52awfkz0NB1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XAb7c+Clox1NuvzMxwSVPef7vdlxHvl6KHpgLboL+Rsg0g2Neq+Sl7wIhDb3?=
 =?us-ascii?Q?BOPc0OuMhPgEOCn1Q3tdOqipxIbVN0FWrExTjFj2W//fSBeGK82jB0MmyiR5?=
 =?us-ascii?Q?L6QKJpB7LExoocynnoOX7Vrk0KIO28CFovodirTtDTvUJ9wUFXvP4WVrfpBT?=
 =?us-ascii?Q?0tsa8Z6JxE15Uklh8XuB14ITpn/ceS7KCYvy60lRHsP5cKNVtL7Qfg7ftjSC?=
 =?us-ascii?Q?UATHgD3X/t3uN/O4PE/9tDqTaYhF9ydp8i9hMNN5dQqicmvu+6fnAaH5LAh4?=
 =?us-ascii?Q?rA0zdOtI5eC+Tcw4Um72ZMBf2TnbO1gY8/diYPAUby2ED/qoaOgLBdkS88hT?=
 =?us-ascii?Q?KtmPxdgyjwTSOQEkxXHGJihguNhDYR6V7HB5ulJXV6OavtLDdPoC11eexF4Y?=
 =?us-ascii?Q?npJj9d8Jo+vDEVhztKbU3m6Tz2/ukeOS3qrC/40mjIxTzVa2ayQe+FrYpp4M?=
 =?us-ascii?Q?plHoRlFBoClaGOB/PPg4mKi/REbOx1gfHz1PGUOhzSmnFpWB8HKYU0N64W7I?=
 =?us-ascii?Q?khhPw/jImJrMRTFBYV+ufka62sj7mWoMQUO+VG4pG9jVXV0+ZfrP6E4C4zzm?=
 =?us-ascii?Q?HHn9FQHujp39UHW0QrQAeJPhr0PxF3UEJ2APCEGR96SSzfxKQgFiBfT97WC9?=
 =?us-ascii?Q?kn9JOTHmsL/u950Z0Mxxz89QQhtdpFhm6JcQNoXmVdxSVTPImqqSxqmAjPrQ?=
 =?us-ascii?Q?jgRuGULgSRRfcFVy13aJ6KtocagCXmuxoTNaMglYU9fMHsQ7ATfVfZFiecXc?=
 =?us-ascii?Q?DAwu4ifBztJOgqvGJ2rA8rzij7nJquOnLqp5ZRx1z+j0UAQcziQ6Zo5UCYjw?=
 =?us-ascii?Q?SJtcYa6kk6/YAzou1AXRBGNAqWKxZELoKOZOEqwmpsW5VLWkH5gep/agy5HR?=
 =?us-ascii?Q?upoXRsVy5dQHVnVOu1v3tv1UVkfD4Z47jGLa02O0XP01a7JsUREUzQALbLLv?=
 =?us-ascii?Q?5PzLf328ZlqOnxIwfHuWAhRdtaCMCfoVg/F7jLPKvvE7qa5Tgf6RWaN3qPk6?=
 =?us-ascii?Q?+oAX?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e307cac-5916-4477-fed2-08d8bb65419c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:58:04.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7J5cjcjXOJK4oxZthM6izQXgqU3jwaSJGOp3joEyoRZU90KnoRNZbXrviyQ+O7z118VVLJ6LcVkCLDniHKYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a reset event, the device automatically triggers ATI at the
default core clock frequency (16 MHz). Soon afterward, the driver
loads firmware which may attempt to lower the frequency.

If this initial ATI cycle is still in progress when the frequency
is changed, however, the device incorrectly reports channels 0, 1
and 2 to be in a state of touch once ATI finally completes.

To solve this problem, wait until ATI is complete before lowering
the frequency. Because this particular ATI cycle occurs following
a reset event, its duration is predictable and a simple delay can
suffice.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v2:
  - Added Acked-for-MFD-by trailer

 drivers/mfd/iqs62x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 9b5c389..d1fc38a 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -81,6 +81,7 @@
 #define IQS62X_FW_REC_TYPE_MASK			3
 #define IQS62X_FW_REC_TYPE_DATA			4

+#define IQS62X_ATI_STARTUP_MS			350
 #define IQS62X_FILT_SETTLE_MS			250

 struct iqs62x_fw_rec {
@@ -111,6 +112,14 @@ static int iqs62x_dev_init(struct iqs62x_core *iqs62x)
 	int ret;

 	list_for_each_entry(fw_blk, &iqs62x->fw_blk_head, list) {
+		/*
+		 * In case ATI is in progress, wait for it to complete before
+		 * lowering the core clock frequency.
+		 */
+		if (fw_blk->addr == IQS62X_SYS_SETTINGS &&
+		    *fw_blk->data & IQS62X_SYS_SETTINGS_CLK_DIV)
+			msleep(IQS62X_ATI_STARTUP_MS);
+
 		if (fw_blk->mask)
 			ret = regmap_update_bits(iqs62x->regmap, fw_blk->addr,
 						 fw_blk->mask, *fw_blk->data);
--
2.7.4

