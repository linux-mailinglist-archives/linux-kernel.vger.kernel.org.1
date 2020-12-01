Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AB02CAA9D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392208AbgLASS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:18:56 -0500
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:31557
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388619AbgLASSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huAt+BbveUUF/DRPkWpH3V56zbWCadj+nLc+E+NlIa6o3EBa1czbe1S23rxKwEfoTcToZQ/bxi5j2OW1YI4q8Q4gZqvcUKJH15C6uN9uk4aN1IwO4zyhymc1Va7utc9KkKt27cUma3ePx07Sd7/rtrjoJVPT2k3MiX/vjJg8dqy0tety8dToQtvblWy/zYZZD4/B37C+MiwexCPe+LPcLzYF5WjubHEtfJAjaJFa0sY/QyhRM4qjoPAOOSDx1Vm5tC3Ls7oA3E62DzrQWZtwIEB6+LE4CfK3vjNeWHuxSMB8fCxc1+/hdQWF/jH5323NGF/BHEJ8NSANtp9t6Hu+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ov6epUecqUccjKtuFBSAQHITD/vuAlwRbMqZeZWmCg=;
 b=YkPcDYW9zZFc8PfsGiBj1PLXO95z2vPCiG+McjB/5hzDhKW/hNOT1k2MHI43wzWxjhT9XnQsM2Iw8ZlrtvyQyT7ul5n6zKwN5DOVtBHwpRKvzKqbHNf98sWDoX2AD1GyfmMPSL8SWVG3uQIOFq/UT6MOa+9uJ3ZDoYsR2WP14h7mU3PFpVpgIJ2p/T6tK81+xF7j1pvX/Hi01C2znkC2hVqBs1qN/i132B7CbWX/6/yB0F5hVNc0AHJa+ZtwPlOUKcJI6Wbkx72ON2L9ubgnIEB2He5GY8g6nlRmKJIe++kU8jiAGR/o2YOFhnfo6jUsENevxGslHAgJ7FB5XUihbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ov6epUecqUccjKtuFBSAQHITD/vuAlwRbMqZeZWmCg=;
 b=Hhrpe0I4v0mpw1Ku3u4OTvtwtiKK35ZfecjHT87Fx5Knv7NNH0kYvT7Ec86XsLjhVU5eqg8jrOx/zqPAh1jXdWw6lGhgtcn/zzLxmYqScqJWGwX4lsp1WG6UBEDDe+6Kf4Q2Yfroalef0dtkmlRDhz4cI+sPyhgouZPl8BR/4Uc=
Received: from AM5PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:203:91::24) by AM6PR10MB2423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 18:18:06 +0000
Received: from AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::c3) by AM5PR0502CA0014.outlook.office365.com
 (2603:10a6:203:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 18:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT016.mail.protection.outlook.com (10.152.8.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 18:18:05 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 19:18:04 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 22B443FBBB; Tue,  1 Dec 2020 18:18:04 +0000 (GMT)
Message-ID: <cover.1606846594.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 18:18:04 +0000
Subject: [PATCH 0/1] regulator: da9121: add IRQ free to release function
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24af3c8b-cf11-4117-198f-08d8962572a5
X-MS-TrafficTypeDiagnostic: AM6PR10MB2423:
X-Microsoft-Antispam-PRVS: <AM6PR10MB2423A4AD5A0E86712E5F4827CBF40@AM6PR10MB2423.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiDaZbUo7ijqZDrjNJdENmaFGj14BzEdWhqQvHSO20mKWOmogE4cUthJbXNBnvUrZD6EWjY3tM3wv9iAOIiQi5mmDAXf0pWfAGH2SSiPBCypIEkgnyU8S/CJI4siU7G0vaheSSqRBoYb7T5JRL/Eer8MHKddoK9+F7qB2TjH4gDzURCH3ghBDMIBQnjf4AHUrXsFD/Achkzg/BDVuEqF4mBz3/rv8ZavYkYvkUD6xcqxyBzkuR8UXFurMHU20MJVxMQ5y2pbMqYgwx42QwQQvTv7+NQRoRyxHLix+gkb5schgIhj2a+Km6ZtFi8G12fsZqegfXiPXFNSFSNj6pdMCAhsskeCK0Q97l2JHVxkeXqIJRbsjKziJqR97qebJMW2ThJCYYAndYccdnRrW1r35g==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(46966005)(4326008)(110136005)(54906003)(2616005)(107886003)(42186006)(6266002)(36756003)(356005)(4744005)(316002)(478600001)(426003)(2906002)(26005)(8676002)(336012)(8936002)(86362001)(82310400003)(70586007)(70206006)(47076004)(81166007)(186003)(82740400003)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 18:18:05.1365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24af3c8b-cf11-4117-198f-08d8962572a5
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the DA9121 driver to disable the IRQ before cancelling
the work, to be sure the IRQ doesn't restart it before all IRQs are
masked

Adam Ward (1):
  regulator: da9121: Request IRQ directly and free in release function
    to avoid masking race

 drivers/regulator/da9121-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

