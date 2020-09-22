Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94527371E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgIVAKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgIVAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C53C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y1so10444446pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DsTBzQVhNY369Insfr5rXAu0ypsKEebbLr2rslQaLzY=;
        b=qLAPqGaHTnCaB6cYxJdNHQJrH1Fc3RZ3EuL2TAqpYtuu4ulTy6Dgjy/8BLCYkaMHRv
         QYOIw9dtogpkvN9q+5t0WsMIGV/H5W/7qEft/xU8cs48tUiTzlEY7JnICqY/d8XZocrs
         kpbfzWtv44TKHxaRurzkZ53FrjpLo3llirw6COXZOm8kv6nXpq5Hr/YU7Z1KbFzZtFvL
         rsvpVuaflv8vR157l6TIL/dapxxb/msR2kVl5wu6tpMRofbZbiGQ1ODcNNoqYCwfD6+L
         wdX+FprrsbTddSMVdem6ahSWaySeDBeFCwwFJ8eYcc2jRBVJ/335leON/8WbsrAGwKUT
         RiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DsTBzQVhNY369Insfr5rXAu0ypsKEebbLr2rslQaLzY=;
        b=MsnDG8+cRfegKaCk4CvcE84nem4ZHeChNDzGe/P2N2N5NRUTAQPW1/o9KEZIbrYbFp
         qXX7gae57/YGhS7QmankCpyRvd02yyDo5mFc1maJAfotjJNm8CO0hjyW4d03a9dn9Vuj
         upE9ibZBIrjmlcbPZz+c8d+EpTIVymZqSUoeZ7qii8KXwJUDatShMvFFHr0heOBuW2eX
         dMSUxrXEFfWgSruY4hwy0Qqkbvbc93N773eOvGmmEu6QU0raaHe54YbrVhqSIFc0XOAl
         TJxf2275vfAKtfCI1nC7wtuJLWepcaPOl/7ZBI8w6oInnyy0H5xyYhifS4xbQCgRsWq6
         3qGQ==
X-Gm-Message-State: AOAM530e5ynSvxulAutI3wKVlgqEOqTEHsGoA69eomWyJz/FVg3/4ZOx
        naue8UJutdCiSIS4acC8wbIU2g==
X-Google-Smtp-Source: ABdhPJzdo1jbYZQjvkyyMUAzyyQAOghwaAhDiinrD3Wg5fBfoOHKlKk1lPGC/VC2Y2hafTX2LSv5RA==
X-Received: by 2002:a17:902:758b:b029:d2:29fc:c841 with SMTP id j11-20020a170902758bb02900d229fcc841mr2220526pll.39.1600733405481;
        Mon, 21 Sep 2020 17:10:05 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] rpmsg: virtio: Add rpmsg channel device ops
Date:   Mon, 21 Sep 2020 18:09:53 -0600
Message-Id: <20200922001000.899956-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Implement the create and release of the RPMsg channel
for the RPMsg virtio bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
[Moved function declaration above struct virtio_rpmsg_ops]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index e8d55c8b9cbf..e87cf0b79542 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -181,6 +181,9 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static struct rpmsg_device *
+__rpmsg_create_channel(struct virtproc_info *vrp,
+		       struct rpmsg_channel_info *chinfo);
 
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
@@ -285,6 +288,25 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
 	return NULL;
 }
 
+static struct rpmsg_device *
+virtio_rpmsg_create_channel(struct rpmsg_device *rpdev,
+			    struct rpmsg_channel_info *chinfo)
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
@@ -377,6 +399,8 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 }
 
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
+	.create_channel = virtio_rpmsg_create_channel,
+	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
 	.announce_create = virtio_rpmsg_announce_create,
 	.announce_destroy = virtio_rpmsg_announce_destroy,
-- 
2.25.1

