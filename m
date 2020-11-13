Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00B2B1C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKMNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgKMNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE0FC061A4D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:57 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so10000198wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+170YZVUptUVP8b8DCIuLCBL2J9gnyH4hHHhpysSOuQ=;
        b=EQpRZyqJUsVS4E/rFG6b8qdqj3RFz0tJHBcF1joK7ObcVM37yHd54OpRfevso3poBE
         M5OLhmyu7OkAIv70yzV+TJDxDkNXhyMs1fRWneF6elDNWjnWFwBRutoWPDfzP4+tY65O
         WWovQI0//2V8n9+aZMQtFE0vB7R5yzfroi/LJrQkbDRBnFsghAyXlFhrCdxPlz356hrR
         H03q3WVIa+V3oIvCzXAzTSRqtg+E0xP5+tnLloYx4W0w++YwwuUvPr4Nv1qmm0xfb7uq
         dQKrZB3olz26+UKqQXCgWyvbmODltp1tYhJLRMzwEdW731pX63JSgPKBUEXD33pKvqhV
         I3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+170YZVUptUVP8b8DCIuLCBL2J9gnyH4hHHhpysSOuQ=;
        b=VuRfR1GoqDoPviVAlyby3eyMAq8jQk+6Edj6/J9sx5fkOFZY2eme15gW1ffeHRgwKe
         WTkke8RNToR/WodQQqHZIrmRETe8E9IA9MaLVB9fy3ddxYS//MMc192S9wzHoBEcuFNG
         krRsrM9m0sJICIVEBybW0271fB0nbJ4OSKGYr/puvaoNzBljGDbcZOhehUdkavjEJOkq
         aVh0dpxnkvq0MiraJHqOAXfGOT7WKF2e7aWch+2L0I9CamT4SHAtLywL1Qq9BMFb7erk
         kwCQkFDOqOJ0T13wrSttDMxp0pj/hkONCdfY0WtZnUHUk7vQFzRu5p7R2Ija+uz1HdqS
         8ZWw==
X-Gm-Message-State: AOAM532KsVs3fcpQ9ZTrumFQVhVgERkJDnjty9cgdJaYuxZcsnOWQ9Uy
        qsgnEDwkyt+AXOhB1FlpTnPujw==
X-Google-Smtp-Source: ABdhPJz2mDCjShB59VT0qzKRspALhSVwp6JJFpyxkcVROfD061boAy4T4UGLpdh8lzEfDUo50TLgOg==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr3537576wrq.401.1605275396744;
        Fri, 13 Nov 2020 05:49:56 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/40] drm/pl111/pl111_display: Make local function static
Date:   Fri, 13 Nov 2020 13:49:10 +0000
Message-Id: <20201113134938.4004947-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/pl111/pl111_display.c:356:6: warning: no previous prototype for ‘pl111_display_disable’ [-Wmissing-prototypes]

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index b3e8697cafcf1..69c02e7c82b7e 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -353,7 +353,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		drm_crtc_vblank_on(crtc);
 }
 
-void pl111_display_disable(struct drm_simple_display_pipe *pipe)
+static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
-- 
2.25.1

