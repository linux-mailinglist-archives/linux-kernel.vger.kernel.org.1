Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A42B4E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbgKPRmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbgKPRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so19670197wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPa36hbXRaCWHNKBNpsuuGTQcILERbE7+3Txd9Olckk=;
        b=pRWYp0XTrVtt3Xvh9YDV5tP6dikwZIDkT90eW9C2OdRoYyd2HswTEVenhb4ycBTOiv
         m0PyBnWv7J8AixspV9covb8JFHnTe8YM2jN84skal5ondJKls6A9lksIy6pD9EwgxGhu
         rZGOvxBj8p/+8YLdDB/E8ijfhC08TPNqfGpoofRbq3gc+zDXXnJaMWSM7DkwmQ8MPgv+
         TqFQ4HaN6/KAC4JiaFVOqnS2icRTYJIr0TJbh3U3s7h2r0dLE4IVIFrX0EVgBgEIAaRV
         AN5bru5QhzF8jQZ2zWe5YmVhQMZlVkG5l/V9ybXf+8ELVTcEHTtIcpONXI3T+dCsPR4K
         yNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPa36hbXRaCWHNKBNpsuuGTQcILERbE7+3Txd9Olckk=;
        b=WHJ/aLkhIf5AXa1LmWR/kcFkQ76MbITJCrzxqQKovEfjWF1ObYrAjDoGdGmoQu64LT
         9VdVW1AdrTZcLSUaoLdgOUj1j93c2n8yl0LwXFytBa5b2wnbDsIBKUS/lb0tL/uc4P2z
         Av0d5Vat7uJ4gar8RLT0GEoow1ZHF8SUUzd/eh9PUgqGj54/DrGfwrtBKuWAghQE3YV2
         rIRIMC3kC5kcsmTm52QffWFex08HeM36++qRUk97Xrzy7JeYAWR/shu5UJovSIlaCXR2
         MXXOaZmPqJLW4tLhh1SlKRz0s3WqTTwNDyTL4U1AOEqSsgY2DUYlCC8dg7Zl6VDFgTms
         mhOw==
X-Gm-Message-State: AOAM532rsAE7UfAY8+iycVIMOaB4hwg23Zt2NSnvSlegBvKe6ojSvaWA
        Z3TXUnfyrzZENTXoDOZY8xwlcA==
X-Google-Smtp-Source: ABdhPJwhedprnVRT8XYKz4ZODyRIwOSlsB9QfSG2MGDe7+rjWfM0Dx7z9ufFAbkbiueG2aby7uBBaA==
X-Received: by 2002:adf:8030:: with SMTP id 45mr20573626wrk.407.1605548526801;
        Mon, 16 Nov 2020 09:42:06 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 33/42] drm/ttm/ttm_range_manager: Demote non-conformant kernel-doc header
Date:   Mon, 16 Nov 2020 17:41:03 +0000
Message-Id: <20201116174112.1833368-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_range_manager.c:46: warning: cannot understand function prototype: 'struct ttm_range_manager '

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_range_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index ea77919569a2e..e0952444cea93 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -37,7 +37,7 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 
-/**
+/*
  * Currently we use a spinlock for the lock, but a mutex *may* be
  * more appropriate to reduce scheduling latency if the range manager
  * ends up with very fragmented allocation patterns.
-- 
2.25.1

