Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6626B893
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgIPAqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:46:19 -0400
Received: from mail-vi1eur05on2113.outbound.protection.outlook.com ([40.107.21.113]:1217
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgIOM7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edNdqL6aSU7/BJJnxLO5NDtaQ8XrbTBQ1FSqUmMFt9/PfNlyVev8eeURgjfE+Gk6mwijicJ5pIrwxX76GvRQQH4X/YPmKb2dgItLVUEpMOqv/erfNYDe8haccGlIqp7u6mWLRKBnPIgae+A7+l4mjQNQ4FEM0tEbqAxDq/bawA1+vL42Bo9Acc4rBhDlulTC/Mk/Db30knX6UK+JGgYly68HS9jH7tvpKDSXXFbd0xZYjovbeJCLhd3OruyXeUVUiZ+c+qIMuk8Jq+zq0wnh4k+HAbu+gGBKDcetY7yyRxiO5IYSwtuZobaeO5hB0tZS3/GTjw9//CP+Pd3v/CK96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaV9lkqiYrTadlAPMHjZPuQhyzzc8JV/D/DgwyajNak=;
 b=TPaU3K/LyC0kGNxjrwsZEdirBBxkV2MXelnsPwfLxuHSRX6pzSroSb50/3lZZL7SjdaAA8ExuzXEPNsxVYhiuHxf4sGRT5Uz2m0Xsm5zI1XwaMKf735Z98jBOuZ7Emg+Y7wsiCSkleMXMg8au9uCaMkDPrRr0VW9Zv1CQAQduPl8hg+3lQIjyMcRZoReSbWdFUJISLAgup9fVmFgKla7zE8azsCfkUu45JRNaCeHeRvboCduyL93I8S8UF0RoJO5uoJ1mwxrokIZy4wB6UjRkR5omHLrMuYUwiJi2A2kjIPitfmU+cDHJ8Vt8Z4Erw53+plWRSIHj/sI+CH2dLFZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaV9lkqiYrTadlAPMHjZPuQhyzzc8JV/D/DgwyajNak=;
 b=bzcJ5+x0yuyOql2zLtxvF+vNeicS0JdABtWRzBlEBx5sRjOlQeI3hSoFJVnikfA+SUVwjmaM6/pt6Xy9veDIP6DJ1hhvNTNtP2Z6vCYhfJtfAsbinYdq6ge554k8X9jYDneYqPFBi4VAgKJm4+ThAhLw088nUddKCTXhT2qoHdM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0331.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19; Tue, 15 Sep 2020 12:41:56 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 12:41:56 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 3/3] dt-bindings: nvmem: add description for ONIE cells parser
Date:   Tue, 15 Sep 2020 15:41:16 +0300
Message-Id: <20200915124116.7196-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915124116.7196-1-vadym.kochan@plvision.eu>
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P194CA0033.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 12:41:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2faa391e-68a5-4c5a-f2ac-08d85974bacf
X-MS-TrafficTypeDiagnostic: HE1P190MB0331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0331ACB2350CC85910CAF01A95200@HE1P190MB0331.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nC8K2Rhsu83c5KaGHjtbtGZyETYWx+Usts3hcDyAXr+49NvQCGdEiT0wIXGgEGcBvM73QX6rdv0Zxh5dKU6KMgDqFc7ZRRnXSgN423ROeL69RrA67J2ZdSTQfAJiwDhYsPKhM7zjiAvMoySR2W3ZS/LxDM/eAFczVOuxsdb32G3P2IExljQ4m8Y2+YQlzAjdCId2O9GFoprDe3xCDxQCG1mrp6z4e6ve/4FpNg11qhCzQQGfkcPN9qo4SDfcnk4sbwkG+mfDmqgsO/cM7Yr6GdL7ijmbaP3Ex1TtBrvTaNl5Pxwik2IYzsoxxsiACxGr66oX1WgbPwR5yI5L64x05YU9ElSw14JbwhV3C1zIYg52cIhx+DfApk1ooHKHiDSa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(376002)(136003)(346002)(6512007)(6506007)(4326008)(44832011)(36756003)(956004)(26005)(8676002)(2616005)(52116002)(6486002)(16526019)(186003)(2906002)(107886003)(4744005)(86362001)(6666004)(1076003)(110136005)(5660300002)(8936002)(66946007)(316002)(66476007)(478600001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kkgWSbyt//Aj+ynAIazvITNAUwQMTwK64qPngPR9B1O6HKREOfnls/3trp4gEK87Gse4Tr7BIO09WpPmj4MJLINNnijb55LeGtBZ/VX6SSoSbeULGN6WFh4tsIsqXjb/DHpqB/VeS2gSIkAwI590R37XthAR/i72LixWFunHR9DTaUqVMLsjsKUA5uSdRKawTzFqcsBcGNc1EuN+JIw5EQ0suIaEYpxi/Fx1VWCanoA7yNYyyjyngQxtzLQNPpPrXM5bZcW1Qul49WvPPfr8DYWha3XR5sXCzpobRLnp/5F4ui9I9wPN40vXtQb2Dqlaa+niGQ0xbBVHUQeoWCOy0rFyzAqLFIUbPgml+BGKhgweUdstCmE+eRpuU1jD5qPAZQp08dDnZSl9wJGfEx1EhrOvPWHUavx2/vqwg8QCFPt4pqzwQExTV4SaMs+I3+AYzoumuFu7diLZ/00lCvtBKbb1S5o40Xy6kO2s6ytQ0AClmD8i5I7OTv2lUUZEYZqP+BacbOsAE5bDLkKTN7azylBNIUFbqTsgLw7DdKpyTUGlSXzr0sSwKoUN4nGs9Ev2f4qEEMfEGC5NXilI072T+iKL/Nxi5K3BdYxvlcRIDjodSaFjSuAVMlJoBlDdPRgW/ARFxll7QCExeIcyPVw/Ig==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faa391e-68a5-4c5a-f2ac-08d85974bacf
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 12:41:56.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gCyUHPwydjMWW+RwXYZsbJ5CBbbTsoEB5lLiUvWejI4xFSXYK+utZTWyIQeCYPkTfCIF2+m4Vu/0spL8t+M9uaeKyPMR6e3Q0VdEtENG/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding description for the ONIE cells parser.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 .../devicetree/bindings/nvmem/onie-nvmem-cells.txt    | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/onie-nvmem-cells.txt

diff --git a/Documentation/devicetree/bindings/nvmem/onie-nvmem-cells.txt b/Documentation/devicetree/bindings/nvmem/onie-nvmem-cells.txt
new file mode 100644
index 000000000000..db06d8b297b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/onie-nvmem-cells.txt
@@ -0,0 +1,11 @@
+= Device tree bindings for ONIE cells parser =
+
+Required properties:
+- compatible: should be "onie-nvmem-cells"
+- nvmem: phandle to nvmem device node
+
+Example:
+	onie_cells {
+		compatible = "onie-nvmem-cells"
+		nvmem = <&at24>;
+	};
-- 
2.17.1

