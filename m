Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6872CADE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgLAVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgLAVAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:00:08 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B04C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:59:28 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id o7so954617pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xp92MbdfOGxMs34FhXWWhWMRKc9mfpWP3SeaYIWAuM=;
        b=cgNgwFqoY+WBXtcw/+ew5EzVBnDdN6R4Ad53YGqxtRpnzmYTS/jZJN0cC5wbb1OfFp
         C1oVQk708EoNM1af2naJuj4PoE2oUGg7I63e+jBEKvZltn6FvfeHsikNCiLPpkuhjoR9
         BL7mbc3B0S/RQoS/M8t/qDsTgdTIudWtp36GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xp92MbdfOGxMs34FhXWWhWMRKc9mfpWP3SeaYIWAuM=;
        b=JPBybzhn7Y7e+HKsX5ebtSnoWvoTrmtq19ZjBt1GBUQMTJFDrSYwNYxinQtxyQkbdL
         FxD1toM6BOtBaaVjcedRqyxNcMBkfo6K0elIH/N340kFbe9tyoctYIQ40D8O3Ec9bJkt
         wyoq1QUbjRqNsd4DzVw43XoENhIGFFADARtzklfS3Ih/xafZhVzHi5fS3Wb0uCeNH+sc
         7X+axOM68ulrHeMss67Rh4WC+GJAWLU5uHoCoa1cq4V7SQjgR3jQpAk/AlMXLBLMGBlN
         TIcAESKXQjArtGYL6p3vUXJ8vc5xf6AHkaGtukiXV9aLHdZsbzEzrn2n5UPq4HC4hKte
         O6+w==
X-Gm-Message-State: AOAM532+xqDQlDSI3m0EqTDV2YNHy5cWue42RbbEbggKetJWcB21htkV
        +oOd+Qaif5EE7w1h0l0bMBeKug==
X-Google-Smtp-Source: ABdhPJy4Nlx7YUEzxifWv8pAev5FkGJZTqHO15Gj+Zv2RLwtUXlVyBzmWggUAPzozIEFT6nT0/pW2Q==
X-Received: by 2002:a17:902:b498:b029:da:84a7:be94 with SMTP id y24-20020a170902b498b02900da84a7be94mr4661967plr.52.1606856367675;
        Tue, 01 Dec 2020 12:59:27 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m9sm629385pfh.94.2020.12.01.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:59:27 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel: Fully transition panel_desc kerneldoc to inline style
Date:   Tue,  1 Dec 2020 12:59:12 -0800
Message-Id: <20201201125822.1.I3c4191336014bd57364309439e56f600c94bb12b@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 131f909ad55f ("drm: panel: simple: Fixup the struct
panel_desc kernel doc") I transitioned the more deeply nested
kerneldoc comments into the inline style.  Apparently it is desirable
to continue the job and move _everything_ in this struct to inline.
Let's do it.

While doing this, we also add a short summary for the whole struct to
fix a warning when we run with extra warnings, AKA:
  scripts/kernel-doc -v -rst drivers/gpu/drm/panel/panel-simple.c

The warning was:
  drivers/gpu/drm/panel/panel-simple.c:42: warning: missing initial short description on line:
   * struct panel_desc

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---

 drivers/gpu/drm/panel/panel-simple.c | 43 +++++++++++++++++-----------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 216cde33b5c4..33d53abdb1fb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -39,31 +39,36 @@
 #include <drm/drm_panel.h>
 
 /**
- * struct panel_desc
- * @modes: Pointer to array of fixed modes appropriate for this panel.  If
- *         only one mode then this can just be the address of this the mode.
- *         NOTE: cannot be used with "timings" and also if this is specified
- *         then you cannot override the mode in the device tree.
- * @num_modes: Number of elements in modes array.
- * @timings: Pointer to array of display timings.  NOTE: cannot be used with
- *           "modes" and also these will be used to validate a device tree
- *           override if one is present.
- * @num_timings: Number of elements in timings array.
- * @bpc: Bits per color.
- * @size: Structure containing the physical size of this panel.
- * @delay: Structure containing various delay values for this panel.
- * @bus_format: See MEDIA_BUS_FMT_... defines.
- * @bus_flags: See DRM_BUS_FLAG_... defines.
- * @connector_type: LVDS, eDP, DSI, DPI, etc.
+ * struct panel_desc - Describes a simple panel.
  */
 struct panel_desc {
+	/**
+	 * @modes: Pointer to array of fixed modes appropriate for this panel.
+	 *
+	 * If only one mode then this can just be the address of this the mode.
+	 * NOTE: cannot be used with "timings" and also if this is specified
+	 * then you cannot override the mode in the device tree.
+	 */
 	const struct drm_display_mode *modes;
+
+	/** @num_modes: Number of elements in modes array. */
 	unsigned int num_modes;
+
+	/**
+	 * @timings: Pointer to array of display timings
+	 *
+	 * NOTE: cannot be used with "modes" and also these will be used to
+	 * validate a device tree override if one is present.
+	 */
 	const struct display_timing *timings;
+
+	/** @num_timings: Number of elements in timings array. */
 	unsigned int num_timings;
 
+	/** @bpc: Bits per color. */
 	unsigned int bpc;
 
+	/** @size: Structure containing the physical size of this panel. */
 	struct {
 		/**
 		 * @size.width: Width (in mm) of the active display area.
@@ -76,6 +81,7 @@ struct panel_desc {
 		unsigned int height;
 	} size;
 
+	/** @delay: Structure containing various delay values for this panel. */
 	struct {
 		/**
 		 * @delay.prepare: Time for the panel to become ready.
@@ -154,8 +160,13 @@ struct panel_desc {
 		unsigned int unprepare;
 	} delay;
 
+	/** @bus_format: See MEDIA_BUS_FMT_... defines. */
 	u32 bus_format;
+
+	/** @bus_flags: See DRM_BUS_FLAG_... defines. */
 	u32 bus_flags;
+
+	/** @connector_type: LVDS, eDP, DSI, DPI, etc. */
 	int connector_type;
 };
 
-- 
2.29.2.454.gaff20da3a2-goog

