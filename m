Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101D1EC128
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFBRiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 13:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:38:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C889CC05BD1E;
        Tue,  2 Jun 2020 10:38:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so1724815pju.3;
        Tue, 02 Jun 2020 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XeNbazw1P1YVFCnm7oMnOTxBVQdBw3FZCn0wbADRtR0=;
        b=GH5mz9tyVo80fGEjOQsOXyi0jt77vrrK+rlvCqZ3DFfqqH003rhfSxrTkuHF2FAGZP
         pqDJ+t0ZUCqX6LNn40VrrMuGlvrDi+5fIRfOfCA7xUsPZoCsm/01BwBkD3bKcze3r54Y
         lYsSYAEgPBnzlkbsaMh6LYRrXfGUNqrRHc591IFM4dr4Zma4UuDD0knNOKhTRlPkdNxa
         M5s+m1wuPnFMjESHMstWNxVZFAOxmCfjOBGWFb7d3P4lBNK6MGHObGevRWVhO5Vb0rTl
         BLvdBwa1Dz3ID1B/qEWuphpFAs/2F4Qx0dN6RAflF6fncUljVOlhhTkQHj3FFDppY9ax
         0QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XeNbazw1P1YVFCnm7oMnOTxBVQdBw3FZCn0wbADRtR0=;
        b=SSw7e+wz0LQ7yXBbmVtuBoVB2saxhDdFWvmz5yUdj1qKnUjQNlcEXN6elZPedc5gzE
         iE731p6n4xxeqW3f47WF2L3j/WoqWx+fQInOAUsvXLKe1G8vO3kI130GfRDrjKZ3BJa4
         4cg4F8V3HCV7GAulSMnFg8SJ/EQj5aczLWBfGir9aUKlAhAts9+/twMZ9HZG47VGXYog
         so8G+fSGSfnmUi0vg4ARhHVLICwaDmFgo8f7MvHkyS+/faCNF1t6YvpHqng93kXpwjAx
         yOwYHSpM5j4pIteXgMvQP4An2u2iKN3Wpk2DLStYig4KNK4+vDbOn15TSErCFBcaJ4KD
         n+pQ==
X-Gm-Message-State: AOAM530T9lHHW0SPyk1nztIrNiY8wBdaEiWA0E7tdNIFvGwYyDPx3XEB
        dSjTvX15arp5uJhEbcAllow=
X-Google-Smtp-Source: ABdhPJw0ktkLtrEycPLvO5BT43WoQJ3oBQSZ68ny+5lfVBOCFIl8FdRs8aMT07hzjZKPRM42+st6HQ==
X-Received: by 2002:a17:902:cb13:: with SMTP id c19mr249414ply.51.1591119503290;
        Tue, 02 Jun 2020 10:38:23 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.38.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:38:22 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Tue,  2 Jun 2020 23:03:10 +0530
Message-Id: <1591119192-18538-9-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds a new SoC specific compatible string "actions,s700-mmc"
in combination with more generic string "actions,owl-mmc".

Placement order of these strings should abide by the principle of
"from most specific to most general".

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v2:
	* Added Rob's Reviewed-by tag

* Newly added patch in v2.
---
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index 12b40213426d..9604ef695585 100644
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

