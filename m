Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5B292F81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbgJSUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgJSUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:34:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57382C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so418861pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eac2eJkbULJAn6wCUm/Bl8+weiuvIgiBhtMaMSxo0p4=;
        b=bCztEImPToOLpt4Vrgm2bFee+ACyaRaMzUI8kK8C/PWxoJCmHDWnCT+nK8qpT6+DXJ
         uOSMipESKk5A9eFh8IGFO2yD7ShORqDqO+ORkjsJ+rgYJfyDhHm4/C2pDXn7FXUF+4Z3
         fd5cftKW3BNHyQAR8+mGuGg87KKsaci7El24plXo4hQdIdFVbMFJRsVPUK4AtPUS0zPf
         0cDuTOKuXtwUB3gY5bHIMjEPRIadI4JyphBJMbcW1RBOQrApxwNraHndqCX/+g7XmfLV
         NIFUIsIphGzMjiCo6sFNIxlf3ZVf6xDp16cXYKmO6kyBhAZlQEF9RDNuQlDpaEaInMVt
         Uekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eac2eJkbULJAn6wCUm/Bl8+weiuvIgiBhtMaMSxo0p4=;
        b=cfw54mjEx3Yko+GBsQVu4v2CWg1RIdzTIHgCpXkjGRU6kwQ1diMMXIbJbdUBzkEas+
         PabrkyoHl0fHzHEcw6At5QGkt8rd0+cMeg2qPMmSHRtM8OdoqRZfdpRKjN1+eNciFM7I
         xjDK8qGNQWOnyxAhnqKp7FDBMM2pQlC143H3S3QTOmEN0SqV/6ht+VKSS7JFIxxfNuw/
         r8/w5EkSUVVrj7rdwknS8bdd1DseuFoKGAgiC4OlwHirkzwK6OR2lzEKzJICkEvOQGBL
         JGISrGgFbjysWye8Dyf5J87aZN4VaPFaTFiUmsKFS+Oem33InOS4WUv0Kyejv8LQIwF/
         Z6oA==
X-Gm-Message-State: AOAM533Q7nsgus+bKyowAQMrDF6cm25j2QLfw1hFy77bHvv3D9FEhBsn
        t5fV4n6wVZIIM+zflw147kfxLLfa6dPM0g==
X-Google-Smtp-Source: ABdhPJz2/jTHYJG+YV8EPnH1F6PIcRNTNWnKolK/dOC8uBilBuLeN2P5VhPJLd8W1ft77hBPANBcAg==
X-Received: by 2002:a17:902:b113:b029:d3:c5c2:e667 with SMTP id q19-20020a170902b113b02900d3c5c2e667mr1564512plr.35.1603139688848;
        Mon, 19 Oct 2020 13:34:48 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q123sm631847pfq.56.2020.10.19.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:34:48 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] rpmsg: Make rpmsg_{register|unregister}_device() public
Date:   Mon, 19 Oct 2020 14:34:37 -0600
Message-Id: <20201019203438.501174-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019203438.501174-1-mathieu.poirier@linaro.org>
References: <20201019203438.501174-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function rpmsg_register_device() and rpmsg_unregister_device()
functions public so that they can be used by other clients.  While
doing so get rid of two obsolete function, i.e register_rpmsg_device()
and unregister_rpmsg_device(), to prevent confusion.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/rpmsg/rpmsg_internal.h |  4 ----
 include/linux/rpmsg.h          | 12 ++++++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 810dd95cc9bd..0721294ed415 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -74,10 +74,6 @@ struct rpmsg_endpoint_ops {
 			     poll_table *wait);
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev);
-int rpmsg_unregister_device(struct device *parent,
-			    struct rpmsg_channel_info *chinfo);
-
 struct device *rpmsg_find_device(struct device *parent,
 				 struct rpmsg_channel_info *chinfo);
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 97098a90c496..8ee1b1dab657 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -164,8 +164,9 @@ static inline __rpmsg64 cpu_to_rpmsg64(struct rpmsg_device *rpdev, u64 val)
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
-int register_rpmsg_device(struct rpmsg_device *dev);
-void unregister_rpmsg_device(struct rpmsg_device *dev);
+int rpmsg_register_device(struct rpmsg_device *rpdev);
+int rpmsg_unregister_device(struct device *parent,
+			    struct rpmsg_channel_info *chinfo);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
 void unregister_rpmsg_driver(struct rpmsg_driver *drv);
 void rpmsg_destroy_ept(struct rpmsg_endpoint *);
@@ -188,15 +189,18 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 #else
 
-static inline int register_rpmsg_device(struct rpmsg_device *dev)
+static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
 {
 	return -ENXIO;
 }
 
-static inline void unregister_rpmsg_device(struct rpmsg_device *dev)
+static inline int rpmsg_unregister_device(struct device *parent,
+					  struct rpmsg_channel_info *chinfo)
 {
 	/* This shouldn't be possible */
 	WARN_ON(1);
+
+	return -ENXIO;
 }
 
 static inline int __register_rpmsg_driver(struct rpmsg_driver *drv,
-- 
2.25.1

