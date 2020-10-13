Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471E28DCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgJNJUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387819AbgJNJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06582C08EA78
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so714570pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GahyWSypfEwT9uS6WgR1EVJilbD+R1xTvJBHKJc9XE=;
        b=YmFrCopNTlwMHpVSctRlADa9tTikF+I4k4nziJkD70kXhUO2rF9SnWUSAHL3ISxxEJ
         lTxNT3R2wJTHIEE+FbSySVzOZ3vZ54EZ3ZhESZJRLE7oV6hu17dxsME511DvpMU9cQZo
         uQxCdx9kGw08cM/qDH56ktGjgW+oIus5lkKg0OUl4dlWUowl3pkXhAdKPG3kBG0OBshv
         IbZcB8xIbc//enos5xYaiTizQnJwAZ1eU62lVwqcLxYcm4t9Hub/FkHPqpKPb2IVjElq
         yuAiFY6YjkHN7gC/JgMBsnSb9CT3hfV5nkoLFphaAv1Osa8CpkTs3y5sIhDf6qTPWVTK
         2Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GahyWSypfEwT9uS6WgR1EVJilbD+R1xTvJBHKJc9XE=;
        b=WZiTHw8Gr+tacXOUd+3Wsgmin7zGJUPtGTcbKEpSIrb8ReogEvL1E5BECLDkEbC/XD
         noqxcLHO7/4qTs2gM90lCcx6UzqNwEhjvBEzfyNoLWZehRvoi00r2QYQ6zAAbHADNB1X
         iKo0YP3PZpZHN6gexDxozT6RA7yd2pT16w4roiSn9+00R+taCKFcWPSrBRbz3B09sY8B
         D9pGRgNTv3bfo2fQcKO0uWcziM1yZZMjHal53IgXfFfuplb8No7Zw1Vl6RrW4Di8uwZF
         HeUIys6sRUehXfHOcBgr87dhIC6IXBqC5cuE5/pPv4GANkQcMeG1jOLDXVw7l8JGiM8S
         db9g==
X-Gm-Message-State: AOAM530gydePgT5Z80vakGgCWmywTCMyFaxbtC0Zy3GnRliS0dS3c9n4
        JNS7w1kKp5t9lQVbN52t5Ts9na29KCsrIQ==
X-Google-Smtp-Source: ABdhPJwUUJW2kk45QEin98GKD9aqoUdihex32D7rFCGWnmD3eKWuZH6rT1vSebcSHBqVGXxaNYjuzw==
X-Received: by 2002:a63:f744:: with SMTP id f4mr1554710pgk.34.1602631527580;
        Tue, 13 Oct 2020 16:25:27 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b8sm791871pfr.159.2020.10.13.16.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:25:26 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] rpmsg: virtio: Rename rpmsg_create_channel
Date:   Tue, 13 Oct 2020 17:25:15 -0600
Message-Id: <20201013232519.1367542-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
References: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Rename the internal function as it is internal, and as
the name will be used in rpmsg_core.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 85f2acc4ed9f..fca982b61c3b 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -345,8 +345,8 @@ static void virtio_rpmsg_release_device(struct device *dev)
  * this function will be used to create both static and dynamic
  * channels.
  */
-static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
-						 struct rpmsg_channel_info *chinfo)
+static struct rpmsg_device * __rpmsg_create_channel(struct virtproc_info *vrp,
+						    struct rpmsg_channel_info *chinfo)
 {
 	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
@@ -820,7 +820,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
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

