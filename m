Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04926A4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIOMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:19:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1825C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a9so3247001wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/f+R+j91elfFPYf4zfHO7Bzdv43BgZ5CODvbZ0Vzlb0=;
        b=ALUSvXEave0lkRZzUeEbGO8h2GDfO0EU1AiDTv2SiPlJ4oOGdkbhRYuv9hFUcMyGSO
         alirB7AKsTW6bTsLpcZ92Ic+b9IriMXONlINaxSKzFIhfodhg/IoZo/6QshxxDEFPQF9
         +z0PYAL6PDisRD661B16WsycbbcZ61BeLzcMHp1/DvhmU7DKPBTRMHjtHkMn5RmafR2Q
         s70bVvvdGwrgVsJxh0OiBJnXJwxMlOn6mg4OI+PW/l4Ap6wUcG33kZiGkZP+yBlpHoqh
         dmfDxhWB79y7cZntYKBsS+i/WkkYB0rizS9oBJEauiIWy4wyfvIo6eZjTzxlPGxabafg
         ikHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/f+R+j91elfFPYf4zfHO7Bzdv43BgZ5CODvbZ0Vzlb0=;
        b=qq1UYS6kJ9uF9DZ+zzPN28bpXTzE5x2HU85WSPIGFL9WpUBHPKHjbWMR2iYzy7TE+O
         zY+c950oihsvAVjQlEJt8AwRMfHBCjN/6GZRCH7lwN4BnnVJrVlQBrSJqPyeOCnEkVkd
         V6Xy/1Kv2kGZTw+Sg0IimvQNWd1Ml0CmUr2P7fw1tzVT3i+ltFaANbNlmbA5GAWoMC59
         PRwRYD2WzINpULPTfK/ve9lZ1Uvny/35V1twP04VHkHYiMFL5vgzzpyIzipkhNvtyL4r
         QSNk5dH3oJSFZDx8eFLlBbGi0QPvkFyx6x+xcLQfrFCwzGOEjICf/Ifk5IdZym0kx02C
         dFhA==
X-Gm-Message-State: AOAM531AnDrdi3ppW7MlDRLDPqdSqzjxQBgSmvcAH8FfyINBNLMusbk1
        KP7kA1V08U/I1CybQ5wDPKJdjg==
X-Google-Smtp-Source: ABdhPJyu3ypcdWMW/OyELVvdkIVANM6RtWY9v4+qY/DqA8slXt9wOmWk6s4o4g2lz7Q0ucEvuSK83Q==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr4634653wmb.155.1600172359411;
        Tue, 15 Sep 2020 05:19:19 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 2sm18271411wmf.25.2020.09.15.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:19:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 2/4] dt-bindings: display: panel-simple-dsi: add optional reset gpio
Date:   Tue, 15 Sep 2020 14:19:10 +0200
Message-Id: <20200915121912.4347-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915121912.4347-1-narmstrong@baylibre.com>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple DSI panels can also have a reset GPIO signal in addition/instead of an
enable GPIO signal.

This adds an optional reset-gpios property.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index c0dd9fa29f1d..4d08e746cb21 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -54,6 +54,7 @@ properties:
 
   backlight: true
   enable-gpios: true
+  reset-gpios: true
   port: true
   power-supply: true
 
-- 
2.22.0

