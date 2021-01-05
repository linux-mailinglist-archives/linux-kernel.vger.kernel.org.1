Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5EE2EAC3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbhAENrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbhAENrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:47:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38BC061795;
        Tue,  5 Jan 2021 05:46:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v1so1709604pjr.2;
        Tue, 05 Jan 2021 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g0jobtBXA5sj9lDPVNKn9xThUOLvezyzWjBOk2AQI4o=;
        b=j7R993e1p6XDqUzZu9+3yl32GIoPMOJlG4ZrwT3Nc2s8L8eOVjRui8reMP0z2Nz0IH
         dUv9QtWe0gosaeqypUR8P7x6ho54pHerFBxPLwpXGq8BskFLq9lTsdXSLx4g3tHEJvnG
         hUWjb7zmLX1e3QpUo8VwyXqXZSIgdxY2rM22uSeXmqIMVa1TFMhEuNHffM+uLGAOTV8R
         Kd12gCUHBb6Ske7B1FuHWdrmYvtP0Z+Zyj6FJcV3ZQP6iBmYVXDOEuWjHFa9a+pfPc0l
         PwG8W5mVApfcvxSBLnk+QfzHZg/d+sZkgXaD4ht9/EHXsgFXQBQiyzPtSl3MBZmUfA+c
         0isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g0jobtBXA5sj9lDPVNKn9xThUOLvezyzWjBOk2AQI4o=;
        b=dtqrPiGOo6OP+9LF93AaC1HfBqvIBHgLLNZBnxrXbRlmfeJdAsCE2MRhZhG1IABWwz
         29ax/4JvY602IeUQ6a3+8P0hJNdU2CjNFbmCl6XAJCpgBtKuuKuGlvAjVQNyyPMrUujg
         kuOfMhszsIospCf3RfByPaItYYVyaDWS1ip0w2iHhoK7gLJGVT/uLlxYMvHnf9dYSVS0
         Ytj6mD/IhsvQqR1cIa2M69ntg0HYato8HJFm3WWm2XDVC81muaMT8jE1OfB4jDggj29M
         4CF5wUOtT/TWlr2x6p0H8ZfXp+oH7Jx7fLvdqu+GGrjyQECISsmf5XN+MySY7pn2Tij0
         c82Q==
X-Gm-Message-State: AOAM532M9VdXfq89yyQLi/gibp0dSZazGql11xc5GYQAXPThyht+vgRV
        2sofjDpJT3GM2j25B8spBpwPqd9xYVk=
X-Google-Smtp-Source: ABdhPJxvd6mIQv1AA6rT/CDrdeIwQ5Gv03Zr0IMu8Te2vbFbkE9nf31TY6rfagk/VngB0+YLJKjv0Q==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr4092457pjq.21.1609854380057;
        Tue, 05 Jan 2021 05:46:20 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w63sm57582284pfc.20.2021.01.05.05.46.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 05:46:19 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] Add Unisoc's drm kms module
Date:   Tue,  5 Jan 2021 21:46:01 +0800
Message-Id: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
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
3. Remove dpu_core_ops midlayer.

v3:
1. Remove dpu_layer midlayer and commit layers by aotmic_update

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi controller bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../display/sprd/sprd,display-subsystem.yaml       |   64 +
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |   77 +
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        |  102 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   13 +
 drivers/gpu/drm/sprd/Makefile                      |    8 +
 drivers/gpu/drm/sprd/dw_dsi_ctrl.c                 |  794 +++++++++++
 drivers/gpu/drm/sprd/dw_dsi_ctrl.h                 | 1475 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.c             |  157 +++
 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.h             |   26 +
 drivers/gpu/drm/sprd/megacores_pll.c               |  317 +++++
 drivers/gpu/drm/sprd/megacores_pll.h               |  146 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  985 +++++++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  120 ++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  224 +++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   19 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    | 1162 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  107 ++
 19 files changed, 5799 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
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

