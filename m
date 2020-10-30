Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD01929FB00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJ3CCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3CCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:02:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:01:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p9so6514745eji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jxJV+udTNsd+r8WbFr6FFQ7TIrLSIyRQqtRx53iH59A=;
        b=MPdOT9TaZ9R7An5qD7DahJxhq6+iT9+frEy3w7ENyXfUVV/jUlVLnjF+7vKxIpr2yO
         iW3qsIAB2PODaqPyVBzrhzt+uMN3qmF4xAfbTpRsYZyvKa/fwcSzQlwCjLo0RGNQ5P7D
         LP5l8Ntc4z5PjB6/xQobIl9Kp4Ml7CywF9CfIqJ7qvbrOcs0mwbqeMQTKkL2KTHphFUS
         Q8lBy04BWOz5FrpGVAukhI6NCvdEaAwht0o+fWFo/o5NNQ9FPIBad+Vs49QuscCFHgf+
         KDL0CxjVVXbUBakVA3c3csAJ3TL5Met4jzy4L5kb4Q+LmHJH3AL+f1Ky2iFEdEqjBvOZ
         9Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jxJV+udTNsd+r8WbFr6FFQ7TIrLSIyRQqtRx53iH59A=;
        b=WCgwYX1AlkFbr0ANCMX2pvTJ0ewASCHRGjbIqwowjXlRu1T/n91V+0KiS6/SpJYS1J
         jCIladkA526EwC951n+eL5kdzf6cw2AGSh+F3qGw6ulN0MaO5a4E/6agESRgotsfVazi
         3yB1OHUycX+JMDH1vwa+74ICEqSMDurLT/xtdvXphC7aB6GwdIiRl7VaJ8M6DMhNgn4D
         /UDpqbaBEbX6JPpnNz0sc6Vigm8PeY5S5dxaLx33JDSc5DoeA5ly1zDaa2wSWwwHmZhG
         4bYSPUYwtPsCSq0qzmUFYTycP/LRORChyfKMQMSjUvJFlMR3ZP9/r6d81IeofghZ5gwi
         qo8w==
X-Gm-Message-State: AOAM5320V6dtXlOEs5gwg57ssVZDPsKmVwtKU86MVNf0MrAmxPwNveo2
        jky3xW8w9+oRSXkXl9TO/RpTgfHSGvYYDpImMOHsfptfDk4xSg==
X-Google-Smtp-Source: ABdhPJzelYK9O3CIcT5zG4BRubsgO1OlrCDfwgrXKOB+RXTq5LGiJLD6G6sP+nzFxUJmy76wkD7p2RysWOjtxfEcOQM=
X-Received: by 2002:a17:906:319a:: with SMTP id 26mr258506ejy.9.1604023298649;
 Thu, 29 Oct 2020 19:01:38 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 30 Oct 2020 12:01:27 +1000
Message-ID: <CAPM=9tw8m2318cixWC-_BvLTpO7usf6wiYiNbdT3W9NaVa5qpg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.10-rc2
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

A busier rc2 than normal, have larger sets of fixes for amdgpu +
nouveau, along with some i915, docs, core, panel, sun4i, v3d, vc4
fixes.

Nothing spooky though or pumpkin related.

Dave.

drm-fixes-2020-10-30-1:
drm fixes for 5.10-rc2

docs:
- kernel doc fixes

core:
- fix shmem helpers dma-buf mmap bug

amdgpu:
- Add new navi1x PCI ID
- GPUVM reserved area fixes
- Misc display fixes
- Fix bad interactions between display code and CONFIG_KGDB
- Fixes for SMU manual fan control and i2c

nouveau:
- endian regression fix for old gpus
- buffer object refcount fix
- uapi start/end alignment fix
- display notifier fix
- display clock checking fixes

i915:
- Fix max memory region size calculation
- Restore ILK-M RPS support, restoring performance
- Reject 90/270 degree rotated initial fbs

panel:
- mantix reset fixes

sun4i:
- scalar fix

vc4:
- hdmi audio fixes

v3d:
- fix double free
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec=
:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-30-1

for you to fetch changes up to 7babd126327b8b5a3904d2f8f01c95235801af2a:

  Merge tag 'drm-intel-fixes-2020-10-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-10-30
11:54:11 +1000)

----------------------------------------------------------------
drm fixes for 5.10-rc2

docs:
- kernel doc fixes

core:
- fix shmem helpers dma-buf mmap bug

amdgpu:
- Add new navi1x PCI ID
- GPUVM reserved area fixes
- Misc display fixes
- Fix bad interactions between display code and CONFIG_KGDB
- Fixes for SMU manual fan control and i2c

nouveau:
- endian regression fix for old gpus
- buffer object refcount fix
- uapi start/end alignment fix
- display notifier fix
- display clock checking fixes

i915:
- Fix max memory region size calculation
- Restore ILK-M RPS support, restoring performance
- Reject 90/270 degreerotated initial fbs

panel:
- mantix reset fixes

sun4i:
- scalar fix

vc4:
- hdmi audio fixes

v3d:
- fix double free

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/display: use kvzalloc again in dc_create_state
      drm/amdgpu/swsmu: drop smu i2c bus on navi1x
      drm/amdgpu/pm: fix the fan speed in fan1_input in manual mode for nav=
i1x

Christian K=C3=B6nig (1):
      drm/amdgpu: increase the reserved VM size to 2MB

Dan Carpenter (1):
      drm/v3d: Fix double free in v3d_submit_cl_ioctl()

Daniel Vetter (1):
      drm/shme-helpers: Fix dma_buf_mmap forwarding bug

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-5.10-2020-10-29' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-10-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'linux-5.10' of git://github.com/skeggsb/linux into drm-=
fixes
      Merge tag 'drm-intel-fixes-2020-10-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

David Galiffi (1):
      drm/amd/display: Fixed panic during seamless boot.

Dmytro Laktyushkin (1):
      drm/amd/display: prevent null pointer access

Guido G=C3=BCnther (3):
      drm/panel: mantix: Don't dereference NULL mode
      drm/panel: mantix: Fix panel reset
      dt-binding: display: Require two resets on mantix panel

Hoegeun Kwon (1):
      drm/vc4: drv: Add error handding for bind

Karol Herbst (2):
      drm/nouveau/gem: fix "refcount_t: underflow; use-after-free"
      drm/nouveau/device: fix changing endianess code to work on older GPUs

Kenneth Feng (1):
      drm/amd/pm: fix the wrong fan speed in fan1_input

Lyude Paul (3):
      drm/nouveau/kms/nv50-: Program notifier offset before requesting disp=
 caps
      drm/nouveau/kms/nv50-: Get rid of bogus nouveau_conn_mode_valid()
      drm/nouveau/kms/nv50-: Fix clock checking algorithm in
nv50_dp_mode_valid()

Madhav Chauhan (1):
      drm/amdgpu: don't map BO in reserved region

Martin Leung (1):
      drm/amd/display: adding ddc_gpio_vga_reg_list to ddc reg def'ns

Matthew Auld (1):
      drm/i915/region: fix max size calculation

Mauro Carvalho Chehab (7):
      drm: kernel-doc: document drm_dp_set_subconnector_property() params
      drm/dp: fix kernel-doc warnings at drm_dp_helper.c
      drm/dp: fix a kernel-doc issue at drm_edid.c
      drm: drm_edid: remove a duplicated kernel-doc declaration
      drm: kernel-doc: add description for a new function parameter
      drm: kernel-doc: drm_dp_helper.h: fix a typo
      drm: drm_print.h: fix kernel-doc markups

Maxime Ripard (7):
      Merge remote-tracking branch 'drm-misc/drm-misc-next-fixes' into
drm-misc-fixes
      drm/sun4i: frontend: Rework a bit the phase data
      drm/sun4i: frontend: Reuse the ch0 phase for RGB formats
      drm/sun4i: frontend: Fix the scaler phase on A33
      drm/vc4: hdmi: Avoid sleeping in atomic context
      drm/vc4: hdmi: Add a name to the codec DAI component
      drm/vc4: Rework the structure conversion functions

Ralph Campbell (1):
      drm/nouveau/nouveau: fix the start/end range for migration

Takashi Iwai (3):
      drm/amd/display: Fix kernel panic by dal_gpio_open() error
      drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
      drm/amd/display: Clean up debug macros

Tianci.Yin (2):
      drm/amdgpu: disable DCN and VCN for navi10 blockchain SKU(v3)
      drm/amdgpu: add DID for navi10 blockchain SKU

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Restore ILK-M RPS support
      drm/i915: Reject 90/270 degree rotated initial fbs

 .../display/panel/mantix,mlaf057we51-x.yaml        |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    | 14 +++-
 drivers/gpu/drm/amd/display/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  | 12 ++--
 .../amd/display/dc/gpio/dcn30/hw_factory_dcn30.c   | 12 ++++
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c    |  4 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          | 33 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 36 +---------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 11 +---
 drivers/gpu/drm/drm_dp_helper.c                    | 12 +++-
 drivers/gpu/drm/drm_edid.c                         |  2 +-
 drivers/gpu/drm/drm_gem.c                          |  4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |  7 +-
 drivers/gpu/drm/drm_prime.c                        |  1 +
 drivers/gpu/drm/i915/display/intel_display.c       |  4 ++
 drivers/gpu/drm/i915/i915_pci.c                    |  1 +
 drivers/gpu/drm/i915/intel_memory_region.c         |  2 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   | 77 ++++++++++++++++++=
++++
 drivers/gpu/drm/i915/selftests/mock_region.c       |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/core.h            |  2 +
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        | 41 +++++++++++-
 drivers/gpu/drm/nouveau/dispnv50/core907d.c        | 36 +++++++++-
 drivers/gpu/drm/nouveau/dispnv50/core917d.c        |  2 +-
 .../gpu/drm/nouveau/include/nvhw/class/cl507d.h    |  5 +-
 .../gpu/drm/nouveau/include/nvhw/class/cl907d.h    |  4 ++
 drivers/gpu/drm/nouveau/nouveau_connector.c        | 36 +++-------
 drivers/gpu/drm/nouveau/nouveau_dp.c               | 31 +++++----
 drivers/gpu/drm/nouveau/nouveau_gem.c              |  3 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              | 14 +---
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 39 +++++++----
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c   | 25 ++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.c             | 36 +++-------
 drivers/gpu/drm/sun4i/sun4i_frontend.h             |  6 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |  1 -
 drivers/gpu/drm/vc4/vc4_drv.c                      |  1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      | 12 ++--
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  6 +-
 include/drm/drm_dp_helper.h                        |  2 +-
 include/drm/drm_edid.h                             |  7 --
 include/drm/drm_print.h                            | 20 +++++-
 45 files changed, 380 insertions(+), 210 deletions(-)
