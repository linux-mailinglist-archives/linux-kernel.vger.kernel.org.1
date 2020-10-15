Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5849328F226
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgJOMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgJOMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:33:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BEAC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:33:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so3430775wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gAf5fB5iQjUkbZE2PNnBqlTvtlb0W+hOlezFL2z0t0=;
        b=phvyFg4xjOGamHGSk/i05nAsDluAs0yWPaT2/eZkZDWz6fh0DSNW+CxmypNWD3fgle
         8AC8w0CuYMtRyP2XvJCqOl7LznkwXyw+cmbpYGi9Qvqk8v4qgD+YVngklOb1YPlZNUpY
         PUWRaFKto7ziGDDuVUXqr9Gw9rozNF27/AkXBF4b5bOmiDhfX6B8+YubTpadSuWCYwie
         5taGkWoqWKn2JjKsSHJby4S6ytLFCNrBGBbw946DYXamCF6ZEmR3PIZB5q+GCgpnYqgd
         xZCtA59kD753+zU0S0xYgVc8jfTVBYa3C4BjN1b3+U879tXdYkKFu/JEEAjFabYwHVHo
         Vfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gAf5fB5iQjUkbZE2PNnBqlTvtlb0W+hOlezFL2z0t0=;
        b=nJSkeUcvqP4+IjEGlb1iDVuBwTyYh9iRyz1rErbJ7fUhG5SF5njPh/fdioerSJZA26
         F/56ib3NIUau6pEZAjCZlOJ/6f189iqI+rTZcD0HFyykULYo3CoFqTXM6YUp/otZYzIS
         0OUhneGGvZTSnimnylnL4x2xBWwI2b4yMlJInL3wbT3A+wR1pr/2utT/HSH7W7t6XgaG
         49I1/uYs29Z5pMA/7U1gg1YrvHtvlH5PJmnN7Dv2x0gfQZJ8ut8jvszIiZcYW5j8LCtO
         NHcIkUPrOgSnJD5itWsIt9bXhQIT7LW0rmDNDJDAxtuMUBIm1+Jt8T89tbqXZJYou7gT
         lJqg==
X-Gm-Message-State: AOAM530fVkoYKsp68a0Fcik3Xs6DY9rF3fhkAuIUszEL1sSubw/AX9jS
        oK/o4eeVE9L5p685duxZ5gyhINlCsE2yzg==
X-Google-Smtp-Source: ABdhPJwMWmhzac8KOGYrXil1jcjuEazEomj2N1xyRdOMuoCb7xSRa3SeIB2Z0+rBWSrgh8MElOQYdQ==
X-Received: by 2002:a05:600c:2905:: with SMTP id i5mr3815469wmd.9.1602765199464;
        Thu, 15 Oct 2020 05:33:19 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net. [81.185.163.129])
        by smtp.gmail.com with ESMTPSA id j7sm4017406wmc.7.2020.10.15.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:33:18 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, vkoul@kernel.org,
        sean.wang@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516 SOC
Date:   Thu, 15 Oct 2020 14:33:14 +0200
Message-Id: <20201015123315.334919-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
index 2117db0ce4f2..fef9c1eeb264 100644
--- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
+++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible should contain:
   * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
   * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
+  * "mediatek,mt8516-uart-dma", "mediatek,mt6577" for MT8516 SoC
 
 - reg: The base address of the APDMA register bank.
 
-- 
2.28.0

