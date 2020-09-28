Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C969E27B10B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1Pju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:39:50 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com ([40.107.2.121]:16954
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbgI1Pjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFEhN/WRcPt4MpNvUaMJYWGwxN8clx2Cr4/SKfydEzQ=;
 b=bbHNcHr3Lyec8T/tsHULyqqbrl7OG8AZ35mz31QXpROYK3WghnLxG7efLCIrYalQFHrQJjRz0ZIjtKYjv6N/TNpqf5KPbKT129R+OO7KnqS4ejPCrNXPgvSDwk8W9in+1I3AnUC2h0A5R2MzmcedmMNIZG1w5CdPkuovPp9ojCI=
Received: from AM6PR04CA0066.eurprd04.prod.outlook.com (2603:10a6:20b:f0::43)
 by VI1PR10MB1872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:34::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 15:39:44 +0000
Received: from AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::6d) by AM6PR04CA0066.outlook.office365.com
 (2603:10a6:20b:f0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Mon, 28 Sep 2020 15:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT008.mail.protection.outlook.com (10.152.16.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 15:39:42 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.55) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 28 Sep 2020 15:39:43 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 11870583
X-ExclaimerImprintLatency: 834633
X-ExclaimerImprintAction: ceff1760ca7041eeb30bad8b60e6137d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFoFtjQWtxuIZobMarBLvcsM18JO7rQYQwXFRt9hg5FZZYSvUSugPm5mboiJBZq4ZraLuRu3QJfpWfc/p9Ac0a9na4Sqip8R5Lke8k/M8XviM95ng/12YpED8xeJab+5/lKay/rhe3y5m5OL1WWUgqWvQDIFhGdpLwT/FUvAPau3jfQTdI/Satkv9pt2vrGGja+CTXAdKF0FAL/Jos8BJlLLnTFpa7sVgITIUePWRioT/cDLe02SVxkSEInv9v96S0wcD7eTVTCIVU8fPTYgyhxgz2LoxpD5wijyGhuJLcYCshmuP313qP045ShNAbgeY8vHV9KFovcPL3j81OkFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tse0wXwbIIq/t7bYSJvBaJ8fOCX4aerZ7/GCyqdAHyQ=;
 b=nVB3qW18mVDYIRjPxW1OP/i6MAHQo++9tJtklALwhYn9IrTaAkkxIxO6oFmwFo8XUxl5eIMnSbWBxkvCnid0yfiEAXrLJQru00ZLkOUlP3iPIO421Njf8uFWltBWWdHM4KR8kCB1PVIVC+JRJ8Gkq/Q9HUaClq4QA8ocptlSQYI41CbNA60eD3+XJIehQGyOpquV9SWTKCFpgI+MgzqfagJlX43fDxZs2rj1/baadvnzfwrNlRrPOWwGroE7W53Kt8p9BkRPKArs8g+tUFJlxYDzrF0MQtFsuWDttddno1JYc3gzbi9YZbpdpBqbd4clpsfWhP+wy+oZVOR+cucbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tse0wXwbIIq/t7bYSJvBaJ8fOCX4aerZ7/GCyqdAHyQ=;
 b=C5StRfL0YSjSYFEIbR1VxVQLzSHj38TF9/mikhwyjnZZHrPaSR2f97sGpSHU5In/M4m5LqkdiLhJWTotLE6kk/ek2wTz4Zcwpfl8dHcKl/5HUV9sJfooqusNY0rlK66EEoaJKIHfuaiXmyMxfz1rQhQEFqgqgl9bt5SmLhGNMDE=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB3057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:162::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 15:39:40 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:39:40 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v2 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Date:   Mon, 28 Sep 2020 17:39:21 +0200
Message-ID: <20200928153923.134151-2-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928153923.134151-1-alban.bedel@aerq.com>
References: <20200928153923.134151-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::25) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.aerq.local (62.214.82.242) by AM4P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 15:39:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [62.214.82.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b04d53-653d-4506-3d17-08d863c4b8d5
X-MS-TrafficTypeDiagnostic: AM0PR10MB3057:|VI1PR10MB1872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB1872010E6ED7DF7D885AE3F496350@VI1PR10MB1872.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uzVWpOmZASwMQQKHYM3gSIxNvfz5Hxb1yAHPpTWOFUgG4My6WZkKoLmoV34Qdc3cgjV2NbwTBlKz7fR/C5nnMxDnCP9ruKmRfpopZSonQ9F9rpdeSc5NiTyJi7z6kRedTPy3QesTkFu1HFemuwFnmEYQFgBSEBGTH1EHonm98cWAUUC4JrDIlmUq3TFgyUn34x+e4u9SZuj828h7Wj9gXf3v1hN7OOOwfKa6nszFSBtXjq3BeN5HWEkhogaghca2/zg1WYDKmlNR84il1fVUDPl267nrCMCaGs4q3SkzOG7tyElptqfth5vhZyJc/K9rTLJ4C4S+1JsXote/wREchcsWwHVyQ2dOAHPghvXh8AxZq8UfVk4wBKLTvj9FRUaZKrDRmkT28nQy3KPhXOhexZQ75Paxec4pPpVlNqjtCBWjUHJtIqDav35VsrRDMR49dh63deiQQb5OsE18CmgdLA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(39840400004)(366004)(396003)(136003)(6506007)(316002)(4326008)(5660300002)(66476007)(66556008)(16526019)(186003)(6512007)(26005)(6486002)(1076003)(6666004)(66946007)(83380400001)(8936002)(36756003)(86362001)(8676002)(54906003)(107886003)(52116002)(966005)(478600001)(2906002)(44832011)(956004)(2616005)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /YxoQ/VlJFjN0hZjzUo6FX8doQoBtkKSPJr4jkAfTDG0pZUCOGP1GLCZ5Lp2DCK3/dlE6Q0b9fXErD5ZQpflhcNHNvFhCwceeT3UAKppaCEy3nUARgtILporB23/DL8fRLsDnJLPl9p+DQoK9gS/bZkM9Fjn6Ty9XppRiUL/2mBgSbtXNDogs88YrZJ0FO2ZU3+2PXtp/ypZYF/iV1VF96gnf0iSIxjs+jXE9hrSNucHrM5cqF8hpDeioHxUrSihlfQd+sQDukXrQv3f4ezfq4a5g1gk1/xfwI5MXD+lnCKs7v6V22/7M8wTl13jwrO/VsfF+W52fptLEbaLNf45TMieVs80w+Opysqi/lrEYyB+WIJb0tDYLcNoAjONatcHJFwvO/QlSCHMuJld7SqphB5wPWlLGAbPQZRUI6GDsMtFVqdUF53ibU35PoQEFcM0IfRxmNPtR5YTXN2Ev4acT8dHB9ya5XfEFLelg3fRChGv864uaMDL6+jEQuFU5gwltFbzQHCW14WEs6E1F/AljoqE3Y0eX8sfdR6zrZayruJGH2irYFxg9EoNV6vhid8kZP65YG4kVVrTJ8KfSqvkQExF6rI0LMBhuuQlf30kjYDjk9C6m5svO3RgDZcWsWI3ZOwja/FCXLf7ejyudfOGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3057
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 356cf57b-d4d1-44aa-6cfa-08d863c4b677
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoYE+tIyYA5xBrgC3o4TTIxic1h/pG0LZE0dA52ptA0yd6myMD3Sm2xFSrKCWOyYXkbyx9WNFNONlrObqsz5SRjpJQwl6NvqfOTlVoEUF/+iDtVGDSG1x5+98N4Hw7FTi3yRNHT2ggEmIKFDgt6n1crVOEqDYhdnSSt09Ou0DO+/6Xy66L+BmHEcQLJotxDjWUA88DzwqDJCiCBYk3g3i9pCf5EhB1gytoh4lpCWvng9W1YDw2GoIKdJI/ki4fWbc6M8RnFevPmFtfLqEeq48ukls51wLl0K4Dg4GetUn+m8vUQUh49vfC6AQbagFuT8rUFcIaN8kK/vT+0g+nxTEK9iZJX2tCVfkainYUjgOHxGCAfSeWMR1GGEyY2AN/HiOuSvtHVJxBSFNZXSb08YhmzRLYuWwCfhltTM0T5KjaFgJvNphQRLq+ZlEfPg7M+pKNJbU3mzEXGNdKILppl80c0KgKhyrYyfp4IAuQsmP0eedM7WEDNA+CPSMRGmR1kD9CuqvXSV7xhC5qkk+ULcsj6nAxFZVsXaOjBbd4+Qf4oJFiQvuGNrIq/4src1trLk
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(136003)(346002)(376002)(39840400004)(396003)(46966005)(70586007)(33310700002)(2906002)(966005)(2616005)(83380400001)(8676002)(47076004)(4326008)(8936002)(356005)(478600001)(36756003)(5660300002)(1076003)(86362001)(6666004)(107886003)(336012)(316002)(54906003)(956004)(16526019)(70206006)(7596003)(7636003)(6486002)(186003)(6916009)(26005)(6512007)(44832011)(6506007)(82310400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 15:39:42.9991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b04d53-653d-4506-3d17-08d863c4b8d5
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1872
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

