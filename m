Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105652B4CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgKPRaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732908AbgKPRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:17 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8AFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o15so19607964wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
        b=NlJq01yN62/e77yfB6ZomE53I8U56CttbAyj4clNq3rSMAmYjlSxdP0xAxdwITbYtW
         sNZ+AOXxf/dARjEuzp8azDZAHdjkgVt3bgmqM8kJb93CiPxgqwvl/zDtxvtZ3Nazf1xH
         u9C2opkk5AwyxzR1/c+HIM70U3y0+DMvcTOR3Ks+QceLv/sm37rlMYYDvKervOmliQyA
         UfA4WtUViRXgfqDRp0doP55lKhCFdsD8+fuQo7Whu60IdoD9P0nAGZkFxZjZawoE2go3
         wy7km/HXTpoxfzK7EE3prhyBihjsz+RHRU9qKmVPPhCHynV3oXCsokAfORHJ/A0SM0DI
         9B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
        b=tLyl8DI9jNeYOMWREVZt+DvFMUGUmW4SzqAM6K8c0ZItr44txTzIydxdlf5l1S1JGW
         yIbq76mofKIZh5Iu+ZMhqfUVU5qV6zuZlik9ToES6hE8boPCfwcYi1KT/yb6u4FItGHP
         Gax8Ipgh3tyGC6eeX+Ni6ueVDL0WHBj2euw6VcVxEdNdigYhxPNYlg50mUFZtSJOgbd1
         OkV5DJk47kPyAUV8IYe6jFhChzu7vVWzUmb57j+AthXrcyYQxYlX4Zzz8YEc7qF6q/b0
         x8uTK0/ARvwa6M96OHWKb79PyX3DoqIEzlP5y4pp8pe/i/ic1xO/+o2eVOpa8/2KQi6Q
         /IYg==
X-Gm-Message-State: AOAM533OtSu6yq4gp7tq+wRK0xAm6uaVTrEt0Y0d/Kw4O1LPZhEs0xXH
        ku2PZKBt72bF1DtO7V4QeuLs4Q==
X-Google-Smtp-Source: ABdhPJzNyPRVW8DvUesFVvmx/nClszHTRSPl0Vnt9bPBF1ji/XhJH0dcpzMuIM/ufUrQZsxhABOndg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr20990525wrr.1.1605547814676;
        Mon, 16 Nov 2020 09:30:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/43] drm/radeon/radeon_kms: Fix misnaming of 'radeon_info_ioctl's dev param
Date:   Mon, 16 Nov 2020 17:29:26 +0000
Message-Id: <20201116173005.1825880-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or member 'dev' not described in 'radeon_info_ioctl'
 drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parameter 'rdev' description in 'radeon_info_ioctl'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 001940bca90a6..50cee4880bb46 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -214,7 +214,7 @@ static void radeon_set_filp_rights(struct drm_device *dev,
 /**
  * radeon_info_ioctl - answer a device specific request.
  *
- * @rdev: radeon device pointer
+ * @dev: drm device pointer
  * @data: request object
  * @filp: drm filp
  *
-- 
2.25.1

