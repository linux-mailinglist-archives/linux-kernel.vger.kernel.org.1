Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A92C0478
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgKWLVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgKWLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957ABC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a186so14724940wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMOy5tV5qipP1ST9dKnY+pJMH76F5GueobC2jcvW6AA=;
        b=AUHltyNVg901tX+NdG7OuZGySL3B7qt2cjw7qJFKKr5S5cktmd5g5QKUC5SJWUZXs2
         9e84i+DyPkxXfKjfJGsXmD2L/fQarFkWrQzjFyzgg9az0tL62yFcToHlgGvVRFL+/v1P
         7l66l5tckg6CyFhj2hykcNKnOIKWSsQDtkOdsSHyYn1fQqlbRiY4bO2cas/8+cC1sf6D
         4gpxgPZbnQm+Yl1oxr0WFa8/ZP5KyF25HDUOJT/LwIOEULbo8AkePLkIImPogdXnsnZm
         fRNGETG5RRhspPPpdUU4lmtZg/yWvhgOJm2YJtI9Wc42gvuYmkwi+Yjb2r8s3XpLKwEk
         DX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMOy5tV5qipP1ST9dKnY+pJMH76F5GueobC2jcvW6AA=;
        b=PHZGOMVunSw0LStQ7K7E6Xa1E85L31iOKgkpq2LSNJuRNrsdAGWrH/pdfVgRJPTkFF
         xlHGtXQN6HZGr07HCdXlGQqKQV8wfcaTwDpZrOJRxGswmMai2p6WAluD3GmSrCrKFqgo
         6ktBcn6U8qM0ldbCbv18TtwUmBCcjItaKSN8MPjdN17TOgeEJNI3iWPtg89sizBu1pgD
         zQ5O8NSNSY/0Ov3pqJXdA63IoEmo31AZNWUd+vRB7RtjZV4wmBSskVauXYERFGam9Jv2
         ES8ZAgHsqF0Bty/J9+Tkrr03muYyklJgfVwAyrvQDiruMxZvw/DtwaUO/J6xTaRWIooz
         r3lQ==
X-Gm-Message-State: AOAM530+zzcJlEsRHYTo6EKtsZW4wmy7F7uNm0RXO9LoPs7crUPbTqEA
        gs5yPDHwMLr/jF2WNoHHk4EaKQ==
X-Google-Smtp-Source: ABdhPJytSB5+7RjVWW+JsuKdu0soHwJ2pUhXfMvSFpqLPabsAny4e8rqlLtnPxrq42WqZTrjRsYYPg==
X-Received: by 2002:a05:600c:1497:: with SMTP id c23mr22970274wmh.86.1606130363476;
        Mon, 23 Nov 2020 03:19:23 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Drew Davenport <ddavenport@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Fritz Koenig <frkoenig@google.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Jerome Glisse <glisse@freedesktop.org>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Likun Gao <Likun.Gao@amd.com>, linaro-mm-sig@lists.linaro.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        nouveau@lists.freedesktop.org,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sonny Jiang <sonny.jiang@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 00/40] [Set 8] Rid W=1 warnings from GPU
Date:   Mon, 23 Nov 2020 11:18:39 +0000
Message-Id: <20201123111919.233376-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Only 900 (from 5000) to go!

Lee Jones (40):
  drm/radeon/radeon_device: Consume our own header where the prototypes
    are located
  drm/amd/amdgpu/amdgpu_ttm: Add description for 'page_flags'
  drm/amd/amdgpu/amdgpu_ib: Provide docs for 'amdgpu_ib_schedule()'s
    'job' param
  drm/amd/amdgpu/amdgpu_virt: Correct possible copy/paste or doc-rot
    misnaming issue
  drm/amd/amdgpu/cik_ih: Supply description for 'ih' in
    'cik_ih_{get,set}_wptr()'
  drm/amd/amdgpu/uvd_v4_2: Fix some kernel-doc misdemeanours
  drm/amd/amdgpu/dce_v8_0: Supply description for 'async'
  drm/amd/amdgpu/cik_sdma: Supply some missing function param
    descriptions
  drm/amd/amdgpu/gfx_v7_0: Clean-up a bunch of kernel-doc related issues
  drm/msm/disp/dpu1/dpu_core_perf: Fix kernel-doc formatting issues
  drm/msm/disp/dpu1/dpu_hw_blk: Add one missing and remove an extra
    param description
  drm/msm/disp/dpu1/dpu_formats: Demote non-conformant kernel-doc header
  drm/msm/disp/dpu1/dpu_hw_catalog: Remove duplicated initialisation of
    'max_linewidth'
  drm/msm/disp/dpu1/dpu_hw_catalog: Move definitions to the only place
    they are used
  drm/nouveau/nvkm/subdev/bios/init: Demote obvious abuse of kernel-doc
  drm/amd/amdgpu/si_dma: Fix a bunch of function documentation issues
  drm/amd/amdgpu/gfx_v6_0: Supply description for
    'gfx_v6_0_ring_test_ib()'s 'timeout' param
  drm/msm/disp/dpu1/dpu_encoder: Fix a few parameter/member formatting
    issues
  drm/msm/disp/dpu1/dpu_hw_lm: Fix misnaming of parameter 'ctx'
  drm/msm/disp/dpu1/dpu_hw_sspp: Fix kernel-doc formatting abuse
  drm/amd/amdgpu/uvd_v3_1: Fix-up some documentation issues
  drm/amd/amdgpu/dce_v6_0: Fix formatting and missing parameter
    description issues
  drm/amd/include/vega20_ip_offset: Mark top-level IP_BASE definition as
    __maybe_unused
  drm/amd/include/navi10_ip_offset: Mark top-level IP_BASE as
    __maybe_unused
  drm/amd/include/arct_ip_offset: Mark top-level IP_BASE definition as
    __maybe_unused
  drm/amd/include/navi14_ip_offset: Mark top-level IP_BASE as
    __maybe_unused
  drm/amd/include/navi12_ip_offset: Mark top-level IP_BASE as
    __maybe_unused
  drm/amd/include/sienna_cichlid_ip_offset: Mark top-level IP_BASE as
    __maybe_unused
  drm/amd/include/vangogh_ip_offset: Mark top-level IP_BASE as
    __maybe_unused
  drm/amd/include/dimgrey_cavefish_ip_offset: Mark top-level IP_BASE as
    __maybe_unused
  drm/msm/disp/dpu1/dpu_rm: Fix formatting issues and supply
    'global_state' description
  drm/msm/disp/dpu1/dpu_vbif: Fix a couple of function param
    descriptions
  drm/amd/amdgpu/cik_sdma: Add one and remove another function param
    description
  drm/amd/amdgpu/uvd_v4_2: Add one and remove another function param
    description
  drm/msm/disp/dpu1/dpu_plane: Fix some spelling and missing function
    param descriptions
  drm/amd/amdgpu/gmc_v7_0: Add some missing kernel-doc descriptions
  drm/amd/amdgpu/gmc_v8_0: Fix more issues attributed to copy/paste
  drm/msm/msm_drv: Make '_msm_ioremap()' static
  drm/amd/amdgpu/gmc_v9_0: Remove unused table
    'ecc_umc_mcumc_status_addrs'
  drm/amd/amdgpu/gmc_v9_0: Suppy some missing function doc descriptions

 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  12 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   2 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  18 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  33 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  38 +----
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |  14 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  10 +-
 drivers/gpu/drm/amd/include/arct_ip_offset.h  |   4 +-
 .../amd/include/dimgrey_cavefish_ip_offset.h  |   2 +-
 .../gpu/drm/amd/include/navi10_ip_offset.h    |   2 +-
 .../gpu/drm/amd/include/navi12_ip_offset.h    |   2 +-
 .../gpu/drm/amd/include/navi14_ip_offset.h    |   2 +-
 .../amd/include/sienna_cichlid_ip_offset.h    |   2 +-
 .../gpu/drm/amd/include/vangogh_ip_offset.h   |   2 +-
 .../gpu/drm/amd/include/vega20_ip_offset.h    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  17 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c   |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_blk.c    |   2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  75 +++++++++-
 .../drm/msm/disp/dpu1/dpu_hw_catalog_format.h |  88 ------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c     |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |  19 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c      |   2 +-
 drivers/gpu/drm/msm/msm_drv.c                 |   4 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   | 136 +++++++++---------
 drivers/gpu/drm/radeon/radeon_device.c        |   1 +
 37 files changed, 277 insertions(+), 268 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Drew Davenport <ddavenport@chromium.org>
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: Fritz Koenig <frkoenig@google.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Jerome Glisse <glisse@freedesktop.org>
Cc: Jiansong Chen <Jiansong.Chen@amd.com>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Kalyan Thota <kalyan_t@codeaurora.org>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: nouveau@lists.freedesktop.org
Cc: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Sonny Jiang <sonny.jiang@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
-- 
2.25.1

