Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1957627B10E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgI1Pj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:39:56 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com ([40.107.6.110]:34464
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgI1Pjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCntZ2lvum6p7VppqAZXy1On98ghYeHIaVKWHh76lFE=;
 b=JGaAvKIlttv4Ojwh8LCcYoxaKSp3h9Hxa9K6ItAJ2Hzi0w7FFy93UYea5+aKHrevsTiDoFeKHjGUih0Rx9DkHgYYdJHxCUT2sbXcws7VNeVb4Megsk28w+azmteSAe9V8+BSiFHtUq4UxybS6d/bl+/OLiwXlgDieod9TUxX8Cs=
Received: from AM5PR0701CA0065.eurprd07.prod.outlook.com (2603:10a6:203:2::27)
 by HE1PR10MB1850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:59::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 15:39:46 +0000
Received: from AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::21) by AM5PR0701CA0065.outlook.office365.com
 (2603:10a6:203:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend
 Transport; Mon, 28 Sep 2020 15:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT011.mail.protection.outlook.com (10.152.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 15:39:45 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.55) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 28 Sep 2020 15:39:46 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12327060
X-ExclaimerImprintLatency: 595637
X-ExclaimerImprintAction: 04c08a50b660410999e9154404ea7c61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANS9jdQAsz4TM/YBC1a3t2O9KF3wZoOQN2RBWKxlT8eA3bGbFlVFvC0GfSllUklaqj8y9jL1W2DNp6d6OFK5z2jatywhpsPue2swXoU6V/9m0PnFg+SDihxmmB1Ja8riaDzAw7JZoA5WY1GlYZmkP9Af/4hqv9CMuwDPoopG59MPzMbPvRPfM6nwdQ9e+uI3QS5K3vksoAXxOFi9KVdzSMx2iGK5zoyz0Ouz1lj2LOedzJPmpwCV6Xziyi3d8K92XmXijJ0HGzFkdL/dWGTFgjEAs0QQ3CDYEFsbLiSzELC2l8FJTWDfLAx4uTyhBR8P7POaEyvjMwWwONn26HzrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVESQKz14HZT47jbTNP3rZq5SzM02Mn6rOTCUSNGqQ=;
 b=RTfNC8i3A/KbzEWahL+YNw5Un26B9oG1/LVYfDMzXqVFuv36XnQwmU2Y8GWPtC0ynZCWNE8uOS71z/CFRq09Z12mNIMMkSQMlvKSep0axI6wq9CsPcTI0ntyYZXgFdyXbesC6FvHEX+Vlq+63INV7wXQXsyKNO2b0utM4llGRz3e45y/aciX4qDrDyJsxuxOTlUNFo2dAysMvm+/4/MDx5/q9BnYfWYAs9tb+OiOMifsjeUaevMIRzuQjSC3a0w3Wmgbuq/tSUk7JK89O37TQkJqkjY93jDHxC/PaSJFsYHiczqMbIUMy/QTGFYFxJNXEgU7/JqBSAVSNUosOXjiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVESQKz14HZT47jbTNP3rZq5SzM02Mn6rOTCUSNGqQ=;
 b=swowiu+EFQGvd1cI3SrmZXqx5l2vCXS5+QhLlRqsel9bUC1fdsg5pOdidDfkGPblnlPrm6nXSeucA84cppDLuzvvhyU2ctzCUVRDE2eCfL6wyn4NVerlld2DHwx6kQkrICdmJdUo88cnQRFylxz/VYSt5q4XmHjxVCdAHMKGqKA=
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
Subject: [PATCH v2 2/3] dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
Date:   Mon, 28 Sep 2020 17:39:22 +0200
Message-ID: <20200928153923.134151-3-alban.bedel@aerq.com>
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
Received: from aerq-nb-1030.aerq.local (62.214.82.242) by AM4P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 15:39:40 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [62.214.82.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 463edcc2-1be9-4d32-53fd-08d863c4ba76
X-MS-TrafficTypeDiagnostic: AM0PR10MB3057:|HE1PR10MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR10MB185067A6434697ACE310F2CE96350@HE1PR10MB1850.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5L969B5jNsmCb8O9zc3PJwNj4pAMjfTeXKw0w8rhFMhcQziXqyQ8PzRJnJW5AUQVd62x4LpWnpmdOZLYXOnB9sfZ9Daypfj0WHpRjDYELvfLAXRb2QtQAlM4UK7JHiL6PnbPbeH45sIfIkix8z86cym1cOnUZ94NkG3IUcLNdKKI+FJUeNvOPFf3QRaOvqP2ia3AikUyPZnNwrm3sgkgwcTe4DfUDkxf051X7otacVKGuo/e7VcM6Wmqsvi64hv15QxLhDILKvDPnPd2PqtYqIB1IEljEf2Vz48IseW5f6ozQXvVHwL2WRmcaPwV7XAwVUCLOWmoxd3ZvHfuBdMc+R3aeV3r2LxZDWR4M1uBhj8w69fiaCb9LW30YIKaqnvk
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(39840400004)(366004)(396003)(136003)(6506007)(316002)(4326008)(5660300002)(66476007)(66556008)(16526019)(186003)(6512007)(26005)(6486002)(1076003)(6666004)(66946007)(8936002)(36756003)(86362001)(8676002)(4744005)(54906003)(107886003)(52116002)(478600001)(2906002)(44832011)(956004)(2616005)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: slTgMXCE02exc3rF35cP7ziEfGktxoQuHgJWqJV1/Xa+1vgXX+unhxNEjtrCVjrDRT4mSXiM46a5IA3obzdgPYkqt/u86o2Of3HhZceSZgGGUMgvrTxMV35AJtKO3H3pjJx+Bmv4eKzwr6+T4o7cLj7wVMc7g+IK/htl6vB0my+f63bg+BSMLFfy++EJAIn8D31bNOdzsM1Qf7SoAOwFprppVC9FUzAq5I59T6u6maG7qNrtqtZ9et7Qs4Ft9c7mb0r0TqAWqO8Etb7aWb+eDhJlvTA6Vu4NF4uwFqRu9Y5fj4epjXP14MsoUoMGZE7ao8F6KLwyW4UmREdnmacGxEP+4I7/15L8+TGjm1KlMC0NMjeWsigDOZm9Ls+dJFizdpGkRHE19nCzrwKXUTLfdjDoa1BuA3hlRmYYzD967tozsJtNc/aQ/bwtBF3QkOn/eAHATlHkqxZczakQ3U1Y3VZsbHAvAknlLaArCKhze7vfWASU3UC1t6zWAAy1a8B3mHc+DftCZdcgolvXZaaSEsJaVmBAuXl9+7kliJFKxt8NcXkGyi9/VBxGQHwjM5ZaZRdGQHPBW1l7bWczBquzWCsrpZCsMnEa44zjC9d24R7JxbCpXpkNA3h5QnUEUHxzeWbxmwlXTF/phZf4ajj4Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3057
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53e27277-f794-489a-cf2b-08d863c4b6ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpnVTOkv5+rlwb0Yurtx7D/u0b+8p2ybjOfDVmNaUyvicqKGfiYJ2up8DGunFgqABfOtdDiSGzK9LECNjwJnccEwXI0EMr45Js42mfchEBYtBxyfyvRM7ZBb5TOKAB/7z6lgo2upLv2p3Zm9MOU05fNqPmIsseQeEDYSQoFoialW5CigT2TV+Bb5ZheRDZlH6iF35ec025LaBURcqnYMF6j1LNKLcrMmMpYD+Rp9d9KKO+/fZzCBTJ74+wpYI18LB07tBsaReX5F4ABZp1cjjrzrHxE1J19ReTXsHG6QoH0ruyRBlMIuSvigoCx2DD3RDWyMSEVCInwmeqobpIwfNIm/J15h5ycXFU0MKsjERxq9pHrAsDMws8rhs/MN8T0+NSfTEPR9rj38AwEVYIrdsdQcy3GOT2HaKEy74soKFcZ69vp28LHIxw4k59ydEOaYS6LKPcLxv/kV6X8TIwvS9z5fl4dVjCA+U0yxSKTHPQk=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(39840400004)(346002)(376002)(396003)(136003)(46966005)(6512007)(356005)(26005)(70206006)(6506007)(70586007)(6916009)(5660300002)(107886003)(1076003)(6666004)(36756003)(44832011)(54906003)(7636003)(33310700002)(4326008)(47076004)(316002)(8676002)(4744005)(6486002)(336012)(16526019)(186003)(2906002)(7596003)(86362001)(82310400003)(2616005)(956004)(8936002)(478600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 15:39:45.7655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463edcc2-1be9-4d32-53fd-08d863c4ba76
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1850
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

