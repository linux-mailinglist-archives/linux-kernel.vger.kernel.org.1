Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8A2B96EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgKSPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgKSPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:41 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF95C061A4B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:52:39 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i12so4700499qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WK7dbS/2WIcf7lppGbM/SVGTBQiYrXQBAamVJT++jdI=;
        b=Ietn0vzuyHymF+fGLpMED5gPejOJx5P9PsMQ9QZfIf/wzyM1FEyilGjb3Dq1VORSyu
         IcqI45ReNY1xEI/igFPRVwVYyhZ8mdbCKPvufR3ia25oIq2M9rB9vjloVAWzsd83//2P
         XF1VGcmFA2KVWMgvGLfHGSaBBgn0NiLfpDBO9SnALlYew2c5xzQVv2I7bO+VFyj6pfGI
         CZ6v49PaCRj2t4atGj5HcPptxxaunnlvtR5YnUF3Tl1QPDak7R/+0RafesR9OKED/aX5
         92VThVXyQyW79fWALN/m0wrLttVwkmsh4dvP7mJ2vwlcTvfTbLIbXPqh4PRq2rQ/crr9
         PlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WK7dbS/2WIcf7lppGbM/SVGTBQiYrXQBAamVJT++jdI=;
        b=J6Lok/GrsGFQ9LDLeCC6TCKRzEEA5F2nAamVDGLmZyD1AovMqgyxjyAZ1VIE7P4FY2
         mg27b/DqBSTHwG+YcyxWY25emJqqABtzL1v+xx/AZZpDhkDnEM2Ssa+Yz9Ob9khgucRB
         Tl+pM1jQKtfaZus72xShONg//tksvMNMzQ/2teYaPE9134m7gze1VQqolHgqG6Mujdqy
         YN1qcJoLS3hPPBPC+GPOaJxM7Rbp6fuZBx3r2RlMByjignpgds9g/vN+BDFusRtyxkMo
         rqXiB8arNRtny4hXFyMgweUV71J3J6iZyYI0GTS5GdzS6wEoaxe4m5UMunrHbbKicico
         PEjQ==
X-Gm-Message-State: AOAM5304JSPugmulMfDppCC6br/lejef3FMLIPzC0iS9wdnZP0175aIO
        wjB5SsXkQbI44SL4v6GRl3///Q==
X-Google-Smtp-Source: ABdhPJzf8dTp0eeFb0ZcGPAqgK0gpZPZnoFCsXJb4OzIL6xCMGCHwTQWbO9Cvc8LdVyi5IZuS3G6sg==
X-Received: by 2002:ac8:ec8:: with SMTP id w8mr6998038qti.371.1605801159080;
        Thu, 19 Nov 2020 07:52:39 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g70sm127290qke.8.2020.11.19.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:38 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [Patch v2 3/6] drivers: crypto: qce: Enable support for crypto engine on sdm845.
Date:   Thu, 19 Nov 2020 10:52:30 -0500
Message-Id: <20201119155233.3974286-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119155233.3974286-1-thara.gopinath@linaro.org>
References: <20201119155233.3974286-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support Qualcomm Crypto Engine accelerated encryption and
authentication algorithms on sdm845.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index ea616b7259ae..67c3ca13e55b 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -160,7 +160,21 @@ static int qce_check_version(struct qce_device *qce)
 		return -ENODEV;
 
 	qce->burst_size = QCE_BAM_BURST_SIZE;
-	qce->pipe_pair_id = 1;
+
+	/*
+	 * Rx and tx pipes are treated as a pair inside CE.
+	 * Pipe pair number depends on the actual BAM dma pipe
+	 * that is used for transfers. The BAM dma pipes are passed
+	 * from the device tree and used to derive the pipe pair
+	 * id in the CE driver as follows.
+	 * 	BAM dma pipes(rx, tx)		CE pipe pair id
+	 *		0,1				0
+	 *		2,3				1
+	 *		4,5				2
+	 *		6,7				3
+	 *		...
+	 */
+	qce->pipe_pair_id = qce->dma.rxchan->chan_id >> 1;
 
 	dev_dbg(qce->dev, "Crypto device found, version %d.%d.%d\n",
 		major, minor, step);
@@ -261,6 +275,7 @@ static int qce_crypto_remove(struct platform_device *pdev)
 
 static const struct of_device_id qce_crypto_of_match[] = {
 	{ .compatible = "qcom,crypto-v5.1", },
+	{ .compatible = "qcom,crypto-v5.4", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.25.1

