Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1348829708D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464890AbgJWNbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464879AbgJWNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:31:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A76FC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w23so391943wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEIQEN0FiX78PtyGPLU6UM8Z2jaXBw6a+LxRvgLs6c0=;
        b=K/0t+tb4Wog9jbcWVMxLS+5RCOWuTowML4Yhf8SUgfVAQaKXXPIJ1KwIOrJlUwYqxb
         WkSynxXMb8x8hbXWJPNxxI+6ehjbVApy+BPpsR93Obz46GgBgtwfhv6QddDGUo59xfcV
         8VPKf0A3hqGTfidaD6+sxboQ9qfaJ/oMmf2v2M9t+UqEBj/bSDGOKPjwE6z5x/Yco93j
         aUeKJPNYvRmSAoiEq1oGdmlNsKT2jIpvF2gT66z3ngcpr8RcX5xalNI7MfQr/uXdK99X
         n9Uknh0ci0hhlNrFwq+EKxnFwmuoz9X8X3u2tySUbYKkVjdqeDwnadO8P2d9vZC7ab9Y
         wGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEIQEN0FiX78PtyGPLU6UM8Z2jaXBw6a+LxRvgLs6c0=;
        b=JZcckBfD+5tqQ4dnqxWdTItum6J1h2ghgiF4NWtrl/p7ZoeXr1O3IRjoAtiEFvYo+6
         KrK6LM1q6wxxoSUGCyf7JNqHM1X/MHGTNo/fkW9XuqxSXoMiUFnGhZiFqWo/vAg8G6p3
         dfqqtyEqHas2mdKygPu+eYL/+iWEmQVmQeL8DRzexMvqW1GyBRn4FDgktlqm5XU4QHdm
         FuNdFBmb2CUwEZ23q7WkdnCcNvAqNymCqqJZ0eNejDMQ/M93zkcNtIQJIsj6bxryWc5Z
         ZwEAu75DN/H8Nx19SgQG9umYJYub45oOcs+XB8i5fUxn7VD/KWd2fhrm1DRY/0aC4J/N
         ErXA==
X-Gm-Message-State: AOAM530vJQtcIEJPuhPN+GosbxjkadChOqZss8R34fkKZBAsS1fzx5wU
        kGPNWE4EYhWeDzJMqnJunkUkmw==
X-Google-Smtp-Source: ABdhPJyfkaJrUDUwQgeF3HxVQWlJt1iTJtu5s+b5Rq1uR/Z8v+wI/Knb1pA8CmTrO1TaadRdqa+kOg==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr2316512wmb.124.1603459898104;
        Fri, 23 Oct 2020 06:31:38 -0700 (PDT)
Received: from localhost.localdomain (211.160.185.81.rev.sfr.net. [81.185.160.211])
        by smtp.gmail.com with ESMTPSA id f6sm3146107wru.50.2020.10.23.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:31:37 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 2/5] dt-bindings: display: mediatek: dsi: add documentation for MT8167 SoC
Date:   Fri, 23 Oct 2020 15:31:27 +0200
Message-Id: <20201023133130.194140-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023133130.194140-1-fparent@baylibre.com>
References: <20201023133130.194140-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

Changelog:

V2: removed part that added a new clock

 .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
index f06f24d405a5..6a10de812158 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
@@ -7,7 +7,7 @@ channel output.
 
 Required properties:
 - compatible: "mediatek,<chip>-dsi"
-- the supported chips are mt2701, mt7623, mt8173 and mt8183.
+- the supported chips are mt2701, mt7623, mt8167, mt8173 and mt8183.
 - reg: Physical base address and length of the controller's registers
 - interrupts: The interrupt signal from the function block.
 - clocks: device clocks
@@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PHY.
 
 Required properties:
 - compatible: "mediatek,<chip>-mipi-tx"
-- the supported chips are mt2701, 7623, mt8173 and mt8183.
+- the supported chips are mt2701, 7623, mt8167, mt8173 and mt8183.
 - reg: Physical base address and length of the controller's registers
 - clocks: PLL reference clock
 - clock-output-names: name of the output clock line to the DSI encoder
-- 
2.28.0

