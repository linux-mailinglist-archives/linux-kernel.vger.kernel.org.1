Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB52D4157
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgLILsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgLILsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:48:22 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:47:41 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so1677659ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rs3z5HiZz52Q+PqaHhfTF1Q+uRexoKTRYXUuslD9bJA=;
        b=d3T36ZkNR/AUgVDsWMcv+epjmknEjkr1S4/hA5BmOBbmMp3QPmqbQ5+T5urLbZsaZm
         yddM22Ca/MjmaZ65L9Ziy8Eis/rNNRh6ZWV33tysfBDK99xgKIFsPiG/pLxOIGV2msux
         3VZ4X/R76YQSx/b/gtQiCbkElRc8FjmqEJZ9snzxdIWHO32LjhfnKFPVl2brKq/cbdPl
         zpDqtSxW6OC+2JHBCUwRoKYHHWYHCx4jqiOhBquIjUJ4tNKpJzn/IlzziXa4/3PKi8pE
         aTb57hm0IUn94GQTHu2NhsmG7apvTb2fEUQ2K5isvTgowQlyZ+eEA7pRISQ75ZxcifFr
         j0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rs3z5HiZz52Q+PqaHhfTF1Q+uRexoKTRYXUuslD9bJA=;
        b=W73KJ2GSgYharvcdhBu08kx53cyAVxrDwQQiu5MDzaKDN71K0fz+44YJOd9R/dKjLy
         OOJonDc6FC+YL1ddr0LFKMpIGksOODLBclv6jFNEh7zMCu2Bdk/Rt4U87PvDDV4vmTAQ
         zOWdA1Qot5sJJBtBD0IzqkOlibQ6Jn8KGJlKxbP68EUOprWzAjoKGKxTeEhEEm/R7djM
         QX42mpM/fkWF0ntJzz7KWef0P9A7gyLXBGGriQ6/p/IFQ7Bla+Xl6Z9rtj2moO75X4W1
         OzYbqXLGJmNasx0AaaI2EVMC95DLwbNhmTWkPeWDFxncYCcSyuCBLHQLmQy8dOEqQ8JI
         0gsQ==
X-Gm-Message-State: AOAM530uk65j4bkqAHb6eX+GSzSJ0YgZ6C9St/IG+lHobOOf6CXKI4nV
        rRCwclD4+RxbEG+TDShpI2z/VA==
X-Google-Smtp-Source: ABdhPJz4K0kLaWeuPBop0IAkjqejJVnYvx1By/KhxM6pBUYlU2Hn4uST4po7Bl+o5xWrlrVSPgRe1g==
X-Received: by 2002:a17:906:98d4:: with SMTP id zd20mr1710918ejb.532.1607514460504;
        Wed, 09 Dec 2020 03:47:40 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k23sm1244877ejs.100.2020.12.09.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:47:39 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516 SOC
Date:   Wed,  9 Dec 2020 12:47:35 +0100
Message-Id: <20201209114736.70625-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V3: remove unicode symbol that slips into patch summary
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

