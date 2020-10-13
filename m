Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D828DD94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgJNJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbgJNJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145AC08EA7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so756505plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3n2ho81UJxHjYAOtHKEObboyFHoWnbr7nY2GT8du90=;
        b=pcw3QpIsWZbgV4mYT17/ZkDzS9GUQwNuXdpUMmPVIXjiAHjDxVe2fclc667n1Mf/Yp
         jO7VVcFUwEnza/M2gr9UFAmzm7fcu+0IcEV+Apl+mye532Kte5e44raMMe+WExzPBQni
         dRdyZVioPHp0H6EVxrlYtgayiGzaOsG3ZOtA7a0s1kvc7uD0IsmBsb6LZTYHVCsW9N/H
         8aWdr2fJd0V5n/s5OHrD23yLxp47xaIbDnKYQNkLmBzwYf7mnYVwqniLy9Au9PG9Tzv3
         ZvqvJq8WayGzHYEvBuDpjfrxtxk+Cp+ERTsySzfYL06z2XJ3R6nQAg1bX86fGXVXGL9v
         COHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3n2ho81UJxHjYAOtHKEObboyFHoWnbr7nY2GT8du90=;
        b=TmTIzUR8FBwh2CLVTSn4eOOQVDPP2Xf4V4OYWRIjGTYH+u2JQc0x+q8wt/A1KDO0/m
         TpblXVsPrkv7pM2+Rj7UHZmJepBF2In2R/vkZMc/pHTd4an8sOHwhpW63kpq5CwTbBmi
         ISEb+xSR5vXQ7trLglS7chwQ+ZOGmKvCSMI1uYu3MWNCspIPzQSJacZa2xbjflVJxD57
         CgNHkz8XHa/t0N+AASXt/0eD2l5za+lTUa/vRNJzSdltFz+5SSwcwZupPvcMqX7TBtWr
         c7Gsfvp5CnyLbhiWH1Mp37CWF7z5RSBTXFCm/GsaAQobV7G5k1ogqbZQHGM2SaS1PAwP
         E6GQ==
X-Gm-Message-State: AOAM532gcFzaJBEdCrU8a/DMy8CizEj72LxsiJnFufQudkjeTHPkoq+q
        yrsslq4p21z/BwBiwEBR3Q9sDw==
X-Google-Smtp-Source: ABdhPJwUl0alPVSwthinpn9vl5ZeslA2Ow8z+un8kBTktbxsOB0px02HyluHPifSwZurWsCmmfN8yw==
X-Received: by 2002:a17:902:6b44:b029:d3:e78a:8ab6 with SMTP id g4-20020a1709026b44b02900d3e78a8ab6mr1695546plt.72.1602631531099;
        Tue, 13 Oct 2020 16:25:31 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b8sm791871pfr.159.2020.10.13.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:25:30 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] rpmsg: Make rpmsg_{register|unregister}_device() public
Date:   Tue, 13 Oct 2020 17:25:18 -0600
Message-Id: <20201013232519.1367542-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
References: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
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
---
 drivers/rpmsg/rpmsg_internal.h |  4 ----
 include/linux/rpmsg.h          | 12 ++++++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b9b34b416b7b..70de053581bd 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -49,10 +49,6 @@ struct rpmsg_endpoint_ops {
 			     poll_table *wait);
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev);
-int rpmsg_unregister_device(struct device *parent,
-			    struct rpmsg_channel_info *chinfo);
-
 struct device *rpmsg_find_device(struct device *parent,
 				 struct rpmsg_channel_info *chinfo);
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index eb70463a9f2e..0b3ec18ddbaa 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -188,8 +188,9 @@ static inline __rpmsg64 cpu_to_rpmsg64(struct rpmsg_device *rpdev, u64 val)
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
-int register_rpmsg_device(struct rpmsg_device *dev);
-void unregister_rpmsg_device(struct rpmsg_device *dev);
+int rpmsg_register_device(struct rpmsg_device *rpdev);
+int rpmsg_unregister_device(struct device *parent,
+			    struct rpmsg_channel_info *chinfo);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
 void unregister_rpmsg_driver(struct rpmsg_driver *drv);
 void rpmsg_destroy_ept(struct rpmsg_endpoint *);
@@ -212,15 +213,18 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
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

