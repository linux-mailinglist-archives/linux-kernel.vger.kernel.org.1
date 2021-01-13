Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A912F4DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbhAMOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbhAMOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r3so2427964wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kBvB4NkQBZ34V2o1ex42K5vSl0rdRhcvGCTff/v+VQ=;
        b=CX3P+S9L4wGYuGSks00quxfFpZEPOVPivW0r/M9EjGfhtOTkdgaF5aDbimCQt5ON7+
         ArYJ0aOzuZ3UQN/A8k7aMly33N16m2n25UqGKwjTU66wrXGcVp4c5o146iISuqMXolOE
         WHoahwD7dLOGZnK8I/aajIntcVornbKvK8GVcqxWXPCDEJzONy6QEKkTDIVeQ8br91/B
         RLFAOAbBTU2oZTL9ZOn/+bu+v4ss+ptf8QatATZZ/Qx5NWvYLhjlLcrxcQuf9r+tNcWM
         SmKKOt26cZHRlMc5SPNWHLCaCXTz35T5oJO8GK2T9EC+lLSv5P25KG/huKlSGIoTohQG
         tmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kBvB4NkQBZ34V2o1ex42K5vSl0rdRhcvGCTff/v+VQ=;
        b=LPmj1w6eHgJnAiYagD0nEUIWSoxFGhvmZvynfluTNAYQ1GNraeYqqhobGO8YTP/gS5
         tCYL+2YHXsemfbChDwsCIFNq89JEqsPJaAWh/e3Y17z0O9pAN8G4U7lMVHNAjNIuZdx6
         yUISah3t2pkad+9UU5KA1vMp06tGARPVcGHHgR8H9NKeKTAS/qXFz/XBKWTOi2Vnvfgg
         jOs28BMKKYpHIp0mYxs5nzAJvYWNLWAoU8dnqpCnF+v6WPhyGKh2W9gCzZiC9JHl70UP
         dpkcsj+3pxQbXaXPnp6oJtEzLeRs/4PMB5pwzpgG9c91eIhPnzuC1wVWsDOcjkWiPnep
         pXJQ==
X-Gm-Message-State: AOAM5315URzbyoo3DdgWQlNbo8m52JVaVkzDi3rZj+dlCunlc+6RmHKF
        d0/y3ACJrOYAG2Kgp14NQhAV2w==
X-Google-Smtp-Source: ABdhPJw1ufVOnrS2JPmqkNrZy8h6u74DEt1BTq/yWKFBkHEkejsbQDOSJfyqheFLrclUErFWt5afkg==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr3189875wro.244.1610549455814;
        Wed, 13 Jan 2021 06:50:55 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Ben Dooks <ben@simtec.co.uk>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/31] video: fbdev: s3c-fb: Remove unused variable 'var' from 's3c_fb_probe_win()'
Date:   Wed, 13 Jan 2021 14:50:08 +0000
Message-Id: <20210113145009.1272040-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_probe_win’:
 drivers/video/fbdev/s3c-fb.c:1176:28: warning: variable ‘var’ set but not used [-Wunused-but-set-variable]

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/s3c-fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index d33d7df77a6a5..91daeca5ca392 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1173,7 +1173,6 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 			    struct s3c_fb_win_variant *variant,
 			    struct s3c_fb_win **res)
 {
-	struct fb_var_screeninfo *var;
 	struct fb_videomode initmode;
 	struct s3c_fb_pd_win *windata;
 	struct s3c_fb_win *win;
@@ -1201,7 +1200,6 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 
 	win = fbinfo->par;
 	*res = win;
-	var = &fbinfo->var;
 	win->variant = *variant;
 	win->fbinfo = fbinfo;
 	win->parent = sfb;
-- 
2.25.1

