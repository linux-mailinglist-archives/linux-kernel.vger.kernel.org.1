Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C35292F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgJSUeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgJSUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:34:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a1so460713pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxZa9s3oSSL/Q1unOxCAuuw1fDc8JLZ4khG8SJugP2E=;
        b=BbUe+t7x9QiSM2wpjhvSiX0oaQ0NFzCemOK7bqR2s5f8nomLdRlzd84Xqw6YH/uuUC
         3PNs6y0vpnITzWrOnf3S8Ihll48mN25ii0W2s4r2rDa5Byh7LoYCLRyeYknMo9WnhdCp
         ICYZsAQC+dKkjOTCVsEDGS73haXtmhs3QFPIPmLS0GcK5Varu3XDSvIQrvX1ObPX4+Qm
         I/7CZG2yWT2Ud8XlEo/XviX/SATL46Y0pNJ3JjtFlky+PEbytKWDFg6cygdumg4KLlD+
         jp2Z3EPM3RhwEjvJ3ee8nOYrC2wQ6y+O2i7QRcxZ17FNDVMa4J3darSg2S+Jwm/CqWSF
         N8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxZa9s3oSSL/Q1unOxCAuuw1fDc8JLZ4khG8SJugP2E=;
        b=oxnmiu3rJ42Txe8iLAtMuLOAuA+tfVAhxLZKtUx5ft5ytDH5bn2I4eDaDMfhQWDhH/
         FlL9qVKAdCmdAWV4ruVfMI5VzsXClMBYWgH7kuUHv8REwjVE/QQYxNcy91LYX/yqwSrS
         4gbVWFmbxLpPaQFLPGZB9YlkXm1KqdU3qG0mPpzVImYyzA6V4IM9mrqq+PE8fin1nIIF
         WYULyvY+mjVV88NNNxnPByFA2eqqSgpKBzReLR5WvvQOOu5cjdxBT/RUPSCVvbUGI0w4
         Otz/962zdBUSvDG3VnicnoF5hLad9N7+mBKwgUfF0xBSfNGDg7CfkqEJr5332a9VcTEE
         QaYA==
X-Gm-Message-State: AOAM533Y/HdgAxmILlbu6LJi4U47NngADT6gfxpSoMRqFUqNr1fxDXYt
        sx9vGFYYxTYG6pXZbKtC2AmoKw==
X-Google-Smtp-Source: ABdhPJynie4UOgKOk6P/3MfWrHwx2yFlBM0Atb3bHL8a31IphcDbEWiC+pGoQhp9f0YLPdTh59yZ/Q==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr1176017pjb.137.1603139685441;
        Mon, 19 Oct 2020 13:34:45 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q123sm631847pfq.56.2020.10.19.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:34:44 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] rpmsg: virtio: Rename rpmsg_create_channel
Date:   Mon, 19 Oct 2020 14:34:34 -0600
Message-Id: <20201019203438.501174-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019203438.501174-1-mathieu.poirier@linaro.org>
References: <20201019203438.501174-1-mathieu.poirier@linaro.org>
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
index 1f8154ee1e90..bd5baa0dfcfb 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -360,8 +360,8 @@ static void virtio_rpmsg_release_device(struct device *dev)
  * this function will be used to create both static and dynamic
  * channels.
  */
-static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
-						 struct rpmsg_channel_info *chinfo)
+static struct rpmsg_device * __rpmsg_create_channel(struct virtproc_info *vrp,
+						    struct rpmsg_channel_info *chinfo)
 {
 	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
@@ -837,7 +837,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
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

