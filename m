Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4521FDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgGNTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgGNTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9DDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so2102591pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SrIZnU0YUH2iCVYi8lfRsLpOXFKIkq3s3vt32Psx5U=;
        b=P0ch2eC3VgDErn1SdkPgrA9O7vWzyNVF0+/CuZx2zr1RX7beEuad1ItUQ5Yk2e5Tao
         6WMZilyJm1rve62WyzDHnV4/ifH/0Cco6TmOVarRcmIFSoqvvgGqC5j/jhxSx06Bg4x5
         xb3Ct+S+br+7+Vt1SY1mUy/wTOCIaP4R6tuwcmH10qWeCcju+YZUBG7R2CDMJF5YVIe1
         tizkJ58r59ks+DJ/YW9winL4TuT/SOEdwEk+LuZKJPAaWrYFA/WiJ+PVTz4E+KRHEyyk
         3rQchJzqCJhucGogm+J7pdhCTnDYJ9As1g0yCTWFRKjU1u0jdmIzRNX9gas3L1jKXN3R
         rauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SrIZnU0YUH2iCVYi8lfRsLpOXFKIkq3s3vt32Psx5U=;
        b=n/rXQqtjkohk7tjAVFxs6oqX40/D9Su+gGK/p95n3xbNFmPwBi+DQfWi8LolU71YoX
         aXns5RpsjZaePrZmSg1urCoDaFje9kblIOwsnORPkz28VgYsiRv8/7s3stmVA+ozkb9a
         +PxDB8HPrQgcekVGUvfQm+6KjrVqI4iCF/YRuSLTnKIa0aQz5y29kPw5pLI/01FCgISt
         07woDRu7MJhj8h578OypQM0c6CQxVi76EicE/z0XXyHfbGIkOa87IPexytMJmqfhnc2p
         gNBVOHAStmavwUWBp4IcogMQl4mWU3kOCjGoLAL3WAV9H/zalLvPZBCndQw5NYTz/KE7
         7kXA==
X-Gm-Message-State: AOAM532Ns1faowYzl2P0R1E4nF9+SmGm5OWQi9y3hokelacjX14M7pNZ
        THDkYbSkBdKoqe7EhAUsv4BuxQ==
X-Google-Smtp-Source: ABdhPJyrbkdEAbkYD3wAsFkm3BMUneo+jO6xqtT8iXbLf4XSKSzO+p7LXqFG5L9YvyDhC0FuDmMaVA==
X-Received: by 2002:a17:90b:1246:: with SMTP id gx6mr6463225pjb.85.1594756244300;
        Tue, 14 Jul 2020 12:50:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/9] remoteproc: Refactor function rproc_boot()
Date:   Tue, 14 Jul 2020 13:50:32 -0600
Message-Id: <20200714195035.1426873-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_boot() to properly deal with scenarios
where the remoteproc core needs to attach with a remote
processor that has already been booted by an external entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ad500c291d5f..caea920ce4b8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1494,7 +1494,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
  */
-static int __maybe_unused rproc_actuate(struct rproc *rproc)
+static int rproc_actuate(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1905,24 +1905,30 @@ int rproc_boot(struct rproc *rproc)
 		goto unlock_mutex;
 	}
 
-	/* skip the boot process if rproc is already powered up */
+	/* skip the boot or attach process if rproc is already powered up */
 	if (atomic_inc_return(&rproc->power) > 1) {
 		ret = 0;
 		goto unlock_mutex;
 	}
 
-	dev_info(dev, "powering up %s\n", rproc->name);
+	if (rproc->state == RPROC_DETACHED) {
+		dev_info(dev, "attaching to %s\n", rproc->name);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto downref_rproc;
-	}
+		ret = rproc_actuate(rproc);
+	} else {
+		dev_info(dev, "powering up %s\n", rproc->name);
 
-	ret = rproc_fw_boot(rproc, firmware_p);
+		/* load firmware */
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto downref_rproc;
+		}
 
-	release_firmware(firmware_p);
+		ret = rproc_fw_boot(rproc, firmware_p);
+
+		release_firmware(firmware_p);
+	}
 
 downref_rproc:
 	if (ret)
-- 
2.25.1

