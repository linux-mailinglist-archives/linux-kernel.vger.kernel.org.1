Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFBF29C40B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822793AbgJ0Rwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:52:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822766AbgJ0Rw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:52:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id 126so1354335pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxjbKzwWoRD40O1+8yIOYppCPE1O5hDOkWo3lEMuP9E=;
        b=AhB9yxjE+oTFnHBvWkXQ1VwSvJONRbmdfYDgefWFNWvk5Wis3UPohWet2v/uqNw/KE
         Uxzw4t88R0JCVK3rRe8HgNZDX7GmJKMw1/rsjRD9qM2jlO35dJ6eDcICWe7jMmnz9BpW
         BKJt+x9zcJqhH8RZa3fDDS3TiWLMRddJXCmRKcOehLTIkg7AP4LOrOzkRaIzB4m5IVnq
         b3nlR9aBTRvn+MkDx18PpA5YMSsTFlQIGNz2V8sKRmAx5IlbZ7CJDh9iUh3/mB2uMZ4b
         WMK5QiTSfhK3/I20E04e/Qa6w/CvquSrWQt2/wJlOaEICRzbRvopsG2pZYn2bOTYcGfF
         uwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxjbKzwWoRD40O1+8yIOYppCPE1O5hDOkWo3lEMuP9E=;
        b=RQU2etQNA/zhZfHjVCHjwDv+E2/JtRpEGqe4gpYu391pTkm5vtN8aExeQiaXC2+8r+
         dNHdkGR6ktbwTWcViOEwIKQwETjUPuLfEZJ1FbWPBeRM5wmkJ33BMkgTVNUvuidUTNQG
         noYZLPgfdqrGTXg4bH69hI/5T4i+10wVzlAO9eAfwGl5wysA8LJ4Ks3qdKZyYOS7uUYw
         r52uTCL6+IPFwaO/gDxgg0+HxSLnupxpyzHDsT0J99GajFx31ZjqVdPxFxPeBkfoB0D0
         9AidYg9CJinoXDh4YltSH2kF40YW02I7NkJ581m7KJwN+1r/8V9qQiSuYyg5bStIPY4O
         OwAA==
X-Gm-Message-State: AOAM530sLNqEhqBuu3iju97L5Z9MrcTR4RhZyUZHfULk8yqOVPdrSWh7
        Y2EtBfBg0bjpbHHBg5YpajuRaQ==
X-Google-Smtp-Source: ABdhPJzb/Y2FlMAxI4SxtC0Nvt4H/XMijvQBJrCPJfb/Zlmk7pJHYbEcXkdLe1HKKdLaLSUseMajqw==
X-Received: by 2002:a63:cd48:: with SMTP id a8mr2741390pgj.83.1603821145679;
        Tue, 27 Oct 2020 10:52:25 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm2761225pgl.57.2020.10.27.10.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:52:25 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] rpmsg: virtio: Rename rpmsg_create_channel
Date:   Tue, 27 Oct 2020 11:52:14 -0600
Message-Id: <20201027175218.1033609-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
References: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
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
index 064a5ddcf7c0..01f05bc570a4 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -365,8 +365,8 @@ static void virtio_rpmsg_release_device(struct device *dev)
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

