Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453092C8880
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgK3Pnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:41 -0500
Received: from mail-vi1eur05on2060.outbound.protection.outlook.com ([40.107.21.60]:17921
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbgK3Pnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaYJ0GVRC0QMran+Bx5V9tAWPVtNYfMfKMMRejdumzDbG/uZ8dUaI9ZNA7MAgh2UJu+eshMmSQhvm/BmfzjtonxO6KSv67UZJ82jGfq0HUbAVOIFvu4E/OJqg/CFjkTcydmGWMcavY7hF+qVyi9R/SyzHGpYEbe8OcnqdOB7F/bxMyiji8nK4eCGyt/vUig5EWnWKtTQDR+TY619jgyjk99TZ//FzaRok1Pr+8IzoACj+FSP4VhyapVjQLUqc9VPIk9jdplEm8lyn3SOo6+HXzvOcxwTk0dRyMDOmY54d6Z7vs4jqmXNHhfyJ+Ry2irKjSf0xZus+3VrGXWQnExiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0CEOabynDZ6zT7leOffTzWH3mZf81SF8Zs0Y/XObaY=;
 b=Pwxq/DgZWGyGuFOLfoHX62kZvNlBEZ9+VoRdW7lEFgG+LxTUfAj06jz16au9mTLKk6mlL3k5d/MhiYDi+wtm7UyVQUI9ryhaSg4dsyYBgidorU/XatCoAoGPCQMFZLH0z0WOWRWWFzUBxjcrsTz6013XqxIsjovh1YddTRZtUdcKdX0QnrI6AAjpCd3w0Ex3aK+XAYBmMFr/p3nhvDFkWCB1hg4Je2BUmnNw1CX201BDJPhCGMh9F5foWt4/OsgoqIkUYHuQre9G6Bd/wf0KImziZh5MoUpklSf9r8IC8YgAPWCJLJwLnBgEG7g6AMn2g7+oHH8JUj2B6+5eHhffDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0CEOabynDZ6zT7leOffTzWH3mZf81SF8Zs0Y/XObaY=;
 b=rGe85spZBYZG/cDnWADs+Z84y9JK0S/MPWVGL+6aXMvf9IBzSqGbykMWlYQXeUg80Maz1KpviSVf4fDz+pNcUUYfoeErPMl4vu/h+jZS1/BYEcI8rs0wVZ6OlAsjtc2OFvIgcD8rfa0y5xeR2aO4fRFOeOYAGHd/OUY0fNTnnyE=
Received: from MR2P264CA0184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::23) by
 HE1PR1001MB1065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:6b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.23; Mon, 30 Nov 2020 15:42:47 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::92) by MR2P264CA0184.outlook.office365.com
 (2603:10a6:501::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:46 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:44 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 9F8113FBD8; Mon, 30 Nov 2020 15:42:44 +0000 (GMT)
Message-ID: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:44 +0000
Subject: [PATCH V2 0/9] regulator: da9121: extend support to variants, add features
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 120986f2-e3df-447b-b805-08d8954695fd
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1065:
X-Microsoft-Antispam-PRVS: <HE1PR1001MB1065B5F6FA2EEC6E0FD27122CBF50@HE1PR1001MB1065.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4vy1CnNKas7c29PViL1AoLixHN0wCjf11cBt0roPoKONic3NhpvosQRF7qj0yeaTY0xCeabu6bYc+ufPvEakRDtNnMZWRlr4TriMcQWy9AeQDDk0f9O0zYb7x3bKulK3JeXWTVLjL7Txn512XR8TIIGYKoAoiewa8LGg5p5rJMPmE3Bw6s0WOp+4GMXfi2Q9Htm2WW/cmGqheSzt4vb1DmMVAplPOphK02N40o2LkG+nDqiEbMvxNHywu+ihvuE/z9xQ13PP1yYUW2/7+wMONCHHBup9qSeDhy4yUs9HYG9XCpZSu8KvG5gcDS+PIqnGluZlsBM924BfuBaJsROtpiOgdIyGEW5o5nGzuIx9KNLIZm7smVUWPi7drlCCrjx7OqyWeGj0Yeh+cc9Sxx926yYkvcD85fkUp/5HDfriTGIhH15Cpbz041FP/JgIbIadmaxFAqZpeEnOJDZZmodlAoC+N1fNhWRxdl6S6bF62o=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966005)(82740400003)(47076004)(42186006)(316002)(6266002)(4326008)(83380400001)(81166007)(2906002)(26005)(356005)(86362001)(8676002)(36756003)(336012)(966005)(8936002)(478600001)(70586007)(186003)(70206006)(110136005)(54906003)(426003)(5660300002)(107886003)(82310400003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:46.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 120986f2-e3df-447b-b805-08d8954695fd
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1065
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

Adam Ward (9):
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

 drivers/regulator/Kconfig            |   14 +-
 drivers/regulator/da9121-regulator.c | 1033 ++++++++++++++++++++++++++++++++--
 drivers/regulator/da9121-regulator.h |  291 ++++++++++
 include/linux/regulator/da9121.h     |   36 ++
 4 files changed, 1336 insertions(+), 38 deletions(-)
 create mode 100644 drivers/regulator/da9121-regulator.h
 create mode 100644 include/linux/regulator/da9121.h

-- 
1.9.1

