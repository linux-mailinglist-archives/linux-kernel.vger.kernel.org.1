Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D730C2A8A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbgKEWun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732369AbgKEWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:50:37 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:50:36 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so1507958plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zy3k3QU006yaoOz1NXa213YD9ZVtkyTeVCamwFEkkEQ=;
        b=xEHF+IdtyxLrW6VnhdCPAbD4EJgB83q0zDX+6njdEr17qs4Etp0e16mlcGpWH/4dau
         4EntVGtkN6skGXvAsj+SUvtCVQtKpwHjyAejAU7sV5U5LtUN51pu1HgOYj3ooT3U4FFA
         VxruqZ0j5jG1yWh/xx3l3U/L/URofGsFEIukUwkZfQ3dlEqEn2bHAMnRYXTlJ9FOIE9P
         UC1/ZGCtEj5kZOFJRlMkSN5rt0TN+M+RLtF0zS5qLVUuz/CMXI50uuJ7EovKoR65oQZR
         ZZISDfJ3KQ8O5HySrX7xA/PsOk/ZVjZ7SXjXmoYuQtgk2vWCpwKpgv2GrqbeHF+8YIyI
         ARsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy3k3QU006yaoOz1NXa213YD9ZVtkyTeVCamwFEkkEQ=;
        b=IIN7OpXYsLvNbm+IGIMxWeV6vSv5JuOnqyv3mYHbeZDkVDaLG8S8PEDqHSHhc3ZSta
         6bDD+sVrAl2ntK1TFndAVZ8JcQAiPPtR/W1PfvsHWI6Llcnk38eYgIVgHSFHhGlqoFK3
         Xgviq+9l+eJ6sr4tiFPcbkXrUvc8+TGchkzcma4nU43vlNnHscfIRsV/1vNvfvoArbpD
         7y4fc9UzurGoTrmR1UVzYl+guV45+7WsOfu8089z4wC9AEsuAtHaaefP4BBKw09vF9a8
         hEH3cIkv5hdTq28RiCpnQrUL4X/nIUgcRwpqCxcA1HEnYIJ7L5vcY14MctuiyN6mju2a
         tzfg==
X-Gm-Message-State: AOAM531pSH0/5QcjvVg6ILNqJxrUBeh6LIh8k1qfdMn8qhoT6yQdQPob
        aib0vVAXR3YwEukySi5PTFuoMg==
X-Google-Smtp-Source: ABdhPJxTGxzV2hRDbyOln23FHGguVoWuO8BReo5j8guE5a79fxfqwLe8kohSDSA1YidHLJVLw4fgLA==
X-Received: by 2002:a17:902:fe07:b029:d6:88c5:f5d5 with SMTP id g7-20020a170902fe07b02900d688c5f5d5mr4113701plj.63.1604616636573;
        Thu, 05 Nov 2020 14:50:36 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d145sm3854501pfd.136.2020.11.05.14.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:50:36 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] rpmsg: virtio: Add rpmsg channel device ops
Date:   Thu,  5 Nov 2020 15:50:26 -0700
Message-Id: <20201105225028.3058818-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
References: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
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

