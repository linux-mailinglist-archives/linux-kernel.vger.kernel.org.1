Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E02E35A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgL1KCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgL1KCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:02:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091DAC061794;
        Mon, 28 Dec 2020 02:01:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq13so5701072pjb.3;
        Mon, 28 Dec 2020 02:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q+6qTPnd2DfkDTjKCeZfbJ0CK5rN8jRkAI/OP6oorK4=;
        b=X7dCJoEylwrQwmsaBx3qB4oY14wfMx3GtzsixeIQ/q8+pm3h3eM9cJq76xHmnyawh5
         m469J+B4V08Hs1niAlQAGvb/wcY3nGpP6bHTVbz5YDAuj5Uo+bbEg/BI1SSbF5CYRrR+
         NDJH3129Jl+OcoIT2xIaF4Y+41j7WO1rSpcjCxef2DYlLwzQRV/1yZ/l68dpuEOmtBcV
         s2BfeMHAyEcS5NLF2wCXVqQs8XqtsYsH5p5NW8LbDByPDAceIXfr1HyHMXr/hvFU0Y3i
         vL0Ow4QoqjE1O/Fdep/kGa74wow90gJdcKxobpuVlc5dVA2N7ujlqXmzhG7MbeHYpQED
         1KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q+6qTPnd2DfkDTjKCeZfbJ0CK5rN8jRkAI/OP6oorK4=;
        b=Bc8IHTe57AN0rUen9yc2pBwjF7TBoazGiiwmwD3tYcicKtgSGiiHXmnBEhkKPj8caw
         KYwI0ApQ5xfpH/zE/+4W/9Wn8oHG2G1ZJkmnv3IbHdVJpLArEgRIXsXvDNap6W0gJPEA
         hm1MQFrS5r/2EdFFzDnVIIxY0UZOuWCK5dby8RV7Y3kNzuDDPnZz2QEZOq6don8n6ua0
         7tKLnMYuhCkK0adjF+9JyFro9hOyAQy2q/bXboMZrzcyKiDCQ2DNQu94nSoh5hCyQCsf
         wm1GcZJp1e7QbwrCYkpq4+oATkheMt7qsFtfL5vT8U4TPpFHT2UO0Gwk9hjrrLdohbgN
         SNKA==
X-Gm-Message-State: AOAM5327T9ireSvZHauOkG5r/LvtQVir0MasFLMfIACeq/o84AImZ/EI
        3gTGMygUToX4EKE98VDVGd4=
X-Google-Smtp-Source: ABdhPJz+EqZlmRCex+rchdhkDja3tKqYO0zpWRckkT0SEnwFNYxqVo2WuF8ZeJnFYv4lAvB5QHV29w==
X-Received: by 2002:a17:90a:a10e:: with SMTP id s14mr19809351pjp.133.1609149717402;
        Mon, 28 Dec 2020 02:01:57 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s1sm33775240pjk.1.2020.12.28.02.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 02:01:56 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/6] Add Unisoc's drm kms module
Date:   Mon, 28 Dec 2020 18:01:41 +0800
Message-Id: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeList:
RFC v1:
1. only upstream modeset and atomic at first commit. 
2. remove some unused code;
3. use alpha and blend_mode properties;
3. add yaml support;
4. remove auto-adaptive panel driver;
5. bugfix

RFC v2:
1. add sprd crtc and plane module for KMS, preparing for multi crtc&encoder
2. remove gem drivers, use generic CMA handlers
3. remove redundant "module_init", all the sub modules loading by KMS

RFC v3:
1. multi crtc&encoder design have problem, so rollback to v1

RFC v4:
1. update to gcc-linaro-7.5.0
2. update to Linux 5.6-rc3
3. remove pm_runtime support
4. add COMPILE_TEST, remove unused kconfig
5. "drm_dev_put" on drm_unbind
6. fix some naming convention issue
7. remove semaphore lock for crtc flip
8. remove static variables

RFC v5:
1. optimize encoder and connector code implementation
2. use "platform_get_irq" and "platform_get_resource"
3. drop useless function return type, drop unless debug log
4. custom properties should be separate, so drop it
5. use DRM_XXX replase pr_xxx
6. drop dsi&dphy hal callback ops
7. drop unless callback ops checking
8. add comments for sprd dpu structure

RFC v6:
1. Access registers via readl/writel
2. Checking for unsupported KMS properties (format, rotation, blend_mode, etc) on plane_check ops
3. Remove always true checks for dpu core ops

RFC v7:
1. Fix DTC unit name warnings
2. Fix the problem of maintainers
3. Call drmm_mode_config_init to mode config init
4. Embed drm_device in sprd_drm and use devm_drm_dev_alloc
5. Replace DRM_XXX with drm_xxx on KMS module, but not suitable for other subsystems
6. Remove plane_update stuff, dpu handles all the HW update in crtc->atomic_flush
7. Dsi&Dphy Code structure adjustment, all move to "sprd/"

v0:
1. Remove dpu_core_ops stuff layer for sprd drtc driver, but dpu_layer need to keeping.
   Because all the HW update in crtc->atomic_flush, we need temporary storage all layers for
   the dpu pageflip of atomic_flush.
2. Add ports subnode with port@X.

v1:
1. Remove dphy and dsi graph binding, merge the dphy driver into the dsi.
2. Add commit messages for Unisoc's virtual nodes.

v2:
1. Use drm_xxx to replace all DRM_XXX.
2. Use kzalloc to replace devm_kzalloc for sprd_dsi/sprd_dpu structure init.

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi controller bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../display/sprd/sprd,display-subsystem.yaml       |   64 +
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |   77 +
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        |  107 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   13 +
 drivers/gpu/drm/sprd/Makefile                      |   11 +
 drivers/gpu/drm/sprd/dpu_r2p0.c                    |  603 ++++++++
 drivers/gpu/drm/sprd/dw_dsi_ctrl.c                 |  794 +++++++++++
 drivers/gpu/drm/sprd/dw_dsi_ctrl.h                 | 1475 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.c             |  157 +++
 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.h             |   26 +
 drivers/gpu/drm/sprd/megacores_pll.c               |  317 +++++
 drivers/gpu/drm/sprd/megacores_pll.h               |  146 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  465 ++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  170 +++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  224 +++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   19 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    | 1162 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  107 ++
 20 files changed, 5940 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dpu_r2p0.c
 create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl.c
 create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl.h
 create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.c
 create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.h
 create mode 100644 drivers/gpu/drm/sprd/megacores_pll.c
 create mode 100644 drivers/gpu/drm/sprd/megacores_pll.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h

-- 
2.7.4

