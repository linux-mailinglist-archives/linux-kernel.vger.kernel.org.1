Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2FF2B4D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbgKPReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733034AbgKPReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:34:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BBDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:34:05 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so2442726wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEyPNgqrCvgW7yAtw6B6vQyE222bBpFcTf7vHkr21Ko=;
        b=OPtujtuUIiaHPXrwEHhBFdgesbmCfs+lQzSA9SMtgIcwEdph0SW0wllmS/L3kUHbce
         Y24r/TzNwhqkpzekveoWb2t/h8FdnLBdgOlMPfvBjCMe8Jm6tixGksZAvVCDSNvZllNX
         Awv7Cl117cA02/Z5UmFgwEmfpwAq22KGcXm07IXFwhz5WMOBfD1wfNjs1S31Sb5Sk4WT
         egyPpwERRQ/nrOL0xiS7btKXz53rGfcr/yv6NK8GkUlxkkvZ1jjLphtmn8iqqVCH9QkQ
         IxUTqhA9CNRLEmHcxm8l3EE8sPji/wzUvnULxrXfhBd3BS97mQjTD01EQKD4MprDzcPn
         m4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEyPNgqrCvgW7yAtw6B6vQyE222bBpFcTf7vHkr21Ko=;
        b=mXrzAvzCaISHPu7u1JKKqOTQI//N6oXuOwCFMPQ9AJ5hMcyrMwHpW3YI86walzQhXO
         FEb71/LRgoo2y9OSh/+8GKbBTRDhnk4U4VHXircO6AcGa14Q1erueFwYnybQ8jNj0ihM
         NJrE17Gd3cn5LyITthFy8fxd0RPRZGgksQM4GrHTVUGjqrMdpwdJOlzVSImrWapiSq5D
         SLcD2xAYqrHH+bGwKnHk64ofrC4vM57DYUZyZ5jeSCP4KTaErPu493T0iBICaYsQVVQd
         WC0tvJ2ZYJ9FiYeU7Biu/1qtN7eCrPVxVWEBXHyB3y2smzYidp/gA2NsnxoTi1aqiCA2
         R4mg==
X-Gm-Message-State: AOAM5312JMpzOdGQ4eyaJYT9tY5roOh6FrFTJrrS140dfTQQzMLrrDs7
        9/snfD0Is9eyUd995ltst3FoLA==
X-Google-Smtp-Source: ABdhPJw5cdJSme1gFB4p1vRURW8tGgzc+PR1zOkEEnozjGPApXdvviPVdnHkmMFtk08Wc3vjnElPbA==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr21978405wre.55.1605548043787;
        Mon, 16 Nov 2020 09:34:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k22sm20178562wmi.34.2020.11.16.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:34:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/42] drm/amd/amdgpu/atombios_encoders: Remove set but unused variable 'backlight_level'
Date:   Mon, 16 Nov 2020 17:33:15 +0000
Message-Id: <20201116173356.1828478-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173356.1828478-1-lee.jones@linaro.org>
References: <20201116173356.1828478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also removing the call to amdgpu_atombios_encoder_get_backlight_level_from_reg()
since, according to Alex Deucher, "We call it again below indirectly".

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: In function ‘amdgpu_atombios_encoder_init_backlight’:
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:174:5: warning: variable ‘backlight_level’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index fa817ebff9804..6134ed9640279 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -171,7 +171,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 	struct backlight_properties props;
 	struct amdgpu_backlight_privdata *pdata;
 	struct amdgpu_encoder_atom_dig *dig;
-	u8 backlight_level;
 	char bl_name[16];
 
 	/* Mac laptops with multiple GPUs use the gmux driver for backlight
@@ -207,8 +206,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 
 	pdata->encoder = amdgpu_encoder;
 
-	backlight_level = amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
-
 	dig = amdgpu_encoder->enc_priv;
 	dig->bl_dev = bd;
 
-- 
2.25.1

