Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6C2135CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGCIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:07:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED8C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:07:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so31683506wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1TNzycKuUCG/Lpw8LCZ7YtLXjAvDFp2TFsGPUACq2s=;
        b=s0Mz/Wdq8iqu3dPfohf7u7IAcdckwYBi+DxKcwrRE4abFYeLQqdL+pBXBr4ow5g9cq
         3n8fkCLWPAbRJ/wTcif1Iv8lrF2TD7HwYVov6GvAh3CNLk39Sme8m26ckcqGhUnkn6Bn
         VZF4v5m3IpLhAUmGAoBdpDq2DdhnkWO5x2+R/s4xz68MmnHXJ1yDy2Jb9U+wKO+SX+7g
         SXMozQhnUH5lOON2n3f2IlmKZNCC16CkEW7qxClyJ6/zaUmnUJ/yBIM2fXaUru47gjyV
         vwSuqsxqUeNitO+JKHdCp2N2h8vZ292KsnBh+XdsYxhz4KSX//OyJzLvbOzJMAGHP8mq
         Oc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1TNzycKuUCG/Lpw8LCZ7YtLXjAvDFp2TFsGPUACq2s=;
        b=jZRhPFSRcrlQP+915Pql6rWkrp8YdDRgt26DFoEAiWAvpyApkGWTCtSe3SdXl3arMq
         I2o2t42djBloIFzATupxsb9W1Ol1EMOWRL041cytoQy3YhHZdql9amczPdst1E0vqaVG
         14QFfyY/HVeMhpbnXH6YqcLW5kjIXaT17BMrVBnzg0KhtnQtKmMKnMgqhBaVVaUEjx0/
         TL9g6pNm5SDPVZXhFVdQmT0VNWutXrmge4fmkjxQymJ6DRNLTF/yqmlZBS726lBlVJ8r
         8EnPKpoBxhnB2E0ObO4Tjhr7aLnTSNVLHCNVC5vRbTJZRzsWuP4lYdZkvxpiSi9LzCCp
         lWYw==
X-Gm-Message-State: AOAM532rviXOfLg+o+F0mdgIMWfJMYG8ASHazkUVmUZAcj1cLUGfsFPU
        jkn6z4PMhQbBSS1ONA+EzIxlUg==
X-Google-Smtp-Source: ABdhPJyg7KEBrWbXbNhkwuxhamaT+87wYHYXZdWBW6ZFOSDlt0fJRgbFVLhpqyvx5pqYzjUvi5GUlQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr38512820wrm.271.1593763657349;
        Fri, 03 Jul 2020 01:07:37 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:6959:e617:6562:cabf])
        by smtp.gmail.com with ESMTPSA id 1sm12682403wmf.0.2020.07.03.01.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:07:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/6] drm/meson: add support for Amlogic Video FBC
Date:   Fri,  3 Jul 2020 10:07:22 +0200
Message-Id: <20200703080728.25207-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

It considerably reduces memory bandwidth while writing and reading
frames in memory.

The underlying storage is considered to be 3 components, 8bit or 10-bit
per component, YCbCr 420, single plane :
- DRM_FORMAT_YUV420_8BIT
- DRM_FORMAT_YUV420_10BIT

This modifier will be notably added to DMA-BUF frames imported from the V4L2
Amlogic VDEC decoder.

At least two layout are supported :
- Basic: composed of a body and a header
- Scatter: the buffer is filled with a IOMMU scatter table referring
  to the encoder current memory layout. This mode if more efficient in terms
  of memory allocation but frames are not dumpable and only valid during until
  the buffer is freed and back in control of the encoder

At least two options are supported :
- Memory saving: when the pixel bpp is 8b, the size of the superblock can
  be reduced, thus saving memory.

This serie adds the missing register, updated the FBC decoder registers
content to be committed by the crtc code.

The Amlogic FBC has been tested with compressed content from the Amlogic
HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
(Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
(Scatter on G12A/SM1, default on GXL).

It's expected to work as-is on GXM and G12B SoCs.

Changes since v8 at [8]:
- added clarification of scatter mmap behavior as suggested by daniel
- added ack and review tags

Changes since v7 at [7]:
- rebased on drm-misc-next
- removed spurious DEBUG in drivers/gpu/drm/meson/meson_overlay.c

Changes since v6 at [6]:
- rebased on drm-misc-next (after drm-misc-next-2020-05-14)
- updated patch 1 commit log for completion

Changes since v5 at [5]:
- merged all fourcc patches in 1
- fixed fourcc definition to have only a single DRM_MOD_
- fixed 2 checkpatch issues

Changes since v4 at [4]:
- added layout and options mask
- cosmetic changes in fourcc.h
- fixed mod check using the masks
- fixed plane apply using the masks

Changes since v3 at [3]:
- added dropped fourcc patch for scatter
- fixed build of last patch

Changes since v2 at [2]:
- Added "BASIC" layout and moved the SCATTER mode as layout, making
  BASIC and SCATTER layout exclusives
- Moved the Memory Saving at bit 8 for options fields
- Split fourcc and overlay patch to introduce basic, mem saving and then
  scatter in separate patches
- Added comment about "transferability" of the buffers

Changes since v1 at [1]:
- s/VD1_AXI_SEL_AFB/VD1_AXI_SEL_AFBC/ into meson_registers.h

[1] https://patchwork.freedesktop.org/series/73722/#rev1
[2] https://patchwork.freedesktop.org/series/73722/#rev2
[3] https://patchwork.freedesktop.org/series/73722/#rev3
[4] https://patchwork.freedesktop.org/series/73722/#rev4
[5] https://patchwork.freedesktop.org/series/73722/#rev5
[6] https://patchwork.freedesktop.org/series/73722/#rev6
[7] https://patchwork.freedesktop.org/series/73722/#rev7
[7] https://patchwork.freedesktop.org/series/73722/#rev8

Neil Armstrong (6):
  drm/fourcc: Add modifier definitions for describing Amlogic Video
    Framebuffer Compression
  drm/meson: add Amlogic Video FBC registers
  drm/meson: overlay: setup overlay for Amlogic FBC
  drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
  drm/meson: overlay: setup overlay for Amlogic FBC Scatter Memory
    layout
  drm/meson: crtc: handle commit of Amlogic FBC frames

 drivers/gpu/drm/meson/meson_crtc.c      | 118 +++++++---
 drivers/gpu/drm/meson/meson_drv.h       |  16 ++
 drivers/gpu/drm/meson/meson_overlay.c   | 289 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  81 +++++++
 5 files changed, 488 insertions(+), 38 deletions(-)

-- 
2.22.0

