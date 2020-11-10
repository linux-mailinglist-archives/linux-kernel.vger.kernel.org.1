Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71F42ADF62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbgKJTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgKJTbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E013C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so13991173wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=niuclzZLrXXllUvyLIlNhRMSWO6LD3jFvv7VGpxMEl8=;
        b=ZoCAeWqOWnwlTA6KsKAUyspJhNqifj65RCAJ2Bbve89rw9W2XKZNT8qx9vnCUrG+70
         +CFU7uXuG2uDCdH4IBNlSUQYOHyma6KqozSOVJNzx7fLBiC495M1QHG0kXo7/De7OnpV
         ignD954xFpyTo1V0XphVRlSM9fXgFrtktfiGjgPGjjmbnm/3S9aSybfx0jc/kSFQhwP1
         M8jJ9JEPfjZZ8zvDkowuVkWPF6K0LaTkW3Dw+aOje1kLR+21+ODvaMmJT1B9jfNaVC4f
         gukHJ0YC7YiPPKt1NOhnmVXVnDaLevKvD6A1tTGEjelGUVGvJaZjHxf7qmgAI4Q66Thf
         wtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=niuclzZLrXXllUvyLIlNhRMSWO6LD3jFvv7VGpxMEl8=;
        b=FO5zWMKghHsSM82vWvkqFqopEVDccR4YwSsqAUp76nTwFbB4kZRDe4fafxSJUEJQ8x
         6WZszKvZ9SkFoDAa/XCkBZhMVwR0cLiO85eEsSImWdg6WHP9ptQr4SI8COYFUh8ze3Rr
         kI2wrqLjaq8DMug6oDclRyP5q4arUjk1zaj/G6MqQ2wiGmagW03gkN5U4/1tocA9cvRb
         Q9qGf5FqSzbZv4B6hzRvtZ1AI7q4AmW8xPVfMQLH8QUy/ZAkJs/0hj8pSCPwrT95DLgA
         DNvb0Z9Bklw+dT2w9XN/pahqwkreRSbc3EfVXWnqJ/7RFPf72Lt82W57zU9IpCXZ4PgV
         oN3w==
X-Gm-Message-State: AOAM533Wb0LeALHm7R09g8I3wHUvywO33mAkB7dE2K9TCgkop1spz9/H
        RDpYmnmZlWb/5rliHfeqfvFTJA==
X-Google-Smtp-Source: ABdhPJwqsmo6of+IMvyqiw805zCVdsMN3uBXSMYMN1Q/gswxeuYmzYoGVdvtxQld+Ssvh6NkkiAaFA==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr8801086wru.204.1605036687702;
        Tue, 10 Nov 2020 11:31:27 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/30] drm/radeon/radeon_vm: Fix some function parameter documentation
Date:   Tue, 10 Nov 2020 19:30:51 +0000
Message-Id: <20201110193112.988999-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_vm.c:131: warning: Function parameter or member 'rdev' not described in 'radeon_vm_get_bos'
 drivers/gpu/drm/radeon/radeon_vm.c:643: warning: Excess function parameter 'start' description in 'radeon_vm_update_page_directory'
 drivers/gpu/drm/radeon/radeon_vm.c:643: warning: Excess function parameter 'end' description in 'radeon_vm_update_page_directory'
 drivers/gpu/drm/radeon/radeon_vm.c:819: warning: Function parameter or member 'ib' not described in 'radeon_vm_update_ptes'
 drivers/gpu/drm/radeon/radeon_vm.c:915: warning: Function parameter or member 'bo_va' not described in 'radeon_vm_bo_update'
 drivers/gpu/drm/radeon/radeon_vm.c:915: warning: Excess function parameter 'vm' description in 'radeon_vm_bo_update'
 drivers/gpu/drm/radeon/radeon_vm.c:915: warning: Excess function parameter 'bo' description in 'radeon_vm_bo_update'
 drivers/gpu/drm/radeon/radeon_vm.c:1155: warning: Excess function parameter 'vm' description in 'radeon_vm_bo_invalidate'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 27b14eff532cb..71f2edcac6ea0 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -119,6 +119,7 @@ void radeon_vm_manager_fini(struct radeon_device *rdev)
 /**
  * radeon_vm_get_bos - add the vm BOs to a validation list
  *
+ * @rdev: radeon_device pointer
  * @vm: vm providing the BOs
  * @head: head of validation list
  *
@@ -629,8 +630,6 @@ static uint32_t radeon_vm_page_flags(uint32_t flags)
  *
  * @rdev: radeon_device pointer
  * @vm: requested vm
- * @start: start of GPU address range
- * @end: end of GPU address range
  *
  * Allocates new page tables if necessary
  * and updates the page directory (cayman+).
@@ -802,6 +801,7 @@ static void radeon_vm_frag_ptes(struct radeon_device *rdev,
  *
  * @rdev: radeon_device pointer
  * @vm: requested vm
+ * @ib: indirect buffer to use for the update
  * @start: start of GPU address range
  * @end: end of GPU address range
  * @dst: destination address to map to
@@ -900,8 +900,7 @@ static void radeon_vm_fence_pts(struct radeon_vm *vm,
  * radeon_vm_bo_update - map a bo into the vm page table
  *
  * @rdev: radeon_device pointer
- * @vm: requested vm
- * @bo: radeon buffer object
+ * @bo_va: radeon buffer object
  * @mem: ttm mem
  *
  * Fill in the page table entries for @bo (cayman+).
@@ -1145,7 +1144,6 @@ void radeon_vm_bo_rmv(struct radeon_device *rdev,
  * radeon_vm_bo_invalidate - mark the bo as invalid
  *
  * @rdev: radeon_device pointer
- * @vm: requested vm
  * @bo: radeon buffer object
  *
  * Mark @bo as invalid (cayman+).
-- 
2.25.1

