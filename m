Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66F72C0476
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgKWLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgKWLTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCFC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:39 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so18247615wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCZKU3j8clNV9/z+mSJexBSfvTb0PXc+UA+5nG1PO4U=;
        b=Oj2jCVRp8mxrSBXicPTrJ6Cjb3r3OcnFBR/iK8m1Di+xA+yQCWzhNblwi55dAJuP5k
         NwGqq/oSo6tOSdhXKl22884gM+qdojICcXDS6fKp1X6Yf1kRGTAVCR6jtXM6SSNhCbEu
         bOzqEuOL1BtF0ukiS0k6kT/r8jALx6ZhPbMbRUxxG0x1MV3fBOWRaKXKYUQiKNpMAJde
         1bl0ThxjbqxbOo0fhFzBXfz+wfM62m+CyojimphzRX27w3UcEJBUjfizhXvPHp/wxgew
         QS33fM+XutaxzEwsZEvpaDqKMNWEQ/YO8rF6CcEWoqBWkNq7hjl6hCND+wHeFX+fXHeZ
         V/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCZKU3j8clNV9/z+mSJexBSfvTb0PXc+UA+5nG1PO4U=;
        b=pd0LKE0sNSCxODNw5NyT+SZQ5zZOKxJsnxLNl3on5Y+Z5A11Hb73f1eMRQnmN/Rfwz
         akjBxoPjVk+H7SsJa549ApEu0FaCIPziN02TmkxUCAYVlAvDVD6tXwikSHmd9Hchr2Iv
         NeaiIqmvqPqoZ6zKZrp4oZo3eIYR6zlCmXsQ8z465ovATjeWRVv7QJBBhdKb9mb1vN9n
         BSZyQabM8vsLSdhEz/laK6++SVypYepGBTBGURqIO+JRSGwOwTgyBg+s+ZhzRrWWXy3j
         KOORcEBdS/7ZsfJfqvwV69lYjwnC160bHZf6gubmfouL7VSa6nTpJYrw9t6M37BGgcSp
         PP2Q==
X-Gm-Message-State: AOAM530RIT2hbQtbC0xA832oL6cUw8h4Y3xXGBhRoXr+/81YrXvBBYqF
        Unb8PnEPYpFY+cG4tsHd4EpVXQ==
X-Google-Smtp-Source: ABdhPJxK2djg0cErC0kW+yAJbREEdI98d1J1Lyc4tpab95gJ+j8Oxsfni5KxA196urUkBeY9GRoXig==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr30390561wre.413.1606130378268;
        Mon, 23 Nov 2020 03:19:38 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fritz Koenig <frkoenig@google.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 12/40] drm/msm/disp/dpu1/dpu_formats: Demote non-conformant kernel-doc header
Date:   Mon, 23 Nov 2020 11:18:51 +0000
Message-Id: <20201123111919.233376-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'fmt' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'a' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'r' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'g' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'b' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'e0' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'e1' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'e2' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'e3' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'uc' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'alpha' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'bp' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'flg' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'fm' not described in 'INTERLEAVED_RGB_FMT'
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c:50: warning: Function parameter or member 'np' not described in 'INTERLEAVED_RGB_FMT'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Fritz Koenig <frkoenig@google.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index a05282dede91b..21ff8f9e5dfd1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -22,7 +22,7 @@
 #define DPU_MAX_IMG_WIDTH		0x3FFF
 #define DPU_MAX_IMG_HEIGHT		0x3FFF
 
-/**
+/*
  * DPU supported format packing, bpp, and other format
  * information.
  * DPU currently only supports interleaved RGB formats
-- 
2.25.1

