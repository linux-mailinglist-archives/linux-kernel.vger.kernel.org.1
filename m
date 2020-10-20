Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D3294199
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbgJTRnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437201AbgJTRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C72C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so2932957wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4H4mc6v2t0oOJX5XSAB3K/LcyD6Rk2g297NTsU0GuU=;
        b=zWcQSDXlGP/96zUAfH5qPzycQ/AK5pvGi5nwVMEHX2j4ynLCXSTLE9qp2r/ZgqpVUR
         HA4D1J8T985dXMnBot5cPB28dimAo8DbYhVpKNYcT1r16Dp5UCWtXkC7BhzEAmk6lA2g
         LpHwQfBiC//6+oOIGn6NZOgytNPgkOhkrdzAhDd/Ff3HFLkWlrnIZt4BF44SrQs54cRx
         StyTw8GWO+LWjQ83yf9x00GL0dvfB3wxR/joYpUni8MOUFzJyYVcAffIhlF8gMBjZJun
         aWGPqjxjC2VoTAS83J6nVKBM90FEti2y28QHrYBcXLGmR3o0dUCskFCU3YFDFYZAOM2K
         +J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4H4mc6v2t0oOJX5XSAB3K/LcyD6Rk2g297NTsU0GuU=;
        b=gv0cShQ3xCyJAeA+YTlRIucKzBkTBPzMI7jkkgwntQmDgka85MIFKiiNvYsJInYSg5
         PPyaZBQxQLTCNA2vHlrBuFlVi59VeKIhHhL5xms5KhvQRYsY4I+ySc+rAuzJfFf/BUHv
         p1MPNSiRTIGkbCD+3XftYuQloFHyI5GCP01cd7EZmXlxju7+OWrAVOgSfOVofxaZ2zW3
         c6mFjZ+wFRIy9DF0BUVR68IB7GFStCFr6W86nuUJ25hlzEW9A0nomNC6NfiN586zp4WQ
         NgG6WJAZZq7ZIJKOgArF3rjkem1S/+w8xrZHvvkBZ9Pj/wN3T16S9TnbUp4vLhzOa8wo
         jjhQ==
X-Gm-Message-State: AOAM530xOEbNFRtUI64NykX8W87//ZbGuzh3as+ye58nBtncDHDKnaD6
        +bCa9SiJOUolQ3SsG7/hlc/ZEg==
X-Google-Smtp-Source: ABdhPJzkT8+U0NpjdVHnhaATbgwrjwpAwrtedA64YWHG7Oi+SvHzjUWaApwcG7WmvLCZ+XbT8s7K3g==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr4068624wmj.168.1603215780592;
        Tue, 20 Oct 2020 10:43:00 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:43:00 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/8] dt-bindings: display: mediatek: dsi: add documentation for MT8167 SoC
Date:   Tue, 20 Oct 2020 19:42:47 +0200
Message-Id: <20201020174253.3757771-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8167 SoC. The SoC needs
an additional clock compared to the already supported SoC: mipi26m.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dsi.txt  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
index f06f24d405a5..10ae6be7225e 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
@@ -7,12 +7,13 @@ channel output.
 
 Required properties:
 - compatible: "mediatek,<chip>-dsi"
-- the supported chips are mt2701, mt7623, mt8173 and mt8183.
+- the supported chips are mt2701, mt7623, mt8167, mt8173 and mt8183.
 - reg: Physical base address and length of the controller's registers
 - interrupts: The interrupt signal from the function block.
 - clocks: device clocks
   See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- clock-names: must contain "engine", "digital", and "hs"
+- clock-names: must contain "engine", "digital", "hs"
+  Can optionnally also contain "mipi26m"
 - phys: phandle link to the MIPI D-PHY controller.
 - phy-names: must contain "dphy"
 - port: Output port node with endpoint definitions as described in
@@ -26,7 +27,7 @@ The MIPI TX configuration module controls the MIPI D-PHY.
 
 Required properties:
 - compatible: "mediatek,<chip>-mipi-tx"
-- the supported chips are mt2701, 7623, mt8173 and mt8183.
+- the supported chips are mt2701, 7623, mt8167, mt8173 and mt8183.
 - reg: Physical base address and length of the controller's registers
 - clocks: PLL reference clock
 - clock-output-names: name of the output clock line to the DSI encoder
-- 
2.28.0

