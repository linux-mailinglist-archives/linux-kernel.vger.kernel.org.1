Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2B2D2225
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLHEjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:39:06 -0500
Received: from mail-bn8nam11on2098.outbound.protection.outlook.com ([40.107.236.98]:29057
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbgLHEjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:39:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QasQG/bHNcb8ug54S7lg0iUUAtEJAjQ6LHeE5vLJhuM9Y/BJD12gAkoOyD5gy6DaxWd83qVrHhOydAOn+irlJi/Wl5LBfXQ6BS8L41WgLMK4zMwW8EKpnTyeSvasXm8j33SQaydDSI4FyfKRJ2hAkSMUKCHdJjoTEhw5mLHdUmjdeFNfA5GWa0dZRHcvVpci78U3HFAJHBs8RsIWCnI2NDtFQurugGq3SUo3Ex3CIGFh3wSSXYuKAC3p0ov+Negc2Cra59zooeRzSmVMgERDm6CyvkMORtNp5KzjfB+SCFc08S9K6RN23CdThzJju6H+XQ+5ZolFpRlc9FOGhQONSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp2bd0o67VtAHORh1r6aJ6LC/oM1JsR3kNUIYITbjY0=;
 b=md6oL/QUJzKTscswFUTfejFMXKECte5AUE/lwgVCfLh9SGDPhpSxU/LdCuEpWn5mhtPkgsDL73p0v7cReyJCzQF+FUEVaLjy3aTYj3VPLUwBzBMcd1cBE/xfqyPFR6r03QQiUcKwsxRee2YOL9gRsirK/XYCb3rdVW4AlprtORaf/LpYX7B8ROayP/U1Fjt5JAQRvtyX+O58HFdZbrIN1ivhLzO7JmVoHl+yKluRVP30h0R39Fo0IUD94WcJKh5h2ydCfmgUhOlwwOqU5FK5I0Zi8GRRaQKMlFcCMb+tAPllTuWHUxA9O0s+SUSgbqVNDJE4ex8HW9LFidlzGPaoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp2bd0o67VtAHORh1r6aJ6LC/oM1JsR3kNUIYITbjY0=;
 b=Z2IRQ3dCsnNj/2LzkWQ44L/A+KkdWCkdjB+YUy++ItCFpml4nM+7CQYpxULfXZZ5EN/tTyd3O8WdDmv1AfQyY1u8igDIYQOIjGK/Em/IVUUBIYOWlyxN9/Kw5DBkRHK5gyL1hHV+zZjyBZ8r8t66+seRDzeObjLt7EggNET7zGI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32) by
 MWHPR01MB2383.prod.exchangelabs.com (2603:10b6:300:3c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 04:37:39 +0000
Received: from MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::e903:700a:f17:7a17]) by MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::e903:700a:f17:7a17%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 04:37:39 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add an entry for AmpereComputing.com
Date:   Tue,  8 Dec 2020 11:36:59 +0700
Message-Id: <20201208043700.23098-2-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201208043700.23098-1-quan@os.amperecomputing.com>
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [118.69.219.201]
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To MW2PR0102MB3482.prod.exchangelabs.com
 (2603:10b6:302:c::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hcm-sw-17.amperecomputing.com (118.69.219.201) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 04:37:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d4e7e6-9cc6-48c4-ab70-08d89b32fec9
X-MS-TrafficTypeDiagnostic: MWHPR01MB2383:
X-Microsoft-Antispam-PRVS: <MWHPR01MB2383D2D9C2A1D1493E07C1FEF2CD0@MWHPR01MB2383.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNPB0kGNTQdOj2mnvcq4y60+MR9KKJr2LughdcLQE94ATdbL4zyywdUsG9w1jaC6nf54mJClJ0TnIiUUo0mS0n7aMMecRSO3otLJQFv/hoTmWW838xQG51xKIkbhrGvbKXPI11ovdaf4rJy1Z4MgjaO/VSc/P8Dx6ySon8BSMu+p5OqMSJ7CMP+MJmFt97qcjlAuacaqw684oLZ7o5zS2fNNpdgVKQ5zfztM0L11yxwub4ZiIzzlqSh1DvVyeEdIRbKPNA5w+YiBNV1bvBEmiDiyFaF5ZhBwovfyEPPPgS0Fn3I7DTE2QPG1R4QGA/r8O4aZZQH28LdevMO3CEZYYZrWhA5eJ79whAXEhTDU3dQzeUTv0PCJu0h7POmzwVAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(6506007)(316002)(66556008)(478600001)(2616005)(52116002)(2906002)(921005)(66476007)(4744005)(6666004)(5660300002)(86362001)(66946007)(8676002)(16526019)(110136005)(26005)(6486002)(8936002)(1076003)(7416002)(186003)(6512007)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VhiK2U8bvWJ5ErcvqHPJWWsDohVIAe9RpvE+3NZ7eMD/rWWCNCk1YlUwc1Sr?=
 =?us-ascii?Q?45nxR/LPznaLwgoSoEuvbr1HKyHbovNSJADSqytFn97D6WGgV6pFvt+NQSGx?=
 =?us-ascii?Q?4/LpnpGLhui9L8q3Ih6p1tmlW3MMDbQPhsPl6afmJJjgWa9iaOzCiQzd9XjQ?=
 =?us-ascii?Q?3X6EfiTNRNragqitoFBd6fLM9GAzlKRWpQtPDMLLIDtHkv+Mhy5CSuwBrpXE?=
 =?us-ascii?Q?X0hpr0MOIOnxPPkTmuOxURFNycdG71pDYusTdK/mzKEPeAeWNKSs1M2Hu5Rd?=
 =?us-ascii?Q?sg+6ELwY0rZ1nLAjbVZ+BAnFWvnYwbQR5oDj+I7zehqbO4pjwyynNv2oFKlL?=
 =?us-ascii?Q?nQ5hY7WKxqqdQSi06ewRPkfRwcbF+pOcOTuEnzuXWeyX4CeXwrJDSrHTxFe3?=
 =?us-ascii?Q?/QPpSVp8CgHPKw5SvdNI8r2AxxfM/VDW4z9L8VY1xhsHFHZpCAxlTGdOEiU2?=
 =?us-ascii?Q?+SFxzc5n1a2C8glTrZ9QNYcYrTHpOtjwKBZif6DFmWIpinhUU71iU/miCthl?=
 =?us-ascii?Q?z5gJoZYXKVmHqzD0Nk6T9LMiexJmchuKDnyohKxZBtM8ksri0Oild58HTHoZ?=
 =?us-ascii?Q?jwhaSGWj4acvFn4XO1yeR67JB/GCJmyaJVcadSBIv6ndNPIen0jyZ3CdsU+8?=
 =?us-ascii?Q?Q566iB/ktZAaYHYjRWg04jLT87I6XaWmZ8652R6FVT3a3G0OoFL9ehgjMuGi?=
 =?us-ascii?Q?C47A0z2B05c3oPOvadlnJRJ6QUPSLfR3QfYTBAtPw22weEFYGF7QHaJgYqQS?=
 =?us-ascii?Q?SoRCH5slmmE3cgYlzPT0rJybwHzC8uXgEL+yPG5zn8h+PIT0dYnUANTxPDgc?=
 =?us-ascii?Q?kIHE83BdRQW4iJqWd6nW9r++4X7Dy240KmJckW5JSoNCuehD3CG4P/P746wZ?=
 =?us-ascii?Q?7UZL+2fZA+C25VFn1G+iE5CmQ8KDuD0RrQK8Fmiz+m+vwdTzNXLb/5vgXZnc?=
 =?us-ascii?Q?mHsLGfL8q1XAhB5AR6ZLt//zQBKJ/HjIU1XDBNPu7j4suh+GlEvb8/7HZoWN?=
 =?us-ascii?Q?bIFt?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 04:37:39.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d4e7e6-9cc6-48c4-ab70-08d89b32fec9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+bSJAvoYAL/BxqRWn32HkGr7GeC3cJYjYwDjOiVvBpWBBdyUsr05j/CzaN5U+KZ7mHU8wmR22CT+KEBoJVUCVgttQsO6WMNHUj1ELSU/D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2383
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "ampere" entry for Ampere Computing LLC: amperecomputing.com

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3a76c226771b..a83fa090f3d4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -85,6 +85,8 @@ patternProperties:
     description: Shenzhen Amediatech Technology Co., Ltd
   "^amlogic,.*":
     description: Amlogic, Inc.
+  "^ampere,.*":
+    description: Ampere Computing LLC
   "^ampire,.*":
     description: Ampire Co., Ltd.
   "^ams,.*":
-- 
2.28.0

