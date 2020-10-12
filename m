Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6028B3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgJLLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388208AbgJLLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:38:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D52FC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:38:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y12so13426229wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=er1O3yHYE2dfZAtg9MYR2G3dWLGNVrruH1edHcefbnw=;
        b=fGv2d15x8t8FMuQO7gEdPG/kMbWbRe2GCYErOzN+qYTexuoeqeQ13RVl4Re6jAm4/J
         R/mnTWb0U/1ir7iJE4eP5u0riKeXNPrnIlPiW9uVzgL8zlRNCbx1GC4xqtjjWSHjMZvT
         FvIYfcncwoTVI0IOtaNH62YzTzByGH0FsXiLvWIgOuKidnowQlD03XWFPxJQppPrE4AW
         T85FGuPH5Z0bZnZgABhqdtXBDCZeIglD6Y5W94LxvC7B3mLwHHq4vVGtajSovmxFOYfV
         9FC1DbUH+aLAU5IIsbtI9OeoIkudCr9gSMicBLbZfmgzX+W4plZn95pIsa/RvzK8qvAF
         BnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=er1O3yHYE2dfZAtg9MYR2G3dWLGNVrruH1edHcefbnw=;
        b=aL4a2nEp/VWu07bcFHXJg88IACTpY/126KOTWBgCDQ2t53cVPEIbrdyFWmTV0MS1Kn
         1CVwsfSDP1XydHkE4w5sjefRtt6xhwNdvzBgnaK+kpXQMZ3fVy/NVFDbenj0rrBf4av+
         HUe/KZwbN3rdDtWg+157zn2zauEHhldwG2Pvp6z3aWYszTUWZX89hRpP/foWLoNYO8Et
         u8VQ/2RU44kEJaSuew+8VyKgCd/u5IHE477kJuA6FyiK0EDErAwD0+i3me6EDTRuksTM
         qS7KPKgbG/hStfn+hQAisi62ZBR8xULfgQvDDsnRyWNC6GccilNigPPlJvl1TVYYKXM8
         /zZg==
X-Gm-Message-State: AOAM532AvYdPGvHvDFBr/ZiUimTnp0pRYkCK4pdW+LI1NuYizd92mB+Z
        FVaqP5LABT8QgRm9AONp98GMnPUOKqWPyw==
X-Google-Smtp-Source: ABdhPJziaYfK5ROz2ZhqIXhTGzXACuyMOEE9XE8nlHbMcsWpb1lIfGcTo1l9oqBQueuCIUPQxQaDAg==
X-Received: by 2002:adf:9e06:: with SMTP id u6mr29835150wre.208.1602502731842;
        Mon, 12 Oct 2020 04:38:51 -0700 (PDT)
Received: from localhost.localdomain (170.175.185.81.rev.sfr.net. [81.185.175.170])
        by smtp.gmail.com with ESMTPSA id o194sm22378065wme.24.2020.10.12.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 04:38:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, matthias.bgg@gmail.com
Cc:     hsin-hsiung.wang@mediatek.com, lee.jones@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date:   Mon, 12 Oct 2020 13:38:38 +0200
Message-Id: <20201012113840.396358-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

V6:
	* No changes
V5:
	* Rebased, removed regulator documentation because it will be send later
	on in another patch series
V4:
	* No change
V3:
	* No change
V2:
	* New patch

 Documentation/devicetree/bindings/mfd/mt6397.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 2661775a3825..f051a951ba72 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -21,6 +21,7 @@ Required properties:
 compatible:
 	"mediatek,mt6323" for PMIC MT6323
 	"mediatek,mt6358" for PMIC MT6358
+	"mediatek,mt6392" for PMIC MT6392
 	"mediatek,mt6397" for PMIC MT6397
 
 Optional subnodes:
@@ -52,7 +53,10 @@ Optional subnodes:
 
 - keys
 	Required properties:
-		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+		- compatible:
+			- "mediatek,mt6323-keys"
+			- "mediatek,mt6392-keys", "mediatek,mt6397-keys"
+			- "mediatek,mt6397-keys"
 	see ../input/mtk-pmic-keys.txt
 
 - power-controller
-- 
2.28.0

