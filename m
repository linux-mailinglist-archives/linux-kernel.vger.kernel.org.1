Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905482CBB97
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLBLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:33:37 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:2242
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbgLBLdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:33:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4vrD6AT8ULwp2LumINJcTsch7Rki9EewJPO+JvGLvbnaXW0WiE2PI9IWZeMFk8s3eZagUyhRNi8+pdoKJ/XYOVBRgLETMuuiVOTV5mU2gE6+1nnVKZ01b9BJ5cvA0SrV+6HHehqcC+RZM5GJfZuvick9tEkFlkgkv6Uci3Kh1N7ww+kb8AxKsUSHEd6wMKeJ0x3msuuVLap40o+PflWSoqdMfGMSzVaebD+PfFkXqDx5Su293n0ljILGUok3+Dk0zmOOM4NFgi7HxxKDfDBxxUkgIMwXELAJFQaX/cXSSE0xWjcQFIDX+mXNadIOQ1xb74WX6OCp0gmXuraFmQ6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuGdlOSE95LJUwj235OkEvd+L/aQpUBhMCUebhoaz5E=;
 b=SxtccFzlQS3XZBY5m5dsG1GhWDPhGHwm7CCkGGxB7MlGPgZoaex+9oUrpd5lzfXtkoIzTCbVInv7B6ErqAlJjDZWAdkVbhuMkRRbTue6Q11LWmij3AUapCsus+w+fVWIpvtEf5DCgPBMwXa3tSRiHx05di8z4cAzsAo+6AVFPCCLrSKCdfMReYctfK6v+Sukw8XIaN8XYcEYTB6723Ag5Om9eTPV41QCCmOCC8IKKTXTxD6tDNa0YG/ws79wwZ5t7xmN6E+KMBClYVcTw0R6fCq4Ps/YDbTAT55YJeetn084Pb4s65oLYZS8fMdz2TaDfS3e46KG15PQBG0Z2SbAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuGdlOSE95LJUwj235OkEvd+L/aQpUBhMCUebhoaz5E=;
 b=KAxySqsIZK09jYmYCGRSeiM9m6O++Peh+4ah1sRByfvQhZpPrgfEdoeznNfwnFEJIAoi5jZwblnIXOpEMQoC34Y6Y3U5Br3dOgGxomew5DlwMdV6dGkAsCdEmOdgMFaZolKV/sNlVqE2JxVmEEpwSMWBqUb1tNiMUIUxBOslGYc=
Received: from AM6PR10CA0069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::46)
 by AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 11:32:48 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::fe) by AM6PR10CA0069.outlook.office365.com
 (2603:10a6:209:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 11:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 11:32:47 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Dec 2020 12:32:46 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 D24173FB18; Wed,  2 Dec 2020 11:32:46 +0000 (GMT)
Message-ID: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Wed, 2 Dec 2020 11:32:46 +0000
Subject: [PATCH V2 0/1] regulator: da9121: add IRQ free to release function
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae842c19-8687-4094-161d-08d896b5fec5
X-MS-TrafficTypeDiagnostic: AM6PR10MB1877:
X-Microsoft-Antispam-PRVS: <AM6PR10MB187798D54B2EBC3DECC0433ACBF30@AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqNlTYHnb23Ytxzb9IMQi4zpoPjlXEupjUbh3mQrS1vxRLHliYGMKpea+WCQvw4CH4G0Cy7ycsPVdtUn0WmUAn+0k7vvesgVs0lH6gmC9VbmZVnV3ZdjPoMhcXzyZPZsm3etZ59UmODts8QQNCmTlEqgBQkaY5/iyKIli5jDzYCKaLTnhrqSnUdq7GEBpxX7wLoHTA2zdo5tHdaHaDQ+GHxtY+z6N4L0hKHrIjY9zAIW7z0IQzjbg89Cglh+qZbjwFLQE7ZKsAKnkb8BMIyfAiMMacSZPqJCyDc4rWaOeLELydEZATez1bQ1VtIluWT20pavYybmUrtodOoKThzG52F5vswk4GARxD01TUB4WcssEeO+mGpxEX3aJm5RbViCBjIhKf6UE8SUYO8g8DGWug==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(6266002)(54906003)(4744005)(26005)(2906002)(8676002)(82310400003)(83380400001)(4326008)(107886003)(478600001)(8936002)(36756003)(86362001)(186003)(110136005)(42186006)(81166007)(47076004)(70206006)(336012)(316002)(70586007)(5660300002)(82740400003)(2616005)(426003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 11:32:47.7032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae842c19-8687-4094-161d-08d896b5fec5
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1877
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the DA9121 driver to disable the IRQ before cancelling
the work, to be sure the IRQ doesn't restart it before all IRQs are
masked

V2:

 - Fix to release IRQ if regmap error fails probe

Adam Ward (1):
  regulator: da9121: Request IRQ directly and free in release function
    to avoid masking race

 drivers/regulator/da9121-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
1.9.1

