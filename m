Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3448C2B0D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgKLTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgKLTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C8C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:51 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so7185661wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LK83PtW9bWg13v6GeG4X98Td032TuGFWFjyFs29+ymI=;
        b=vq4ZP2TVmSqBWCOE1Wu+ytkEKp2xRQfUssN2R6DGgz8tFeRWOgvoEvdWsZE8eSlmzX
         T7oLXH66Lae/Qr3uAOim8byoaRyb2q3k1zhgoit1n1huKS46ig4/cKUNdvroiUKa/I6u
         8RlUhEltZ4fv7QkMnn8qg5Et2eUaCE5zH1UHNRevW64lB/xOIJYt63WmEwYZi//AB+2V
         8sRr68YKSZyT5rl6FSfWtakQZ2iKFLJCyzXGyqBj4oUEsvSCHlMgnamLIx/7sEwt23rj
         WvRMy83ztza+CoIFdi9oVXtjeaJuN//QojE3MCEUeE7da8G4FVpucVGnWk3KSi0H8l0q
         TJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LK83PtW9bWg13v6GeG4X98Td032TuGFWFjyFs29+ymI=;
        b=LpFK/V2Wx/a6wMQzWk19WhkrqmRV6zcGg/BU9EUlOif5opzJBGHusgKNQeGERyVp0b
         g1+uZrW0jOEHM67ZhIM5PAo7yULUNjVH/9Mj54JI0z/dMxW2xlvwQ1SNnPbXLvqmJPpE
         LGyB7KlrIe+QvO1KdyaFodKB3YcgN+N6Yjoo6d0BxtcG1uf8vwow8z5pTtLyGyU6VZC5
         CrTmMfEirq2gb5O28/fi2rlhdAzeNR1RoJ3C020Sfa5OUULEEkgFHrh7n9dhyy6Y1hxg
         rS8LbXafYH4rGJqKUb8GEkDOB9HY2BcPta59Lkx6PH8uKO+iMTqVck3JSFKHV2+Rwhx6
         YUJA==
X-Gm-Message-State: AOAM530bvCLVoubqdlzC2fWgKccgTJGyd7+9vsW/Iy1BkL5R+K5MXZcH
        aD21WG2WKsTqHkQdy6gOIIWo+7uUHPqaO1x6
X-Google-Smtp-Source: ABdhPJxNEnxvjxLyk9I2A+iSYrZd6QKCswPKKcJgp9Bl5EuD0dpUMbW/MXKoV3grMsaYvi0XW92N5g==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr1112855wrt.312.1605207709781;
        Thu, 12 Nov 2020 11:01:49 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 29/30] drm/amd/amdgpu/atombios_encoders: Remove set but unused variable 'backlight_level'
Date:   Thu, 12 Nov 2020 19:00:38 +0000
Message-Id: <20201112190039.2785914-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index fa817ebff9804..af87505ad7d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -171,7 +171,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 	struct backlight_properties props;
 	struct amdgpu_backlight_privdata *pdata;
 	struct amdgpu_encoder_atom_dig *dig;
-	u8 backlight_level;
 	char bl_name[16];
 
 	/* Mac laptops with multiple GPUs use the gmux driver for backlight
@@ -207,7 +206,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 
 	pdata->encoder = amdgpu_encoder;
 
-	backlight_level = amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
+	amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
 	dig = amdgpu_encoder->enc_priv;
 	dig->bl_dev = bd;
-- 
2.25.1

