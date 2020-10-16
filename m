Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04818290A76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbgJPRSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbgJPRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:18:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DEC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:18:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b8so3828772wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxRj1doknn/xUt9dt4A+Dfj/59qnD0jj+WzuGpoEtw8=;
        b=OJHthVY2orfEBGnmd+zroB7jVXNM/DeKLqSGVpZ237xx+RcK4Jce1K71EzuBXxveCB
         ntVMlr1EDOvkacSErILmcMMQ/8Nt1oC8Vl06ljz5KAqAzgzrm086j4KdS/LqFgo3XlOH
         UIiTLYE/P9oOl0U6aivd+z0xxMLbuPEwfDFxjNINSoBeZ5AKFpWKpx2nnYuOO80jQ7Rj
         dWzRPk3XLh3FKhAJlOHVy/+fY9t8gQuQviL02bQK1Ew8kAngA1Z2GIjFbtoVyKE8JSUj
         RwEx4mNmjXS+DobDktwxFxVmyIcwuUCsTeVT/2MtvdjC5FWo0sFMbL2rLyV+8f0Y2qPm
         Ry6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxRj1doknn/xUt9dt4A+Dfj/59qnD0jj+WzuGpoEtw8=;
        b=Lz+jjMMVfHduXbKmTo5iN+mFBbC3+sRiro1ePcZJAOQPRTT7+FE9fWUwQLZ40VFb8E
         PXBNFgRC3RhVm155WSbKDPMM8FXd8pwzEtbv8VXjKbukf3LUISLLTm5z1+NeBWtR0vGg
         tHUKXNxoe1SFXgo0UF2hWXH+0OBmPtt/4pcTu1QW0xQZZu7pmq/PwcZTOsUG7EleM5BO
         41Fqj3ktxpmrzWecTiqg+U0Rrcn3RniXK44E/IGRDJrf0SnHCHhh6DNe9DBtU7MWsl2o
         B57yx6omu5IiL4nEQ9ti0eHx7MM/lGRx5qo+0fkk2UF4nhzYjRn3EnSACTKId+dMAruA
         MELA==
X-Gm-Message-State: AOAM530xj2OXsHTJx013SqK97BMbx1XzYVcT1eH4+VQtwYU0yBh4CWXF
        LTrlatNH1RVbuq0liGXPKlWEiq6ak6nAGw==
X-Google-Smtp-Source: ABdhPJxMMoIjZdN4eGMUPlC37fq6cmHIzrXVd95AulMRGp1cDZLxwZQQ6TAKQp45QX+vpzgJvkntmg==
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr4887656wrx.278.1602868721280;
        Fri, 16 Oct 2020 10:18:41 -0700 (PDT)
Received: from localhost.localdomain (211.163.185.81.rev.sfr.net. [81.185.163.211])
        by smtp.gmail.com with ESMTPSA id o6sm4177162wrm.69.2020.10.16.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:18:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: nvmem: mtk-efuse: add documentation for MT8516 SoC
Date:   Fri, 16 Oct 2020 19:18:36 +0200
Message-Id: <20201016171837.3261310-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index 0668c45a156d..ef93c3b95424 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -7,6 +7,7 @@ Required properties:
 	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
 	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
 	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
+	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
 - reg: Should contain registers location and length
 
 = Data cells =
-- 
2.28.0

