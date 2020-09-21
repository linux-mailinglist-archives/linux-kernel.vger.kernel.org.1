Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D272736E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 01:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgIUXxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 19:53:05 -0400
Received: from mail-vi1eur05on2108.outbound.protection.outlook.com ([40.107.21.108]:48225
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728976AbgIUXxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlVeN4gYeb/2sIL98rdR78rmZSgDfEo9KMcD2v0H2ELEwWulFk864dQzxWX9o1WtQxLNQjvPfElDalST9UkCCyUIbzo/RB+sI3EIhzctE9yekeLELSJ3wKeyTgt9ZOr2C1Ksyb8ah+C+i5ec0wFn/PFW9p/007tHWwFgA8X9kMlh8vKj49P6tHx3juAUcfXC5bt8ih+3HXqDgI02onZlGcaIfnebNuuU9unOMjHlvjDO+4rLZLjwBtpEekARvddGuZUt5DDGNLqNtavo/pwtlgZB7MATp+UIESPdOE5aaFwGkomF80g0auvEkS1NI+IK8hSxg8K0Vd8Ras//5Pr6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9TF4Ra215+6A7oNdFs5iCVPORE3l+rpQbvSo6DANnE=;
 b=f111dlUOrW2pOs9iEmI9vFTVasC+ejqjPvnFGodRthcDT3n5siog8Hsk0uY/i4z23SGOMMvqc/LPlPTY57pAnBDwbM1SvCM7zuNJ78I4OhRO8CLBtPlbBbYL0uFpxeY1uvg8/bTJc3ub/VRnLMXOOYB7fcqvKwLJ8Oxebpzx9Y1XlC3XwZ3M2BRUZVsYDqvycwnIM1k1mnAFAkJzXR08JUn+2miSgQ+h9Wauhyp6PsA7+LWvpOV7Erz0OY8s2xux+iLGlVgyBBPH+asvTwH32oFGkW2a/FDc+jzmTTjjMRoy/2YxttRnT2LNseyvP2GNlmT8PrQNP/EWAownbXYMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9TF4Ra215+6A7oNdFs5iCVPORE3l+rpQbvSo6DANnE=;
 b=VvvF1jlqDux3dgJFGhVHqz15CeNmTZaVA/Wn5lhue7OxB//w934NmyghgHnSiIvI0Z36Pj87LEUlu1BWX8/Sohc8aRveeHNWzi/11ZnqgeOSuB+KFfgpZcjKSAzEmySK/p+dohJ7wMUvqnWJ775kNlMz79JN3r9g6zZCaREfZUo=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0299.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:55::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 23:52:56 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 23:52:56 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 2/2] dt-bindings: nvmem: add description for ONIE provider
Date:   Tue, 22 Sep 2020 02:52:37 +0300
Message-Id: <20200921235237.7980-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921235237.7980-1-vadym.kochan@plvision.eu>
References: <20200921235237.7980-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0069.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM5PR1001CA0069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 23:52:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3adfe9a7-30a9-4294-4e36-08d85e897678
X-MS-TrafficTypeDiagnostic: HE1P190MB0299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB029907B2749ED335EEAB11B2953A0@HE1P190MB0299.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEM4yG/i+ttyVkPEIuSEyVoyN0Z9SywG+YagkJTkwwNBdN3WzNZJ8K4uu2mYHkNgbEUT7MQO9Lrm8q3FE9+gTxQ05RTzwUMYqdP3ZStEIQc4eqIiqW+QZJN+L+wUk9v5smZf9AZtXSsVezxwSMPERiIjcMTF5U6/cM7RP9S2xsphPoWmt58gVJc4/Jksf4TUsy8u7xzt1JrfeDv0+x1rU2A907b7GklRinuigH33liyRKJ5Ra3gFU6/s2ZKDEo506EaWQYTHiPprfyZTYns9xXmAxuVF8VhLAi0WOcsq1kzcX6krYJMwR7Vd63bPllq6Ie9g6QkEq1rwPqI9zESEaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(376002)(346002)(136003)(8936002)(2616005)(110136005)(4744005)(316002)(8676002)(44832011)(956004)(4326008)(6506007)(52116002)(107886003)(478600001)(6512007)(66476007)(66556008)(6666004)(36756003)(2906002)(1076003)(5660300002)(16526019)(186003)(66946007)(86362001)(26005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zzq36naTClthBnKqFUHU491WzztNKuEsqwCWw5uKD+f1DsvE3POnW4Y6ssRqAr3Erwk8FTk87/XS/xfmogcgyTqmO0JS4fGuvjYHRsykAQW20+E25S2BR5qN74mT9SQYlqOrS6YentnjgaqRHEP6kOFKg7b6czjS0Hw8ovtwD7bDm1ZWKMCv4OQ1JZGnmKtyV7FdkBYqiT6Q0kgw2dzscb+tpAEL9sRJTI8W4pGEgpVi9A4s1IVuoes6Q4lTBHimkOr41VppI8SIZMeTNfFOQRQBr2RNKvnmRTb5wOCoYx5zNB9RftDP30Sw7YkJl+3JwhkAJuhJwx4CVMoSQ9sQrGCZlENrfc0KgJXdnsegj0sn7YzzbwICmcg0zanbmKpbiAMZ3F6z0S2ipc1MQ1F42XP5Eajw0RC4YKTIVHr66duBkvzF8qVCza4tPV9CTfbi+6GcqdaFDe0M9iRd/wnobHTpNcFq5IhYcdu+3VFjQh2uwoeYOupK+BM63Ard9QoKw5U9yqkFNLss56P8MIt0BTk9IuvTpZHgN10dO1U3zOyccx7s6zNa3DmwLbwZgFIWO2Aw5PDWmumO/r9CUyKi9L/gapexFhFJ/FrxmP0Yl9DWG20oBPfpTci8TQ4F9b2231PeZEFekWeymtebhcqUkQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adfe9a7-30a9-4294-4e36-08d85e897678
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 23:52:56.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TurDIat1ega1K1o82x7Ddl8npgoBNeAyRAMimWxUz4aikFaoCK01yuneDrGuSvDDea4WE1MC53P7PXB90isIcpvPaUztmiXqLGs4qKYQ64U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding description for the ONIE nvmem provider.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 .../devicetree/bindings/nvmem/onie-nvmem.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/onie-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/onie-nvmem.txt b/Documentation/devicetree/bindings/nvmem/onie-nvmem.txt
new file mode 100644
index 000000000000..16fb903118d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/onie-nvmem.txt
@@ -0,0 +1,11 @@
+= Device tree bindings for ONIE NVMEM provider =
+
+Required properties:
+- compatible: should be "onie-nvmem"
+- nvmem: phandle to nvmem device node
+
+Example:
+	onie_cells {
+		compatible = "onie-nvmem"
+		nvmem = <&at24>;
+	};
-- 
2.17.1

