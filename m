Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614922A248C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgKBGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:00:03 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:51822
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbgKBGAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:00:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heh4nECR5UGA2DBjxIMyStv68DjfAbvfFqTmFRqyA+oJ332hf54GXM6MydVqBDmVwSBR1Uh45rHvt4tMNv3bLLUmFkrxpncxTSMNkwG2iFsKasexyj/kzAhK/2mhs1oFwieELH7MXRzBpl0FvQMkBDaWthrAT0ituP/0vEjOJC4zIJM/BA4jtF1+K2GCNvbzaiB/ZYCGSqMg/zrw0lYhI3SnVZMpLfpRkGHunH1b59TATZOr9X7GK4n2yPYjuPvjDj+qsGsgn6yemyFoTuE3SgpWWlv99G81yx7O/G+QDbrBeoBW+6enp8mBbUL9D4JgpNk+Z8e9eGHbyhM3STzvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53GtBVqgVMacHN/cZiJ5NKb9GnkAmQu3Uk9idhwgCrQ=;
 b=RyqmVE9qLKRbMmjEi3RNDxvkc/eT+OYTntkQlKYuf8pxLIrtbbXQ8mcmMJAy0f4Wey3DGKcvJxNpeQqQZVtjxR0oO83x9+K1SZgyZifyCzqW/cRBhNrROdJ+t3XfHqFkBCv87TW8TmTyDsyiddVWS1tXvtSHtGezDcoyUgl1oNdJgkbPMhZirf4t/svr84d9o3GX1Gtg3BoAmwlEQbN3HJwmjoWFnF1Y5R6c3QTrAwa6QsmQKbSe9w2JSRapHFzFa4AlqPF/BzxvLGqb14EOqrrWr8zURDQIGWx0Nvu4HiGOsiIgfjP+YjXO71oxIBqgqJg8AH6jzwLeXZUdMYUApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53GtBVqgVMacHN/cZiJ5NKb9GnkAmQu3Uk9idhwgCrQ=;
 b=pK3j0oh3M8BGgBh7E5YQz7RMgnwKeLp6nm8uAmukVntwV/tHhzyaDAiJGyOIxFzg0JF3Oi5h4l4AyhgcEeFIfuBTgyIem1tVoTy1rlcbUV0RXC8U/nISMTkOjBXb/n8OJBGFF85Q7tfwWgDsntRvcYKWLF0k/C0N897Bs5gW12M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6893.eurprd04.prod.outlook.com (2603:10a6:803:133::7)
 by VE1PR04MB7439.eurprd04.prod.outlook.com (2603:10a6:800:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 05:59:59 +0000
Received: from VI1PR04MB6893.eurprd04.prod.outlook.com
 ([fe80::48ec:3370:b98c:ad13]) by VI1PR04MB6893.eurprd04.prod.outlook.com
 ([fe80::48ec:3370:b98c:ad13%2]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 05:59:59 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v4 0/2] Add device tree support for LX2162AQDS board
Date:   Mon,  2 Nov 2020 11:29:39 +0530
Message-Id: <1604296781-28295-1-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To VI1PR04MB6893.eurprd04.prod.outlook.com
 (2603:10a6:803:133::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0067.apcprd02.prod.outlook.com (2603:1096:4:54::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 05:59:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbca7c81-c6f8-410d-a08f-08d87ef48780
X-MS-TrafficTypeDiagnostic: VE1PR04MB7439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB74393AE41797A6B7A99A6AD18E100@VE1PR04MB7439.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwBu2BFmtPkh6y6gl8chK41Rpbii7zI5CxLlGzHQ93zds9dfBkMZXppkL5Vla5Bg3IiOHsLFRT+ZVp1WuQUxxp8u0d4DMubX028jBBGfT7myyDz+xdmRhQCZagERf+3yYdDzKtiXc9XQ+1hSte/UKyWp7DC4NKvirZ4zhJhHSno5IJRLUCQJJl2sgiNPjMChR6nep3+QWRzDr/3QD0fPncmac5GcUHS/XZcryJG9M01Ske2f9qs3VdTGh6jEk+LCtMz+OGCYY/7cpMX6+HOypNpXGrATcIw7q+Wqb6L4xvV9IFMSDPMvMJnEZqN6knpHi35lAUOZIw8zImgGpzwlX+JVP1OUipvoXpjOjE3skO+q/PH6fo5ffV12hBnbjtKL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6893.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(5660300002)(66556008)(8936002)(6486002)(4744005)(8676002)(9686003)(316002)(83380400001)(66476007)(1006002)(6666004)(66946007)(7696005)(86362001)(52116002)(4326008)(55236004)(16526019)(2616005)(36756003)(956004)(26005)(478600001)(186003)(2906002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Lqg4zDIgMcrNCnVJS2Se3+stdWAVmgwp/NtohOi4J0n2luwN6LYBvuuudf3qebmKi0lmNlZfDPuI3eRW3C1fZ8Z8W8NWi2ZHatmdyw3QvONNH1eAR57d1+5zsjcqR4RAeNEZLqMu0V0UqCWx36lyKMuJ2WT1Rmk1F3VE30ereIYxUThyqxNp6byDzPuMdMDR28RWQ/kXDahXhApMBikSELEsl+zNK8/8kGUb0R6puG+AvpGeiBWDkm9hIuqNJglxN+cQoexVojprV5hdljFwgNR71csr8hfb08J+La15o+bOR2MInfR5YSUPhmChGqAVWq/CgNZv8LtLFXT3hVepcIWPT7gxPQXRKMQoB0Qm7t7CHKrmOTayP9TA8W7xO6OXFqvkVNPXJwBE4JDUJQPwvQCCo3CmLP06rZ20ILHXZttgK6vCMSQuV6IFuQRpl8/iU4FGxwaTGLPYbuhdQm+kjG0ccMK4tM3op1Vy5QLid4573YmP3Zn1zSL2bbJZziB1K9+3AIkdeol58VQi1njOjJnR+6Bn3G4AkQuNstTK7cSOCtWTURieizfspG6Odw/k4e8ev3dGYdW3gap2/iHArhbP8nlAErpY1dOXcjbA9Za3kWP7sspGozEPzZKDH8UMQjgnW7ouNk0VKPdmDkWvpg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbca7c81-c6f8-410d-a08f-08d87ef48780
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6893.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 05:59:59.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WxhjffeGSo+2Rur1YUvCkGO/0Ltm57WifS9IrcByMRg1odwiBuf28WL5Tut12ttB31O3F1UBHq0+X2M4qlZJ3CtKA9oW2c3mKy+euXgw6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7439
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

LX2162A has same die as of LX2160A with different packaging.

Changes:

        v2:
        - divided patch into two, binding and dts support

	v3:
	- incorporated review comments on voltage regulator node

	v4:
	- fixed check-patch warning.

Meenakshi Aggarwal (2):
  dt-bindings: arm64: add compatible for LX2162A QDS Board
  arm64: dts: lx2160a: add device tree for lx2162aqds board

 Documentation/devicetree/bindings/arm/fsl.yaml    |   1 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 334 ++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts

-- 
2.7.4

