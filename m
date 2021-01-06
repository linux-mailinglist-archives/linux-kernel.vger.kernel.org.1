Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD52EC567
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbhAFU7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:59:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B0C061786;
        Wed,  6 Jan 2021 12:58:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b26so9644171lff.9;
        Wed, 06 Jan 2021 12:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pphb7wrsc+c5YZrOm38o1FrhievSA5Jx32bg5aoI1/A=;
        b=ZHsN3VC0q0Nn1YIr0Ukx+/4Q0FFRpOoKCaaFe3Bl0+Jl1U0ChMUT3bvpe2AVJV008F
         U9NbqGPf81BO1xif+tkXeg8jLP6mt3AUd5ed0Klsx0zrMj0RpRI1piYZif6wJiPNZQBA
         2pCWhBypeGGz6j3BAgVk2N8rbnB62FV2EzB5t+Ufx5v6m136hjnvsxyJqbAw2qPIxfgg
         3rzm5CXiYlG4zzwqXyhmWsLXaJIpjxE2gDbEroTKBNh28C8GOra6G5nxra5oLQyWhCn3
         m3c4wqZn+xL55/M4dtTo9fYQUqiyhPOvHSG9OdfNfIF4EieI5USoSJajev0BycFYyRDZ
         aYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pphb7wrsc+c5YZrOm38o1FrhievSA5Jx32bg5aoI1/A=;
        b=fQIfGYtRm8QWqoVCQ6BOTUT7NaOrWLnhq1QCUxL6j2GK2rwu9TM+AI532aa/qunbl3
         7mS9xwSKmwKDkfCp5x71Wb3EBtJ+4r9zwNCeQFXoPF3QAIdc6CSp084p42ddcrkTuxD0
         sMnay1Yzz6uQJXSSEjiNJzV4WYezkf/1M3z4QQBcMh1aXpx1LfpOweARn7jQOwhjbjIb
         skLldXLFCuCAwnKSULUWzrUeC/u7XKf99DwdEzuNIF2i6Mc9T8FisCha671MZDkAIK9F
         Qh6RFXQCWtmE/3VM+D41i+FALv6GQfic/KG/RDQTcSz5X+6IwKUllUyVHRvJ3cHC/45l
         tTEg==
X-Gm-Message-State: AOAM530JKjNpMFSaxn8v79uqnHOcc/WeVmiRe+VfyuMGmj5fjVxrESaf
        fGfbyTiT+9yOwyikxD7nVLU=
X-Google-Smtp-Source: ABdhPJzxXwmn/oI4ZLMGFYfSOoUpKqx5vPY/5BDqCQhRFt8UMHvieheVz0Pk0aXJcrCDbem6SUZgIw==
X-Received: by 2002:a05:6512:30d:: with SMTP id t13mr2622323lfp.84.1609966729843;
        Wed, 06 Jan 2021 12:58:49 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t3sm606970lfe.263.2021.01.06.12.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:58:49 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V4 2/3] dt-bindings: phy: brcm,brcmstb-usb-phy: add BCM4908 binding
Date:   Wed,  6 Jan 2021 21:58:37 +0100
Message-Id: <20210106205838.10964-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106205838.10964-1-zajec5@gmail.com>
References: <20210106205838.10964-1-zajec5@gmail.com>
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
index a5780beadf97..0497368d1fca 100644
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

