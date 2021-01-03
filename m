Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C892E8E37
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhACU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:58:27 -0500
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:45793
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbhACU6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:58:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InglSZNsTSiO2rlJDo/ja7hLFbQBfhcd2CgH6NOVB69CmzrNEVc+HdIiORx8WDNA/PTlN05hUXZzYQCNAJwkC4MWk/sQ26GjgQRjaMeLBKIakNnUvZdlDFV5kZsinQFpFQFpNA0q8rBi+VH1EXNwUl4Jg8Ov6b6LPTYyU6OH5GThEBCVOo8HWMltUVh3/6K9id89M1OLB7TFR1OKIzaFBuV8B0+1HjqJcWUXUYQA2zrM3eNXeXl84/CQcUz2yGqOHQRIf/95LsDtIuZj4W+4czQ/yzKXt1pmdS68WDenK5hB2HuuIlZunHJfQhegKdvvNppemE2U/CIkjUUoTfseVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXWVnGdCFRPdKp035gWWaE46oMEBevJfcn6xv/UjOLo=;
 b=C5WlDBkx33bAvlAMdOM3flOdJTZ9oJOs/8tREG8karPr78BSB+T5U/BPbOII2t+6z54gGpNp/cBmS0wG1WP751j9Hl0NbINFiiEnhO2nt5FXfeCMDWcpN2KUoQen1qwL/TtPFk3N9nbfP7aMpoQ8SplS1yQd5QA6oHnQLc2RLBaousDj9RDNOoK6DKGhr8IBIYezbSpkq/G5DWOZGLq2s//lpZk5MHx9TF8pAGK6yNBljE5mwN0Hco1kqmVUCkW2S+Tch0WDF75IplEzOZ+zDJWnpbQ6HYG/2A3w9wd/rqeqS4cnqo462Y9W+TEZJF/JFI2WunyYa8VknXWZ/QjTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXWVnGdCFRPdKp035gWWaE46oMEBevJfcn6xv/UjOLo=;
 b=jx0aV0RwbBf18P5d4gtI3dqFkchRPLRTm+KCfInCxLdUdM1ZVlIeiMShU3vl0wbFHMk0YBkJk5d9SJxkcyTSf1wp25tXlYAWV86m+NCTi/LtAhF6G8o+KxSEBExfeEXt5t8iTDoSvUjJiaFOMSkWrw59R2Kh6DBCBBN3OIWsLn8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:51 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:51 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 6/6] mfd: iqs62x: Do not change clock frequency during ATI
Date:   Sun,  3 Jan 2021 14:56:09 -0600
Message-Id: <1609707369-11297-7-git-send-email-jeff@labundy.com>
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
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d2e782b-1ca0-4d92-f74d-08d8b02a1817
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB7152D1B3A0FB598E787654BFD3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vHvUg1rPfrkZ5dPrTn24XZE6u8+nrswnRSw+t6/cGouo3gROMdeflXzVujWE3sq2hPJLflb5j1Kf53DJYlk6g3vt0HnhKcqyeaaSIMC+wGxUcMgLn4T3HUWEu5uCoaV5zcO2VqUkxEx7Or/gDXLmGWnowTVxrzykyknhpzMEcvue/eUBytbx5hrNHRgTXk/FAV2MxcDoxY1VSxl4RHmyoeAViQG/fBZsCqhEOFzZ34nTOp79vDWKCAwyyejO0SsheJKK56U6CjNMrEBkrZUpTzXInsP3whPuXlI2zJsNT7fsPWIk+EAhsXcEsKp0o9Gcc181Y74AP40mkLjtnCjmBnQACqifdfZjZlPMhziM3h9j5STuOvd4JsLbzV9LFtO0Fk5Ghv+yjNHnX9EYQpJs9LlGysDQud5utqHf3ILJK4HMhfnehh7DBoXjxNGtQPKnqESAZgQce2IIzcYSuohYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(2616005)(956004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?80Gk6sbc3HAZmPhmv3JjX68YJbCThgQkNI9LKMauey1kXrcfOWukU97ck6Sd?=
 =?us-ascii?Q?qkcD9hWsWKb9OAGNvRMtQzuiC56HhjfbwByeAOioy6QdQE8Oe29/BWO7RB5I?=
 =?us-ascii?Q?hGepqAyLxPNrN6oqosqcZhL08qsBfzJAxSi2Rsb29tKH1AN1HAOsPjjYk864?=
 =?us-ascii?Q?WpKtcWfPEooQMp1F63EOAKL/L+LDUnbfZ8Z9fOqo4LE17mNr+N78pAJzKdV/?=
 =?us-ascii?Q?LCRItOCZsg2lmVyjPAwJZBS74moZ9rCaDAQUv1+55KF62740xdydjPp8P5bz?=
 =?us-ascii?Q?RnysH9Tco+xrRuW8edCp6puke7rYxTdYDZAsyOSrdTwNjAghkod3/vSsbGcS?=
 =?us-ascii?Q?9tfR11wPOvEBrHWZPezPD+pKxx3yr4kPC5TZO8oLrRcc5kqn11cQSqSGbO5I?=
 =?us-ascii?Q?nLDwsIaTriXmdkoF6e7WF5GrGQYFO2ihC4gFW4066u1L6mBcv2oQ0WhJ4jzp?=
 =?us-ascii?Q?1bdw/PWc738pSjmNjIezSA17pZoYnmESAoO4c9RHA850ab5EsDUDDqcnBD1G?=
 =?us-ascii?Q?A0OdPDS+8dbWPeoDS+eDfw57SexDHhQO9DSzVIvS4/+oVdU3YnSsWDd5vLT1?=
 =?us-ascii?Q?b/+uHOoO8w4SfPBBUzD9G/Wt1f1kYS95j4Ii4/efY3mz4G0OmLtUHbbR1Cdp?=
 =?us-ascii?Q?S0hyppJ8T9rlNGJEhuyHr4ZEV6/UY7t0MqU4SNqYz7IK/bih1mfboHEf4DuM?=
 =?us-ascii?Q?2lJgN725BHgLto+YP4mCNfaLJ7IdhXiFk/OLnP4irBfHQI4BQ73K6SnD3L0H?=
 =?us-ascii?Q?u5pjCGMTO0vb7as3AtAuIHJgD3mZwGalDrwYZc4Rf21Eydnnm47o0Bmrvlqw?=
 =?us-ascii?Q?u/0/NOdQ2UcAEVbwFa6C1UsSOtf0u2U1H8ReovopZs15a7SFLevb7jhREitI?=
 =?us-ascii?Q?K/InRjsAywM7DSatlY7OHe+NUwapuRZYbjD5FnXa19QdwZMqm0q5UKVrH9aI?=
 =?us-ascii?Q?3SW2vUlNCB4RWejjtyrFFXpzbBZL2/EShjs0AuD9FOHppJtqjZJDuN7IVS6r?=
 =?us-ascii?Q?93vy?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:51.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2e782b-1ca0-4d92-f74d-08d8b02a1817
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzldXd2dTgMoUeVznKVZnk8mxDIA/eBnkfhVmD1v8SYr/ttuw/2fovjH8VnaY+CXnYdS9Hq1YW0tulWE/YhIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
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
---
 drivers/mfd/iqs62x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 9fdf32f..3b32542 100644
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

