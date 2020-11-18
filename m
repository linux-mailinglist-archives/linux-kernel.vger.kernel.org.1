Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901ED2B86E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgKRVhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgKRVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:37:08 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD24C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 81so2219781pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0V+Pj0ilaPOi+EzL05tF5APIQBX5vdWZzPetY3Iqd8=;
        b=RVxSONmTmFchR5uxHhCtCS1pk7Imat+poXGbdY1TgW6KqZV+YZDteRSIRqKzzwK+T0
         iuhwu+Cdm4dkHY7AbwjBWJuJMuK8f2M3y9w5gOrtAYCWmFc2Tyg+WGg1AizkzGbdZO/s
         2K47lUg/Oy6/ozg1uNpuKB/eHllJJKVXFJo6QoPwOZ0676y7X8Z2KgnnXgO+4eQx5IxP
         RuPt/Tuc5mg87P2HhOp64Exs20nQddcmIxE8Ca8i9kwAs7Fldn+3s3d7C6sJZ/1xrbFF
         mm+W8/44Mn8HUwGM4K9JN5sb7JP3uTOmO3PxHq0ZliAs9oSDBygo1s5utEcT+/cFefGk
         D71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0V+Pj0ilaPOi+EzL05tF5APIQBX5vdWZzPetY3Iqd8=;
        b=sxIByF8omEVHOPBJpHUi9uvoVwtIbJfOhWWil8oIkQLlsXiUwJlFLwJN0R6e1tbZWn
         MA2U03bRDB/Ujfek9QBMJKH+nJKm5BMisO8b2wSsvwT0ahidHj+Yo17tsCIYfVF57ZIB
         1vLoWwBf6i0nmzuS/ZqtWf9mbJAEQeRwHngSVQMRzK0MiOyCP4j0ccSUXMN9MYhVNIAF
         HOG8YOfyt80uIynLTKVG7CDUL6Q23IlMIEEOk8Vz5DfWM+nTXv9XjdGMgd6i5Rx7MxZM
         8gtlHtNSD11BDS/SFTASry9HxV6q8gAPOnbZRU8IpX5XRKMfAsLiOtMSPICo1EDConKI
         rCDQ==
X-Gm-Message-State: AOAM5324FSG7lc22EVJBM27jvJ3l31AnByeE/NngBQ/sBkS2cABLACNV
        YriACroKpDlvDOg198+dLw9kNw==
X-Google-Smtp-Source: ABdhPJzcZgsyf4S9HllU0iQptl/crimQpN5Uwf4Wk6kK4UwMpXkTGdhQSeH5/iYwpeFinpg0Sqy01w==
X-Received: by 2002:a63:e146:: with SMTP id h6mr10367406pgk.0.1605735426604;
        Wed, 18 Nov 2020 13:37:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm26575694pfn.190.2020.11.18.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:37:06 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] rpmsg: virtio: Rename rpmsg_create_channel
Date:   Wed, 18 Nov 2020 14:36:56 -0700
Message-Id: <20201118213700.74106-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118213700.74106-1-mathieu.poirier@linaro.org>
References: <20201118213700.74106-1-mathieu.poirier@linaro.org>
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

