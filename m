Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6563529BAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807598AbgJ0QMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:12:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1802001AbgJ0QGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:06:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so2551123wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2o0NP0S9IKMIYtZh0rK85wpdZyLqH3CjfIzafWh3T1M=;
        b=gc3wETkfZTjfdkDofvqk/rEFWOyZf/bsJh0lBSp4vQHy7Xmup3eUSnw0ckfNsMTlKc
         7qI0BUBC6g9BKYJP2QxOnBQY0WwTJ4qFmAIS7pnW7erJjxnqwbjpUyhU65bOG69ASDtX
         32MSBAfRRU1msgTl3ycWW1oIG07Nz7Z06ppDOy0s8jsIe9ajHSEQTZRHMiyjhfE5G/kV
         wSx83YYM4BUtB/Til+Psdi8mMYz470jReTlXEilugMS+GkbYA5dvWuiWoY/1v17vkE5E
         2Mf3vPTWa6G70bMLabvnxNa5WNbXhaXG5DXvElQz57gEIeMF38qvGRks8mpca4L30rgr
         JI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2o0NP0S9IKMIYtZh0rK85wpdZyLqH3CjfIzafWh3T1M=;
        b=NzgEinVb2VIrzmKH/NaJ4h/kHGFhUQWghC9UthbxvRiDOUH0HUd7AbmW79lvoL9IJH
         r+6lw6ecyRlZe00aj3bN/diZoGi39MIGmtkNEGJEgshxMiakAmBWRDcZ0fTmiztRBtwJ
         X9sBIQ/vkk+EtXlhEqOvv2xIEpz9z4s+Kp11oNZ3uj98IMArgtR9AG8Qkzmgy4Ausd+W
         aiaJwnu4KJK1L2fERFnDNg5AgfD9xDPuvdwMBFUVuQI4q41jaDA4OegpLbI1w4+iCyuN
         tLeRHKAlXJLExbOk9cKHbXIQ2E/DfKIG0Yjj89ZT0JP7GpEodI7uEifEVzj5MYcNsUQk
         a7ZQ==
X-Gm-Message-State: AOAM53298aMpu3M1Kni2MgGbF8zUBoxMJVm1SAdEqr+duRL5yg/ril2w
        PqIG69G45YW3VEojg7kH6wUepg==
X-Google-Smtp-Source: ABdhPJx7aos5PzrahnnOd9RdHxUgT77NM16RV43TCCat0bwz+NKJkLk+zqi21kJ4IXAXwFVHn5MHog==
X-Received: by 2002:adf:e885:: with SMTP id d5mr3732878wrm.100.1603814795825;
        Tue, 27 Oct 2020 09:06:35 -0700 (PDT)
Received: from localhost.localdomain (159.174.185.81.rev.sfr.net. [81.185.174.159])
        by smtp.gmail.com with ESMTPSA id u15sm2656988wrm.77.2020.10.27.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:06:35 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
Date:   Tue, 27 Oct 2020 17:06:29 +0100
Message-Id: <20201027160631.608503-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index d8c9108c3b4a..78c50733985c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt6779-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
+	- "mediatek,mt8167-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
 	- "mediatek,mt8183-mmsys", "syscon"
 - #clock-cells: Must be 1
-- 
2.28.0

