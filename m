Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A62C447B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgKYPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:50:25 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:40262
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731643AbgKYPuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:50:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odP4HjGhMAcYrVdw3wWLFV4Fp5VR0j8uL+VyB+dBHkpcHawyWyCB2UC8t71pjSKUnJs5db7LT1d1OYH8t/tcbD8vwM/jqCbdNWVSzI5actunJ3AGaAE71FAjTW+SCguYAd7MTEb6hrnoMCw9VI5FbrNRLYU5OaEqyZGerUcmya2tFc8WJSLCPPQ/wPCpeeKwVwSGhdrngS/oHUh9riRXDBjNtWhe57luA3KRq0+hgn5vZDlD75QlXWRP9KK7eqPYHw/ou1PjPfayKDtAYY7z9Huh1Sk/+MXsCgwN0Y6E+UthJauqIhOjwt3/WVn1uOw/y6GlqWSHcHNC4i5GQ8G19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foaxRQHEJR9E5q0qG9jsk3ndAqyhxl7K6MEGCF7Tl3A=;
 b=VSECekDAqckeo9DTSRT9IuvYQY6zpimIFILnJs80jypdSt/PT0Hz5qLtnHfMuZX6x4OrjuoXBeWNNAXAbk9R6xBB942XIl02M2V4mkRSjaM9MWuJQKGjG+myNRTqoavpODYIRUWSlrsRJIIC38EUNeru6QOSYUp0ftbHJDV82TeOAlHk/aXRfD12Ww/YLsrMZhGkMcriDpCKnJPJyKRDmHl6rY7dLV0MKCyob6mWeFiXMKqh2bckT30P7AL5pspSKgMLej77JVHkHzzdtDGteXGlbdYJA2/zG3eN1oz9XLhcz/Pp37PZiR/9Cn/ifIKa8KIwtRyVve7R11l7dbvgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foaxRQHEJR9E5q0qG9jsk3ndAqyhxl7K6MEGCF7Tl3A=;
 b=eZFVFID5eMn61xzqOMy7MqAybfcZoN6+NdsWSdx/je3j5mRvUA2hIf3lpUqYJT3NAiAwcH8eDD4bPqFS0KfxsJ0hYN39m4xOW862v7ivI90IYX56H7wiTIUnxsrqsuMcOUeOl+/ba+yKO84YfQo5DP1mKrwrSjdr9vg+RHFCG88=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0401MB2528.eurprd04.prod.outlook.com (2603:10a6:800:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 15:50:21 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3%2]) with mapi id 15.20.3541.028; Wed, 25 Nov 2020
 15:50:21 +0000
From:   laurentiu.tudor@nxp.com
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] iommu: arm-smmu-impl: add NXP hook to preserve bootmappings
Date:   Wed, 25 Nov 2020 17:50:09 +0200
Message-Id: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 15:50:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 259b249c-fc3e-415d-c867-08d89159d02c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2528E783D95510E8B2158728ECFA0@VI1PR0401MB2528.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upHxm0iseRGaDC7cJ8ol0Z4GohtN7IADaXXfy8uGPxBx5czda2ZBqZN6LjmA1pcpsRrYenEqeXolGv3uRgBoSlfhNPSJQUAUEIMtj+BryBsaU/gSkwEskwCpd1Y+WSZP7BUUWUY0ucJZJUfDzCzRw+XHncgI4S1aHWH7ApOgOgP2AyJqsD0pAME+MlF1U5Kbe2q40jIul0kS0DLhjM4x+tmrO2MnKuHCl8hTbyRuUAV+s7hF/S7CbTZN/fRpSpBqOTIxEQDcdN6LSDE1dJ2Nx0vODgVN0ReTuKxkLIdPjOQMjAIbZg21aHkJb3u+8EuDmQicz5naTmTYYWCM4Qq9Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(4326008)(6666004)(478600001)(6512007)(9686003)(6486002)(2616005)(8936002)(8676002)(956004)(316002)(52116002)(83380400001)(6506007)(5660300002)(86362001)(66946007)(66476007)(1076003)(186003)(66556008)(26005)(2906002)(16526019)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AOOXeWma1aBhEeIgmcB4RueDLv6SK66drSGyuWCsIXUHabb5MU8nju61+UsibQLfpd8yQGRvKk2VWHOcYKNfCgqoxf1fgGInV8qSLn5Z/Kg9kwEb7H5yo9HFq2dm3KQvzkCJtUZVZMVS1VEwl0MHLk41j+xTt6vPBQk6WtwhUPNlK+Tf0tg/wp7BNZ4t9Iq3qj1r0HZJa0dq3JyXWNFYIXWYnltQwGRiyTfBWuU6CrXInpLMwJd1oRXjrC9haL73ajZWIG1BYkZ+ruvWiTFKIiGNrJtrlUkpnnIbH68mMh0D61xUFAwFtLz6WdqvUhyL/XSHdHSwdhUOJKRscQAVEdxq5nQSkQwjxWfBum8HWNbYR7b4TCYFae/QVUoOudCHQQkcz5SWtXh3STFRAJDhYcVHtP4jPvgon8ihESNpK2fxBfIJFvPFvvYmOuPpilGRGMUOdytSjL5AhGLfdwvtUOTf5NntHOE4/3rtnKOzV0XXnEgQwccdil6muQ0cuNeCxiGswrU0894geNy1TpJjv7i00GwNwWh7j8g0+fkcxTrRCK+PGP8PvFlG88JDh1sC3GvAktf00frCiefNr+5KRStKq3P/sy/ET+i+727ORHtK4pmpesUB2cHtOvg9/X0IE31RcPMN1alVS2JcawVFtkyZCFeEpE3gfpzW6R0klpExKJBv1cyuGqBl4bkVv1UlqQY+6lpXaTuVdb9YHkpadqs/36SPATOSbAQMCG38q39ZSO/jwAbv8xUc1j4+mnnelmDxp+4HHKLwMsY3mr5k1eYUBDdF1oGzW3cmiUawnHCb9cZ2QDQpBFonhNI32if/2+eNSgPnEXZdY2L58fcdBwjL9UTX1TQAu4SLkZ1x43zpRW344cvR9oVB8BvtMgV71XpffwAoxCHI4+gZCiEEMg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b249c-fc3e-415d-c867-08d89159d02c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 15:50:20.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAQi2rNf2BaGPDAvYeQBr2YtM+pTDJUprepg2Tilxwku1vNm/bQu0YvnYh2SvC+PO2H1TA9jNVojwd2VR2Rfeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a NXP specific hook to preserve SMMU mappings present at
boot time (created by the boot loader). These are needed for
MC firmware present on some NXP chips to continue working
across kernel boot and SMMU initialization.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 7fed89c9d18a..ca07d9d4be69 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -187,6 +187,36 @@ static const struct arm_smmu_impl mrvl_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static int nxp_cfg_probe(struct arm_smmu_device *smmu)
+{
+	int i, cnt = 0;
+	u32 smr;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+
+			cnt++;
+		}
+	}
+
+	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
+		   cnt == 1 ? "" : "s");
+
+	return 0;
+}
+
+static const struct arm_smmu_impl nxp_impl = {
+	.cfg_probe = nxp_cfg_probe,
+};
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -226,5 +256,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
 		smmu->impl = &mrvl_mmu500_impl;
 
+	if (of_property_read_bool(np, "nxp,keep-boot-mappings"))
+		smmu->impl = &nxp_impl;
+
 	return smmu;
 }
-- 
2.17.1

