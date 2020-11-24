Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F421F2C3105
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKXToO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgKXToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB92C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so70989wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjbxtDMJ2mzJHY8erVLf4gsozStccXbO1UKtGEg99mY=;
        b=Ag7rhcl7/rvzeLuAHjQfgJaFLQTfabEOu2bp+usdtMNvawzlH0cWoeYgVAdlXm/biq
         ZuPZfgyx6m2NUQSEkBnlnJJgAXw7ZL9Gedeo4VS1wjsX5Hosf48qqXr8+c//c3dxeNRX
         v+AvpZmgpG4hKWD+bq6vwgrjIVLgu5N+EzNskBVkez4sbFuZu9H6EpivWUedWLSDWYK1
         mbF9KJ4sS+HvbukWNxWHNN25abdGc9B/vDEwX6zmmqtUntUPPJsgbCRMT85DKyPHbldD
         tc7RQJb0a8JDuMWutpdlsBpUPy5fyXLlIYLwhfDXXgG8vvGVl0QJ1NaL/tEHLpXs9bhj
         gX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjbxtDMJ2mzJHY8erVLf4gsozStccXbO1UKtGEg99mY=;
        b=gXHueZ/ywgmHtwDTaBZZRRE0Z1zpxmQtFcXEDWjadLR01StW9nvozdW+7AVSs5sXMr
         cVpwcgIZXoAunIMY1ZHi7cX2A8HJno6dIItixOv+Z6cCNFlYv9BQbmVRSK7uZzh1jcBO
         9sYdD/huk/y3XCJxegtPsh/nRHSU39Eba4WchFX0T4WQgLhLU27W0FhXsMqn4OGORsQ5
         TFO909QhF7BFk4sqpOSuQ2vcVxHJCTuDG22DTq+xYnkGFKbsauiDBRbb6L1eA7iHhvaK
         h5djyjir9VFpr+IQq15CO4QnykA0AQKKCH+p3y05aMJqQiHDPiSpM5sRKkhYHXQh3a4s
         G+jQ==
X-Gm-Message-State: AOAM530kf8b83fX8TGDkc56IUUbHQcnnJv4EJAU60sxQdOy8SJhgY1Iz
        M9KdlW7DVByP7rNtzfjrtyVBEg==
X-Google-Smtp-Source: ABdhPJzUd+8fjzWTFYwiB6AmT0yaY7XFSUxHnPxdi5IjlskHBIh47RAs2kkFJmMSWrxtNAGoDb0o6Q==
X-Received: by 2002:a05:600c:2908:: with SMTP id i8mr188239wmd.182.1606247045448;
        Tue, 24 Nov 2020 11:44:05 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amd/amdgpu/tonga_ih: Provide some missing descriptions for 'ih' and 'entry'
Date:   Tue, 24 Nov 2020 19:37:49 +0000
Message-Id: <20201124193824.1118741-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/tonga_ih.c:193: warning: Function parameter or member 'ih' not described in 'tonga_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c:225: warning: Function parameter or member 'ih' not described in 'tonga_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c:225: warning: Function parameter or member 'entry' not described in 'tonga_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c:255: warning: Function parameter or member 'ih' not described in 'tonga_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index e40140bf6699c..ce3319993b4bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -181,6 +181,7 @@ static void tonga_ih_irq_disable(struct amdgpu_device *adev)
  * tonga_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (VI).  Also check for
@@ -215,6 +216,8 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
  * tonga_ih_decode_iv - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to decode
+ * @entry: IV entry to place decoded information into
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position.
@@ -247,6 +250,7 @@ static void tonga_ih_decode_iv(struct amdgpu_device *adev,
  * tonga_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to set rptr
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.25.1

