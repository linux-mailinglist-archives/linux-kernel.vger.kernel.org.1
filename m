Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1C2F7156
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbhAOECH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbhAOECG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:02:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC3AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:01:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v184so2266317wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YAwc0pXn/Gx7YHsfWcfsW5rb54m4c7aWDsZ6VJ3Rf60=;
        b=mS6AeXdJ/kHS8D7RB4na4AY5VkCBLDdh/Rv+jJiNMkoxxZcISrp5AE99+4IdnBngRz
         2EpilqbZryjiHIQPFkAwlXzWo1QHv9gASMQtWActpbe9nCk83eKt5lD6wNO1OjsR0YDQ
         qbvQ/AX4tAUFSGpBCl+MTs58mzgxdXBPgQzFIMjsDj49YblikoEEJsclS4yJnNdXuU3R
         hAPONdIZVrpJnB9ULowzCwacR7ylcGB8ga5r0wmXnrtDk66vwihj1s85XB6+sdn473Zd
         CgKjrQ9K3P2bltyOrUMM0uBXjV6fCZ/JzMOaU9rFCSRZ7sYZIvNwmCijvOMKaH+AKmg/
         8tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YAwc0pXn/Gx7YHsfWcfsW5rb54m4c7aWDsZ6VJ3Rf60=;
        b=orKT3LvjEVVrd0nxwKqxkmD+XczJIITcqzHm5rONSrgMD0GDsi19nRT3TXun7jTScm
         Txm2namjTuB+m6UotskCc0LiJY/xqnHZvXO80apXdw6EFrGb9DsPcTWUAM/vVcEEoc4R
         Z135oi44Zk5Koer//wYBGidGI9Q9ZoRnBuDBNhEhHXDr6Tk/3I2HoCFYXIZgjhaCTAcC
         2UTxXqEQIOsJCvfB/bJC0jX//ljzj2/O8V9A21vqxrXid6DQX401NHSerfmKJJBJkrmc
         JntYGkuy8kDNzB90l+6+7C6/WzbD6uBMC0QmESkrXpYEMvT4T2MrNmtn0p/KWTPzlpNn
         m4kw==
X-Gm-Message-State: AOAM532jdUDnxNNBP6KIswLFKn5MdLHnLeXGK0kdbN0/hnXfv7dO1JFB
        WHbDvVxb33U0ayqWQFHRrSaJZNBClDmaCkq6otmpj+sHLl8=
X-Google-Smtp-Source: ABdhPJyeJydgWViEu0nM62LsO/qd2KD8kO+sOycEKZ2CZ61+EXGENUuHsVuxE+aDvAQhJX4G2OuhEsHDWgqr+X/NBCo=
X-Received: by 2002:a1c:e902:: with SMTP id q2mr6555021wmc.143.1610683284169;
 Thu, 14 Jan 2021 20:01:24 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Jan 2021 14:01:12 +1000
Message-ID: <CAPM=9tyyT70W1pkQj3tLWSmQWQpT6V3mSZzOg2n1j+VGa4V-fQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.11-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Back to mostly regular scheduling for me. Big thanks to Daniel for
stepping into my duties for the last few turns.

Regular fixes for rc4, a bunch of fixes across i915, amdgpu and
nouveau here, along with a couple of TTM fixes, and dma-buf and one
core pageflip/modifier interaction fix. One notable i915 fix is a HSW
GT1 regression fix that has been outstanding for quite a while.
(Thanks to Matt Turner for kicking Intel into getting it fixed).

Ben Skeggs has asked about the possibility of pulling nvidia ampere
basic display support into fixes as new hardware with nothing outside
touched, I'll queue up a separate pull after this one and you can
decide if it's appropriate.

Dave.

drm-fixes-2021-01-15:
drm fixes for 5.11-rc4

dma-buf:
- Fix a memory leak in CMAV heap

core:
- Fix format check for legacy pageflips

ttm:
- Pass correct address to dma_mapping_error()
- Use mutex in pool shrinker

i915:
- Allow the sysadmin to override security mitigations
- Restore clear-residual mitigations for ivb/byt
- Limit VFE threads based on GT
- GVT: fix vfio edid and full display detection
- Fix DSI DSC power refcounting
- Fix LPT CPU mode backlight takeover
- Disable RPM wakeref assertions during driver shutdown
- Fix DSI sequence sleeps

amdgpu:
- Update repo location in MAINTAINERS
- Add some new renoir PCI IDs
- Revert CRC UAPI changes
- Revert OLED display fix which cases clocking problems for some systems
- Misc vangogh fixes
- GFX fix for sienna cichlid
- DCN1.0 fix for pipe split
- Fix incorrect PSP command

amdkfd:
- Fix possible out of bounds read in vcrat creation

nouveau:
- irq handling fix
- expansion ROM fix
- hw init dpcd disable
- aux semaphore owner field fix
- vram heap sizing fix
- notifier at 0 is valid fix
The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837=
:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-01-15

for you to fetch changes up to c8f6364f35f32786dd40336cfa35b9166d91b8ab:

  Merge branch '04.00-ampere-lite-fixes' of
git://github.com/skeggsb/linux into drm-fixes (2021-01-15 13:26:44
+1000)

----------------------------------------------------------------
drm fixes for 5.11-rc4

dma-buf:
- Fix a memory leak in CMAV heap

core:
- Fix format check for legacy pageflips

ttm:
- Pass correct address to dma_mapping_error()
- Use mutex in pool shrinker

i915:
- Allow the sysadmin to override security mitigations
- Restore clear-residual mitigations for ivb/byt
- Limit VFE threads based on GT
- GVT: fix vfio edid and full display detection
- Fix DSI DSC power refcounting
- Fix LPT CPU mode backlight takeover
- Disable RPM wakeref assertions during driver shutdown
- Fix DSI sequence sleeps

amdgpu:
- Update repo location in MAINTAINERS
- Add some new renoir PCI IDs
- Revert CRC UAPI changes
- Revert OLED display fix which cases clocking problems for some systems
- Misc vangogh fixes
- GFX fix for sienna cichlid
- DCN1.0 fix for pipe split
- Fix incorrect PSP command

amdkfd:
- Fix possible out of bounds read in vcrat creation

nouveau:
- irq handling fix
- expansion ROM fix
- hw init dpcd disable
- aux semaphore owner field fix
- vram heap sizing fix
- notifier at 0 is valid fix

----------------------------------------------------------------
Alex Deucher (1):
      MAINTAINERS: update radeon/amdgpu/amdkfd git trees

Alexandre Demers (1):
      drm/amdgpu: fix DRM_INFO flood if display core is not supported
(bug 210921)

Bas Nieuwenhuizen (1):
      drm: Check actual format for legacy pageflip.

Ben Skeggs (7):
      drm/nouveau/bios: fix issue shadowing expansion ROMs
      drm/nouveau/privring: ack interrupts the same way as RM
      drm/nouveau/i2c/gk110: split out from i2c/gk104
      drm/nouveau/i2c/gk110-: disable hw-initiated dpcd reads
      drm/nouveau/i2c/gm200: increase width of aux semaphore owner fields
      drm/nouveau/mmu: fix vram heap sizing
      drm/nouveau/kms/nv50-: fix case where notifier buffer is at offset 0

Chris Wilson (4):
      drm/i915: Disable RPM wakeref assertions during driver shutdown
      drm/i915/gt: Limit VFE threads based on GT
      drm/i915/gt: Restore clear-residual mitigations for Ivybridge, Baytra=
il
      drm/i915: Allow the sysadmin to override security mitigations

Christian K=C3=B6nig (1):
      drm/ttm: make the pool shrinker lock a mutex

Colin Xu (1):
      drm/i915/gvt: Fix vfio_edid issue for BXT/APL

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2021-01-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-01-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.11-2021-01-14' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge branch '04.00-ampere-lite-fixes' of
git://github.com/skeggsb/linux into drm-fixes

Hans de Goede (1):
      drm/i915/dsi: Use unconditional msleep for the panel_on_delay
when there is no reset-deassert MIPI-sequence

Huang Rui (1):
      drm/amdgpu: fix vram type and bandwidth error for DDR5 and DDR4

Imre Deak (1):
      drm/i915/icl: Fix initing the DSI DSC power refcount during HW readou=
t

Jani Nikula (2):
      drm/i915/backlight: fix CPU mode backlight takeover on LPT
      Merge tag 'gvt-fixes-2020-01-08' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Jeremy Cline (2):
      drm/ttm: Fix address passed to dma_mapping_error() in ttm_pool_map()
      drm/amdkfd: Fix out-of-bounds read in kdf_create_vcrat_image_cpu()

John Stultz (1):
      dma-buf: cma_heap: Fix memory leak in CMA heap

Li, Roman (1):
      drm/amd/display: disable dcn10 pipe split by default

Likun Gao (1):
      drm/amdgpu: set power brake sequence

Nikola Cornij (1):
      drm/amd/display: Add a missing DCN3.01 API mapping

Prike Liang (1):
      drm/amdgpu: add green_sardine device id (v2)

Qingqing Zhuo (1):
      drm/amd/display: NULL pointer hang

Rodrigo Siqueira (4):
      Revert "drm/amd/display: Fixed Intermittent blue screen on OLED panel=
"
      Revert "drm/amd/display: Fix unused variable warning"
      Revert "drm/amdgpu/disply: fix documentation warnings in display mana=
ger"
      Revert "drm/amd/display: Expose new CRC window property"

Victor Zhao (1):
      drm/amdgpu/psp: fix psp gfx ctrl cmds

Wayne Lin (1):
      drm/amd/display: Fix to be able to stop crc calculation

Wesley Chalmers (1):
      drm/amd/display: Initialize stack variable

chen gong (1):
      drm/amdgpu/gfx10: add updated GOLDEN_TSC_COUNT_UPPER/LOWER
register offsets for VGH

mengwang (1):
      drm/amdgpu: add new device id for Renior

 MAINTAINERS                                        |   4 +-
 drivers/dma-buf/heaps/cma_heap.c                   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  53 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  48 ++++++-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  11 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 142 ++---------------=
--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  38 -----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  54 +------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   8 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   4 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   1 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |  11 +-
 drivers/gpu/drm/drm_plane.c                        |   9 +-
 drivers/gpu/drm/i915/Makefile                      |   1 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |   4 -
 drivers/gpu/drm/i915/display/intel_panel.c         |   9 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  16 ++-
 drivers/gpu/drm/i915/gt/gen7_renderclear.c         | 157 ++++++++++++-----=
----
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   6 +-
 drivers/gpu/drm/i915/gvt/display.c                 |  81 +++++++----
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   5 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   4 +
 drivers/gpu/drm/i915/i915_mitigations.c            | 146 +++++++++++++++++=
++
 drivers/gpu/drm/i915/i915_mitigations.h            |  13 ++
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.h            |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wimmc37b.c        |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h  |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  12 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild     |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h      |   7 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c   |  10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c |  17 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gk110.c    |  45 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gm200.c    |   7 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/pad.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/priv.h     |   4 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gf100.c   |  10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gk104.c   |  10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c     |   6 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |  22 +--
 48 files changed, 598 insertions(+), 410 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/i915_mitigations.c
 create mode 100644 drivers/gpu/drm/i915/i915_mitigations.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gk110.c
