Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F02C3120
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKXTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgKXTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:52 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8BC08E860
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so7732783wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAMUF0M+5e5QxYGdyHTIO/CIT9L6gglBGUvPq+MzHBg=;
        b=jzIcHL0eMMZm6DtlZ9fd+0W/Qjf5OD3r//36xPdi8sot0v4hYcjWBJGo5JsdiMAylp
         59cVzB0oYdEJPt6mdkziyQpaCf9SGy3mSSb/GS6zD2UgphuNsEksk+mdbzN58DTfIKHq
         EAOM2xRHO5Peg/72jxA8+vV69v1RYabIKSnergZZ0ZMBcl+60CIl9Iq3i0vVOQ24h4iG
         GvSC+Xkk8n07CN7qKU+XEd44EJWCpmiRlNYWrlWHzqAYUhnJHcFSBkYV+/Ut8MP8+xxf
         pr0QrRWs6YAUEhSh5t8ghtWxnO/bqpAlEyi4IUA21Oj2pQc67sOd7YpbMJx2fSqqXAju
         XxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAMUF0M+5e5QxYGdyHTIO/CIT9L6gglBGUvPq+MzHBg=;
        b=e2UIP3U2FXrOHNczDrxT8QpCxwOeHzETUNkZymoI1Pz4I+a0kID+Rr5fgDHhBIlsfK
         vxeqHtkJdAG5mtl+nA7TNh+wJ/StVMxEf4tkTr0GC3/ETKqjxWPbUn8yJ0GYDGZ+4wdW
         BJN7t4BwixaY/sLjnvJ4DthpMTUFGWLpW2z4r2+9XnWyu0R8auWL5299TIrvnCH1r05x
         N4o8dWqEXpsrgZw9dZMpq4xq6pf4LAKuyVJcOPa1AeQbqGIiBr2uf2th7hQT0B1w+4Pe
         soSjShvWH0YkHYP0IO11na3Y3bJf4C6AUHsLHPh1/15T2AWRtsvaDle11HM+X6/qqK7Y
         1avA==
X-Gm-Message-State: AOAM5300OkR2Vns0K9rhA6sFhhDyWaPDHayCYvjNhG2QPYsNuO8549iv
        sFh7cWoXzJtOdVdXS6qwdMqYZQ==
X-Google-Smtp-Source: ABdhPJwGpjx8U/47ZgWVIMjepZQiRgQQJIP/hnzr40LeSboZi3EXQzjARjAY1rA2rTYNNnVeMWqbpA==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr44599wru.405.1606247088972;
        Tue, 24 Nov 2020 11:44:48 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 40/40] drm/amd/amdgpu/amdgpu_uvd: Add description for amdgpu_uvd_cs_msg_decode()'s 'buf_sizes' param
Date:   Tue, 24 Nov 2020 19:38:24 +0000
Message-Id: <20201124193824.1118741-41-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:555: warning: Function parameter or member 'buf_sizes' not described in 'amdgpu_uvd_cs_msg_decode'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index f8f0384a8d9ad..7c5b60e534822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -547,6 +547,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
  *
  * @adev: amdgpu_device pointer
  * @msg: pointer to message structure
+ * @buf_sizes: placeholder to put the different buffer lengths
  *
  * Peek into the decode message and calculate the necessary buffer sizes.
  */
-- 
2.25.1

