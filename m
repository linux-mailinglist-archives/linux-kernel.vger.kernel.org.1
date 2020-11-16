Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA312B4E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbgKPRmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbgKPRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46777C061A04
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so2482611wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kn9g1kMG5JlU7ctdIXE2LbkwCeCLbWZDScIEWNzvtKI=;
        b=TjXthjttEpmJXsxziQtJEgvptDqsm2IsMdlIZDf2ll+O3GDNYuajE0ftV8lFIdMW20
         sb7gHK7eew5HhS2T8VF1svXf4x6DaTH/qnWItZoXjoCQbfK5zbk/wdMR5+HAloUjJrr4
         PHqMKcXYueDMUUWbuzAxxJ/L0bfnO1NIqAxF0fhT/ycL4/BRJ+ckcIHt2ZvXJyKHIYS3
         UD0PCl6u6AP2alOfvZKLw2BGhLfkN/h0hlD5sTYfOvW2+jmz6mlWKhKUmQgmkEaSa8zH
         sXKFSFkB4u6zAygOG9BZ3+S3GBvWQpluxgeoZarTXAQ9g+epMBQDJWftsEQT7/DT/yAE
         Eicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kn9g1kMG5JlU7ctdIXE2LbkwCeCLbWZDScIEWNzvtKI=;
        b=lJFDj9UL/BkIV1Uqj0CzCJk0n+uukRfJ+7MHqkNHMgS+ZlqVSjtxt0zBwkCVOtnYkT
         zKN97EyhMfc/8ZaUFhIHfNK210L88jn/Y4MRqHTC/IX27Ew3u3UTjai9CtSNKWgfCN4/
         f7KHk/0SOgwKD+93Oyl/qi6Gaqy9ZIgrbZFc14ZH0jDGFTqowzyYd0kwcUdA+LN6RkzF
         yB/lsr6bxa2zLy+eGBvKkjeSeOPDK9FZvjHig78lAjxPDnj7hHEiC9OWVKNDRwN0I5Ir
         rz/Z+Yo4bhDYwg772w4MkanYkDUht4AH6yHoa3OslCqDOG5pwUbVmR1RsgKUXRhrqapu
         ZZkA==
X-Gm-Message-State: AOAM533vWIx8dE7HUxHByC0y6qENXkEMDPAP1U2um8rGQ+nbOtWUTcMb
        TNrkdKIZphaJ8SyQeefVOv97ag==
X-Google-Smtp-Source: ABdhPJyAXVf2/cgIvwC56rcD5A8G4Ad6Kn2UAK55+eDnXsJvtjSRnX56sS6h1gKA2V+1GziFtMfVWw==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr20913528wrq.70.1605548534067;
        Mon, 16 Nov 2020 09:42:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 38/42] drm/vc4/vc4_hdmi: Remove set but unused variable 'ret'
Date:   Mon, 16 Nov 2020 17:41:08 +0000
Message-Id: <20201116174112.1833368-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_set_audio_infoframe’:
 drivers/gpu/drm/vc4/vc4_hdmi.c:334:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Eric Anholt <eric@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 95779d50cca0b..b80eb9d3d9d5a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -331,9 +331,8 @@ static void vc4_hdmi_set_audio_infoframe(struct drm_encoder *encoder)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	union hdmi_infoframe frame;
-	int ret;
 
-	ret = hdmi_audio_infoframe_init(&frame.audio);
+	hdmi_audio_infoframe_init(&frame.audio);
 
 	frame.audio.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
 	frame.audio.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
-- 
2.25.1

