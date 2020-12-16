Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D52DC0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLPNPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:15:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23CC06179C;
        Wed, 16 Dec 2020 05:15:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y19so48129738lfa.13;
        Wed, 16 Dec 2020 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bqN0VQwl8tDX1KGMDEJjbziUGx+xbpEwCCsyvHgV/8=;
        b=Eq9RHPPQ/9K70lYdmCeFlVwFEq0xDOOmxX/ZdbOm3y+3bD5iaCYMwTb2gM01XdJEUy
         mKm2hj8pRlh+BlDjwCHkIiJyhOS9K2UFeUhw8WFXyzehrU6w0Zc0poUKgaIPh653sdJa
         OnSJm1hBeflrMTY2XvP7fkV2XqI8WuAEjZtcZ7q0ThqqLhs6j8xZHPdRQX2C8cIN/1//
         KwRRm0bVjwkNgFuiFiSAY3i76GQjEgp9VFfvi9791ZQcO/SgDU/GT+FnfuVPAJpFikkZ
         gVpqcISzsDu3EJofzb76OL9tFzYoWEq/g3XZLgtBR50rTkIkwYISJNLwjLZxq45yZ9zB
         zUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bqN0VQwl8tDX1KGMDEJjbziUGx+xbpEwCCsyvHgV/8=;
        b=pEfrYX08oZY14AZv+7kwE7hbBITk4V4FVK+70Dv3whdu+zvAYmbE+Mo9cHNv9hQs3h
         X9OMYu6QbAuQSWBXagtvUkl9AU0C08hSSiFBmqnYK0ebZJ8/aiPQubz1IWnOb+xtK4yS
         /36q3JIpYYXSdEhhzeiDD6lZ7RA9U6y5ABgB3sXfBPvUeEZ/yKlZy6aJbC31PDXqQHHz
         zaz2vIXJQOKn5V/VsscbJQfTTLp2nqiYNj9yy/MKGond+g1dGbHezz5A/LZVaG1arkop
         4rjxHtqwEuJCZXWwaqOTDsKmFJoxRNb0C48hc3ebBPYvFMMeq6IQ3qzSdX5EVPRvB2hj
         xfxg==
X-Gm-Message-State: AOAM531SYOlhzc4ChXrVGcgZoX0VqEVomhQAWf0iXYLbWPXHcYJtEDwS
        f5EpKsmeKFhoaOQ/82EDM28=
X-Google-Smtp-Source: ABdhPJzovhIxkbkc8gSM6k+TCyzmOgPth66anjNdaLfM7pmLMXnBX0mUm/pkUDvC321bytvKTKk4pw==
X-Received: by 2002:a19:c96:: with SMTP id 144mr12260977lfm.564.1608124504320;
        Wed, 16 Dec 2020 05:15:04 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n84sm220899lfd.176.2020.12.16.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 05:15:03 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] dt-bindings: phy: brcm,brcmstb-usb-phy: add BCM4908 binding
Date:   Wed, 16 Dec 2020 14:14:50 +0100
Message-Id: <20201216131451.16900-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201216131451.16900-1-zajec5@gmail.com>
References: <20201216131451.16900-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses the same PHY and may require just slightly different
programming.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
index 34664bdfa4be..021d3171be75 100644
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
@@ -14,6 +14,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - brcm,bcm4908-usb-phy
       - brcm,bcm7211-usb-phy
       - brcm,bcm7216-usb-phy
       - brcm,brcmstb-usb-phy
@@ -90,7 +91,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: brcm,brcmstb-usb-phy
+            enum:
+              - const: brcm,bcm4908-usb-phy
+              - const: brcm,brcmstb-usb-phy
     then:
       properties:
         reg:
-- 
2.26.2

