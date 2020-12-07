Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B52D1753
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLGRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:16:41 -0500
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:7169
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbgLGRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:16:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwRfbNhIfpsadEbT9HaZNcDsKozU1NkHvKHyGgEHYeMMRo/KDijNBRu4O6NJR82j4VIMMify3M0Cp2L5KxFAOEqIS+FYO4Segb2spgEa9s5dIS56NmC0rwWduOd7qNOuP4ZRJzn/SdQhXGt4NSeigkqzZEHLXhviTKnLd3FPDfr3er3Iu+VcDPHddvWJ10UD1/tvrhkbI230u5jIOnnSxHFZMZRWeYwYMXEtmr6rEQXw4/7YesIOTjmvoDrd/CCvro2l8v2Z9cQ3I9oCbzERCpom2l8b2H1NFVaOUbFPqv5CBojrCdX1CJLdfVwFoXf6IhuJQ46NV5tFfxEW4G2yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbYPgJQR4sBdBUhttzxAXW+5YpyXotqu6kXXcvWRr5k=;
 b=MKb33kWtSpI8UJEekaoWqvQBnMV3FQu623lOb1alKNPF2WBBoYEtg1hYUsYulwhR9frj0no4rBLfdwbaNVx2zRdwXWIJW7QDw5xDnRCAegaElVuwiLOKlJYyPlJKf5bcTUgNijgPjt/hszoIXm3KP0ViRFSx7o4qB7a2/GLpWcmY3WpHmtp4tQWJRG15LVTOvYhYPIAc3Qch0OxKplT72l9qgReD+gvEk/vclZhjn8PI7bKsD3EX6JDX57MyLn9vmvTueffOSklKMJJexiJeg44nKnpiSnDvt340SAJUzRvWWNrr3YwiSylgy6BCjQEwE2d3wIe9EDEGhi9bmtVECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbYPgJQR4sBdBUhttzxAXW+5YpyXotqu6kXXcvWRr5k=;
 b=GrosbWiPov1YCVK/LYGnrawKNVO+R6hrMVN1LgBkFU7lhFTZxGcN5qqs6UA52P2LyOZBglF9lL/IK8QM2ALO3wQtyEKo+GMHIvjZtsJoozEBCHW2ZP/j+rw6WuYUxX/IxPuG4gqubRn6xTa28CE0SFNAVGgwZm33CJKgJuXaV9k=
Received: from AM6P193CA0124.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::29)
 by AM0PR10MB3508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Mon, 7 Dec
 2020 17:15:52 +0000
Received: from AM5EUR02FT022.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::45) by AM6P193CA0124.outlook.office365.com
 (2603:10a6:209:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 17:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT022.mail.protection.outlook.com (10.152.8.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 17:15:50 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 7 Dec 2020 18:15:16 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 29E543FBF9; Mon,  7 Dec 2020 17:15:16 +0000 (GMT)
Message-ID: <2cf324b68d37c4059c7995e8cab5fc9a608ea65d.1607361013.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 7 Dec 2020 17:15:16 +0000
Subject: [PATCH 2/2] regulator: da9121: Fix index used for DT property
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        "Support Opensource" <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b9fa68-c890-4165-0b01-08d89ad3bf1e
X-MS-TrafficTypeDiagnostic: AM0PR10MB3508:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3508CDFF790047F8B1F0F213CBCE0@AM0PR10MB3508.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSAuZMg2dwF2R8GIAc/iRVIbb+HnQBlujduoIfHz7lLTPJ+iUG969WZutB4CrxTPqCf+aeH1duoiEx0Qfv2i8PKS1HGdiBnWeM1A5ZZnMmQv9nyn2yuuvdQr8k6av6iouvLjI9Ltdaz7nHWAbc1U6TATRmDqy+Gjh0ZFz3UP0USivyuF6TN93oUVgunpbdi2ceDYm99EWmpzjIdhoRznWDsO2y+8XhTRPlk2L538s3x92lfkI3uEeqcK5LQkCZWlsnqJ7CLfyTM7gGuyPtAU1rGwBSzYnsEouEZ/I3Ky0sgBOZ7RhDX1txNb4Hvd27JXPf1/Qg9Vp6cATF1HO+mkWQBbLSBS1xERL78SmfsEJaopCEv17cP1gFdQeqhxOqnG0bK0fBPbpp94wIRGZ9tdeg==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(478600001)(8676002)(6266002)(4744005)(54906003)(2616005)(83380400001)(47076004)(356005)(42186006)(316002)(5660300002)(107886003)(81166007)(86362001)(26005)(186003)(82310400003)(70586007)(426003)(82740400003)(8936002)(4326008)(36756003)(2906002)(336012)(70206006)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 17:15:50.5400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b9fa68-c890-4165-0b01-08d89ad3bf1e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT022.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3508
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index ed68259..9d5b02f 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -381,7 +381,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 		uint32_t ripple_reg;
 		int ret;
 
-		if (of_property_read_u32(da9121_matches[pdata->num_buck].of_node,
+		if (of_property_read_u32(da9121_matches[pdata->num_buck-1].of_node,
 				"dlg,ripple-cancel", &ripple_cancel)) {
 			if (pdata->num_buck > 1)
 				ripple_reg = DA9xxx_REG_BUCK_BUCK2_7;
-- 
1.9.1

