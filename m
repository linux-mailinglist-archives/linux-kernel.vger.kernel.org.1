Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177862A9F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgKFVt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgKFVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:49:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:49:55 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id n15so2791219wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPa36hbXRaCWHNKBNpsuuGTQcILERbE7+3Txd9Olckk=;
        b=cRpiXYsoYNFoqQKy6HN5L54gAQBJro5vQdbxqra3rZdwMubGOsuA58ftK516DBSs9w
         GfisJZOZifFFHK0+b3c+rwTW3EZj5pa3Qk8EP+YQond6DzGj6v3pxICy+0LYt3QJRgeC
         JdtOA2zJhY6yREC+w0s13kcQt8bi3GnpjMTUNybsESi/R49bwNwLvfhUzvfndgSntarZ
         gg0wIhsUmnT7BYGuuPSZ6i2qVs4D87b0qXpN0Na843lQ7CVoopJbVgDTUVm3fBKqQRQF
         MlqkPf6NkgtOkYCLb6/MBEgySUT7djXYFMV70RzxJHU6oaquZE9VB4sGHH9u5d8F0TGF
         PU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPa36hbXRaCWHNKBNpsuuGTQcILERbE7+3Txd9Olckk=;
        b=A2iD3mJYSFwmdgvY5VvqhcZvXU9Lr+swmFVgebWKUSo8qc1w7Mr+muY80aXxS/pPX4
         EJfS87QHwyPdrd1gWw2UwTT+v4jTHvliUFhvEH/hQotWcAv2MMF7E/ORU/LOJC1H3/nV
         7kCP85xQi8mHeIu+ix7HipTLOiL+9ubLhiWQyjCoT2Z5D+l997jxQOj8AR1wv+smjBHd
         elAE4GWvw7Dabk4miiGWXAMBpjuLAK2b0FrX4pGUSfzyj6XbzvffRXwdxolKrxD53xx5
         c3mTzSf9oL51Mh4HjNKEZ9j3FJjCJ0XZtVNH7/05stWeRrC29a4C3rn/Mluxu4zjEGpk
         p0xg==
X-Gm-Message-State: AOAM531E22WruYH9snZdG5fnoLQiF5Zs12a+3+I19PI9RkTAclFd/+IF
        pa66+fmpYApTyy7xgrBsGdIXWQ==
X-Google-Smtp-Source: ABdhPJydwKMlO1v5pDAqy0we2KrKHwWhu7VxuH459Jq4br/NRTf+Rribn3mDOIvbuPagpT3+N5fQpw==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr893436wrb.132.1604699394143;
        Fri, 06 Nov 2020 13:49:54 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:49:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/19] drm/ttm/ttm_range_manager: Demote non-conformant kernel-doc header
Date:   Fri,  6 Nov 2020 21:49:31 +0000
Message-Id: <20201106214949.2042120-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
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

