Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136EC2AC6F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgKIVTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgKIVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so918295wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mP6ncVP3tb6PBoh8PR+HhOmxf1xJDs0FPGkTnD+ivtc=;
        b=KFykpLfCS//ZsH9E/r0koc17hviNUTM0dyZhwgahRURu3RDlD7WSTPyYvfI4R8B37N
         ZFI3daldAmSN6II7vkZ85e3c/io1Z3RNNLihM2vj4e44wuAlM7r5dqaY2pDwC8H5SDhx
         MVXosMn+hWDvCRWFW3ZAc6jqRmjlJQqoWzd+x45NGezmyeXfjnPyZNr4TX3GenC0Kslv
         8jDKQGDpJUYd5tCK0MisiUthJtNJogiZomkAVQ4mIqAEpuMMcUSgIerN9BLCTgEJ9vGL
         +NKWgQHleOmv5Wx5VeN25Eq5miaw3qZyfxGB+zMrOE+/foVnBu/M/3DohTb7/Dk+ROoN
         7rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mP6ncVP3tb6PBoh8PR+HhOmxf1xJDs0FPGkTnD+ivtc=;
        b=k1M8f3XCMQS5kFvtfRV7mYITPySnKPLNdIQwAw26/co5ygN8FRtCsi7lbXUJGmduyS
         zgSOys2X5wa0pWlMJ1pgyYhoXMvYE8VfHwGKWjBK8+VlLwNC7VVfxUBMkxd7rh7Yuam+
         ZAGHee+6p00zKlW6qI3xHoLfXkf4khSbWugU+Drud1Qel/WwIP7D5y4mMFi15aHJkc/2
         mU8MfaTP/+omlozpW1v6Vr8VNhMBBDP7rIn20Mn5njVSElhmfC0+xlN6c3FpPoLKcnEs
         NFAu9YD5ElwzWGZQd4th5RIWCoihhjJ9XPyFZq955RBCC73G1kANH+7cAZ9f5wVOPglj
         +3Xw==
X-Gm-Message-State: AOAM530n5EkIfmMyaVHoMOJRrQ+WY0mrmuE64dnwuhyQ3PzQbXuTPwQy
        ZmnRV2b+KxVdITP+KHs8zMEqlQ==
X-Google-Smtp-Source: ABdhPJwMQ0THyZ4Mbc995Ryvr/CJnNf+FANW5IqZWpqhZmq6ig24FVd7CojcL67BKR9smBQwsI+Y4A==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr1125386wmd.95.1604956773891;
        Mon, 09 Nov 2020 13:19:33 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/20] drm/radeon/evergreen: Move 'rv770_set_clk_bypass_mode' prototype to shared location
Date:   Mon,  9 Nov 2020 21:18:48 +0000
Message-Id: <20201109211855.3340030-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/rv770.c:1138:6: warning: no previous prototype for ‘rv770_set_clk_bypass_mode’ [-Wmissing-prototypes]
 1138 | void rv770_set_clk_bypass_mode(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.c | 1 -
 drivers/gpu/drm/radeon/r600.c      | 1 -
 drivers/gpu/drm/radeon/radeon.h    | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 14d90dc376e71..3541a9444be22 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -223,7 +223,6 @@ extern u32 si_get_csb_size(struct radeon_device *rdev);
 extern void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 extern u32 cik_get_csb_size(struct radeon_device *rdev);
 extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
-extern void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
 
 static const u32 evergreen_golden_registers[] =
 {
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 6e780b0109995..9587792503525 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -112,7 +112,6 @@ void r600_fini(struct radeon_device *rdev);
 void r600_irq_disable(struct radeon_device *rdev);
 static void r600_pcie_gen2_enable(struct radeon_device *rdev);
 extern int evergreen_rlc_resume(struct radeon_device *rdev);
-extern void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
 
 /*
  * Indirect registers accessor
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 421f6b26512ed..32a2c894ee3ff 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -280,6 +280,8 @@ struct radeon_clock {
 	uint32_t vco_freq;
 };
 
+void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
+
 /*
  * Power management
  */
-- 
2.25.1

