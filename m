Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90882801D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbgJAO6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:58:01 -0400
Received: from mail-am6eur05on2120.outbound.protection.outlook.com ([40.107.22.120]:18209
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732672AbgJAO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEpIzpHojeXETkubthYdVRgIEi+fmh7wLV5WtdxHTyk=;
 b=IDndTGW2zr/YwlrGNKi+/qZLlzjm8pU4cuYn0kByrRBcgHfxN7gYNWwGt5nWLOiDVVVBfY/tS+1zEowNo5nmesxxCa8EsLCmy15HV4vjhYwlxQuKdtr8G4omDQjysRYHOWUOL8PAUVM3aE5X/kI43MQRmCtCc74V3PuXHSe2Ap4=
Received: from AM6P191CA0060.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::37)
 by AM4PR1001MB1235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 1 Oct
 2020 14:57:55 +0000
Received: from AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::d3) by AM6P191CA0060.outlook.office365.com
 (2603:10a6:209:7f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Thu, 1 Oct 2020 14:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT022.mail.protection.outlook.com (10.152.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 14:57:54 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.54) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 1 Oct 2020 14:57:54 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12816451
X-ExclaimerImprintLatency: 891514
X-ExclaimerImprintAction: ddecfb2005b04c259bca033a120ecf6f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO9m7wmdTHgIW4ehCL22l7KJcMj/8L0xdIEr3HSYBPO6jCbtp6NwAn1vWJ2brIU8qI+h+I8ooYH33cH2+TeF4L3BMOsMx85RyKHq0BRVqj0GaHCTaV+aEbPeDvlwS7JA5atcaLqfjDzMz2rlcXFNBMQkXf+7DeB59dti1gOEZc2oEidYxz3AZ1cPU7Ydghhp1h5dB1Dg6xVXBYf26oqHbB9gcDZjDQ3JMFV2/hqjkGHwPppt9/r20qZQysEdHrybphvj4xsihVMe3WvzW9qkcBQPsRWmptDOy4DogL2SaUG3C2CUNOJygj5gW92219JaJ/Jw0U19JeB099jzx2a6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB9hu3UpPOV3pK7xa6wLzo7woMH7r3/EabKIE/e+RZw=;
 b=Iqfm1OonsMrXQUvXf+9in0Dl8lX9Sgb35qqnOEkQoeZd4PXf7PgQ3vJUsemTMjsMaxKB/Q1CLQJErmEA5ejMg5DWaXF6g3Zczcg2akNKFCAT5V98pXr/V6ar1qRJbqIxBM8pbpg4PEnBgi/CmSYZ9MXG1botDxuLLyTEkHfAIouyzlyQiJKnJ9H9rHOeiWrO+xisOerIyVW0L/pol88EwiOj3O17djVvMHYc9jwLfE16VEWjGcXe72oIJT/Kz1GSqPLeWfXMJz8cSQfHrxKcWpyhdwDbNN6Xv3klGDJAVtC3QFlbXfduf1oCHUvXKX2C+nPhDcrL+boCg/RXDpHbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB9hu3UpPOV3pK7xa6wLzo7woMH7r3/EabKIE/e+RZw=;
 b=GOXAK/7WsK3F/Yfh8VnwSQElxhqtEpHa7oyM68fcs06k07vsG45fy3B27csheh74z8R8ZEZHGkYfqsf9in51jEC+opj8nAIe1vyI5s/cvG1lqInUBhi4uv/WBnsXcbnkhNX/M/Cv3i4NyvkH87pg1+ciOCRTEwrSpffPqiHx6Sc=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB2417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 14:57:49 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:57:49 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
Date:   Thu,  1 Oct 2020 16:57:37 +0200
Message-ID: <20201001145738.17326-3-alban.bedel@aerq.com>
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
Received: from aerq-nb-1030.dotsec.gv (87.123.201.111) by AM0PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:208:ab::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 14:57:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b090d18-0901-403a-ac80-08d8661a60a9
X-MS-TrafficTypeDiagnostic: AM0PR10MB2417:|AM4PR1001MB1235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR1001MB12353027AE6BCFB95FE5819796300@AM4PR1001MB1235.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /J+Xeb+Es+N/M1Pvk549pAM2Bdi8PF3cYAS60OOhUOIu4P4IiiTVteX6aRfeI+0LU3UHjVRjrPWw03NaovUGXbrETRAReBxgb3AeW6DpP3udD2Vq8wrbuT8ilNWBqoYVntT3Iy0His9RV0m8UHsy7R0BnHNMbst7Q9dakB/pIgERoUWohYU2T/YYpj35HNhYO/ITxz00ogAQLrqZcho7KieDI4Jmk6rMAWe1OjQB95i1/bBfbxWvv1Mlyu2WPi2p3fhg3i3ijzT+5XrC/wXF2aYzRiUJYYMZc1v9YJwAv4ZEwTzU8tO/To7y6snGnij7nncNuGoFVwQutAH1pvjP9Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(136003)(346002)(376002)(8936002)(26005)(4326008)(36756003)(5660300002)(54906003)(8676002)(2616005)(86362001)(186003)(478600001)(16526019)(6486002)(52116002)(6506007)(44832011)(66946007)(2906002)(6666004)(6916009)(316002)(956004)(6512007)(1076003)(66556008)(66476007)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: P4y8yvQ206yGmbkNFw2y+Yf6YguOIbv574laQDY2cIIJaklzzSBk7U5iW0+YUaFJ6B3nRgSQtH3s9fRVt+ie90TLSLhc+c0ZBc0z05vv4VxyCPwX3UHwoKsdAIzVs284i3oiV44wlNTsJMC+5+H9AdkFY2APsqXmGlfK/l0fxo4yx479Z64W5bO3T8HcSYxz99mxe7RfFn6sL6WcspmRbYMlMYxpXVVqTIBVumRYthhIsGnSA1PoDLV9QS43d06EW1iRTx6FtW+udNNjjlzL8yTtW3gcWDhlLYRreqp1QnNwWkZOV/4rY0AeY3sjyoyVmmusTU8l4DSBQHG1mggI7YDRNICo5a+xLrh1dQg9XGvQkykOl5qW2iadxusoVH8iirpkkhpPB9JetHHNB+YnCUjYACpNVX3LCC2w0auQwWR1gLoGlr3TXnpvmdUe0NhhPzlPtUuqKvy6hfvZt7imSaKWquPfwBo6nrPSeujddF1cNnHIsdCZ7e/odwLdg/ukmoZdIE2ybZYZZogk/AvZQ/rxqa26hqWcnFkueGua/hdfnvOAvIUUfOklDb86u1b5e0aJ/9P8fCSWHaSgnKWmysCBQYhHFABErwqNKzyBXiPlQ+EyYx3e06N974WGd1t0lyy4qdAdLzD+plv3UvV6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2417
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 065f431a-16bb-4846-e8c3-08d8661a5cec
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJKQo95z7HB9bJsGwzc3fUIXfjO7TfB3mfJtyMgRicaYc1U3wPlw/QI8PcYIoT02ZAXabAy66xAyzr3vGyzoVCuC9sSwOaGwiecSKzWuhUIiHd78c0a+934Nq65nZwzlqvu0V6SITZzSOQjwjZ0SCQkmGzj0XnqWv+gwicKmEezEQt0qmLxwIG3iP2AqccRWISReERao18DZnEd1d/zfUOIvEacumh/R6XySMyPDhdNu1b9A+SzBUyrSOvL4IwTRqZf5dsF7hYnow+TcbtjPnf/rexurohwxjNZqmAlzyLL1QrU3d3Mina0zRoHnKeSY4FkRrXEaPxC/OJTU/CzaKykQLsSNPeEzpRQJ4Ke1IW91NTQNxfcajHiOI0gWmRSjoNWubLOaruqWuQdkyThpL07xf0VyvilxyhUwbQMDEXKLx3/TAM046vgg7qZgXw/+VouBiQA6TVCA3XtjBj2sj8Q/mcLWvUdkujicQX3JKfI=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(39840400004)(136003)(396003)(346002)(376002)(46966005)(33310700002)(6916009)(4744005)(54906003)(5660300002)(7596003)(8936002)(36756003)(2906002)(82310400003)(2616005)(956004)(336012)(6512007)(8676002)(186003)(478600001)(16526019)(7636003)(26005)(44832011)(1076003)(47076004)(6506007)(6666004)(356005)(316002)(6486002)(4326008)(70586007)(70206006)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:57:54.1054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b090d18-0901-403a-ac80-08d8661a60a9
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards might have a regulator that control the +VS supply, add it
to the bindings.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2: Removed the unneeded `maxItems` attribute
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index c9a001627945..96eed5cc7841 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -43,6 +43,9 @@ properties:
   reg:
     maxItems: 1
=20
+  vs-supply:
+    description: phandle to the regulator that provides the +VS supply
+
 required:
   - compatible
   - reg
@@ -58,5 +61,6 @@ examples:
       sensor@48 {
         compatible =3D "st,stlm75";
         reg =3D <0x48>;
+        vs-supply =3D <&vs>;
       };
     };
--=20
2.25.1

