Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4972A325F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKBRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKBRyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:54:08 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64844C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:54:07 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id v18so13766773ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQkch3MA8NUfknMqZNI4RlophsHH876j+HFe2EhGf3U=;
        b=lvBU5EAlIGuN1EshizyFdjWBOAwRTLHSx8Hnm1+B7oYHwCgwb0aRGAeGck3MBY8eVR
         h7pE45OZ/XVxxoWBcOWAhCDSCjcv26JrM6SBgEQNORvOqSSB8/cbHCVM9at2UtyKY+77
         4+/KR5DmshnZrmjAjZmI7zOPZUK0zR2VE8x5CG/SmslfEKBR7JiYZWNqMC80YZYfUU+o
         vRCVOdKn0YTLMc6Zm9Txrp++OCIwxFSaKvhnDPWYyuh3emo3coWYjD/K6UhwhwLwIxKv
         W/s8j+Xq/zDuEI/U3j3xbb5IIYnMOK/OZaRThMnhln9O4hXntLD/kL3gv05rYGj/Hpvh
         0/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQkch3MA8NUfknMqZNI4RlophsHH876j+HFe2EhGf3U=;
        b=ICr/dA3eh2gd5SMw7FvtWTrC26XE/X+vxngWRCdedDXGybQNiMehizfVmS2FLGBraM
         aloMu8m6F4Lj35Ol+lYCO91Hnp5xiynzr5gCHOdP2/zHVfz+qWvN+gU0p4sPNbEPlGCv
         NE7aEkOE1KSer7z6zjXAlCGEbLdVDfAz6kIpwfWAQihsP2IrW3FR7ySZegECZgSXcwBc
         Pep0iiYWbsjPEvHJgS+NIpedt9JiidwLPOEpXCA09GDq7pHsfNWWDOwOpp4rRBPo4zDN
         lg8esQ8WDloGHxYiSYT0+a4MI5MYjPLuj5nD1pqBUmzWsowo/fGzRD58GH4Vl5bnIP0M
         32DQ==
X-Gm-Message-State: AOAM533BPETlD2NXtUvcdg9FYx9Ed5rXlAEgUzDi6KcsHPwXl48Zu/33
        SOMIRG6nYxIWjgWKK+A0XDbqgw==
X-Google-Smtp-Source: ABdhPJzv9T7ZIZDuz9keLQgzwbFPQ0eIa/jDcVRDKUoVPuCSPFDiOSbQtmpxMU9VL7C82PcfjGwOHw==
X-Received: by 2002:a92:41cf:: with SMTP id o198mr11832519ila.262.1604339646728;
        Mon, 02 Nov 2020 09:54:06 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id r4sm11089591ilj.43.2020.11.02.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:54:05 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ipa: record IPA version in GSI structure
Date:   Mon,  2 Nov 2020 11:53:56 -0600
Message-Id: <20201102175400.6282-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102175400.6282-1-elder@linaro.org>
References: <20201102175400.6282-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the IPA version passed to gsi_init() in the GSI structure.
This allows that value to be used directly where needed, rather than
passing and storing certain flag arguments through the code.

In particular, for all but one supported version of IPA, the command
channel is programmed to only use an "escape buffer".  By storing
the IPA version, we can do a simple version check in one location,
and avoid storing a flag field in every channel (and passing a flag
along while initializing channels to set that field properly).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 16 +++++++---------
 drivers/net/ipa/gsi.h |  6 +++---
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 1e19160281dd3..178d6ec2699eb 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -747,7 +747,8 @@ static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
 	if (doorbell)
 		val |= USE_DB_ENG_FMASK;
 
-	if (!channel->use_prefetch)
+	/* Starting with IPA v4.0 the command channel uses the escape buffer */
+	if (gsi->version != IPA_VERSION_3_5_1 && channel->command)
 		val |= USE_ESCAPE_BUF_ONLY_FMASK;
 
 	iowrite32(val, gsi->virt + GSI_CH_C_QOS_OFFSET(channel_id));
@@ -1815,7 +1816,7 @@ static bool gsi_channel_data_valid(struct gsi *gsi,
 /* Init function for a single channel */
 static int gsi_channel_init_one(struct gsi *gsi,
 				const struct ipa_gsi_endpoint_data *data,
-				bool command, bool prefetch)
+				bool command)
 {
 	struct gsi_channel *channel;
 	u32 tre_count;
@@ -1839,7 +1840,6 @@ static int gsi_channel_init_one(struct gsi *gsi,
 	channel->gsi = gsi;
 	channel->toward_ipa = data->toward_ipa;
 	channel->command = command;
-	channel->use_prefetch = command && prefetch;
 	channel->tlv_count = data->channel.tlv_count;
 	channel->tre_count = tre_count;
 	channel->event_count = data->channel.event_count;
@@ -1893,7 +1893,7 @@ static void gsi_channel_exit_one(struct gsi_channel *channel)
 }
 
 /* Init function for channels */
-static int gsi_channel_init(struct gsi *gsi, bool prefetch, u32 count,
+static int gsi_channel_init(struct gsi *gsi, u32 count,
 			    const struct ipa_gsi_endpoint_data *data,
 			    bool modem_alloc)
 {
@@ -1917,7 +1917,7 @@ static int gsi_channel_init(struct gsi *gsi, bool prefetch, u32 count,
 			continue;
 		}
 
-		ret = gsi_channel_init_one(gsi, &data[i], command, prefetch);
+		ret = gsi_channel_init_one(gsi, &data[i], command);
 		if (ret)
 			goto err_unwind;
 	}
@@ -1962,17 +1962,15 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 	resource_size_t size;
 	unsigned int irq;
 	bool modem_alloc;
-	bool prefetch;
 	int ret;
 
 	gsi_validate_build();
 
-	/* IPA v4.0+ (GSI v2.0+) uses prefetch for the command channel */
-	prefetch = version != IPA_VERSION_3_5_1;
 	/* IPA v4.2 requires the AP to allocate channels for the modem */
 	modem_alloc = version == IPA_VERSION_4_2;
 
 	gsi->dev = dev;
+	gsi->version = version;
 
 	/* The GSI layer performs NAPI on all endpoints.  NAPI requires a
 	 * network device structure, but the GSI layer does not have one,
@@ -2016,7 +2014,7 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 		goto err_free_irq;
 	}
 
-	ret = gsi_channel_init(gsi, prefetch, count, data, modem_alloc);
+	ret = gsi_channel_init(gsi, count, data, modem_alloc);
 	if (ret)
 		goto err_iounmap;
 
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 2dd8ee78aa8c7..cf117b52496c1 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/netdevice.h>
 
+#include "ipa_version.h"
+
 /* Maximum number of channels and event rings supported by the driver */
 #define GSI_CHANNEL_COUNT_MAX	17
 #define GSI_EVT_RING_COUNT_MAX	13
@@ -20,8 +22,6 @@
 /* Maximum TLV FIFO size for a channel; 64 here is arbitrary (and high) */
 #define GSI_TLV_MAX		64
 
-enum ipa_version;
-
 struct device;
 struct scatterlist;
 struct platform_device;
@@ -109,7 +109,6 @@ struct gsi_channel {
 	struct gsi *gsi;
 	bool toward_ipa;
 	bool command;			/* AP command TX channel or not */
-	bool use_prefetch;		/* use prefetch (else escape buf) */
 
 	u8 tlv_count;			/* # entries in TLV FIFO */
 	u16 tre_count;
@@ -149,6 +148,7 @@ struct gsi_evt_ring {
 
 struct gsi {
 	struct device *dev;		/* Same as IPA device */
+	enum ipa_version version;
 	struct net_device dummy_dev;	/* needed for NAPI */
 	void __iomem *virt;
 	u32 irq;
-- 
2.20.1

