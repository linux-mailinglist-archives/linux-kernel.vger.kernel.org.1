Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C522E2F35
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgLZVi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZViX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:38:23 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15201C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:37:43 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w12so6396896ilm.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKCfsVGa3InM/ueidbaTHb3IhiqFNjw9eRGba4OKyqE=;
        b=jnaYYcyV6rMMpn6Z7pMxzaSc62h0MO67PatEmPkDJLCA4occu9Weo7eJOOkZNFPmdY
         XUzcpTyNgaEm9qLxw8tHHTrHMNYI7Qriw4+480dBTRnvwrJF7P2TDcjZDd2yuy/mL87G
         +RfKwMGziXKSyTMDOHJ8nV8XDMwW6ucW9UUsuFCtpPll9Q4v+hsccZUVMNxtEGMKLx8Y
         A4hRJBQ5hJaqBaG8XwYQOsFmmgdfSgZ3rfGzbOelMUWdvQTeXwyan4He9GaEbMaWmIKT
         XM+iJMF9r0n0FYhQjiVYPDwhe8GG8qR2O8NBJSkgRF7K3eJ8y6Ithtk+npwLt8G5CLba
         RmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKCfsVGa3InM/ueidbaTHb3IhiqFNjw9eRGba4OKyqE=;
        b=jG2Tlrn5N4F0RbtJoME/zEqFflrQjC3iaoRHmfvQas+ZF1s+PvvQiDMBSC5PQ9QrJt
         LxRpdfpI7YBca3+vVunTMh4gINPmI6s70A+HYUD29OCUnlTwLXgiXHVHHuQofhHtZmj6
         zfghhw1AY11DkCgD/IFsW5WqLIldo/K0V6rqhRAo4ypbyIivvwpFEObQI1cXpAThaI0/
         bOLX6LHIyPdrajLGafSzMV9DdBLjfbwGeJ8mstNZczQcXxBVfAvX+RQDFWhGzHG4w+Mi
         a37j3/f565ZRbQMnbiNLJMJaTPBBx9Jck/un6JVO8tFgYM/AFNgf4OyESSeuITtAZED8
         pX4Q==
X-Gm-Message-State: AOAM53195ER0UwptWR04DzYY6Hf9+izFbj+Y28SrkCZ/XoTCj5cQI2Qo
        f60BiLjpRtNRkJ3vQDCm7VwbHg==
X-Google-Smtp-Source: ABdhPJyHdT5P1KFc+TL5fuJKr9QwoYNjJRND3Figj9Xz1FEnLfu3AAvID4RVB7m237rCXP1a+txESQ==
X-Received: by 2002:a05:6e02:e44:: with SMTP id l4mr38824035ilk.208.1609018662467;
        Sat, 26 Dec 2020 13:37:42 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u8sm30582763iom.22.2020.12.26.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 13:37:41 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH net 1/2] net: ipa: don't return a value from gsi_channel_command()
Date:   Sat, 26 Dec 2020 15:37:36 -0600
Message-Id: <20201226213737.338928-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201226213737.338928-1-elder@linaro.org>
References: <20201226213737.338928-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of gsi_channel_command() no longer care whether the command
times out, and don't use what gsi_channel_command() returns.  Redefine
that function to have void return type.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 6ffddf3b3d182 ("net: ipa: use state to determine channel command success")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 579cc3e516775..e51a770578990 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -454,7 +454,7 @@ static enum gsi_channel_state gsi_channel_state(struct gsi_channel *channel)
 }
 
 /* Issue a channel command and wait for it to complete */
-static int
+static void
 gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode opcode)
 {
 	struct completion *completion = &channel->completion;
@@ -489,12 +489,10 @@ gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode opcode)
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_MSK_OFFSET);
 
 	if (success)
-		return 0;
+		return;
 
 	dev_err(dev, "GSI command %u for channel %u timed out, state %u\n",
 		opcode, channel_id, gsi_channel_state(channel));
-
-	return -ETIMEDOUT;
 }
 
 /* Allocate GSI channel in NOT_ALLOCATED state */
@@ -503,7 +501,6 @@ static int gsi_channel_alloc_command(struct gsi *gsi, u32 channel_id)
 	struct gsi_channel *channel = &gsi->channel[channel_id];
 	struct device *dev = gsi->dev;
 	enum gsi_channel_state state;
-	int ret;
 
 	/* Get initial channel state */
 	state = gsi_channel_state(channel);
@@ -513,7 +510,7 @@ static int gsi_channel_alloc_command(struct gsi *gsi, u32 channel_id)
 		return -EINVAL;
 	}
 
-	ret = gsi_channel_command(channel, GSI_CH_ALLOCATE);
+	gsi_channel_command(channel, GSI_CH_ALLOCATE);
 
 	/* If successful the channel state will have changed */
 	state = gsi_channel_state(channel);
@@ -531,7 +528,6 @@ static int gsi_channel_start_command(struct gsi_channel *channel)
 {
 	struct device *dev = channel->gsi->dev;
 	enum gsi_channel_state state;
-	int ret;
 
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_ALLOCATED &&
@@ -541,7 +537,7 @@ static int gsi_channel_start_command(struct gsi_channel *channel)
 		return -EINVAL;
 	}
 
-	ret = gsi_channel_command(channel, GSI_CH_START);
+	gsi_channel_command(channel, GSI_CH_START);
 
 	/* If successful the channel state will have changed */
 	state = gsi_channel_state(channel);
@@ -559,7 +555,6 @@ static int gsi_channel_stop_command(struct gsi_channel *channel)
 {
 	struct device *dev = channel->gsi->dev;
 	enum gsi_channel_state state;
-	int ret;
 
 	state = gsi_channel_state(channel);
 
@@ -576,7 +571,7 @@ static int gsi_channel_stop_command(struct gsi_channel *channel)
 		return -EINVAL;
 	}
 
-	ret = gsi_channel_command(channel, GSI_CH_STOP);
+	gsi_channel_command(channel, GSI_CH_STOP);
 
 	/* If successful the channel state will have changed */
 	state = gsi_channel_state(channel);
@@ -598,7 +593,6 @@ static void gsi_channel_reset_command(struct gsi_channel *channel)
 {
 	struct device *dev = channel->gsi->dev;
 	enum gsi_channel_state state;
-	int ret;
 
 	msleep(1);	/* A short delay is required before a RESET command */
 
@@ -612,7 +606,7 @@ static void gsi_channel_reset_command(struct gsi_channel *channel)
 		return;
 	}
 
-	ret = gsi_channel_command(channel, GSI_CH_RESET);
+	gsi_channel_command(channel, GSI_CH_RESET);
 
 	/* If successful the channel state will have changed */
 	state = gsi_channel_state(channel);
@@ -627,7 +621,6 @@ static void gsi_channel_de_alloc_command(struct gsi *gsi, u32 channel_id)
 	struct gsi_channel *channel = &gsi->channel[channel_id];
 	struct device *dev = gsi->dev;
 	enum gsi_channel_state state;
-	int ret;
 
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_ALLOCATED) {
@@ -636,7 +629,7 @@ static void gsi_channel_de_alloc_command(struct gsi *gsi, u32 channel_id)
 		return;
 	}
 
-	ret = gsi_channel_command(channel, GSI_CH_DE_ALLOC);
+	gsi_channel_command(channel, GSI_CH_DE_ALLOC);
 
 	/* If successful the channel state will have changed */
 	state = gsi_channel_state(channel);
-- 
2.27.0

