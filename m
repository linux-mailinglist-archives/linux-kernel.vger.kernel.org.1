Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C922EF555
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbhAHQAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbhAHQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:00:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2262C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 07:59:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v14so8209011wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding;
        bh=+frVH2P3qgSnqL7HXhR9TCdoXNAxfK7Z0TgEh1F+V+k=;
        b=lMHMa3eGLCu1da4yljPzgqxf9iNm+Y0UzZeNIIqpWrxgdmExkiJCVYi4gqAvkXYEhe
         iCECOQDPtW/5gqiiCNJLNhUAALoGF3epXhBrXn2TGbI8qTV3xAKjgueMZaKD7mepmzfp
         wzpD7AZLL6aL8BCauQNUXBxuolN7ihG1nq6lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding;
        bh=+frVH2P3qgSnqL7HXhR9TCdoXNAxfK7Z0TgEh1F+V+k=;
        b=JN2AAe/350RinuZ5whdEwnqKMy0oD6GS2wbMr/s4/1CH8xG80ZcjDXLPAoJeHV1Wk0
         OAQXzevuqVPrFBsttDsTAstpoeWdQZsmEU2fgnFluE8H5ANxDoxbfAeLAZeK+NaI0t6R
         aUWBzbPblujPyQ0vBovs4MqKhlNGVoQpvMHUDBMCqx6EqOc2lhpC/4yvOe3XvEHWGHFz
         5tGA/OB1Ju4K8rfFIr7pH1DGEcKFFfH5Tw4p7DCLuNetTdbfkV/tGUaauqfBmRQTKVi7
         SHb93vhYvOESrtwxivOIEfyJigRMXcV14jc64dQpK9KQgaEo9qrmqJu1z6DGTgk94HvL
         wTAA==
X-Gm-Message-State: AOAM5314LDJLaCtZ4bMxBs+57m5pNdpfvKJYbtCBPxgsWu/9PXpMYP1q
        tRZrZ+GNqggVuzUnvxKUK6A4lUZuQK7Ikmfm
X-Google-Smtp-Source: ABdhPJylobJ5eNy7WNKASR1cko+DeJQqWQ6sa9zNb1lgPek10t7CK8c4jmpQf7XzrEZoykVDJ8QZIQ==
X-Received: by 2002:a1c:3cd5:: with SMTP id j204mr3554583wma.53.1610121592502;
        Fri, 08 Jan 2021 07:59:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h9sm13777969wre.24.2021.01.08.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:59:51 -0800 (PST)
Date:   Fri, 8 Jan 2021 16:57:50 +0100
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
Subject: [PULL] drm-fixes
Message-ID: <X/iA/qwB8X11akLF@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Looks like people are back from the break, usual small pile of fixes all
over. Next week Dave should be back. Only thing pending I'm aware of is a
"this shouldn't have become uapi" reverts for amdgpu, but they're already
on the list and not that important really so can wait another week.

Cheers, Daniel

drm-fixes-2021-01-08:
drm-fixes for -rc3

- fix for ttm list corruption in radeon, reported by a few people
- fixes for amdgpu, i915, msm
- dma-buf use-after free fix

Cheers, Daniel

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-01-08

for you to fetch changes up to 29f95f20581c4bb4e58c1cc1cb15bff9b931cad9:

  Merge tag 'drm-misc-fixes-2021-01-08' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2021-01-08 10:39:18 +0100)

----------------------------------------------------------------
drm-fixes for -rc3

- fix for ttm list corruption in radeon, reported by a few people
- fixes for amdgpu, i915, msm
- dma-buf use-after free fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/display: drop DCN support for aarch64
      Revert "drm/amd/display: Fix memory leaks in S3 resume"

Arnd Bergmann (1):
      drm/amd/display: Fix unused variable warning

Charan Teja Reddy (1):
      dmabuf: fix use-after-free of dmabuf's file->f_inode

Chris Wilson (2):
      drm/i915/gt: Define guc firmware blob for older Cometlakes
      drm/i915/dp: Track pm_qos per connector

Christian König (2):
      drm/radeon: stop re-init the TTM page pool
      drm/ttm: unexport ttm_pool_init/fini

Craig Tatlor (1):
      drm/msm: Call msm_init_vram before binding the gpu

Daniel Vetter (4):
      Merge tag 'amd-drm-fixes-5.11-2021-01-06' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2021-01-07' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-msm-fixes-2021-01-07' of https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2021-01-08' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Dennis Li (3):
      drm/amdgpu: fix a memory protection fault when remove amdgpu device
      drm/amdgpu: fix a GPU hang issue when remove device
      drm/amdgpu: fix no bad_pages issue after umc ue injection

Hawking Zhang (1):
      drm/amdgpu: switched to cached noretry setting for vangogh

Iskren Chernev (3):
      drm/msm: Fix null dereference in _msm_gem_new
      drm/msm: Ensure get_pages is called when locked
      drm/msm: Add modparam to allow vram carveout

Jiawei Gu (1):
      drm/amdgpu: fix potential memory leak during navi12 deinitialization

John Clements (2):
      drm/amd/pm: updated PM to I2C controller port on sienna cichlid
      drm/amdgpu: enable ras eeprom support for sienna cichlid

Kevin Wang (1):
      drm/amd/display: fix sysfs amdgpu_current_backlight_pwm NULL pointer issue

Konrad Dybcio (1):
      drm/msm: Only enable A6xx LLCC code on A6xx

Kuogee Hsieh (1):
      drm/msm/dp: postpone irq_hpd event during connection pending state

Matthew Auld (2):
      drm/i915: clear the shadow batch
      drm/i915: clear the gpu reloc batch

Rob Clark (1):
      drm/msm: Fix WARN_ON() splat in _free_object()

Xiaojian Du (4):
      drm/amd/pm: correct the sensor value of power for vangogh
      drm/amd/pm: improve the fine grain tuning function for RV/RV2/PCO
      drm/amd/pm: fix the failure when change power profile for renoir
      drm/amd/pm: improve the fine grain tuning function for RV/RV2/PCO

 drivers/dma-buf/dma-buf.c                          |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  25 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |   2 +-
 drivers/gpu/drm/amd/display/Kconfig                |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |   4 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |  21 ---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   7 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |   7 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   7 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |   4 -
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |   4 -
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile      |   5 -
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile     |   4 -
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile     |   4 -
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   4 -
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |   4 -
 drivers/gpu/drm/amd/display/dc/os_types.h          |   4 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   | 166 +++++++++++++++++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h   |   3 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |   1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |   3 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   1 +
 drivers/gpu/drm/i915/i915_cmd_parser.c             |  27 ++--
 drivers/gpu/drm/i915/i915_drv.c                    |   5 -
 drivers/gpu/drm/i915/i915_drv.h                    |   3 -
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   4 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  21 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   6 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   7 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  12 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   8 +-
 drivers/gpu/drm/msm/msm_gem.c                      |  13 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |   3 -
 drivers/gpu/drm/ttm/ttm_pool.c                     |   2 -
 47 files changed, 302 insertions(+), 177 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
