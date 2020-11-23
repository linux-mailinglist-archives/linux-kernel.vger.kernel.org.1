Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5B2C0460
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgKWLUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgKWLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C71C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:15 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so17534842wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P119mFSQ3gSCoSYB/CN9/cMQZuTwsZhoVi6LljBTVvY=;
        b=CrRYYm/KGRuXUUR/ONdnY49DZdCnEJu/XQdHwr44D6hafzYw0j3GaZou7bR45m/YLy
         w7oUaMgSveRI2wSoPDH57G3A7SdpuMQfcEU8p7qd162FJG1Z/nAzhiO7dRC2gnQbC/vm
         PfEmtwcw+HGqx7OB4N24SgMpomvXZtGtwEsyx4SzW6GTRVcwDBTpOLVS8SoCFa22A6sF
         /3gu23WFyO3SC/QrFpSPMePYUsbWOF4Vm6zfw/OUfyR02zvkB1bH7dBVhByeI0X8Hjzb
         53JU2+DIwHKHSvO0tkb8bZu2RemE5bgp9AwkP/sRtts1p1ww7gYv5xbvTNFt6hTems3X
         mR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P119mFSQ3gSCoSYB/CN9/cMQZuTwsZhoVi6LljBTVvY=;
        b=mxtCbtA8/hVsLoQ5Q6ftOJV8LxIBHCQjn9Xe8D7Q+9zREHWdZJhdZsYmjbhqTU6QiM
         RvLzMjlFl7LNMNntSxypVuz48T/77fl8IWTa2Bk6U7+p5F/Uz3VV+MgTXwxux524O4En
         z7wuJdtSGzFzpT2jDWpfe6FYzqATHndpCb/WhhjfGLAQtUmb0pdle3Wpuq0VIyPBdmPu
         6F+TuuFxieY4/luJ9ln61YiCkoBJcIO03x2fcodrFumJREydYHczYgfC8bbW1lEVabPk
         iC13MY7FXOLuQrVDRr5TkvduEucDlTmxIlULJUOfGfJkzTeyTZJgAh97Shs9QWaHVaBM
         6vjw==
X-Gm-Message-State: AOAM531Rwr2bI1jar0KUfEC7MdA2oxOKBjQooIX4aEFjcbBFl6sSXMgl
        U1YNsM2is4syf/4s6rRGirMDYw==
X-Google-Smtp-Source: ABdhPJx6hsFjzM6+Cc5+0sYPcATCIG/Nu0mB09vjfnULq275RahDlgSdUHsy4uAQivbOwg3jDsZZIg==
X-Received: by 2002:a1c:2384:: with SMTP id j126mr23898113wmj.116.1606130414120;
        Mon, 23 Nov 2020 03:20:14 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/40] drm/amd/amdgpu/gmc_v8_0: Fix more issues attributed to copy/paste
Date:   Mon, 23 Nov 2020 11:19:16 +0000
Message-Id: <20201123111919.233376-38-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:618: warning: Function parameter or member 'flush_type' not described in 'gmc_v8_0_flush_gpu_tlb_pasid'
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:618: warning: Function parameter or member 'all_hub' not described in 'gmc_v8_0_flush_gpu_tlb_pasid'
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:657: warning: Function parameter or member 'vmhub' not described in 'gmc_v8_0_flush_gpu_tlb'
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:657: warning: Function parameter or member 'flush_type' not described in 'gmc_v8_0_flush_gpu_tlb'
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:998: warning: Function parameter or member 'pasid' not described in 'gmc_v8_0_vm_decode_fault'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 0f32a8002c3d7..41c1d8e812b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -609,6 +609,8 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  * @pasid: pasid to be flush
+ * @flush_type: unused
+ * @all_hub: unused
  *
  * Flush the TLB for the requested pasid.
  */
@@ -649,6 +651,8 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vmid: vm instance to flush
+ * @vmhub: unused
+ * @flush_type: unused
  *
  * Flush the TLB for the requested page table (VI).
  */
@@ -990,6 +994,7 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
  * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
  * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
  * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
+ * @pasid: debug logging only - no functional use
  *
  * Print human readable fault information (VI).
  */
-- 
2.25.1

