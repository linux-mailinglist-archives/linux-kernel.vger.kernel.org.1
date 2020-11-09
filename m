Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868B42AC703
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgKIVTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbgKIVTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so5974052wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nw6A8bk/xb3oF0GjjrWfN8mr8P4GAXIbWL67zCF8LOk=;
        b=xffKJqvPcoVpjX49CD9iPngImypKFrocw+0RBun/VUNAfSfLuUnR0X8h9ZvT33k/sS
         o7nKicVgJtcPFneOEneZ7flekt6bjeIRwpD8cyyv0PTIrfpPpKSu3AIALYPSs8jGW7Ny
         YllwT7lzXzObLav713wvGeTJk0uasvrXtGa5RUwqQH2pVsBn45qDDiJ7VQs6Su60k3P/
         3ZqJAoEe0RyHAdp90UhuMRhyC+F8NaTAQFWqB0WJURo28AiPzFAwLUIt8HZVCAe2MOuJ
         RhEx4AxLBHo4loQ2xytFlPGMkYHgp5grST5XuwpZvs0VD6/GmfjlhFgjs4dPzNBCCwsD
         JGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw6A8bk/xb3oF0GjjrWfN8mr8P4GAXIbWL67zCF8LOk=;
        b=JB/14san6J5o5eO6EyHHD7H8PLltVAmHBWYsyHgo9xVSas5OBKwQMRB5yaHcvdp288
         nKvMyH9QElBMt4CdL+Y7Qvvy7pq6FsB0tsSBh8cYlA26Uh3eorHHc0FS35Qnt1sEKY+S
         hYMXtDaU0ZeO24wnDgq7+FeRI7sNEg/O4pAve1Nl94yhsF1zUpXA3PMnkrg/iAG8c1EL
         uLD+NrLG3Upao8LsY+0JJ/vyOayyyeJa0c680a8GGSSr696hZpcxyAQz+L1tDaXZiSe2
         u1Oyr72Dz8pjLzfEco9tHd1NA76D76mSgOgoFnkHKqRcyaOXo0DNNgflkbkdq9WTFBpj
         DPww==
X-Gm-Message-State: AOAM531F3lVG7uOPS7i3Qzta3rrwYLtCsZZnsEgzbsWKj9TI9yWVmWcR
        YKBOcsSv7bhIYgUr+NmCregY9Q==
X-Google-Smtp-Source: ABdhPJzBYCCxbeqDxcy+cqzF/zmtWBihGaalt05+pmFyUXq30I6+OlzY9me0l/+GZ0wPMixKzRfEGQ==
X-Received: by 2002:adf:8b84:: with SMTP id o4mr20360420wra.269.1604956789425;
        Mon, 09 Nov 2020 13:19:49 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 20/20] drm/radeon/cik: Fix a bunch of function parameter descriptions
Date:   Mon,  9 Nov 2020 21:18:55 +0000
Message-Id: <20201109211855.3340030-21-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/cik.c:1869:5: warning: no previous prototype for ‘ci_mc_load_microcode’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c: In function ‘cik_gpu_init’:
 drivers/gpu/drm/radeon/cik.c:3181:6: warning: variable ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/radeon/cik.c: At top level:
 drivers/gpu/drm/radeon/cik.c:4852:5: warning: no previous prototype for ‘cik_gpu_check_soft_reset’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:5850:6: warning: no previous prototype for ‘cik_enter_rlc_safe_mode’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:5871:6: warning: no previous prototype for ‘cik_exit_rlc_safe_mode’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:6289:6: warning: no previous prototype for ‘cik_update_cg’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:6421:6: warning: no previous prototype for ‘cik_init_cp_pg_table’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:6678:5: warning: no previous prototype for ‘cik_get_csb_size’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:6710:6: warning: no previous prototype for ‘cik_get_csb_buffer’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/cik.c:3084: warning: Function parameter or member 'max_rb_num_per_se' not described in 'cik_get_rb_disabled'
 drivers/gpu/drm/radeon/cik.c:3084: warning: Excess function parameter 'max_rb_num' description in 'cik_get_rb_disabled'
 drivers/gpu/drm/radeon/cik.c:3084: warning: Excess function parameter 'se_num' description in 'cik_get_rb_disabled'
 drivers/gpu/drm/radeon/cik.c:3114: warning: Function parameter or member 'max_rb_num_per_se' not described in 'cik_setup_rb'
 drivers/gpu/drm/radeon/cik.c:3114: warning: Excess function parameter 'max_rb_num' description in 'cik_setup_rb'
 drivers/gpu/drm/radeon/cik.c:5662: warning: Function parameter or member 'mc_client' not described in 'cik_vm_decode_fault'
 drivers/gpu/drm/radeon/cik.c:5690: warning: Function parameter or member 'ring' not described in 'cik_vm_flush'
 drivers/gpu/drm/radeon/cik.c:5690: warning: Function parameter or member 'vm_id' not described in 'cik_vm_flush'
 drivers/gpu/drm/radeon/cik.c:5690: warning: Function parameter or member 'pd_addr' not described in 'cik_vm_flush'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 5c42877fd6fbf..4494f9122fd91 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3071,8 +3071,7 @@ static u32 cik_create_bitmask(u32 bit_width)
  * cik_get_rb_disabled - computes the mask of disabled RBs
  *
  * @rdev: radeon_device pointer
- * @max_rb_num: max RBs (render backends) for the asic
- * @se_num: number of SEs (shader engines) for the asic
+ * @max_rb_num_per_se: max RBs (render backends) for the asic
  * @sh_per_se: number of SH blocks per SE for the asic
  *
  * Calculates the bitmask of disabled RBs (CIK).
@@ -3104,7 +3103,7 @@ static u32 cik_get_rb_disabled(struct radeon_device *rdev,
  * @rdev: radeon_device pointer
  * @se_num: number of SEs (shader engines) for the asic
  * @sh_per_se: number of SH blocks per SE for the asic
- * @max_rb_num: max RBs (render backends) for the asic
+ * @max_rb_num_per_se: max RBs (render backends) for the asic
  *
  * Configures per-SE/SH RB registers (CIK).
  */
@@ -5654,6 +5653,7 @@ void cik_vm_fini(struct radeon_device *rdev)
  * @rdev: radeon_device pointer
  * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
  * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
+ * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
  *
  * Print human readable fault information (CIK).
  */
@@ -5677,11 +5677,9 @@ static void cik_vm_decode_fault(struct radeon_device *rdev,
 	       block, mc_client, mc_id);
 }
 
-/**
+/*
  * cik_vm_flush - cik vm flush using the CP
  *
- * @rdev: radeon_device pointer
- *
  * Update the page table base and flush the VM TLB
  * using the CP (CIK).
  */
-- 
2.25.1

