Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5952B9DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgKSWti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgKSWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:49:38 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:49:36 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id o11so7904219ioo.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgeSJpT+2VpJ8nnnk4D+8w/nk3Hu1aQYbqU02TDgkZI=;
        b=uOyYzUjr1NFc3RYfmSjmJem7iZM/CUh42JLbEsj5dyUVGdbopYnTcZZmMxf9sXYx7K
         pCy9IiFlVfz9IKcrvVHb+JS0W1XxF5Rn2TukFr9TO2Hn7L5EyHFH47IrgeZ8EaV4ax/r
         rl+Jg7jF5MkDSOpLgangkdAAfD7+h0oLmKxkVORFY+xVR7mK3/cD4rIvLtyEs1woSXLB
         Wn3cVYRENaX++GLOT7AgZI01x+BNB9BXJ7sBEVRJt9i3Hf4s5EBIcilUiUBCAXMEOyFV
         KaPR1x0X7CoLoNSnoiL/WvbGuoQiKQlZfd8XreQKfkptALwuPmVJ7jbQHDpVuoBcM58i
         +QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgeSJpT+2VpJ8nnnk4D+8w/nk3Hu1aQYbqU02TDgkZI=;
        b=bpyNgo5UcCx/0+Y2JIFeEFZ7MvcHKL+mh+lI1Gfwz5+In9idP3GRap7r1ihmcXn1hx
         cjDSr6z/iUsrL6ItpyAzjjT27IowRJG3K8poQHiz5zGO5I2GcTMlXkP7UWnNxg1/9D+r
         Sffgi796tpJ40t1aoCT0ssZrb0k3r43lc5LMAqBAQgDOfpZIciccJo/X2QQNwv/rXjJS
         zh/fUgbWOtw5eC66Es6Jb4a9fpicU5o49QgRGe18rPSGHRJwmj5+ek13Vl5JGJB+h+qs
         3RluUZwyMGNsPFwV5G94Y+QbN6fhAxp9ESHxnVAh7WJL9cr+NR5jkABY3F7VENt8BhBw
         IRVw==
X-Gm-Message-State: AOAM530X+F0y0Qg5xoaDucElkAt04HGPrlzKpFph7ZtAUQfMdrRjjIg6
        Dgb3RVKCAxFjK+c7I9lRE7Zy/w==
X-Google-Smtp-Source: ABdhPJxqMRKJE7HEJ5Va7ap17EWSY6IFGKdgetxCqI+JYMxPNcmOhtGB0p2M213fTuYBR1cBrUst1w==
X-Received: by 2002:a6b:148e:: with SMTP id 136mr23554982iou.60.1605826175894;
        Thu, 19 Nov 2020 14:49:35 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i3sm446532iom.8.2020.11.19.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 14:49:35 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ipa: don't reset an ALLOCATED channel
Date:   Thu, 19 Nov 2020 16:49:25 -0600
Message-Id: <20201119224929.23819-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119224929.23819-1-elder@linaro.org>
References: <20201119224929.23819-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rmnet_ipa0 network device has not been opened at the time
we remove or shut down the IPA driver, its underlying TX and RX
GSI channels will not have been started, and they will still be
in ALLOCATED state.

The RESET command on a channel is meant to return a channel to
ALLOCATED state after it's been stopped.  But if it was never
started, its state will still be ALLOCATED, the RESET command
is not required.

Quietly skip doing the reset without printing an error message if a
channel is already in ALLOCATED state when we request it be reset.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 2bc513c663396..58bec70db5ab4 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -576,8 +576,10 @@ static void gsi_channel_reset_command(struct gsi_channel *channel)
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_STOPPED &&
 	    state != GSI_CHANNEL_STATE_ERROR) {
-		dev_err(dev, "channel %u bad state %u before reset\n",
-			gsi_channel_id(channel), state);
+		/* No need to reset a channel already in ALLOCATED state */
+		if (state != GSI_CHANNEL_STATE_ALLOCATED)
+			dev_err(dev, "channel %u bad state %u before reset\n",
+				gsi_channel_id(channel), state);
 		return;
 	}
 
-- 
2.20.1

