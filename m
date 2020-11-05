Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A872A8957
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgKEV6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEV6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:58:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7BC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:58:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so2314819pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9M3puV2O+f9OQuFbTUvfKRPi3QbkyCpFGgLmOhG8TIo=;
        b=mAvTnRbni1OBh9wjhdQOvX3RdLhypGfZ6OC8ix0pN2QH21/iw1GcshCJpYtABCfI1K
         mi5h1Xj2OqtfyLfrksXFLPRGz17c8htW7pokNCL0ckwZoj0SZNVpbP/NM3apSSwRIbd2
         jB4umcALDkn5sZkX36l7yn9NTWVTSnsVl/swY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9M3puV2O+f9OQuFbTUvfKRPi3QbkyCpFGgLmOhG8TIo=;
        b=b3y/F7CXQ+F8BQdzc4Q87qqp18dRNSnCzwsyCHgUM+kQmBHJ3xDDMDW3RSwUdMJSHn
         zj5Tf9n8g/OH15SRTI8A/C84nQkhgcqc+foqhJEw4mZaqLvvHBpKJPavoJTOH2GxtqJe
         9kqwgA7R5Uw+CbiTEXCp45/Ov70pozBgM/rgca/rqUunSYhudP2rWxI4Pvhz9qNfH1qC
         M4M2sNo8lx8PEGlAsVh2pRT3MEuy5sbZwXntX/kyUhyYwAS/jupp27NAgbCnseqopoza
         0UHfBtgH00AB1F4b3jYOjvSvNY6DBegf/b7pB+Ag+LKuzVaarfwr0yCmx555pzJ3yf51
         yOkA==
X-Gm-Message-State: AOAM5306MROeppT6Pmq3XliCAY9OXHaaE8n1oYWN1yO+ElgCB5xKt3De
        Y/IjklHFLi9XmTyE09HTQaPJdA==
X-Google-Smtp-Source: ABdhPJwypK1CAJ3uQ/QhZXmgYYJxHRTaUbSpdjDwluRHgFYuEhFuwB/HE75SHdb/1ua7ZJgVVkC+Dw==
X-Received: by 2002:aa7:9af1:0:b029:152:6101:ad12 with SMTP id y17-20020aa79af10000b02901526101ad12mr4297747pfp.40.1604613484905;
        Thu, 05 Nov 2020 13:58:04 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id k7sm3572890pfa.184.2020.11.05.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:58:04 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>, robdclark@chromium.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm: panel: simple: Add BOE NV110WTM-N61
Date:   Thu,  5 Nov 2020 13:57:40 -0800
Message-Id: <20201105135639.v3.2.I71b2118dfc00fd7b43b02d28e7b890081c2acfa2@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105135639.v3.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
References: <20201105135639.v3.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
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

(no changes since v2)

Changes in v2:
- Adjust for shorter names in patch #1.

 drivers/gpu/drm/panel/panel-simple.c | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index bb1e3d15f793..db3f0e2b6001 100644
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

