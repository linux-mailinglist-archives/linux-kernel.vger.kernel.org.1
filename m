Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349612C0451
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgKWLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgKWLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:53 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04371C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:53 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so16872211wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mJp/ZJF2fFOdQnMH+2RLRCl5LAsiRJ8lK5Mp9M3IrA=;
        b=pGRSDl6ZZ6iHS5KUMMUVMTZNqFR7SFiatCJxWyjgYvflweYqP5nen0rwMFWz3zWAUP
         F9vD3BXT96by7P/QzeyM+zO1ABElGZng++/2COnRLJpPOo85dbY8EMGmtVXcElg8CA9T
         BcAcJfYFvZTsDq8wEh6RLmGsyKcCngpWt/oaOQhCeD1GwlY++9cTPjKGF+z63ceefWDa
         OiXnGDIjLZ1YbjSACRPQhuW/gcKkHhXmVucUmc2b/J9bECm5myRUcHiOh1WtcLGMqxxV
         r2lQ6ssplWP6uF8VZfZScTZ7urI2Hozk/TR1Lbszu529iDtfIhE0/YTmlkhv7T3cnYTQ
         Zjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mJp/ZJF2fFOdQnMH+2RLRCl5LAsiRJ8lK5Mp9M3IrA=;
        b=bLFkObRmvfx1IgXnqjLYpfClgXdpNr4NRIAvX7B40Tx7GlATWu5ERpGpK+A8wjHdu7
         Y8z0Fj0ZQFTsFam76BjWSvCrqELhdo7e04zuQDFaD2Qpt01wUkF1tSe85oIuhi5vAwzC
         Dbza17xYUDSkmOA2iilb8VKJHHtV6CTKhmI1Xlj0Z6LUE85IXey8maryvCRDi1zjuLAo
         YUYIEmYOYCWzQh0yT3xs+JrXPGE8lTG5Efod9zW/rZqoQfmKIf9qVrQsMIlmPcrkw4FP
         vh4BMBSMEmtqWgrmHTxxY7UVVv5rEz79Rkn++hNcd/ZXM634/ZZrfc7TZphSqyfa6y2T
         npLQ==
X-Gm-Message-State: AOAM533Stew/wZITNQXXTKk86WQnGq545SjTC0b6nAYFbjZA2l7yVytC
        +lXGVmgZmwsXsmnAmxFXgIdLziZlXYQJcETN
X-Google-Smtp-Source: ABdhPJx9N0T7kD5rTXkjFAUKmVJ6haqyTW8x9cxW/A4t95quKeeGUp0vIN2Hq7Ju8oF0FGdNdWSusw==
X-Received: by 2002:a1c:98cd:: with SMTP id a196mr23581122wme.42.1606130391783;
        Mon, 23 Nov 2020 03:19:51 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/40] drm/amd/include/vega20_ip_offset: Mark top-level IP_BASE definition as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:02 +0000
Message-Id: <20201123111919.233376-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 In file included from drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/vega20_ip_offset.h:154:29: warning: ‘XDMA_BASE’ defined but not used [-Wunused-const-variable=
 154 | static const struct IP_BASE XDMA_BASE ={ { { { 0x00003400, 0, 0, 0, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/vega20_ip_offset.h:63:29: warning: ‘FUSE_BASE’ defined but not used [-Wunused-const-variable=]
 63 | static const struct IP_BASE FUSE_BASE ={ { { { 0x00017400, 0, 0, 0, 0, 0 } },
 | ^~~~~~~~~

Fixes the following W=1 kernel build warning(s):

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/vega20_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/vega20_ip_offset.h b/drivers/gpu/drm/amd/include/vega20_ip_offset.h
index 2a2a9cc8bedb6..1deb68f3d3341 100644
--- a/drivers/gpu/drm/amd/include/vega20_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/vega20_ip_offset.h
@@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C20, 0, 0, 0, 0, 0 } },
-- 
2.25.1

