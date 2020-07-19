Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2F22532C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGSRnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:43:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC4C0619D2;
        Sun, 19 Jul 2020 10:43:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so9202117pgm.11;
        Sun, 19 Jul 2020 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLYlz5zLcstFedwvUClCeYbR/tSrAZj+4PU7wzkVOas=;
        b=N9N4kia58MB/FvuKAs/VVvfVXPD4GIw3Ta9I5UnPtNq3jV2eSUFdWHB+BhRE4Fmcdo
         ClxJ6QxP8EEs2XWR/t8e7RbiPvfurrlgtuUzFsOfDKp878aPcbrUNJaWTvQnwkflYvQI
         vaE9PUUa/T0ewyKA4jUNpe55VlwM0C+X+1LeEvTTbWOy0F4x6+aocJdA7QwYxag1N8WY
         sjqSsqWAypktiKWytnA9P962Gj3XhWYpo2sNthV95xCxvjvCj5U0VjzEq/j1heNZs0nP
         GFEyg2vf71i1+b9JBfIH2Cgns9WpUVqeItznMd0j0yVztxSyqCvxCxsc2JmVrdsj8Ymo
         rLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLYlz5zLcstFedwvUClCeYbR/tSrAZj+4PU7wzkVOas=;
        b=QfcS5dVMovkGNp/or396czKNHmw7EwVr9X9bAsPBittkCDM1t4MTlHk+Mqa2U8qK3N
         K0hEgEtfN++vr8T9Lhx27Pz/sJMIE+Mjxw+TybB8qGijcTMerSi8XGKyBJHovCUPXj9c
         /G+eW6CqCBvMtVr7gWTd+rLgbyZcV6nGmnivWkBb2vZ1r8qfjDVKpG3Fbs9fOug5qG3k
         wdLisCfdlqlpve8x5IBahBILLr3zhgJAnkbh6A7+aK3C3eN4oLHaV4bXpqKJKuLjl4mH
         PV2EDNDk7VVO6fvbS6mZSJvpNJcZl2bmsp75nrNxlDnydr7r4ovrmThf4C9+BSC6YzFn
         HXSA==
X-Gm-Message-State: AOAM5333Jpecifjh7/NpcqYCAVx9NvqIdVBfvJTvi2JVB+apbwctYIqf
        2x+EKsBjPiMHBngHrGmPYZU=
X-Google-Smtp-Source: ABdhPJw2SMFYwWepGI+YF3ckzmJDKG8q0mMNIP8cSV1HMt2lZLcmct73XbifuRtMfVg/0hNG6Jcj6Q==
X-Received: by 2002:a62:be06:: with SMTP id l6mr16645381pff.310.1595180591638;
        Sun, 19 Jul 2020 10:43:11 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.43.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:43:11 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Sun, 19 Jul 2020 23:12:05 +0530
Message-Id: <1595180527-11320-9-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds a new SoC specific compatible string "actions,s700-mmc"
in combination with more generic string "actions,owl-mmc".

Placement order of these strings should abide by the principle of
"from most specific to most general".

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes since v4:
        * No change.
Changes since v3:
        * No change.
Changes since v2:
        * Added Rob's Reviewed-by tag
---
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index 1380501fb8f0..5eab25ccf7ae 100644
--- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -14,7 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    const: actions,owl-mmc
+    oneOf:
+      - const: actions,owl-mmc
+      - items:
+          - const: actions,s700-mmc
+          - const: actions,owl-mmc
 
   reg:
     maxItems: 1
-- 
2.7.4

