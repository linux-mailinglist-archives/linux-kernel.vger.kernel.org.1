Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02322BB887
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgKTVmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgKTVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:42:51 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:51 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id j19so8432872pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0V+Pj0ilaPOi+EzL05tF5APIQBX5vdWZzPetY3Iqd8=;
        b=BQ2mStleSEb6Vq7fzNOMEORpABuWVGX+OVYNXDrlZp3laXuQdzsp9CL9/KB6iKm3rA
         nqfv+WVK8PJkSdGFgUi0aDPkFlMCwi1HF9KqtfbGeCsQq0DzBcHFkmIWE4AtX3wz8MBN
         DiYMbLLeqYauKBa0yOzr5j0vfaGhAb/2QrmnH7QJtYAdSCXOJmAS5DUkoxUDpTBr2pYY
         yTP8+dy/EaoX4wy0ICiAVROMdEUwnF3E2iAemXTCAptqHKa+6l9Ba9092asqFdob7nNa
         telokoOdqILySOLocvqK2iftTdRweQ8IpdvSYbnWI6B6aFXeTEszTf/5qcg9aoFoyKB7
         8TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0V+Pj0ilaPOi+EzL05tF5APIQBX5vdWZzPetY3Iqd8=;
        b=LcsmCDZAq2n5EMXOvqHJIsEgAeE4rzbNhFY1qRDElFNxqp6LOzt9R/l3LMXoRlH4+i
         OJEiIAOkN9J3oM00SC6JhBViClrYAbWP8YdQYFhoKnwTTg0UOdVBlap2xtLZ7JABN/yO
         F1jTJGeX5RJkLL0FqHMQsuZctpNMIJOmTURlJT2qR+KAn2usR6BbRLOdwSzHSND/lXzF
         C2dAsVRE6DB0pKq96Io/ciYKcupUljTAXSHCT3t36HdVd66sGLZ+765uyvpeDauvgpz7
         8Z7k2/99jBW88ShC+8OC0K29wZbEwztbVv4L71kGcOAs+ghCsV7gagdxobDsJhNUsAB2
         BTng==
X-Gm-Message-State: AOAM5322sfihLxewLew5eiimY9l2yrW0gQbkdAQi4OdrA2VNiNFq0IsK
        oTGfMFDMtE2U2wGoUmOM0IKq8XmKTQBRHA==
X-Google-Smtp-Source: ABdhPJx0An3b+R1I2ZHms+oK4lKIOFr0gTovvFhZajuljF8WtiMdqH3URsRuYsyzOHedVl8cGBVecg==
X-Received: by 2002:a17:90a:b118:: with SMTP id z24mr13018704pjq.102.1605908570843;
        Fri, 20 Nov 2020 13:42:50 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm4713197pfj.157.2020.11.20.13.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:42:50 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/8] rpmsg: virtio: Rename rpmsg_create_channel
Date:   Fri, 20 Nov 2020 14:42:41 -0700
Message-Id: <20201120214245.172963-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120214245.172963-1-mathieu.poirier@linaro.org>
References: <20201120214245.172963-1-mathieu.poirier@linaro.org>
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
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 20d0cf909bea..2253936593c5 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -365,8 +365,8 @@ static void virtio_rpmsg_release_device(struct device *dev)
  * this function will be used to create both static and dynamic
  * channels.
  */
-static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
-						 struct rpmsg_channel_info *chinfo)
+static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
+						   struct rpmsg_channel_info *chinfo)
 {
 	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
@@ -842,7 +842,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
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

