Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF826C960
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgIPTIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgIPRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:44:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DCFC0086D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so2853776wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Zatbl7mrAhM9R5fUS2YkaTonXg6opq03K7IVVy2jXk=;
        b=KmPJRTBfjSReOhmZEAA0xaFKj0rSG6mdJJXaH6YOhZcIs+4LmghOyYVsX1ZW/ceAvS
         XU8vSwAn4+NjOCZyDYaIjUCHZg/KdMFaKjkbOf7AbHkEvJg/asPj2T4413jNfoaHgd/r
         IGMirpGCDw/ziH5ArOD0RoDwf9yLfIqGLziZk9NMQv3EV/jNLKpSjB8DQohl/5E/QBub
         RLg9edr2gR/47lrvX/XGKoIW51NJ+tsRXKgHFwYXSc6PSXsmG43AvnLJTgH/hkEETNgz
         /eq0eBldf/BAXhxQWD2UdRhKPIyI/3A1e4kkdxbEbF1XehQB4voh5010UukMlzzVjwfJ
         n5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Zatbl7mrAhM9R5fUS2YkaTonXg6opq03K7IVVy2jXk=;
        b=q6LPJNVB953Yu/bYl2WgQTBVPGuIuLjJbUu2T2zn7K7vW1GJOowNDVG1nXL642wuMF
         mhuh2WIny4r+nbb7k/KXChIwcI58i8ZohG1pGTlQfdV5a9Y9aIpycpLFwyqOkUX/rJC6
         dM98m0oeWiQb6jinVyJ6lNztlcGuEBzCyznilZ1JioABwZkdCjYmqhVx81NtMYSFI+aQ
         RQU+mbcEW56LBd0XL5Zr29W0RjEjTjT0gQamuJULc4uwRrOvnn/SRhRcnXnh++W3KoU4
         hi5XsQ6IKIM9xn6C6Jqz7yuvp2NE3bJ0rLQx/wbObM69naDHl3TzIAyKrZh4F5RgIY5a
         TtYA==
X-Gm-Message-State: AOAM53025sB55KNHY+pBVb3IXUq3oEI6nY20ZgGLHnSUPA+Mzqno4F8E
        64wdwSiwDH3LU6jM4dkeKQkWvp9t2sY=
X-Google-Smtp-Source: ABdhPJxpWL+cfsd8kHVURQNd5zD41UryNOSQvpyLEwN1p+KA76HGm+cTEAMOPT+oI5NVzUpwwWQ0jA==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr4903825wmj.30.1600263818431;
        Wed, 16 Sep 2020 06:43:38 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w81sm5658664wmg.47.2020.09.16.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:43:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 2/3] habanalabs/gaudi: fix DMA completions max outstanding to 15
Date:   Wed, 16 Sep 2020 16:43:32 +0300
Message-Id: <20200916134333.4029-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916134333.4029-1-oded.gabbay@gmail.com>
References: <20200916134333.4029-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a workaround for H/W bug H3-2116, where if there are more than 16
outstanding completions in the DMA transpose engine, there can be a
deadlock in the engine.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2c10e3f92c86..86650be5898f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1918,6 +1918,9 @@ static void gaudi_init_dma_core(struct hl_device *hdev, int dma_id)
 	WREG32(mmDMA0_CORE_RD_MAX_OUTSTAND + dma_offset, 0);
 	WREG32(mmDMA0_CORE_RD_MAX_SIZE + dma_offset, 0);
 
+	/* WA for H/W bug H3-2116 */
+	WREG32(mmDMA0_CORE_LBW_MAX_OUTSTAND + dma_offset, 15);
+
 	/* STOP_ON bit implies no completion to operation in case of RAZWI */
 	if (hdev->stop_on_err)
 		dma_err_cfg |= 1 << DMA0_CORE_ERR_CFG_STOP_ON_ERR_SHIFT;
-- 
2.17.1

