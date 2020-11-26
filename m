Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4B2C5646
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbgKZNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390906AbgKZNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F029C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so2196267wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMzTR5vhzo4BdnrJCmrInB6ds6XJwPsog3Z9fF6R2ds=;
        b=YVnwZsrr7sG3BHYwtr4MQW0aFJrpyD1AMT0vIyWvKcE71Md7uD7/R1HGxpYrZ+mLGc
         LeFTtH/ouu+XRI7m5k3wKbRSAWdT5hheLq1/QuRnxmNDiTlgIFJrrhudBnl8EV/RLAMr
         wWnX0ysGFBkhWiW/dGtbfC21e0xIXHmByq6e5otpAD420wMf+55cFJRcDnp6qajBpAZ4
         n87ywLwxtWbV8AiwIdfNBlpxykEfpASJ5MNiA0hqqd4t602Rt0Xo//VKfwTDbymFhPd0
         1144Nr5rim3Iu8GIBe+FjKnKVgabvyK9pIRGoq0tYp4NYkA5aZApC60sSMGcrkzNUDuU
         TKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMzTR5vhzo4BdnrJCmrInB6ds6XJwPsog3Z9fF6R2ds=;
        b=GbkZ0jAIX3ftnSpBsEgsDa87UxuUbK0lZ4g8/l2zKulaGLenaHJEkNIGigTxfCldmp
         veyDC1pPgRYttIBVa5WNaFjFUv/kf9eVB1JrWALh31Mpq7+nQ27NmD5JuUtvPA3WGExe
         4Ea4d1L3hvEphlmggdCF0NDw/sQZU+MoSDh6eAIWG8ZcqJQf7LGhFxO3INPTSHL4Bc++
         mibmZNkKpw8P/vb4UQ5kOXakr0KJq+AmuM4ph3xqeH/JpMvhnoprYci606qIOoFB6RMh
         ZWrTRVKRFxkYq2mW7gBR3EXRg3jIlLGOttWVv+ZUpuAnZ05TMe9asRKI1OvwGa2UyGB+
         v1ug==
X-Gm-Message-State: AOAM532gEQTcpFDeKR0jjuPApgSKADMk8XigRAU80vWg47VeQv01pO+Q
        kP3uaphAK/XeNh6rz8+kjlNFWA==
X-Google-Smtp-Source: ABdhPJyhtdnIH1ikDDVg8piHiBypOWo1mfmoQmPid3U6du/K6yVg2piBxR5ziT9lEe57b37KzCa5WQ==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr3536392wml.136.1606398204018;
        Thu, 26 Nov 2020 05:43:24 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move 'vega12_hwmgr_init()'s prototype to shared header
Date:   Thu, 26 Nov 2020 13:42:26 +0000
Message-Id: <20201126134240.3214176-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c:2862:5: warning: no previous prototype for ‘vega12_hwmgr_init’ [-Wmissing-prototypes]
 2862 | int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
 | ^~~~~~~~~~~~~~~~~

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h             | 1 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 393e4e76a8961..499f2520b1aa3 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -830,5 +830,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
 
 int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
 int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
+int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
 
 #endif /* _HWMGR_H_ */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 7999091cca16e..49f8a331eb02e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -47,7 +47,6 @@ extern const struct pp_smumgr_func smu10_smu_funcs;
 extern const struct pp_smumgr_func vega20_smu_funcs;
 
 extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
-extern int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
 
-- 
2.25.1

