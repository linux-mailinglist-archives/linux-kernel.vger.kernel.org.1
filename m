Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C871E9B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 04:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgFACQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 22:16:57 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:29413
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbgFACQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaBC2KHnO0at449N3rMSMUK7TB1lC846m3Ke870kSFMUHLYN7Xp6toWeayj097+v1z4H9WOB9X6ZbewzS13GeKgIBIPkeDkK5qrGX1KC/iVG3l3Qach37Nq9+2qa4GUEqLrtT3E4fGl/PkpN6uIPLCoUYp5CRhdMBnNvIC3H+6+K+2w5DUVSi28F8dD2E+M+YTKQg9eV5Friq3ipnMjErkLfBBMnUNAq35aVRCRVKtcw1wV14o5dQCTwuG23kx604kS1DxR8rUzrBoNgfgLDSaQI2GHAODrGtk1Yylq5GfzqpS7bDNbhshueXNeIJZpqGJF4EgHMNG5TLJrbnFBjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJMPA9QMAzEYk6cEERdf4JbmBymwZMKNaMK8ZPolpXA=;
 b=DWNjShN57c7DJjgND/U/C2naMTkSkoBtGR9IY4J1O8LaQhyMv6V4UuK+3BYspJT0nngnhld9BgXUYz3mp9lZiX/0L55P33Eim/thf7nUBeCEpVfh9OYbk7LVdc3+/lt4A8K4c9pd3DiA+CJqdkj6H+3UpwWbdJV56OvnkF8K97F8yGuHx0QwT+QnfUbEd7aV0AZjpvt0asVngPb3T1B7ckgimrF1XaFumnqjDo9ed8LD31WOgwNmHVg7rdX8GeEhXyBIkrssdbNtxdHBS93nGuTktCEXUxUtyUsRRenHLDscaHJ8Glz/U8oUyfsjB99hvtf5XaVFoO2Fu1MZoHJ8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJMPA9QMAzEYk6cEERdf4JbmBymwZMKNaMK8ZPolpXA=;
 b=GwvGw0xDUDTCqAiCo3FzUQnRUxbN7sgo6ZuyO2EeYdFvaa1tt99Eq7PdHJiun9cS/OGawcnAzy3lbFt99c835+PUSD6se0W0J5tiw6o0Bi+h8V7ygq2j9rJim6PXpyM8hKtYpQiw3UIhiXvebfLkFqzdyH8PFNef7qAwOFrLW3Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2744.eurprd04.prod.outlook.com (2603:10a6:4:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 02:16:52 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 02:16:52 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] arm64: dts: imx8qxp: dtb aliases fix/update
Date:   Mon,  1 Jun 2020 10:06:17 +0800
Message-Id: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0157.apcprd06.prod.outlook.com
 (2603:1096:1:1e::11) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0157.apcprd06.prod.outlook.com (2603:1096:1:1e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.17 via Frontend Transport; Mon, 1 Jun 2020 02:16:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f5f4314-6cda-402f-7106-08d805d1d8b9
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2744EA3997227438FA9B2AB7888A0@DB6PR0402MB2744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNW+8ZcU7rEi+HJrlt/ZRjMJuduSsvD1k8qb+1jZlesmzBIn+dcfWn4ulG2otXLy24WUMAkeAQulQN96kXeQ6rpP6CfDrxMCdRrzKgfvsxptsqRExSVOGHXdOjPbVG9guaDzewx8oPMQIoh6MhN1KrCcglJneqYYTj4rg39g6fbbqrZASQvnFSpqqNxqx34xIQQ23CVYKgprhLcmOlKtFQLl5jPK3ipibU4nfVh+YbemfJBelexUt/IHMEQfsYU92SjnluDHQnTVDHyPO6NTvN5t37qUaiEvYBWrhUce+qjgGJ9AR7rlA2awTIXnw1DJtUSxF58+md/Z99kDW0Dx7QEwfEC1olMljj4MgLrXa8tiUZfwA67ksPFMXJ4tQl99AKb588xHkNHxbxo9DBANMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(26005)(316002)(52116002)(6666004)(186003)(16526019)(6506007)(8676002)(6512007)(9686003)(478600001)(6486002)(15650500001)(8936002)(4326008)(69590400007)(2906002)(36756003)(66946007)(66476007)(66556008)(2616005)(956004)(86362001)(83380400001)(4744005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gEeajkaOR4nYJKvmNv7Bi+xlpBIygq0hLhTbftUNJuQCVdlfqDKNK4QI4npUhOFC9tpS77gonDcHSohJQRKsLOoI+EOQ2xKB9DcvdHON5gGHYeADgVwHXfQTeJ0TYE7n9z8DBzbXEt+WjDJbIilaB1EGx9Z/bciAG3uogSSNIpvDAI9PYTYADOiDACziIo6cX6+YQI0dmvBZJ2ufb4zIbI87RShJPqNuEa1h6yaVqZgzJy8MB3g9Dqv3YSbBgRP0r91MHzztiSt1xxk0Mn8WxG9/f9X9pkcVOnz2zN34zNLgSFCIA+MxGAXj4gnR88tr76gnhLj0oYA/q49WLeJjdBAva+1WyVXvKfe49Opy8QFVBC4zRP482kzcl6acRVB+jXuuyFKmkgAsKF5L3vkHr++GRKzJVJ7iIDrp4WHF2XHDmvNchU1vSZEIdN1U9X//Sh9B2jLKsv2Vq4nkK4LKJSWhhCCvPbYtXi17I7DHSv0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5f4314-6cda-402f-7106-08d805d1d8b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 02:16:52.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed3m5laOHHgGpJCV4SJ4PXJJ3DFljW/OSLLA8+kSnHm8h2DWvuEmpuVg/rLx64pusiubKxYzlhqXNIDkj6zYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Minor patchset to fix and update alias for i.MX8QXP

Peng Fan (3):
  arm64: dts: imx8qxp: add alias for lsio MU
  arm64: dts: imx8qxp: add i2c aliases
  arm64: dts: imx8qxp: Add ethernet alias

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.16.4

