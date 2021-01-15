Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250502F88BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbhAOWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbhAOWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:45:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D705C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so6947391pgj.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qS78FZ4W8rqLJokNq5ZcTTS18dyO2G9lo8sgbVdLz2w=;
        b=YBoV0cjHnLMdT8Whco1/3fv7OBbHNm2k319MX/R0wLJYhD6YFdhLQsB5q+WF7XBDXm
         hRpxkUOt7zqvot1S5epP5UBkcggBnmlR9sN3rudAptlzzphIIuA5m0rOrE7BmI2bsSWd
         c54c8vQ6mXLKQ73Ela+dyd8ne2TvUqkDhwPjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS78FZ4W8rqLJokNq5ZcTTS18dyO2G9lo8sgbVdLz2w=;
        b=Yt5X90yeqiyZTljSMkgVyDaJF6Arn01347s4LZRPl6EwsmdNw4XJpo3xn9L8gqUIXl
         lKR2XMjPR4IY5vvUnqOPpYVUGrG58tkQ8cOym5ifFTf5l3l6ohtkunOG6OUJY2sQ5hsW
         +nmStmIgUGXZhB+DAjiRHs4EQO2paBabNJhp5XNbI/Sdhkdhzeh+KCwiv80audSJv91j
         LOcHft4fdGl1M2xDnUzRl9SopC9W9fY730n8SwuUxgI4lwi2Kj5OnEAwBnk6cj8SQHac
         UgO1HUYG+Kn+8kZ/lUbvBsIeeFxEcma7PoKHOgHjN0Mayv+MO3+rIMTYDtnvlrc+8jRA
         Y4GQ==
X-Gm-Message-State: AOAM532cTnWUgFJrBsBLMCxXYBUjOJKc/r8QE+Ktltb4lDK0/7ZuAbPh
        skrpRw96fACssMBGu3HQOtYltg==
X-Google-Smtp-Source: ABdhPJxz7VaGdPquJIeid3tc9J3bmDjLmTag/CY/rmobwMCbN3MNqeLjfBLTBQKNukUJtNI3d/d02Q==
X-Received: by 2002:a63:d446:: with SMTP id i6mr15023966pgj.446.1610750693977;
        Fri, 15 Jan 2021 14:44:53 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q16sm9131100pfg.139.2021.01.15.14.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:53 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] drm/panel-simple: Add N116BCA-EA1
Date:   Fri, 15 Jan 2021 14:44:20 -0800
Message-Id: <20210115144345.v2.5.I3c01f3aab8335cb509da7009d8938c1a27a266dc@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
References: <20210115224420.1635017-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel is quite similar to the similarly named N116BGE panel (the
nominal timings are, in fact identical).  However, let's add a new
entry because the full range of clocks listed for N116BGE aren't
supported for N116BCA-EA1, at least according to the datasheet.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("drm/panel-simple: Add N116BCA-EA1") new for v2.

 drivers/gpu/drm/panel/panel-simple.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 823177d89d1b..76a1bebaaaf9 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2407,6 +2407,36 @@ static const struct panel_desc innolux_g121x1_l03 = {
 	},
 };
 
+static const struct drm_display_mode innolux_n116bca_ea1_mode = {
+	.clock = 76420,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 136,
+	.hsync_end = 1366 + 136 + 30,
+	.htotal = 1366 + 136 + 30 + 60,
+	.vdisplay = 768,
+	.vsync_start = 768 + 8,
+	.vsync_end = 768 + 8 + 12,
+	.vtotal = 768 + 8 + 12 + 12,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc innolux_n116bca_ea1 = {
+	.modes = &innolux_n116bca_ea1_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 256,
+		.height = 144,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+		.prepare_to_enable = 80,
+		.unprepare = 500,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 /*
  * Datasheet specifies that at 60 Hz refresh rate:
  * - total horizontal time: { 1506, 1592, 1716 }
@@ -4320,6 +4350,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,g121x1-l03",
 		.data = &innolux_g121x1_l03,
+	}, {
+		.compatible = "innolux,n116bca-ea1",
+		.data = &innolux_n116bca_ea1,
 	}, {
 		.compatible = "innolux,n116bge",
 		.data = &innolux_n116bge,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

