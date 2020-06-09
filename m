Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298451F37D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgFIKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgFIKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:18:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACDFC03E97C;
        Tue,  9 Jun 2020 03:18:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so70063pgn.7;
        Tue, 09 Jun 2020 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qaHu+lOS4HqMUllo0B6KB/Pk6c1pWihOMSjOnZMBY2o=;
        b=l9BnxJDWnTVW0ldCRykjgn3+ZK5jr2hKHSQC3wuOOOq641E3KtzhoKiKXH4DNa/Mdq
         tir9iHBpkf/GSIa2iVepQFFm/DAG+CPrBLr2vzJe0bpg7DnK5tUFzxu9uw1UfJT1/WH2
         v7hNmIGPHl7JNNaUXEzDaCWVBhNf6VtcLcus4u+UjQpVChbzcsPRMOuvShN5YiO1/Vuk
         eqBRwwvofY2VKAQ68vBFo8Jg+8prA6kzpXMfFC9yCc2vM/Z5+rXWSHgJF2LTFlDlWayl
         dYgKRrz8Mn3V2e3g1RVnHBMX0IfsVFcajWbJOiWuG8evaEvOgni4Q6K1p44ggSqpvg52
         DgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qaHu+lOS4HqMUllo0B6KB/Pk6c1pWihOMSjOnZMBY2o=;
        b=GueN53tt9V2X+cmPcpzFKI8xjYp9b+UFhuBLF/cwXuaWkfxsX79IYrivbj4Nmm5e05
         fQKFXPE7rI2qeEmt3znH9e0ugklc7NxiFe9//7Iia9fsmvS8KpDFADkcQxXkmq+PTthf
         hEZdYdVllxjnqWwI00jZUUNZb68Uvy3F1aZi4IATMK552CXGGYTVb3glLHrbGWOYtTHz
         BRz5leS8+AqZlzkiktomTJMqhOvOquiU3qBn5Bi13wDjrgEr5CSdEAxNucPropigO8y6
         YBqjnJdoYWNSbPl6asb26qOjIeD4sowfvRpQ7Yo7CKC985CsmCm3WVOENOqaCaYcQLbF
         6CaQ==
X-Gm-Message-State: AOAM533q1ToSVwcxVHBwWAwJIXIWMYcajow1OLPbElUOJWcpi4HHntV2
        QrqbwFadJdKBQZPVQzHli1c=
X-Google-Smtp-Source: ABdhPJx27IQ3ZXDqGg5+M5DgRVC4TvnofbEo9tRZjpSBxaauw9aXPaH3TmIiJOC6henWCBEiB/LNdg==
X-Received: by 2002:a63:f804:: with SMTP id n4mr9504183pgh.302.1591697891572;
        Tue, 09 Jun 2020 03:18:11 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:18:10 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Tue,  9 Jun 2020 15:47:08 +0530
Message-Id: <1591697830-16311-9-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
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
Changes since v3:
        * No change.
Changes since v2:
        * Added Rob's Reviewed-by tag

* Newly added patch in v2.
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

