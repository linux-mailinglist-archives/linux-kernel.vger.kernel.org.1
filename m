Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462F42DF8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 06:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgLUFYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 00:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgLUFYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 00:24:43 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B2C061248;
        Sun, 20 Dec 2020 21:24:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h205so20728095lfd.5;
        Sun, 20 Dec 2020 21:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ndwpbb8/wtrUCe/HVYs2AwRu6duGGmHbostQ59+l5iY=;
        b=kg8I1pYbxb72Z8OpZXG8/r5Y8pJG0oAAjtOJaHLrA8kdRIn+XniAmfHasmWxpFS5La
         9+DK2NgCdxmHhOjQtQ/gHuRgFH+BrAwOKc6fRWRq2ZVKOQMTUNT5w8ImYye/JFPfdeaQ
         yGl/owDrfPzoma2uLrD5NEbdhq7r6PD3B9SVShyPZ+8x7xST7lTQJp4m5eEop9UAAMdX
         2+XMZeuiBLeHdkeVYsbLIeZJx62h2hFhOjHSq/Wee4YuykcXxGCpxmgvZqDYQj0HmCpX
         BqXqw+dSVAKVCa5TPkFQhtg1LAhLJ3Vggkwk0SxKoGJEBJzjQUSN6UFGUYtDB8VnFEXt
         xxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndwpbb8/wtrUCe/HVYs2AwRu6duGGmHbostQ59+l5iY=;
        b=sDxsw26JKofAQtzQFXwZbyF860bgzGcsYTL8f09BbpISxA3A5OlZ3YSyVf1x/rFdit
         Sk/AUPVvYyWRsfGqld6dPKKnhN5s9mX3PgLCYeyK2S+S/ojYkvcKUxHLCLuqr6zuck3K
         a8ZXh3KqOqttVNUEL0RXEoBP/oLkt4VG3UgcwGcKuaUt3CcS6pLB30lGkT/gVWyqKa1W
         YO2PIGXqFxWIwtQ7/99df+Jx4sb5ndm134zcmxddWIVgT+j6SCXH6xuwvfy8hnRBG3b0
         vuuzOmvSXFGkKW8bc5XcHWCL3RIkYtR82bpSh2+KxoFjNmbXDIpzA8pVe0Z3DvI336YO
         0EaQ==
X-Gm-Message-State: AOAM532+bemJhI0rv3679NgGJn0rksoa7vIkAKnctt/vY2T9Xq/Ts1A9
        +c2AaQiPIo53aIsmaTn4sr2GfeG98fQ=
X-Google-Smtp-Source: ABdhPJxX+qDHDPGlebub90vSgKVhWJsmoWYJqHe72Mmg5gKB009OdHXEQnfxjHGELbWnPJjXWftu2w==
X-Received: by 2002:a05:6512:360a:: with SMTP id f10mr6170782lfs.200.1608528241578;
        Sun, 20 Dec 2020 21:24:01 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id v10sm2052525lji.130.2020.12.20.21.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 21:24:01 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/3] dt-bindings: phy: brcm,brcmstb-usb-phy: add BCM4908 binding
Date:   Mon, 21 Dec 2020 06:23:38 +0100
Message-Id: <20201221052339.10100-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201221052339.10100-1-zajec5@gmail.com>
References: <20201221052339.10100-1-zajec5@gmail.com>
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
---
 .../devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
index 1dad1e3df1a5..2bdcb649808b 100644
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
@@ -91,7 +92,9 @@ allOf:
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

