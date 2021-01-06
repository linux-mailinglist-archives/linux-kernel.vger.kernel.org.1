Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE82EBE90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAFNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbhAFNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:23:20 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767ECC06134C;
        Wed,  6 Jan 2021 05:22:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so6414680lff.9;
        Wed, 06 Jan 2021 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z26q/nioE2A163icDc1AkzZzT7ydJbu5sFfNkAQMY/E=;
        b=suqYCaFXtZQq2ezZP9DvNo6uvIwPNP2LrRXTju7FieKSwH4ixH6d3IAFfH5xcCM8Gy
         FMm/e3b7nihtK5LGLE3t4zCqJw8gchczQNe0effcXvuld9h5YxfKKZwMrkUOcXIkxpUs
         ZmvKBde3F+OTKPz+imKeCaSffobjvlQ6kEhCaXM1/8StA5xIGMHTgvyn99os59d1R3M6
         IFgXcMmR2cPgBkyprK6C90nNckKRMCmhn1ZD8LXHB4+gyxf1jMWnRmlRW5DEx0wqY2GU
         9pUl+n9GqploD4647RcEqkRVsk/jNLRamNhbGpvimLXSEt9T3b15erK8TrebQuSnVcIL
         SnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z26q/nioE2A163icDc1AkzZzT7ydJbu5sFfNkAQMY/E=;
        b=Q/lAKXEekT2W+eWkrYBQhg8cAtVZ9xj94j3yYashmj7oDYVhq5gyyi6a0h3eE7MR64
         Sn7iD6rC9uev/5NQ0iap1GBabPLl53CdjOnd7AGjFE74o3YUz18qDudNxlRI75ANwdDU
         tibguy5fuYkuj7x6tJLVFDwCoB5Ghys7qU5SFJLVYx1Vl9Sy46Z5Gsxege5zZdiU4Qwp
         RMM0XMhCmm0KdKyJrD+ykrgdbrhNChWx3l0V6buNpQpqIr1n6qPSdgaobuL6CB1A7YEE
         fCt8Afzcr4wLfqspr5dxIillDnjdqZcFBEk/iOcxypujNNkm2ah/hoMnljLyf2EvjT2u
         biWQ==
X-Gm-Message-State: AOAM531+b5wN9AGTH15hE0sPSLqXeSPe3ez8bghh+QctnUu2MgHm/9c+
        XQg2JOMzZjzIvzjU2j4G5jk=
X-Google-Smtp-Source: ABdhPJxZd0YawpwUNAfXz0oJurV9v0LrHLqwNANWHrMjTMU549BNekXy4pn7uLiBli5UUJ6rCmVsIQ==
X-Received: by 2002:ac2:5442:: with SMTP id d2mr1828931lfn.154.1609939357974;
        Wed, 06 Jan 2021 05:22:37 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id j12sm361118lfc.99.2021.01.06.05.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:22:37 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 2/3] dt-bindings: phy: brcm,brcmstb-usb-phy: add BCM4908 binding
Date:   Wed,  6 Jan 2021 14:22:24 +0100
Message-Id: <20210106132225.21215-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106132225.21215-1-zajec5@gmail.com>
References: <20210106132225.21215-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses the same PHY and may require just a slightly different
programming.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
index 4b8958d8c119..2d9ae83250ab 100644
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
@@ -15,6 +15,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - brcm,bcm4908-usb-phy
       - brcm,bcm7211-usb-phy
       - brcm,bcm7216-usb-phy
       - brcm,brcmstb-usb-phy
@@ -113,7 +114,9 @@ allOf:
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

