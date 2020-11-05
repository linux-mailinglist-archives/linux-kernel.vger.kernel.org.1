Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F222A895B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgKEV6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732562AbgKEV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:58:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:58:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r186so2320223pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2C9RwNHEEzntRHRC2/FatGdskUP1kHVzkLqXpbiboB8=;
        b=PFT3+0PatJKuPYB1chtX4wnurYFYnsTkZSjFZzbZIlZUrbjWqygKzClUHVVTbI4Jpg
         hgURVUNZM1FYPacsH+a8eCi5tVeuuVapm/G9vqavgnwFwa+R2/vlEu2/Hh1v98Z2fOEu
         fQf9HVXfStgowndj35ZlQthH5zvK98BkXHjNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2C9RwNHEEzntRHRC2/FatGdskUP1kHVzkLqXpbiboB8=;
        b=cjQ3UuY1LNz7UZyUzcU83v3hw8zlWCIB6/70QrVekIjjmXECAGNdmthQAemqZp2Cvp
         siRMlATbGz/OGd0OZSItWRfay6EyIz6UVYs/gXyAXwTeRFbQ6fV7YTFpV6w4mIBk9R9q
         u2DmJ2rQPn8C9vnyNcgV+DNU7hcKPPXTdiirxq2GfkdlL17PRMNiBc0sWuWhhRTEtOnC
         SrZ1+yl2YcUkNriVAdjzUu4DrlJPY908QB8TGqWJdT8U2XPpF2i9S7Te/5dMGKhnfeE7
         ysWsNX5/dMjABcRl0pViAzaAONmlpmMVn1T82Erj2WWsYrPeEH0NV0aYqi0z8dilQug4
         4B9Q==
X-Gm-Message-State: AOAM532HnvIHtTPNvWsNutBwbVd78Jpj56rGfgmX/3XMJg0CFC26+0W5
        pc41tEuE1lZb+7csrXNfHY8IUA==
X-Google-Smtp-Source: ABdhPJxiXwT2dZs/H6MoJPes3fNW6/NBVLO8bmXlFqmTu9H1Yd0qzp+LtxSQvsnzXXg9NXSdjBi2DQ==
X-Received: by 2002:a63:d252:: with SMTP id t18mr3901954pgi.300.1604613486363;
        Thu, 05 Nov 2020 13:58:06 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id k7sm3572890pfa.184.2020.11.05.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:58:05 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>, robdclark@chromium.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: dt-bindings: display: simple: Add BOE NV110WTM-N61
Date:   Thu,  5 Nov 2020 13:57:41 -0800
Message-Id: <20201105135639.v3.3.I28d9e32b3cc0aae980ecc39d364263a3f9871298@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105135639.v3.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
References: <20201105135639.v3.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yet another eDP panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index edb53ab0d9eb..93e244c67e8a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -76,6 +76,8 @@ properties:
         # BOE OPTOELECTRONICS TECHNOLOGY 10.1" WXGA TFT LCD panel
       - boe,nv101wxmn51
         # BOE NV133FHM-N61 13.3" FHD (1920x1080) TFT LCD Panel
+      - boe,nv110wtm-n61
+        # BOE NV110WTM-N61 11.0" 2160x1440 TFT LCD Panel
       - boe,nv133fhm-n61
         # BOE NV133FHM-N62 13.3" FHD (1920x1080) TFT LCD Panel
       - boe,nv133fhm-n62
-- 
2.29.1.341.ge80a0c044ae-goog

