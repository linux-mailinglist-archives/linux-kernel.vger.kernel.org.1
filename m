Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD12B86E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgKRVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgKRVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:37:09 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4EC061A52
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:08 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so2402295pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zy3k3QU006yaoOz1NXa213YD9ZVtkyTeVCamwFEkkEQ=;
        b=icUFKKqdT3O3MfaZT1wGzWn5QA732yvQHomUfU0K7xdkzUdogA+4S5L9cfQ07uzZhZ
         AZp2HNmeoiburbu5jDmc2c/PuxYRvv6sotaKfm79q6Enp6JzlfICvlqbMFg3PGYRHhfy
         T4/bBSvpPrAOnS5tmioFZdtqW1Di85b5TU9NXVfYN6opIgyCIy7GzmZXyjXAarYOBTAR
         TqIILJHxA+ck+RwZ5ikeMJwX20mym39vRwedgoOLCC/KVxBFK+1DojWmo0dFoS3k4ocb
         dZ7M+1Bfl3Y4yr/YBRf61uxymYjuxew+M70kBhBo1DaR4/ts0UChdg//zfhcYFCZgv63
         alCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy3k3QU006yaoOz1NXa213YD9ZVtkyTeVCamwFEkkEQ=;
        b=np6vjKwUwbpyrVMBwDAecv+xQ17BBh8hE+29w5Lx6Gehtk6uR9vM0ktADiWULoH6lm
         7LJrrgRvDr0cGa3y9vYac5xD8SuvABOCv/o2LNvlZIVjGMF02a8am/+i2ros9yDg8q6h
         GiGEtahsmd78KkP96qJFSX0SYVyybI9KiO9ZFzqtTCwQsp16uXB27/EKs/1Wl3C2xX1O
         fdegKfhfx8CWKlx0kwCJ7j1hLpQLxtw/FHQpRs+DHwY43LOLu583njs9VSY9AA45Fbms
         obM7FL4kPLGXmcfNUNu0t6XE3jz0339hOF0odmVm6qzimsdyDl+VmBEuB6+gAffc5Yeb
         TG3w==
X-Gm-Message-State: AOAM531qIjXIe+jUJ6rxHgLVO3CNHW2b7t9CN8hIS6xC6h3K7ay6DApq
        IUY5ICx70wdQyh0UT/O6ULwmOJBe/2TkMA==
X-Google-Smtp-Source: ABdhPJxRW8Jrq4birgvuXpqlj5KN69JKSfYJk+5WtworHWJCvIaFslvj2wHgFA+NHNM7N8f+Lm7eEQ==
X-Received: by 2002:a65:688b:: with SMTP id e11mr9768874pgt.175.1605735428544;
        Wed, 18 Nov 2020 13:37:08 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm26575694pfn.190.2020.11.18.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:37:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] rpmsg: virtio: Add rpmsg channel device ops
Date:   Wed, 18 Nov 2020 14:36:58 -0700
Message-Id: <20201118213700.74106-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118213700.74106-1-mathieu.poirier@linaro.org>
References: <20201118213700.74106-1-mathieu.poirier@linaro.org>
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

