Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAF2C0456
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgKWLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgKWLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4701C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:00 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so2998685wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gwlhc6VWNQpc30FQNQL/2GN/SmFNbQKQvmIwzZcrdLA=;
        b=ii8qj0aheF693rKVv9viDbBG3uIBD3b1E/d48+r0czABOQzGbo+zl+Inp9aHhbiI8D
         quQKTjsklt1ekVGzZYrPVj50Tr1V0Zm5iuosIuVA8jbF13ZPgHjnYK/R5aO8uoEYMbMg
         R8jdbDEsd0nTHR5e/K6gw/CAluupMzSov0+8gEcmQaIKSEB+89kapqJU5OstjXmu+PHE
         6iS8H+q6YomiC4vS3QMI7bSl5kfHtYPCttEAyMyLHKZXC6m/lYCiPCOUjvKevuo2r+WQ
         56F94rTw6+KuYZGBmY+nRjet4KL8v28PXyUz5LlAtFPPkmMs7Ajuw54jRum5iSxfYa7s
         EGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gwlhc6VWNQpc30FQNQL/2GN/SmFNbQKQvmIwzZcrdLA=;
        b=a8lzZ75yjqvn7yamv86HHEkEu60boqPcIXUn6C5ageYk9OqMcvREpqx9afdhdcwDcI
         4lqaxsNkEvSGURJRxEkKIwJlvz5EXfFoGJgnJllQc/xUmyca/q/QKkFDgNFYBQv+67BV
         gfyeltjIdRjZG4d7GDe1uttdfUKvmJEOm5kot7PZWai+j47pjx40bQ6gJh2nJ3/NW93c
         3QGfcpJ+HnmKn6TDsPMupzUHNxmEAnB7+w1sCaVaq9HvIWy1zZx6zQd7X12xTAr6/ci6
         NQOd7kC5d+JRVOTWd/plynpg8wDk79z9g4rRMZp71BYIdgbTeN6BT4RnKX9Tg/rST0uR
         jO2g==
X-Gm-Message-State: AOAM531RJM6EVuZ86F6iwa3Khj87i6hlot2L76EhN0hKl/2H3valmAbc
        f6HgtPuBBhIFBISJNsKP9XuUvw==
X-Google-Smtp-Source: ABdhPJzEtM9u5WB7ddkQaslExzIYNinQZJFC9Neck66WcdNDTl83GY9W0Dc+q8EEm6OkToN8tdejQg==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr9165183wru.260.1606130399449;
        Mon, 23 Nov 2020 03:19:59 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amd/include/sienna_cichlid_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:07 +0000
Message-Id: <20201123111919.233376-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c:28:
 drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:186:29: warning: ‘USB0_BASE’ defined but not used [-Wunused-const-variable=]
 186 | static const struct IP_BASE USB0_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:179:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 179 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:158:29: warning: ‘SDMA1_BASE’ defined but not used [-Wunused-const-variable=]
 158 | static const struct IP_BASE SDMA1_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
 | ^~~~~~~~~~

NB: Snipped lots of these

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
index 06800c6fa0495..b07bc2dd895dc 100644
--- a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
@@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x02408C00, 0, 0, 0 } },
-- 
2.25.1

