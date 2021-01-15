Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4B2F7DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbhAOOOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbhAOOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:14:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766ADC0613C1;
        Fri, 15 Jan 2021 06:13:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so4777955plx.0;
        Fri, 15 Jan 2021 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pEukWvtuwh82TDEPEZ3woLLJLq853GtFGRDGVW376W0=;
        b=d56nTDt327VgF/XuYROfVX7Ku4gbnv881jVJBzfwSdhMsqCb8W3xDas4Ii4WP+3rym
         y1jbl0OHSy2yL2Qfm6Xatbk4PvpjuiIjVbeLpGibFMYI2unQT2LA3qpK4ZrfXMTdSeo7
         d9WQ8asbVfBdxxwbrSVMxgt+VI4r3jLDbyYjFsxx6bzqZ4j/cUnSHlklmYfQOGE2BwF/
         cugv4B7yy40HyQWJFkunnBqNZL9l40c0l3U+YEtmducQgtcrKQpgMh/4dhD/Ipf6pxgj
         vJTdIrhLFXNTYs1G13vxi7AOZEB6fG7h1X1n9cCowKokdjfDRXDuERCE5kO1o0CFLHW3
         6YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pEukWvtuwh82TDEPEZ3woLLJLq853GtFGRDGVW376W0=;
        b=MueGgKYIYLwk7x3IMaGjlWUSu/9yXphEfMWCOWSAX8WDGYFXgLsgmt4BvmQus6ew1c
         CARothZtyouE2xqYRlvSRqDUnniHxZpODIMBFHhiXIyQvycmBq42zFXdSau8u/fK09ap
         49DmXYSvm+vnzxl4aTa4zC5SkttprKXa/OpJeoMat6rcmF2MteAs5yqNE+9Jg7OZbzcT
         ZdoUqXU5JN5J6ImWllB6339AS84YR2l7Dz85CrWSd/VuZcyAtXcRnIQ5WzfXkXe5KWz5
         17/m0xFggOFey5riEAYpHHu2fUqrSYn2Za81DF9UMlz4DGEOdMvjG6dN+ZW/aUym3170
         pplw==
X-Gm-Message-State: AOAM5319o5Of077gG989vWsB5AdBr4ZZhyWPX7uCI9dRmUw0by6DwHMq
        UNc5JRje02YErjsDZp/6f2k=
X-Google-Smtp-Source: ABdhPJwLvlOK7S6tSYllr+OMNyZgyloJTKWhIZLiNjcdhjGKjeEWhTc0QmEW8fZcY9NCzKk9a2u6Jg==
X-Received: by 2002:a17:902:9896:b029:dc:3306:8aa7 with SMTP id s22-20020a1709029896b02900dc33068aa7mr12972171plp.6.1610720019995;
        Fri, 15 Jan 2021 06:13:39 -0800 (PST)
Received: from localhost.localdomain (1-171-15-80.dynamic-ip.hinet.net. [1.171.15.80])
        by smtp.gmail.com with ESMTPSA id h5sm8898408pgl.86.2021.01.15.06.13.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:13:39 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] usb typec: tcpci: mt6360: Add vbus supply into dt-binding description
Date:   Fri, 15 Jan 2021 22:13:21 +0800
Message-Id: <1610720001-15300-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add external vbus source into dt-binding description.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
index 1e8e1c2..b8d842b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -26,6 +26,11 @@ properties:
     items:
       - const: PD_IRQB
 
+  vbus-supply:
+    description:
+      Vbus source supply regulator.
+    maxItems: 1
+
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml#
@@ -38,6 +43,7 @@ required:
   - compatible
   - interrupts
   - interrupt-names
+  - vbus-supply
 
 examples:
   - |
@@ -54,6 +60,7 @@ examples:
           compatible = "mediatek,mt6360-tcpc";
           interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
           interrupt-names = "PD_IRQB";
+          vbus-supply = <&otg_vbus>;
 
           connector {
             compatible = "usb-c-connector";
-- 
2.7.4

