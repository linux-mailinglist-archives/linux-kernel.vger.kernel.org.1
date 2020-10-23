Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9572967CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373673AbgJWADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373666AbgJWADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:03:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A777C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:03:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so4930305ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OtjpAOjCAnd7Q5toMek55kg2wpMiXEmoeGjBhRaVDnc=;
        b=TS1OK/ma7nUwTrFEhNDKN+nsISXixTRF4YmBKx7b7Y33Dk/CzmR/YLfBp11TP/SfnK
         uvlMvyDz8JVs2dl3y7YcyNdxsyamQC/S5e/COk85GuJ7cuLKox4qVxNvV5cTiWj4VwNg
         UHnKAHvcCKhVgmZnLygQSw9L0LEvKOr6vgBZ0hsuneRBqiw9xmwdo1c4lF+1q6e+Q5tS
         eO90u83nFaRRQe8FOVrfKwHT3u+o1XPoSmblE7UFsDfbYYn5bczC0DNnnII3EHuEp5Be
         loXNSI+yRJ/b8juGEovgdv5PQxmbkvoYt4zkZ7ZdaYF8IRP6JphUg2A3L0wzZJWuvAR2
         F1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OtjpAOjCAnd7Q5toMek55kg2wpMiXEmoeGjBhRaVDnc=;
        b=EK4cqWgn9jnz1qMI7z+DxPYUIuDLjn1oxjJrJ+6geW7pMlh56Y7QHHxcILeHLtRRY3
         iDsvkln+Ml1kwI0BiyE4ABGwibWIH1R3gqNYvJlpCyHRaUXcPID9x4L/wBdXwTDvhXaI
         1muYYK3ItgjFyDB2/SfCFtTBQX3MYmCpNrkXKEAyN3vzuzO58jkow/9Mz4z2CUe1Ivm/
         OYBlMbBwCCkOmEyAPDAjGkqffKKqNW+Zo22n7ci5W47FuDCmYUJquGZHdGyK5NYMFkUu
         0jj2F70lI7Ln8U2AXerdPgcXdwaLA0EB3yXajeN41cZKa7FSf28sEbeF5rjaRRjEoXt2
         unmg==
X-Gm-Message-State: AOAM530zuNVdXf+VfykD5Y/uPfnFfexWAp8G1edU8jCmmVJaJxRNqjc+
        vlFgOPi4W0Dl9CcRFculun1DZt2UWcIEdyBNCBw=
X-Google-Smtp-Source: ABdhPJwDjNPzQ29b/9sh0kaOjPpizjUiM3/2bfBLdah2bvgPaGwAOOp0vW2TTapLN0j3hL55Lr6Jlu0UnwZ9GOJDxjo=
X-Received: by 2002:a17:906:580e:: with SMTP id m14mr4569217ejq.237.1603411401637;
 Thu, 22 Oct 2020 17:03:21 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Oct 2020 10:03:10 +1000
Message-ID: <CAPM=9tw08JOodzP4F_K9gMpQb7MiLr5-uc0vg=kSwdmDxr=Ziw@mail.gmail.com>
Subject: [git pull] drm fixes part 2 for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This should be the last round of things for rc1, a bunch of i915
fixes, some amdgpu, more font OOB fixes and one ttm fix just found
reading code.

Dave.

drm-next-2020-10-23:
drm fixes (round two) for 5.10-rc1

fbcon/fonts:
- Two patches to prevent OOB access

ttm:
- fix for eviction value range check

amdgpu:
- Sienna Cichlid fixes
- MST manager resource leak fix
- GPU reset fix

amdkfd:
- Luxmark fix for Navi1x

i915:
- Tweak initial DPCD backlight.enabled value (Sean)
- Initialize reserved MOCS indices (Ayaz)
- Mark initial fb obj as WT on eLLC machines to avoid rcu lockup (Ville)
- Support parsing of oversize batches (Chris)
- Delay execlists processing for TGL (Chris)
- Use the active reference on the vma during error capture (Chris)
- Widen CSB pointer (Chris)
- Wait for CSB entries on TGL (Chris)
- Fix unwind for scratch page allocation (Chris)
- Exclude low patches of stolen memory (Chris)
- Force VT'd workarounds when running as a guest OS (Chris)
- Drop runtime-pm assert from vpgu io accessors (Chris)
The following changes since commit 40b99050455b9a6cb8faf15dcd41888312184720=
:

  Merge tag 'drm-intel-next-fixes-2020-10-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-10-19
09:21:59 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-23

for you to fetch changes up to b45b6fbc671c60f56fd119c443e5570f83175928:

  Merge tag 'drm-intel-next-fixes-2020-10-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-10-23
09:52:18 +1000)

----------------------------------------------------------------
drm fixes (round two) for 5.10-rc1

fbcon/fonts:
- Two patches to prevent OOB access

ttm:
- fix for evicition value range check

amdgpu:
- Sienna Cichlid fixes
- MST manager resource leak fix
- GPU reset fix

amdkfd:
- Luxmark fix for Navi1x

i915:
- Tweak initial DPCD backlight.enabled value (Sean)
- Initialize reserved MOCS indices (Ayaz)
- Mark initial fb obj as WT on eLLC machines to avoid rcu lockup (Ville)
- Support parsing of oversize batches (Chris)
- Delay execlists processing for TGL (Chris)
- Use the active reference on the vma during error capture (Chris)
- Widen CSB pointer (Chris)
- Wait for CSB entries on TGL (Chris)
- Fix unwind for scratch page allocation (Chris)
- Exclude low patches of stolen memory (Chris)
- Force VT'd workarounds when running as a guest OS (Chris)
- Drop runtime-pm assert from vpgu io accessors (Chris)

----------------------------------------------------------------
Andrey Grodzovsky (3):
      drm/amd/display: Revert "drm/amd/display: Fix a list corruption"
      drm/amd/display: Avoid MST manager resource leak.
      drm/amd/psp: Fix sysfs: cannot create duplicate filename

Ayaz A Siddiqui (1):
      drm/i915/gt: Initialize reserved and unspecified MOCS indices

Chris Wilson (10):
      drm/i915/gem: Support parsing of oversize batches
      drm/i915/gt: Delay execlist processing for tgl
      drm/i915/gt: Undo forced context restores after trivial preemptions
      drm/i915: Use the active reference on the vma while capturing
      drm/i915/gt: Widen CSB pointer to u64 for the parsers
      drm/i915/gt: Wait for CSB entries on Tigerlake
      drm/i915/gt: Onion unwind for scratch page allocation failure
      drm/i915: Exclude low pages (128KiB) of stolen from use
      drm/i915: Force VT'd workarounds when running as a guest OS
      drm/i915: Drop runtime-pm assert from vgpu io accessors

Dave Airlie (4):
      Merge tag 'drm-misc-next-fixes-2020-10-20' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      drm/ttm: fix eviction valuable range check.
      Merge tag 'amd-drm-fixes-5.10-2020-10-21' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2020-10-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Evan Quan (1):
      drm/amdgpu: correct the gpu reset handling for job !=3D NULL case

Jay Cornwall (1):
      drm/amdkfd: Use same SQ prefetch setting as amdgpu

John Clements (1):
      Revert drm/amdgpu: disable sienna chichlid UMC RAS

Kenneth Feng (2):
      drm/amd/pm: fix pp_dpm_fclk
      drm/amd/pm: remove the average clock value in sysfs

Kevin Wang (2):
      drm/amd/swsmu: add missing feature map for sienna_cichlid
      drm/amd/swsmu: correct wrong feature bit mapping

Likun Gao (5):
      drm/amdgpu: add function to program pbb mode for sienna cichlid
      drm/amdgpu: add rlc iram and dram firmware support
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/pm: fix pcie information for sienna cichlid
      drm/amdgpu: correct the cu and rb info for sienna cichlid

Peilin Ye (2):
      docs: fb: Add font_6x8 to available built-in fonts
      Fonts: Support FONT_EXTRA_WORDS macros for font_6x8

Sean Paul (1):
      drm/i915/dp: Tweak initial dpcd backlight.enabled value

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Mark ininitial fb obj as WT on eLLC machines to avoid
rcu lockup during fbdev init

 Documentation/fb/fbcon.rst                         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 111 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager_v10.c  |   5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |   1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  22 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  27 +--
 drivers/gpu/drm/i915/Kconfig.debug                 |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |   8 +
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  31 ++--
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  10 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.h         |   2 +
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |  18 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   3 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  58 +++---
 drivers/gpu/drm/i915/gt/intel_mocs.c               |  16 +-
 drivers/gpu/drm/i915/gt/selftest_reset.c           | 196 +++++++++++++++++=
++++
 drivers/gpu/drm/i915/i915_drv.h                    |   6 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   3 +-
 drivers/gpu/drm/i915/intel_uncore.c                |  27 ++-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   2 +-
 lib/fonts/font_6x8.c                               |   8 +-
 31 files changed, 527 insertions(+), 90 deletions(-)
