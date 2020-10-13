Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC84E28DD20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgJNJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgJNJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73CC08EA7B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so826046pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ycxUYKRLNQGbeCvnapexQBRiRUEcK7gRrJqEvEJwNPU=;
        b=DReAvGur7O904kV9bwo2L59Z3mvZRc0h595iFLuMXVnNIjg1reLDaqCfs1ExYnuL0a
         xzkyYZMfg3qkxDFHouotKCI/T+UEp/ihm12qm1sAtj/fTpzqId7uRrTPLxUUbWZ38517
         kdlIyO1xazLS69mHFCgSkWzuN0L/Az+SXZWaECt3NlRNN7jPH5pN2YVo3/oiQ6xAdR3P
         lxMJnhTu4FYgdmfecWxDNAkdXxToBCSW+tT5OK7d148gbNeZe0zmnELBGHx8BskptLpS
         C2PBZY4tmJsGur/D6IqtnRi7fjyV3gFOMZAjEU7oqqi8URV1XsQHhkYRP0D96WqTN2AJ
         crHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycxUYKRLNQGbeCvnapexQBRiRUEcK7gRrJqEvEJwNPU=;
        b=UycVGQxT9omyUVZt2bXUckgJyWTFtPgnrnNfPExWNIGLf2p/PunIchTh72PRTvsgKX
         SpVQrsq8VVJjIVQ2aU+Rbm/SoS+UgtAmABCwNN7N8dyOk5edWGbY0jcOVclf3lr8AXYR
         wxCtXTty21aCB7Niwo3EgkFFNZEOlxZG/B0QpFGzowE5Ac3A9zXXt8HgKf7zOHSQNY+N
         wJ3IYHwTmMG3zOnfZz7rg38hCZkS4I7jh3YYVoVgWqXyK2Ly65V7nJKEwlJCJINmq0sz
         xP0XuVmIEXZ/SrhwfaJiV+7oAQ5OvKDpGE2Pu2ZP99Wlo/t8dB9KU/9NafyeK4fE6lXY
         jwdg==
X-Gm-Message-State: AOAM530pDhk1GEo3keawC1bu5rBLJvU49JIpS5+RfOPgcMDcbIM5RmsG
        n84q7WFEYCoqfiXpGPgJ/UhCtQ==
X-Google-Smtp-Source: ABdhPJxgfavWpmuypj/8H9ULQUnlQNTptm5BF7sI12I+BEGDSeAMZy/ayCjKlengG3wmmLGtDjIMJg==
X-Received: by 2002:a63:77c4:: with SMTP id s187mr1487622pgc.303.1602631529987;
        Tue, 13 Oct 2020 16:25:29 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b8sm791871pfr.159.2020.10.13.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:25:29 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] rpmsg: virtio: Add rpmsg channel device ops
Date:   Tue, 13 Oct 2020 17:25:17 -0600
Message-Id: <20201013232519.1367542-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
References: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
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
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index fca982b61c3b..1488b9ddc18d 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -122,6 +122,8 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static struct rpmsg_device * __rpmsg_create_channel(struct virtproc_info *vrp,
+						    struct rpmsg_channel_info *chinfo);
 
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
@@ -234,6 +236,24 @@ static bool virtio_rpmsg_is_little_endian(struct rpmsg_device *rpdev)
 	return virtio_is_little_endian(vrp->vdev);
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
@@ -327,6 +347,8 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
 	.is_little_endian = virtio_rpmsg_is_little_endian,
+	.create_channel = virtio_rpmsg_create_channel,
+	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
 	.announce_create = virtio_rpmsg_announce_create,
 	.announce_destroy = virtio_rpmsg_announce_destroy,
-- 
2.25.1

