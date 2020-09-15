Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C410E26AFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIOVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:49:48 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:29250
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727982AbgIOVs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:48:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T83+3xw9MbA+/pxS0RObUBrTjOysAY23qsmL2q59y0z8x8W09FOuePhByDaVPk4dUEJVyVz+HRmudyincj5bseZR+5GiUbdJX9VNCRgYA213vGjRUXx6VfDjbsHv3hOtbsPdaqDqAtIfoB10v0rbZS84RlQt9YK3XqiHxQp0jrz/1AzmU5Z+OYx3moJMguCIsfux6ZRRD+vSIVvCOIU00uE3nFftVaMkSDJQFFZS+KBBfb5xK6lFmMBJvyKicQey9uYkTIR2IFtUrG+jcrrlsBHWiDeZUPz+X1sRKXENzIQVO+cEJtgyiapddbxzrgEl/4Z1zpi5ZgID9yaM5Gjqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGNOiLXyD/8ixzt5hj5xxJiTfHmoYkBsmIRQmw9Ny9c=;
 b=PsQ4rrL3FtGJhSUhvhLror5rOAk1VylUyTVX8Ty7Cdzkq/1sr7vxRtkZA1hXpFMz5gHHz04Agpjrdu51qzyqL67gKbckAKkUNuG/IUgxxieWNQA3F3IxorXgOjR7oBPiBs1RCa/RzeR5TdfqGbpjRdb8YEREyeJ+deicvSuJcbJfThl7oS28E1LzPBgJMogtEQOeVh1tFyCPl65yF9l0pu+sSi6OQkU0S66hjdOKPsgkcjksmGyRgIZXJprsaA8X+lCwv9MrOUNg9te406uqFmipk4L8CaubaGJMYDHkU/j2y5i/PahNRq2ZY1/H8JgZPQw4DxeCbRwGAua9O1yCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGNOiLXyD/8ixzt5hj5xxJiTfHmoYkBsmIRQmw9Ny9c=;
 b=VcEYJsfUTVuU70FZLgEOTJ32gj/jYedlBm3MaYfMDdMSdvn6Ko1lBufkxCUrnW3gm9b6M+S3yGVYpGFTv1iujYspLMqac3sY0KlQ92omgb/2vjG/JskrkUzDaX12qaUc1WqVKFqlgkHalD7DUBQ1/qG5KjLYXbYHqiVQAmt9Fd8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0505.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:55::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Tue, 15 Sep 2020 21:48:36 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 21:48:36 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH] nvmem: core: fix missing of_node_put() in of_nvmem_device_get()
Date:   Wed, 16 Sep 2020 00:48:22 +0300
Message-Id: <20200915214822.6756-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0052.eurprd06.prod.outlook.com
 (2603:10a6:206::17) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM5PR0601CA0052.eurprd06.prod.outlook.com (2603:10a6:206::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 21:48:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fd0682-acc0-41ab-2a29-08d859c118f6
X-MS-TrafficTypeDiagnostic: HE1P190MB0505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0505FA4677C5C786870E81BC95200@HE1P190MB0505.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkWt3XyppSzFRbzMmLNDr+DTQkhsT/ngRbzjhicHIBeoC1UliIDY8zsJnKuCtA1kkB7KirfhnLyaVMylGkhfB8FgQWkem9/XlWtqHZLzK6lecFdX93qol3x7eirFTxhLX+IT0b5YXVOOOSLDDhhaeQttlqff2YzU3/CJKsurBvQBWAhQdKYBLwQXsJhvMQ634Vab2qJck63CZD8b5FXJ0zo6WtyMojQdMJBAC74RCSp8LIYo3PF8eqTnQ85WzI6nh/Sve0Z8AZB6LCIlqIa2JDBJS045quKT2gGek3AWhi6Vp+ByHuN6+FB6fvTCnl6LGlRKzZE6eSTXXDzNg1Eg3vtnrgMYcYT1HkBt2WTYE7+JfTgxNRZCD0WfOfrBIIS6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39830400003)(376002)(366004)(6666004)(478600001)(107886003)(52116002)(1076003)(44832011)(4326008)(86362001)(6486002)(83380400001)(66476007)(956004)(2616005)(66556008)(66946007)(8676002)(2906002)(36756003)(5660300002)(110136005)(6506007)(6512007)(186003)(316002)(26005)(16526019)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: s/YQYhDoFaKrqGHv218aSySlwmxCereU9yoATp2CcnauC5/QZM1IvFipInBaDtcpTcmFJoZnCFC1ZOsAcoz/Ax8mPMH553CcO9e5NkI9zRqStzJe1cHwlbTTMH7SALZwD9XNjSThTZIdiFR3I/9CFWxRLoNzlCnZXj6N4cE9hpnSadoYKwQzDmTR5ZTNJpG7GfBoGuTuGeJwZLj/RPnI6C8gGbzAldPVWWC3lG6beShbrwoWBAsESzNLT3iGk4d8/mMrccw/1MuG7OfDbeGM2Vv1H1HUHXcjpOf6XNjppVWx9oNKCvm5BH4/KUOkOrOC+GK153VNa1bGJEHQxvhutbWAPXniIjBJldXGeP8QmLjuqAjv9j9ubC2h8wrGZKWL1XNLruzxDqMgyiKBOCeIBnrDI+5H84CKpYxliz2NpTpr6VPHzhkFjsLVTvEGIYSCeLHlKQWKkgoqBU4O+RJKByAxh4DuQSOvcg6CUb7t7A6aZE/uyKTbKT5IQEP+YAa4upEUuxqPWFL8pXuHyqLv13ZP9455qeztU+GOhO+rkom2Fx0NX/wO6jJuJ6YoUqj/5S3tWkdN0f0mPCan3a/ASJB42unw1bCxN8c8QM2uZwmsRuk6tLc4PwqfYG0qDMAz5WUujKQ6QpbaQe1K0m0PYA==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd0682-acc0-41ab-2a29-08d859c118f6
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 21:48:35.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaZgwcdoOOGAcEcNL+Ot4ouf6oWuG9sk+IKCFNF83N9H2WJPFGsP9ZEBfNtVVw8zF/TBeL1txg8crsWie2U0VJnVR5SSWZogK35DsCTM5gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns device_node with incremented ref count
which needs to be decremented by of_node_put() when device_node
is not used.

Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..204a515d8bc5 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -835,6 +835,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 {
 
 	struct device_node *nvmem_np;
+	struct nvmem_device *nvmem;
 	int index = 0;
 
 	if (id)
@@ -844,7 +845,9 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-ENOENT);
 
-	return __nvmem_device_get(nvmem_np, device_match_of_node);
+	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
+	of_node_put(nvmem_np);
+	return nvmem;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
-- 
2.17.1

