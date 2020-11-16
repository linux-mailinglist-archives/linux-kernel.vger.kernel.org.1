Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE692B4D60
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgKPRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733183AbgKPRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED069C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so19604359wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
        b=d2v+UQdDsneXlTN6mpwGtQa1JII7loaPK7FtyMdxwBh94nR+RMRJ2sdDSYWiWA4Gdi
         Fsfex/7l3c1d762P+eJfgiwtQweyGf+VyN6BqpR170YJE1cYPNRrZ2c4aQsXcc4rPdZJ
         otnuSbCzU3hogR5xqxla71Y0DxcVOGr3gnwv3HURcr7LQCg51B+f6/qNZ//m5TOu71hA
         gR9IG8kLM7fkPhoX4mWRd0t02ouUlxB7dBZQQN1h8Sc4P4hwG3Px8zuCPyOsPqB5Pz2m
         lsqp/V2hrnhwY7hSpbuRGaQ44N+AU0CUgjVfNQhR9LEgD9IWQYmyikJu0q16dQ81tnF+
         pGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
        b=GNKwQjvj2t3sUKWeNT0XX9cpEW11BI559s6CaTs7EpR95qpeA1kOPcNZLaK5yawYKb
         HQoZ5nHMTCpq1jyRBziOI6iw35RO2kfWmNRJqm/l5mKpTIFqctEhFULzlh78kSTbw4kQ
         lCJriry7IfWXrBBeXNx+S4PsIFqeT7TdHn+y0ri3cFz2xRu6Yyob30y//QKd9/OYd86M
         lmpx5f1pHIl8rXxu8CAG//IBWMIRFMReRoEIOoqNeHWM2fdpa7m+dEMBvJdMlM2Ctk86
         1D2guS77xoSHOhpTB0Bp9BFEnJtxXWXm3VKimeHOLRPmSrAyDDwjJspjC8fTooY+uCtF
         5JOw==
X-Gm-Message-State: AOAM5322wHHvSksU1LArGUKISt6khbRgz/gYxjQz88PLOgCEIcCqDjih
        pQomEiOMyK+xKRufoZvu5nY0Sw==
X-Google-Smtp-Source: ABdhPJyHYdBcdf6dmzu+ALix2+ZPddVQAxDPKulZ23x4FWjXmT0ZNsPvLa6uH2tvTXV3+CtTi1fmzA==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr20435374wrq.401.1605548228653;
        Mon, 16 Nov 2020 09:37:08 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/43] drm/radeon/radeon_kms: Fix misnaming of 'radeon_info_ioctl's dev param
Date:   Mon, 16 Nov 2020 17:36:21 +0000
Message-Id: <20201116173700.1830487-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
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

