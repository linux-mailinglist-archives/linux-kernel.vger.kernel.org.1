Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08092B40A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgKPKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgKPKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:16:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7395C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:16:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so18007441wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dYJtPTYT6zqSviFEoyuJVLQepwx0AVqn3LnihaWjaQ=;
        b=UjfmdbEmpKOGnekOBK+J4IyAP5SU0GKIh56iaq5I7d8+xqH8/n/xdP2pWWQctUzZAv
         KqSFRsa7izEvgDeYvHyUZKPmGVRvSGVMiBKkJvFtudnKQA9T2W45KyCEgSW6OsDtjQ/6
         RP9/Vc+ddEetdn6LT0JpdG6xzlcSdY3P6mzIXTQAEiklRRDK/BEeazudt016zL7F9Wpm
         bVCaA80+/VVP5CA9Y6h33zoIpDWNwyXu8fMw/eTrzKFilFTwyIibmLk/zrAKip3fXAm0
         QqmuF61H0jRFF14ALdsb2wOjjsgOYzhMLNBbhWEVWc5GemC61ioM3dDWi6TZkoer8l0J
         ZTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dYJtPTYT6zqSviFEoyuJVLQepwx0AVqn3LnihaWjaQ=;
        b=mkD2fzWfHoSL0LZu3j16Byob6FOOLoGnhlCUmkuDVQ3ALfo0UJjCaDU8IWnhOQVhcU
         U6G4fCN3eCrnlJoM+fNNPTY8EaxIzw2gxLp5sqaE+ljDDZ8+0phHwoEu6FmZjouaK6T4
         LFs5cYKkQTvKpbaser3r4p4jze0XGjo34RpU+rnybn4DdGIrZKTtdFsoOZb9WZeDyAOI
         4K1qFoq0A6JOs2xZWMbZIj4Nz+Rf10AYWgxEAfU494YaU+4/S8YZFa/gV1t7jkm75DzT
         trWyDA4Q7jxYQ61uczbBtUyaZQzTys1K/ZHGMXwGAz34cnNDmds8UL0M8atGdwloYFIv
         /ETQ==
X-Gm-Message-State: AOAM53280ohZzcdhUFs3LeFsgS0VYy7al7CRQOWR88hOr0KhRZHjVW8J
        6O2ZaP2YgxKNj7TzSSJiIeCx+Q==
X-Google-Smtp-Source: ABdhPJyYONDEDIrJ1XvKWq53W8urXPyOX6Uj6h4HdNDHCqAdP91wFip1sBUTAHngykTJps8pKNkNmQ==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr19540242wrx.251.1605521813480;
        Mon, 16 Nov 2020 02:16:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id c17sm22265131wro.19.2020.11.16.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:16:52 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org,
        vkoul@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 2/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell parameter
Date:   Mon, 16 Nov 2020 11:16:46 +0100
Message-Id: <20201116101647.73448-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116101647.73448-1-narmstrong@baylibre.com>
References: <20201116101647.73448-1-narmstrong@baylibre.com>
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

