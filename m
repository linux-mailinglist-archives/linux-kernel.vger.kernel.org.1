Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7CE273722
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgIVAKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgIVAKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5DCC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so10445949pgd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjxi5jPY+5fiGib9aemaW9NnwRUiNwpEBOAwlpbjCi0=;
        b=EjV9H6eR89HJ++cASGIFensX72XSXg+IFP9M3mKjHvsMy3f146k9UUilXnSUfmEiVc
         3B325WaWi9ZUSOzRSmL6PsQA0em7gIGb3Fja199BBBNTDoR796qUsfHPwZh1dpHoNwi0
         jzxtxb8+6+kDkMhJzRys+ogIOrlyJXM2gbg2kCfWmY90L7kS7zxaSpTNdRBHv11cK/7V
         9BksIdUFNr6OCaATgwFpSxGMHGSX1DLdWEzT4aliit/3g7qfid6p+xAnKudJJQs9nuCk
         EHO8IsyPDrKZ/J1cZrzTPqBHChS6dDjkPH7iFWmr2xPcVA4LfpVKXtc0qjXK7Dc1uuOC
         3Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjxi5jPY+5fiGib9aemaW9NnwRUiNwpEBOAwlpbjCi0=;
        b=Bgbli8Dk88GnvQFDrhynG9G27OBcMf5KgUEijrw+yBbRibINarR6x8yKxz7dqX6phQ
         FjXOwp26sg+qNmrINa5y05kF0l2Lb70cpyLEFU9gYCmyIX5sxSR7uTOMOvenstnGcGQs
         04/KLcqkVI2C00pEyBafBGbVXTXkUt8XXuzLWNuyxeayBYk9wLC/J9cBlKDpkO2EB5vQ
         c/pWgshxKTz4XzshLIeY6Ru8NUHNC6yrd0Kuf3wNM9aOg1QSpRoFAQPlm0sPUfOlpcU6
         n7+5n5oXKO4Ye0wsvqtFJKR8r/wGSkCkCEYSdrSweQm9H3kIEWShv8ft7pia4HC4985c
         h9jw==
X-Gm-Message-State: AOAM530N+w70H+YlA6R5bhtS49vQjz8P+A8UBjUyP4ra/8tTlF9/ycaw
        jK7+35nez2SLZhZ0OfR5U0kC5ofGixfjFw==
X-Google-Smtp-Source: ABdhPJxpCINuRSuKV4NEjLVkGeyuI4+z9LCyALw01vOZ954g/7R2EFYevIRMs05UPRRJxSJNJa/Orw==
X-Received: by 2002:a63:384f:: with SMTP id h15mr1572345pgn.144.1600733413027;
        Mon, 21 Sep 2020 17:10:13 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:12 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] rpmsg: virtio: Make endianness conversion virtIO specific
Date:   Mon, 21 Sep 2020 18:09:59 -0600
Message-Id: <20200922001000.899956-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce rpmsg operations to make byte conversion specific to the
virtIO transport layer, therefore avoiding the protocol code from
being aware of the virtIO transport specification.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 1c0be0ee790c..15cc383a85cc 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -157,6 +157,38 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
 	return NULL;
 }
 
+static u16 virtio_rpmsg_transport16_to_cpu(struct rpmsg_device *rpdev, u16 val)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+
+	return virtio16_to_cpu(vrp->vdev, val);
+}
+
+static u16 virtio_rpmsg_cpu_to_transport16(struct rpmsg_device *rpdev, u16 val)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+
+	return cpu_to_virtio16(vrp->vdev, val);
+}
+
+static u32 virtio_rpmsg_transport32_to_cpu(struct rpmsg_device *rpdev, u32 val)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+
+	return virtio32_to_cpu(vrp->vdev, val);
+}
+
+static u32 virtio_rpmsg_cpu_to_transport32(struct rpmsg_device *rpdev, u32 val)
+{
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+
+	return cpu_to_virtio32(vrp->vdev, val);
+}
+
 static struct rpmsg_device *
 virtio_rpmsg_create_channel(struct rpmsg_device *rpdev,
 			    struct rpmsg_channel_info *chinfo)
@@ -268,6 +300,10 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 }
 
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
+	.transport16_to_cpu = virtio_rpmsg_transport16_to_cpu,
+	.cpu_to_transport16 = virtio_rpmsg_cpu_to_transport16,
+	.transport32_to_cpu = virtio_rpmsg_transport32_to_cpu,
+	.cpu_to_transport32 = virtio_rpmsg_cpu_to_transport32,
 	.create_channel = virtio_rpmsg_create_channel,
 	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
-- 
2.25.1

