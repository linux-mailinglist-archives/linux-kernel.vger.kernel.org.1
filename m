Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57EC2BB88D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgKTVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgKTVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:42:54 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:53 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q5so9146012pfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zy3k3QU006yaoOz1NXa213YD9ZVtkyTeVCamwFEkkEQ=;
        b=mHVx4nMreWTzBAHDDMmYZXDqZmTt10XLrRXiZQrup3sGkBkxTudYjR55ls20nM5eW1
         JmmqivHfvVfsui8YPxni6zeqnY09u38UAcAxPavMKmwVOyxQMCgOrcSCJ5YuTeGiBIU3
         MRqBh9EIUAuzrVsupH8W9p1t8zaoNe9kLz1qM6PTl+AwQDI9aZg2IyHNfq429pebncYa
         mSRK5ytaY2LePH3dTwe8pyZ0zd8dXwRUAwJZh4SrbQS5pXauaIuhtFzEw38nDfAGiDhE
         1fmmI4s5+Z0W465VJf5xAONWerTxW2/4i7Hk+/CoJaU6mTtchTzxgrna2DVHVj9zLI3R
         gcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy3k3QU006yaoOz1NXa213YD9ZVtkyTeVCamwFEkkEQ=;
        b=WWd6sW1n6iycms8ZpNLA3Kn7wFwlQh9Vu+HkgO4ZFIn/aMg9+AjOLmMUr1H1/MciPu
         W78nXR+bXp5F1bx1Y5Rg+kdl4ZWDHQjO3S3vQ4XpPXeVeswPBC1X8MPRCiAipOWBqwWS
         +OUR7rkuMhXyUbld5CvPx2CS6lwh4hPdM2G8Wvhc3epLZuSdJZD/rsVmj1/G4lKneYHL
         OutBS2nRFfQoyvDRRlLgnXuNs8srm10NWYKqkag9BXjbDFV2wg0YmQdDiCrGLRGWerKX
         ecPCFan6kepCgWgjcdPi5UCPw+KSrlSaIUyZOPXRJuTMshN5PKH8j4Azk+nVha5wF6gC
         NZPA==
X-Gm-Message-State: AOAM530u+pdKCzeGFKiqnUbKreju765cWLhdV3ACIWnaImjMVVjDLZlN
        deN1QUUxiHdJrVn2GovEzdaO3w==
X-Google-Smtp-Source: ABdhPJzDV/RbYKBqaRiwM48tr9/S9fRSo6t/9VSD2dhcy8do6dMdNAgMBeP8oattOr/L6XrG3E0dPQ==
X-Received: by 2002:a17:90a:c401:: with SMTP id i1mr11822474pjt.184.1605908572867;
        Fri, 20 Nov 2020 13:42:52 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm4713197pfj.157.2020.11.20.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:42:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/8] rpmsg: virtio: Add rpmsg channel device ops
Date:   Fri, 20 Nov 2020 14:42:43 -0700
Message-Id: <20201120214245.172963-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120214245.172963-1-mathieu.poirier@linaro.org>
References: <20201120214245.172963-1-mathieu.poirier@linaro.org>
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
index 2253936593c5..6ec299f7f790 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -151,6 +151,8 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
+						   struct rpmsg_channel_info *chinfo);
 
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
@@ -255,6 +257,24 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
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
@@ -347,6 +367,8 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 }
 
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
+	.create_channel = virtio_rpmsg_create_channel,
+	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
 	.announce_create = virtio_rpmsg_announce_create,
 	.announce_destroy = virtio_rpmsg_announce_destroy,
-- 
2.25.1

