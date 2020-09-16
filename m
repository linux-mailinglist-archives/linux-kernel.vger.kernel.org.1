Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6154126BA62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgIPCzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:55:38 -0400
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:22847
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgIPCzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X93YJQ6pT6eXGOqRW5VMkxNwOQ3f7Peu6zMopTHSKY4opLfeZ/37A8fhG/I7Pm2QUHFlDoZgM8rHqrao3MPkfTAzg36pNrl6DNm3jSa9pdHHw89uZUkOHXMZGezvLLmLN7A08VLly9UOEJZ3bAm224XFWNxUjP8hx3Rz6dqpCzGEn7mhsGpbqGsmZcYemqMDmlws8DEixFeVEwtl6sipRlU7gUqdDQk72sglqav/vla3fAA9ZO+h4ai0WkuC/xKYRcPLS3902nZKcvqOGJ0M58yR/Xj160+73Iy25txMiM3CiAppSw9rVaysqD8VE23CK6YZLhc17Fpsw1tIAPzR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmqOc4d4r54+yy0rkWlK/XcI9KrH7Z0UqvaQod+2ZN8=;
 b=Coxd5ZjgfE/gwku58CcEIEz8FEHKu6GgH4n3ETMUo/AU6UzxdIoYnTKJHOED5nSgPtCG1K6I7stFmX7loZctv3PwrAGirapFwpnH8tCr47gq0wDOuSiPRJsdzIzTaFxl8nfScYt97fzW7irSRU7px4DWFiSLBF2M/6wTW9nkGtPrahBR2bY3jFN0tdSZbvjnZjd1LBeToiqIopQ5jOYht+Cf+VE0MYG9j80VvRUv1srOCBO3wWtruzHP1v11IrsibPDWbCBvtroGaDW5wZfDOchpDTdWvwK0kiDK/SoRdrDMydq7MLfs6g1afLK/SI8QQo56ufU9Hbq7pogHtdjYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmqOc4d4r54+yy0rkWlK/XcI9KrH7Z0UqvaQod+2ZN8=;
 b=Z8L7ezqEnPO4pkoW5Fvt3/biqOyB20Aw36FHtqva2nUJ4wHxBijuz0RkJ9WjIwal7OC8yGafbGME32UokpSqqcuyLNbFrsTGx52cMdsCI/ACvJ7zlfNGaq8nNrL6Ljz4vc5lJ3xpZVPiZfjpZv5yrcKTx6VHnyZM0UZ/muKhuGI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 02:55:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413%10]) with mapi id 15.20.3370.019; Wed, 16 Sep
 2020 02:55:32 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] imx: support i.MX7ULP HSRUN mode
Date:   Wed, 16 Sep 2020 10:48:33 +0800
Message-Id: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 02:55:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b48cbcaa-1594-47b9-6406-08d859ebfa15
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7177640918E2362E2527FD7A88210@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COfy/ErDLT7TEtJtHM3mssyqW+IYfXonSjcUUxr+gGDCD/ZkGRWQjIJS+ScwvHfh0QS0FXa9qycWbHsUQHaHE3kiksM1CsqOcRAABaIxSt0ehvvmKllAIoNUt36ijYdLJlRwpAL/bFVkbn+5lfoFvIriNTFKqfu5rpsguX/NCGm/w+JskyVSiTozEgobbAHaXH0wn7+rHizlww+8jGVUL7+EtglzuqtXwcIExzgxrbnQurlrRsF6B5dI13d49DJWV7Iv4e68IzrllQLXqC4i5ZGIkOEnzxsQ0JXnF2sPUU8kGnTNd6od5LifoBtpGC58Nf+ePxXf/fJETwpBG3cqp6J6KmEnCE35Vkt5aHTLeiIl4c0RyXg/PAVxVb85zwSk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(4326008)(8676002)(66946007)(36756003)(16576012)(316002)(86362001)(8936002)(9686003)(16526019)(186003)(5660300002)(6666004)(26005)(66476007)(66556008)(478600001)(52116002)(6486002)(2906002)(83380400001)(956004)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oTPH+fRx4jFO1nnvyMqzUxll55RcyZUVLOXAnW2giyBp2rwZECX75qDY16tZIrq/atXJdaUhjEYQEo/KZsMT3vVFiQIPiCIrnqxnaeq9heY9bNpPHI4nfF5vmkbpMxcG9t2AiGg6srALQovFK3Gl3XVHAPa63iNdmwcpjCzWHzLT2m336t42hn2lJEWYML9BMpELGkZHDUn8i8pMb4AdaUQvLqqzCh1hXz1KQhvZmMkspUEyROKacBgm28iZR7svGmvqEx1rWYcnn+PUAJdLFochGSheybhUjfAzzsQN++Iaq/xUNxWlABEXpIMKHl151lW5AgCnlMSMxr/57kYAYj+fie5eDYhxsXHAMpe7utwu0qI4IuDg9Nipq5ngz3JGLVR5v4ggTpPJByucaVZI0fyueJUCSONcxgry9shtc5gaeThB/5yE4mtH3sD9K5VjI/odfGU0W70GN44Vlm2HxL/vG/f6AmvjuRhHMNiIp4o50249Ww+2d4LzId1gcr/N18PM5zWGGmgwR5IBaKyh1fyXSpoeD2JMAaujFLKQoOV5rsfha0Zhkq7axTzGdbLC5FWlB1oFCgmGXq5UYfDDStv6kKDeA/AXX/r7vfKV8y5pZLPorbyLdN6MqbNQX/MiEtWmkLsFT/yP1uAp5qTI4g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cbcaa-1594-47b9-6406-08d859ebfa15
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 02:55:32.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXGvWfLfrMJMmJ+ONlKBO3rsaY5rby7SGIu0ibCX9nmYCU0NCrGXUQiyvUfN0rzLqaC4SLYaE+w96suzSaUmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Update to use pmc0/pmc1 following hardware naming

This patchset is to add HSRUN mode support.
Patch 1,2 is to add binding doc and dts node
Patch 3 is to support HSRUN mode
Patch 4 is to use wait mode when HSRUN working per hardware state machine requirement.

Peng Fan (4):
  dt-bindings: fsl: add i.MX7ULP PMC
  ARM: dts: imx7ulp: add pmc node
  ARM: imx: imx7ulp: support HSRUN mode
  ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN

 .../arm/freescale/fsl,imx7ulp-pm.yaml         |  6 ++++-
 arch/arm/boot/dts/imx7ulp.dtsi                | 10 ++++++++
 arch/arm/mach-imx/common.h                    |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c           | 14 ++++++++---
 arch/arm/mach-imx/pm-imx7ulp.c                | 25 +++++++++++++++++++
 5 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.28.0

