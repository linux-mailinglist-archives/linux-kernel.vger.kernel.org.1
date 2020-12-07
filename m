Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA23B2D1752
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgLGRQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:16:39 -0500
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:17024
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbgLGRQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:16:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3B0gsTJQZw6/CfZmAWGjRWGaOmf7902PUHF/BaTvCeDd8Pj7KAZFo0HA09CnKnEuQy0g1Z/m9usjJhkuycIdVDDCdCPfKdyNcnhNbPsBthpEHMMzv7U8+xdnw//H7j4cETekoZ3imQPWWBtcCCtjiMQ3OD8oZfMM52QBCnMFzqEgu404G4py+MTBVzD6V7RVX/V5DGUTQoYY4jhb37wvXIwvO1MjZmeeeBSb7RLM9rdGe1cyqPq0yWyCL4iBmZnfn6jNjpADuuD3DYuabDaFhQfJT/JFi5weQcjo4QzXbtNmmz/fVg8Fa7JvYVdWbvisjI/Bqzs6AOUXJDNy7tRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7GPNufJEK7X8atVFBLp6HXAk3Uvdj8lZ9vSjyAvAzw=;
 b=Xtqy5lnq1rtcD1P6CF5uINd0ruBfpBNCHChp/la58MgJEgpZXgwTKggkQBumjqBBugpdc/kkEibpWQSYfT9NAyvvy2kE+73uonk6dtUhM84lhZiM1jnrFDZlXN71d0AClvgmObkC0uIMY10At4k0/X4eYc4itGP48Z2CK7H8vFxExNv9KRZZnnvn8T4QX0kSkoHYfRoPFjuZrfTDTQFESuLamtEUIfPG9s92u8Z8d3V3jpz+HOzTnvmiOr8cAmHSST+ItfBTeN4XkJ76YWxsLc9aWO3Sh6oKtldZFaA4x+suqPb7TcHTMwJW3Zk51rc/hIldSV5hLkknhPlToso0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7GPNufJEK7X8atVFBLp6HXAk3Uvdj8lZ9vSjyAvAzw=;
 b=kTkvEgesncla/d480ol5KFAqXTMJ1NHuLpfFbVBl/oPapThBBVEadFT2rN0xijpbDNhllMVXtqfCxYmdQW9NzWPrO2bfi9dxjKbeonZ1lo105s7bZqYwpfRULxWVtqS3EX05HvSJ3X+PaQ8L3dNnl4IBU4KWIG298xuluizM86w=
Received: from AM6PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::28)
 by DB6PR1001MB1382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 17:15:47 +0000
Received: from AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::10) by AM6PR10CA0015.outlook.office365.com
 (2603:10a6:209:89::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 17:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT033.mail.protection.outlook.com (10.152.8.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 17:15:44 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 7 Dec 2020 18:15:15 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 25EBC3FBE9; Mon,  7 Dec 2020 17:15:15 +0000 (GMT)
Message-ID: <c7a9e947a9582fe0150d860b5eab7e093cd832bb.1607361013.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 7 Dec 2020 17:15:15 +0000
Subject: [PATCH 1/2] regulator: da9121: Remove uninitialised string variable
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        "Support Opensource" <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f08d0f11-1efc-4dae-af7c-08d89ad3bc23
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1382:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB13822CB43409DB790DF40560CBCE0@DB6PR1001MB1382.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOiCypCawlSRK9Dn+SWbuWKhnnCjkEuHtfBOsgXR+SjJhH9DTAjkHQDfjVXyXn/fky2qqWB4xCiJs8rge8tNOTWUglbPSk7DAtl+WQOb1HfKmyMluAbGNzp0KqnM7r7KW6Ry68XOoW+WHeZYVItNCbYeAjvg9TBbhhguNAB9yrh1UVmaMXj9FHm/bBtmDHg0qohtR6dBosKW0EWpVqtWM3lQ58ZGbOYTbiP+waR5w4WYWQC84fIuXnvqrBqe0RPtZ5NROCfkaKfd/26uN7nvI3tDdgSmWcfactcUhPZqJpQOPVKEZmCOwQxydU0pCl42Bk2VyEGY0YLB2uCmUHSsEWvKL+vqgXvmYOaKfUekupk7YNYEROodngZC5P/jbm3fIBhErqDmEc16EdFPVRETgg==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(336012)(6916009)(186003)(26005)(2906002)(36756003)(316002)(70206006)(86362001)(8936002)(8676002)(70586007)(83380400001)(356005)(478600001)(82310400003)(6266002)(42186006)(47076004)(5660300002)(426003)(82740400003)(4326008)(54906003)(107886003)(81166007)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 17:15:44.1765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08d0f11-1efc-4dae-af7c-08d89ad3bc23
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1382
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erroneously left in when switched to using of_parse_cb()

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index db1c2cc..ed68259 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -816,7 +816,6 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 	u32 variant_id;
 	u8 variant_mrc, variant_vrc;
 	char *type;
-	const char *name;
 	bool config_match = false;
 	int ret = 0;
 
@@ -867,7 +866,7 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 		 device_id, variant_id, type);
 
 	if (!config_match) {
-		dev_err(chip->dev, "Device tree configuration '%s' does not match detected device.\n", name);
+		dev_err(chip->dev, "Device tree configuration does not match detected device.\n");
 		ret = -EINVAL;
 		goto error;
 	}
-- 
1.9.1

