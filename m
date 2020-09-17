Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358DF26D8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIQKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:20:04 -0400
Received: from mail-db8eur05on2119.outbound.protection.outlook.com ([40.107.20.119]:54455
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgIQKTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ977mz7TTYtdDVXfM3bE7TODp8VeiEX4V9gCWEAhL8=;
 b=FDAHNdZM2xC4Fy2y1lpTjJfO0GBQCnZJ1ai+zDZEiHLzLys5zgUXL8b8A6GYcUNJEMVyOL5GNz8++gdp13g5eXde3d6JgNevDxI+TPlHpEymNiAPz6hb8cAhJVVAx8esqLOhINQm/ZpHJxZnujhlK1Jk+yTkipPnjlpDZdRoPK0=
Received: from AM5PR1001CA0051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::28) by AM6PR10MB2872.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:e1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 10:18:54 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:15:cafe::7b) by AM5PR1001CA0051.outlook.office365.com
 (2603:10a6:206:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 10:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 10:18:53 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.53) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 17 Sep 2020 10:18:54 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12468553
X-ExclaimerImprintLatency: 1050382
X-ExclaimerImprintAction: 8caefc70cd9f4bdbb7c209eac0069768
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1GHJDR8jMxNTbMVHq4Zm5euQNsQs2LKJwxOizRxIutNBLPaQThJSsZm7XGUoJxK4EfAMUG9DOa/pPjvT3cZSYb9h43e9P95FTRE3Ek5AChomAtGqml0jCvDZz808eax0nvUavGVFJSnkZTlkgczPVdYlWcR01DWIfiurLnBupF12Q26pYuuACsfR5HJZaIOU6y/9lI/jiC/JJq5VSA77saNNybMnxdM1XFcXCEZ14rbg74K2GrJo8pKaI8CPOBSD28z+tO3ujribfzjnMr06JrExs5EEnmjpsvYiM2qiE4pbbYkf9osNblaw/G+r6/scUhdGuD/40/E2eEiFaBSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PdSlg0o8uvCvhTk8r7zTqPcI+y5TPkVdX2YoDaE+eQ=;
 b=efBKQTZUGTATmZK8R75RzuEKMBWu1ciIQ8wyzI51jbc149F98et5jT4x9e5zC4rGvc29WBM3mvPRuYY2BnujFbez9/Kg+L1iCgWZ9D2C7ZZLXl4b4ZqOXeI2WQXfVz3nnLiIR96LU58fLO6W/u7M44ZO5TQH/GlSIy10myj+I0fLD8NWEpBH3Me95B/X73RysluwIjxPxSXF652m3mlR8TL81olU01ZT8JWVQ4aViAjbs/bCKeHbFn6Bu7sQey0eGRp/qmWN7RhhlFiiMKGrhHaQ+IKFFmGogFFZlwmQtzSiyDuHQwpuz5SzcY6DCD6R1Fdq/OzZ6s3OHm+f4c+ZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PdSlg0o8uvCvhTk8r7zTqPcI+y5TPkVdX2YoDaE+eQ=;
 b=DRWtXCpGT0wODouq0o3EZ9veNdAEwpIET2UhnPIoBJA/p9dqCU/fDADXL+otRmKK0rSptaLHXUTBPPpLZ6eFgqU9ya0FSu4CuLHeidWFTqjpZu5zEMwSNBQ8ZSxAJWp0aJ6K8i0Ynm68kU4IkyHRTvUFnsqAQbgd6Hb7NyMmtag=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM8PR10MB3987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 10:18:48 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 10:18:48 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Date:   Thu, 17 Sep 2020 12:18:17 +0200
Message-ID: <20200917101819.32045-2-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917101819.32045-1-alban.bedel@aerq.com>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0017.eurprd07.prod.outlook.com
 (2603:10a6:203:51::27) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (87.123.201.53) by AM5PR0701CA0017.eurprd07.prod.outlook.com (2603:10a6:203:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 10:18:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [87.123.201.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39a41f1-b327-4d38-9176-08d85af314d5
X-MS-TrafficTypeDiagnostic: AM8PR10MB3987:|AM6PR10MB2872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR10MB28728B3AAFBA372EBA0FBADB963E0@AM6PR10MB2872.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Vz3whrk5UsyknyaBPw8Lb2jD8MhrFjLvCWSKq2EFYxbDNP3OQvVgleNQAQqDCEAIemIbfsny3nC3qjl4Ehl9fujL4SlihPEPxtvWM7Byp5QZPvAIYEZN0sPvqA1WeYGRWUQXbW+6c6ikzPkGICrvQVrQmz53qbwUB9VkqjyS0S4vraa0jHxz79ZpSodkgdhcofLy43ac1FQdHIA+bA31tsukkqkzAnyu5gJvaktJZIMACCSJ9myb/tAr+oMBd/t1/2zo/11jdNyEnmRtkGlP6UQzFe1SZHD28RGnzmI9cmqqcMvZ+umfBpBZR+jgoDGo42h5YCeYTTdAUow3ppu1lujXMqMJunFIJmnDYCiys09ADFr2/2YQ+3vNzcCQlnfpZK07+ctO8+x5j7KGiiyTBg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39840400004)(1076003)(83380400001)(36756003)(66946007)(66556008)(66476007)(44832011)(316002)(6506007)(8676002)(107886003)(2616005)(956004)(4326008)(52116002)(6666004)(16526019)(26005)(5660300002)(966005)(186003)(54906003)(86362001)(2906002)(478600001)(6486002)(6512007)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bs+Q61k33QfF5airUBROJRYSUIn7QvEyTv3shktqvnoU0j47tcZ79Ct3ps8f2AmLoYkqb+SozxZWti2jD2y+c8w73oqYN7OWzSPhcKcWQS3H5eh2UWvE+mMx3U+TUbJ73hK0yJJGc5Z1QudqDNL6l87w4GTIA0xxe8dMT28ziQilAuPUnYL6vjr4hBz9Z1McITAqXujgvwflfGg51U0nH+c6NQcZD4ZBTdrBlEAXB6PcI3oUBUeoQnYWJVxnrAnvAPYr6/Kst6vi5ZZmdH5MpRG48PSilLaqVM8VpYjeICYrEwzIs6HHp014DHu1/xVsuTelBB604a9uOJF8j3JuCOqo5agLFrap+0O5mlIaUD7G4z2WJU2RCO5P14DzMXpjdLhQwBSuxedkQDK31plsEtwtUzvs0lwMRbOxq9xDFqjvOsnevN7ZpLUdlDZw670tlLdgfj6c4LH7moV+HJAOZy40wENvdiJex9/pGX15AaBgTQEor5tK2TKGd2IB6m/CkAaovAxrGxum+HsFXba2CHGWUrrZqFfIZCBooHQarJVwzZtLXtcs9R9Ql4giOlc25wdPUmvh1gpklSnJJJZZ9RMAoi6eLzxP6/rZc2rekETRYGKXfO1uhCFfZGYFAIlau+C23gCoCmfzX8MOqKgVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3987
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b8232298-20ca-4ca4-8353-08d85af3113d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBQ9xN9VgE8nK9JR7nwz7fRWJTYXpWWp3TfqpA795ZIRG4B725jJXbE8q/4aJ3c3Ss+rpZ6RRyLChR1e72Qk4f1KaaEzuK5N8TjVyrYkYXgqCj9n+g+mbR/IAMguyT2CYkUgZqrmkNX1dRCZjjS8YfB6MGpyIgeUbvZYqXiNsT98nQ8mlZ+9nmMtLzoRSXUTdKjBLVqdvk6qyaYbGUf3j3/XbcbCB7J+wY9cpsPlraN9NvhfO16UbK5p6eM1qr27HVeLkrcIyXZQue+IY9hgBOL1cBLlORYKhT80s3jy22EN1I0U50vUKtCyXT5UomMBf8tC/RsJa/OAGk4D0Zqje5fasmCQ/6cGFimc2zQnFtUlEsPvzbjgEzN+l6tqPH4+P6Rlu2IpdaaYcsUm1oDSSV+HSdMZKl6CxL6G0pcD2G8zPJXkNtlBErPGMNvXrX3I/M+56j4qC+j7tR7x1BbH95HwO9emgaW7VpavvfJEDxHM1rzel+7b+enPeRzNIwV+
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(136003)(396003)(39840400004)(376002)(346002)(46966005)(6506007)(70206006)(82310400003)(36756003)(2906002)(54906003)(1076003)(8676002)(7596003)(33310700002)(83380400001)(47076004)(7636003)(356005)(44832011)(70586007)(5660300002)(2616005)(16526019)(186003)(107886003)(956004)(6666004)(316002)(86362001)(478600001)(26005)(4326008)(6512007)(6486002)(336012)(8936002)(6916009)(966005);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 10:18:53.6903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39a41f1-b327-4d38-9176-08d85af314d5
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2872
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to automate the verification of DT nodes convert lm75.txt to
lm75.yaml.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
 .../devicetree/bindings/hwmon/lm75.txt        | 39 -------------
 .../devicetree/bindings/hwmon/lm75.yaml       | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 39 deletions(-)
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
index 000000000000..78d6291fcdcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -0,0 +1,55 @@
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
+    sensor@48 {
+            compatible =3D "st,stlm75";
+            reg =3D <0x48>;
+    };
--=20
2.25.1

