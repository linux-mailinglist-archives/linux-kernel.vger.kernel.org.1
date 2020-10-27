Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0EF29C40C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822801AbgJ0Rwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:52:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40650 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822778AbgJ0Rw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:52:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id w21so1350408pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=807sOLdqwgnAyj71IoZ5gIos6+0azuDGDEd483PBBLI=;
        b=ma8MrtpKWnvLHz9JdBhZmp3Bb1x9dZ9VDEljydi7sbfA58vIxGmi/rJR7xGJh34A9t
         2di7lSTtL/p3h3Y/vNXK0DfOBD5QUj6IG9C2+TINopx6/RGrbnl5/4WV+j7j854Gkwyb
         FOTbHpvQq/wJx0NGKTTbcpVF0N5s5omoG3hBW3EpDj3kmtqO0qmdE3CdgaFBFF32nDi+
         wIXADSibPCcXIYrScuFOZa75PAQc6XD/zzEjawwyhJjiB5UOAWbu5RVzPOiiezftYU1j
         XOevQ22B+EjBFLiNhfVaQPU87ADom08sCBlAyB+pabn6BhRT1jSuag4YTUIhqC0YNc6k
         fjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=807sOLdqwgnAyj71IoZ5gIos6+0azuDGDEd483PBBLI=;
        b=BZDaJnAiK547AiNKKl/BO3wb83o5P06gBbhW9zyWXg95MbEFjDY+MQZF2v1QlFd9/q
         jPrHfw84OLm/lu9Lr/x20kC5CJJZhwIbw9j9KD5i3fc4AM07Yq8JhIbpaLfrO15+t7Hn
         BYPnjiHGAd0hHjR7qp+ZG4KXjNWII+pNP//4Lci2ErA4YppV502yqblWiIjhmUW0EFtO
         K9WemFUNXnwyjm11hU0kDDf5D8AqG9eBeazSl79riSqpe1JSM5bl8TPEwxUWDOXGVGxu
         AsVkGqPfzRmf9N+yA2q7fXDtTmK2ZWKx1MgaYtR7bbwLw+gEXpYb23wGlw5l6FByEbo0
         BgmA==
X-Gm-Message-State: AOAM531ZwhR4ikdsITdbsS2ipwZaH9Xv92rHv0+6FpXjbVmCJDXfvDGH
        PnRZnSVo0OEBtqh7nkgWzdpblNkpSq4jvg==
X-Google-Smtp-Source: ABdhPJw6GaFY7swybF+dTqPUmiaT1hhGvUuDyS8QpPNK2sJv0otV705hGsfD2LEhNN0dgDxs97dxrg==
X-Received: by 2002:aa7:9192:0:b029:15c:ebd2:971c with SMTP id x18-20020aa791920000b029015cebd2971cmr3489331pfa.33.1603821147934;
        Tue, 27 Oct 2020 10:52:27 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm2761225pgl.57.2020.10.27.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:52:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] rpmsg: virtio: Add rpmsg channel device ops
Date:   Tue, 27 Oct 2020 11:52:16 -0600
Message-Id: <20201027175218.1033609-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
References: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
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
index 01f05bc570a4..ff8afee807cc 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -151,6 +151,8 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static struct rpmsg_device * __rpmsg_create_channel(struct virtproc_info *vrp,
+						    struct rpmsg_channel_info *chinfo);
 
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

