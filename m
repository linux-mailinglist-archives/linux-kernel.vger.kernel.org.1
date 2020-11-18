Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF862B86DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKRVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbgKRVhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:37:10 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207DC061A48
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 81so2219929pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jz6JCYyURz+3oCPXxnAvwJDQutjB3zynS7kiUzNmMdo=;
        b=no8NmVJ0uLTOe3xrw/pOr/wq5Axf3Jpz0z4ao3AI6IPNiKgl7fYcBh3rwBhyK1Lx79
         Y1K7O6ni78WsDi7JgJ9K0J1HPzWeFb81ybauXhBeLK8x9BrU3ZLiPUqIYuUPb2m6G+2l
         SrDq3Q+nzTvwq6a47nsl2JGHfqAJAPOiWNXP5i6Zv4HnFxxL59/jawbiBIvPm3yAm+RV
         AilcGgXEeQoz3c8TPvsi60FO3rik1OI166hXkbdyK51dpDQZCIAMZKM3LnDtdCU2lJWz
         Zm8/TF6b1mXo8DOdj5m4UzaXruMDXEqwMYbNLX5gDh1JoKwqlHZ27YZDniQag+tJyuNy
         QOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jz6JCYyURz+3oCPXxnAvwJDQutjB3zynS7kiUzNmMdo=;
        b=jJGEaqEBTZ0ZiD9wgAGXOLRZpwAddy4/c25LLWpeuTg83H2jakgFrkUipRXzCeOfGd
         9HycWCgsGDWsYavpZB5vClTkRAdL/2b/bVpfZ4xIz8zmQVlyftxUrKpf1WvSKEthUP8T
         0skTNwPxQKm5NFzFvGsrGF2UifkXipBJoUl/NVKQamoJh4Jrsp26i5Yu7JdNFRmIW17n
         DGDV0886+nypVqFbX4bib80doVeovsMdOgpJPvJgcSMEqrly5CVp3KXdfcQ1bfaFuuun
         +coMkm4uLIseJqbFnWpXBDTz7IM8q5I4iFgxH4MmipVWjOe4t9ti+0Tq1ZQkILaTN2gG
         Qh2Q==
X-Gm-Message-State: AOAM532vqvFLFEkKO4A2tKvWS84VFouRme/C8kFS8+59ahhQ4R3OIBbp
        0ukBm/QeRqC716joBd24Vw3qaw==
X-Google-Smtp-Source: ABdhPJyO9knuWxEulG+GqJzfpyUzibox6S+EV5G2TvAeje7vTPsO4RzlJ1cMOJzAnYyGP/bMMhpIsA==
X-Received: by 2002:a63:1805:: with SMTP id y5mr9607064pgl.27.1605735429652;
        Wed, 18 Nov 2020 13:37:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm26575694pfn.190.2020.11.18.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:37:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] rpmsg: Make rpmsg_{register|unregister}_device() public
Date:   Wed, 18 Nov 2020 14:36:59 -0700
Message-Id: <20201118213700.74106-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118213700.74106-1-mathieu.poirier@linaro.org>
References: <20201118213700.74106-1-mathieu.poirier@linaro.org>
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
index f1de73e0f2d6..a76c344253bf 100644
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
index faf2daff6238..a5db828b2420 100644
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

