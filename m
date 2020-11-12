Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE02B0D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKLTB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgKLTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE77C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so7157221wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ov+hNhD3SKYkmXLxIt4K88IOrbz9wi3prlF4IGflKIA=;
        b=HaKWon5e27vVoEszYC+8GRccl3aOte+jqCuD5RwYvw6ylRWQd+CrIRkR769NKQET+a
         NL15ssjcWuHmB4bGvwWQE15yhgjPfNjQZJEkpEWKtwO15LmfdpWSGi2jxoGPtRF3onFR
         OMCJcskY6WOsWAC3jLRiORkoCCBrebvUO0iccdgpgchRhmHQTRjFTdj4H/hd/tNKfWw8
         v9VAvpV5PuEmRGo5WNivCmGd2TWHPU1F5F5qdr/ZVVTKGKkszlMWRp6uJ3j6LV5sF6Ce
         Y2J8LeF0SlEfnnzIAYZPMXx8e/WQ7QclnjIFWV37iZJi2NtqT8r2WywT4Wf331WLmZOl
         9r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ov+hNhD3SKYkmXLxIt4K88IOrbz9wi3prlF4IGflKIA=;
        b=YZSbvCz5zbC/ykJpouJnd5CRG/A6yW1XTDP6OzRXE/HPRXrcSxHAT4zC+Ey7vfV+0c
         M5mUBoIJ6usc7vroDd5uw1945tE90dMAj6odvVx5R3nrZRR82N7oPf4PdoDd5l+iAwGw
         Zz2uM6duHY0vCeYJbrctY0h2ojaiPncidF1vLjH8d8SQM4DuTBMDh0/HGK8gYl8wWbIb
         bXmBAqGGv77E/4uDA9bi6fkS23h8Ok07ShDaDj1ErmuVPwT0FpJwmRLQbX+ESNd8/aUD
         MA7iHIlCHz52YVTnJpP8pP2cAoOucEqKVNGuW0MLlwOR1vVjpQ8jcfu9aVU/26VrYIck
         9KZg==
X-Gm-Message-State: AOAM531ANfVRJwDea1dJkHm1jAxCUUJ1dalSJETahTxb/o9f3t5V7ufw
        imYtPEVtl+QWoaktgOBnrsdLRA==
X-Google-Smtp-Source: ABdhPJz6gcI8pqKX92aeK0A2wnxDfVcWz6jrilEoWlaSmQJS1ipaQgmvzbQ4hI9uHgviAXYzqMTaMg==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr1152395wrk.71.1605207706981;
        Thu, 12 Nov 2020 11:01:46 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/30] drm/sti/sti_hdmi: Move 'colorspace_mode_names' array to where its used
Date:   Thu, 12 Nov 2020 19:00:36 +0000
Message-Id: <20201112190039.2785914-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hdmi.h:36:40: warning: ‘colorspace_mode_names’ defined but not used [-Wunused-const-variable=]
 36 | static const struct drm_prop_enum_list colorspace_mode_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 6 ++++++
 drivers/gpu/drm/sti/sti_hdmi.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 38a558768e531..f3ace11209dd7 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -167,6 +167,12 @@ struct sti_hdmi_connector {
 #define to_sti_hdmi_connector(x) \
 	container_of(x, struct sti_hdmi_connector, drm_connector)
 
+static const struct drm_prop_enum_list colorspace_mode_names[] = {
+	{ HDMI_COLORSPACE_RGB, "rgb" },
+	{ HDMI_COLORSPACE_YUV422, "yuv422" },
+	{ HDMI_COLORSPACE_YUV444, "yuv444" },
+};
+
 u32 hdmi_read(struct sti_hdmi *hdmi, int offset)
 {
 	return readl(hdmi->regs + offset);
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
index 1f6dc90b5d83a..05b2f3d0d48d3 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -33,12 +33,6 @@ struct hdmi_audio_params {
 	struct hdmi_audio_infoframe cea;
 };
 
-static const struct drm_prop_enum_list colorspace_mode_names[] = {
-	{ HDMI_COLORSPACE_RGB, "rgb" },
-	{ HDMI_COLORSPACE_YUV422, "yuv422" },
-	{ HDMI_COLORSPACE_YUV444, "yuv444" },
-};
-
 #define DEFAULT_COLORSPACE_MODE HDMI_COLORSPACE_RGB
 
 /**
-- 
2.25.1

