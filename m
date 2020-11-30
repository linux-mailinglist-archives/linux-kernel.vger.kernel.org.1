Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346312C8A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgK3Q77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:59:59 -0500
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:56480
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbgK3Q76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:59:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmoY+FqJwQC2hYqAzLxmcphQrwi4iHao9AGBd/uJUDkWfJZo2tn3bE2wV4tIZb62KjSmRGP4xWWg3bhCLH3qno2VKRz8twrq5lRL6dsW3QR1wLGEzquimluI4XybYmYGQGSFcecZrR+Mdd3YWgXoqXHuPOFJlE5tgroq4nrOGSVMvfmv3j8WDegg2CwdeP+1FZEz7vlNymeNozLE+wnGQa8oEhUV1abO8XJIbwcC3LfvaC92jsrNgNvc+UEqKT8aoPQnjJAOrSeHA0NkkLT48lL5BL9vB29LJrf1KFCOOKheygrSR5RZ7JJLRAUvlCw3DlWcGC3bLcq+RqRkk43i/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGX3y88JAV9u9qGMIGZmqNklJh//JjkJXCmFNcTo4rE=;
 b=gJvDjAVJS46X3xXAax0a5fBcvO9fYf1Vk8qt2jfLRKg+7sBOFroThDgEL4FmhgTmYTOCcN7pCZybFSloLTADh/YaErNd9PIRXk7EhTAdseb2mDX96RjherW/7E6txzDcB2xj8x32RdBYpjpGzLPVA2/RzAw3YR9MaCXb/KuhL4AmUaWF/IviLrrVx0JjqoybuYXhRXIbE2WwtiR/bf5urcw9wq2KBSaYxNhQlgi+s9eMuyFsbWhyv8NJaZyWh5n2TgQ2NeS1FgZWPqw5U392LGapLuUOX6Xy608KfyRIbki1V8OzlHCGZf01sBonK0betX+OAz6tX6JqdmYepYDrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGX3y88JAV9u9qGMIGZmqNklJh//JjkJXCmFNcTo4rE=;
 b=C9PJ6lrS1nbRrfpM2geOArKqfYDEmBff3Gmh5+EVUxGVy+UfWY7VCUqijDkxicLXpy7Pbpo4m4x6pWW7MaAnVuJS4IZb078EIyUQYxw5T5xdWd0Gzk7pmnRlFokc9J8quSRQ8DqZaiYfSwwoWy/U0COh/xIIc72WvUqiOBKQEbg=
Received: from AM6PR0502CA0040.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::17) by AM7PR10MB3334.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 16:59:08 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::57) by AM6PR0502CA0040.outlook.office365.com
 (2603:10a6:20b:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:06 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:04 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 AD5023FBD8; Mon, 30 Nov 2020 16:59:04 +0000 (GMT)
Message-ID: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:04 +0000
Subject: [PATCH V3 00/10] regulator: da9121: extend support to variants, add features
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a240e3-015d-41d3-d4ba-08d8955140db
X-MS-TrafficTypeDiagnostic: AM7PR10MB3334:
X-Microsoft-Antispam-PRVS: <AM7PR10MB3334C05A8C6BD4E1E5FABF8ECBF50@AM7PR10MB3334.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2wRFxHyHvxw+NrgisCPrct9PlDiUHdD+xEszWWndnXQwCp/qU8O4iMTE+LPkYIRI+pLeVQA04/F6OMoyfiMUuxcFCT59JxnwoeAGZQeemi7sK6B61BrXz1YCyQWPYFFa7zvKLVUDRdHM2cU7AL7tLRC1goxGo/203M6gPfatDyWCP8DNNP44xgXKFyAj9uU/tofZNHCLxKI1D2I8PrIeg76/0qITbgG8xQsNRzFBY9fwfFbtehHhUfr519dxU+XGNsZKtddaPOj5DWZMmHsRs6hq9HGWmj3YDNfbIHm89y0yNMtfKwI67iY0H7DmU8E/+oXbhx0rA+shuxnonjVycGNS6OFgcF8KMuLqWELeHZxc9B3Sc6bpVF4jirsoAHYJmxtfblcIZIVLoN7I0HC0hWRiX7VGngTFgTw6ako5JayP/Gj/oWiGQhXrroBEWiZqM1Q8JPnLDP/GH9yP6g6FEeGhlnYCyE4kExcFVkZdvE=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(6266002)(8676002)(36756003)(47076004)(82740400003)(2616005)(107886003)(54906003)(110136005)(186003)(42186006)(4326008)(26005)(316002)(336012)(426003)(2906002)(478600001)(966005)(86362001)(82310400003)(5660300002)(70586007)(83380400001)(81166007)(356005)(8936002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:06.9621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a240e3-015d-41d3-d4ba-08d8955140db
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3334
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

