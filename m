Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0CD2A8A1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbgKEWux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732497AbgKEWui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:50:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5DCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:50:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w65so2539327pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jz6JCYyURz+3oCPXxnAvwJDQutjB3zynS7kiUzNmMdo=;
        b=Lyq6cBR5bESwgDz7BezLJTREjb84mC72Z4RznrhqvsM1m+LcHkR/OBZ6evj8vv8K/Y
         d+uakuZvP05xdUAYUHd02N3vT1SwapEoFpR4b05gQ3XWX71+tmc3OxjJ3nEHeEWJyK+q
         JsdSpSBGDSbB5R3mxfcXe2GWes4kUxXVyCR0zZXyXdN8DA5HF3DGfcjto3qdjU2NSGBD
         EkJhQWHbRSUTC+Ds3m4WK9nMNEDPollDiegkcfYAXUk18VVC2w7l/VBRGyzIBtC+sN+P
         GLAln0Tax0kGF5IcP+x15WFtAc32t1w5BOC8mhvFvizwe48G5lygy6NLCQG2TO/tBrWR
         a4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jz6JCYyURz+3oCPXxnAvwJDQutjB3zynS7kiUzNmMdo=;
        b=RVpwD0VRq/R8SsnToD6AF9QpdxdRgkuwTEcZ7xIIlOJI9hdCFKbaPIH8lrp11aVfOp
         PzQSv/+lRx2kwRF6LCNGGTdrWC/6qiz7zJdz1T9Z66I7bZr5MymXu2NcZc44wq5mJElz
         /pHHRcej1iNoN1encudVblEdv+MVwXIdS1ibkzDJ3tgskQYE7ZQU8IJBUQHrTO4aFr6l
         iUEhzXzftOdHr1VOUiVwFHE7ULXADX22OLOmUac6zdNxJXpbXsa19Ui4r0zdabcWzTmh
         oeHX/k0rXs8caqS7ddwU+ehTDTVGcYiOA2iKDKizpc8H1q7U0XFpjCByARPuGydr9zEv
         g95g==
X-Gm-Message-State: AOAM530SoS6hun+JxQFwzAUGCH+y7dbBi5mMGPnzfpw5xpzA9ODAt0xy
        ernnj7Uw4UywAJvta8+c9inMQg==
X-Google-Smtp-Source: ABdhPJwVscyvOD2/BQ8bxMexnSNdtAko1LauXmsbgiYM3BeHOTcfB1XMH1i2d+8Aiq9BtCLJwIsWsg==
X-Received: by 2002:a17:90a:2c46:: with SMTP id p6mr4655524pjm.166.1604616637666;
        Thu, 05 Nov 2020 14:50:37 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d145sm3854501pfd.136.2020.11.05.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:50:37 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] rpmsg: Make rpmsg_{register|unregister}_device() public
Date:   Thu,  5 Nov 2020 15:50:27 -0700
Message-Id: <20201105225028.3058818-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
References: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
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

