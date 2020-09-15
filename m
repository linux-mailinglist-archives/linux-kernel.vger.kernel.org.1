Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C74C26A591
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIOMvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:51:12 -0400
Received: from mail-eopbgr70112.outbound.protection.outlook.com ([40.107.7.112]:47021
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgIOMmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBQ1sF5nMMHeQPF/VjLUg1pZfL3XPw0wlhKzHA029YqSDbvGDMSnjPMQiCmTqfkRQGArn6XNzWzbGjFt+6ppG4F5W0F6jA72/3N7mWactqnXERDldMALEhBLxVjqUmVtfH3lkcz6UK0jDvEeDVcMqHwR9B+KzicFeSNWV1z2QbowNddy4nHPjBlXMoro615BdCliuoPVsKXm0uZToa6FC0NXVqGjwWfjKKxWlKNTwsM2jphB8rJCne50avgLfIwYHDz0+hPxn3Vxy0lO/5Xv27r5brnQfA3C/FRrvPYq2cYEGOmVQYwLc2zohAQO8oeZPQ270U8JoAyHY5XwgnTlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I1YvclSxKIOt3/5RTS0SCgIH0ZPFVHj/gF99L5VhJs=;
 b=XinvuRKiZWOU5EMcBEOfvj1tF6CJVrJ/eycI6Dtcc5E2MP6iNgE7JqLyKaRf4JFE9jDWXUdFouom6ZDdZ3xp2ff3y6BkafeEltR+pcAVUJ/ZfOLzHHSEgSG+3HUviZrEQRo0emrswLa58U/LGNgxYkak53v5O4BNAZeqW0XR3p3/rMkGdZAnd7Kdcb6LWsGQ5o+yhkjyEqj7zySIYsEa8mp+G+gDA+8AA5zeD8rZytrVCetRdtu6C31yLoKIPkDU7z8nEvioHR/CRdtD8znUG7X+Wd2S0hmO9dL4vPB7OTTiPlyNoVYbHYe8kfjhSADDAOpOQahYfUVefs3+CxWtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I1YvclSxKIOt3/5RTS0SCgIH0ZPFVHj/gF99L5VhJs=;
 b=Xk4txfAC8zManhLGaoYcDYRJvxomg2ks6IXdm4SBWmnd5dNxQxLYQeFE1oaMR0SNj9i2nO7UVPuij+DTt8uY/FMH3uBxS9/OVmwB/JbeF87P3+zbKqiAGrufpdwxePb+pu855VZQbtXGeEGbXOu5x/T+FJ5CqOjbnQt9nfYxfmY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0298.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:57::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 15 Sep 2020 12:41:53 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 12:41:53 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 0/3] nvmem: add ONIE NVMEM cells provider
Date:   Tue, 15 Sep 2020 15:41:13 +0300
Message-Id: <20200915124116.7196-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P194CA0033.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 12:41:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7800507c-da4f-4401-00ab-08d85974b91f
X-MS-TrafficTypeDiagnostic: HE1P190MB0298:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0298AE1552D001D81FBCE9F995200@HE1P190MB0298.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MU1MfNlb3KWdiYztAZP1prEZTc0ypW5EKgsQVHpqgxpIjUlFTTrqD9PVprslLYS6l1KKKmAkCQ2pGg7Y2ILxJ/KhL5n0QVczyTI2Ibg+6SDN7M2PTH9DhqZuvdBzxqG2Ud6O9wT0ZqpoU/zak6II0CNuzsmRKpLI7XXajL7dmnhYfI51L//EzCUf8k/IboTpdGApLB14eTY4f67WqfVcaDMCWKoo+wWNGVhuKSBx2xA6pqPsM7nk2mpvKym7Q6L2Q67waDCKxg1RhpjxBGVjZroiUIgY5WcQJoMVWl/P95QsPtR09C7ak+GcUt/iNpb8yrgEUgrW2aIa0aPY5oOJCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39830400003)(376002)(396003)(52116002)(6512007)(6666004)(5660300002)(110136005)(16526019)(1076003)(6486002)(86362001)(956004)(2616005)(478600001)(316002)(4326008)(8936002)(6506007)(36756003)(26005)(66476007)(8676002)(66946007)(44832011)(107886003)(186003)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Vx7n1uI7UiJ3pK0O3HpP9fGMIBjRP9qJJXfcJl5NBfgZCUXAYctUFNRSKTdq3GDQJIYL6JUFTBYyAoNznaQdcuuiv9sVOIkVUYcNx6Z6zhw+3zXF/ohPBPOOSIbfxpKJokBHb2jYJMGCRQ5DpEs5kSsJlDBVa1ekP+rHxHq7mn4iFSHpMFgsfF4xHFQLEjaMzCwUPPL1p5g8/LTc4RPYYUN9UEI8VaNrdjajA0k82pOK/RxIFmkPEcKxgBxpuRjujcp9WakiiblizDcx1ZP7z2tM1AhzA8ySV/jAzqRwLT1Pqj0lbQ7AeHenKxuw31Y28E5O2rSGhYBjLyxYRftGeFovv0NSKl7AChFCuwQXAoDDEKfzrFq/+2LqDDGgHzgVZ3YlTMUnJzcklP49emu2XiK4RAlycEdhDUinPybKJXE70sYpcLSl8SY0Cudv95ihXM5LjuTgMB3tWPuZp/zF8rR0Haij2fyApBtPwUizIZd+OlX9GeZKU9XZGTN8/IjlNK0HbD94ZQcPrFXE24H40YIY7mzGeYE+Adx2Ld2VDtF1+EHfsbLtcBt3Q+gcsrnxVa8rik0Dns/fDkrjcaxVPAyBwXV873YG+XgFXqbhl6eLDrDH7ct3TAJ9r5S3wzqTtAe3adDYi9j2A2i6Eyug6Q==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7800507c-da4f-4401-00ab-08d85974b91f
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 12:41:53.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Se+S9om+rEnThyJTJje+ZsZsE//lcIccGD0/8YTlFoa7cQxSAcJ9n8/bfSEJju4WfPFMz0KdEDvug+oeLx7kE/hf16UJNYrZaCGoZaG0l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds cells parser for the ONIE TLV attributes which are
stored on NVMEM device. It adds possibility to read the mac address (and
other info) by other drivers.

Because ONIE stores info in TLV format it should be parsed first and
then register the cells. Current NVMEM API allows to register cell
table with known cell's offset which is not guaranteed in case of TLV.

To make it properly handled the NVMEM parser object is introduced. The
parser needs to be registered before target NVMEM device is registered.
During the registration of NVMEM device the parser is called to parse
the device's cells and reister the cell table.

Vadym Kochan (3):
  nvmem: core: introduce cells parser
  nvmem: add ONIE nvmem cells parser
  dt-bindings: nvmem: add description for ONIE cells parser

 .../bindings/nvmem/onie,nvmem-cells.txt       |  11 +
 drivers/nvmem/Kconfig                         |   9 +
 drivers/nvmem/Makefile                        |   3 +
 drivers/nvmem/core.c                          |  80 ++++
 drivers/nvmem/onie-cells.c                    | 370 ++++++++++++++++++
 include/linux/nvmem-provider.h                |  30 ++
 6 files changed, 503 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/onie,nvmem-cells.txt
 create mode 100644 drivers/nvmem/onie-cells.c

-- 
2.17.1

