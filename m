Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254DF2CAA9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392225AbgLASS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:18:58 -0500
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:56982
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391625AbgLASS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:18:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIJzCMVqveW+Ji8llwNzwybbZEoFcNfhc2hwnE1IivOXU4xbWdF0zU/r4m/B07AwLN9oOdGHU1nzCZYKUTRZg67oH5WGR/bsKKw65v6VWau8X6iylRyWbVJVUMaARs4yOgKWQstM2Bd0X9OdyjYhRVGX1rl3bB6phB0ArcBDR/KSNeO/GZORQja6dY469Dw3iuPL8GyHMGJYWxpL/1B8CbKv1jSg2w/mud083Nn1wIq8eKk29fKOi8mmbt4CoJdww8gXdBHenNgzxpviMtHrVdV6d1cjCb8k1yDsYdJb6INfTc/wmON8al8b/RW4/klYa3mDrq3vIbpd5UamcmHlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niz7pPJ/JSbxO4LND6s7Mt3m8qqpMe4vXxK653L12Bs=;
 b=AfIen24DTKONPuZdAtbSWgHrEMZVT0NR13GOo/tqbG6J3A1wjjxhJaB9qmVwxlPQbc+2jxhjYG+4BNPI+3iTJciShGVIegT7fnUS/eJ23MhL92QLkM6dl+AC5yGxFGnAYF0txTf0GJTbAGT3BBI40YH6f0vR0VrR+HXxHHBOpoWmC5ZU6ioj2RVPy0P/ZouGSMgZxUQseWrxumewfXzT24qQYVKeWLzaNQPY1Aium8CKSNSNFeF/q0/dSh3stfhAON4rRPNgiyx2V6Wehl3eVQOmE3Z9UdkCZZ0ysydHZOaSH5yIDD2T1sjwIHlkCxDKcelRPKn1UdWnt116mo/nyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niz7pPJ/JSbxO4LND6s7Mt3m8qqpMe4vXxK653L12Bs=;
 b=qinAueiK2aLOj8pwexWEfbiqJzyzZM11bLSdUZsR8e3u/221Q3jlmzVAMzJBpSSVx2iQR3QmA+mg+lvBKRUipDBJiomXR98od0AnbZoYyYdPuRZpto2OIWqP2l9SsEgVAQZ94csATIeI1NZwWt6TVElteQrY6I8IyTQISGAdSW8=
Received: from AM5PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:203:91::15) by AM6PR10MB2822.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:a2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 18:18:07 +0000
Received: from AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::2a) by AM5PR0502CA0005.outlook.office365.com
 (2603:10a6:203:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Tue, 1 Dec 2020 18:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT016.mail.protection.outlook.com (10.152.8.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 18:18:07 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 19:18:05 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 257F83FBE4; Tue,  1 Dec 2020 18:18:05 +0000 (GMT)
Message-ID: <2fa0d40f539d48fcab6695a282d33c2ecff759bc.1606846594.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606846594.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606846594.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 18:18:05 +0000
Subject: [PATCH 1/1] regulator: da9121: Request IRQ directly and free in
 release function to avoid masking race
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec6ab96-3fec-4d63-dabb-08d8962573e3
X-MS-TrafficTypeDiagnostic: AM6PR10MB2822:
X-Microsoft-Antispam-PRVS: <AM6PR10MB28227B3DDC32ED4649565806CBF40@AM6PR10MB2822.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaTDHSMLydxvMypmwvot1LNwR8EQtwX2Lc6GGv8rk938tCB7dG+gFMUCMEFtmlgAIOGUt7TOcQgm3CDay2hVRjLNYWxykOpeQCdUKYJpAwQkPRbsfZtz9n7TY3quE01U2j3on03kPujqP15zn2XvSK8ZAC4gWq+7qnXbuC0KrzyInlqnUBHqXkoH0W5ArY0ZQMYJiGrIleBgolC0NSQHrBG7X+qdVLaExKfOhTZte1taY+olTvJZqhGCWS7Ns6qvIQzavxBxFPAMiweUGa8tAt+PAHeWpPeyrLXoqxgd3GXDDCX5DbGUrs7E3igClBzO77fw/fOQdhrQgn5Ay8f60YEwmgZkYpWLun15WpiaiXMD2iwOCsUWi3eEd25gUau7eK1Jdz2G6SxcdBqsc7Cl3g==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(46966005)(36756003)(4744005)(107886003)(82310400003)(82740400003)(26005)(4326008)(2616005)(83380400001)(2906002)(6266002)(81166007)(426003)(5660300002)(86362001)(336012)(356005)(70206006)(42186006)(47076004)(8936002)(186003)(8676002)(70586007)(478600001)(54906003)(316002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 18:18:07.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec6ab96-3fec-4d63-dabb-08d8962573e3
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2822
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index d9a8a4b..3e59f68 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -945,8 +945,7 @@ static int da9121_config_irq(struct i2c_client *i2c,
 
 		chip->passive_delay = p_delay;
 
-		ret = devm_request_threaded_irq(chip->dev,
-					chip->chip_irq, NULL,
+		ret = request_threaded_irq(chip->chip_irq, NULL,
 					da9121_irq_handler,
 					IRQF_TRIGGER_LOW|IRQF_ONESHOT,
 					"da9121", chip);
@@ -1036,6 +1035,7 @@ static int da9121_i2c_remove(struct i2c_client *i2c)
 	const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
 	int ret = 0;
 
+	free_irq(chip->chip_irq, chip);
 	cancel_delayed_work_sync(&chip->work);
 
 	ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
-- 
1.9.1

