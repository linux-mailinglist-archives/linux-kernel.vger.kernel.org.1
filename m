Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A282D224A27
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGRJUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003EFC0619D2;
        Sat, 18 Jul 2020 02:20:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so6462961pls.5;
        Sat, 18 Jul 2020 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CWd71u1VSStjenmpxWOFVNxuJKXhZdTHDWm1zq57kXU=;
        b=G83P+A/zJlAsVWMqogHMju/pOy1PfeGTjN3oUrr1W3v9a5rcZV/NyZ3Ywo78LpsHxZ
         Ejua7A5VvemOj+40P0KpJLw4cC4ZbwgcbGmHncgU/FyBNmLSIwjAowc5Wzoa0veE4930
         0zMEjLI3WBf508bXTX7hhvoakHbI+FBilURlx2/xUd8mjnn0JYoAj67scccS5PbtjtW0
         InRnQAX21EcaLbV8urdu3Qpx+eZ6HrR3LAoybuP2n4MQFiFUs3z2mys/zRxDCqcIhGmN
         SZarMPDl5yS8C8Cvwd0bXQuulpVrbpbAqymjUe5H2ivlQOGFDDigFvX3fHGFr3AQLpmt
         1IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CWd71u1VSStjenmpxWOFVNxuJKXhZdTHDWm1zq57kXU=;
        b=RZqPE9CavABOi4kNzGaTu3xOg8xN4UbsaVNvF8MRkMrIJwNgRZ5TOwVWRSW6O60gNn
         Wh3skGZkYLCiPZnuUF2q45X9n7RfSBajASgA2CMx+Vrvg/4BE/eDw8XcM1YF9Q5aEPre
         5bStl5O94sniECg5UT4GCURvVvPEDqPSi6X1HhFHV5s5IIXQYoF54RM+jvUBnCz2kYqa
         mGr8p1ppp3fNyvQ0sgALxTSvOeQ//BC/p2URSehc74AeI+zeBhbVuxEkJ0bDrlaqk8Rv
         8eS3vazt+RVdjkmipuQRhCcCAYoKztN8XRHwBQ0LmogQ5BBp9Y2XNjsjU9ziRYA/4ScB
         1dOw==
X-Gm-Message-State: AOAM532U54azPncLk/ipNvb8YXa80unLLRjuu0mGS5WM6EY9BJyYGweT
        wOZQaI449qEX/pCDRqqPwpc=
X-Google-Smtp-Source: ABdhPJyQKg9YP13KyO4C2ZVvGTNtsqdIE84tlUeZU3QPKrXo2ad81rYnfQduG3t1tFGsP8QLDCXKNQ==
X-Received: by 2002:a17:902:7083:: with SMTP id z3mr10790884plk.156.1595064042481;
        Sat, 18 Jul 2020 02:20:42 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:41 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Sat, 18 Jul 2020 14:49:32 +0530
Message-Id: <1595063974-24228-9-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
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

