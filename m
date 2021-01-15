Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C832F88B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbhAOWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbhAOWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:45:33 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5301C061799
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:52 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x126so6395817pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEhRjbUNCR1Hk02j8Xf/vg8e/9gEkRjaydiv70kLOXo=;
        b=WtVSiq1xRJf/azOoRgkZu0P+6BgKHV3frEFxWd4je9YJyusVNv13pnUz3hhXDuRGJn
         /SRt98VRKQnSIBPJO4m7J26UDOsfyCfmsfaLC8NaC4j1M7BpDB3SnUdg8s2+Kz970sAn
         qSdjRtw4AvTloiTj1OmxODP7o3c3wmo9xiug8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEhRjbUNCR1Hk02j8Xf/vg8e/9gEkRjaydiv70kLOXo=;
        b=Ki7gb5cblwuelXRZ9n75UdpG1jS+ZSykgk3u6DtxF7dKjivRvsk+q8cZlJnWuEVzOe
         R+xEPQ0oh52n4OvtwyliGcIoKGleP9pA1jM+uSD07PFwwgAc2T5ZVBKz5wuKcIwQR9JE
         ttkUlxw6wuk0+/MA9T4djRFOu/V3/LzTU0tY2h9JBrXIyD9SruZMvP4S6h603qqd1aWd
         2a/jC0ZnRDXXzmNVGdN6BYm6DSxuigSyNIeFy81N8NI99F4ThrwismQ/gMiZtjYUHIN1
         zf7K8lM2/WoSigHSSwJdfiBOA6DnWTjaXnI3AA0uorGDjLu1PEGRXTpQt7teYLFD+28M
         F1uA==
X-Gm-Message-State: AOAM533wE00buIbBrdlwXdc6M+SXFtqOaAUbNpeH0c8vsVuJmPMQGRhV
        8dCUpmqj7n/vuntbhGDjUrM5lQ==
X-Google-Smtp-Source: ABdhPJyKVdXbmgrldR0ZGLdeKMcYo4sYZP34Sje2L0pdmwZnmj3LCoFn7nX19ZSe2u2WkkD81f2X9A==
X-Received: by 2002:a63:9811:: with SMTP id q17mr15175105pgd.238.1610750692473;
        Fri, 15 Jan 2021 14:44:52 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q16sm9131100pfg.139.2021.01.15.14.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:52 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1
Date:   Fri, 15 Jan 2021 14:44:19 -0800
Message-Id: <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
References: <20210115224420.1635017-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another simple eDP panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1") new for v2.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 35b42ee4ed1d..a2db2a8def15 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -160,6 +160,8 @@ properties:
         # Innolux Corporation 12.1" G121X1-L03 XGA (1024x768) TFT LCD panel
       - innolux,g121x1-l03
         # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
+      - innolux,n116bca-ea1
+        # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
       - innolux,n116bge
         # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel
       - innolux,n125hce-gn1
-- 
2.30.0.284.gd98b1dd5eaa7-goog

