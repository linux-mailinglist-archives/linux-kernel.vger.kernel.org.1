Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96A2E7A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgL3PSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3PSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:18:05 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C5C06179B;
        Wed, 30 Dec 2020 07:17:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw4so22243807ejb.12;
        Wed, 30 Dec 2020 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tN9R7XEuR/MI9VKQRuMKlkJ4/z1wACtnnnmm4C2QvRs=;
        b=U0FYCGHWsbgYU6cVFVNaMtyKIm1tExUy1jpoAGvYcHCBx4bwWJoRjzLDVDm5a8NfzM
         Q4db910XAPgI+b3a89f+Aws1ZyenFv5SVF7B+p9iK6g9hH9LgMqkcFM7YLEYaUX52wNS
         Yq4WRBxUOTxYisGf4gLEPHPMFaVhIpQAuAhrNZgV1Sdt7rPT6VUBCqyuLcGcNPTBpw02
         xDXq/DI/ShXE0YCVksdkrW04bVugJBSgLNzd9O76vYk4OnO9MzCoifKEUB/XcrGdKkbj
         hfQuphlgvHHo0ytc3nUM727aYikz22bWM0ir6xDb/25oZ2esgs5/mkumAF4tcjarYTaf
         IO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tN9R7XEuR/MI9VKQRuMKlkJ4/z1wACtnnnmm4C2QvRs=;
        b=YRj+/rvs9SQkZ5/JKe+0TJmTq+cwX6x9uXv2up21sbChmP/uFgsGuHEDb+tVG5+CB8
         jDISxmL1i3MqDLRGJTSanmxwd9fzBByTp0EJbUdCb95JcKPY49frCOqEE685rvfp827E
         xddMzP5nk8wPkaY0upNIkFx4BRBet8uO4ETX+ijIef5UuMcbBx59XqTyKrvFgA26AZxZ
         R6FPwKYQL0rQ76LzaEv+jG5jT+6nMW9I4zjW8ORi0yTyAe0AgmGsp/majpzsAndaIYiD
         K6YZMMf+o4zVTJj8mNtzTEiP4fEBZAYo4TGz/G+lpzfxyhydlL87lwMJorExStM9SngJ
         iIhw==
X-Gm-Message-State: AOAM5302A+4rnEMYNIYq3HK9B8WEQNxffaCF4jNHddH1mRE9UQqyn+Kp
        VZhvf5QiB/tvhX+iUQ9+WN0=
X-Google-Smtp-Source: ABdhPJy5CVgXNzWxBNFzhz6ipQehWwMHs78M3LRkZeGND5vm1dqJp9fWwUBfN/eHLLSv/BesAzCA3A==
X-Received: by 2002:a17:906:f1cc:: with SMTP id gx12mr47991397ejb.164.1609341443932;
        Wed, 30 Dec 2020 07:17:23 -0800 (PST)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id r24sm38624518edc.21.2020.12.30.07.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 07:17:23 -0800 (PST)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Samuel Pascua <pascua.samuel.14@gmail.com>
Subject: [PATCH 2/2] drm/panel: simple: add samsung,s6e3fa2 panel
Date:   Wed, 30 Dec 2020 17:17:11 +0200
Message-Id: <20201230151711.3619846-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230151711.3619846-1-iskren.chernev@gmail.com>
References: <20201230151711.3619846-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Pascua <pascua.samuel.14@gmail.com>

This panel is used on the Samsung Galaxy S5 (klte).

Signed-off-by: Samuel Pascua <pascua.samuel.14@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 41bbec72b2dad..5f16826f3ae06 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4611,6 +4611,33 @@ static const struct panel_desc_dsi osd101t2045_53ts = {
 	.lanes = 4,
 };

+static const struct drm_display_mode s6e3fa2_mode = {
+	.clock = 149769,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 162,
+	.hsync_end = 1080 + 162 + 10,
+	.htotal = 1080 + 162 + 10 + 36,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 13,
+	.vsync_end = 1920 + 13 + 2,
+	.vtotal = 1920 + 13 + 2 + 3,
+};
+
+static const struct panel_desc_dsi samsung_s6e3fa2 = {
+	.desc = {
+		.modes = &s6e3fa2_mode,
+		.num_modes = 1,
+		.bpc = 8,
+		.size = {
+			.width = 65,
+			.height = 115,
+		},
+	},
+	.flags = MIPI_DSI_MODE_VIDEO_BURST,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+};
+
 static const struct of_device_id dsi_of_match[] = {
 	{
 		.compatible = "auo,b080uan01",
@@ -4633,6 +4660,9 @@ static const struct of_device_id dsi_of_match[] = {
 	}, {
 		.compatible = "osddisplays,osd101t2045-53ts",
 		.data = &osd101t2045_53ts
+	}, {
+		.compatible = "samsung,s6e3fa2",
+		.data = &samsung_s6e3fa2
 	}, {
 		/* sentinel */
 	}
--
2.29.2

