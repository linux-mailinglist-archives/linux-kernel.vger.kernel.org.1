Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C399F26D8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIQKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:20:40 -0400
Received: from mail-eopbgr140111.outbound.protection.outlook.com ([40.107.14.111]:60398
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgIQKTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z94DKysPiAKbvYMsd7XWzrIhg0mGBbNQpIWNBixt3Nw=;
 b=s1pkAWvsFUt8bmPiZIwUvIg+PaE1Owd8arezoVdSiG41b2xV3AO/PsJqqtFaVNxYosJIEylSORx1SeJ3FRp4kq1aAjYuDe5fEVHtTxx5iaLsn59n3hSbWhed30ow+d9Oz8Yt4i7nkQoH4kv3GBUjwsQpKlHfFFT7yb2JdnNDayA=
Received: from AM5PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:203:90::11) by AM7PR10MB3477.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:137::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 17 Sep
 2020 10:18:57 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::4a) by AM5PR0402CA0001.outlook.office365.com
 (2603:10a6:203:90::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 10:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 10:18:56 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.53) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 17 Sep 2020 10:18:57 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12186084
X-ExclaimerImprintLatency: 637992
X-ExclaimerImprintAction: 8ae5ebf0d48d4105bb0d594b7ecfdf04
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkbv6hP5LLHOFxHX0Yvqwoq42nKyLOV4MgAU8/xRAN9AU9n4k4yYRwG62sL+I+2ITgw/wUoxlUjhTIoLAUuki+5nyXy7IivczIffL8Z8Om0W12ac86r0LVuTVt5+AYrFKnsqaQv/scB8a5s9RZDvdJEpJ7L5q21pxYMKu31QNVZv4hKEHlUve2QpJZpFdl+T92ouygZnMRccbI6imCrd8Rmioo2x2KivaJWS91T1MazxgF7OWI0L90S11Bk0B+mUdd+t3fNgrmfXcIDDmDTan2WlXDjoEzwv+vWTwQRlocZqMWznTKgftBwaMPAWVymgsiJHHJXOh+IguAVaYSKlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSxXB2jhWPmgXVTuqttFDR9UeIeF9d79OAagit+kPrQ=;
 b=PVsGsnvUa4Va4PWNAH7rWhF9+Qd7ZaS6WKDx4+aPKHdFDL+RN+xTtIfoY1kSkcS211FKj4TjeLKp/+BON75+/NDzyadibpIXlwD9pXWWXFhouOX5zx8Ek0kJh7jYrgl2K5YNp0gUp2v8tCHqUAqQ77KIRoJxzkBgPmbZCbTE3qxguCWbvNGUoHFTOK+ZUaWbxcaYIYVTDf0rIGptG2dtGyhrlklNZL+X/aDJf6jO36r5LOApVhOEa0iHdZSZEEJs3Ecwf8nAzwuiZRpLEy8o4AXFFAfPWHpl23AI2Dl2Z3feFUfynpBR2FQaijhH4Apn/qIuMIy+zXNThgskTa+3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSxXB2jhWPmgXVTuqttFDR9UeIeF9d79OAagit+kPrQ=;
 b=U0xyPrEDu+gxCxyqW90Lj5AUbSGgvWnUKH0yM81++7jOCtQVuhsewtQCIAZY6RvOY7I4XNHFzJib2vsR5G13HjJUIEHv61JUsM9J3uUwFFd1qi53VCo1WgMwTV0mLIgz/jdvDsfpKfCceXJbxeMWIglfA9OZ+K5qL0twfvuwuWk=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM8PR10MB3987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 10:18:49 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 10:18:49 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH 2/3] dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
Date:   Thu, 17 Sep 2020 12:18:18 +0200
Message-ID: <20200917101819.32045-3-alban.bedel@aerq.com>
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
Received: from aerq-nb-1030.dotsec.gv (87.123.201.53) by AM5PR0701CA0017.eurprd07.prod.outlook.com (2603:10a6:203:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 10:18:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [87.123.201.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6ed54a-f21a-441a-46ca-08d85af3165c
X-MS-TrafficTypeDiagnostic: AM8PR10MB3987:|AM7PR10MB3477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR10MB34770A43CFBFB3E66D5D74C9963E0@AM7PR10MB3477.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KEEMWCiPvVEgavISH3TALC+IAEV2ZsXFRYwou3RvetV89sAOI9qafz4PcpnuSuDX9b+W/uwOkMbJL8MQw31dFRfH2ChmOZ5hZZc5QWWJKJv8BfNx5X53kwRtYBMXkAQqbdWoDpA6ooyRmHDs5LwmJCHBdoXOcj8G9+WdF8uGf4C4MSWZMfcvIMNSD3OOq1xu708j8Qu/MD49cYKSmA2iwWYf6FCjH9FAVRKKsuWkjsOT7MRKGUwRycPiCu320ZXQM8UFrAS6R8kMxE5NSQ/INwdKRW+IXXL68/CdLKyfEPlCmT1FLAwb9lJM7ZRnRpo5TehAVecSifU0UcBRDSc7wg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39840400004)(1076003)(4744005)(36756003)(66946007)(66556008)(66476007)(44832011)(316002)(6506007)(8676002)(107886003)(2616005)(956004)(4326008)(52116002)(6666004)(16526019)(26005)(5660300002)(186003)(54906003)(86362001)(2906002)(478600001)(6486002)(6512007)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vBtD+dUwIXVOJ77NZBR2uuxixlvm8dTXl+Pc9eDtuANUXdUbpWxC3lA9r9VIlS/zURkcLxaoyDu7CAj7NK58LCaKMHbjtqH9nk9ovVU8V4y5Vu0pUhJCLdEeSneLE3p7UcGYUaUsGnJ34RTTfio47SmF5KSHRTgu4O9sZ6MP1EblgQCQkGJmSiJSd+KlvLQ5s+wxDO3e9u7E29mlDHOyPvRpe1GBN+gTscF3HyQxRqyh5tpUePFKROrvvo2lq887Mq+bsZZe6AFZl3n74UdDJbkKbiRmdg9D0Mn8LAMMycUnW4EGC21e1OZ4IGfx6+TSFFkVWgVaCJwbFEbUvcjs3Ql6DTXhbnylT5f7P134AMD92U9q/iHwgI8kwkI5WrdVerec4Pjac0plY6xdwjnHWfiVAIMLOrkYV7FDGLNc1rq+TRVxHl2Pp8mv6FV1jTF7lAoou0aksMxIEV2t54bnpHR5ra4lEaw+rvbYuA3GaU/6/zgasMqPJ52nx7WpGse96fwsiHgdoOa0opzUqTZIxXmybXRftqqQobppPaObbWaKiCL4sF2w2b/6yp/TBC6lVCScZ2IhyIm9TBy5CARkEpasCVfh26pJxqy7oWd4Hkr2P8QB+mXaTqCUV/1ArL0hPPLV8BjdP7cdWAfaIJvuPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3987
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3fa22896-4b3c-4fd8-30f0-08d85af311b9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXyhMJWbX9k4EjujL6leMflQdqsiWnqbzNmrOUGWEgazp44xnGQquZN1eINsXp+K/38BsXgdtl9pqfA/yvqjNFnf8bx66qslfYZclkDzhtINnQjG79Ihq3xNbUBzhDpmbjDIhMsWxZCFJ7XhDVoI4FfHwWWZgli2L5t/oP7wXoOFwG5LYF+VVKPJiN6XXB/AcesSeisc0lJEJQIJHn2SdLWvNrviuBi6HKzJyN2/owPdSYGbGbkH13tzWEPf63Iv7qNwzI5mvWncABR/3illxAUpH8T2Vtr8DW9rvBIpClCOLbc2NV+JUKx8KJ+LuHHow3TfRqzhbujAkKqRVyOqh3GwIzbhZFwTpBrwqF5GCDlrcyT9dYUQ+RpimpuofGjArQPzmUTjEBzVt/EV+lXmkB273fDYfhIZ0GawhFOBqtGxHjH5BWZzrxjKFZaFNyWc5rk02eVDRnkKbh7uazgj0R59D+ymB9U+rMqqL7PHr94=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(376002)(346002)(39840400004)(396003)(136003)(46966005)(1076003)(107886003)(6486002)(5660300002)(6666004)(86362001)(6916009)(70206006)(70586007)(4744005)(6512007)(186003)(47076004)(316002)(6506007)(2906002)(8676002)(8936002)(36756003)(82310400003)(4326008)(956004)(356005)(44832011)(7636003)(16526019)(2616005)(7596003)(54906003)(336012)(478600001)(33310700002)(26005);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 10:18:56.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6ed54a-f21a-441a-46ca-08d85af3165c
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards might have a regulator that control the +VS supply, add it
to the bindings.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index 78d6291fcdcc..1a4405b17924 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -43,6 +43,10 @@ properties:
   reg:
     maxItems: 1
=20
+  vs-supply:
+    maxItems: 1
+    description: phandle to the regulator that provides the +VS supply
+
 required:
   - compatible
   - reg
@@ -52,4 +56,5 @@ examples:
     sensor@48 {
             compatible =3D "st,stlm75";
             reg =3D <0x48>;
+            vs-supply =3D <&vs>;
     };
--=20
2.25.1

