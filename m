Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693D727D13E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgI2Oe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:34:27 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com ([40.107.15.133]:38465
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730216AbgI2OeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCntZ2lvum6p7VppqAZXy1On98ghYeHIaVKWHh76lFE=;
 b=MiqML0iH7Rt/zJKTWwwECzc5jebrXkgI68HkbETuWqXNRSvM0o9DF4KLVBPQ1xK8yhCCwebKJqEUtZgvt5iihb7X4MqBhwpljQZCGi9dZMkAbEn4wEoNlT4tRy8wi/YGCx9P5J5S1JQz1YezXmQruN42GlqpJyX8wyqQUPg8+K4=
Received: from DB6PR07CA0052.eurprd07.prod.outlook.com (2603:10a6:6:2a::14) by
 AM0PR10MB1907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Tue, 29 Sep 2020 14:34:17 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2a:cafe::25) by DB6PR07CA0052.outlook.office365.com
 (2603:10a6:6:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend
 Transport; Tue, 29 Sep 2020 14:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 14:34:16 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.54) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Tue, 29 Sep 2020 14:34:17 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 9908857
X-ExclaimerImprintLatency: 1502638
X-ExclaimerImprintAction: ea584690d30642c7b494840faf678b5e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2nL6bTdSCwWUtQrx3LmsZLT0W4JxLCIPUblF/G7B+cFLmSnD/Xhuq4kjhVZ6K+Jcbsn9REyOr8YR+Qw+E6AYkjjPh4Wmu535sFhROB2PhihApHDDiUnBtkGpK3CDLNGBR8dJgeYUZ7edkL5Xo3+sA4EdZONX5NB/Jp7NVsJLVx5NgwDRWarO2A0eFyAXg+I8hwXG/QYVAkydJs62BC7UuuQMXuKCBdpXI0d0uGS0BovHT2cPInlaK81IOZJGSXPB5moCA1SaW/myJOsTfqai8PEB0K5/lJXlsF1lNqBBzLGh0Faxws6NdJSbY63nPkDUzUOsMMBA4XepMPOiuahfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVESQKz14HZT47jbTNP3rZq5SzM02Mn6rOTCUSNGqQ=;
 b=K3RlKaRInxuiu+a3dpWv1Tx6NUVi7RHFYL1Q2W2zcW09BOxIERBbYEk9e5cJOl7ZvnDHJat6hUTJ9kad1obPlBuOryaKiOBfmNslx+2kqgEhMobQbw1IlZbzfKhV1LzH3Ycx3AKnJw4IWyrBKIl7sGcJ8ai4jttarIHvA88mhu5uinbF1SBSZzeOEVfNJBOzDjqkgd4ShstnUzMJktycd+aOqClmTlkV0d7dYLwG5FCHCSd4lWzXB/YlO0Jg9ry6hVHMgondx1+laL/KjtWHtMx2LJ/HDulMKgiJ2EO1ZYIpHXb2zPdjcUccKHiyDsQ7/J6jj1RAbz3055a3vmar/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVESQKz14HZT47jbTNP3rZq5SzM02Mn6rOTCUSNGqQ=;
 b=RWKHJ8XhlImZcxT57hOzKDptbIOl2m4Mq8ePmgXemCMMX88JsjQNFR4s2RFMXy6gyXbDGGAcRifECvPUVH68TtV8mnMTpFuCdrXuhlu7BjnlOWwJb1PNsETx8biqKNRmoyw5MoWHc0bDcTHAbkGEuCF+gzzGlbUE2AfHA1J0tSQ=
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
Subject: [PATCH v3 2/3] dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
Date:   Tue, 29 Sep 2020 16:33:44 +0200
Message-ID: <20200929143345.73170-3-alban.bedel@aerq.com>
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
Received: from aerq-nb-1030.dotsec.gv (88.130.152.63) by AM0PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:208:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 14:34:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 981f9e11-e1d4-4161-168c-08d86484bedc
X-MS-TrafficTypeDiagnostic: DBAPR10MB4091:|AM0PR10MB1907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB190746BA3D787D3A37BEBF4296320@AM0PR10MB1907.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EhByhDS7S2N4d870zoajpzNbXbE7krahx6blBzImN32AR5zDfMJGU55cEKW+ri5oQoBMd/mU3BJYBis4yVk3oLOqbkI25ntlHInBHHb4VBfwD7EhI7TJFKZGf3CyWR01CEwCijxY760oCMTQnPqV5E6C3z+EjOPqIwoYtL/O9mVTu0Tm84144ChTTkNv+qG/Uqaw965zzFXJ+Lk5N6jTOC7RnAxlR0YB69JuOh7aGBO8D+z4bpow3UYITxdepfX2Ea/aEdcRv5qTIq5OH3H74BHZItiS9WMG+cvqeyyS2XvfPKheutCBZhIZ8+C1dgFXlcsxylBV61g5I4GjnD6yP2CPG9YH5NqzT70BwdCrrKYMpDWZjkcyyWWWLBmY4t79
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(2616005)(44832011)(6666004)(6506007)(1076003)(26005)(54906003)(36756003)(8936002)(186003)(52116002)(66946007)(5660300002)(508600001)(16526019)(6916009)(8676002)(6512007)(6486002)(956004)(2906002)(107886003)(66476007)(4326008)(66556008)(86362001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9/UvSdYD3LnuToJZWk/iyCKL+zTWUVWfUZX6ZnHTd7ONTabbC2XNnHkT2TgLwR5uHjUTrAMP8oI+WN6iZ27Obyd05wkgrWCFgj9f4+jfAhbBtcwXGCwo1K+vGdYcPwzk9udMGBCyhh3HXQ/ZpkN6AJKvMWDZgP7xykB2T91OyEE8eqD7Kaf0uZ8JgqzC3YGk6CS1IL1VYn1N5tlXVRSkwmaGe8rBNfh2/HAo9NYwQCBu1NZW0gYETfD5Amez9Vlly0T5Wd+00gYR+RblJaku0Ms4OEcmC8VCCfEuCoJrDO2r59Dj8QO2BapWg5DM6Cmma+iXwPnqE9lZYD84ii68WGTsgGCm7DY/h+qpr7JyXzGiXea+vyBhNhEf+tpCYkq5xqyo26kwQJQqTRA5rJ7T/NHSoq2WjSU3wRvQCelzlTik+pYlQks0tHtSRxUf2QssYP8IOLIH2cLAoM5geVMiQ1bDsiIX7V18aK1UFIlonv3uLQi/FN50fNX36T6x6ZXyyjt7ukCZY59lnmkHnqOphNG0keDnmAwNXWqA4Vh2gm3CyVEq1JAXfrsldHyiXdTjiHDEdtaDmhR7BwbW4gvP3PXXCj3hbRaZIok3yL3yo9wZBNPg+/YChtCaEaN8H5OsQcEMedLHhpGPEbLgXvwEkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4091
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6bf5494d-e4d5-45cb-b01c-08d86484badf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaZuorVGFrjMnZAQ7Yag5c09bIg76wTRxYo1d9Qe4LmiCnB2F+mbJeOkv1XeaI2UJTS9L3SNC6v0yc19fkqpcAu0u5Niy9YkUwmih/zjkt5M6PQYX8Pp7Olns4oeM1m9CYdom0SFaTPNr8klQy4eUuFCn8OCa7iz20htfbfHSaI606V8M3t16rq6sktGnGyQ+2RbEfCnxImWZ80OSydE03rawGV1hP+/dFYs7XrEsQIYArk+vJyHJMnzufOL5sCOLQ0owOj4s1xwlUg5Ef1hKmXc4HJnq1dMHKNoumjG6wEJ+xLcDSkRX0P6e/3VtWnrgs/MatEQunnHlq8Ns2EnttAbwjoDEEAzlap1vlPpFxumfXu8Fvq/4afpw2v8Nau2dXLr52fru5oesPHt3rXdvJGKuGGnzTq8tjJt8EmRkwoyC9R21+CH5LlZ5g9Y/ePzIYj1ZQtKiFgtzUcgJ6SyGqDqF1LAptauRvLxQNGYN0Y=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(396003)(39830400003)(346002)(376002)(46966005)(70586007)(33310700002)(6506007)(8936002)(956004)(26005)(508600001)(70206006)(47076004)(2616005)(107886003)(6512007)(6916009)(6486002)(336012)(6666004)(16526019)(356005)(82310400003)(186003)(4326008)(86362001)(44832011)(2906002)(5660300002)(1076003)(8676002)(54906003)(316002)(7596003)(36756003)(7636003)(4744005);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:34:16.6993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981f9e11-e1d4-4161-168c-08d86484bedc
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards might have a regulator that control the +VS supply, add it
to the bindings.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
v2: Removed the unneeded `maxItems` attribute
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index 203829c6ba6f..1c1ce4cf1616 100644
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
@@ -56,5 +59,6 @@ examples:
       sensor@48 {
         compatible =3D "st,stlm75";
         reg =3D <0x48>;
+        vs-supply =3D <&vs>;
       };
     };
--=20
2.25.1

