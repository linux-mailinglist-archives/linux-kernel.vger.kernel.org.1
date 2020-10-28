Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD529D9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbgJ1XAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389909AbgJ1W63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:58:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A993C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:58:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 15so725615pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L14M8gLTS91UQ2xt9BArYr1ZaQb6zJDDTLAvbEG2OWg=;
        b=lxcFSteIPVC/UmFZ3Y+zSinp2gYZkNUFzsVVFjeV/ajvK2lZNbMcoXIcYlwJMkhxgs
         8VB8L/RWDUGWkUdxXtEVK723BEA0Z9Y5611+VJjwhgQyWVhzcFUWt/pfxOUZCvYhE0zN
         mbd5x4O+N0Mi8/bMYpQ33L/93+VlTt+R6ANAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L14M8gLTS91UQ2xt9BArYr1ZaQb6zJDDTLAvbEG2OWg=;
        b=kYLLSf9ht+ra2ZfzWBcFi0631rLORj2DypKClJyTUYvoZ2XQEQdfvtLtb8oFSF55kR
         skTMX2lBreZ7GTFjTPoZf+wGZvEq/jJtvsLUf0v/ueEkXU21dArtI9O/Du4OnZziy9Z1
         qS8vRj0jvkJzTyFnBFSCzbrSNdxXjEhVmddlqYzi1oMmbX+f5xF4ynFZRDhhAWxWiAiG
         p3uLbjto7VvWTLllxnMm7SR+SwVPhlTI+JfTj0e73GkGJzZoIG4AfEA2xNB5qWquWcdG
         KgBF539v/F9ocb1amnJVL9tuCl84LkViIH6lBmYvdfPmuN/aRClGt2lYEv98YgbN4ss9
         z9Vg==
X-Gm-Message-State: AOAM532RQfCcnxH8rtePxy59cW+pQ496WOA1K/0INHp/sP72dqBQfmNo
        o3r13/I3EAk9Wpq7hhrQlEUI3Q==
X-Google-Smtp-Source: ABdhPJzqHZYSsntfD7BMXocOFeXUZaXfE0HotNL58MWaHJrcQ2HJGai40I+Zxum7j/ou0rX2LRgM0w==
X-Received: by 2002:a17:90a:db43:: with SMTP id u3mr1132102pjx.225.1603925909043;
        Wed, 28 Oct 2020 15:58:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id b185sm394364pgc.68.2020.10.28.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:58:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        robdclark@chromium.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm: panel: simple: Add BOE NV110WTM-N61
Date:   Wed, 28 Oct 2020 15:58:02 -0700
Message-Id: <20201028155617.v2.2.I71b2118dfc00fd7b43b02d28e7b890081c2acfa2@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
References: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BOE NV110WTM-N61 panel.  The EDID lists two modes
(one for 60 Hz refresh rate and one for 40 Hz), so we'll list both of
them here.

Note that the panel datasheet requires 80 ms between HPD asserting and
the backlight power being turned on.  We'll use the new timing
constraints structure to do this cleanly.  This assumes that the
backlight will be enabled _after_ the panel enable finishes.  This is
how it works today and seems a sane assumption.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Adjust for shorter names in patch #1.

 drivers/gpu/drm/panel/panel-simple.c | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2613b9434548..aef9f9b00d2b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1401,6 +1401,51 @@ static const struct panel_desc boe_nv101wxmn51 = {
 	},
 };
 
+static const struct drm_display_mode boe_nv110wtm_n61_modes[] = {
+	{
+		.clock = 207800,
+		.hdisplay = 2160,
+		.hsync_start = 2160 + 48,
+		.hsync_end = 2160 + 48 + 32,
+		.htotal = 2160 + 48 + 32 + 100,
+		.vdisplay = 1440,
+		.vsync_start = 1440 + 3,
+		.vsync_end = 1440 + 3 + 6,
+		.vtotal = 1440 + 3 + 6 + 31,
+	},
+	{
+		.clock = 138500,
+		.hdisplay = 2160,
+		.hsync_start = 2160 + 48,
+		.hsync_end = 2160 + 48 + 32,
+		.htotal = 2160 + 48 + 32 + 100,
+		.vdisplay = 1440,
+		.vsync_start = 1440 + 3,
+		.vsync_end = 1440 + 3 + 6,
+		.vtotal = 1440 + 3 + 6 + 31,
+	},
+};
+
+static const struct panel_desc boe_nv110wtm_n61 = {
+	.modes = boe_nv110wtm_n61_modes,
+	.num_modes = ARRAY_SIZE(boe_nv110wtm_n61_modes),
+	.bpc = 8,
+	.size = {
+		.width = 233,
+		.height = 155,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+	},
+	.min_times = {
+		.prepare_to_enable = 80,
+		.unprepare_to_prepare = 500,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DATA_MSB_TO_LSB,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 /* Also used for boe_nv133fhm_n62 */
 static const struct drm_display_mode boe_nv133fhm_n61_modes = {
 	.clock = 147840,
@@ -4063,6 +4108,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
+	}, {
+		.compatible = "boe,nv110wtm-n61",
+		.data = &boe_nv110wtm_n61,
 	}, {
 		.compatible = "boe,nv133fhm-n61",
 		.data = &boe_nv133fhm_n61,
-- 
2.29.1.341.ge80a0c044ae-goog

