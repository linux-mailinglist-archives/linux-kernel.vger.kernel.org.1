Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545F129D9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgJ1XAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389911AbgJ1W6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:58:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:58:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id r10so371642plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHzSigbV/JOyfbEwYkWBCndr5m2zp1xIjqS7IrkBvzA=;
        b=GpTrl91L3KD7Gr90gj8a7l0rvJe1X2jHQtuCFQLfsw22xq4Agzn7dK/J9hXGR/5w3v
         I/MSIETrvTEM/q209qUCvzj7mNK+4XlEqHQBnZoEmyZKnC2RP9toT2wCw7Z6jT11tYy1
         chNcVb3UKPF4au50BKJ7FiElgJuSMzrSaG6vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHzSigbV/JOyfbEwYkWBCndr5m2zp1xIjqS7IrkBvzA=;
        b=IpCvFChsDgwSnBCU2Gpkigmu2BlzVD+hnOCmL2O6QgL8WElILqVZKUuJk3A9C7fxeu
         BpHr4E7bWs8VOO7Qo0aMElnwd7vnjs7LJE6d7oUKQbQnY3p65oyroO5Ji9qp4u7l9yeY
         irV6IE7mx8ZzI00uV3zvocm2viftw3JIGNMqbEil1ljBVcwFnW0urtEp5SG1DY3TCNtE
         ZlA+PwJF0RAP6sqVGwG6O5Szhh2uiJtypU9yk3KH0Odee/lxpWeZysgHxUGXE0izpw5M
         jaLuTaJXrBLMDk5MhVv1u3UE7QyM1a4OPJf0KPa48eaAQOxtlX05Bn2KbPajWt8+B26o
         PrXg==
X-Gm-Message-State: AOAM5324YE1FBc7b2HrRGOmw+RZnnO98VwBuCuo3/S4Gl6n45ufkc9fD
        NdFmpn6CP3romOqDBh+irXonGg==
X-Google-Smtp-Source: ABdhPJxbrjrClcGm6KxlSxyjy6eM4uVyOkacCXkN7gEI6nLyjMmuprf+Mw+5/soBo1oXHAou/yYg2Q==
X-Received: by 2002:a17:902:8a97:b029:d4:d3f4:d209 with SMTP id p23-20020a1709028a97b02900d4d3f4d209mr1227225plo.35.1603925910429;
        Wed, 28 Oct 2020 15:58:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id b185sm394364pgc.68.2020.10.28.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:58:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        robdclark@chromium.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: dt-bindings: display: simple: Add BOE NV110WTM-N61
Date:   Wed, 28 Oct 2020 15:58:03 -0700
Message-Id: <20201028155617.v2.3.I28d9e32b3cc0aae980ecc39d364263a3f9871298@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
References: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yet another eDP panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
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

