Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F882ECE2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhAGKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:50:17 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82BC0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:49:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id s21so3598555pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGJRNiBLbvw7xCPqy2AchkT9eub4MYo4xJlh03INrks=;
        b=DvMLePqIJi9OiOcjbgCxz374NfGoUM+kkmvnmFJ6dm5AugVTHAeNvWJnpakax7L4Ys
         pAUGwtiHnv8dmt/jxPTeNS1SxsS6bo0HoDfZqa1RLbl25dofDVzak/M2MPo2W2Y1OcU1
         YY3BRoWIODySaDmt95gWgW07brIDUUebP31MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGJRNiBLbvw7xCPqy2AchkT9eub4MYo4xJlh03INrks=;
        b=kaf6IWKwqtJlO7gpeZkV6AW2yy48SzaUtonmKf9eWATyT5VxQU2Juc8FEi72Q9dcAM
         qZjHS2sHixee+jdP/1cf3U9GNL7FwlMqtc/nGSxg0wTkVKS2pZYPRh+lOxxS9K9DgpCe
         to4ldiqOEuq9ofgK2zR1TnLUmpR5sKBT5vB3V0H7etnqg+XUtlDuuM6+JkSeoJUsNbPE
         sPulGCsOgkCWBKbSTS5XkWNun1tGYROv9UdvuU4G9n6nQMk7pqPMVN78go9Yuw1IvZVV
         wmyqzYo3kNqwXIPhDvB4TcpayCUfGFNMqj8bubiXlZvYJdBdvy207oGHjzbR6EFRkyqA
         l7fw==
X-Gm-Message-State: AOAM530QPyPfN1ELjyOW4dtaF25LOjshsvhAn3eYG+eCZzZEA9lIl18l
        fYHG8V5LWbz6iUNwBt0qlyphFQ==
X-Google-Smtp-Source: ABdhPJwBSsyXdxgTohL/cng8/yb125s3RKKNUvYQP0am/LN/TsdLSbnjo0eQpDSzU42HyaxOFT6+Nw==
X-Received: by 2002:a05:6a00:8c7:b029:19d:afa5:34e5 with SMTP id s7-20020a056a0008c7b029019dafa534e5mr8491932pfu.30.1610016571251;
        Thu, 07 Jan 2021 02:49:31 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id n10sm5381974pfu.176.2021.01.07.02.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:49:30 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: power: Add domain regulator supply
Date:   Thu,  7 Jan 2021 18:49:14 +0800
Message-Id: <20210107104915.2888408-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107104915.2888408-1-hsinyi@chromium.org>
References: <20210107104915.2888408-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some power domains (eg. mfg) needs to turn on power supply before power
on.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/power/mediatek,power-controller.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index d14cb9bac8497..e529586af5a12 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -82,6 +82,9 @@ patternProperties:
           be specified by order, adding first the BASIC clocks followed by the
           SUSBSYS clocks.
 
+      domain-supply:
+        description: domain regulator supply.
+
       mediatek,infracfg:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the INFRACFG register range.
@@ -130,6 +133,9 @@ patternProperties:
               be specified by order, adding first the BASIC clocks followed by the
               SUSBSYS clocks.
 
+          domain-supply:
+            description: domain regulator supply.
+
           mediatek,infracfg:
             $ref: /schemas/types.yaml#/definitions/phandle
             description: phandle to the device containing the INFRACFG register range.
@@ -178,6 +184,9 @@ patternProperties:
                   be specified by order, adding first the BASIC clocks followed by the
                   SUSBSYS clocks.
 
+              domain-supply:
+                description: domain regulator supply.
+
               mediatek,infracfg:
                 $ref: /schemas/types.yaml#/definitions/phandle
                 description: phandle to the device containing the INFRACFG register range.
-- 
2.29.2.729.g45daf8777d-goog

