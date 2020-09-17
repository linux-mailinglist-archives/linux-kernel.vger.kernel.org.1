Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB626E910
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgIQWo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:44:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:44:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so3405824pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emK8TCQ/AOCbQCaTZuyx4EX1GGlS5xLteCwUhZhZWKs=;
        b=asVwRODTCKzTMhPdETpQLiZroP91Get/mIBjAac5bezdK+pOzFI4MJpd0T9o9DUYWW
         Jrgc59dc5QywWAx0/rRfNXXzIp+8G6594T6t/N1pVZVe2h3Q97pV/5VPO3dLx5rXGWbS
         OUXTBUjCBjdKZPF75UxabZQM0laVCy2zi9SYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emK8TCQ/AOCbQCaTZuyx4EX1GGlS5xLteCwUhZhZWKs=;
        b=ANEAe4ptdrvOQ9s7gsGsHmpYMdEck9Qf5Fqfn5D5v8RfyNqHhla3neC73IqtWmSf0m
         zetm9xfoVy8ukc4Pw9k6oM786kq+7iMeeBeEg5yW1QU6wz066eF187HMU8eto6W0dqDd
         CbwQog3WCwmVbawWY+EFaeJuKBRLSdqAumYtue8bWxm7huQKpXGzJNUG38Lgi/TXs3kC
         z0NZlES6l9aodeTH86TX2fVk7SdDpsZxoKHRYzSE7nZlOQYVcIvNZwagykDhWReEUuah
         QDgKR9oFYOJL3NGEaG+ESqBBe7vLfKU7xnminX0LlbtraEmQvLuu6cQRy1iQcM8/q90Z
         ZCpg==
X-Gm-Message-State: AOAM531OOz7CnnSWqrlgqbAT9EuJ7NqjrUFMkIQsufP4+CNUCMeKsZXc
        CQ5k07i/VGh/sAjtSTRmyUyUHVdJB5H99A==
X-Google-Smtp-Source: ABdhPJywypDGBU0fygZ+vRZ0Ah7m+uJXUNioxfPKAcCRYPGZUExxbYZ5CmLJLP3uPld3wN0+0sGN1Q==
X-Received: by 2002:a17:902:8509:b029:d0:cbe1:e746 with SMTP id bj9-20020a1709028509b02900d0cbe1e746mr29812096plb.33.1600382667062;
        Thu, 17 Sep 2020 15:44:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l123sm674509pgl.24.2020.09.17.15.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:44:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Tanmay Shah <tanmay@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] drm/msm/dp: Sleep properly in dp_hpd_handler kthread
Date:   Thu, 17 Sep 2020 15:44:25 -0700
Message-Id: <20200917224425.2331583-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't be waiting for an event here with a timeout of 100ms when
we're not in the 'timeout' arm of the if condition. Instead we should be
sleeping in the interruptible state (S) until something happens and we
need to wakeup. Right now this kthread is running almost all the time
because it sleeps for 100ms, wakes up, sees there's nothing to do, and
then starts the process all over again. Looking at top it shows up in
the D state (uninterruptible) because it uses wait_event_timeout(). FIx
this up.

Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Reported-by: Douglas Anderson <dianders@chromium.org>
Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Based on msm-next-dp of https://gitlab.freedesktop.org/drm/msm.git

 drivers/gpu/drm/msm/dp/dp_display.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 05a97e097edf..e175aa3fd3a9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -970,9 +970,8 @@ static int hpd_event_thread(void *data)
 				(dp_priv->event_pndx == dp_priv->event_gndx),
 						EVENT_TIMEOUT);
 		} else {
-			wait_event_timeout(dp_priv->event_q,
-				(dp_priv->event_pndx != dp_priv->event_gndx),
-						EVENT_TIMEOUT);
+			wait_event_interruptible(dp_priv->event_q,
+				(dp_priv->event_pndx != dp_priv->event_gndx));
 		}
 		spin_lock_irqsave(&dp_priv->event_lock, flag);
 		todo = &dp_priv->event_list[dp_priv->event_gndx];

base-commit: 937f941ca06f2f3ab64baebf31be2c16d57ae7b8
-- 
Sent by a computer, using git, on the internet

