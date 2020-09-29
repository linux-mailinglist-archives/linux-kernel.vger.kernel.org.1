Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5556E27D13A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgI2OeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:34:23 -0400
Received: from mail-eopbgr70102.outbound.protection.outlook.com ([40.107.7.102]:46847
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730163AbgI2OeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFEhN/WRcPt4MpNvUaMJYWGwxN8clx2Cr4/SKfydEzQ=;
 b=hEKM7ZMgBjMkKMHJy08eEXVY27auN9FdxDWobtYzQQ3wy8V/GZsK9npNQjjNQvzCG8uxT7Hnm6RwQlDGgHjQmgfsi9O4c83stmpnA5PC/NuLPIjRvZBpvsLTf9S3z2//Q6vH/C4PIpZMdqFkIOpYOzGZOMipvo9HLeLg90t1VCU=
Received: from AM5PR0701CA0011.eurprd07.prod.outlook.com
 (2603:10a6:203:51::21) by DB7PR10MB2346.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 14:34:17 +0000
Received: from AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::ef) by AM5PR0701CA0011.outlook.office365.com
 (2603:10a6:203:51::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.16 via Frontend
 Transport; Tue, 29 Sep 2020 14:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 104.40.229.156)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 104.40.229.156 as permitted sender)
 receiver=protection.outlook.com; client-ip=104.40.229.156;
 helo=eu1.smtp.exclaimer.net;
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 AM5EUR03FT048.mail.protection.outlook.com (10.152.17.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 14:34:15 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.175)
         by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
         ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Tue, 29 Sep 2020 14:34:16 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 27201838
X-ExclaimerImprintLatency: 960103
X-ExclaimerImprintAction: e54d41d0a3da4ae79cb008db8bb819fb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfmQEJ5rvuMAijjuFVhn5ywmTJxk+uMdSxhPWmEAgNxZFdajjjRJQmxP0WcW6QEtHsXJes7lqLpw2xshotG+zrfQMn3Wn4InKIbl0fj5xjSwGWM+Gpyv44ZuO4GdZiCseCEncDeyFkt6t2PcYLu3mhPq09h1390BmmWGliIUrKBZGoV+9RogJCAW3ruG/6XXvX69w0DbYJXZMTjbxZYbrboD7hKRmSosv9HcH6FQEf9mz8JMLMO9vkrWigBWbenWs34RcjpANmIWOiX02EqHPdYhweej5Z/ElwgmMLBI7jxjn50k3cqJJ+Smt5WVYZgfSSfMyTzPYmG9j9zzri37ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tse0wXwbIIq/t7bYSJvBaJ8fOCX4aerZ7/GCyqdAHyQ=;
 b=FNpnz340N5wg+rpDFZ6cuDp1vW9APF1UJ/ffbWQrTRCKMY4pSmUJsoF/tT+bQxJ4W2LhmedB5c7WOjSDaTvA2z+UMMGPV4OjYeX2JfYxe2uQ1xuXLz5mU8errhXIsnpQaPtIJINWuZNrdhTKoe0UsieQPngqktJwAr+sevjSdvyOMEHiB8PPropA/J/TD1pU0bcrC7JXhmkUPg5DF3/JDTNngTx5L76uMlvWSuYLNyOykw+cEIh+OT4tDjNeuOMi7Kn5lkG07AzarU3lRHXJnUjLKyfO351kGBe4OlOKV8L8DpajuzotM83lPxK+UYrbczD0DRotGEIav34zpBS3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tse0wXwbIIq/t7bYSJvBaJ8fOCX4aerZ7/GCyqdAHyQ=;
 b=AQzzsEPUhNAMdhEqi1oVteIfKmrZQVurENc8pdPOCBi/P7ivF4FxjXZ/69rcBZFBCS5YXJuiBGA6Mcwh93zIVY3tinjz/wIicgY7n+ARwptfLtDi5xchs+ZtErbCH2URpL+RI9/mmSB1+kTrDolZWA6sOndRQdR/1gEzl8676mM=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e4::19)
 by DBAPR10MB4091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 14:34:10 +0000
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431]) by DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 14:34:10 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v3 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Date:   Tue, 29 Sep 2020 16:33:43 +0200
Message-ID: <20200929143345.73170-2-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929143345.73170-1-alban.bedel@aerq.com>
References: <20200929143345.73170-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [88.130.152.63]
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:e4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (88.130.152.63) by AM0PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:208:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 14:34:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0615bd5f-1240-4b77-0d89-08d86484be41
X-MS-TrafficTypeDiagnostic: DBAPR10MB4091:|DB7PR10MB2346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR10MB23468583681AE22D60C85FC296320@DB7PR10MB2346.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aG7i9QRIH5rm494r4BXBzr9i1+EAss8wFLf+bW4q8SPC4v60mLTs3YLJjllDfFOy58mZao2tp7Mvt+8G1JyvNdUhqvDw/K6oeRqLpfrpJvoAi94jfveL4r4JWflk2C4Q2LbdNT4Lpg2stoqglfyBkgC1sNat43T3BQllMB/GLkAn4TJAN4fDC37nXaswnopkxwtZXKAX4A0mndQr0IH4VNM5uWXQ7EZmTHyg4T/ialzDj/dG+jJJFxx6RnT2pPTPTp2PYOzyaV83Ux7TT0/Xt48ib7jxV1xYwrIzQ7BsAv+xtRULI71Lw/n2lrs/9nLzxxVVaIkrW87d3a65xvoPmWY+rHQn1DautnmgedYoxGSq3H7lNu91Qc58BOJoevK/d4vT55HTfEBUgik2uz7Pj+MJpE5O8uPCY27GfLDf/6CT1uo1DYdhuD5QyXOgWrSjyRzc+DDe9A8GdcKlUvxslg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(2616005)(44832011)(6666004)(6506007)(1076003)(26005)(54906003)(36756003)(8936002)(186003)(52116002)(83380400001)(66946007)(5660300002)(508600001)(16526019)(6916009)(8676002)(6512007)(966005)(6486002)(956004)(2906002)(107886003)(66476007)(4326008)(66556008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zM4uxQriPvfwJQRBGml088N5WsCZHdVyVC3cSqqqABk4e7P7/Sp1IMphn4jWjS0X7NzrfgZin+a6Vxqu40c407GW/VIuTCRFhEpghBKLBCnVaawP1iRywLiWQzlHqfulDTLkpPQvlWzv6rAEEAZQw7yvsIz+7AJTfE8efSVg2i9LxfHXHT+g/2/xgOgU2ekDyZH0HM9JbS/lxF/5yJ5piTXKHa7y3OSHx3O2XG/tm14IdHLz/RUBMSnBmNnYFNZmlDfmz/ZOXo9rG9E72pZLQ201pB1oRjJzEu8DxxUpjdZn3K/LgMlj/oK39J8j8pE/lNwYLgfmbOXu/HF50og7DADYiwK1j8/v6TYUVrA0ir7FBZ09wMbCMNdr3ZSCFiPJcV0wDVvBkn+iYj8MXsrHnzDYnKMxvsIZsHfZAOmJCcWkuKJmrqFgIK25QSUsht5vo/tOwNgo/3nYtg4RKuaXenDhh8nyMnT1j7v2PVZ9GNfjw+sm0MmhFLklLB3tk45139XUyIeYYZorcBFrXXonV1E+GbBGrsQtcbQH/H5gtwprUJCGYQQ7KPwugv9rL9CCXfFzcLlD5LCJ3NogYG9+ojRI8O3Ma4llzNmxjh/ufDEmgwGmPR4T6rsTqUYpbWVhHY3C4OajZD67lqg8q/T83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4091
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f7b2623c-8fc2-4740-0ad8-08d86484ba69
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfbbpIaF+8mFdy7jIbEbq1RcY/8ZxdWsqBziz1PkmQvlyxYYlvFxHkakrSkqaHdOHWe/GBr1pxscruN8NePjZTWunSdPF8hzFPHB8P/LCIewFJTNhHNZ3J9V8KfxSLmZepDUQLfTnTXtOHJOWb+6Nu08ZM+sKBn729erMfchHxWHVvubt61au86+k2JNO7glg2jlv8nI0CYNjRAHsDF9zeLr/KUai/4Xcm6AoVd9lWMyu+lRmQqByNYfqgX2aXszSk0T+qYx7E3O9K2hFPug5fDv8Pc2BNwH86acTypSUDE9oKypaHohHaYONGe2HqgICXv8egdVH0QblQlQTmYzRcG2279AaZA57DiEG7mvr843Ej8LzCGFRba8Z2MvW9dhy8aTTHBBaC9DFuFolx7sfDGgi0G4UACLuIeHuhJTBux2llvNmawEI6cXxH8nfcbaulEaPUD52IxooIVU7i8xpmrO143oPnFezyFApZMYR6qqhiJABcWL0rt/GDdl2eD7+Yt3BrW/YyTK65IMYs53neC+5sGlSqtetmNAQqETLrAgS04dHhotbsbXRZVWQtrr
X-Forefront-Antispam-Report: CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(39830400003)(396003)(376002)(346002)(46966005)(956004)(7596003)(70586007)(70206006)(7636003)(6916009)(186003)(6486002)(316002)(54906003)(82310400003)(6512007)(44832011)(26005)(6506007)(8936002)(356005)(4326008)(47076004)(33310700002)(508600001)(16526019)(83380400001)(2616005)(966005)(107886003)(6666004)(336012)(86362001)(1076003)(36756003)(8676002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:34:15.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0615bd5f-1240-4b77-0d89-08d86484be41
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2346
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to automate the verification of DT nodes convert lm75.txt to
lm75.yaml.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
v2: Fix the example to pass `make dt_binding_check`
---
 .../devicetree/bindings/hwmon/lm75.txt        | 39 ------------
 .../devicetree/bindings/hwmon/lm75.yaml       | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentati=
on/devicetree/bindings/hwmon/lm75.txt
deleted file mode 100644
index 273616702c51..000000000000
--- a/Documentation/devicetree/bindings/hwmon/lm75.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-*LM75 hwmon sensor.
-
-Required properties:
-- compatible: manufacturer and chip name, one of
-		"adi,adt75",
-		"dallas,ds1775",
-		"dallas,ds75",
-		"dallas,ds7505",
-		"gmt,g751",
-		"national,lm75",
-		"national,lm75a",
-		"national,lm75b",
-		"maxim,max6625",
-		"maxim,max6626",
-		"maxim,max31725",
-		"maxim,max31726",
-		"maxim,mcp980x",
-		"nxp,pct2075",
-		"st,stds75",
-		"st,stlm75",
-		"microchip,tcn75",
-		"ti,tmp100",
-		"ti,tmp101",
-		"ti,tmp105",
-		"ti,tmp112",
-		"ti,tmp175",
-		"ti,tmp275",
-		"ti,tmp75",
-		"ti,tmp75b",
-		"ti,tmp75c",
-
-- reg: I2C bus address of the device
-
-Example:
-
-sensor@48 {
-	compatible =3D "st,stlm75";
-	reg =3D <0x48>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
new file mode 100644
index 000000000000..203829c6ba6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/lm75.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LM75 hwmon sensor
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+properties:
+  compatible:
+    enum:
+      - adi,adt75
+      - dallas,ds1775
+      - dallas,ds75
+      - dallas,ds7505
+      - gmt,g751
+      - national,lm75
+      - national,lm75a
+      - national,lm75b
+      - maxim,max6625
+      - maxim,max6626
+      - maxim,max31725
+      - maxim,max31726
+      - maxim,mcp980x
+      - nxp,pct2075
+      - st,stds75
+      - st,stlm75
+      - microchip,tcn75
+      - ti,tmp100
+      - ti,tmp101
+      - ti,tmp105
+      - ti,tmp112
+      - ti,tmp175
+      - ti,tmp275
+      - ti,tmp75
+      - ti,tmp75b
+      - ti,tmp75c
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      sensor@48 {
+        compatible =3D "st,stlm75";
+        reg =3D <0x48>;
+      };
+    };
--=20
2.25.1

