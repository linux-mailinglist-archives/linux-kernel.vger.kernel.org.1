Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA072A65A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgKDN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgKDN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:56:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C5C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 05:56:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s9so22123537wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dYJtPTYT6zqSviFEoyuJVLQepwx0AVqn3LnihaWjaQ=;
        b=HjTSuvVXCLyN5Xb17UWY0BzXH/9TcQ/mu6B3kXBVUzk50Edp862ZGilGal3UUbM3Q9
         8JJW1+SlCJKT2m4vlOdrFXFm4q5S4l5PkuRGU5hGMkb486tly5uLQTFAG43bG5JwFFv8
         Ohgc4hoWNFlERixWLWFRcf9L2Z7euaklDLS/iMZ9aIwcmC1YAvv/RGQRzFUDcVRc/dG1
         8Jyi3MQ2MbYHIL524rrwhdHRXA+H8iI0zirrBy4o5v9b9JjL86TkK6uDQmmhIEsfkINs
         XMpKlwZsj2RrDhkkdXPFRK35thB9Zo3ZY13RWIA+NgbuT4G+wlMt9aUfFfj/aRwzScfS
         MOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dYJtPTYT6zqSviFEoyuJVLQepwx0AVqn3LnihaWjaQ=;
        b=VcYMqfJLTkq2/4T9HXONRD6aPA5u8XhtZvi9kcqnLH1d4O/vpT6N60+4IETUjPGzkE
         tJamSlVkRCYWlITqBJlDl1hDO5BTWCSqtq/+FtubHksU34cj9h87b32KVtuzDm+yHeUs
         5aLFIcUZFdJBhBUJ6/ckztNNgeZfA8KYM/nGlxxMgzcMQkCSKwDxan2FU6Yq2EkkWV2s
         LsobesH4fSA87ZaC9AkYSjA7GFak6Kp7N/pLnGdAFDWNEEom8pjkhM0wMknfRV3z+PH3
         ueaOYSr10VfBvMZ2jdWRSKtydo/Dt+WrdmzyKJuv00tihmiqlbc4zGLQCkCCaegttCtv
         +GEg==
X-Gm-Message-State: AOAM530xMuAka73keiW4EpnouQIa7JZYWd1IkXVkYP7GqZaN0bsaVPgc
        Ht4eIC4tpGA6F+183fBxcmZAYg==
X-Google-Smtp-Source: ABdhPJzbZfYlPISkG4WkSzxh4Sv5r+tnOypjZAiYnby/8qahqW1xegCvNbYUsxN+HvEEWUi4XVUlMQ==
X-Received: by 2002:a5d:624e:: with SMTP id m14mr7986418wrv.413.1604498197937;
        Wed, 04 Nov 2020 05:56:37 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:61b2:b9fb:eeb7:b9f7])
        by smtp.gmail.com with ESMTPSA id n9sm2285234wmd.4.2020.11.04.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 05:56:37 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell parameter
Date:   Wed,  4 Nov 2020 14:56:30 +0100
Message-Id: <20201104135631.1550125-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104135631.1550125-1-narmstrong@baylibre.com>
References: <20201104135631.1550125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
MIPI DSI at the same time, and is not exclusive.

Thus remove the invalid phy cell parameter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 702763a84dac..4d01f3124e1c 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -24,7 +24,7 @@ properties:
     const: amlogic,axg-mipi-pcie-analog-phy
 
   "#phy-cells":
-    const: 1
+    const: 0
 
 required:
   - compatible
@@ -36,5 +36,5 @@ examples:
   - |
     mpphy: phy {
           compatible = "amlogic,axg-mipi-pcie-analog-phy";
-          #phy-cells = <1>;
+          #phy-cells = <0>;
     };
-- 
2.25.1

