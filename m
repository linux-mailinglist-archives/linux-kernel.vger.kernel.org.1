Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8384F2E2F36
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLZVjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLZVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:39:02 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ABAC061794
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:37:44 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id t8so6326935iov.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EelmeiCwh0mSgh0t/gPM5pOh0Ts2KQEn5sM0mWzh/c=;
        b=v15rRe0XLufvITPY3eBFUGrxw7IrH5moQu5pQ1ZU8Tr/3V7cc7B0nwtZ5IHxL7pdCv
         an6NBskCa9l4kjhFnxBJrT0vDJPvIiSd6+JSVuepbDEhTqENf3cZ2V8RcmXI/0UFnfV+
         JF6r5Bs70TvNfQDyFan7Gwx72nyBwCK/xcnUubnhyoGEH8rLyUcrBpIrrxqtRwIMGAgm
         5tm78NwhdR8N0CZYcnWFgdYyHvRP762HefKO6upkAt9XX0ca8Uf4cX6xdbsYhSsAU0af
         ih5Un7YeB5adqn4R/5j07LkjA6mCpjObiJUA1cymMQ72t0ALQz1EaAlvbmr9wt9hC/mI
         TuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EelmeiCwh0mSgh0t/gPM5pOh0Ts2KQEn5sM0mWzh/c=;
        b=CKIn5PW62J/fmWm701k4bJ5D6Lh9GuVbiUTjMThTpiYu4scjNvxe/LVnYeqpM7rNWA
         DMh3QSitqvlVZlXzkUwVhl/CUm7GWBq0W6bv1B98DPJs9yAQRGecyRA8jtYU+1Lc6HEF
         HLqHlYchuDnXB89TM8pWLjbtg+HZcfh2+WGokB5ZJH7W09gICncx94ZxTQfIBT+gRHtE
         C5yG4tYub2fPbemOsvQqlLMP/PFrqnGSphfEM5gxNWnu/E0MEXRkHI4Z4tvsJ1wQWdVb
         9d2JUsWLdJjsG2oXKiJ2sisSsxgZEglyCQaxts+hNFf0Tw7VI8lIBWkrhtuf6gWH4U5i
         qRvw==
X-Gm-Message-State: AOAM532vhOg3TCPvEZX0RBfrKmt+wYC+ls/P3esv9NurEeX6lg6zBIPZ
        +XmVYRpb3Ro6M5EmHX0pDvovQQ==
X-Google-Smtp-Source: ABdhPJw7RgiiN5BW8xuhIE8ulm2Vbf1h4RpsXrtyvNLsefo0DoA7qiHktnQtnsq4USgTavWr44y5bQ==
X-Received: by 2002:a5e:9242:: with SMTP id z2mr32257326iop.175.1609018663463;
        Sat, 26 Dec 2020 13:37:43 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u8sm30582763iom.22.2020.12.26.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 13:37:42 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH net 2/2] net: ipa: don't return a value from evt_ring_command()
Date:   Sat, 26 Dec 2020 15:37:37 -0600
Message-Id: <20201226213737.338928-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201226213737.338928-1-elder@linaro.org>
References: <20201226213737.338928-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of evt_ring_command() no longer care whether the command
times out, and don't use what evt_ring_command() returns.  Redefine
that function to have void return type.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 428b448ee764a ("net: ipa: use state to determine event ring command success")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index e51a770578990..14d9a791924bf 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -326,8 +326,8 @@ gsi_evt_ring_state(struct gsi *gsi, u32 evt_ring_id)
 }
 
 /* Issue an event ring command and wait for it to complete */
-static int evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
-			    enum gsi_evt_cmd_opcode opcode)
+static void evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
+			     enum gsi_evt_cmd_opcode opcode)
 {
 	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
 	struct completion *completion = &evt_ring->completion;
@@ -361,19 +361,16 @@ static int evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET);
 
 	if (success)
-		return 0;
+		return;
 
 	dev_err(dev, "GSI command %u for event ring %u timed out, state %u\n",
 		opcode, evt_ring_id, evt_ring->state);
-
-	return -ETIMEDOUT;
 }
 
 /* Allocate an event ring in NOT_ALLOCATED state */
 static int gsi_evt_ring_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 {
 	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
-	int ret;
 
 	/* Get initial event ring state */
 	evt_ring->state = gsi_evt_ring_state(gsi, evt_ring_id);
@@ -383,7 +380,7 @@ static int gsi_evt_ring_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 		return -EINVAL;
 	}
 
-	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
+	evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
 
 	/* If successful the event ring state will have changed */
 	if (evt_ring->state == GSI_EVT_RING_STATE_ALLOCATED)
@@ -400,7 +397,6 @@ static void gsi_evt_ring_reset_command(struct gsi *gsi, u32 evt_ring_id)
 {
 	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
 	enum gsi_evt_ring_state state = evt_ring->state;
-	int ret;
 
 	if (state != GSI_EVT_RING_STATE_ALLOCATED &&
 	    state != GSI_EVT_RING_STATE_ERROR) {
@@ -409,7 +405,7 @@ static void gsi_evt_ring_reset_command(struct gsi *gsi, u32 evt_ring_id)
 		return;
 	}
 
-	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
+	evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
 
 	/* If successful the event ring state will have changed */
 	if (evt_ring->state == GSI_EVT_RING_STATE_ALLOCATED)
@@ -423,7 +419,6 @@ static void gsi_evt_ring_reset_command(struct gsi *gsi, u32 evt_ring_id)
 static void gsi_evt_ring_de_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 {
 	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
-	int ret;
 
 	if (evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED) {
 		dev_err(gsi->dev, "event ring %u state %u before dealloc\n",
@@ -431,7 +426,7 @@ static void gsi_evt_ring_de_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 		return;
 	}
 
-	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
+	evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
 
 	/* If successful the event ring state will have changed */
 	if (evt_ring->state == GSI_EVT_RING_STATE_NOT_ALLOCATED)
-- 
2.27.0

