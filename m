Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0818298FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782075AbgJZOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:50:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44847 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782036AbgJZOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:50:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id a5so10431453ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjEF2KqOXKaLbNJ1lhobH8B17OERpDyB9/tbkI8C/08=;
        b=HPYGaAAYsjgalKpDgIX2K4tGtRw/UCJit+fZ2vH/w/3KbTGTyHCTu9Ut8j1kDVNWr/
         jWPMbMCI5Q4SDNrCtUsDgNtwi8EzIsfQfseVbF1qwkFN/NKLoHYrv2dEG3yHzz8zjv39
         Y6FMmuud2jQbBtE0CcLXDD1t1PcPlpBRd0Qy+eebOKZf09QI4JFWu2fc+TbQvEconMqf
         2nWllRn/bsWfGqeEWY53gueWLNqKjcl8Ml5VzkIO0rX1cQBgpgqvGrFs10lVx4rwelW/
         PS6a9bDnE2a3KRuX5lYlFYTfBZ8EhGrUjdHgCL1P3b2Lkoc5TQ69bb91DOrBPguTd8Qe
         dM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjEF2KqOXKaLbNJ1lhobH8B17OERpDyB9/tbkI8C/08=;
        b=oI0hUt8jx5hHq6bJ7ODuKeQYJPVijzUEbsJtvIG+2gt9wv5tmZkWlmsVFDfHadygP1
         /6FLKrd3V1O6Iv3qTaXT9hD4EooTwPMQCTyPjbaMgX/emcgS9+gY/Tij/Mbz391j2pNs
         yjcZn6LjQNzGNhuesFE1SrGCv0q/yMh1dkXyzcu/1+FeKahRiP7ZWaPkJYQD7nPdtrKi
         7E0JvN83NDnilh+yL4fmahlZRtNecQ74dv5ygto54tyHu/O59OAmgYnJQdeQ8HlFye1f
         LuXKmVuy9f0Q2GZc5uMmfWz2WqZyjDMKbJbGuRQ60eum4kQN3rb1P1/eG8hawyXOtjGr
         /tKg==
X-Gm-Message-State: AOAM533NyyvbePKC5CwuTE2+EjkbGRMYjYCWk0LzIMlJJTJvvVo4HaM4
        TPGIUURahq4x3rWKWE7VFgrQLg==
X-Google-Smtp-Source: ABdhPJzglLdj3k7YiObTfmoD5Y1+QYVfbtS03yxhQVEzj9ZlCLveJNoso6kvb2hB4j3HxFIpC4Yetg==
X-Received: by 2002:a2e:9ccd:: with SMTP id g13mr6297132ljj.127.1603723842608;
        Mon, 26 Oct 2020 07:50:42 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id l129sm1061301lfd.279.2020.10.26.07.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:50:42 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, tony@atomide.com,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH] soc: ti: pruss: Remove wrong check against *get_match_data return value
Date:   Mon, 26 Oct 2020 15:49:43 +0100
Message-Id: <20201026144943.30821-1-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the of_device_get_match_data() doesn't return error code, remove
wrong IS_ERR test. Proper check against NULL pointer is already done
later before usage: if (data && data->...).

Additionally, proceeding with empty device data is valid (e.g. in case
of "ti,am3356-pruss").

Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/soc/ti/pruss.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index cc0b4ad7a3d3..5d6e7132a5c4 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -126,8 +126,6 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 	int ret = 0;
 
 	data = of_device_get_match_data(dev);
-	if (IS_ERR(data))
-		return -ENODEV;
 
 	clks_np = of_get_child_by_name(cfg_node, "clocks");
 	if (!clks_np) {
@@ -175,10 +173,6 @@ static int pruss_probe(struct platform_device *pdev)
 	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
 
 	data = of_device_get_match_data(&pdev->dev);
-	if (IS_ERR(data)) {
-		dev_err(dev, "missing private data\n");
-		return -ENODEV;
-	}
 
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret) {
-- 
2.29.0

