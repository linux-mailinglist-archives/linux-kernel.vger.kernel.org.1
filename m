Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F038D2FC1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbhASVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbhASUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:45:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F8C061786
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:45:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b3so13053885pft.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HPHLTIbnqvyYqZakEN0yW6023R2vX5SvJvHEGRsu88=;
        b=rVY83dpi8ReoTmjM5P+oExiEZYsinMGkbYee1lkK/ULznES2ZNsQayfBScXWTZxwHT
         xzR9TWfOeB0CMtADGKZkF8TcwHODZPc1u4AMryo79Zq9NNv2fP2u7rpmstz007F5Nwzb
         fYc/mdbBQq3n41ctal8AiQZluORE84aHZh48bd34Zb95cR6VzRRKiIQtqtWHSWK5Ql/Z
         37MtMXfQhlWisjAseq7aB5u02jTDZwCwRQhmEw5cye33lLvuVq6TSjWkKCFJCnRio0sf
         Jg4mseBZ0ILUNtu46AlrTKRbSYK79YX03tEGKvAoDHj4I2D3x6wz8PcifiCFUrwR00mS
         hKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HPHLTIbnqvyYqZakEN0yW6023R2vX5SvJvHEGRsu88=;
        b=CtnVjnCEhEUDdfEx0TlnrVr3MGGCrpEiCJrH5lhWr/dlOJcZiA0XZGifkILc/vMNg6
         91aj/Ef9pAq88SySsuXojCethfk79eZ0s9JO0U62yFHGzYv4Znoh87AuSclIHUd8xFgu
         XyHw+QnQjZ94q3P/SZ2wc8vXrRANFW96x0INmtB2Mrt7uayRRnM0+zM72N7Yvdjy91od
         sdvtSE/9GMNmyZfETBpKJOMyVHWWFVmw3IwUTf3iHSRqmyVqEu8jodiQ533JPPGi4i1Z
         bdrF0e+DBis56LpyMvVESrQ2xiAir6HV/YU5mBic/Xw2qgCWShB5kQ1pNuOb11hP9Pw/
         l5sQ==
X-Gm-Message-State: AOAM531OC+CRYx9lyeRywWrCD3afXKI0pA9uLFtdsFUC65DC6Q3FFqIT
        2fnjUOVH7O6AZDcdvJUwPPg0sTkveCWF5w==
X-Google-Smtp-Source: ABdhPJx7XqKFUvEfxsZUM/yPecJslI2EJghoNxHC6weKaxS/Wdl7E5UFXQpws/ka9g4TjNc2jaAWIA==
X-Received: by 2002:a62:5b07:0:b029:1ae:177d:69e1 with SMTP id p7-20020a625b070000b02901ae177d69e1mr5644437pfb.25.1611089113811;
        Tue, 19 Jan 2021 12:45:13 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id md7sm4129838pjb.52.2021.01.19.12.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:45:12 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RESEND][PATCH 2/3] dma-buf: heaps: Add a WARN_ON should the vmap_cnt go negative
Date:   Tue, 19 Jan 2021 20:45:07 +0000
Message-Id: <20210119204508.9256-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119204508.9256-1-john.stultz@linaro.org>
References: <20210119204508.9256-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't vunmap more then we vmap, but if we do, make
sure we complain loudly.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/cma_heap.c    | 1 +
 drivers/dma-buf/heaps/system_heap.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 364fc2f3e499..0c76cbc3fb11 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -232,6 +232,7 @@ static void cma_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 
 	mutex_lock(&buffer->lock);
+	WARN_ON(buffer->vmap_cnt == 0);
 	if (!--buffer->vmap_cnt) {
 		vunmap(buffer->vaddr);
 		buffer->vaddr = NULL;
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 405351aad2a8..2321c91891f6 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -273,6 +273,7 @@ static void system_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 	struct system_heap_buffer *buffer = dmabuf->priv;
 
 	mutex_lock(&buffer->lock);
+	WARN_ON(buffer->vmap_cnt == 0);
 	if (!--buffer->vmap_cnt) {
 		vunmap(buffer->vaddr);
 		buffer->vaddr = NULL;
-- 
2.17.1

