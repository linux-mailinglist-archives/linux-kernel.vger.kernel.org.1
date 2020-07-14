Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1623C21EF09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGNLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGNLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62AC08C5FA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so4994381wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5s+rt+e2q3V0egWj1kNYGUguad7SryOLaiZ+itebdM=;
        b=jL/qnxUg7kHcZtAr6n9CGwUkJP9YJWkIhRzSWv4qL92aeS/U9U9g4zmNTJgB3Xz5vk
         EhtOmx3utz7MY7fGlpBM8ymeZz/Z1LEcmgct51u77TV6v8ybZlzM05eoBQZHgZEju/TN
         P1NVX5MKM9FKkX/foE9t2S2+zssTOe5hxn6ZIdXU/zcsNGXWLkpHk5+z0yRwIm+K60IF
         5AfyIwSiPgWmJxPCZuO4J2098g00yGjDb6/m5ubDBW1OjdYQwtSxGucUafpEVM4+wmsE
         npu8ws+PErzvWJ4Bg8Ue0dHmiwGP1cvG6cC/5tOHg5SglktOksJAj+zL7FxBMMYhDlw5
         2isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5s+rt+e2q3V0egWj1kNYGUguad7SryOLaiZ+itebdM=;
        b=AyJ+ojt4bkeOtgKrZzbwtjeaVYovBqKsn7uHIUYd+74yeLDKUPs9EIC715gmWTghrT
         WhPmLOHD1KDXIhS4z9Aplg4SsHvzeZlwmtTHSc+/5StXOW5tNFpqzdIO1tSTwMVDSv/x
         opFrDCIXERr6nOwQqcQLLjvB7iqWXOaBxDjBLUeodxkNrd560aS55g/ymqV14isZ6Ll3
         WvtzJjskwkIDXuteyhHqv2lrKNhF1x4FW5ZqvRx/RjH1hxmxo2b05bwmovSySrQ6Tu94
         Jeh89lDE8C/Q2r/8oi6amIzuDwEN6y9LjtE3zs2hJ1mJLs9J5OBuqulZzfy3XRkf4xu7
         DDlQ==
X-Gm-Message-State: AOAM530g3kH8oYuV2hqg9tAjc/2e2u6PlJM4/xosxXQO+9SCX+aVXuGN
        RBB+c1wwdus8AMcR5qMntvnZ3Q==
X-Google-Smtp-Source: ABdhPJzlT0nwkncrA8tygh2vgm+oBugX1DRxO+s57LIOaZAoV6vTcoZohz7bp+W9pItWsl0fDL6/YQ==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr3821369wmc.188.1594725360960;
        Tue, 14 Jul 2020 04:16:00 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Wen He <wen.he_1@nxp.com>, Jiaheng Fan <jiaheng.fan@nxp.com>
Subject: [PATCH 10/17] dma: fsl-qdma: Fix 'struct fsl_qdma_format' formatting issue
Date:   Tue, 14 Jul 2020 12:15:39 +0100
Message-Id: <20200714111546.1755231-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc formatting for attributes should be '@.*: '.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/fsl-qdma.c:154: warning: Function parameter or member 'data' not described in 'fsl_qdma_format'

Cc: Wen He <wen.he_1@nxp.com>
Cc: Jiaheng Fan <jiaheng.fan@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/fsl-qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 95cc0256b3878..c33f491fae3e5 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -136,7 +136,7 @@
  * @__reserved1:	    Reserved field.
  * @cfg8b_w1:		    Compound descriptor command queue origin produced
  *			    by qDMA and dynamic debug field.
- * @data		    Pointer to the memory 40-bit address, describes DMA
+ * @data:		    Pointer to the memory 40-bit address, describes DMA
  *			    source information and DMA destination information.
  */
 struct fsl_qdma_format {
-- 
2.25.1

