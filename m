Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE527371C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgIVAKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgIVAKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84039C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y1so10444369pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbzzrbDhZx0uwATrkyhoLM+A2nR9L970PZGfpM6TTB0=;
        b=iLTt1Smx7uFfhdTUhKzZxeN8wtr6uy46RYMNIjhtQ3bDtc68W1BwCuFibdvTkwEJug
         XF+5zdjbf18nXVXpu9A9qP3gf8apyvHwkjM57nGIjy49PCwvm3hwDuDfwNYxtL3t0Mmn
         izcEWc8TWIdeWjr1jnkAQklTnCsfbdP6F6lNYcoJhsAZZIQ4UahHpJkpQQGpe5AZJ4SL
         mv4Lp23DVrlkj/FSRxCqlbf6Nv8tKBW7jr8W/Mdf0GWxXaQQY/YlnEEJrSNW47Nt7729
         w0oFej/PBzAi62lkTNiKF+r2njj1iIKwYcUSjrfQlX1LNQyw9aTnKGj29PZmZgYWN9xI
         8r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbzzrbDhZx0uwATrkyhoLM+A2nR9L970PZGfpM6TTB0=;
        b=ePtuYFzbeFuZGz2Ra4b1Bvv9YaI76WTEm2258Q9y9nuhr0etNlkUSUy1GJa0f4F8HR
         SJ822fUhrx6zU/xXAXQXQHqJB5P6uogwen4snNmfOXzQ4hiexp/d7wB1fdGaE/jXXIQF
         f1wg5T3U4caw3y2536K3HvNHOh4c6fMlqD1jP9nSB70lPvhvepq8xUfmljyefFr4dtYB
         ymDzPCldrzpnEsMVeet8v8NGn+2jsanseEPjLlqMooPiBTatUEWYLnnyZevDmFKufSqm
         NyRgWe+gSJsQ2JCD7LfaDWh6+M/PBdjQsQJjCuXmh5g2BgPNQPUfwkD0trmQtR8QQRHa
         IPUQ==
X-Gm-Message-State: AOAM530froaqXHDhqN0GI9JzolfPfVjy23azVeivV0NA4cOV7Luf4qNz
        2WqESIXQ8zBwpXWks/JqQx9fvw==
X-Google-Smtp-Source: ABdhPJwWRwcrPfvgvFCP11lvXOSs/9uM+0kqDcOin22KRsPJDvt+AWNRKrEPKCZDZ33UblhdqVG1wg==
X-Received: by 2002:a62:fb1a:0:b029:142:2501:39f9 with SMTP id x26-20020a62fb1a0000b0290142250139f9mr1796480pfm.72.1600733403024;
        Mon, 21 Sep 2020 17:10:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] rpmsg: virtio: rename rpmsg_create_channel
Date:   Mon, 21 Sep 2020 18:09:51 -0600
Message-Id: <20200922001000.899956-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Rename the internal function as it is internal, and as
the name will be used in rpmsg_core.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 7d7ed4e5cce7..e8d55c8b9cbf 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -395,8 +395,9 @@ static void virtio_rpmsg_release_device(struct device *dev)
  * this function will be used to create both static and dynamic
  * channels.
  */
-static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
-						 struct rpmsg_channel_info *chinfo)
+static struct rpmsg_device *
+__rpmsg_create_channel(struct virtproc_info *vrp,
+		       struct rpmsg_channel_info *chinfo)
 {
 	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
@@ -869,7 +870,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		if (ret)
 			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
 	} else {
-		newch = rpmsg_create_channel(vrp, &chinfo);
+		newch = __rpmsg_create_channel(vrp, &chinfo);
 		if (!newch)
 			dev_err(dev, "rpmsg_create_channel failed\n");
 	}
-- 
2.25.1

