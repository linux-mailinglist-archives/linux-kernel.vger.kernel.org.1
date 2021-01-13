Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B52F45F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbhAMIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbhAMIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21739C0617BA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so714301wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtdAaEqJ+OgUUPAXBPbeBnhYUUGO94r1mRrUVzyKNqw=;
        b=J4u9O4QqJw9NZ0jVvvAMdTcHDKR5DdnXk3Ob0X7W0XjXytVoKhQFQmf5V177HDeaw6
         DqwzEq0kkEhGD+eaLkMORoIjCqrj+FznQMQ1+ocLIg7w8IIdKP+L2AgJH7jnt2HMLAEY
         AfvdBRThpE1B+QBu7eOFPYevp1TjEjyey0WgZD3O7XSAOZzsXHK+oJNH4GcVoa7ujph3
         vET4kj0k272eJplJyWKqGojwAmFg/YuM4prRhb7l2cKjj8dDHFw6wqM/okNdk2Ftv/FL
         WePS7sAZPVPTArf/yf2wYdKCqzTeB+MyjCuzBqmZnZBDbQ3QMr5vJrvDieTyNRVTXn2d
         RQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtdAaEqJ+OgUUPAXBPbeBnhYUUGO94r1mRrUVzyKNqw=;
        b=EFFlhFWQ0Fb44JfAcMDDdZa/TgLeWKq6yquJKBamojm8a7IDrp0Oc+wQOuW+oIzSSO
         gPsHEJqVKTeuhAZHONvkv9lVOvbR5l8XopO5FJ6GBDrzo4r7n54etEMrhuIgtW1kKzan
         2VZnh4KlCrZ9++H4/MUzOf8fSp+mBmIxEWuf8jwgCnjCZ97bvXKov2g9Bg9DbGZWP6zx
         eq2Kq5h1oOLPBq7TobkfkUyzh65yYzbTsHB5e1JugITLskWa6pp/hJgz2na8VLqth+vZ
         8RoYhU8CichiawTLmud2oP4InVMLQh9/+OJ4aKdqkh8UDN45qUUSLLz13jVBmkSVaJJM
         chgw==
X-Gm-Message-State: AOAM532eJRGIyLlvyAma5teNBwlG/HP5f0dv5ELbvcnndkQft0LW8CGB
        IP2dd84gvkSsF0nY9NfMSBWZ+z0p+SD2dj+Z
X-Google-Smtp-Source: ABdhPJwCvYxaM2sHo0QhAxW+Mm5PK5lmxhLKKwKNhoXwmQg+a/L2rTXiNEg6zDYQlv3SjpfxITC8jQ==
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr935004wmi.55.1610525294937;
        Wed, 13 Jan 2021 00:08:14 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/30] drm/amd/display/dc/dce80/dce80_resource: Include our own header containing prototypes
Date:   Wed, 13 Jan 2021 08:07:37 +0000
Message-Id: <20210113080752.1003793-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:1126:23: warning: no previous prototype for ‘dce80_create_resource_pool’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:1325:23: warning: no previous prototype for ‘dce81_create_resource_pool’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:1520:23: warning: no previous prototype for ‘dce83_create_resource_pool’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index fe5d716084363..725d92e40cd30 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -60,6 +60,8 @@
 #include "dce/dce_i2c.h"
 /* TODO remove this include */
 
+#include "dce80_resource.h"
+
 #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
 #include "gmc/gmc_7_1_d.h"
 #include "gmc/gmc_7_1_sh_mask.h"
-- 
2.25.1

