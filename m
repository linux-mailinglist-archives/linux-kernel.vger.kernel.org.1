Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7868B2CA469
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbgLANxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:17 -0500
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:27975
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388187AbgLANxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REFVrHhEB4MTU8ZNuJVjYrRntoiaG1F5r1fN1iC+7YKnEra6YUcQGK/Zu4MnkgQR9J26ia3LtfW4OGk7SrEDrWpi8L8z4RSnJ9pXGcxfFV2lFpF/Lq/u974ksfvQUy+6tjsgt0Ur1JVlNdyUHEcwLxqFMxye0adE93uFBiMbreHYMdvZ3F/oct+aS86+k+JWgQCwBoupL0ic2JT766rchRqliQ3sOJfeTgZ7V/YfShGcTU+mg5/iYE0C9aw+cPyPdfFKoaag36U4tLkOBCgyzGrLr/z8UtE0C9O0UUDPIYrQYRd8GPzo5uVwd2bSO6BOnxEIXNypmQtImw6BC4yLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=214ZgoVw1jj62rObcawquy4Y9Pm2tW+lqHv5kF0O8XI=;
 b=Gbqb3o9B2qs8gYdurl9wDqnKMn57ZzTnf+AFqT0k/FVg7qFlN7fVNInN0bGYJ/YrpipuA9b3jXnfYqqN6gPI9u3fOZjlOmCS9Sqw4nyXKqPC+E+XtjkwF/tN41kQZ7N90Vqq7h2ZUdPtmaic8EeocF5tNAIK3qhW+5rHge+lDQOCB2NuzqAGA6p/lnj6WMUd9rJ9C18NZlXvCDYrLXXdXjtbLiLRikFPWKg1YBOCougvG36Rb/VD48DTFoLNIWXCIdwLaFQHJf7ps751QyHgsghPvdfhbPDfgVPBb/t5L1OIycUKe7ok1Ymrx5CYV9JCgPRNh3ZBZnbENfX/UFNwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=214ZgoVw1jj62rObcawquy4Y9Pm2tW+lqHv5kF0O8XI=;
 b=ZwmO0FwlOgczWSjhxWwsOCNxFrV1jRF1/HFdX3GbkbpD7oE2+tr6i+hWgMcXPhbhcGRfrGsXXOq9EjQQ4n5elXZjPiQvkY8uSyDRvyjkrNNEVPe1jYXcV0t3M9EQSVFF97oxlkMheBONX7vqXRRsIBKNLnXLwYka3/rufrfS3FU=
Received: from AM9P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::32)
 by AM6PR10MB1958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 13:52:27 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::42) by AM9P195CA0027.outlook.office365.com
 (2603:10a6:20b:21f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:27 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:26 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 6B40D3FBBB; Tue,  1 Dec 2020 13:52:26 +0000 (GMT)
Message-ID: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:26 +0000
Subject: [PATCH V4 00/10] regulator: da9121: extend support to variants, add features
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e73e18-d15b-4377-524a-08d8960056ce
X-MS-TrafficTypeDiagnostic: AM6PR10MB1958:
X-Microsoft-Antispam-PRVS: <AM6PR10MB1958D6F653C58CCC3D5F4D7DCBF40@AM6PR10MB1958.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa0nbSSb7wyWcRfvnNz0RT6/xBjUE4tQB4lwckKKtW5dqBTj5a7L/J50Tq2QY5Ixrvg66JDkcoiKVvyyuPkkSt/0FM1cxjSEAektCRAZKSF819KCcX0PiPISk/RXnLY10uq4n/4erUuEe7oHso3y/BVlJK+qHHsxxH5BP6upqrIqOOuTGLdhnHIil8t9dkRdO/yqgJPfsca/0DMBxyUDs/nfLksEOyWDLRWowpLtz3I1t2sKj5X4jvYjaoCUO8n4UQvo0RfVQ+0LesfOwOk6+HkZXgiaIBkaHR/xjgXK2ghAcJGi8c7i7zVo0VA42YIVbeho9c198nvdSp4dYCAGyiuvrbSwgE0Gfup7KnHy27bZr2cHbnsUkfP/qMqArb9w8W3xG/nES1zZj+hvTRWC134r2Q5Uu/tp8Z5UjCxvVvlcOrz2dRgowiwiYfDbTNPz7Zb3VOnANBFj9wlByWjek7BCxkHrrtdlZHj1+GAImYA=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(86362001)(54906003)(36756003)(4326008)(2616005)(110136005)(83380400001)(5660300002)(2906002)(82310400003)(8936002)(426003)(47076004)(81166007)(336012)(356005)(42186006)(186003)(6266002)(107886003)(966005)(70206006)(26005)(70586007)(8676002)(498600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:27.1054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e73e18-d15b-4377-524a-08d8960056ce
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the DA9121 driver to add support for related products:

  DA9130, 10A, Dual-Phase (Automotive Grade)
  DA9122, 5A + 5A
  DA9131, 5A + 5A (Automotive Grade)
  DA9220, 3A + 3A
  DA9132, 3A + 3A (Automotive Grade)
  DA9217, 6A, Dual-Phase

It also extends support to cover DT configured GPIO enable, current limit
setting, and interrupt handling for all devices.

The datasheets are currently available here:

https://www.dialog-semiconductor.com/sites/default/files/da9122_datasheet_2v1.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9220_datasheet_2v1.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9217_datasheet_2v1.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9130-a_datasheet_1v0.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9131-a_datasheet_1v0.pdf
https://www.dialog-semiconductor.com/sites/default/files/da9132-a_datasheet_1v0.pdf

V4:

 - Request IRQ directly and free in release function to avoid masking race

V3:

 - Restored missing DT bindings patch

V2:

 - Remove Vincent Whitchurch as DT maintainer, as requested
 - Use configuration to select register map
 - Split regmap and description patch
 - Defer device ID check to negate, not gatekeep
 - Removed superfluous compatible check
 - Tidied banner comment
 - Switched to using of_parse_cb()
 - Simplified buck checks accordingly
 - Simplified current/mode register/mask use
 - Simplified interrupt handling
 - Synchronise workqueue at driver exit

Adam Ward (10):
  regulator: Update DA9121 dt-bindings
  regulator: da9121: Add header file
  regulator: da9121: Add device variants
  regulator: da9121: Add device variant regmaps
  regulator: da9121: Add device variant descriptors
  regulator: da9121: Add support for device variants via devicetree
  regulator: da9121: Update registration to support multiple buck
    variants
  regulator: da9121: add current support
  regulator: da9121: add mode support
  regulator: da9121: add interrupt support

 .../devicetree/bindings/regulator/dlg,da9121.yaml  |  164 +++-
 MAINTAINERS                                        |    2 +
 drivers/regulator/Kconfig                          |   14 +-
 drivers/regulator/da9121-regulator.c               | 1033 +++++++++++++++++++-
 drivers/regulator/da9121-regulator.h               |  291 ++++++
 .../dt-bindings/regulator/dlg,da9121-regulator.h   |   22 +
 include/linux/regulator/da9121.h                   |   36 +
 7 files changed, 1513 insertions(+), 49 deletions(-)
 create mode 100644 drivers/regulator/da9121-regulator.h
 create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h
 create mode 100644 include/linux/regulator/da9121.h

-- 
1.9.1

