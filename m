Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF22B2EE7C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhAGVom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:44:41 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDBC0612FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:43:32 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z5so7599399iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9HgxlCMRBRvY3EtPBfpOoI3TYfy8ZVEt5J8BdfVXKI=;
        b=x5i3A8tfaLHchgjQEBdoO1VwSLM5+0GIPP0995ZsTGKIAI8HIpN+xsT6mgVuKrZenV
         9IB2rSFQyxFuVMJG6wV5NsL1AmLa8521N51CgHMxp1fqaDfyXjZaRbq1gWGoIuZmQlMr
         dBS2A2zpsuPws1Ww9igyXEm1wSqZNjXu/6ovDA9r8ypbfv20E/KYns6XzDx5qVBo/WSU
         UgXIqivDZsgQBZvuqISF69y3McqXzBdFXkc4CEaz2FubZtWpV5dXm+AiV9XM6DSaBv3Z
         LGe1CAfXsovD4ND0sp971bMb6tY2j6NZuB0uCs4LU+0v5VPYiVj2uqW39r632w2+04Jc
         hmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9HgxlCMRBRvY3EtPBfpOoI3TYfy8ZVEt5J8BdfVXKI=;
        b=bDHEQrePFIf0miHL3eYIIKp2xKR0ozrTQ0sj1YfOJui4TXO/N0ZR5pzdD6EeMz0hbo
         b8gmWOlnXZIWFYdtW+UmAqZ9eYzA/VGlbkZbLg445ZELqQtCfygP/EqWqvZFJh57K/y3
         e2q1yEKb5M72jAIpt7DQR7kMcXuOs5sm0yzqd9wabaJNqMyFU9fuUUm3HlW6qmFYgQrs
         aBWev3wu2dnpkyA5nGpzrbeN7vqAlMSnXyT4iScBNGHize13mzIJ7OYz/6wL34GQ56DP
         9rTkp6N2pn5+vdj5QFij79VPtMc+uYTpvXSNP6Y2DCLnpDWCbT/iwZmlSj28rIvEv+eR
         25aw==
X-Gm-Message-State: AOAM533fv7kb++gGoHelNjRHxrYdUy/qUESSSQaMWmscRLuUTJLbiVsV
        58xm6B9SvpaldJEHfRYDAchoTA==
X-Google-Smtp-Source: ABdhPJx14y6fk8GpEtaJa5MTqI3izUEBNYmTK2saNni0apMvWFsrLJTy9oqMQ5zhcFtOHz8eMufrNw==
X-Received: by 2002:a5d:84cf:: with SMTP id z15mr2896543ior.81.1610055811515;
        Thu, 07 Jan 2021 13:43:31 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f10sm5218260ilq.64.2021.01.07.13.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:43:30 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: ipa: re-enable NAPI before enabling interrupt
Date:   Thu,  7 Jan 2021 15:43:25 -0600
Message-Id: <20210107214325.7077-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107214325.7077-1-elder@linaro.org>
References: <20210107214325.7077-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we stop or suspend a channel, we first "freeze" it.  The last
part of that involves disabling NAPI, and disabling the IEOB
interrupt that schedules NAPI when it occurs.  On resume, a "thaw"
does the inverse of these activities, in reverse order.  Currently
these are ordered such that NAPI is disabled before interrupts on
suspend, and NAPI is re-enabled after interrupts on resume.

An interrupt occurring while NAPI is disabled will request a NAPI
schedule, but polling is deferred until after NAPI is enabled again.
When NAPI is re-enabled, polling is allowed again, but enabling
NAPI does not schedule a poll (i.e., it won't trigger polling to
handle a schedule request that occurred while disabled).  Polling
won't commence until the next napi_schedule() request occurs.

Instead, disable completion interrupts *before* disabling NAPI when
stopping a channel, and re-enable interrupts *after* re-enabling
NAPI.  That way NAPI is always enabled when an interrupt occurs,
and polling to handle the interrupt can commence immediately.

The channel STOPPING flag ensures the polling function won't
re-enable the completion interrupt while we are stopping.

Fixes: 650d1603825d8 ("soc: qcom: ipa: the generic software interface")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 7e7629902911e..9bde6d02b1cd6 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -743,21 +743,21 @@ static void gsi_channel_freeze(struct gsi_channel *channel)
 	set_bit(GSI_CHANNEL_FLAG_STOPPING, channel->flags);
 	smp_mb__after_atomic();	/* Ensure gsi_channel_poll() sees new value */
 
-	napi_disable(&channel->napi);
-
 	gsi_irq_ieob_disable(channel->gsi, channel->evt_ring_id);
+
+	napi_disable(&channel->napi);
 }
 
 /* Allow transactions to be used on the channel again. */
 static void gsi_channel_thaw(struct gsi_channel *channel)
 {
-	gsi_irq_ieob_enable(channel->gsi, channel->evt_ring_id);
-
 	/* Allow the NAPI poll loop to re-enable interrupts again */
 	clear_bit(GSI_CHANNEL_FLAG_STOPPING, channel->flags);
 	smp_mb__after_atomic();	/* Ensure gsi_channel_poll() sees new value */
 
 	napi_enable(&channel->napi);
+
+	gsi_irq_ieob_enable(channel->gsi, channel->evt_ring_id);
 }
 
 /* Program a channel for use */
-- 
2.20.1

