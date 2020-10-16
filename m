Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5541290C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410989AbgJPT1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410955AbgJPT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:27:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981CC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y1so1807134plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+eTonsOgHo0VpdzJxRB/GPu2K4jh+xpWGoOhIyKr/g=;
        b=HEpM1JYoHoJLkOOP2sbmDVjF8fN9J5syKs04/Xn+ydhlhZnLsBLzkUELW7R6LomGMO
         1Qs9MIwJJBFNJhNgfrHjfsnC9i2gV6ZBYJWh4pQP114oqU1ZrY1BDH2LaQ0YGJoqVjf/
         vW5+VSxxMi3tgOxUcHmwK1tfJPG/2/Dt7VGHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+eTonsOgHo0VpdzJxRB/GPu2K4jh+xpWGoOhIyKr/g=;
        b=db/pWDvGD+amzuPAaAfPbk6BypmkaUd8/HEzM0UNvHqTnl/IZNTR0zHpGhuA0j2eGv
         rE1OYyvZJuUZz1w4W4fRQR3TvUaCcpgQFQ30kPo/FGKZf1P33Cams5BYWV5qyAQZlUhi
         f181cg8pqrIka13S4ZZfYrg5LbPN2UfEdoOAdnIU9z70wHbdIFsJz+qjbxYNw1dcR/kp
         +oEr/ywfySkqBOeO1JMbfa6zEpVT9CM5fewuZKqff3sZorhaZnidQWIJp/tazQ6i7PJb
         040FFs00//jIrLsP1bGkSjRiDX1xIAKndQgCFEC43OO3sE5g4DI4w5srmHYxzbDYmXw+
         YkrQ==
X-Gm-Message-State: AOAM531SCuGBE2+fM/1UIFO5d9yLxANVDi64H1UiXVd++/S0oa2De+t7
        9U7FY2E12N6//7XTInOub7rdBQ==
X-Google-Smtp-Source: ABdhPJy+OQEHMSMcS1vd93N60CBMVeSW+QitL/129/y8kekcDBQACGbQbgRON7NeBT5QkZx+oPIx/Q==
X-Received: by 2002:a17:90b:d91:: with SMTP id bg17mr5649631pjb.66.1602876434596;
        Fri, 16 Oct 2020 12:27:14 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id lb13sm3566622pjb.5.2020.10.16.12.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Oct 2020 12:27:14 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: nvmem: Add soc qfprom compatible strings
Date:   Fri, 16 Oct 2020 12:26:51 -0700
Message-Id: <20201016122559.v2.1.I8b447ca96abfbef5f298d77350e6c9d1d18d00f6@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016192654.32610-1-evgreen@chromium.org>
References: <20201016192654.32610-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC-specific compatible strings so that data can be attached
to it in the driver.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
 - Add other soc compatible strings (Doug)
 - Fix compatible string definition (Doug)

 .../devicetree/bindings/nvmem/qcom,qfprom.yaml      | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 1a18b6bab35e7..eb1440045aff1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -14,7 +14,18 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,qfprom
+    items:
+      - enum:
+          - qcom,apq8064-qfprom
+          - qcom,apq8084-qfprom
+          - qcom,msm8974-qfprom
+          - qcom,msm8916-qfprom
+          - qcom,msm8996-qfprom
+          - qcom,msm8998-qfprom
+          - qcom,qcs404-qfprom
+          - qcom,sc7180-qfprom
+          - qcom,sdm845-qfprom
+      - const: qcom,qfprom
 
   reg:
     # If the QFPROM is read-only OS image then only the corrected region
-- 
2.26.2

