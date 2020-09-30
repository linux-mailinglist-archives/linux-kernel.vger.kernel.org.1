Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE53B27F543
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgI3WkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbgI3WkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:40:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90760C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:40:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h17so3497584otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1w+MKbf5xKkMTSCbjMZtxGQzOFrk3MRoVomMxqemDQ=;
        b=mfhnP7rY3Cqvb7FdLurV8Judix8H0TrQ+qLke0CGeNDvGpSr9Nm8xNpXD5DKy5NfVG
         wprQt/8sLiORDd0XUza4IKkwlJqsQwZBkHdLQ3YSzUKlUc8y4F17BKmiKeP/FAI6/OvE
         0JTt7vMqSRXIrBxPAD55IEK+zERvqnFySEBS/+jyK91el91dtx263kzJAonx+IfB/UKN
         ZPvmfZgxbvxpNCZLJjX9QlNiEvrjdZEQChxAiGr2xEKcNj6u+tQlgXHzuR870U3mb/Wf
         Lt7sQ60cAohM6aZEN37x7zlKFC1EBI+dImg2hF7XXznxC5iR8x+RkzjGeyzUkb7ORPf1
         9QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1w+MKbf5xKkMTSCbjMZtxGQzOFrk3MRoVomMxqemDQ=;
        b=S7DphpGGjsnATcvp6kbeGDjlUnKMYjfY6ifEoMXdL1t8Mk2hW5UW4ENiTp6hJGyYh0
         fpgDkwrgcVZ+67mwy1da0rJTQBCRmDYc8NyREJsneahyY6SWnKUydIDoExQPGYwdVSqY
         oC7kPHPaIikn9Zoc6SbuESfQb4MzJ7qUf8FGffGWQ7moE7wRe/0cYl8zDVf1UQU/DKT1
         1t6MLDjRPZ3XGeLjMh9rHwQHBnaZ/eCaCow1SZd2zvOfOKx51lVBMGYSsdxu2SN2NvNm
         dZKTtCjhVHl64XvLlNo66fLIZiEbvv5AzUevRrhvgFgwD/LT0RptUUUPP8GQAhtfraKi
         rTkw==
X-Gm-Message-State: AOAM531Bxw+YDOm8znCBc79YGlX70pQ4EJ9n1JCBJwnEOCJrXsP8uw4p
        fCeF/0/0BuK9E1cnZtwdXex/sw==
X-Google-Smtp-Source: ABdhPJyS4plT+kSdTLIEL/+JsM+p99cBBaXa6h7EWWFDUgIsPbm72YXl0zSvjttynHIL88oTS4LBVg==
X-Received: by 2002:a05:6830:1e39:: with SMTP id t25mr2967510otr.8.1601505615931;
        Wed, 30 Sep 2020 15:40:15 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p8sm781364oot.29.2020.09.30.15.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:40:15 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: drm/bridge: ti-sn65dsi86: Replace #pwm-cells
Date:   Wed, 30 Sep 2020 17:35:31 -0500
Message-Id: <20200930223532.77755-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930223532.77755-1-bjorn.andersson@linaro.org>
References: <20200930223532.77755-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the signal on GPIO4 to drive the backlight controller indeed is
pulse width modulated its purpose is specifically to control the
brightness of a backlight.

Drop the #pwm-cells and instead expose a new property to configure the
granularity of the backlight PWM signal.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index f8622bd0f61e..e380218b4646 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -66,9 +66,12 @@ properties:
       1-based to match the datasheet.  See ../../gpio/gpio.txt for more
       information.
 
-  '#pwm-cells':
-    const: 1
-    description: See ../../pwm/pwm.yaml for description of the cell formats.
+  ti,backlight-scale:
+    description:
+      The granularity of brightness for the PWM signal provided on GPIO4, if
+      this property is specified.
+    minimum: 0
+    maximum: 65535
 
   ports:
     type: object
-- 
2.28.0

