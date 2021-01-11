Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178912F1B39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbhAKQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388969AbhAKQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610383248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8MLJHq6t8gx0gvzWqP/vbEu7Db0NCGsfRJMnLvQSQpI=;
        b=NGAKj8q3z92w+6K5ZYOOvBDtGD9nmBHrPYu/lNd/Q6erYaDgtDyPy7EPwm8gCTj7D0oZcd
        JXxsHY3DiE/hR8EZpcZBVLU+rGfea3RdsaC/2OR9tzId5J+vcfGEIt7SkI6ZG3aBm2Pnou
        tFGzSU3OT7Cgiz7oMeM4gwGUwY1K3AE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-rmeUnzSjM7Gz91Z-Q-qL6w-1; Mon, 11 Jan 2021 11:40:47 -0500
X-MC-Unique: rmeUnzSjM7Gz91Z-Q-qL6w-1
Received: by mail-qk1-f198.google.com with SMTP id d7so24090qkb.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MLJHq6t8gx0gvzWqP/vbEu7Db0NCGsfRJMnLvQSQpI=;
        b=Zbrr0rAyg4l1RzaFawicGbwc6+tbtoxC3sO1O8xUwMJPczfAtT95QdMCRxkhoox4p5
         3Dx4oWPX/ght5wEF659DBrgU565drXTwBEhj+wyDNy6wdDtR786xi8L0yjKS9Y+bp++I
         BlCX8CLbqxvUdZkA/w8DuDvNawNzrohQlz0RCH2P22/lRL8A03xDALVczFRgJpHSbwpL
         CyVz+X74MTvpzIvTgcQIsou2o/O1H37FaiNU/uPDuqTnO/GyTCJkz+i+MjTNZHiVdEg6
         1JX2RLDUJLRYjVRuKX0oNYohva8T+lRULomYjCsGPIgl3y6bVEPLSm57NDamb7Um2NnZ
         OXIQ==
X-Gm-Message-State: AOAM533/T9gJrAwEIqqhH7C2KptuZSs5rE3DaRrC2CPKpsYuAr+IRQJW
        omax146eCsn6MeltnxiJu1gNiKeHsRXwUcW0iMGKmO+aXrTHuTTZ+Mps3g6Nu77/XwN4743Ol1V
        T6T8PzsZe1+BF2uQssZTGpxxm
X-Received: by 2002:ac8:4e05:: with SMTP id c5mr392175qtw.359.1610383246207;
        Mon, 11 Jan 2021 08:40:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMrrmIVF44OfsAGYG/+RRjsGMToGWbU7pQD4+DB6QzgUWbkiNW0MklrV62BFCwWSB4qILCPQ==
X-Received: by 2002:ac8:4e05:: with SMTP id c5mr392161qtw.359.1610383246025;
        Mon, 11 Jan 2021 08:40:46 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a63a:4d01:c440:5c61:43ba:350c])
        by smtp.gmail.com with ESMTPSA id i4sm42599qtw.35.2021.01.11.08.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:40:45 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] drm/ttm: Fix address passed to dma_mapping_error() in ttm_pool_map()
Date:   Mon, 11 Jan 2021 11:40:33 -0500
Message-Id: <20210111164033.695968-1-jcline@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_unmap() is producing a warning about a missing map error check.
The return value from dma_map_page() should be checked for an error, not
the caller-provided dma_addr.

Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 7b2f60616750..0aa197204b08 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -190,7 +190,7 @@ static int ttm_pool_map(struct ttm_pool *pool, unsigned int order,
 		size_t size = (1ULL << order) * PAGE_SIZE;
 
 		addr = dma_map_page(pool->dev, p, 0, size, DMA_BIDIRECTIONAL);
-		if (dma_mapping_error(pool->dev, **dma_addr))
+		if (dma_mapping_error(pool->dev, addr))
 			return -EFAULT;
 	}
 
-- 
2.29.2

