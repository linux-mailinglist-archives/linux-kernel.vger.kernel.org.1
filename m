Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244292A8A24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgKEWvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbgKEWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:50:35 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1099C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:50:34 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id z24so2401344pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0V+Pj0ilaPOi+EzL05tF5APIQBX5vdWZzPetY3Iqd8=;
        b=iXSJkj7cHwi+eyj+HvmVvAtHEUJFtbp2KmLGkOLKuWng1OQwBkkROIXC/oZRxV5NHe
         cwWxJNaPmAfkA8IQFiQs8ZZiuh2g5ikiy0gneq8kqHe3jqpc8PtrTqffBzzi4Yn7UylT
         4f+RPTLzoolwnl5A3SVezlHur4yDrz0B+f3OpVuHbWSWP9Fw5qa9lw3ef2FOCO+NdSTu
         s94EcLzKn0f8go3yDPGJEpOSyhNjNARSMFkZNaSOICLtJkuguuQQKJICRYePKMR8biXp
         lmu4rTbHtd8H5WgEobDGaWZXcM4f4gkcg67lpgYCzO3u/7b44Y5mplLhsKLdTVDotzQV
         TXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0V+Pj0ilaPOi+EzL05tF5APIQBX5vdWZzPetY3Iqd8=;
        b=A/4cUUvWmiRl2R3q+yTYzSFuYjcIJkGMoNZHbz8OrWTvOwta5mFV6jSGUbyWzIP8VX
         71wAq0eaS59Q0YvfHh2ioxxAVp1mQp3avz1yMoz2+Mwy5gqnH2GymxKT6Vh0pwu7lmOT
         A1oB1Z1wqUAcc/HOevPp9W82axP8FchgHtWrSv+qDKE/sD7rRi0Y5EXdS1k+mnkQf/7M
         Kcn0C8/rOTlIYR9+nGp6UYuFIYpDtJS2Cx7igst8qjjmWPPOPKUxyQjmVIvj5HsCEozL
         DP4XTk7BTo7qHmf3E9eOdk6cA3QmupDkCtKi9WESaFO2C4L8CxzmDDdGEGDl3WysshJv
         cgkQ==
X-Gm-Message-State: AOAM533KjyNVJqLoSgjpAso6RkgHwXj8NWP14ri0tVyAhnhy+J68pzyy
        oLWeeb26pEehP8FroZ/iFBpU3Q==
X-Google-Smtp-Source: ABdhPJz/8J+fcHR3apF+VVLXHgBWjXklC/LPwVsX5Js28a9REdw2pvF4CKnuzVcFAcIX5vzuVvC0LA==
X-Received: by 2002:aa7:86c9:0:b029:18b:b0c:53e5 with SMTP id h9-20020aa786c90000b029018b0b0c53e5mr4510758pfo.57.1604616634420;
        Thu, 05 Nov 2020 14:50:34 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d145sm3854501pfd.136.2020.11.05.14.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:50:33 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] rpmsg: virtio: Rename rpmsg_create_channel
Date:   Thu,  5 Nov 2020 15:50:24 -0700
Message-Id: <20201105225028.3058818-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
References: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Rename the internal function as it is internal, and as
the name will be used in rpmsg_core.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 20d0cf909bea..2253936593c5 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -365,8 +365,8 @@ static void virtio_rpmsg_release_device(struct device *dev)
  * this function will be used to create both static and dynamic
  * channels.
  */
-static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
-						 struct rpmsg_channel_info *chinfo)
+static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
+						   struct rpmsg_channel_info *chinfo)
 {
 	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
@@ -842,7 +842,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		if (ret)
 			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
 	} else {
-		newch = rpmsg_create_channel(vrp, &chinfo);
+		newch = __rpmsg_create_channel(vrp, &chinfo);
 		if (!newch)
 			dev_err(dev, "rpmsg_create_channel failed\n");
 	}
-- 
2.25.1

