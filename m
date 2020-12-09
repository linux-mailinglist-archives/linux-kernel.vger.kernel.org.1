Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7A2D414D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgLILpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgLILpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:45:30 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D5C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:44:50 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cw27so1206465edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3zBnoEd2BLvViOa+U8szKTE6OyLng93MHF1miQwX9o=;
        b=Byyh+WzGJwB9hb+hsnXSoHIvv+Tr7CA98iS13mEF37Dm62Y+yT8PAW5ZANj12pQ5sA
         xvYJQCYfDnP/mmuw0CNmbpbbk8YWu1rSlBZ04EPWvksHnWIRBBi6berkz8TuWyaS8kvV
         ep3ZCcV26ZEqwMuVeobHq7u/RFQ16VCoAjsvcZBtRakby1zzJCMCskm2VQjt/nx+30GA
         FKC23QCKr2trZC/BtbKKaJBPacLMroHcsHd8cj2y338s8XiSqWx9IgJV/766AeY/QMto
         Y5fG7Ls6ljj3PceYbWChqlGyj6fMRbV7NWK6UhJyvGIRlzw0Ttbfk5Go3apzggTfZm2B
         k1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3zBnoEd2BLvViOa+U8szKTE6OyLng93MHF1miQwX9o=;
        b=rEyhbogcVW41b+j3d+4xy6BHsFLxJGavhmQCLLjnuycSdxlOmHzLJQnYROMmwlExFg
         fKkTR25fru+XG1v3gE+A2v+AAIcLfuYrXmwulnujnDMs//wFMzeBtdAMGoYGlgdFEXBh
         F6AXDbWS/ryJCkuGZFPuwK2qyj1sG2SdN48xhBZwJVc/4PKLJVAZJ4cwch/QSW/cqhjU
         aKTTIw6L/OiVDDCDA9Z9lVUbpxAls/Ze80BaPcJA5cHmwmpyEoAa4x7cbq1h8PC1OrW8
         ghd0gxMK6K2yPZuu1bgjku8Bq8leDY5QulSsKUMNK+qK/lKT51zYaGEGTozTjv7z829f
         EPaQ==
X-Gm-Message-State: AOAM533r4HJd0wM4MacsNkSA+EfYvzz85CnbnkTUi9sFcyZjYw4ofOBs
        +bd5E0MvprWYWFjGnKXZfv1cfQ==
X-Google-Smtp-Source: ABdhPJzXaWJEsxBqW/suyQOFajp0LZEwwhaXnTCIKtAoFuT+paYDZO6DqYGylmK2TXlZJjMUrzx4qA==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr1602775edj.293.1607514289034;
        Wed, 09 Dec 2020 03:44:49 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c25sm1260327ejx.39.2020.12.09.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:44:48 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] =?UTF-8?q?=F0=9F=93=A4=20dt-bindings:=20dma:=20mtk?= =?UTF-8?q?-apdma:=20add=20bindings=20for=20MT8516=20SOC?=
Date:   Wed,  9 Dec 2020 12:44:39 +0100
Message-Id: <20201209114440.62950-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V2: no change

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
2.29.2

