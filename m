Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF12941A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437207AbgJTRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391701AbgJTRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B76C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so2937597wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPldaAln0wKV7enamBXwVRl5MAfLsITQC/GnZaAj1po=;
        b=wdF9uoO+Ykbhxvbj/BpimI1WuFHEdYHMfvhomEaYkckQkI4DtzI3Dr/dLEZjcQeH61
         TRk+GZZuWg4DrKcU9BlaJP59g048zt5611B7itGSWHXYrjTwCTfLXo9cWlKuekgY5nqD
         F/Y9Srju0qajoPep+dnWtRxj+TIIc/6v7TTjeHY/qCzDyfC0wXVB24XYjeDA9guBd2T2
         NoFzhVNKNZ8Cr1sBnaulV99aq8LB6POuSCaCZQPmoKyRyDzowb6anbSOS3ac6FCrS5gz
         tj42kqp7bAFF+RTciFBlHkcSGW3kblhffsApqgY4Udc4K5gJ3Y8YgApx54/WsQYGhUZ1
         4SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPldaAln0wKV7enamBXwVRl5MAfLsITQC/GnZaAj1po=;
        b=GKtcmazE1L+j03SgED3GDfbbFSA1KzEUBUdiZR7gX2bSdyrsxUwyibm/Ov/MKC1Kfj
         QKP1KcfWVDzQkJiYLL0U0xLQpqH05O6r/V4uiq07nN8bOFl0zlQvaduGjbGFZE0IXRtV
         7YlljyFEULSGYy2aGKl0GirwZH6XqiDu43KII7qW1ewoV9wIqjDcVtf1lX9AT9G8lJTK
         sYPlzIFhE+2rxfhgDl9UxBThBqqIeKU2pe/RO4hL7BtUTg7NhLrzFiVPVJHcyYH0M1un
         B0jtGRgyvSucPFFxz7BT+/IOz0xIHO+4RmyLeGsV7fSlOp3jJgx/UEsyCsGxizfxyOhE
         ncQg==
X-Gm-Message-State: AOAM533aXfXOt7anoUdnxWBlTmhidLuS8kohXYO1q8BnWlWJ9ZhEK8tp
        BERHgefsslNqlWkY1u+cPmxV4Q==
X-Google-Smtp-Source: ABdhPJzc5f87ZwIDIbbgCVZgs9r3XrFUb0sfEhjseIGs62RR8xgLtEjhevlVDme05La0zhRYaSYRAA==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr3983936wmf.24.1603215779042;
        Tue, 20 Oct 2020 10:42:59 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:42:58 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/8] dt-bindings: display: mediatek: disp: add documentation for MT8167 SoC
Date:   Tue, 20 Oct 2020 19:42:46 +0200
Message-Id: <20201020174253.3757771-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8167 SoC

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 121220745d46..33977e15bebd 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -43,7 +43,7 @@ Required properties (all function blocks):
 	"mediatek,<chip>-dpi"        		- DPI controller, see mediatek,dpi.txt
 	"mediatek,<chip>-disp-mutex" 		- display mutex
 	"mediatek,<chip>-disp-od"    		- overdrive
-  the supported chips are mt2701, mt7623, mt2712 and mt8173.
+  the supported chips are mt2701, mt7623, mt2712, mt8167 and mt8173.
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
   merge and split function blocks).
@@ -59,7 +59,7 @@ Required properties (DMA function blocks):
 	"mediatek,<chip>-disp-ovl"
 	"mediatek,<chip>-disp-rdma"
 	"mediatek,<chip>-disp-wdma"
-  the supported chips are mt2701 and mt8173.
+  the supported chips are mt2701, mt8167 and mt8173.
 - larb: Should contain a phandle pointing to the local arbiter device as defined
   in Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 - iommus: Should point to the respective IOMMU block with master port as
-- 
2.28.0

