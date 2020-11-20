Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB76F2BA9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKTMOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:14:55 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:13902
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgKTMOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:14:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnbwPmq1NaqPOZn2kA8Z8QTneGMWxh0YUmMwcdbxPZ6YiQlXp7Ueg/Cak/CM6wVhWPIGRE71mIf+Bus4zXNo5uOAz7Wzh1yu/0IeLaQl46rRp4cJjSNbfr+qXJfawKKV+9a/m3D/JL90lENBOC4LEZzJELqKRme8+vnNU6CKZowjNS4XUoCRGZRgZr5WjHzAmlpcxOzTpi4uVnLqqnwMYlweMC4BsCZdh0pBO/6p+Gfqm0n8kG9acMTqzJmvGUWfXMBHAiGyRzh7vT7GiHlopw78THfY2rZ54oQuJr01DrKUQeR3z78kZdxQHernDNgIyU4B8HDCvCwGjECJuRdhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYXmc/ij0rt5cRtx95qGp54AaEW/ozkrfl5wXK1KCTo=;
 b=YlQgNvqeDAtzoGGkrKIwWpuc8SOa4SzKG/DORk+FH3ZTQ8Z1wCTW1HUpZvk/v2peECGvudaoFi9G3Q1GmaEkq2gA01c89k7X/TTzEBsQ5o4St/X/fMw1yeJ0/4TCdyYeO3NEsEPc1QqGgL2MpxX2YtNOY+6gtPoSWRFmva6sVZWdwrKYm/QXRxmkHqidraI+dLuVXH0gE6lgXzriDo9L/+RIJsz31acIAADCAUs664HyWla42GedlZJNlteS5Xb1L7a0vXXK3N1ciPJYWccx0Xwl23mKfAn0zcDDqeRvr7c3chUeSzZsdD9Ha/zTnFAXWfXaheW8FsijUZQesidqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYXmc/ij0rt5cRtx95qGp54AaEW/ozkrfl5wXK1KCTo=;
 b=Ga2b1m/SWCyxHIwa0/G2Ygnlvpz9/wnSvYdZA8xsy4vJHHZ2MM/fMN7eFRpZQIpqKARzDEQwrpnvNeAQABdPcdoF9bSSexIVVEkPLflWmAM1WQfzR4qIFJap1+hzmCfMf9mHoKqBhGBu8G8dnaStjDbPAybHmI6CpdRnJQNXyZg=
Received: from AM4PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:205::40) by
 AM5PR10MB1841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Fri, 20 Nov 2020 12:14:51 +0000
Received: from AM5EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:205:0:cafe::71) by AM4PR05CA0027.outlook.office365.com
 (2603:10a6:205::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT049.mail.protection.outlook.com (10.152.9.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:14:50 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:50 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 EBF433FBAB; Fri, 20 Nov 2020 12:14:49 +0000 (GMT)
Message-ID: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:49 +0000
Subject: [PATCH 0/9] regulator: da9121: extend support to variants, add features
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6122c161-bd79-49dd-5b5b-08d88d4de19f
X-MS-TrafficTypeDiagnostic: AM5PR10MB1841:
X-Microsoft-Antispam-PRVS: <AM5PR10MB18416478A3447A411E04C4A9CBFF0@AM5PR10MB1841.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYFVoe9/D7dwkqkAPCbQX1ytqgo8dvn72Ib4A9MPeHo+WFNijk+CVvySuiAn6ZIrQtFyWnJWUV1Yk6sEQnkie9YyAQkgxGWSICC8BHtOTJiH36oCbN/6vV/URogPxDSXCKJSNAV11XelRom2H0dP/iN8QeEMQWLEJhQHJAfJfzFNGbaglVbnmld1vHUsQMQZYwRY0zm0jFjnPTSwZL/YttZlt8GardM6DfMTU1G0FaF7LJlKE8Ez/GlcOowTHseyivTGmPx41eDNGCoRWcXh8ds6oYoV4n4Uuzv0SMCbESK0/Xq9LKAc9SHn8cXNFX9jISiRBDdejAyobEYFQyQgjHtDNeEAsj4I9isF5g03wKpS/p+GBwsDRu7UJE0wkRmIORX6O02BEZ/UIGq83SMm+2dOttAulA44NMWsTfpWLfbJ6shegaWuIxP2A7gjYLW8Ibo+INnVAmF+vadcVxHZnhwnD6T7NMOy/gKRelULDCIvgD7JWVFe281I99c7vpMa
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(46966005)(83380400001)(4326008)(82310400003)(6266002)(478600001)(47076004)(81166007)(33310700002)(356005)(966005)(82740400003)(8676002)(70586007)(2906002)(8936002)(70206006)(42186006)(316002)(2616005)(54906003)(26005)(110136005)(36756003)(36906005)(186003)(426003)(5660300002)(86362001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:50.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122c161-bd79-49dd-5b5b-08d88d4de19f
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1841
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s series extends the DA9121 driver to add support for related products:

  DA9130, a High-Performance, 10A, Dual-Phase > DC-DC Converter (Automotive Grade)
  DA9122, a High-Performance, 5A + 5A, Dual-Channel > DC-DC Converter
  DA9131, a High-Performance, 5A + 5A, Dual-Channel > DC-DC Converter (Automotive Grade)
  DA9220, a High-Performance, 3A + 3A, Dual-Channel > DC-DC Converter
  DA9132, a High-Performance, 3A + 3A, Dual-Channel > DC-DC Converter (Automotive Grade)
  DA9217, a High-Performance, 6A, Dual-Phase > DC-DC Converter

It also extends support to cover DT configured GPIO enable, current limit setting,
and interrupt handling for all devices.

The datasheets are currently available here:

https://www.dialog-semiconductor.com/sites/default/files/da9122_datasheet_2v1.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9220_datasheet_2v1.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9217_datasheet_2v1.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9130-a_datasheet_1v0.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9131-a_datasheet_1v0.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9132-a_datasheet_1v0.pdf

Adam Ward (9):
  regulator: Update DA9121 dt-bindings
  regulator: da9121: Add header file
  regulator: da9121: Add device variants
  regulator: da9121: Add device variant details and respective regmaps
  regulator: da9121: Add support for device variants via devicetree
  regulator: da9121: Update registration to support multiple buck
    variants
  regulator: da9121: add current support
  regulator: da9121: add mode support
  regulator: da9121: add interrupt support

 .../devicetree/bindings/regulator/dlg,da9121.yaml  |  177 ++-
 MAINTAINERS                                        |    2 +
 drivers/regulator/Kconfig                          |   14 +-
 drivers/regulator/da9121-regulator.c               | 1429 +++++++++++++++++++-
 drivers/regulator/da9121-regulator.h               |  291 ++++
 .../dt-bindings/regulator/dlg,da9121-regulator.h   |   22 +
 include/linux/regulator/da9121.h                   |   36 +
 7 files changed, 1917 insertions(+), 54 deletions(-)
 create mode 100644 drivers/regulator/da9121-regulator.h
 create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h
 create mode 100644 include/linux/regulator/da9121.h

-- 
1.9.1

