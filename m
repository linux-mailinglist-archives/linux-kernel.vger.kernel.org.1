Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5392801D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgJAO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:58:05 -0400
Received: from mail-vi1eur05on2114.outbound.protection.outlook.com ([40.107.21.114]:57345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732651AbgJAO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UELcrPw48FFcRhWF90F5IN3yeLj+5uVkf0hQzSyLkrE=;
 b=U6oqih1RtL0pAg1xOo/bIQwMI6ddxtQ8udLWk5MTxw0mRtqKB8348I1LbOxiWljLZsBUJBLaPIbs6msY7Xlf+5luNZPIN8voFwGuoH8pSk7M/PYag7jcpMAwNdSriNTY8OUAoOVQCXUf1uEgXe9Kxwfi/+K9kBIRGroBZjY4in8=
Received: from AM5PR0601CA0047.eurprd06.prod.outlook.com
 (2603:10a6:203:68::33) by AM9PR10MB4054.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 14:57:54 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::53) by AM5PR0601CA0047.outlook.office365.com
 (2603:10a6:203:68::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Thu, 1 Oct 2020 14:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 14:57:52 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.58) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 1 Oct 2020 14:57:53 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 15810913
X-ExclaimerImprintLatency: 561752
X-ExclaimerImprintAction: 0604c53072d04f27a1197d6f4a8c7fec
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8VfiMcuh95alu82gE4TYhxSKGJ2lKX2QBIL32HANWbuY0M7F4pmDDuHFnx/JisMca5N3UwtmhxojloapEtfR/EGnLESZTCd9eR9AT650bFQcQrJLsYak8xR9nyV8HQCYP1h5HcuwkFoUtODmooUeyGe7P1eFf6RIPdKSbfVbFLc1Fu9elvGSdSJZ1oNfvx1kUNms9Gs1tKH754z+ZCe9AXGH1aSXO5WDmipgTZFMOMeV7QCEDmz6OplsNjvoKg972GP38GdswSyXEGRzkXcoWU6V9rJY/4CN9Z6S/mAnrtNhAeTvFZ5uc0hkZW5tp5b5oIwJVF3gZZsfTAMcWg5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wy/q/txcnXiXFU0xysDseF/4EnXR11ZYgtN0o99qpE=;
 b=SsxrB934xP/+iWdbn5s5UWJTstcBtclstraazBwhzrwqWKKuDlG/I0MToCXwIuLMLrKLHK0uzYP8mh3cN6bN6j5eB9/0d4A5iv9fEuY/26shqHwhpMTsmT0/VmX+2Pez/1+j8UaPDjoZEDOjLG2hZUY4Nmq2avEuTbrPWhRWIognMt7VfFxnnI1viljxG05JatkvvwJjzUXrgyn7p9RFU4EHX4caHifUqjLoKVB9UhkZ/8RptKjZc61+FOA8awp/M0bTcDKTrL+sSU4IfkAXN2gqb3FeRhTQs/SGadcueYzUZHLmEEy069HID6RM4Dz8Ih+iSwuNKUGfrwudkw0sjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wy/q/txcnXiXFU0xysDseF/4EnXR11ZYgtN0o99qpE=;
 b=X3IIQAQdEYOoteBcV5Pc5r2bicqlGo9a/EZgOmNorrC6enNISPAZqPPtjwoZLaAeFkIUSlUFm6FXZv8F2DtODhg7ZMqjekWZy4DtFQQQ3qlXHxD3Xjte2UcBVN2hTNg0crULKhv/5eYEjWvKS94PhBNE3oaewy+Dx+bA9eIMjQo=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB2417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 14:57:48 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:57:48 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v4 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Date:   Thu,  1 Oct 2020 16:57:36 +0200
Message-ID: <20201001145738.17326-2-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001145738.17326-1-alban.bedel@aerq.com>
References: <20201001145738.17326-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [87.123.201.111]
X-ClientProxiedBy: AM0PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::26) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (87.123.201.111) by AM0PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:208:ab::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 14:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b37ca4da-d197-400b-cf4b-08d8661a5fe2
X-MS-TrafficTypeDiagnostic: AM0PR10MB2417:|AM9PR10MB4054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR10MB405418CF37DF555F019903E696300@AM9PR10MB4054.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /4P6ASgh36WEbRCm27z8SF1UpIoVqSUgPWmM7RBiy7S51C3Bu6X0WE//+84Ch1OUPVDEVpHEwBbayYEPU1bSQ56R9jT18a474o7Nvc9G0khK0l4/8Enkj+XvRi4UGVomE6gvHxR6DDyBBB5adhRDybKrxpNSQ7jpmHkImDkyuh3svjkFMDtlx+yekDswYWGSvuHVFJbYrq6Cx4kIjd+6DTWMAuE8mskXHyJDPhjviRN7e/eyNBdhz18WWOl/lIeN/PZJdhhC5MeaFSdH8HnOl0PxZN1UcEYxiBuVF/MprOBwuOvPC+jGn2WOEWWyEj8Z6MLnhb2z1Lcm2jDXlCrndISFH278GOTJU7wXf2mZGg+3kRmEcF+pbOkQGowThg9/xr1hbi3AMuCsLhoUpQWvlg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(136003)(346002)(376002)(8936002)(26005)(4326008)(36756003)(5660300002)(54906003)(8676002)(2616005)(86362001)(186003)(478600001)(16526019)(6486002)(52116002)(6506007)(44832011)(83380400001)(66946007)(83080400001)(2906002)(6666004)(966005)(6916009)(316002)(956004)(6512007)(1076003)(66556008)(66476007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5OtDPT/WRdeYXJQJsLr71yaVQQiHKEw5Wz2+ZFL33bnbwIWp7O+aqeqOfPttd1O8XdX/0h8/AfXIFVyi1HUik79hpm4/hkdcYbAeUpV+k3ntNN22V6hcU8hbhjV+rrb68m5ISXs/dVLWffDerlu05HwaBAcdpOxk5GQ4p3FgWeV0pKf3RdDV1WWNQqIXx1lgR+/TIMC9EtKUrKY6g7YiHTI0qP1+wA0i5Eg9O/a8QKvkw0eAnEgp8T8M1JiJ0c3qSdZU8wzJknp9b309NdHF2fXrxg4iMbMmlkn1faYam3SBps5RA4Ioe4q0i0K/Ca2cz5LdrL/D1pJK4wLV1yQf9YgX+YNGwlx8oerhqMC1iIUxm6EhbSVV9wQr4ltcKLukjbAPtsMONMX2R9Z3/gknoOWzPVo7wd5QKYqPiAnSg8ipFXYw+8j5kWBLBAZiZZK+Zfga4UF+ngnelu13byGc8VWlD6ankv+VnjG/Um11ohxzd5dMuPhhEiSpVFwrfcnF4hntD6Nvt2HM8nvp7rMFcmVPrLJg5nQMlYCvmDLEhtopytBFm3w64l0R6P6vAHasWcnk8CTrpqt9diNLz4SvNH8OIiotNU5wLByjMndr1QH8Mk4efUM7gxfPLZ/0A+V/lPPHLL9VHB/vzRShxvrQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2417
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0e929a3d-8b64-4dfd-5866-08d8661a5c7e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFpIFGKpegxe3BjW15P8cMmhUSgqeMxiuDWpA5QJ81zy2ZTO73jNcYqqePLEmlsSkUNMAnxnAr6m2eduJzUfzNnVEMfF2XL02cVv/ikpuv26GT0dLXgpn458GeTKokZ1AvHPmg777o77Vn014A9eR2C2usM2+Zcrg6LPKfJpc1w+C5fJa+tfg5nHDj+JwPN6YUk6MtPHRrFZhhqfGdxSy0bWV/xMBJGvq2T+EvaY0Cpub4FX0JaksFv3BFi69Ri9gSVisKR/vclVsnclAKgRCwNK8dGDkgg5yvD2iGpspHlIwQBYCQFnCVDEo+WcZ23MXywXkT1+IGU5edq5enuiFqzZzIXxjvxEnrpepSACmX0VwUuiRkJuxWbb/gRMGmO3vjsnKaxQch8XRAeJpsJ4CB1jcmA+pbHm7O+yYWyq5c3lAlT/POnztrFkhSYQbHPg6kHUSYRWvjU8tu6zJxgT5rJU8cETU3RD/iBFYwfsBz5PTCCL/OoCbn1n05rRMoea
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(346002)(396003)(39840400004)(376002)(136003)(46966005)(316002)(54906003)(6506007)(186003)(478600001)(966005)(86362001)(44832011)(70206006)(1076003)(70586007)(36756003)(6666004)(16526019)(26005)(5660300002)(6916009)(83080400001)(107886003)(6512007)(4326008)(2906002)(956004)(8936002)(6486002)(356005)(83380400001)(2616005)(82310400003)(336012)(7636003)(47076004)(33310700002)(7596003)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:57:52.7384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37ca4da-d197-400b-cf4b-08d8661a5fe2
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to automate the verification of DT nodes convert lm75.txt to
lm75.yaml.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
v2: Fix the example to pass `make dt_binding_check`
v4: Add the missing additionalProperties: false
---
 .../devicetree/bindings/hwmon/lm75.txt        | 39 ------------
 .../devicetree/bindings/hwmon/lm75.yaml       | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 39 deletions(-)
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
index 000000000000..c9a001627945
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -0,0 +1,62 @@
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
+additionalProperties: false
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

