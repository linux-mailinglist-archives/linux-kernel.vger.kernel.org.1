Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53529BE98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813638AbgJ0Qws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:52:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40537 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1802500AbgJ0Qqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:46:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id j5so1052441plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1454WDznDDB4HVIvN+ksGK2VxFOSrCXsfMI/gG/Yms=;
        b=oQJPpPIG4EaovjrBVzzsMnpryDFa6cLQiDvG730jBV7G1T19BJIabWlTnnwm6tnxlf
         wxaGcCC/RFSUQWdAUld+hhWK4M4QScQiVorHIHDJvNVBOvfO5Jn2adPf7wHc1Wksr0rC
         c/AFy6YdyjqctKqUGRTUlcZZhfLYWs8p5SQn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1454WDznDDB4HVIvN+ksGK2VxFOSrCXsfMI/gG/Yms=;
        b=j8BVcQMcT2U/RNBhRV0PlQ9FpBqyglI89nDs+SCoMSNlSclZ6nqszUo1lizmLywOHU
         ahYcbv2uEZmUpvZ3QWzR+q5c4+MHJ5siEM+z5KMsgn/o9drz7GuAo/KGoVlf682GYaY3
         K/mLtyF1l74MP118vAYWzyPpCdobxVswAUIQ460KGHFM6AvALJZLFljM+9jUJcNCJL53
         QAtJLbcXZWaAp96hGutg13y9fpI6EnCLoeB15gDiQNo4T+2zXhcW60bENFu0VtzEyn2E
         m4/vlBkCx47UXCbhHZDQ2vwFtcLQw/MvxPU9PbHekygx+qHvIwel4unnPzQcu6ycJrty
         4psA==
X-Gm-Message-State: AOAM532p6b1mhU3XUGLjcG4N6fqqxEQ+PouLE0yJsPYY744UQQ0SfEkR
        QXuGkKU6QgjuAlNa3hUV39bjUg==
X-Google-Smtp-Source: ABdhPJyTpzBwPzGSyUpO+81xeAo7gZN3jmfx8jUfWWRehiMcepTWOtraQ9wfdIcT5SHgrA95ky7pUA==
X-Received: by 2002:a17:902:8545:b029:d5:dbd4:4ab5 with SMTP id d5-20020a1709028545b02900d5dbd44ab5mr3459355plo.31.1603817191235;
        Tue, 27 Oct 2020 09:46:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id c12sm3002688pgi.14.2020.10.27.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:46:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, robdclark@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: dt-bindings: display: simple: Add BOE NV110WTM-N61
Date:   Tue, 27 Oct 2020 09:45:56 -0700
Message-Id: <20201027094553.3.I28d9e32b3cc0aae980ecc39d364263a3f9871298@changeid>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027094553.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
References: <20201027094553.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yet another eDP panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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
2.29.0.rc2.309.g374f81d7ae-goog

