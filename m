Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952E32C6315
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgK0K2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgK0K2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:28:53 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so4684605wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3Z8qkthDjoiKRU/rVN2GJeEls8VONHf+qQQu2fW8mE=;
        b=ecdwsE2XJkWaO8XbTyw7Bb/vFfClhTgc167h4cwmvSDtxxInoFNsY3R/rZs4NCaakr
         ulEXTwKtvziPrAioo07eZUqK1kL8HuM7J4fAGXb0N7O7kIkhvXLlQD49wm+6Da1etw6Q
         D7BmJx5leILMv6I3C8mo1CFs+M11xuunK1o3ApJHTnlIJz3twJjdS2x/zsIaRWXHvfOK
         Jn8asahUhkwXUPkeQxulx7JThGN9RgwRhp2BC1Vre0ISEilzxWNQOSZsSeIR3Zi3a7T0
         lOIFvYqOpl1xOx9bOKNeaJlju/yddg9Kl4sJ25Vvf2/SMVu9X/d9NtcEGbytKu8SIO2N
         dkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3Z8qkthDjoiKRU/rVN2GJeEls8VONHf+qQQu2fW8mE=;
        b=g5xwAlF/G/beNoUBEt5ehFgddEMCBZA+HIrQvFqzc2B6wbrpg3snKZnUcc/tdatzyV
         mP6DK03RmyvHg9HG/+hm2h1G9cR+4eyU6d+eyskudy79DPo7x0W9hZ5pJBenMLcAKa4a
         plKfr+09/ZdsmeWb5Rf7WJh96FyvCKQvvog/PdXCv02mstzfsvkb1RWLq8w8ijuQW6kT
         niRQBJoAzZMn5BB8Ov7jDmtGLOK/CtPnisa+BYjF93FCUD1zwL521pFteKhoFrE/QQlh
         S5LcMQbMnADrDdP62gkCeT1nwdg+6itEmFXosqsigkDC+pTafMfJFzuGKO5Up73NKuSp
         QlzA==
X-Gm-Message-State: AOAM530vpjpnSPso+oZvWcSRdWUnAztkZWcMcKr+n0BtEnruvnY64vhH
        82iSmuP5cEOF9tK7NNFPigAscQ==
X-Google-Smtp-Source: ABdhPJxZ7zSI1R6/IFYRYkLkZjGAOmwzA8MsOw9ShK1uuqob5GXkgUbQ29tQhmFGRgcp/yZvoMyM8w==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr670850wme.5.1606472930505;
        Fri, 27 Nov 2020 02:28:50 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d8sm14073051wrp.44.2020.11.27.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:28:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] nvmem: imx-ocotp: add support for the unaliged word count
Date:   Fri, 27 Nov 2020 10:28:37 +0000
Message-Id: <20201127102837.19366-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
References: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When offset is not 4 bytes aligned, directly shift righty by 2 bits
will cause reading out wrong data. Since imx ocotp only supports
4 bytes reading once, we need handle offset is not 4 bytes aligned
and enlarge the bytes to 4 bytes aligned. After reading finished,
copy the needed data from buffer to caller and free buffer.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7a1ebd6fd08b..08f41328cc71 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2015 Pengutronix, Philipp Zabel <p.zabel@pengutronix.de>
  *
+ * Copyright 2019 NXP
+ *
  * Based on the barebox ocotp driver,
  * Copyright (c) 2010 Baruch Siach <baruch@tkos.co.il>,
  *	Orex Computed Radiography
@@ -158,22 +160,30 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 {
 	struct ocotp_priv *priv = context;
 	unsigned int count;
-	u32 *buf = val;
+	u8 *buf, *p;
 	int i, ret;
-	u32 index;
+	u32 index, num_bytes;
 
 	index = offset >> 2;
-	count = bytes >> 2;
+	num_bytes = round_up((offset % 4) + bytes, 4);
+	count = num_bytes >> 2;
 
 	if (count > (priv->params->nregs - index))
 		count = priv->params->nregs - index;
 
+	p = kzalloc(num_bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
 	mutex_lock(&ocotp_mutex);
 
+	buf = p;
+
 	ret = clk_prepare_enable(priv->clk);
 	if (ret < 0) {
 		mutex_unlock(&ocotp_mutex);
 		dev_err(priv->dev, "failed to prepare/enable ocotp clk\n");
+		kfree(p);
 		return ret;
 	}
 
@@ -184,7 +194,7 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	}
 
 	for (i = index; i < (index + count); i++) {
-		*buf++ = readl(priv->base + IMX_OCOTP_OFFSET_B0W0 +
+		*(u32 *)buf = readl(priv->base + IMX_OCOTP_OFFSET_B0W0 +
 			       i * IMX_OCOTP_OFFSET_PER_WORD);
 
 		/* 47.3.1.2
@@ -193,13 +203,21 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 		 * software before any new write, read or reload access can be
 		 * issued
 		 */
-		if (*(buf - 1) == IMX_OCOTP_READ_LOCKED_VAL)
+		if (*((u32 *)buf) == IMX_OCOTP_READ_LOCKED_VAL)
 			imx_ocotp_clr_err_if_set(priv);
+
+		buf += 4;
 	}
 
+	index = offset % 4;
+	memcpy(val, &p[index], bytes);
+
 read_end:
 	clk_disable_unprepare(priv->clk);
 	mutex_unlock(&ocotp_mutex);
+
+	kfree(p);
+
 	return ret;
 }
 
@@ -447,7 +465,7 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.name = "imx-ocotp",
 	.read_only = false,
 	.word_size = 4,
-	.stride = 4,
+	.stride = 1,
 	.reg_read = imx_ocotp_read,
 	.reg_write = imx_ocotp_write,
 };
-- 
2.21.0

