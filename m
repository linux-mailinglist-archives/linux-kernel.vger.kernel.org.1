Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B23A273728
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgIVAKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgIVAKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k133so5685715pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYPr+7owzyzLplTCeGY50zAG7FlCrMEoUfNJS9GMOSU=;
        b=X9B7jt/PocCFkpDLXpWEOeyS6Aa35CKU0xIQNF03K3hk2yt4jXmf4G7/A4sudY4IhD
         gZ0F5XM+NKvO1ab/sBKJ/JGZH1yiV5WIG5lDEAv6P5Q0OjNL/w3iW7TO8l2DheRetixw
         2FcT+LgUfCzP0tLE4PaOKkC0E1yG3GGHaNngv8PSpEEZlR/ptWg5ImH6GPMvzLTjXoOo
         FkjBNbm4ERXiJFndrCa4anX3GxCXf6US0IOSitxZiSyZ5uKcBHIOae8Mhu22wN6R2DbP
         eH3NqfysxwsnXf6ciepO+YAkXVxqL6Q8li/u+8ekfKTvwOJ80M0Z7vxGqAVTPmKw0WuT
         rY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYPr+7owzyzLplTCeGY50zAG7FlCrMEoUfNJS9GMOSU=;
        b=meXRVomKjkaOAaCfta/Jggl+p4rQ4Vnb4stAY+FDMdKteEPoVYF5IF+NKDuVtS/EDF
         FIz73WkhMJHOSQx+eCoL4G9ublSfGR33o72AqTKemH5EZ64P3OCTkTqLqkn/WyXRbwzc
         Te0H2AWdAfKQ/clUrrf/kc5CvMauePXphna0twDrd34sj6+iLbbQWHw070cPfHpiDnlX
         gqStT3494BBlCJvpXBTIsf+pNcY7h6WutgdBScoffrmBnX+Kkc6ByRFEX3AK/5sLxH3z
         A2BBWLybpnvKVl20I0IUusrGRnOkshsPkiI2xsJRQ7/Zqq7Q1JSWQf5bgDddWsxLLhht
         hHUQ==
X-Gm-Message-State: AOAM530q6I2+rVIhwM+3/wKeWrla54IwjA6BhPph6RdcWsm58w+/6d0m
        BdBQDDKdzsnPqAl1g8Eq7j0EEA==
X-Google-Smtp-Source: ABdhPJxLG4zVEFiTc0YFWJgvJVZU03YbD/HubJTEB7Pj5AzguknZki7gHWjxvQU3NiNWes3J4xnf3w==
X-Received: by 2002:a63:d841:: with SMTP id k1mr1548724pgj.59.1600733414189;
        Mon, 21 Sep 2020 17:10:14 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:13 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] rpmsg: ns: Make Name service module transport agnostic
Date:   Mon, 21 Sep 2020 18:10:00 -0600
Message-Id: <20200922001000.899956-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make name service module transport agnostic by using the rpmsg
device specific byte conversion routine.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/rpmsg_ns.c | 10 ++++------
 include/linux/rpmsg_ns.h |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index b3318bf84433..1df3aaadfe10 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -18,9 +18,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	struct rpmsg_ns_msg *msg = data;
 	struct rpmsg_device *newch;
 	struct rpmsg_channel_info chinfo;
-	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
-	struct virtproc_info *vrp = vch->vrp;
-	struct device *dev = &vrp->vdev->dev;
+	struct device *dev = &rpdev->dev;
 	int ret;
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
@@ -38,13 +36,13 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 
 	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
-	chinfo.dst = virtio32_to_cpu(vrp->vdev, msg->addr);
+	chinfo.dst = rpmsg32_to_cpu(rpdev, msg->addr);
 
 	dev_info(dev, "%sing channel %s addr 0x%x\n",
-		 virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY ?
+		 rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
 		 "destroy" : "creat", msg->name, chinfo.dst);
 
-	if (virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY) {
+	if (rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY) {
 		ret = rpmsg_release_channel(rpdev, &chinfo);
 		if (ret)
 			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
diff --git a/include/linux/rpmsg_ns.h b/include/linux/rpmsg_ns.h
index aabc6c3c0d6d..9f3030b2145b 100644
--- a/include/linux/rpmsg_ns.h
+++ b/include/linux/rpmsg_ns.h
@@ -41,8 +41,8 @@ struct rpmsg_hdr {
  */
 struct rpmsg_ns_msg {
 	char name[RPMSG_NAME_SIZE];
-	__virtio32 addr;
-	__virtio32 flags;
+	u32 addr;
+	u32 flags;
 } __packed;
 
 /**
-- 
2.25.1

