Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE6E26BA67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgIPCzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:55:54 -0400
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:23584
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgIPCzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:55:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsJdqhTMFVO/0/luIDEzVREXUUSzQRH2+dBZoJPxoqYuTnusXCDQIQeP5sWPkkS4X4a9aDT2vEmA9RxwmaAdrSsWtwU5nVRcFg1+0uRvxb7GQwzTJFv/vqqvF1y/1bVY/6cVXp6V8FeUJEz7Ff2xNsadAzg9Eimw2hAhjT7eb2/4lcoxCZpbec8mJjL6hEQG2Z0oezZ8nGed9Z2tKwWhxs5KUe55DblTtHi0BqqNIKJ3XoL0FrbBrr67DuusqGH3y3D5KnB2FED0T0LRVHquUfJ9EX91ZHxQMy2mYVpkvFyW6+ESaUCvsmrpqGurtIU9i1T4VNIY+PDwP5SAviTDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqJJS1xNStWS5y3sRFc0WpYHvh+5NBAOXBJ/0Fi/Ho4=;
 b=iwFy8kh8pJHto+qgK8UT7RNUswn3R/MQrXoGJpT6wGRoOomJHQS7hV4ut9/dALin0H+teSpIgQ0QuE9/sMmcIFeR4ey+QcOobaYHHGfNI6OBhISNn5GAfKOsKmx1neklvKxjKd1pGEGCNl9ze6g20/KppS7jD3iZ7jqPdW0jPDOxg81V9Pc6GZdAxJoCuwpSa2Fy18mjNEWBy5fLa0dYslMgOj9NMvo6vZsUQY5J/W4BT87MLPjQ3Ii8g+ndS1Np6QoJF0VfcEsQ2I3qRpw2pj+aUCjkFQ6zN757sNvkG1FjoN8Vs/h4CEluL/8PcAc572+idyhrZ2qeFTl3085+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqJJS1xNStWS5y3sRFc0WpYHvh+5NBAOXBJ/0Fi/Ho4=;
 b=W+aQvmSq6K8jsnKzR8v24YIvSIL4gYWVcjI/9yhDrZXe95nervwlioNaavVvxRRrA/E16tC8JUH0Jv+vRAgLvzUj4wF5LMfpVHQswZqJZ9hkh5P5Ey0Ppwi8qjneEjA76buBnsOikPhDJ6giFktybzQZJksgEw9TNI4lxjFrkbE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 02:55:44 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413%10]) with mapi id 15.20.3370.019; Wed, 16 Sep
 2020 02:55:44 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] ARM: dts: imx7ulp: add pmc node
Date:   Wed, 16 Sep 2020 10:48:35 +0800
Message-Id: <1600224517-31465-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 02:55:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46acb51a-64b2-46b5-ffb1-08d859ec00fd
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71779224209376EE3E85DFEA88210@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6M8s14A9H6cxo6ufxUne4WlSorxJdbxgTTM09Ut2JeMycMpkV6ZY0F0DjRXDLiwF0toltQBaWXcYL/crVOm4WoLuj5WLRd3vziQLqPMZP4OKJJsw97rK44+E8dQgO/JqcF96gJYIeyfSL7UjbOYlL+iZ9rAYn/a98JkpCdL6BS5Jwp13i0yTnhf/x/Voom2JHD/xnRhFFwaUME3LxRf+BSPu8sw4yGU/zQUW/t4CjicvgjpI5ruNIDX/Xred6wwKZXok/fYOEe9fIlVFzpyLTilIgAFQt+b3OPsaWq/mJFRP4FpjQhVfYXdvMUX/uCXAu/r6PHvV3ftYSUqQs87QPzDA6nNzCsSQZbwyi5HBz610SJHKjhey2plyDupqtZp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(4326008)(8676002)(66946007)(36756003)(16576012)(316002)(86362001)(8936002)(9686003)(16526019)(186003)(5660300002)(6666004)(26005)(66476007)(66556008)(478600001)(52116002)(6486002)(2906002)(83380400001)(956004)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aOnxHw952+6EmHcNWWS6fd3CZohwP2IYe50sZPYRzUmjCJe8qpbmZWbokj6/Lzf+e7Ao1IkOkl7fLlsBK10f1Ih8H1cQFbvBO+9tEqrUBYGicsB6b7RNKdmELIOERiZ96ENaS3//FUlncWg5Fc2zYH5ExxHQHlZF48x6UvPPmi8BbiT5ZHpS164r8rrZTL+1H5wZfQbOiLXYK8tVGrTzhPkoA0eB3ZXFoG5t8LLJJWYV2Wb1UAMniAIf2TDYCmb8Ba7qTMlWEgqIvc5SwUN3kFD8H6qmxBW+MyVE0Uj1UC1auVQ3KhIQs2DoOw5NLl6Ie7x0C50ThOjm7jLxPNZB+YDHJNBkm2r5anJ+ruMzD6y4ZxUHFLDuTrPAFCWnnxAzOb3/SEL3qVmyflCVJjvMWaDZT0plKJrJipxx9n6uW+OeussVh5DCF1gwNoGiVI9qx332AoRkyDlxFYcZG5fYtvMoRnckmm2haoEffCaluj5Zw/GANqtl0G4eC8RwVg/MiEXM4Am4oLWzqR/QImOIXCUdhEeTsjDzLmab+2fOTo59no/Dv3AM91f7eQh/RUd0qzpbZwIFR1uis41XaFSsMIHN/E52QrssN5Ct3kLTgaal2KIJdeSoRxnU4c9UYG8yEKNZzjzfDUnWmqL6GOjBww==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46acb51a-64b2-46b5-ffb1-08d859ec00fd
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 02:55:44.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu4nI7iuH5yP0WnVWX7ym7PyHFjDPA9PY9wa31kmtcxg74CxtdafPytSLA92LUmbGXZ4go1pkUbLtN7+k8ETiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP pmc node for m4 and a7.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index b7ea37ad4e55..b02dc4c97fb8 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,11 @@ pcc2: clock-controller@403f0000 {
 			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
 		};
 
+		pmc1: pmc1@40400000 {
+			compatible = "fsl,imx7ulp-pmc1";
+			reg = <0x40400000 0x1000>;
+		};
+
 		smc1: clock-controller@40410000 {
 			compatible = "fsl,imx7ulp-smc1";
 			reg = <0x40410000 0x1000>;
@@ -447,6 +452,11 @@ m4aips1: bus@41080000 {
 		reg = <0x41080000 0x80000>;
 		ranges;
 
+		pmc0: pmc0@410a1000 {
+			compatible = "fsl,imx7ulp-pmc0";
+			reg = <0x410a1000 0x1000>;
+		};
+
 		sim: sim@410a3000 {
 			compatible = "fsl,imx7ulp-sim", "syscon";
 			reg = <0x410a3000 0x1000>;
-- 
2.28.0

