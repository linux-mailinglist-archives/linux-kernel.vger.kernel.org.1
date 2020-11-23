Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16332C0465
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgKWLUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgKWLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:18 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89DC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:17 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so18235469wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUeixF4MexcQptzRTHrmHc3KXAc8UlMXol5+btOxzyI=;
        b=Mgn5NMLhJpAl73mAfi6yoe9e8RtL/B1FIcdsGg2VTegVerYl9+T3G23KUJvYn0BDoF
         dlBP/X8WktZxc0ZCu+O1ZljebWw81+gjSvSbLG5Bdk3nGL5OBbiZzNo9YhiQIKSF1lUL
         gOix0w2ugmEjS9JVXUW28BxIQSvVZdpD8jZMgQi92EHVLJHcXDFnYWL43sF4I96SBH7/
         D9sVx3HH7YaHGxybPEAnIA4O5QASV4xoEgRv2q93MKVZfRajp6lsW72rlLbIGxKvetL+
         /YpGoq+Ty/beR9aTF2YRNUaA+MPUlWoK3EMlvY7XVLzZdA6Bc3uv+HsiBmhRl21IeO4j
         TSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUeixF4MexcQptzRTHrmHc3KXAc8UlMXol5+btOxzyI=;
        b=S7JCxGk+oseqE1z1PoCW9sleF6sQFUh/HIu8TL4JJG8Q6bwGag5Ba4+zMWCM6tF85/
         mqU8PvwpsOvZTFEh/Jg3N3EEG0QQ4xP4r5VYEXPhHr5Q3mbsIwiaqizfKrVQicXOqVS2
         1FAbRUvGDUFI1qyfk6yke3Hi0/7klOQzKXdNu5oTPqJHje8hgE9w1+bCmbRt66zzppNy
         saHUHpxmSl46w8Tr+BugAx6mpBPhNkwWNX+OLuzntSXhZ8QI5PtPTVM0rcB7QtqARN/7
         8jPQejVfzQjjZwwmUMjRTrjRZQHW92+FtwJ+pmV3EA+5/GTw7Yn6Qk7vgQ3feUSLrAHT
         y7IA==
X-Gm-Message-State: AOAM530hp9/s0DUu+kB4gMZevPRrm7NRi4bryO6AwTJIbYHrG129O89N
        ffWdfQygdI+gf2LiGcYchUdb9JXKxzGEETkj
X-Google-Smtp-Source: ABdhPJwf1MG0nyF0KLJfvrLqdG9CK8RUAZrjaSqIDR0mr7UkahjCOL9jww5T+xSB+9uq9C230bQPuA==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr30393682wre.413.1606130416608;
        Mon, 23 Nov 2020 03:20:16 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amd/amdgpu/gmc_v9_0: Remove unused table 'ecc_umc_mcumc_status_addrs'
Date:   Mon, 23 Nov 2020 11:19:18 +0000
Message-Id: <20201123111919.233376-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:382:23: warning: ‘ecc_umc_mcumc_status_addrs’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 35 ---------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 0c3421d587e87..fbee43b4ba64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -379,41 +379,6 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
 	(0x001d43e0 + 0x00001800),
 };
 
-static const uint32_t ecc_umc_mcumc_status_addrs[] = {
-	(0x000143c2 + 0x00000000),
-	(0x000143c2 + 0x00000800),
-	(0x000143c2 + 0x00001000),
-	(0x000143c2 + 0x00001800),
-	(0x000543c2 + 0x00000000),
-	(0x000543c2 + 0x00000800),
-	(0x000543c2 + 0x00001000),
-	(0x000543c2 + 0x00001800),
-	(0x000943c2 + 0x00000000),
-	(0x000943c2 + 0x00000800),
-	(0x000943c2 + 0x00001000),
-	(0x000943c2 + 0x00001800),
-	(0x000d43c2 + 0x00000000),
-	(0x000d43c2 + 0x00000800),
-	(0x000d43c2 + 0x00001000),
-	(0x000d43c2 + 0x00001800),
-	(0x001143c2 + 0x00000000),
-	(0x001143c2 + 0x00000800),
-	(0x001143c2 + 0x00001000),
-	(0x001143c2 + 0x00001800),
-	(0x001543c2 + 0x00000000),
-	(0x001543c2 + 0x00000800),
-	(0x001543c2 + 0x00001000),
-	(0x001543c2 + 0x00001800),
-	(0x001943c2 + 0x00000000),
-	(0x001943c2 + 0x00000800),
-	(0x001943c2 + 0x00001000),
-	(0x001943c2 + 0x00001800),
-	(0x001d43c2 + 0x00000000),
-	(0x001d43c2 + 0x00000800),
-	(0x001d43c2 + 0x00001000),
-	(0x001d43c2 + 0x00001800),
-};
-
 static int gmc_v9_0_ecc_interrupt_state(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *src,
 		unsigned type,
-- 
2.25.1

