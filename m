Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B662A2A12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgKBLy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgKBLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so4391813wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2abslax4xTZx4NcG965UPlBWLqxdXR2VSBh/TqhIys=;
        b=k+m8SyGwdyAZD/uE6UskLvlqqTDE0Zdmc13bxLxJNTOcT6bdgr//rlE3Uq0VvHoh4c
         L77qIbJGPIze8rBOXShkZjSLdm1Yh4fJeSGogRMqgDJqeNwbxd9FEyaQ6/21e8s/jQP0
         ZtdkjCgFsAGHqMrfLzpN0e92IoNVi3hRN69is0zOA0ceu/HTIx5q4uzamVc3B3JLjX7h
         zdKjOpZ8vUA2xpuSYQyaFY/uUJsPe95QNOT6rYg4ZSDQ6t22alLiKgTXEaDLUoHUkrun
         1jLb+ugkygHiMiPSNKSD2vo2QxSGd35Hs5XLVUB177RbZukpKURgRQ4NPCIuqHcIlmPf
         e0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2abslax4xTZx4NcG965UPlBWLqxdXR2VSBh/TqhIys=;
        b=UyD6l7QgXKNqZxcjaWFb38+4aD6HxBray+m5S7nog4jVmv5RgW3xhemtaELjLbyYy/
         8chdc6iXzAfLHeEpYEhiGKwj7IUQxovsUPevKMqXBN35YBTqy2bHPaV6hszjw5ZWlwh4
         Ta31lmMiT5nlfFkdil0th6wTdzc/BVua71OUyJQie8lt5NSPrifjvlffRdhLAN8aw3Sm
         IMDj1+ja+m91qZYBeUP8WRqTRqwFSh1oU+LtYnb4pPrTkPsqhdIOAKbcMVfVLt55Qi9c
         b0u0vGyd6oLMmyLMVDHr9r8jOp5ZdkiqI5UusyX5zxU/x99A7YoqEPXNGpUXjNktvCMv
         giVA==
X-Gm-Message-State: AOAM532hNRKN4BplLosMjpiX0XT69Aki9+wtgsMpVJxVWk0lIArssPEV
        7Ilc8fUTwlFxF1jhyNYUMRxzEg==
X-Google-Smtp-Source: ABdhPJxULnli5YuM/+UwFfCgpMpztcQccJXd4pmVDfFOBvacZYK17w/mFel1HAK/kzz/eK3yaka/iw==
X-Received: by 2002:a1c:3c44:: with SMTP id j65mr18144388wma.13.1604318079703;
        Mon, 02 Nov 2020 03:54:39 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Choudary Kalluri <punnaia@xilinx.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 21/23] mtd: nand: raw: arasan-nand-controller: Document 'anfc_op's 'buf' member
Date:   Mon,  2 Nov 2020 11:54:04 +0000
Message-Id: <20201102115406.1074327-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/arasan-nand-controller.c:133: warning: Function parameter or member 'buf' not described in 'anfc_op'

Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Choudary Kalluri <punnaia@xilinx.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index fbb4ea751be8e..549aac00228eb 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -118,6 +118,7 @@
  * @rdy_timeout_ms: Timeout for waits on Ready/Busy pin
  * @len: Data transfer length
  * @read: Data transfer direction from the controller point of view
+ * @buf: Data buffer
  */
 struct anfc_op {
 	u32 pkt_reg;
-- 
2.25.1

