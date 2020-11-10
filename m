Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F862ADFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgKJTds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgKJTbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:31 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BFAC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so4300249wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLMSTbAF92ExvmzWs2JoLwFgJtHWMDt9gk+mh90YZlk=;
        b=vS46JKcEmSWEQ3jxokyfU3VpP+Kg5LtmqXQcuf/5Lpde1IBpJDp2rXzKHT9D2/Sn5J
         yCgGGCxwdlJNzYtFFtYduZNnDZW8g7uzYAawpyS49TyAd1vEMgQLCnuL7DuH22jt4jmE
         /flXpNq4bfxjgNX0LGd6afTlsweLI1uevM8eoFZSv5F3HHg0BuqX6D262fuEtKnk/n9/
         slWy4R9tVgQaF1FOGG56x8ognPP/x2Grl1EEOyXYILf0zJAIguIzqxePHoQLKZ90QQyN
         BJdcIKLygprzsTLHGs4qnZzfIJUPOjadAD49f8ag10HK38i0fzolUac0mlThHXgdqn4F
         hZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLMSTbAF92ExvmzWs2JoLwFgJtHWMDt9gk+mh90YZlk=;
        b=pI0lgJF3GkyM34HbmHpWVy46tlCvmEaOYxremzPLYx3QLo1RlgkXb6nKRsc/NsiCjS
         2I1tCHJ47ZrjSknghFaNkEeYbPFO5CndV0q0064wiO9xPdte+kV+Yzeoey/+WFwstSfS
         Piao7+dq3UWFYL/zz692dTXTZIo2VRu3SlFQFbU/HrgqykF9XJBhvyQyXhzJCY4NWMPp
         V6Y8BP5aEiSnjdtdsgWuSrC5BUfgSV6ZkO4ogkkoEwlJ4lXbLO0C4mfAmr3z+w0rhZ5m
         vuGqfMH5xknMTlRRNrhHCtVMzfOSQVj9ZZ90Npv2EPM2a1K/Yc5GvSQfk9n6D/Re9KIi
         G+9g==
X-Gm-Message-State: AOAM5329iIqI64THr53K6npXs8uFvG4fikx+sAwQ0GYO8XxrjuJ9Nemn
        qi/DbRDZNPolpnnd4XOEYzSq1g==
X-Google-Smtp-Source: ABdhPJw/JxxqA18VBzRvlKN0u/UYpIts1gzl/5bw4Z+3TTPyCM+aH12jT763m9MwukJRI3bn6bSaeA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr764766wme.0.1605036690396;
        Tue, 10 Nov 2020 11:31:30 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/30] drm/radeon/radeon_ib: Supply description for 'radeon_ib_get's get param
Date:   Tue, 10 Nov 2020 19:30:53 +0000
Message-Id: <20201110193112.988999-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_ib.c:61: warning: Function parameter or member 'vm' not described in 'radeon_ib_get'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_ib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_ib.c b/drivers/gpu/drm/radeon/radeon_ib.c
index 9fd55e9c616b0..c1fca2ba443c9 100644
--- a/drivers/gpu/drm/radeon/radeon_ib.c
+++ b/drivers/gpu/drm/radeon/radeon_ib.c
@@ -48,6 +48,7 @@ static int radeon_debugfs_sa_init(struct radeon_device *rdev);
  *
  * @rdev: radeon_device pointer
  * @ring: ring index the IB is associated with
+ * @vm: requested vm
  * @ib: IB object returned
  * @size: requested IB size
  *
-- 
2.25.1

