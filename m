Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62C026FA84
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIRKXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:23:11 -0400
Received: from mail-bn8nam12on2126.outbound.protection.outlook.com ([40.107.237.126]:36129
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbgIRKXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZvlAQFM74ifM6Ew5RPMr5xipUIMs0lRULI1i8m/pcxuTyc5HeI5kE2rhPwBITXIXEgZ/T+L1jr8l391prqjyPwQ2k3Ej5XlRXtGSVyjFriabXlVYn45j+q10t5wt3+Hri3LTvUIXVv8w5HihEH0olIyXXhKoV3JvWad93DEHWdwBeq8zSK5u83szQKftrz76fmCacu0EZyt03D/ia7Gj+a630cV3eiAElUa50AoE2o1h7PvsDoV38VEIzNw5BujGlyI5bIOSVOhlJ0/65t9Eh3XQdrB3EjiXb52bSKRifKfJl/5tprWtUSvzY/FQkWYqdZyroh1gwKHZx+AgXy/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2l02bwqOJcFgzvXOM1FKabFhPQkV7mDdw5aOX8Ym6k=;
 b=gPHI4O0y2Q7m77fXNsAK6eQBXDZXvDZN7o+UsTfRmr3DqD8qRLg1/nJ/Q6CFhN6d1mWTd1CoqZDNnloCfw8qTt1FCY0d/amnV9KSSBpcWvAHeeW0YGJRupxBMMpgBI+3HVPhXOAagXnJOJo1FT4z3dNCQWHCwLpsHByZVGnX20h59vy9P3s3X1GW10R+JbfxfZxlFfdJZPH/mn+70W1ESvqAGA7pL5d8oTRMSpF8i3X2A3Hn3FYlsa72N+LMLskRXLlrcMpSCrXE1blkJuTTPjCooWlOareFvBqmp3/QsO27zwY/KE/zinmJFgY9Xa+p8IXj2uD85Hsp0wp8V5iM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2l02bwqOJcFgzvXOM1FKabFhPQkV7mDdw5aOX8Ym6k=;
 b=0jYQp1tU0BMv0ECxAN6n/vGRdxFRZyn2gAZOCM7zRfqrbjx9or7aGLswQfMjh+CTvijOcp2H0dJAEmWUWj54shsd9Ncrjwh5niuARlzciFItI/peMBzoWUfEtZPOIy6oy2dIywB46x9u78MtZ6vPYEEwdvb7m5JBa2nfZ6pt7YE=
Authentication-Results: analogixsemi.com; dkim=none (message not signed)
 header.d=none;analogixsemi.com; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4582.namprd04.prod.outlook.com (2603:10b6:a03:13::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.18; Fri, 18 Sep
 2020 10:23:06 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::1dc0:7d4b:9820:e68]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::3c04:982f:7d75:779e%7]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 10:23:06 +0000
Date:   Fri, 18 Sep 2020 18:22:57 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     devicetree@vger.kernel.org, devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v17 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter DT schema
Message-ID: <bafa02aa50c5c29b3336ca6930c406150a3c60d2.1600423932.git.xji@analogixsemi.com>
References: <cover.1600423931.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600423931.git.xji@analogixsemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-user (114.247.245.146) by HK2PR06CA0007.apcprd06.prod.outlook.com (2603:1096:202:2e::19) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 10:23:05 +0000
X-Originating-IP: [114.247.245.146]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2ca01c-b94b-480f-5680-08d85bbcd52b
X-MS-TrafficTypeDiagnostic: BYAPR04MB4582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR04MB458212F657954815060D33C6C73F0@BYAPR04MB4582.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZBmPKBNbe/pBtuNWJhJUOIuMhT5LsdpW9RDp+jGHlQF0s3YtIxnz5bPla++EuO4bmFqlHNvWhHsaQeyvPQyHBtMaW5AGkYutIToJLCDmbnGhHbcBFEdWijy35VyR+C0bVGyuUJxhdT7LbI6K6IkhHpAT4QMe+wa2JTLuN7bBGK32/kKLu5k1QLDt/5k4VI0EvMnHGwgr1nJ0krS3KtSpn7POFmmJlWAlbJvip0gLORJ1Gtt9eccNz/xXmh9O30B/nor9va2quMUAGdo6Y8P7Iz0cAT229Lfs3jFTWLAXoC7Wq3BOS5tzSf+8P4haQiTncw50stnTM+O+98XxVBDIZHez6Vu6cGJQLYEcord4c9/oG9kjlBzAZ3V4MtZ0HzESvl8QPbJniQVj93+FFbFbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(346002)(396003)(376002)(136003)(2906002)(5660300002)(52116002)(956004)(2616005)(7416002)(16526019)(478600001)(6496006)(4326008)(186003)(26005)(54906003)(6486002)(110136005)(8676002)(107886003)(6666004)(8936002)(316002)(66556008)(36756003)(66946007)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xOXFOvCIZJkuUwCEhSTG0D6x59WfLfWb6F3qLQTaxBOhpiVR4KvStR/cncqBT+BEEFSKwFs0yaSBKV5L8QKiAV72skyGNUYebcCi9Z/A0ofR8P6KoFn1eLdFIDxv+CPkc0QG9RorA7oVVxVw457aRmlIIpveAzeQODjGtiLJa6FW2akhs9CgqbDmdxOMhaQVK0lOsogCo2SbQAQFaTj4Rz+Y+UckbvbS3hOEmXzY3lVxQruXqLsheW0pk838SRR7ZywSgs+4d7f8njgG6cUPnC+oSb6m2Zvj9OGlyEXol/+UgwemVr1DOAPWYVqM4V0SlEbxtgA9M21a0GkRj+b250ZnltVDaDvKKPb9ml4FnXeefzMt7T50wSBCrSnlh0+ZkfUzAyGf6oOKWxXFek3tOUReDxVEruelLFSwqAmfly+rFVK4nI2ZNgGEAQ+rciFBa3LvaLOpQ6FUThb7Md7fAkPJu8HZDvgzCskVPr90TLVYWL0qNZuZ36XO/W8j1YaZxdjTuyDxpYegjZazyBVgoxR3v3ZPulcTC5JthcK10nIPSwWVNGA6BRU+P81zkiQ1vRLT4IPexYIHuip+vdYKwaishHVpQ8qtMBDuVgUBqakSiqwZVt85n8xH9JFhdBg82jL+iVZTte39lkBzPiXgAw==
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2ca01c-b94b-480f-5680-08d85bbcd52b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 10:23:06.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atdc3vlAWu54U+/OO5MyrIrDJ0e/92RS2fX1H4BhOFeUFGvdHfJLq0mFWJ+A2tzrgjPNjRXT7kl0CLkamKwXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anx7625: MIPI to DP transmitter DT schema

Signed-off-by: Xin Ji <xji@analogixsemi.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/bridge/analogix,anx7625.yaml  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
new file mode 100644
index 0000000..60585a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analogix Semiconductor, Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+description: |
+  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
+  designed for portable devices.
+
+properties:
+  compatible:
+    items:
+      - const: analogix,anx7625
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: used for interrupt pin B8.
+    maxItems: 1
+
+  enable-gpios:
+    description: used for power on chip control, POWER_EN pin D2.
+    maxItems: 1
+
+  reset-gpios:
+    description: used for reset chip control, RESET_N pin B7.
+    maxItems: 1
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description:
+          Video port for MIPI DSI input.
+
+      port@1:
+        type: object
+        description:
+          Video port for panel or connector.
+
+    required:
+        - port@0
+        - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        encoder@58 {
+            compatible = "analogix,anx7625";
+            reg = <0x58>;
+            enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                mipi2dp_bridge_in: port@0 {
+                    reg = <0>;
+                    anx7625_in: endpoint {
+                        remote-endpoint = <&mipi_dsi>;
+                    };
+                };
+
+                mipi2dp_bridge_out: port@1 {
+                    reg = <1>;
+                    anx7625_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.7.4

