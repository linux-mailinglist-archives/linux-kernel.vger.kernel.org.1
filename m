Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3966F2FA2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392818AbhARORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:17:12 -0500
Received: from mail-ve1eur01hn2203.outbound.protection.outlook.com ([52.100.7.203]:61166
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404602AbhAROKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:10:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyc8z0uV4RLfYYrYmEZLY4pAgIOkxkyEaGQZFKIKD2aBrepOzYAz1iOizSK6s57bFdwYd5Zhq2G8MBzWhnT/91OzR4HDfj4M+7R9Ovw6I8RN4n+2M5krkHlgbUzcRNq5pX+J6UWudZAx3hUJJKmT/na2R73qedyn6TEZji1XlxINVbyt9NgnEJxd25SCAsd7vtxYks0DcdOzYGCRenjLHr+9OhmI1jvcq3gwgNkjBQSZIWurcFtjhIvyjvStwMa5DYAexw9/6zVAz29iuQGgzkk7oU1l+AVlbxW/6NExlGGPLpuu3HBewxVXCtVqjiB0f0Wx6dN2ezgvAqH7clcgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ch+TDBVQwmtp0AZCA0o9OKX8vp7eqp2AkDNaCu/lnw=;
 b=E3vCuZX1WXR1TsJ+3+a2SXNnon2K7XLLCp/FmNPW4+TycuOQ1xe1oKd41UYpEhUrYaP26DVfPWgEmyfjjZiDeq663mNGNISsHKqg8ooHU8+j9cxQ43q/LJrFEXf4nDAgOb/qykIfN/bb39jD93DhdMEIgxYWIArMblq9akzU/FfaAf3Z90XGFci9VNy1rQg7l3Oc8oHjqk2IVDCDEmWBQVzlfq6R95UtQ8us1/UzTq7WBm8SIWqQlBFLgIHrLs6HtFHyu57FX8wzYTq2xgZNTt4C3u5FEKxe1iufyJu43C5Oi/9ytMKOocVQv1sQbzXwbpOjTm2h8naNOHP/DSzZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ch+TDBVQwmtp0AZCA0o9OKX8vp7eqp2AkDNaCu/lnw=;
 b=FuMqjrLAHPKo0BZugJOTasvayMSGUe6NSXZtI7ivpZxH2sJzdNwVYpJYv4sAGaZWBK0SgC2GjEEBtzDdKYvJH7bVmZ6d/QZU0dUzZj4tYn3Cc/TxRhEbXgVkY9KCM/x7NimSWRwUlCpPkysninu9Yv7vTcZkYkfFlgUjpU2lGOI=
Received: from AM7PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:20b:100::36)
 by VI1P190MB0782.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 14:10:02 +0000
Received: from VI1EUR04FT056.eop-eur04.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::f2) by AM7PR02CA0026.outlook.office365.com
 (2603:10a6:20b:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Mon, 18 Jan 2021 14:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; vger.kernel.org; dkim=fail (no key for
 signature) header.d=schleissheimer.de;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 VI1EUR04FT056.mail.protection.outlook.com (10.152.28.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 14:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=schleissheimer.de; s=dkim1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=2Ch+TDBVQwmtp0AZCA0o9OKX8vp7eqp2AkDNaCu/lnw=;
        b=pRllO+N3qGsfhl6Rpram2B+hbHcyVBK0jL826ibpuy9nja4MkymWejsMSLpdruY9Pir4ffMmkckPbBuzGU07MpWnqZ5kHnVsyZbCbjIynFh6sggX9VmiK77v0JMCx9F7ZpDQpULegGss0FBBNvtBVHJgU5WDEdI0mZNyaseMlzA=;
Received: from [192.168.10.165] (port=40438 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1l1VEA-0003DD-2g; Mon, 18 Jan 2021 15:09:54 +0100
X-CTCH-RefID: str=0001.0A782F23.600596B2.00D5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     schuchmann@schleissheimer.de
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: lp50xx: add setting of default intensity from DT
Date:   Mon, 18 Jan 2021 14:09:47 +0000
Message-Id: <20210118140947.3887-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 16550122-721b-4180-a5af-08d8bbbabf1f
X-MS-TrafficTypeDiagnostic: VI1P190MB0782:
X-Microsoft-Antispam-PRVS: <VI1P190MB078202232CD70D35CC6D02AA84A40@VI1P190MB0782.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCuWqk5qLPUTjxwndmWHjsycLJTWYMlryyXwW9EtEtkzzjQ0dLZ2Qjy68H6nef0Y9aIrZlq2gL6uu6t4td5JryE9G012viG6kabPf5hN1gwol9uaysckj08u4cb/apC/C5zz/Tkd4FvA7U+CHszGbZ4IUd6eduLCmL9H1GH3rnL4Q3Rf+dKUCABy5FyvA2e6KdtsCyYMDklQNVVXz/nFM2gFlOI3p0P1Ild6D7AxF3SpGud365YYjBi7Y3gspJrTzzVWIwhKJtXo4E2UNKGNHNUo8ZSIX44HYrGXpcvr/RwJ9nLrL8mRulLKtMtXOctuWoJke1AmS+YyoY2aTxy4FhH5Nl/UxJtKstKCTscnUbgf+SUoD2mFL7BbNQAokU3bIiIbdd0tKr8VgOoQFvR1JWPt552yy6lr1okemZNKeet6WfXVsrQ840lTSLAgatOiipKyCy5edT4kPorwAEZsftLQnhMXl+2Yxu4vOjw/FCd6/73UWSIOvVvE7Acksulo7wY98GDrkvKFo3d7Tjp5IhKw3JTF7xPuy6Hm24oNq8oiHw5Yo/dFIrgnW7Al8JJuRCg9xyP4VbLc4Yq5JW/2hfmXy9rVpuBCKUd/jeZI6is=
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:www.schleissheimer.de;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39840400004)(46966006)(26005)(82310400003)(186003)(54906003)(316002)(478600001)(37006003)(336012)(34010700045)(1076003)(34206002)(356005)(47076005)(4326008)(2906002)(7636003)(70586007)(36756003)(5660300002)(7696005)(8936002)(83380400001)(6666004)(426003)(9786002)(8676002)(2616005)(70206006);DIR:OUT;SFP:1501;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 14:10:01.6859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16550122-721b-4180-a5af-08d8bbbabf1f
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT056.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0782
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use a multicolor-led together with a trigger
the led needs to have an intensity set to see something.
The trigger changes the brightness of the led but if there
is no intensity we actually see nothing.

This patch adds the ability to set the default intensity
of each led so that it is turned on from DT.

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 6 +++++-
 drivers/leds/leds-lp50xx.c                              | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index c192b5feadc7..f810c4e84c44 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -69,7 +69,11 @@ patternProperties:
     patternProperties:
       "(^led-[0-9a-f]$|led)":
         type: object
-        $ref: common.yaml#
+        allOf:
+          - $ref: common.yaml#
+        properties:
+          default-intensity:
+            The intensity the LED get initialised with.
 
 required:
   - compatible
diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index f13117eed976..55b9e0c9e737 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -501,6 +501,10 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 			}
 
 			mc_led_info[num_colors].color_index = color_id;
+
+			fwnode_property_read_u32(led_node, "default-intensity",
+				&mc_led_info[num_colors].intensity);
+
 			num_colors++;
 		}
 
-- 
2.17.1

