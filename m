Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0B27BF89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgI2Icq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgI2Ico (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:32:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k13so3828059pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sUVXqpZJYkTBREYHZGN9bQA2aipRxyO9aiTTvfxyw8=;
        b=kfiW+NjdDy+C2sILWaGX88I2j6iS3pWFqcOPb2ZJZw4qrj1QS47zGBedSGdh8guFTY
         7mMLHb1rV8z8LCZ4fhO82oLCjnExT4WTFpie9mwGkjshyZHsBWLWAYgzr7rylJaU8Nld
         aw2KqJk/wk/SYbFuhHEKz38/9fMW122qWpEto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sUVXqpZJYkTBREYHZGN9bQA2aipRxyO9aiTTvfxyw8=;
        b=U8W5TWMQ6xS8TMdgqa8tbbGdZBOMwwIgCHYuI8PUfHxz76MnjzWXmWfwKy/Xo2LhwR
         Mfo88/CrABF/+DhRUstGe/+18pUqx7BKUlp/Sz2FLm2vPlSm9SqJBkhi18LF7TIAj4S6
         2LyCgkrWKmlWlmbzfbGnZxT3ohSITrGCU/ETMbrI53rG4VULzcHfWGhUT9OyT0/W2GLc
         aiNaDFkr/jTDspGfW7B/tUg6O1i6KUo03P49Xxqx/XTae4DNi2735u9trVpZHIsxs5Z8
         X9WXnR/B1kNffFXcYiWVbKVWyHoVQTg/QnXLpe6KXmJpwXvCxyu67C9QklDGiZLek6u+
         6nZA==
X-Gm-Message-State: AOAM530+qfSb6FRaQt4AZ7Yq98cfQFT6x7FpWJJDPQK+sMSTQ0EorRIc
        Q4ZMfab7TPpJm4EBbsz8REeHXg==
X-Google-Smtp-Source: ABdhPJzFRDorTIZS2Gzyq7KzAqkcBtri5d5hVUIMskwm3+Oj6sHiU6SVA+IXKnbF7FFx6WPpwe1KKw==
X-Received: by 2002:a17:902:6902:b029:d0:cb2d:f26d with SMTP id j2-20020a1709026902b02900d0cb2df26dmr3650727plk.6.1601368363652;
        Tue, 29 Sep 2020 01:32:43 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([2405:201:c809:c7d5:b511:310d:8495:d767])
        by smtp.gmail.com with ESMTPSA id 36sm3961241pgl.72.2020.09.29.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:32:43 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Tue, 29 Sep 2020 14:02:11 +0530
Message-Id: <20200929083217.25406-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board from Engicam.

PX30.Core needs to mount on top of this Evaluation board for
creating complete PX30.Core EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v4, v3:
- none
Changes for v2:
- collect Rob A-b

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7025d00c06cc..bda0f2781890 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -70,6 +70,12 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: Engicam PX30.Core EDIMM2.2 Starter Kit
+        items:
+          - const: engicam,px30-core-edimm2.2
+          - const: engicam,px30-px30-core
+          - const: rockchip,px30
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:
-- 
2.25.1

