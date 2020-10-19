Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B293C292F80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgJSUfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbgJSUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:34:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A8C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o9so394452plx.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hcw4U5lmOg9HxNvVnMS7hY/n1r7F8V4+oMdjBv27lK4=;
        b=Urd5EVhT41rvG7Mnt4AG1Rtiw5V6LWrfvy17Y3/TbOk0A0E8aysZU2M5/JlcTArcFF
         yYVYMpPaR8np9vwh7QW6mUVOibQUdZ74AesDZhovXf63dxLwg7c8GC+LiK0Yg2kyw9EL
         rpoWyUa7Mu/eSdfWoG0MZAfNJAC0A3kRgFrW7rLJMDKsrsgaR+QEsPITfgxC82tiDp8r
         RXuwNT0DH+YiFtSAd8BYTGegDHHW0VM+k902hrVD0DfAfzXi+weieXhwxfs73ZKZ/gFr
         5Jt+hG17x/rLEA/IG1fH2lViSx7vujYldipOHvauHfntvEq6CIT12GFhFiZJ1xac5bM2
         7ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hcw4U5lmOg9HxNvVnMS7hY/n1r7F8V4+oMdjBv27lK4=;
        b=Boew1naXmcgf0q0DfVxpwAzjU1uBS29tFrtP3U3j7a4rtcTP9Fvh90L103CsguDFlS
         WxC/7SkuqqDIH0umssNzNdQcRV0fwm+dpw6msv2FDxE/Cdbeurs0ExigoaRo8FtC4QXQ
         4F5M8E+PpmxG/mRQEctME7+7ECpNhUVsY5Mi3XR7GjWpee9CPwqHzZFRo26L55W2YAJ9
         NnOyxLaAqSwFWEVPYfEax4Uv2F1GetPlZ+KFyEj4TZ1Qj12RUuK/AnC/xb/nWX+Pfo6s
         ksdyjqQqO04hZqaGwvn6pHt/kno9xk5LsMBo6bNWMScPRVviq9WuEX0AzrT87u8ehrRA
         3+Vw==
X-Gm-Message-State: AOAM532jTyh4QyAPUxIbJ6fmz/svQyPkfN7K07Sq+qG4Gzj7C+xzVUyg
        cYNyaHHlHUdApfanBje8F3wAEg==
X-Google-Smtp-Source: ABdhPJxB7THi9S5pfO2GW+Vv8PUWBhoqhM6YQJk6bJsiEdCRdocklfU52e/ANtQNbcKqVFfNTilHCg==
X-Received: by 2002:a17:902:7fc5:b029:d3:f0da:ade with SMTP id t5-20020a1709027fc5b02900d3f0da0ademr1387077plb.63.1603139687680;
        Mon, 19 Oct 2020 13:34:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q123sm631847pfq.56.2020.10.19.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:34:47 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] rpmsg: virtio: Add rpmsg channel device ops
Date:   Mon, 19 Oct 2020 14:34:36 -0600
Message-Id: <20201019203438.501174-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019203438.501174-1-mathieu.poirier@linaro.org>
References: <20201019203438.501174-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Implement the create and release of the RPMsg channel
for the RPMsg virtio bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index bd5baa0dfcfb..e14390a81265 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -146,6 +146,8 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static struct rpmsg_device * __rpmsg_create_channel(struct virtproc_info *vrp,
+						    struct rpmsg_channel_info *chinfo);
 
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
@@ -250,6 +252,24 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
 	return NULL;
 }
 
+static struct rpmsg_device *virtio_rpmsg_create_channel(struct rpmsg_device *rpdev,
+							struct rpmsg_channel_info *chinfo)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+
+	return __rpmsg_create_channel(vrp, chinfo);
+}
+
+static int virtio_rpmsg_release_channel(struct rpmsg_device *rpdev,
+					struct rpmsg_channel_info *chinfo)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+
+	return rpmsg_unregister_device(&vrp->vdev->dev, chinfo);
+}
+
 static struct rpmsg_endpoint *virtio_rpmsg_create_ept(struct rpmsg_device *rpdev,
 						      rpmsg_rx_cb_t cb,
 						      void *priv,
@@ -342,6 +362,8 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 }
 
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
+	.create_channel = virtio_rpmsg_create_channel,
+	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
 	.announce_create = virtio_rpmsg_announce_create,
 	.announce_destroy = virtio_rpmsg_announce_destroy,
-- 
2.25.1

