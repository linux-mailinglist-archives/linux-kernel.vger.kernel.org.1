Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B662B0D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKLTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgKLTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:08 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F1DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:08 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so7119763wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kn9g1kMG5JlU7ctdIXE2LbkwCeCLbWZDScIEWNzvtKI=;
        b=LW3L37TwALnk4Q2xAPgEMzfzdr9zoa+spFmcHccQPbuhCyr3wHoD9YOlFlgX+pwBlq
         zqmKPE0BGKQsYMGsz0hzah+uMSULv+3zZt050EZH+He85XYyfbQbsHB4IHGeHUINSDHO
         7A+WAD3QCV6qvf0ix7jhR0+05n8cQYNx8iQx/aTB1liHFtvjGBJxfS9/GwD4HphiSkMY
         pLEEMq4AAv0ASpigUk1pEOCF28p/s1xmpNClKI2Vrpu0YrQuMN8akO1yxONVW6yL9cja
         XhIaSQvd0CYJk3NXYpq1viX+Yy2ayRVZ7lNdPpSeiQr5YO9EFVKrHYN+A5s1NfQuE4nx
         wzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kn9g1kMG5JlU7ctdIXE2LbkwCeCLbWZDScIEWNzvtKI=;
        b=hEAEtFdcum+UDnyyuwo94QYs0X6Z+sB8dOPCaXo7mAuBMmrbRZRMXa2t6sI/cvHnzD
         H/2yMQftNotrmrsnsxWZj4W3qWAfA+zlDTxycm5cPHKvp7iQ9SvizGMrvmXI1MY8g6+m
         c2Gzax7dASMZbCZttYOyRIfyhV03uP/km9ZUFvxw6hz49Fk7j0JaE8Gp9EEXFSIsAsFa
         uZ6TY6++zEbSVxGRYf0mL6flRTkqUNxRLS0wWX1mNbaiwN3GgY4qwUbOIzpi1LR5Ltgs
         J0ejBboc5a4ic1jbbz8DDUkcwhUp+8W9s7ZtIiaE7f5JxFfMBg/8hP2HSeAzkuD5BxlA
         +0Pg==
X-Gm-Message-State: AOAM530L6nuVfBkNemhehQMFiJmfg4SFseuAatAQzbHuUx/K5FSMpp5E
        1QWGluUvnLK3+myyuy/S4eR1sw==
X-Google-Smtp-Source: ABdhPJz24AiC3oFR5b0ByLxHCL2PfXIsq4dpRc1qmLG97PHeh7my9FDsIQnfL+CA3CUQyuEg5yYupw==
X-Received: by 2002:a5d:4690:: with SMTP id u16mr1106632wrq.263.1605207667284;
        Thu, 12 Nov 2020 11:01:07 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/30] drm/vc4/vc4_hdmi: Remove set but unused variable 'ret'
Date:   Thu, 12 Nov 2020 19:00:20 +0000
Message-Id: <20201112190039.2785914-12-lee.jones@linaro.org>
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

