Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93292D6EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395242AbgLKDxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgLKDxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:53:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:52:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m5so7592821wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=erkHhBLeoi7N19jRIQfoLzRWFMhP1U3Oh23iMLxflVk=;
        b=ke86EZJefhwIyQFcRu45kNKEBD8CiptjNmwOMltZdw4kAj2faQoudXYiI4n7EZxuVQ
         P0mu/JJ8OqawuHoDiVl6f+xM0yeZnIwkTcHFwMHtbYLO8Y9zWzA9sSO75d0JZUP7vCYj
         kmctoR0kfCus4HMDsWDjM+dJ7SApF9sZpsFrsJv5Fl5qj1Tkfin+RYcVgJR84DhxPaLh
         j5JV8ywLtUTIjTJlC+MrHXeSP1wzaxBBPjcqIYye7J45SrizagE+DSa4Vyq/j9g4NEK0
         /iXztv4fi8dADi9M6sD6aTWUoBvY+SGLKpAf7baNhNXnvMN+jV7Vgtw0FH+dAhXGK8Jg
         cM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=erkHhBLeoi7N19jRIQfoLzRWFMhP1U3Oh23iMLxflVk=;
        b=SefkJU2M+wPizWG8VQGP0EhhAMK8pbGqyu125XAhu7N2L0M5/Eala4OEQs2ED0G4YK
         BIZSF4QcBqtuu3dsTJpOrIqd1Lv7Qp54FZXKeVGPjNQVd/W+vHxNSMf+7xkKstMaKasL
         zfiW0vXFagKcS3a1ABUtN0+8qEqDep1fcCyEDAzzrOT0eqiWmY72U9f7uTB5tMroqQC7
         hgMH3hdHQFzI7VSucWjyahLTeHjt0gI5vKs2SXC20jZroNpk7a2MHkIr8QnFDsemF7Ta
         m4nlJaIWJADOSrJMFjEDFO/DsqWgtbs/dVJ2iQecBCn5OSU6gGUAoNxh5L0qaIGilDss
         U9eA==
X-Gm-Message-State: AOAM533nMTYwfXpTJjQO2LjEQ9jUrKhM0EgwwvEaSJzsI9AMcMxXXNw+
        mA0koZuChAo0RhSCTCi4Mj2i6ufmnt00laf9G6pz0acnWJdIoQ==
X-Google-Smtp-Source: ABdhPJy5hEC33AnyG8Xxm/DssNmX/cfPRRVl5fxkJTk9EtoFR96d6d0FSBmyMpmJgZ8ZJLw+HdZWtcd0uMCFRT5jYeE=
X-Received: by 2002:adf:8285:: with SMTP id 5mr11198266wrc.289.1607658755212;
 Thu, 10 Dec 2020 19:52:35 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Dec 2020 13:52:21 +1000
Message-ID: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
Subject: [git pull] drm for 5.11-rc1
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

This is an early pull request for drm for 5.11 merge window. I'm going
to be out for most of the first week of the merge window so thought
I'd just preempt things and send this early.

Not a huge amount of big things here, AMD has support for a few new HW
variants (vangogh, green sardine, dimgrey cavefish), Intel has some
more DG1 enablement. We have a few big reworks of the TTM layers and
interfaces, GEM and atomic internal API reworks cross tree. fbdev is
marked orphaned in here as well to reflect the current reality.

I've done a test merge into 5.10-rc7 + my earlier drm-fixes + this,
there are a few minor conflicts, but none of them are at all scary,
the nouveau one is the worst and is just a remove the code added in
fixes in favour of next as the change is elsewhere in the next code.

There is one silent build failure after merge:
https://lore.kernel.org/dri-devel/20201209125357.64825ba6@canb.auug.org.au/
again pretty trivial fixup required.

Regards,
Dave.

drm-next-2020-12-11:
drm for 5.11-rc1

core:
- documentation updates
- deprecate DRM_FORMAT_MOD_NONE
- atomic crtc enable/disable rework
- GEM convert drivers to gem object functions
- remove SCATTER_LIST_MAX_SEGMENT

sched:
- avoid infinite waits

ttm:
- remove AGP support
- don't modify caching for swapout
- ttm pinning rework
- major TTM reworks
- new backend allocator
- multihop support

vram-helper:
- top down BO placement fix
- TTM changes
- GEM object support

displayport:
- DP 2.0 DPCD prep work
- DP MST extended DPCD caps

fbdev:
- mark as orphaned

amdgpu:
- Initial Vangogh support
- Green Sardine support
- Dimgrey Cavefish support
- SG display support for renoir
- SMU7 improvements
- gfx9+ modiifier support
- CI BACO fixes

radeon:
- expose voltage via hwmon on SUMO

amdkfd:
- fix unique id handling

i915:
- more DG1 enablement
- bigjoiner support
- integer scaling filter support
- async flip support
- ICL+ DSI command mode
- Improve display shutdown
- Display refactoring
- eLLC machine fbdev loading fix
- dma scatterlist fixes
- TGL hang fixes
- eLLC display buffer caching on SKL+
- MOCS PTE seeting for gen9+

msm:
- Shutdown hook
- GPU cooling device support
- DSI 7nm and 10nm phy/pll updates
- sm8150/sm2850 DPU support
- GEM locking re-work
- LLCC system cache support

aspeed:
- sysfs output config support

ast:
- LUT fix
- new display mode

gma500:
- remove 2d framebuffer accel

panfrost:
- move gpu reset to a worker

exynos:
- new HDMI mode support

mediatek:
- MT8167 support
- yaml bindings
- MIPI DSI phy code moved

etnaviv:
- new perf counter
- more lockdep annotation

hibmc:
- i2c DDC support

ingenic:
- pixel clock reset fix
- reserved memory support
- allow both DMA channels at once
- different pixel format support
- 30/24/8-bit palette modes

tilcdc:
- don't keep vblank irq enabled

vc4:
- new maintainer added
- DSI registration fix

virtio:
- blob resource support
- host visible and cross-device support
- uuid api support
The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091=
:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-12-11

for you to fetch changes up to b10733527bfd864605c33ab2e9a886eec317ec39:

  Merge tag 'amd-drm-next-5.11-2020-12-09' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-12-10
16:55:53 +1000)

----------------------------------------------------------------
drm for 5.11-rc1

core:
- documentation updates
- deprecate DRM_FORMAT_MOD_NONE
- atomic crtc enable/disable rework
- GEM convert drivers to gem object functions
- remove SCATTER_LIST_MAX_SEGMENT

sched:
- avoid infinite waits

ttm:
- remove AGP support
- don't modify caching for swapout
- ttm pinning rework
- major TTM reworks
- new backend allocator
- multihop support

vram-helper:
- top down BO placement fix
- TTM changes
- GEM object support

displayport:
- DP 2.0 DPCD prep work
- DP MST extended DPCD caps

fbdev:
- mark as orphaned

amdgpu:
- Initial Vangogh support
- Green Sardine support
- Dimgrey Cavefish support
- SG display support for renoir
- SMU7 improvements
- gfx9+ modiifier support
- CI BACO fixes

radeon:
- expose voltage via hwmon on SUMO

amdkfd:
- fix unique id handling

i915:
- more DG1 enablement
- bigjoiner support
- integer scaling filter support
- async flip support
- ICL+ DSI command mode
- Improve display shutdown
- Display refactoring
- eLLC machine fbdev loading fix
- dma scatterlist fixes
- TGL hang fixes
- eLLC display buffer caching on SKL+
- MOCS PTE seeting for gen9+

msm:
- Shutdown hook
- GPU cooling device support
- DSI 7nm and 10nm phy/pll updates
- sm8150/sm2850 DPU support
- GEM locking re-work
- LLCC system cache support

aspeed:
- sysfs output config support

ast:
- LUT fix
- new display mode

gma500:
- remove 2d framebuffer accel

panfrost:
- move gpu reset to a worker

exynos:
- new HDMI mode support

mediatek:
- MT8167 support
- yaml bindings
- MIPI DSI phy code moved

etnaviv:
- new perf counter
- more lockdep annotation

hibmc:
- i2c DDC support

ingenic:
- pixel clock reset fix
- reserved memory support
- allow both DMA channels at once
- different pixel format support
- 30/24/8-bit palette modes

tilcdc:
- don't keep vblank irq enabled

vc4:
- new maintainer added
- DSI registration fix

virtio:
- blob resource support
- host visible and cross-device support
- uuid api support

----------------------------------------------------------------
AMD\ramini (1):
      drm/amd/display: Set FixRate bit in VSIF V3

Aaron Liu (1):
      drm/amdgpu: enable green_sardine_asd.bin loading (v2)

Aaron Ma (2):
      drm/i915/dpcd_bl: uncheck PWM_PIN_CAP when detect eDP backlight
capabilities
      drm/i915: Force DPCD backlight mode for BOE 2270 panel

Abhinav Kumar (2):
      drm/msm/dp: do not notify audio subsystem if sink doesn't support aud=
io
      drm/msm/dpu: update the qos remap only if the client type changes

Aditya Swarup (4):
      drm/i915/display: allow to skip certain power wells
      drm/i915/dg1: Add DPLL macros for DG1
      drm/i915/dg1: Add and setup DPLLs for DG1
      drm/i915/dg1: Enable ports

Akhil P Oommen (4):
      drm/msm: Implement shutdown callback for adreno
      drm/msm: Fix duplicate gpu node in icc summary
      drm/msm: Add support for GPU cooling
      dt-bindings: drm/msm/gpu: Add cooling device support

Alex Deucher (54):
      drm/amdgpu/gfx10: add updated register offsets for VGH
      drm/amdgpu: IP discovery table is not ready yet for VG
      drm/amdgpu/mmhub2.3: print client id string for mmhub
      drm/amdgpu/swsmu: fix ARC build errors
      drm/amdgpu: prevent spurious warning
      drm/amdgpu: add Green_Sardine APU flag
      drm/amdgpu/swsmu: clean up a bunch of stale interfaces
      drm/amdgpu/swsmu: init the baco mutex in early_init
      drm/amdgpu/display: DRM_AMD_DC_DCN3_02 depends on DRM_AMD_DC_DCN3_01
      drm/amdgpu: move amdgpu_num_kcq handling to a helper
      drm/amdgpu/gmc10: remove dummy read workaround for newer chips
      drm/amdgpu: add GC 10.3 NOALLOC registers
      drm/amdgpu/display: use kvzalloc again in dc_create_state
      drm/amdgpu/swsmu: drop smu i2c bus on navi1x
      drm/amdgpu/pm: fix the fan speed in fan1_input in manual mode for nav=
i1x
      drm/amdgpu/display: re-add surface size calculation in dcn30_hwseq.c
      drm/amdgpu/display: fix indentation in defer_delay_converter_wa()
      drm/amdgpu/powerplay: Only apply optimized mclk dpm policy on polaris
      drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
      drm/amdgpu/display: remove dal_cmd_tbl_helper_dcn2_get_table2
      drm/amdgpu: drop CONFIG_DRM_AMD_DC_DCN3_01 from atomfirmware.h
      drm/amdgpu: allow TMZ on vangogh
      drm/amdgpu/display: fix warnings when CONFIG_DRM_AMD_DC_DCN is not se=
t
      drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (=
v3)
      drm/amdgpu/display: FP fixes for DCN3.x (v4)
      drm/amdgpu/virt: fix handling of the atomic flag
      drm/amdgpu/pm/smu12: cache smu firmware version
      drm/amdgpu/pm/smu11: cache smu firmware version
      drm/amdgpu/display: fix FP handling in DCN30
      drm/amd/display: Add missing pflip irq for dcn2.0
      drm/amdgpu: remove experimental flag from arcturus
      drm/amdgpu: only register VGA devices with the VGA arbiter
      drm/amdgpu: default noretry=3D0 for navi1x and newer (v2)
      drm/amdgpu: enable AGP aperture on gmc10.x (v2)
      drm/amdgpu/swsmu/vangogh: return error if fetching metrics fails
      drm/amdgpu/powerplay/tonga: return an error if copying to smc fails
      drm/amdgpu/powerplay/ci: return an error if copying to smc fails
      drm/amdgpu/powerplay/iceland: return an error if copying to smc fails
      drm/amdgpu/powerplay/vega10: handle error in getting pptable
      drm/amdgpu/powerplay/psm: return an error in power state init
      drm/amdgpu/swsmu/navi1x: simplify sensor handling
      drm/amdgpu/swsmu/arcturus: simplify sensor handling
      drm/amdgpu/swsmu/sienna_cichlid: simplify sensor handling
      drm/amdgpu/swsmu: add metrics enums for voltage
      drm/amdgpu/swsmu/vangogh: simplify sensor handling
      drm/amdgpu/swsmu/vangogh: use metrics table for voltages (v2)
      drm/amdgpu/swsmu/renoir: simplify sensor handling (v2)
      drm/amdgpu/powerplay: parse fan table for CI asics
      drm/amdgpu/disply: set num_crtc earlier
      drm/amdgpu/cik: enable BACO reset on Bonaire
      drm/amdgpu: enable runtime pm using BACO on CI dGPUs
      drm/amdgpu: free the pre-OS console framebuffer after the first modes=
et
      drm/amdgpu: remove amdgpu_ttm_late_init  and amdgpu_bo_late_init
      drm/amdgpu: fix size calculation with stolen vga memory

Alex Shi (1):
      video: fbdev: riva: remove some unused varibles

Alex Sierra (1):
      drm/amdgpu: replace ih ip block for vega20 and arcturus

Alexander A. Klimov (1):
      drm: omapdrm: Replace HTTP links with HTTPS ones

Alexandru Gagniuc (3):
      drm/bridge: sii902x: Refactor init code into separate function
      dt-bindings: display: sii902x: Add supply bindings
      drm/bridge: sii902x: Enable I/O and core VCC supplies if present

Alexei Podtelezhnikov (4):
      drm/i915: Update Haswell PCI IDs
      drm/i915: Reclassify SKL 0x192a as GT3
      drm/i915: Reclassify SKL 0x1923 and 0x1927 as ULT
      drm/i915: Add SKL GT1.5 PCI IDs

Alistair Delva (1):
      virtio-gpu api: fix 64/32 compat issue with blob implementation

Alvin Lee (8):
      drm/amd/display: Don't allow pstate if no support in blank
      drm/amd/display: Program meta addresses correctly
      drm/amd/display: Only flush inst_fb if backdoor loading
      drm/amd/display: Set WM set A to 0 if full pstate not supported
      drm/amd/display: Update GSL state if leaving immediate flip
      drm/amd/display: Keep GSL for full updates with planes that flip VSYN=
C
      drm/amd/display: Reset flip_immediate to topmost plane
      drm/amd/display: Check other planes for iflip only if GSL already ena=
bled

Andrey Grodzovsky (4):
      drm/amd/display: Revert "drm/amd/display: Fix a list corruption"
      drm/amd/display: Avoid MST manager resource leak.
      drm/amd/psp: Fix sysfs: cannot create duplicate filename
      drm/amdgpu: Initialise drm_gem_object_funcs for imported BOs

Andy Shevchenko (2):
      drm: shmobile: Reduce include dependencies
      drm/virtio: Use UUID API for importing the UUID

Anitha Chrisanthus (8):
      dt-bindings: display: Add support for Intel KeemBay Display
      dt-bindings: display: Intel KeemBay MSSCAM
      dt-bindings: display: bridge: Intel KeemBay DSI
      drm/kmb: Keem Bay driver register definition
      drm/kmb: Add support for KeemBay Display
      drm/kmb: Mipi DSI part of the display driver
      drm/kmb: Build files for KeemBay Display driver
      drm/kmb: Fix build warnings

Anshuman Gupta (2):
      drm/i915/dg1: DG1 does not support DC6
      drm/i915/dg1: Update DMC_DEBUG register

Anthony Koo (9):
      drm/amd/display: [FW Promotion] Release 0.0.36
      drm/amd/display: [FW Promotion] Release 0.0.37
      drm/amd/display: [FW Promotion] Release 0.0.38
      drm/amd/display: [FW Promotion] Release 0.0.39
      drm/amd/display: [FW Promotion] Release 0.0.40
      drm/amd/display: [FW Promotion] Release 0.0.41
      drm/amd/display: [FW Promotion] Release 0.0.42
      drm/amd/display: [FW Promotion] Release 0.0.44
      drm/amd/display: [FW Promotion] Release 0.0.45

Antonio Borneo (2):
      drm/panel: otm8009a: remove hack to force commands in HS
      drm/panel: otm8009a: allow using non-continuous dsi clock

Anusha Srivatsa (1):
      drm/i915/ehl: Remove invalid PCI ID

Aric Cyr (15):
      drm/amd/display: 3.2.105
      drm/amd/display: Check for flip pending before locking pipes
      drm/amd/display: FreeSync not active near lower bound of non-LFC
monitor range
      drm/amd/display: 3.2.106
      drm/amd/display: 3.2.107
      drm/amd/display: Don't trigger flip twice when ODM combine in use
      drm/amd/display: 3.2.108
      drm/amd/display: 3.2.109
      drm/amd/display: 3.2.110
      drm/amd/display: Only wait for flip pending on immediate flips
      drm/amd/display: 3.2.111
      drm/amd/display: 3.2.112
      drm/amd/display: 3.2.113
      drm/amd/display: DC Release 3.2.114
      drm/amd/display: 3.2.115

Arnd Bergmann (10):
      fbdev: simplify fb_getput_cmap()
      fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
      fbdev: sbuslib: remove compat_alloc_user_space usage
      matroxfb: avoid -Warray-bounds warning
      drm/tilcdc: avoid 'make W=3D2' build failure
      drm/amdgpu: fix incorrect enum type
      drm/amdgpu: fix build_coefficients() argument
      drm/msm: add IOMMU_SUPPORT dependency
      drm/amdgpu: fix debugfs creation/removal, again
      drm/amdgpu: fw_attestation: fix unused function warning

Arunpravin (1):
      drm/amdgpu/pm/smu11: Fix fan set speed bug

Ashley Thomas (3):
      drm/amd/display: Source minimum HBlank support
      drm/amd/display: fail instead of div by zero/bugcheck
      drm/amd/display: Source minimum HBlank support

Aurabindo Pillai (2):
      drm/amd/display: Clear dc remote sinks on MST disconnect
      drm/amd/display: turn DPMS off on connector unplug

Ayaz A Siddiqui (1):
      drm/i915/gt: Initialize reserved and unspecified MOCS indices

Bartlomiej Zolnierkiewicz (1):
      MAINTAINERS: mark FRAMEBUFFER LAYER as Orphan

Bas Nieuwenhuizen (16):
      drm/amd/display: Initialize num_pkrs on VANGOGH.
      drm/amd/display: Do not silently accept DCC for multiplane formats.
      drm/amd: Init modifier field of helper fb.
      drm/amd/display: Honor the offset for plane 0.
      drm/fourcc: Add AMD DRM modifiers.
      drm/amd/display: Store tiling_flags in the framebuffer.
      drm/amd/display: Convert tiling_flags to modifiers.
      drm/amd/display: Refactor surface tiling setup.
      drm/amd/display: Set DC options from modifiers.
      drm/amd/display: Add formats for DCC with 2/3 planes.
      drm/amd/display: Expose modifiers.
      drm/amd/display: Clean up GFX9 tiling_flags path.
      drm/fourcc: Fix modifier field mask for AMD modifiers.
      drm/amd/display: Store gem objects for planes 1-3
      drm/amd/display: Set new format info for converted metadata.
      drm/amd/display: Extract 3rd plane from metadata

Ben Skeggs (1):
      drm/nouveau/ttm: avoid using nouveau_drm.ttm.type_vram prior to nv50

Bernard Zhao (8):
      drm/amd/display: remove no need return value
      drm/via: reduce no need mutex_lock area
      gpu/drm: delete same check in if condition
      drm/amd: fix typoes
      drm/mediatek: Optimize functions which do not need to return
      amd/display/amdgpu_dm: delete same check in if condition
      amdgpu/amdgpu_ids: fix kmalloc_array not uses number as first arg
      amd/amdgpu: use kmalloc_array to replace kmalloc with multiply

Bhaskar Chowdhury (3):
      drivers: amdgpu: Correct spelling defalut to default in comment
      drivers: amdgpu: amdgpu_display.c: Fix a spelling doens\'t to doesn\'=
t
      drivers: amdgpu: amdgpu_display: Fixed the spelling of falg to flag

Bhawanpreet Lakha (14):
      drm/amd/display: Add missing function pointers for dcn3
      drm/amd/display: Add support for DCN302 (v2)
      drm/amd/display: Add DCN302 support in amdgpu_dm (v2)
      drm/amd/display: Use amdgpu_socbb.h instead of redefining structs
      drm/amd/display: Fix DCN302 makefile
      drm/amdgpu/display: add MALL support (v2)
      drm/amd/display: Add missing pflip irq
      drm/amdgpu: Add and use seperate reg headers for dcn302
      drm/amdgpu: Use PSP_FW_NAME_LEN instead of magic number
      drm/amdgpu: Enable TA firmware loading for dimgrey_cavefish
      drm/amd/display: Update dmub code
      drm/amd/display: Add display only once.
      drm/amd/display: Add comments to hdcp property change code
      drm/amd/display: Add DPCS regs for dcn302 link encoder

Biju Das (3):
      drm/bridge: lvds-codec: Add support for regulator
      drm/panel: panel-simple: Add connector_type for EDT ETM0700G0DH6 pane=
l
      drm/bridge: lvds-codec: Use dev_err_probe for error handling

Bob Paauwe (1):
      drm/i915: Tweaked Wa_14010685332 for PCHs used on gen11 platforms

Bokun Zhang (3):
      drm/amd/amdgpu: Fix incorrect logic to increment VCN doorbell index
      drm/amd/amdgpu: Add rev_id workaround logic for SRIOV setup
      drm/amd/amdgpu: Update VCN initizalization behvaior

Boris Brezillon (4):
      drm/sched: Avoid infinite waits in the drm_sched_entity_destroy() pat=
h
      drm/panfrost: Fix job timeout handling
      drm/panfrost: Remove unused variables in panfrost_job_close()
      drm/panfrost: Move the GPU reset bits outside the timeout handler

Boyuan Zhang (3):
      drm/amdgpu: enable VCN PG and CG for vangogh
      drm/amdgpu/vcn3.0: stall DPG when WPTR/RPTR reset
      drm/amdgpu/vcn3.0: remove old DPG workaround

Brandon Syu (2):
      drm/amd/display: skip avmute action
      drm/amd/display: Init clock value by current vbios CLKs

Caleb Connolly (2):
      dt-bindings: panel-simple-dsi: add samsung panels for OnePlus 6/T
      drm/panel/samsung-sofef00: Add panel for OnePlus 6/T devices

Camille Cho (1):
      drm/amd/display: To update backlight restore mechanism

Changfeng (2):
      drm/amdgpu: modify cp_flags to pg_flags in gfx_v10_cntl_power_gating
      drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for raven

Charlene Liu (3):
      drm/amd/display: Add i2c speed arbitration for dc_i2c and hdcp_i2c
      drm/amd/display: add i2c speed arbitration for dc_i2c and hdcp_i2c
      drm/amd/display: Enable gpu_vm_support for dcn3.01

Chengming Gui (5):
      drm/amdkfd: Support dimgrey_cavefish KFD (v2)
      drm/amdkfd: Add kfd2kgd_funcs for dimgrey_cavefish kfd support
      drm/amd/amdgpu: set the default value of noretry to 1 for some dGPUs
      drm/amd/amdgpu: enable noretry for
Sienna_Cichlid/Navy_Flounder/Dimgrey_Cavefish
      drm/amd/amdgpu:  simplify pa_sc_tile_steering_override check

Chris Park (3):
      drm/amd/display: Update panel register
      drm/amd/display: Update panel register
      drm/amd/display: Prevent bandwidth overflow

Chris Wilson (54):
      drm/i915/gem: Avoid implicit vmap for highmem on x86-32
      drm/i915/gem: Prevent using pgprot_writecombine() if PAT is not suppo=
rted
      drm/i915/gt: Clear the buffer pool age before use
      drm/i915/gt: Check for a registered driver with IPS
      drm/i915/gt: Widen CSB pointer to u64 for the parsers
      drm/i915/gt: Wait for CSB entries on Tigerlake
      drm/i915/gt: Apply the CSB w/a for all
      drm/i915/gt: Use a mmio read of the CSB in case of failure
      drm/i915/gt: Show engine properties in the pretty printer
      drm/i915: Break up error capture compression loops with cond_resched(=
)
      drm/i915: Reduce GPU error capture mutex hold time
      drm/i915/gt: Remove defunct intel_virtual_engine_get_sibling()
      drm/i915/gem: Serialise debugfs i915_gem_objects with ctx->mutex
      drm/i915: Redo "Remove i915_request.lock requirement for
execution callbacks"
      drm/i915/gem: Hold request reference for canceling an active context
      drm/i915: Cancel outstanding work after disabling heartbeats on an en=
gine
      drm/i915/gt: Always send a pulse down the engine after disabling hear=
tbeat
      drm/i915/gem: Always test execution status on closing the context
      drm/i915: Avoid mixing integer types during batch copies
      drm/i915/gt: Signal cancelled requests
      drm/i915/selftests: Finish pending mock requests on cancellation.
      drm/i915/gt: Retire cancelled requests on unload
      drm/i915: Skip over MI_NOOP when parsing
      drm/i915/gt: Scrub HW state on remove
      drm/i915/gt: Track the most recent pulse for the heartbeat
      drm/i915/gt: Fixup tgl mocs for PTE tracking
      drm/i915/gem: Support parsing of oversize batches
      drm/i915/gt: Delay execlist processing for tgl
      drm/i915/gt: Undo forced context restores after trivial preemptions
      drm/i915/gt: Cleanup kasan warning for on-stack (unsigned long) casti=
ng
      drm/i915/gt: Confirm the context survives execution
      drm/i915: Use the active reference on the vma while capturing
      drm/i915/gt: Onion unwind for scratch page allocation failure
      drm/i915/gem: Poison stolen pages before use
      drm/i915: Exclude low pages (128KiB) of stolen from use
      drm/i915: Force VT'd workarounds when running as a guest OS
      drm/i915: Drop runtime-pm assert from vgpu io accessors
      drm/i915/selftests: Flush the old heartbeat more gently
      drm/i915/display: Unkerneldoc cnl_program_nearest_filter_coefs
      drm/i915/gem: Flush coherency domains on first set-domain-ioctl
      drm/i915: Reset the interrupt mask on disabling interrupts
      drm/i915/selftests: Skip RPS tests on Ironlake (only IPS)
      drm/i915/gt: Use the local HWSP offset during submission
      drm/i915/selftests: Exercise intel_timeline_read_hwsp()
      drm/i915/gem: Avoid synchronous binds deep within locks
      drm: Quieten [zero] EDID carping
      drm/i915: Reduce severity for fixing up mistaken VBT tc->legacy_port
      drm/i915/gt: Expose more parameters for emitting writes into the ring
      drm/i915/gt: Flush xcs before tgl breadcrumbs
      drm/i915: Hold onto an explicit ref to i915_vma_work.pinned
      drm/i915/gem: Perform all asynchronous waits prior to marking
payload start
      drm/i915/gem: Pull phys pread/pwrite implementations to the backend
      drm/i915/display: Whitespace cleanups
      drm/i915/display: Defer initial modeset until after GGTT is initialis=
ed

Christian Gmeiner (4):
      drm/etnaviv: rename pipe_reg_read(..)
      drm/etnaviv: call perf_reg_read(..)
      drm/etnaviv: add total hi bandwidth perfcounter
      drm/etnaviv: add pipe_select(..) helper

Christian K=C3=B6nig (66):
      drm/ttm: remove nonsense AGP handling
      drm/ttm: stop dangerous caching attribute change
      drm/nouveau: stop using persistent_swap_storage
      drm/ttm: remove persistent_swap_storage
      drm/ttm: add ttm_bo_pin()/ttm_bo_unpin() v2
      drm/vmwgfx: remove unused placement combination
      drm/vmwgfx: stop using ttm_bo_create v2
      drm/vmwgfx: switch over to the new pin interface v2
      drm/nouveau: switch over to the new pin interface
      drm/vram-helper: switch over to the new pin interface
      drm/qxl: switch over to the new pin interface
      drm/radeon: switch over to the new pin interface
      drm/amdgpu: switch over to the new pin interface
      drm/ttm: remove ttm_bo_create
      drm/ttm: remove TTM_PL_FLAG_NO_EVICT
      drm/ttm: move SG flag check into ttm_bo_vm_reserve
      drm/radeon: stop using TTMs fault callback
      drm/amdgpu: stop using TTMs fault callback
      drm/nouveau: stop using TTMs fault callback
      drm/ttm: remove fault callback
      drm/qxl: fix usage of ttm_bo_init
      drm/ttm: remove TTM_PAGE_FLAG_WRITE
      drm/ttm: cleanup ttm_handle_caching_state_failure
      drm/ttm: nuke ttm_bo_evict_mm and rename mgr function v3
      drm/ttm: drop glob parameter from ttm_bo_swapout
      drm/vmwgfx: move ttm_bo_swapout_all into vmwgfx
      drm/ttm: remove ttm_bo_unmap_virtual_locked declaration v2
      drm/ttm: move ttm_set_memory.h out of include
      dma-buf: use struct_size macro
      drm/ttm: set the tt caching state at creation time
      drm/ttm: add caching state to ttm_bus_placement
      drm/ttm: use caching instead of placement for ttm_io_prot
      drm/ttm: nuke caching placement flags
      drm/ttm: nuke ttm_tt_set_(un)populated again
      drm/ttm: move swapin out of page alloc backend
      drm/ttm: make num_pages uint32_t
      drm/ttm: merge ttm_dma_tt back into ttm_tt
      drm/amdgpu: increase the reserved VM size to 2MB
      drm/amdgpu: nuke amdgpu_vm_bo_split_mapping v2
      drm/amdgpu: drop mem_global_referenced
      drm/ttm: new TT backend allocation pool v3
      drm/ttm: wire up the new pool as default one v2
      drm/amdgpu: switch to new allocator v2
      drm/radeon: switch to new allocator v2
      drm/nouveau: switch to new allocator
      drm/vmwgfx: switch to new allocator
      drm/qxl: drop ttm_page_alloc.h include
      drm/vram_helpers: drop ttm_page_alloc.h include
      drm/ttm: nuke old page allocator
      drm/amdgpu: cleanup gmc_v9_0_process_interrupt
      drm/nouveu: fix swiotlb include
      drm/ttm: rework no_retry handling v2
      drm/ttm: replace context flags with bools v2
      drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
      mm: mmap: fix fput in error path v2
      mm: introduce vma_set_file function v4
      Revert "mm: introduce vma_set_file function v4"
      Revert "mm: mmap: fix fput in error path v2"
      drm/ttm: fix missing NULL check in the new page pool
      drm/amdgpu: drop leading zeros from the gmc9 fault address
      drm/amdgpu: cleanup gmc_v10_0_process_interrupt a bit
      drm/amdgpu: add infrastructure for soft IH ring
      drm/amdgpu: enabled software IH ring for Vega
      drm/amdgpu: make sure retry faults are handled in a work item on Vega
      drm/amdgpu: enabled software IH ring for Navi
      drm/amdgpu: implement retry fault handling for Navi

Chun-Kuang Hu (3):
      drm/mediatek: Separate mtk_mipi_tx to an independent module
      phy: mediatek: Move mtk_mipi_dsi_phy driver into
drivers/phy/mediatek folder
      MAINTAINERS: add files for Mediatek DRM drivers

Clinton A Taylor (1):
      drm/i915/dg1: invert HPD pins

Colin Ian King (6):
      drm/gma500: clean up indentation issues
      drm/amd/pm: fix out-of-bound read on pptable->SkuReserved
      drm/amdgpu: fix spelling mistake: "Successed" -> "Succeeded"
      drm/kmb: fix spelling mistakes in drm_info and drm_dbg messages
      drm/amd/pm: fix spelling mistakes in dev_warn messages
      drm/amd/powerplay: fix spelling mistake "smu_state_memroy_block"
-> "smu_state_memory_block"

Colin Xu (3):
      drm/i915/gvt: Save/restore HW status to support GVT suspend/resume
      drm/i915: Add GVT resume routine to i915
      drm/i915/gvt: Fix virtual display setup for BXT/APL

Dale Zhao (1):
      drm/amd/display: WA to ensure MUX chip gets SUPPORTED_LINK_RATES of e=
DP

Dan Carpenter (3):
      drm/i915: Fix an error code i915_gem_object_copy_blt()
      drm/virtio: Fix a double free in virtio_gpu_cmd_map()
      drm/udl: Fix missing error code in udl_handle_damage()

Daniel Abrecht (1):
      drm: mxsfb: Implement .format_mod_supported

Daniel Vetter (20):
      drm/doc: Document that modifiers are always required for fb
      drm: update todo.rst
      drm/atomic: Make the kerneldoc a bit clearer
      drm/fb-helper: Add locking to sysrq handling
      drm/atomic: document and enforce rules around "spurious" EBUSY
      drm/atomic: debug output for EBUSY
      drm/vkms: Set preferred depth correctly
      drm/vkms: Switch to shmem helpers
      drm/vkms: fbdev emulation support
      drm: Give irq_by_busid drm_legacy_ prefix
      drm/doc: Document legacy_cursor_update better
      drm/radeon: Stop changing the drm_driver struct
      drm: Compile out legacy chunks from struct drm_device
      drm: Allow const struct drm_driver
      drm/<drivers>: Constify struct drm_driver
      Merge v5.10-rc3 into drm-next
      fbcon: Disable accelerated scrolling
      fbcon: Drop EXPORT_SYMBOL
      drm/qxl: Remove fbcon acceleration leftovers
      drm/docs: Fix todo.rst

Dave Airlie (50):
      drm/radeon: kill radeon_bo_wait
      drm/qxl: kill unused bo wait wrapper
      drm/radeon: cleanup ttm operation ctx usage.
      drm/nouveau/ttm: plumb ctx through move functions.
      drm/ttm: add bo wait that takes a ctx wrapper.
      drm/ttm: handle the SYSTEM->TT path in same place as others.
      drm/amdgpu/ttm: handle tt moves properly.
      drm/radeon/ttm: handle ttm moves properly
      drm/nouveau/ttm: handle ttm moves properly.
      drm/nouveau/ttm: memcpy waits for bo already
      drm/qxl: drop unused code (v2)
      drm/vmwgfx: move null mem checks outside move notifies
      drm/vmwgfx: add a move callback.
      drm/vram_helper: implement a ttm move callback.
      drm/ttm: make move callback compulstory
      drm/ttm: drop free old node wrapper.
      drm/ttm: refactor out common code to setup a new tt backed resource
      drm/ttm: split out the move to system from move ttm code
      drm/ttm: use new move interface for known system->ttm moves
      drm/ttm: add move old to system to drivers.
      drm/ttm: drop ttm_bo_move_ttm wrapper
      drm/ttm: move some move binds into the drivers
      drm/ttm: minor cleanup to move to system
      drm/ttm: add move to system into drivers
      drm/ttm: drop unbind callback.
      drm/ttm: remove move to new and inline into remainging place.
      drm/ttm: drop move notify around move.
      drm/ttm: move last binding into the drivers.
      drm/ttm: ttm_bo_mem_placement doesn't need ctx parameter.
      drm/ttm: replace last move_notify with delete_mem_notify
      drm/ttm: remove overlapping memcpy support
      Merge tag 'drm-misc-next-2020-10-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-queued-2020-11-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2020-11-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.11-2020-11-05' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      drm/ttm: add multihop infrastrucutre (v3)
      drm/amdgpu/ttm: use multihop
      drm/nouveau/ttm: use multihop
      drm/radeon/ttm: use multihop
      Merge tag 'drm-misc-next-2020-11-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      drm/Kconfig: rename keembay config
      Merge tag 'drm-intel-gt-next-2020-11-12-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'linux-5.11' of git://github.com/skeggsb/linux into drm-=
next
      Merge tag 'drm-misc-next-2020-11-18' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-queued-2020-11-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'exynos-drm-next-for-v5.11' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'mediatek-drm-next-5.11-2' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge tag 'drm-msm-next-2020-12-07' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'amd-drm-next-5.11-2020-12-09' of
git://people.freedesktop.org/~agd5f/linux into drm-next

David Galiffi (1):
      drm/amd/display: Fixed panic during seamless boot.

Deepak R Varma (17):
      drm/amdgpu/dce: improve code indentation and alignment
      drm/amdgpu/gfx: improve code indentation and alignment
      drm/amdgpu/vcn: improve code indentation and alignment
      drm/amdgpu/nbio: improve code indentation and alignment
      drm/amdgpu/amdgpu: improve code indentation and alignment
      drm/amdgpu: improve code indentation and alignment
      drm/amdgpu/vcn: use "*" adjacent to data name
      drm/amdgpu/umc: use "*" adjacent to data name
      drm/amdgpu/jpeg: use "*" adjacent to data name
      drm/amdgpu/sdma: use "*" adjacent to data name
      drm/amdgpu/amdgpu: use "*" adjacent to data name
      drm/amdgpu: use "*" adjacent to data name
      drm/amdgpu: do not initialise global variables to 0 or NULL
      drm/qxl: replace idr_init() by idr_init_base()
      drm/vc4: replace idr_init() by idr_init_base()
      drm/vgem: replace idr_init() by idr_init_base()
      drm/i915/gvt: replace idr_init() by idr_init_base()

Dennis Li (4):
      drm/amdgpu: protect eeprom update from GPU reset
      drm/amdgpu: change to save bad pages in UMC error interrupt callback
      drm/amdgpu: remove redundant GPU reset
      drm/amdgpu: fix the issue of reserving bad pages failed

Derek Lai (1):
      drm/amd/display: combined user regamma and OS GAMMA_CS_TFM_1D

Dinghao Liu (1):
      drm/omap: Fix runtime PM imbalance on error

Dmitry Baryshkov (14):
      drm/msm/dsi_pll_7nm: restore VCO rate during restore_state
      drm/msm/dsi_pll_10nm: restore VCO rate during restore_state
      drm/msm/dsi_phy_7nm: implement PHY disabling
      drm/msm/dsi_phy_10nm: implement PHY disabling
      drm/msm/dpu: simplify interface flush handling
      drm/msm/dpu: initial support for merge3D hardware block
      drm/msm/dpu: handle merge_3d configuration in hw_ctl block
      drm/msm/dpu: setup merge modes in merge_3d block
      drm/msm/dpu: enable merge_3d support on sm8150/sm8250
      drm/msm/dpu: fix clock scaling on non-sc7180 board
      drm/msm/dsi: do not try reading 28nm vco rate if it's not enabled
      dt-bindings: display: bridge: Add documentation for LT9611UXC
      drm: bridge: add support for lontium LT9611UXC bridge
      drm/msm/dpu: enable DSPP support on SM8[12]50

Dmytro Laktyushkin (9):
      drm/amd/display: Fix OPTC_DATA_FORMAT programming
      drm/amd/display: add dcn21 bw validation
      drm/amd/display: enable odm + full screen mpo on dcn21
      drm/amd/display: prevent null pointer access
      drm/amd/display: allow 18 bit dp output on DCN3
      drm/amd/display: fix recout calculation for left side clip
      drm/amd/display: correct dml dsc bpc assignment
      drm/amd/display: remove unused dml variables
      drm/amd/display: Expose clk_mgr functions for reuse

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Add retries for link training

Emily.Deng (1):
      drm/amdgpu: Remove warning for virtual_display

Enric Balletbo i Serra (1):
      drm/mediatek: Use correct aliases name for ovl

Eric Bernstein (2):
      drm/amd/display: Move common speakersToChannels definition to hw_shar=
ed.h
      drm/amd/display: Revert update clk_mgr for vg

Eric Yang (1):
      drm/amd/display: expose clk_mgr functions for reuse

Eryk Brol (3):
      drm/amd/display: Reverting "Add connector to the state if DSC
debugfs is set"
      drm/amd/display: Update connector on DSC property change
      drm/amd/display: Do full modeset when DSC debugfs is changed

Evan Quan (61):
      drm/amd/pm: setup APU dpm clock table in SMU HW initialization
      drm/amd/pm: increase mclk switch threshold to 200 us
      drm/amd/pm: populate the bootup LCLK frequency
      drm/amd/pm: populate Arcturus PCIE link state
      drm/amd/pm: correct gfx and pcie settings on umd pstate switching(V2)
      drm/amdgpu: add interface for setting ASPM
      drm/amdgpu: add interface for setting MGCG perfmon
      drm/amdgpu: fulfill Navi gfx and pcie settings on umd pstate switchin=
g(V2)
      drm/amd/pm: properly setting GPO feature on UMD pstate entering/exiti=
ng
      drm/amdgpu: correct the gpu reset handling for job !=3D NULL case
      drm/amd/pm: correct the checks for polaris kickers
      drm/amd/pm: populate smc vddc table
      drm/amd/pm: populate smc samu table
      drm/amd/pm: correct vddci table setup
      drm/amd/pm: correct sclk table setup
      drm/amd/pm: correct mclk table setup
      drm/amd/pm: correct the ACPI table setup V2
      drm/amd/pm: correct the BootLinkLevel setup
      drm/amd/pm: add pptable VRHotLevel setting
      drm/amd/pm: drop arb table first byte workaround
      drm/amdgpu: correct CG_ACLK_CNTL setting
      drm/amd/pm: add PWR_CKS_CNTL setting
      drm/amd/powerplay: separate Polaris fan table setup from Tonga
      drm/amd/pm: optimize AC timing programming
      drm/amd/pm: drop redundant efuse mask calculations
      drm/amd/pm: correct the settings for ro range minimum and maximum
      drm/amd/pm: correct polaris10 clock stretcher data table setting
      drm/amd/pm: setup zero rpm parameters for polaris10
      drm/amd/pm: add edc leakage controller setting
      drm/amd/pm: add mc register table initialization
      drm/amd/pm: correct VR shared rail info
      drm/amd/pm: correct the checks for sclk/mclk SS support
      drm/amd/pm: correct Polaris powertune table setup
      drm/amd/pm: correct Polaris DIDT configurations
      drm/amd/pm: correct avfs fuse settings
      drm/amd/pm: correct vddc phase control setting
      drm/amd/pm: correct VRconfig setting
      drm/amd/pm: correct platformcaps setup
      drm/amd/pm: correct smc voltage controller setup
      drm/amd/pm: correct sclk/mclk dpm enablement
      drm/amd/pm: correct the way to get the highest vddc
      drm/amd/pm: correct clk/voltage dependence setup
      drm/amd/pm: correct pcie spc cap setup
      drm/amd/pm: correct SMC sclk/mclk boot level setup
      drm/amd/pm: correct vddc_dep_on_dal_pwrl setup
      drm/amd/pm: fulfill the Polaris implementation for
get_clock_by_type_with_latency()
      drm/amd/pm: enable Polaris watermark table setting
      drm/amd/pm: correct the mclk switching setting
      drm/amd/pm: reconfigure smc on display vbitimeout setting change
      drm/amd/pm: drop redundant display setting
      drm/amd/display: correct asic type check V2
      drm/amdgpu: enable MULTI_MON_PP_MCLK_SWITCH DC feature at default
      drm/amdgpu: perform srbm soft reset always on SDMA resume
      drm/amd/pm: correct the baco reset sequence for CI ASICs
      drm/amd/pm: enable baco reset for Hawaii
      drm/amd/pm: perform SMC reset on suspend/hibernation
      drm/amd/pm: do not use ixFEATURE_STATUS for checking smc running
      drm/amd/pm: fix compile warning about missing prototype for function
      drm/amd/pm: fix compile warnings about variable used uninitialized
      drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for Polaris only
      drm/amd/pm: invalidate hdp before CPU access the memory written by GP=
U

Fabien Parent (3):
      dt-bindings: display: mediatek: disp: add documentation for MT8167 So=
C
      drm/mediatek: Add disp-color MT8167 support
      drm/mediatek: Add DDP support for MT8167

Felipe (1):
      drm/amd/display: Fixed comments (uniform style)

Felipe Clark (1):
      drm/amd/display: Fix max brightness pixel accuracy

Felix Kuehling (1):
      drm/amdkfd: Fix leak in dmabuf import

Flora Cui (2):
      drm/amdgpu: disable DCN and VCN for Navi14 0x7340/C9 SKU
      drm/amdgpu: rename nv_is_headless_sku()

Gang Ba (1):
      drm/amdgpu: Change the way to determine framebuffer type

Geert Uytterhoeven (3):
      drm/fb_helper: Use min_t() to handle size_t and unsigned long
      drm: DRM_KMB_DISPLAY should select DRM_MIPI_DSI
      drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY

George Shen (1):
      drm/amd/display: Removed unreferenced variables.

Gerd Hoffmann (6):
      virtio-gpu api: blob resources
      virtio-gpu api: host visible feature
      drm/virtio: implement blob resources: probe for the feature.
      drm/virtio: implement blob resources: probe for host visible region
      drm/virtio: implement blob resources: implement vram object
      drm/virtio: implement blob resources: resource create blob ioctl

Gowtham Tammana (1):
      drm/tidss: Add prepare_fb to the plane helper funcs

Guido G=C3=BCnther (4):
      drm/panel: mantix: Don't dereference NULL mode
      drm/panel: mantix: Fix panel reset
      dt-binding: display: Require two resets on mantix panel
      drm/etnaviv: Add lockdep annotations for context lock

Gurchetan Singh (13):
      drm/virtio: blob prep: refactor getting pages and attaching backing
      drm/virtio: blob prep: make CPU responses more generic
      drm/virtgpu api: blob resources
      drm/virtgpu api: host visible feature
      drm/virtgpu api: cross-device feature
      drm/virtio: implement blob resources: expose virtio_gpu_resource_id_g=
et
      drm/virtio: implement blob resources: add new fields to internal stru=
cts
      drm/virtio: implement blob resources: hypercall interface
      drm/virtio: implement blob resources: blob display integration
      drm/virtio: implement blob resources: refactor UUID code somewhat
      drm/virtio: implement blob resources: fix stride discrepancy
      drm/virtio: implement blob resources: report blob mem to userspace
      drm/virtio: advertise features to userspace

Gustavo A. R. Silva (19):
      drm/amd/pm: Replace one-element array with flexible-array member
      drm/amd/pm: Replace one-element array with flexible-array member
in struct vi_dpm_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_clock_array
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_uvd_clock_voltage_dependency_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_acp_clock_voltage_dependency_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_phase_shedding_limits_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_vce_clock_voltage_dependency_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_cac_leakage_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_samu_clock_voltage_dependency_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_ppt_v1_clock_voltage_dependency_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_ppt_v1_mm_clock_voltage_dependency_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_ppt_v1_voltage_lookup_table
      drm/amd/pm: Replace one-element array with flexible-array in
struct phm_ppt_v1_pcie_table
      drm/amdgpu: Use struct_size() helper in kmalloc()
      amd/amdgpu_ctx: Use struct_size() helper and kmalloc() (v2)
      drm/amdgpu: Fix fall-through warnings for Clang
      drm/radeon: Fix fall-through warnings for Clang
      drm/amd/display: Fix fall-through warnings for Clang
      drm/amd/pm: Fix fall-through warnings for Clang

Hanjun Guo (2):
      drm/amdkfd: Move the ignore_crat check before the CRAT table get
      drm/amdkfd: Put ACPI table after using it

Harish Kasiviswanathan (1):
      drm/amdgpu: During compute disable GFXOFF for Sienna_Cichlid

Hawking Zhang (9):
      drm/amdgpu: enable GDDR6 save-restore support for dimgrey_cavefish
      drm/amdgpu: add amdgpu_smuio structure
      drm/amdgpu: implement smuio v9_0 callbacks
      drm/amdgpu: implement smuio v11_0 callbacks
      drm/amdgpu: switch to use smuio callbacks for AI family
      drm/amdgpu: disable rom clock gating support for APUs
      drm/amdgpu: check hive pointer before access
      drm/amdgpu: declare smuio callback function as static
      drm/amdgpu: make gfxhub_v1_0 callback functions to be static

Huang Rui (38):
      drm/amdgpu: add vangogh asic header files (v2)
      drm/amdgpu: add van gogh asic_type enum (v2)
      drm/amdgpu: add uapi to define van gogh series
      drm/amdgpu: add van gogh support for gpu_info and ip block setting
      drm/amdgpu: add vangogh_reg_base_init function for van gogh
      drm/amdgpu: add nv common ip block support for van gogh
      drm/amdgpu: skip sdma1 in nv_allowed_read_registers list for van gogh=
 (v2)
      drm/amdgpu: add van gogh support for ih block
      drm/amdgpu: use gpu virtual address for interrupt packet write
space for vangogh
      drm/amdgpu: add uapi to define van gogh memory type
      drm/amdgpu: update new memory types in atomfirmware header
      drm/amdgpu: get the correct vram type for van gogh
      drm/amdgpu: add gmc v10 supports for van gogh (v4)
      drm/amdgpu: set fw load type for van gogh
      drm/amdgpu: add gfx support for van gogh (v3)
      drm/amdgpu: add gfx golden settings for vangogh (v3)
      drm/amdgpu: add sdma support for van gogh
      drm/amdgpu: set ip blocks for van gogh
      drm/amdkfd: add Van Gogh KFD support
      drm/amdgpu: add mmhub v2.3 for vangogh (v4)
      drm/amdgpu: add pcie port indirect read and write on nv
      drm/amdgpu: add nbio v7.2 for vangogh (v2)
      drm/amd/powerplay: partially enable swsmu for vangogh
      drm/amd/powerplay: add vangogh ppt into swSMU
      drm/amdgpu: add smu ip block for vangogh
      drm/amdgpu: add TOC firmware definition
      drm/amdgpu: add TOC firmware support for apu (v3)
      drm/amdgpu: enable psp support for vangogh
      drm/amdgpu: disable gfxoff on vangogh for the moment (v2)
      drm/amdgpu: add gfx power gating for gfx10
      drm/amdgpu: enable gfx clock gating and power gating for vangogh
      drm/amdgpu: add van gogh pci id
      drm/amdgpu: fix the issue that apu has no smu firmware binary
      drm/amdgpu: disable gpa mode for direct loading
      drm/amdgpu/display: fix the NULL pointer reference on dmucb on dcn301
      drm/amdgpu/display: enable display ip block for vangogh
      drm/amdgpu: add vangogh apu flag
      drm/amd/display: fix the NULL pointer that missed
set_disp_pattern_generator callback

Hugo Hu (1):
      drm/amd/display: correct eDP T9 delay

Imre Deak (13):
      drm/i915/skl: Work around incorrect BIOS WRPLL PDIV programming
      drm/i915: Move the initial fastset commit check to encoder hooks
      drm/i915: Check for unsupported DP link rates during initial commit
      drm/i915: Add an encoder hook to sanitize its state during init/resum=
e
      drm/i915/tgl: Fix Combo PHY DPLL fractional divider for 38.4MHz ref c=
lock
      drm/i915: Fix DP link training pattern mask
      drm/i915: Simplify the link training functions
      drm/i915: Factor out a helper to disable the DPCD training pattern
      drm/dp: Add LTTPR helpers
      drm/i915: Switch to LTTPR transparent mode link training
      drm/i915: Switch to LTTPR non-transparent mode link training
      drm/i915: Fix encoder lookup during PSR atomic check
      drm/i915/tgl: Fix typo during output setup

Isabel Zhang (4):
      drm/amd/display: Revert check for flip pending before locking pipes
      drm/amd/display: Force prefetch mode to 0
      drm/amd/display: Add fallback to prefetch mode 1 if 0 fails
      drm/amd/display: Prevent freesync power optimization during validatio=
n

Iskren Chernev (1):
      drm/msm: Fix use-after-free in msm_gem with carveout

Jacky Liao (8):
      drm/amd/display: Add MPC memory shutdown support for DCN3
      drm/amd/display: Add OPTC memory low power support
      drm/amd/display: Add I2C memory low power support
      drm/amd/display: Add DMCU memory low power support
      drm/amd/display: Add BLNDGAM memory shutdown support
      drm/amd/display: Add GAMCOR memory shutdown support
      drm/amd/display: Add HDR3DLUT and SHAPER memory shutdown support
      drm/amd/display: Add DSCL memory low power support

Jagan Teki (3):
      dt-bindings: vendor-prefixes: Add Yes Optoelectronics
      dt-bindings: display: simple: Add YTC700TLAG-05-201C
      drm/panel: simple: Add YTC700TLAG-05-201C

Jake Wang (1):
      drm/amd/display: set hdcp1 wa re-auth delay to 200ms

James Zhu (12):
      drm/amdgpu/vcn: add firmware support for dimgrey_cavefish
      drm/amdgpu/vcn: enable VCN DPG mode for dimgrey_cavefish
      drm/amdgpu: enable VCN3.0 PG and CG for dimgrey_cavefish
      drm/amdgpu: enable jpeg3.0 PG and CG for dimgrey_cavefish
      drm/amdgpu: enable vcn3.0 for dimgrey_cavefish
      drm/amdgpu: enable jpeg3.0 for dimgrey_cavefish
      drm/amdgpu/vcn: refactor dec message functions
      drm/amdgpu/vcn: update header to support dec software ring
      drm/amdgpu/vcn: add test for dec software ring
      drm/amdgpu/vcn3.0: add dec software ring vm functions to support
      drm/amdgpu/vcn3.0: add software ring share memory support
      drm/amdgpu/vcn3.0: fix compilation warning

Jane Jian (1):
      drm/amdgpu/sriov: reopen sienna_child smu ip block under sriov

Jani Nikula (7):
      drm/i915/uc: tune down GuC communication enabled/disabled messages
      drm/dp: add subheadings to DPCD address definitions
      drm/dp: add a number of DP 2.0 DPCD definitions
      drm/i915: Update DRIVER_DATE to 20201103
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915/display: return earlier from intel_modeset_init() without di=
splay
      Merge tag 'gvt-next-2020-11-23' of
https://github.com/intel/gvt-linux into drm-intel-next-queued

Jason Gunthorpe (2):
      drm: Remove SCATTERLIST_MAX_SEGMENT
      drm: remove pgprot_decrypted() before calls to io_remap_pfn_range()

Jason Yan (6):
      drm/panel: samsung: make vint_table static const
      drm/bridge: analogix_dp: make analogix_dp_start_aux_transaction() sta=
tic
      drm: bridge: adv7511: make adv7511_hdmi_hw_params() static
      drm/panel: st7703: Make jh057n00900_panel_desc static
      video: fbdev: sis: remove unneeded semicolon
      video: fbdev: fsl-diu-fb: remove unneeded variable 'res'

Jay Cornwall (1):
      drm/amdkfd: Use same SQ prefetch setting as amdgpu

Jiansong Chen (5):
      Revert "drm/amdgpu: disable gfxoff temporarily for navy_flounder"
      drm/amd/pm: drop navy_flounder hardcode of using soft pptable
      drm/amdgpu: disable gfxoff if VCN is busy
      drm/amdgpu: update GC golden setting for navy_flounder
      drm/amd/pm: update driver if version for navy_flounder

Jianxin Xiong (3):
      dma-buf: Clarify that dma-buf sg lists are page aligned
      dma-buf: Fix static checker warning
      dma-buf: Document that dma-buf size is fixed

Jing Zhou (2):
      drm/amd/display: force use sRGB for video TF is sRGB or BT709
      drm/amd/display: Set default bits per channel

Jingwen Chen (1):
      drm/amdgpu: skip power profile switch in sriov

Jinzhou Su (2):
      drm/amdgpu: Add gfx doorbell setting for Vangogh
      drm/amdgpu: Set doorbell range for gfx ring

Jinzhou.Su (6):
      amdgpu: Add GFX MGCG and MGLS for vangogh
      amdgpu:Add flag for updating MGCG on GFX10
      amdgpu: Add mmhub MGCG and MGLS for vangogh
      drm/amdgpu: Add GFX Fine Grain Clock Gating flag
      drm/amdgpu: Add Fine Grain Clock Gating for GFX10
      drm/amdgpu: Enable FGCG for Vangogh

Jitao Shi (1):
      dt-bindings: display: mediatek: convert the dpi bindings to yaml

Joe Perches (1):
      MAINTAINERS: Update AMD POWERPLAY pattern

Joel Stanley (1):
      drm/aspeed: Add sysfs for output settings

John Clements (4):
      Revert drm/amdgpu: disable sienna chichlid UMC RAS
      drm/amdgpu: added support for psp fw attestation
      drm/amdgpu: resolved ASD loading issue on sienna
      drm/amdgpu: add UMC to ip discovery map

John Harrison (3):
      drm/i915/guc: Update to use firmware v49.0.1
      drm/i915/guc: Improved reporting when GuC fails to load
      drm/i915/guc: Clear pointers on free

John Wu (1):
      drm/amd/display: Don't check seamless boot in power down HW by timeou=
t

Jonathan Kim (3):
      drm/amdgpu: fix xgmi perfmon a-b-a problem
      drm/amdgpu: add per device user friendly xgmi events for vega20
      drm/amdgpu: add xgmi perfmons for arcturus

Jordan Crouse (1):
      drm/msm/a6xx: Add support for using system cache on MMU500 based targ=
ets

Joshua Aberback (6):
      drm/amd/display: Force enable pstate on driver unload
      drm/amd/display: Copy WM values from set A to other sets in hw_init
      drm/amd/display: Blank HUBP during pixel data blank for DCN30
      drm/amd/display: Blank HUBP during pixel data blank for DCN30 v2
      drm/amd/display: Revert HUBP blank behaviour for now
      drm/amd/display: Check link_active instead of lane_settings !=3D unkn=
own

Jos=C3=A9 Roberto de Souza (14):
      drm/i915/display/ehl: Limit eDP to HBR2
      drm/i915/vbt: Fix backlight parsing for VBT 234+
      drm/i915/vbt: Update the version and expected size of
BDB_GENERAL_DEFINITIONS map
      drm/i915/vbt: Add VRR VBT toggle
      drm/i915/display: Ignore IGNORE_PSR2_HW_TRACKING for platforms
without sel fetch
      drm/i915/display: Check PSR parameter and flag only in state compute =
phase
      drm/i915/display: Program PSR2 selective fetch registers
      drm/i915/display: Program DBUF_CTL tracker state service
      drm/i915/display/fbc: Implement WA 22010751166
      drm/i915/tgl/psr: Fix glitches when doing frontbuffer modifications
      drm/i915/display: Use initial_fastset_check() to compute and
apply the initial PSR state
      drm/i915/display: Do not reset display when there is none
      drm/i915/display: Group DC9 mask set
      drm/i915/display: Make get_allowed_dc_mask().max_dc set a chain
of if and elses

Judy Cai (1):
      drm/amd/display: Change to IMMEDIATE mode from FRAME mode

Julian Stecklina (1):
      drm/i915/gvt: treat intel_gvt_mpt as const in gvt code

Jyri Sarha (2):
      drm/tilcdc: Do not keep vblank interrupts enabled all the time
      drm/tilcdc: Remove tilcdc_crtc_max_width(), use private data

Kai-Heng Feng (1):
      drm/i915: Init lspcon after HPD in intel_dp_detect()

Kalyan Thota (1):
      drm/msm/dpu: consider vertical front porch in the prefill bw calculat=
ion

Karthik B S (8):
      drm/i915: Add enable/disable flip done and flip done handler
      drm/i915: Add support for async flips in I915
      drm/i915: Add checks specific to async flips
      drm/i915: Do not call drm_crtc_arm_vblank_event in async flips
      drm/i915: Add dedicated plane hook for async flip case
      drm/i915: WA for platforms with double buffered address update enable=
 bit
      Documentation/gpu: Add asynchronous flip documentation for i915
      drm/i915: Enable async flips in i915

Kenneth Feng (6):
      drm/amd/pm: fix the wrong fan speed in fan1_input
      drm/amd/pm: fix pp_dpm_fclk
      drm/amd/pm: remove the average clock value in sysfs
      drm/amd/amdgpu: switch on/off vcn power profile mode
      drm/amd/amdgpu: fix null pointer in runtime pm
      drm/amd/amdgpu: skip unload message in reset

Kent Russell (4):
      drm/amdkfd: Use kvfree in destroy_crat_image
      drm/amdkfd: Fix getting unique_id in topology
      amdkfd: Check kvmalloc return before memcpy
      drm/amdgpu: Fix Arcturus fan speed reporting

Kevin Wang (8):
      drm/amdgpu: remove gfxhub_v1_1_funcs set
      drm/amd/swsmu: add missing feature map for sienna_cichlid
      drm/amd/swsmu: correct wrong feature bit mapping
      drm/amdgpu: update module paramter doc of amdgpu_dpm
      drm/amdgpu: cleanup debug log in amdgpu_set_pp_features()
      drm/amdgpu: add missing clock gating info in amdgpu_pm_info
      drm/amdgpu: change trace event parameter name from 'direct' to 'immed=
iate'
      drm/amdgpu/pm: add smc v2_1 printer in amdgpu_ucode_print_smc_hdr()

Koba Ko (2):
      drm/dp_mst: Retrieve extended DPCD caps for topology manager
      Revert "drm/dp_mst: Retrieve extended DPCD caps for topology manager"

Krishna Manikandan (1):
      drm/msm: Fix race condition in msm driver with async layer updates

Krunoslav Kovac (1):
      drm/amd/display: Engage PSR synchronously

Krzysztof Kozlowski (2):
      drm/mcde: Fix handling of platform_get_irq() error
      drm/tve200: Fix handling of platform_get_irq() error

KuoHsiang Chou (3):
      drm/ast: Support 1600x900 with 108MHz PCLK
      drm/ast: Fixed 1920x1080 sync. polarity issue
      drm/ast: Create chip AST2600

Kuogee Hsieh (7):
      drm/msm/dp: add opp_table corner voting support base on dp_ink_clk ra=
te
      drm/msm/dp: return correct connection status after suspend
      drm/msm/dp: fixes wrong connection state caused by failure of link tr=
ain
      drm/msm/dp: deinitialize mainlink if link training failed
      drm/msm/dp: skip checking LINK_STATUS_UPDATED bit
      drm/msm/dp: promote irq_hpd handle to handle link training correctly
      drm/msm/dp: fix connect/disconnect handled at irq_hpd

Lee Jones (291):
      gpu/host1x: bus: Add missing description for 'driver'
      drm/panel: panel-simple: Fix 'struct panel_desc's header
      drm/panel: panel-ilitek-ili9322: Demote non-conformant kernel-doc hea=
der
      gpu: drm: bridge: analogix: analogix_dp_reg: Remove unused
function 'analogix_dp_write_byte_to_dpcd'
      drm/r128/ati_pcigart: Source file headers are not good
candidates for kernel-doc
      drm/mga/mga_dma: Demote kernel-doc abusers to standard comment blocks
      drm/mga/mga_state: Remove unused variable 'buf_priv'
      drm/omap: gem: Fix misnamed and missing parameter descriptions
      drm/omap: dmm_tiler: Demote abusive use of kernel-doc format
      drm/omap: omap_irq: Fix a couple of doc-rot issues
      drm/omap: dsi: Rework and remove a few unused variables
      drm/amd/amdgpu/amdgpu_device: Provide documentation for 'reg_addr' pa=
rams
      drm/amd/display/dc/basics/fixpt31_32: Move variables to where they're=
 used
      drm/amd/amdgpu/amdgpu_kms: Remove 'struct drm_amdgpu_info_device
dev_info' from the stack
      drm/atmel-hlcdc/atmel_hlcdc_crtc: Apply correct formatting to struct =
docs
      drm/atmel-hlcdc/atmel_hlcdc_plane: Staticise local function
'atmel_hlcdc_plane_setup_scaler()'
      drm/atmel-hlcdc/atmel_hlcdc_plane: Fix documentation formatting
and add missing description
      drm/savage/savage_bci: Remove set but never used 'aper_rsrc' and 'fb_=
rsrc'
      include: drm: drm_atomic: Artificially use 'crtc' to avoid 'not
used' warning
      drm/sti/sti_hdmi: Move 'colorspace_mode_names' array to where its use=
d
      drm/via/via_dma: Remove set but unused variable 'agp_base'
      gpu: drm: scheduler: sched_main: Provide missing description for
'sched' paramter
      gpu: drm: scheduler: sched_entity: Demote non-conformant
kernel-doc headers
      gpu: drm: radeon: radeon_drv: Remove unused variable 'ret'
      gpu: drm: amd: amdgpu: amdgpu: Mark global variables as __maybe_unuse=
d
      gpu: drm: radeon: radeon_device: Fix a bunch of kernel-doc misdemeano=
urs
      drm/radeon/radeon_kms: Include header containing our own prototypes
      drm/radeon/radeon_drv: Source file headers are not good
candidates for kernel-doc
      drm/radeon/radeon_drv: Move prototypes to a shared headerfile
      drm/radeon: Move prototypes to shared header
      drm/radeon/atombios_crtc: Remove description of non-existent
function param 'encoder'
      drm/radeon/radeon_ttm: Place declaration of 'rdev' in same
clause as its use
      drm/radeon/radeon_fence: Demote some non-conformant kernel-doc
headers and fix another
      drm/radeon/radeon_connectors: Strip out set but unused variable 'ret'
      drm/radeon/radeon_display: Remove unused variable 'mod'
      drm/radeon/radeon_i2c: Remove pointless function header
      drm/radeon/radeon_ring: Add missing function parameters 'rdev' and 'd=
ata'
      drm/radeon/r600: Strip out set but unused 'tmp' variables
      drm/radeon/radeon_cs: Fix a bunch of doc-rot issues
      drm/radeon/radeon_display: Fix function doc formatting and
missing param issues
      drm/radeon/r600: Fix a misnamed parameter description and a
formatting issue
      drm/radeon/cik: Fix a bunch of function parameter descriptions
      drm/radeon/evergreen: Remove set but unused variable 'mc_shared_chmap=
'
      drm/radeon/evergreen: Add comment for 'evergreen_page_flip()'s
'async' param
      drm/radeon/si: Remove set but unused variable 'mc_shared_chmap'
      drm/radeon/ni: Demote vague attempt at function header doc
      drm/radeon/cik: Remove set but unused variable 'mc_shared_chmap'
      drm/radeon/radeon_vm: Fix some function parameter documentation
      drm/radeon/kv_dpm: Strip out unused functions and their tables
      drm/radeon/trinity_dpm: Remove some defined but never used arrays
      drm/radeon/radeon_dp_mst: Remove unused variable 'ret' from
radeon_mst_encoder_dpms()
      drm/radeon/radeon_sync: Add description for function param 'rdev'
      drm/radeon/radeon_ib: Supply description for 'radeon_ib_get's get par=
am
      drm/radeon/ci_dpm: Remove set but unused variable 'dpm_event_src'
      drm/radeon/radeon_mn: Supply description for 'cur_seq' even if
it is unused
      drm/radeon/r100: Fix some kernel-doc formatting, misnaming and
missing issues
      drm/radeon/r600_cs: Fix some doc-rot and supply missing function
param docs
      drm/radeon/cik_sdma: Demote vague attempt at kernel-doc
      drm/radeon/evergreen_cs: Fix misnaming issues surrounding 'p' param
      drm/radeon/evergreen_dma: Fix doc-rot of function parameter 'resv'
      drm/radeon/ni: Remove set but unused variable 'mc_shared_chmap'
      drm/radeon/sumo_dpm: Move 'sumo_get_pi()'s prototype into shared head=
er
      drm/amd/amdgpu/amdgpu_kms: Fix misnaming of parameter 'dev'
      drm/amd/amdgpu/amdgpu_fence: Fix some issues pertaining to
function documentation
      drm/amd/amdgpu/amdgpu_ttm: Demote non-conformant kernel-doc
headers, fix slightly lacking ones
      drm/amd/amdgpu/amdgpu_ring: Fix a bunch of function misdocumentation
      drm/amd/amdgpu/amdgpu_display: Remove pointless header
      drm/amd/amdgpu/amdgpu_cs: Add a couple of missing function param
descriptions
      drm/amd/include/vega10_ip_offset: Mark _BASE structs as __maybe_unuse=
d
      drm/amd/display/dc/core/dc_link_dp: Move
DP_VGA_LVDS_CONVERTER_ID_{2, 3} to where they're used
      drm/amd/display/dc/core/dc_link_ddc: Move
DP_DVI_CONVERTER_ID_{4, 5} to where they're used
      drm/amd/amdgpu/amdgpu_ring: Fix misnaming of param 'max_dw'
      drm/amd/amdgpu/amdgpu_ib: Fix some incorrect/incomplete function
documentation
      drm/amd/amdgpu/amdgpu_pll: Fix kernel-doc formatting, missing
and extra params
      drm/amd/amdgpu/amdgpu_sync: Fix misnamed, missing and extra
param descriptions
      drm/amd/amdgpu/amdgpu_vram_mgr: Add missing descriptions for
'dev' and 'dir'
      drm/amd/amdgpu/amdgpu_virt: Make local function
'amdgpu_virt_update_vf2pf_work_item()' static
      drm/amd/amdgpu/amdgpu_csa: Remove set but unused variable 'r'
      drm/amd/amdgpu/amdgpu_sched: Consume our own header containing protot=
ypes
      drm/amd/amdgpu/amdgpu_ids: Supply missing docs for 'id' and 'vmhub'
      drm/amd/amdgpu/amdgpu_debugfs: Demote obvious abuse of
kernel-doc formatting
      drm/amd/amdgpu/amdgpu_gmc: Demote one and fix another function header
      drm/amd/amdgpu/amdgpu_ras: Remove unused function 'amdgpu_ras_error_c=
ure'
      drm/amd/amdgpu/amdgpu_ras: Make local function
'amdgpu_ras_error_status_query' static
      drm/amd/amdgpu/amdgpu_vm_cpu: Fix 'amdgpu_vm_cpu_prepare()'s doc-rot
      drm/amd/amdgpu/amdgpu_vm_sdma: Fix 'amdgpu_vm_sdma_prepare()'s doc-ro=
t
      drm/amd/amdgpu/amdgpu_fw_attestation: Consume our own header
containing prototypes
      drm/amd/amdgpu/smu_v11_0_i2c: Provide descriptions for 'control'
and 'data' params
      drm/amd/amdgpu/gfx_v7_0: Remove unused struct definition
      drm/panel/panel-tpo-tpg110: Correct misnaming and supply missing
param description
      drm/lima/lima_drv: Demote kernel-doc formatting abuse
      drm/lima/lima_sched: Remove unused and unnecessary variable 'ret'
      drm/radeon/atombios_encoders: Move
'radeon_atom_get_tv_timings()'s prototype into shared location
      drm/radeon/radeon: Move prototype into shared header
      drm/radeon/radeon_kms: Move 'radeon_*_kms' prototypes to shared heade=
r
      drm/radeon/radeon_kms: Fix misnaming of 'radeon_info_ioctl's dev para=
m
      drm/radeon: Move radeon_ttm{init, fini} to shared location
      drm/radeon/radeon_legacy_encoders: Move
'radeon_add_legacy_encoder' prototype to shared header
      drm/radeon/radeon_legacy_encoders: Move
'radeon_add_legacy_encoder's prototype to shared location
      drm/radeon/radeon_irq_kms: Demote non-conformant kernel-doc fix anoth=
er
      drm/radeon/rv770: Move 'rv770_set_clk_bypass_mode' prototype to
shared location
      drm/radeon/radeon_pm: Move 'radeon_pm_acpi_event_handler'
prototype into shared header
      drm/radeon/radeon_audio: Move 'dce3_2_*' prototypes to shared locatio=
n
      drm/radeon/evergreen: Move 'evergreen_*' and 'sumo_*' prototypes
out to shared location
      drm/radeon/radeon_drv: Move 'radeon_mmap()'s prototype to shared head=
er
      drm/radeon/radeon_drv: Move 'radeon_driver_irq_handler_kms's
prototype into shared header
      drm/radeon/atom: Move 'radeon_atom_hw_i2c_*()'s prototypes into
shared header
      drm/radeon/radeon_gem: Move 'radeon_gem_prime_*()'s prototypes
to shared header
      drm/radeon/evergreen_hdmi: Move 'evergreen_*()' and 'dce4_*()'
HDMI prototypes to shared header
      drm/radeon/rv770: Move 'rv770_get_*()'s prototypes to shared header
      drm/radeon/ni_dpm: Move 'ni_get_{pi, ps}()'s into shared header
      drm/radeon/evergreen: Move 'cayman_*()'s prototypes to shared header
      drm/radeon/r600_dma: Move 'r600_gpu_check_soft_reset()'s
prototype to shared location
      drm/radeon/cik: Move 'r600_ih_ring_{alloc, fini}()'s prototypes
to shared header
      drm/radeon/evergreen_dma: Move
'evergreen_gpu_check_soft_reset()'s prototype to shared header
      drm/radeon/r600: Move 'evergreen_rlc_resume()'s prototype to shared h=
eader
      drm/radeon/ni_dma: Move 'cayman_gpu_check_soft_reset()'s
prototype to shared header
      drm/radeon/radeon_atombios: Move 'radeon_add_atom_encoder()'s
prototype to shared header
      drm/radeon/radeon_encoders: Move 'radeon_atom_backlight_init's
prototype to shared header
      drm/radeon/ci_dpm: Move 'ci_*()'s prototypes to shared header
      drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s prototype to
shared header
      drm/radeon/si_dma: Move 'si_gpu_check_soft_reset()'s prototype
to shared header
      drm/radeon/cik: Move 'si_*()'s prototypes to shared header
      drm/radeon/btc_dpm: Move 'evergreen_get_pi's prototype to shared head=
er
      drm/radeon/radeon_audio: Move 'dce6_*()'s prototypes to shared header
      drm/radeon/evergreen: Move 'si_get_csb_*()'s prototypes to shared hea=
der
      drm/radeon/cik_sdma: Move 'amdgpu_cik_gpu_check_soft_reset()'s
prototype to shared header
      drm/radeon/evergreen: Move 'cik_*()'s prototypes to shared header
      drm/radeon/ci_dpm: Move 'si_*()'s prototypes to shared header
      drm/radeon/cik: Move 'Move 'cik_sdma_*()'s prototypes to shared heade=
r
      drm/radeon/si_dpm: Move 'vce_v1_0_enable_mgcg()'s prototype to
shared header
      drm/radeon/cik: Move 'vce_v2_0_enable_mgcg()'s prototype to shared he=
ader
      drm/radeon/evergreen_cs: Move 'r600_dma_cs_next_reloc()'s
prototype to shared header
      drm/radeon/radeon_audio: Move 'r600_*' prototypes into shared header
      drm/radeon/radeon_drv: Move
'radeon_gem_prime_import_sg_table()'s prototype to shared header
      drm/amd/amdgpu/atombios_encoders: Remove set but unused variable
'backlight_level'
      drm/armada/armada_overlay: Staticify local function
'armada_overlay_duplicate_state'
      drm/drm_dp_mst_topology: Remove set but never used variable 'len'
      drm/exynos/exynos7_drm_decon: Supply missing description for param 'c=
tx'
      drm/exynos/exynos_drm_fimd: Add missing description for param 'ctx'
      drm/exynos/exynos_drm_gsc: Supply missing description for 'num_limits=
'
      drm/mediatek/mtk_dpi: Remove unused struct definition
'mtk_dpi_encoder_funcs'
      drm/mediatek/mtk_disp_color: Fix formatting and provide missing
member description
      drm/mediatek/mtk_disp_ovl: Fix formatting and provide missing
member description
      drm/mediatek/mtk_disp_rdma: Fix formatting and supply missing
struct member description
      drm/mediatek/mtk_drm_crtc: Demote seriously out-of-date struct header
      drm/mediatek/mtk_drm_drv: Staticise local function invoked by referen=
ce
      drm/meson/meson_venc: Make local function
'meson_venc_hdmi_get_dmt_vmode' static
      drm/meson/meson_vclk: Make two local functions static
      drm/nouveau/nvkm/core/firmware: Fix formatting, provide missing
param description
      drm/pl111/pl111_display: Make local function static
      drm/pl111/pl111_debugfs: Make local function 'pl111_debugfs_regs()' s=
tatic
      drm/rockchip/dw-mipi-dsi-rockchip: Demote non-conformant
kernel-doc headers
      drm/rockchip/rockchip_rgb: Consume our own header
      drm/rockchip/rockchip_lvds: Fix struct document formatting
      drm/selftests/test-drm_mm: Mark 'hole_end' as always_unused
      drm/selftests/test-drm_framebuffer: Remove set but unused variable 'f=
b'
      drm/selftests/test-drm_dp_mst_helper: Place 'struct
drm_dp_sideband_msg_req_body' onto the heap
      drm/selftests/test-drm_dp_mst_helper: Move
'sideband_msg_req_encode_decode' onto the heap
      drm/ttm/ttm_bo: Fix one function header - demote lots of kernel-doc a=
buses
      drm/ttm/ttm_range_manager: Demote non-conformant kernel-doc header
      drm/ttm/ttm_tt: Demote kernel-doc header format abuses
      drm/v3d/v3d_drv: Remove unused static variable 'v3d_v3d_pm_ops'
      drm/v3d/v3d_gem: Provide descriptions for 'v3d_lookup_bos's params
      drm/v3d/v3d_sched: Demote non-conformant kernel-doc header
      drm/vc4/vc4_hdmi_regs: Mark some data sets as __maybe_unused
      drm/vc4/vc4_hdmi: Remove set but unused variable 'ret'
      drm/vc4/vc4_v3d: Demote non-conformant kernel-doc headers
      drm/vc4/vc4_debugfs: Demote non-conformant kernel-doc headers
      include/drm/drm_atomic: Make use of 'new_crtc_state'
      drm/mediatek/mtk_disp_rdma: Fix formatting and supply missing
struct member description
      drm/mediatek/mtk_drm_drv: Staticise local function invoked by referen=
ce
      drm/mediatek/mtk_disp_color: Fix formatting and provide missing
member description
      drm/mediatek/mtk_disp_ovl: Fix formatting and provide missing
member description
      drm/msm/adreno/a6xx_gpu: Staticise local function 'a6xx_idle'
      drm/msm/disp/mdp5/mdp5_crtc: Make local function
'mdp5_crtc_setup_pipeline()' static
      drm/msm/disp/mdp5/mdp5_kms: Make local functions 'mdp5_{en,
dis}able()' static
      drm/msm/disp/dpu1/dpu_core_perf: Remove set but unused variable
'dpu_cstate'
      drm/msm/disp/dpu1/dpu_encoder: Remove a bunch of unused variables
      drm/radeon/radeon_device: Consume our own header where the
prototypes are located
      drm/amd/amdgpu/amdgpu_ttm: Add description for 'page_flags'
      drm/amd/amdgpu/amdgpu_ib: Provide docs for
'amdgpu_ib_schedule()'s 'job' param
      drm/amd/amdgpu/cik_ih: Supply description for 'ih' in
'cik_ih_{get, set}_wptr()'
      drm/amd/amdgpu/amdgpu_virt: Correct possible copy/paste or
doc-rot misnaming issue
      drm/amd/amdgpu/uvd_v4_2: Fix some kernel-doc misdemeanours
      drm/amd/amdgpu/dce_v8_0: Supply description for 'async'
      drm/amd/amdgpu/cik_sdma: Supply some missing function param descripti=
ons
      drm/amd/amdgpu/gfx_v7_0: Clean-up a bunch of kernel-doc related issue=
s
      drm/amd/amdgpu/si_dma: Fix a bunch of function documentation issues
      drm/amd/amdgpu/gfx_v6_0: Supply description for
'gfx_v6_0_ring_test_ib()'s 'timeout' param
      drm/amd/amdgpu/uvd_v3_1: Fix-up some documentation issues
      drm/amd/amdgpu/dce_v6_0: Fix formatting and missing parameter
description issues
      drm/amd/include/vega20_ip_offset: Mark top-level IP_BASE
definition as __maybe_unused
      drm/amd/include/navi10_ip_offset: Mark top-level IP_BASE as __maybe_u=
nused
      drm/amd/include/arct_ip_offset: Mark top-level IP_BASE
definition as __maybe_unused
      drm/amd/include/navi14_ip_offset: Mark top-level IP_BASE as __maybe_u=
nused
      drm/amd/include/navi12_ip_offset: Mark top-level IP_BASE as __maybe_u=
nused
      drm/amd/include/sienna_cichlid_ip_offset: Mark top-level IP_BASE
as __maybe_unused
      drm/amd/include/vangogh_ip_offset: Mark top-level IP_BASE as
__maybe_unused
      drm/amd/include/dimgrey_cavefish_ip_offset: Mark top-level
IP_BASE as __maybe_unused
      drm/amd/amdgpu/cik_sdma: Add one and remove another function
param description
      drm/amd/amdgpu/uvd_v4_2: Add one and remove another function
param description
      drm/amd/amdgpu/gmc_v7_0: Add some missing kernel-doc descriptions
      drm/amd/amdgpu/gmc_v8_0: Fix more issues attributed to copy/paste
      drm/amd/amdgpu/gmc_v9_0: Remove unused table 'ecc_umc_mcumc_status_ad=
drs'
      drm/amd/amdgpu/gmc_v9_0: Suppy some missing function doc descriptions
      drm/msm/disp/dpu1/dpu_core_perf: Fix kernel-doc formatting issues
      drm/msm/disp/dpu1/dpu_hw_blk: Add one missing and remove an
extra param description
      drm/msm/disp/dpu1/dpu_formats: Demote non-conformant kernel-doc heade=
r
      drm/msm/disp/dpu1/dpu_hw_catalog: Remove duplicated
initialisation of 'max_linewidth'
      drm/msm/disp/dpu1/dpu_hw_catalog: Move definitions to the only
place they are used
      drm/msm/disp/dpu1/dpu_encoder: Fix a few parameter/member
formatting issues
      drm/msm/disp/dpu1/dpu_hw_lm: Fix misnaming of parameter 'ctx'
      drm/msm/disp/dpu1/dpu_hw_sspp: Fix kernel-doc formatting abuse
      drm/msm/disp/dpu1/dpu_rm: Fix formatting issues and supply
'global_state' description
      drm/msm/disp/dpu1/dpu_vbif: Fix a couple of function param descriptio=
ns
      drm/msm/disp/dpu1/dpu_plane: Fix some spelling and missing
function param descriptions
      drm/msm/msm_drv: Make '_msm_ioremap()' static
      drm/msm/msm_gem_shrinker: Fix descriptions for 'drm_device'
      drm/msm/adreno/a6xx_gpu_state: Make some local functions static
      drm/msm/dp/dp_ctrl: Move 'tu' from the stack to the heap
      drm/amd/amdgpu/gmc_v10_0: Suppy some missing function doc description=
s
      drm/amd/amdgpu/iceland_ih: Add missing function param
descriptions for 'ih' and 'entry'
      drm/amd/amdgpu/tonga_ih: Provide some missing descriptions for
'ih' and 'entry'
      drm/amd/amdgpu/amdgpu_psp: Make local function
'parse_ta_bin_descriptor' static
      drm/amd/amdgpu/cz_ih: Add missing function param descriptions
for 'ih' and 'entry'
      drm/amd/amdgpu/vega10_ih: Add descriptions for 'ih' and 'entry'
      drm/amd/amdgpu/navi10_ih: Add descriptions for 'ih' and 'entry'
      drm/amd/amdgpu/psp_v11_0: Make local function
'psp_v11_0_wait_for_bootloader()' static
      drm/amd/amdgpu/dce_v10_0: Supply description for function param 'asyn=
c'
      drm/amd/amdgpu/dce_v11_0: Supply description for function param 'asyn=
c'
      drm/amd/amdgpu/gfx_v9_0: Make called-by-reference only function stati=
c
      drm/amd/amdgpu/gfx_v8_0: Functions must follow directly after
their headers
      drm/amd/amdgpu/gfx_v10_0: Remove a bunch of set but unused variables
      drm/amd/amdgpu/sdma_v2_4: Fix a bunch of kernel-doc function
documentation issues
      drm/amd/amdgpu/sdma_v3_0: Fix a bunch of kernel-doc function
documentation issues
      drm/amd/amdgpu/sdma_v3_0: Fix incorrect param doc-rot issue
      drm/amd/amdgpu/uvd_v5_0: Fix a bunch of kernel-doc function
documentation issues
      drm/amd/amdgpu/sdma_v4_0: Repair a bunch of kernel-doc problems
      drm/amd/amdgpu/amdgpu_uvd: Fix some function documentation headers
      drm/amd/amdgpu/sdma_v5_2: Provide some missing and repair other
function params
      drm/amd/amdgpu/amdgpu_vce: Provide some missing and repair other
function params
      drm/amd/amdgpu/uvd_v6_0: Fix a bunch of kernel-doc function
documentation issues
      drm/amd/amdgpu/uvd_v7_0: Fix a bunch of kernel-doc function
documentation issues
      drm/amd/amdgpu/gfx_v10_0: Make local function
'gfx_v10_0_rlc_stop()' static
      drm/amd/amdgpu/vcn_v1_0: Fix a few kernel-doc misdemeanours
      drm/amd/amdgpu/jpeg_v1_0: Add some missing function param description=
s
      drm/amd/amdgpu/jpeg_v2_0: Add some missing kernel-doc descriptions
      drm/amd/amdgpu/vcn_v2_0: Fix a few kernel-doc misdemeanours
      drm/amd/amdgpu/sdma_v5_0: Provide some missing and repair other
function params
      drm/amd/amdgpu/vcn_v3_0: Remove unused variable 'direct_poll'
from 'vcn_v3_0_start_sriov()'
      drm/amd/amdgpu/amdgpu_acp: Fix doc-rot issues pertaining to a
couple of 'handle' params
      drm/amd/pm/inc/smu_v11_0: Mark 'smu11_thermal_policy' as __maybe_unus=
ed
      drm/amd/pm/swsmu/smu12/renoir_ppt: Demote kernel-doc formatting abuse
      drm/amd/pm/swsmu/smu11/navi10_ppt: Remove unused 'struct
i2c_algorithm navi10_i2c_algo'
      drm/amd/pm/powerplay/smumgr/fiji_smumgr: Remove unused variable 'resu=
lt'
      drm/amd/amdgpu/amdgpu_uvd: Add description for
amdgpu_uvd_cs_msg_decode()'s 'buf_sizes' param
      drm/amd/pm/powerplay/smumgr/polaris10_smumgr: Make function
called by reference static
      drm/amd/pm/powerplay/smumgr/iceland_smumgr: Make function called
by reference static
      drm/amd/pm/powerplay/smumgr/vegam_smumgr: Make function called
by reference static
      drm/amd/pm/powerplay/smumgr/smu9_smumgr: Include our own header
containing our prototypes
      drm/amd/pm/powerplay/smumgr/fiji_smumgr: Demote kernel-doc format abu=
se
      drm/amd/pm/powerplay/hwmgr/hardwaremanager: Remove unused
'phm_set_*()' functions
      drm/amd/pm/powerplay/hwmgr/hwmgr: Move
'smu8_init_function_pointers()' prototype to shared header
      drm/amd/pm/inc/pp_thermal: Mark 'SMU7Thermal{WithDelay}Policy'
as __maybe_unused
      drm/amd/pm/powerplay/hwmgr/ppevvmath: Place variable declaration
under same clause as its use
      drm/amd/pm/powerplay/hwmgr/ppatomctrl: Remove unused variable 'fPower=
DPMx'
      drm/amd/pm/powerplay/hwmgr/hwmgr: Move
'smu7_init_function_pointers()'s prototype to header
      drm/amd/pm/powerplay/hwmgr/ppatomfwctrl: Demote kernel-doc
formatting abuses
      drm/amd/pm/powerplay/hwmgr/hardwaremanager: Fix function header
related formatting issues
      drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0: Convert to
proper kernel-doc format
      drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix a myriad of kernel-doc iss=
ues
      drm/amd/pm/powerplay/hwmgr/vega10_processpptables: Make function
invoked by reference static
      drm/amd/pm/powerplay/hwmgr/smu7_hwmgr: Fix a whole bunch of
historical function doc issues
      drm/amd/pm/powerplay/hwmgr/smu7_thermal: Repair formatting in a
bunch of function docs
      drm/amd/pm/powerplay/hwmgr/vega10_thermal: Fix a bunch of dated
function doc formatting
      drm/amd/pm/powerplay/hwmgr/hwmgr: Move 'vega12_hwmgr_init()'s
prototype to shared header
      drm/amd/pm/powerplay/hwmgr/hwmgr: Move 'vega20_hwmgr_init()'s
prototype to shared header
      drm/amd/pm/powerplay/hwmgr/smu_helper: Demote or fix kernel-doc heade=
rs
      drm/amd/pm/powerplay/hwmgr/vega20_thermal: Fix some outdated
function documentation
      drm/amd/pm/powerplay/hwmgr/vega12_thermal: Fix some outdated
function documentation
      drm/amd/display/dc/inc/hw/dpp: Mark 'dpp_input_csc_matrix' as
__maybe_unused
      drm/amd/display/amdgpu_dm/amdgpu_dm_color: Demote a misuse and
fix another kernel-doc header
      drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Mark local functions
invoked by reference as static
      drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Remove unused
function 'pp_nv_set_pme_wa_enable()'
      drm/amd/display/dc/basics/conversion: Include header containing
our prototypes
      drm/amd/display/dc/basics/fixpt31_32: Remove unused variable 'dc_fixp=
t_pi'
      drm/amd/display/dc/basics/vector: Make local function
'dal_vector_presized_costruct' static
      drm/amd/pm/powerplay/kv_dpm: Remove unused variable 'ret'
      drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Use 'gnu_printf'
format notation
      drm/msm/disp/dpu1/dpu_hw_interrupts: Demote kernel-doc formatting mis=
use

Lewis Huang (1):
      drm/amd/display: stop top_mgr when type change to non-MST during s3

Li Heng (1):
      video: Remove set but not used variable

Likun Gao (14):
      drm/amdgpu: add function to program pbb mode for sienna cichlid
      drm/amdgpu: add rlc iram and dram firmware support
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/pm: fix pcie information for sienna cichlid
      drm/amd/pm: update driver if file for sienna cichlid
      drm/amdgpu: correct the cu and rb info for sienna cichlid
      drm/amdgpu: add support to configure MALL for sienna_cichlid (v2)
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/pm: update driver if file for sienna cichlid
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/pm: fix the crash after runtime pm resume
      drm/amdgpu: add module parameter choose runtime method
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amdgpu: increase reserved VRAM size to 8MB

Linus Walleij (6):
      fbdev/sh_mobile: Drop unused include
      drm/panel: s6e63m0: Simplify SPI writing
      drm/panel: s6e63m0: Implement reading from panel
      drm/panel: s6e63m0: Add some explanations
      drm/panel: s6e63m0: Support 3WIRE protocol
      drm/panel: s6e63m0: Set up some display info

Lionel Landwerlin (1):
      drm/i915/perf: workaround register corruption in OATAILPTR

Liu Shixin (6):
      omapfb: simplify the return expression of panel_dpi_connect
      omapfb: simplify the return expression of sharp_ls_connect
      omapfb: simplify the return expression of tpo_td043_connect
      omapfb: connector-dvi: simplify the return expression of dvic_connect=
()
      drm/panel: simplify the return expression of rb070d30_panel_enable()
      drm/lima: simplify the return expression of lima_devfreq_target

Luben Tuikov (1):
      drm/amdgpu: Make struct drm_driver const

Lucas De Marchi (16):
      drm/i915: don't conflate is_dgfx with fake lmem
      drm/i915/dg1: add more PCI ids
      drm/i915/dg1: Define MOCS table for DG1
      drm/i915/dg1: gmbus pin mapping
      drm/i915/cnl: skip PW_DDI_F on certain skus
      drm/i915/dg1: Add DG1 power wells
      drm/i915/dg1: Enable DPLL for DG1
      drm/i915/dg1: add hpd interrupt handling
      drm/i915: Guard debugfs against invalid access without display
      drm/i915/display: remove debug message from error path
      drm/i915/dg1: map/unmap pll clocks
      drm/i915/display: add namespace to intel_prepare_reset
      drm/i915/display: add namespace to intel_finish_reset
      drm/i915: re-order if/else ladder for hpd_irq_setup
      drm/i915: move display-related to the end of intel_irq_init()
      drm/i915: Do not setup hpd without display

Lyude Paul (1):
      drm/edid: Fix uninitialized variable in drm_cvt_modes()

Maarten Lankhorst (6):
      drm/i915: Fix uninitialised variable in intel_context_create_request.
      drm/i915: Add hw.pipe_mode to allow bigjoiner pipe/transcoder split
      drm/i915/dp: Allow big joiner modes in intel_dp_mode_valid(), v3.
      drm/i915: Try to make bigjoiner work in atomic check
      drm/i915: Add bigjoiner aware plane clipping checks
      drm/i915: Add debugfs dumping for bigjoiner, v3.

Madhav Chauhan (1):
      drm/amdgpu: don't map BO in reserved region

Manasi Navare (10):
      drm/i915/display: Rename pipe_timings to transcoder_timings
      drm/i915/dp: Some reshuffling in mode_valid as prep for bigjoiner mod=
es
      drm/i915: Move encoder->get_config to a new function
      drm/i915: Add a wrapper function around get_pipe_config
      drm/i915: Pass intel_atomic_state instead of drm_atomic_state
      drm/i915/dp: Add from_crtc_state to copy color blobs
      drm/i915/dp: Modify VDSC helpers to configure DSC for Bigjoiner slave
      drm/i915/dp: Master/Slave enable/disable sequence for bigjoiner
      drm/i915: HW state readout for Bigjoiner case
      drm/i915: Do not call hsw_set_frame_start_delay for dsi

Marc Zyngier (4):
      drm/meson: Free RDMA resources after tearing down DRM
      drm/meson: Unbind all connectors on module removal
      drm/meson: dw-hdmi: Register a callback to disable the regulator
      drm/meson: dw-hdmi: Ensure that clocks are enabled before
touching the TOP registers

Marek Ol=C5=A1=C3=A1k (2):
      drm/amdgpu: set LDS_CONFIG=3D0x20 on Navy Flounder to fix a GPU hang =
(v2)
      drm/amdgpu: set LDS_CONFIG=3D0x20 on VanGogh to fix MGCG hang

Marek Szyprowski (2):
      drm/bridge: tc358764: restore connector support
      drm/exynos/hdmi: add support for 1920x1200@60Hz mode

Marijn Suijten (1):
      drm/msm: a5xx: Make preemption reset case reentrant

Martin Leung (2):
      drm/amd/display: adding reading OEM init_data to dcn3
      drm/amd/display: adding ddc_gpio_vga_reg_list to ddc reg def'ns

Matt Atwood (1):
      drm/i915/dg1: Load DMC

Matt Roper (9):
      drm/i915/dg1: Wait for pcode/uncore handshake at startup
      drm/i915/dg1: Initialize RAWCLK properly
      drm/i915/dg1: Don't program PHY_MISC for PHY-C and PHY-D
      drm/i915/dg1: Update comp master/slave relationships for PHYs
      drm/i915/dg1: provide port/phy mapping for vbt
      drm/i915: Rename FORCEWAKE_BLITTER to FORCEWAKE_GT
      drm/i915: Update gen12 forcewake table
      drm/i915: Update gen12 multicast register ranges
      drm/i915/rkl: Add new cdclk table

Matteo Franchin (1):
      drm/fourcc: Add AXBXGXRX106106106106 format

Matthew Auld (4):
      drm/i915: check i915_vm_alloc_pt_stash for errors
      drm/i915/region: fix max size calculation
      drm/i915/gem: Allow backends to override pread implementation
      drm/i915/region: fix order when adding blocks

Mauro Carvalho Chehab (11):
      drm/dp: fix kernel-doc warnings at drm_dp_helper.c
      drm/dp: fix a kernel-doc issue at drm_edid.c
      drm/amd/display: kernel-doc: document force_timing_sync
      docs: amdgpu: fix a warning when building the documentation
      drm: amdgpu: kernel-doc: update some adev parameters
      amdgpu: fix a few kernel-doc markup issues
      drm/amdgpu: fix some kernel-doc markups
      drm/amdgpu_dm: fix a typo
      video: fix some kernel-doc markups
      drm: fix some kernel-doc markups
      drm: amdgpu: fix a kernel-doc markup

Maxime Ripard (10):
      drm/atomic: Pass the full state to CRTC atomic enable/disable
      MAINTAINERS: Add myself as a maintainer for vc4
      drm/vc4: dsi: Only register our component once a DSI device is attach=
ed
      Merge drm/drm-next into drm-misc-next
      drm/nouveau/ttm: Add limits.h
      drm/atomic: Pass the full state to CRTC atomic_check
      drm/atomic: Pass the full state to CRTC atomic begin and flush
      drm/nouveau/kms/nv50-: Use state helper instead of crtc pointer
      drm: Use the state pointer directly in atomic_check
      drm: Use state helper instead of CRTC state pointer

Melissa Wen (1):
      drm/vkms: update todo

Michael Strauss (1):
      drm/amd/display: Revert DCN2.1 dram_clock_change_latency update

Michael Tretter (3):
      drm/encoder: remove obsolete documentation of bridge
      drm/exynos: remove in_bridge_node from exynos_dsi
      drm/exynos: use exynos_dsi as drvdata

Michel Thierry (1):
      drm/i915/dgfx: define llc and snooping behaviour

Mihir Bhogilal Patel (2):
      drm/amdgpu: Add debugfs entry for printing VM info
      drm/amdgpu: add a list in VM for BOs in the done state

Neil Armstrong (4):
      dt-bindings: vendor-prefixes: Add Shanghai Top Display
Optolelectronics vendor prefix
      dt-bindings: display: panel-simple-dsi: add optional reset gpio
      dt-bindings: display: panel-simple-dsi: add TDO TL070WSH30 DSI
panel bindings
      drm: panel: add TDO tl070wsh30 panel driver

Nikola Cornij (1):
      drm/amd/display: Add an option to limit max DSC target bpp per sink

Nirmoy Das (5):
      drm/amdgpu: fix compute queue priority if num_kcq is less than 4
      drm/amdgpu: fix usable gart size calculation
      drm/amdgpu: use generic DMA API
      drm/radeon: use generic DMA API
      drm/amdgpu: use AMDGPU_NUM_VMID when possible

Ondrej Jirman (1):
      drm: aspeed: Fix GENMASK misuse

Pankaj Bharadiya (4):
      drm: Introduce plane and CRTC scaling filter properties
      drm/i915: Introduce scaling filter related registers and bit fields
      drm/i915/display: Add Nearest-neighbor based integer scaling support
      drm/i915: Enable scaling filter for plane and CRTC

Patrik Jakobsson (2):
      drm/gma500: Remove GTT roll support
      drm/gma500: Remove 2D accel code

Paul Cercueil (13):
      drm/ingenic: Reset pixclock rate when parent clock rate changes
      drm/ingenic: Add support for reserved memory
      drm/ingenic: Alloc F0 and F1 DMA descriptors at once
      drm/ingenic: Support handling different pixel formats in F0/F1 planes
      drm/ingenic: Add support for 30-bit modes
      drm/ingenic: Add support for 24-bit modes
      drm/ingenic: Add support for paletted 8bpp
      Revert "gpu/drm: ingenic: Add option to mmap GEM buffers cached"
      drm/ingenic: ipu: Search for scaling coefs up to 102% of the screen
      dt-bindings: vendor-prefixes: Add abt vendor prefix
      dt-bindings: display: Add ABT Y030XX067A panel bindings
      media: uapi: Add MEDIA_BUS_FMT_RGB888_3X8_DELTA media bus format
      drm/panel: Add ABT Y030XX067A 3.0" 320x480 panel

Peilin Ye (7):
      fbdev/atafb: Remove unused extern variables
      Fonts: Make font size unsigned in font_desc
      console: Delete unused con_font_copy() callback implementations
      console: Delete dummy con_font_set() and con_font_default()
callback implementations
      Fonts: Add charcount field to font_desc
      parisc/sticore: Avoid hard-coding built-in font charcount
      fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcoun=
t

Peter Ujfalusi (1):
      drm: xlnx: Use dma_request_chan for DMA channel request

Philip Yang (1):
      drm/amdkfd: keep BOs in system memory if restore failed

Pratik Vishwakarma (1):
      drm/amd/display: Tune min clk values for MPO for RV

Prike Liang (8):
      drm/amdgpu: add green_sardine support for gpu_info and ip block
setting (v2)
      drm/amdgpu: add soc15 common ip block support for green_sardine (v3)
      drm/amdgpu: add gfx support for green_sardine (v2)
      drm/amdgpu/sdma: add sdma engine support for green_sardine (v2)
      drm/amdgpu: add s0i3 capacity check for s0i3 routine (v2)
      drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx power
change entry (v2)
      drm/amdgpu: update amdgpu device suspend/resume sequence for s0i3 sup=
port
      drm/amd/pm: add gfx_state_change_set() for rn gfx power switch (v2)

Qilong Zhang (1):
      omapfb: use devm_platform_ioremap_resource_byname

Qinglang Miao (12):
      vga_switcheroo: simplify the return expression of
vga_switcheroo_runtime_resume
      drm/panel: simplify the return expression of td028ttec1_prepare
      drm/qxl: simplify the return expression of qxl_plane_prepare_fb()
      drm/panfrost: simplify the return expression of cz_ih_hw_init()
      drm/panfrost: simplify the return expression of panfrost_devfreq_targ=
et()
      omapfb: connector-analog-tv: simplify the return expression of
tvc_connect()
      omapfb: connector-hdmi: simplify the return expression of hdmic_conne=
ct
      omapfb: panel-sony-acx565akm: simplify the return expression of
acx565akm_connect()
      omapfb: simplify the return expression of hdmi_pll_enable
      fbdev: nvidia: use for_each_child_of_node() macro
      drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
      drm: panel: simple: add missing platform_driver_unregister() in
panel_simple_init

Qingqing Zhuo (2):
      drm/amd/display: NULL pointer error during compliance test
      drm/amd/display: Only one display lights up while using MST hub

Ramalingam C (2):
      drm/i915: terminate reauth at stream management failure
      drm/i915: dont retry stream management at seq_num_m roll over

Ramesh Errabolu (2):
      drm/amd/amdgpu: Enable arcturus devices to access the method
kgd_gfx_v9_get_cu_occupancy that is already defined
      drm/amd/amdgpu: Import amdgpu_amdkfd_gfx_v9 header file into
implementation

Randy Dunlap (1):
      drm/aspeed: Fix Kconfig warning & subsequent build errors

Raymond Yang (1):
      drm/amd/display: correct data type

Reza Amini (2):
      drm/amd/display: Define PSR ERROR Status bit VSC_SDP
      drm/amd/display: Implement VSIF V3 extended refresh rate feature

Rikard Falkeborn (2):
      drm: bridge: dw-hdmi: Constify dw_hdmi_i2s_ops
      drm/msm: dsi: Constify dsi_host_ops

Rob Clark (33):
      drm/msm/atomic: Drop per-CRTC locks in reverse order
      drm/msm/gpu: Convert retire/recover work to kthread_worker
      drm/msm/kms: Update msm_kms_init/destroy
      drm/msm/atomic: Convert to per-CRTC kthread_work
      drm/msm: Fix a couple incorrect usages of get_vaddr_active()
      drm/msm/gem: Add obj->lock wrappers
      drm/msm/gem: Rename internal get_iova_locked helper
      drm/msm/gem: Move prototypes to msm_gem.h
      drm/msm/gem: Add some _locked() helpers
      drm/msm/gem: Move locking in shrinker path
      drm/msm/submit: Move copy_from_user ahead of locking bos
      drm/msm: Do rpm get sooner in the submit path
      drm/msm/gem: Switch over to obj->resv for locking
      drm/msm: Use correct drm_gem_object_put() in fail case
      drm/msm: Drop chatty trace
      drm/msm: Move update_fences()
      drm/msm: Add priv->mm_lock to protect active/inactive lists
      drm/msm: Document and rename preempt_lock
      drm/msm: Protect ring->submits with it's own lock
      drm/msm: Refcount submits
      drm/msm: Remove obj->gpu
      drm/msm: Drop struct_mutex from the retire path
      drm/msm: Drop struct_mutex in free_object() path
      drm/msm: Remove msm_gem_free_work
      drm/msm: Drop struct_mutex in madvise path
      drm/msm: Drop struct_mutex in shrinker path
      drm/msm/a6xx: Clear shadow on suspend
      drm/msm/a5xx: Clear shadow on suspend
      drm/msm: Protect obj->active_count under obj lock
      drm/msm/shrinker: We can vmap shrink active_list too
      drm/msm/shrinker: Only iterate dontneed objs
      msm/mdp5: Fix some kernel-doc warnings
      Merge remote-tracking branch
'arm64/for-next/iommu/io-pgtable-domain-attr' into msm-next-staging

Robin Murphy (7):
      drm/etnaviv: Drop local dma_parms
      drm/komeda: Drop local dma_parms
      iommu/io-pgtable-arm: Support coherency for Mali LPAE
      drm/panfrost: Support cache-coherent integrations
      arm64: dts: meson: Describe G12b GPU as coherent
      drm/msm: Add missing stub definition
      drm/mediatek: Drop local dma_parms

Rodrigo Siqueira (8):
      drm/amd/display: Fix module load hangs when connected to an eDP
      drm/amd/display: Decouple amdgpu_dm_trace from service
      drm/amd/display: Rework registers tracepoint
      drm/amd/display: Add tracepoint for amdgpu_dm
      drm/amd/display: Add pipe_state tracepoint
      drm/amd/display: Add tracepoint for capturing clocks state
      drm/amd/display: Always get CRTC updated constant values inside
commit tail
      drm/amd/display: Avoid HDCP initialization in devices without output

Rodrigo Vivi (1):
      drm/i915/tgl: Fix Media power gate sequence.

Roman Li (10):
      drm/amdgpu/atomfirmware: Add edp and integrated info v2.1 tables
      drm/amd/display: Add dcn3.01 support to DC (v2)
      drm/amd/display: Add dcn3.01 support to DM
      drm/amd/display: Add green_sardine support to DC
      drm/amd/display: Add green_sardine support to DM
      drm/amd/display: Refactor ABM_MASK_SH_LIST_DCN301 naming
      drm/amd/display: fix psr panel lightup
      drm/amdgpu: add ta firmware load for green-sardine
      drm/amd/display: add S/G support for Vangogh
      drm/amd/display: setup system context for APUs

Roy Chan (2):
      drm/amd/display: Detect dynamic backlight support in eDP sink
      drm/amd/display: Fixed the audio noise during mode switching
with HDCP mode on

Ryan Taylor (1):
      drm/amd/pm: fix smu_v11_0_init_power power_context allocation

Saeed Mirzamohammadi (1):
      video: fbdev: fix divide error in fbcon_switch

Sai Prakash Ranjan (2):
      iommu/io-pgtable: Add a domain attribute for pagetable configuration
      iommu/io-pgtable-arm: Add support to use system cache

Samson Tam (1):
      drm/amd/display: fix cursor calculation for 1xnY rotated display grou=
ps

Sandeep Raghuraman (3):
      drm/radeon: Add new callback that exposes vddc
      drm/radeon: Add implementation of get_current_vddc for Sumo
      drm/radeon: Expose vddc through hwmon

Sean Paul (1):
      drm/i915/dp: Tweak initial dpcd backlight.enabled value

Sergey Senozhatsky (1):
      drm/virtio: use kvmalloc for large allocations

Sharat Masetty (2):
      drm/msm: rearrange the gpu_rmw() function
      drm/msm/a6xx: Add support for using system cache(LLC)

Sherry (1):
      drm/amd/display: change hw sequence

Simon Ser (21):
      drm/fourcc: document modifier uniqueness requirements
      drm: document that user-space should avoid parsing EDIDs
      drm: deprecate DRM_FORMAT_MOD_NONE
      drm: unify formatting for color management documentation
      drm: document that blobs are ref'counted
      drm/fourcc: add table describing AMD modifiers bit layout
      drm: convert drm_atomic_uapi.c to new debug helpers
      drm: add debug logs for drm_mode_atomic_ioctl errors
      drm: fix oops in drm_atomic_set_crtc_for_connector
      drm/fourcc: fix AMD modifiers PACKERS field doc
      drm/amd/display: add cursor FB size check
      drm/amd/display: disallow cropping for cursor plane
      drm/amd/display: check cursor scaling
      drm/amd/display: don't expose rotation prop for cursor plane
      drm/amd/display: add debug logs for dm_crtc_helper_atomic_check
      drm/amd/display: use FB pitch to fill dc_cursor_attributes
      drm/amd/display: add cursor pitch check
      drm/amd/display: extract cursor FB checks into a function
      drm/amd/display: check cursor FB is linear
      drm/amd: use drm_dbg_kms to log addfb2 failures
      drm/amd: print error on convert_tiling_flags_to_modifier failure

Sonny Jiang (3):
      drm/amdgpu: fix SI UVD firmware validate resume fail
      drm/amdgpu: fix a page fault
      drm/amdgpu: VCN 3.0 multiple queue ring reset

Stanley.Yang (3):
      drm/amdgpu: set default value of noretry to 1 for specified asic
      drm/amdgpu: only skip smc sdma sos ta and asd fw in SRIOV for navi12
      drm/amdgpu: fix sdma instance fw version and feature version init

Stephen Boyd (6):
      drm/msm/dpu: Add newline to printks
      drm/bridge: ti-sn65dsi86: Combine register accesses in
ti_sn_aux_transfer()
      drm/bridge: ti-sn65dsi86: Make polling a busy loop
      drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
      drm/bridge: ti-sn65dsi86: Update reply on aux failures
      drm/panel: simple: Add flags to boe_nv133fhm_n61

Steven Price (1):
      drm/panfrost: Don't corrupt the queue mutex on open/close

Stuart Summers (1):
      drm/i915/dg1: Add initial DG1 workarounds

Sumera Priyadarsini (2):
      drm/amdgpu: Return boolean types instead of integer values
      drm/amdgpu: use true and false for bool initialisations

Sumit Semwal (2):
      dt-bindings: display: panel: Add bindings for Novatek nt36672a
      drm: panel: Add novatek nt36672a panel driver

Sung Joon Kim (1):
      drm/amd/display: enable pipe power gating by default

Sung Lee (7):
      drm/amd/display: Hardcode 45W Bounding Box for DCN2.1 Diags
      drm/amd/display: Add Bounding Box State for Low DF PState but
High Voltage State
      drm/amd/display: DCN2.1 Disable 48MHz Powerdown Debug Option
      drm/amd/display: Populate hostvm parameter before DML calculation
      drm/amd/display: Handle Unknown Result for SMU Periodic
Retraining on DCN2.1
      drm/amd/display: Update dram_clock_change_latency for DCN2.1
      drm/amd/display: Add wm table for Renoir

Taimur Hassan (1):
      drm/amd/display: Raise DPG height during timing synchronization

Takashi Iwai (3):
      drm/amd/display: Fix kernel panic by dal_gpio_open() error
      drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
      drm/amd/display: Clean up debug macros

Tanmay Shah (1):
      drm/msm/dp: DisplayPort PHY compliance tests fixup

Tao Zhou (52):
      drm/amdgpu: add dimgrey_cavefish asic type
      drm/amdgpu: add dimgrey_cavefish gpu info firmware
      drm/amdgpu: set fw load type for dimgrey_cavefish
      drm/amdgpu: set asic family and ip blocks for dimgrey_cavefish
      drm/amdgpu: add support for dimgrey_cavefish firmware
      drm/amdgpu: add gmc support for dimgrey_cavefish
      drm/amdgpu: add gfx clock gating support for dimgrey_cavefish
      drm/amdgpu: add common support for dimgrey_cavefish
      drm/amdgpu: initialize IP offset for dimgrey_cavefish
      drm/amdgpu: add mmhub support for dimgrey_cavefish
      drm/amdgpu: add common ip block for dimgrey_cavefish
      drm/amdgpu: add gmc ip block for dimgrey_cavefish
      drm/amdgpu: add ih ip block for dimgrey_cavefish
      drm/amdgpu: add gfx ip block for dimgrey_cavefish
      drm/amdgpu: add sdma ip block for dimgrey_cavefish
      drm/amdgpu: configure dimgrey_cavefish gfx according to gfx
10.3's definition
      drm/amdgpu: add virtual display support for dimgrey_cavefish
      drm/amdgpu: force pa_sc_tile_steering_override to 0 for dimgrey_cavef=
ish
      drm/amdgpu: add gmc cg support for dimgrey_cavefish
      drm/amdgpu/swsmu: increase size for smu fw_name string
      drm/amdgpu/swsmu: add smu support for dimgrey_cavefish(v2)
      drm/amdgpu: increase size of psp fw_name string(v2)
      drm/amdgpu: add psp support for dimgrey_cavefish(v2)
      drm/amdgpu: skip reroute ih for some ASICs
      drm/amdgpu: support cp_fw_write_wait for dimgrey_cavefish
      drm/amdgpu: add gc golden setting for dimgrey_cavefish
      drm/amdgpu: enable front door loading for dimgrey_cavefish
      drm/amdgpu: support athub cg setting for dimgrey_cavefish
      drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
      drm/amdgpu: enable GFX clock gating for dimgrey_cavefish
      drm/amdgpu: enable mc CG and LS for dimgrey_cavefish
      drm/amdgpu: enable athub/mmhub PG for dimgrey_cavefish
      drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
      drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
      drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish(v2)
      drm/amdgpu: add psp and smu block for dimgrey_cavefish
      drm/amdgpu: enable hdp CG and LS for dimgrey_cavefish
      drm/amdgpu: enable ih CG for dimgrey_cavefish
      drm/amdgpu: remove gpu_info fw support for dimgrey_cavefish
      drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
      drm/amdgpu: remove ASD ucode init for dimgrey_cavefish
      drm/amdgpu: add DM block for dimgrey_cavefish
      drm/amd/pm: update driver if version for dimgrey_cavefish
      drm/amdgpu: enable GFXOFF for dimgrey_cavefish
      drm/amdgpu: update gfx golden setting for dimgrey_cavefish
      drm/amd/pm: update driver if version for dimgrey_cavefish
      drm/amd/pm: retire dimgrey_cavefish hardcode for the use of soft PPTa=
ble
      drm/amd/pm: support runtime PPTable update for dimgrey_cavefish
      drm/amdgpu: add device ID for navy_flounder (v2)
      drm/amdgpu: add DID for dimgrey_cavefish
      drm/amdgpu: update GC golden setting for dimgrey_cavefish
      drm/amd/pm: update driver if version for dimgrey_cavefish

Tao.Huang (1):
      drm/amd/display: Fix compilation error

Tashfique Abdullah (1):
      drm/amd/display: intermittent underflow observed when PIP is
toggled in Full screen

Tejas Upadhyay (3):
      drm/i915/jsl: Split EHL/JSL platform info and PCI ids
      drm/i915/ehl: Implement W/A 22010492432
      drm/i915/edp/jsl: Update vswing table for HBR and HBR2

Thomas Zimmermann (53):
      drm/vram-helper: Fix use of top-down placement
      drm/ast: Reload gamma LUT after changing primary plane's color format
      drm/amdgpu: Introduce GEM object functions
      drm/armada: Introduce GEM object functions
      drm/etnaviv: Introduce GEM object functions
      drm/exynos: Introduce GEM object functions
      drm/gma500: Introduce GEM object functions
      drm/i915: Introduce GEM object functions
      drm/imx/dcss: Initialize DRM driver instance with CMA helper macro
      drm/mediatek: Introduce GEM object functions
      drm/msm: Introduce GEM object funcs
      drm/nouveau: Introduce GEM object functions
      drm/omapdrm: Introduce GEM object functions
      drm/pl111: Introduce GEM object functions
      drm/radeon: Introduce GEM object functions
      drm/rockchip: Convert to drm_gem_object_funcs
      drm/tegra: Introduce GEM object functions
      drm/vc4: Introduce GEM object functions
      drm/vgem: Introduce GEM object functions
      drm/virtgpu: Set PRIME export function in struct drm_gem_object_funcs
      drm/vkms: Introduce GEM object functions
      drm/xen: Introduce GEM object functions
      drm/xlnx: Initialize DRM driver instance with CMA helper macro
      drm: Remove obsolete GEM and PRIME callbacks from struct drm_driver
      drm/vram-helper: Integrate drm_gem_vram_init() into drm_gem_vram_crea=
te()
      drm/vram-helper: Set object function iff they are not provided by dri=
ver
      drm/vram-helper: Don't put new BOs into VRAM
      drm/rockchip: Include <drm/drm_gem_cma_helper> for drm_gem_cm_vm_ops
      dma-buf: Add struct dma-buf-map for storing struct dma_buf.vaddr_ptr
      dma-buf: Use struct dma_buf_map in dma_buf_vmap() interfaces
      dma-buf: Use struct dma_buf_map in dma_buf_vunmap() interfaces
      dma-buf: Document struct dma_buf_map
      drm/aspeed: Set driver CMA functions with DRM_GEM_CMA_DRIVER_OPS
      drivers/video: Fix -Wstringop-truncation in hdmi.c
      drm/tiny/gm12u320: Retrieve USB device from struct drm_device.dev
      drm/udl: Retrieve USB device from struct drm_device.dev
      drm/vram-helper: Remove invariant parameters from internal kmap funct=
ion
      drm/cma-helper: Remove empty drm_gem_cma_prime_vunmap()
      drm/etnaviv: Remove empty etnaviv_gem_prime_vunmap()
      drm/exynos: Remove empty exynos_drm_gem_prime_{vmap,vunmap}()
      drm/ttm: Add vmap/vunmap to TTM and TTM GEM helpers
      drm/gem: Use struct dma_buf_map in GEM vmap ops and convert GEM backe=
nds
      drm/gem: Update internal GEM vmap/vunmap interfaces to use
struct dma_buf_map
      drm/gem: Store client buffer mappings as struct dma_buf_map
      dma-buf-map: Add memcpy and pointer-increment interfaces
      drm/fb_helper: Support framebuffers in I/O memory
      drm/cma-helper: Make default object functions the default
      drm/gma500: Remove unused function psb_gem_get_aperture()
      drm/msm: Use struct dma_buf_map in GEM vmap ops
      drm/mediatek: Use struct dma_buf_map in GEM vmap ops
      Merge drm/drm-next into drm-misc-next
      drm/nouveau: Fix out-of-bounds access when deferencing MMU type
      drm/mediatek: Introduce GEM object functions

Thong Thai (2):
      drm/amdgpu: enable vcn3.0 for van gogh
      drm/amdgpu: enable vcn support for green_sardine (v2)

Tian Tao (12):
      drm/hisilicon: Support i2c driver algorithms for bit-shift adapters
      drm/hisilicon: Features to support reading resolutions from EDID
      drm/hisilicon: Deleted the drm_device declaration
      drm/hisilicon: Using the to_hibmc_drm_private to convert
      drm/hisilicon: Delete the unused macro
      drm/hisilicon: Use the same style of variable type in hibmc_drm_de
      drm/hisilicon: Use the same style of variable type in hibmc_drm_drv
      drm/hisilicon: Adding a const declaration to an invariant construct
      drm/msm: Add missing struct identifier
      drm/msm: Remove redundant null check
      drm/amd/pm: Use kmemdup instead of kmalloc and memcpy
      drm/msm/dp: remove duplicate include statement

Tianci.Yin (3):
      drm/amdgpu: disable DCN and VCN for navi10 blockchain SKU(v3)
      drm/amdgpu: add DID for navi10 blockchain SKU
      drm/amdgpu: enable DCN for navi10 headless SKU

Tom Rix (6):
      drm/gma500: fix double free of gma_connector
      drm/amdgpu: add missing newline at eof
      drm/amdgpu: remove unneeded break
      drm/amdgpu: remove unneeded semicolon
      drm/amd/display: remove unneeded semicolon
      drm: remove unneeded break

Tomi Valkeinen (2):
      dt-bindings: display: ti,am65x-dss: add missing properties to dt-sche=
ma
      dt-bindings: display: ti,j721e-dss: add missing properties to dt-sche=
ma

Tvrtko Ursulin (6):
      drm/i915: Fix DMA mapped scatterlist walks
      drm/i915: Fix DMA mapped scatterlist lookup
      drm/i915/pmu: Handle PCI unbind
      drm/i915/pmu: Fix CPU hotplug with multiple GPUs
      drm/i915: Improve record of hung engines in error state
      drm/i915: Use ABI engine class in error state ecode

Vandita Kulkarni (5):
      drm/i915/dsi: Add details about TE in get_config
      i915/dsi: Configure TE interrupt for cmd mode
      drm/i915/dsi: Add TE handler for dsi cmd mode.
      drm/i915/dsi: Initiate frame request in cmd mode
      drm/i915/dsi: Enable software vblank counter

Veerabadhran G (1):
      drm/amdgpu: vcn and jpeg ring synchronization

Veerabadhran Gopalakrishnan (1):
      amd/amdgpu: Disable VCN DPG mode for Picasso

Venkata Sandeep Dhanalakota (2):
      drm/i915/dg1: Increase mmio size to 4MB
      drm/i915: Correctly set SFC capability for video engines

Victor Lu (2):
      drm/amd/display: Do not warn NULL dc_sink if forcing connector
      drm/amd/display: Explicitly disable cursor when disabling CRTC

Ville Syrj=C3=A4l=C3=A4 (113):
      drm/i915: Extract intel_dp_output_format()
      drm/i915: Decouple intel_dp_{min,output}_bpp() from crtc_state
      drm/i915: Use the correct bpp when validating "4:2:0 only" modes
      drm/i915: Make intel_{enable,disable}_sagv() static
      drm/i915: Don't hide the intel_crtc_atomic_check() call
      drm/i915: Fix state checker hw.active/hw.enable readout
      drm/i915: Move MST master transcoder dump earlier
      drm/i915: Include the LUT sizes in the state dump
      drm/i915: s/glk_read_lut_10/bdw_read_lut_10/
      drm/i915: Reset glk degamma index after programming/readout
      drm/i915: Shuffle chv_cgm_gamma_pack() around a bit
      drm/i915: Relocate CHV CGM gamma masks
      drm/i915: Polish bdw_read_lut_10() a bit
      drm/i915: Replace some gamma_mode ifs with switches
      drm/i915: Read DIMM size in Gb rather than GB
      drm/i915: Implement display WA #1142:kbl,cfl,cml
      drm/i915: Fix TGL DKL PHY DP vswing handling
      drm/i915: s/pre_empemph/preemph/
      drm/i915: s/old_crtc_state/crtc_state/
      drm/i915: Make intel_dp_process_phy_request() static
      drm/i915: Shove the PHY test into the hotplug work
      drm/i915: Split ICL combo PHY buf trans per output type
      drm/i915: Split ICL MG PHY buf trans per output type
      drm/i915: Split EHL combo PHY buf trans per output type
      drm/i915: Split TGL combo PHY buf trans per output type
      drm/i915: Split TGL DKL PHY buf trans per output type
      drm/i915: Plumb crtc_state to link training
      drm/i915: Eliminate intel_dp.regs.dp_tp_{ctl,status}
      drm/i915: Make lspcon_init() static
      drm/i915: Shut down displays gracefully on reboot
      drm/i915: Add an encoder .shutdown() hook
      drm/i915: Replace the VLV/CHV eDP reboot notifier with the
.shutdown() hook
      drm/i915: Wait for eDP panel power cycle delay on reboot on all platf=
orms
      drm/i915: Wait for LVDS panel power cycle delay on reboot
      drm/i915: Wait for VLV/CHV/BXT/GLK DSI panel power cycle delay on reb=
oot
      drm/i915: Rename i915_{save,restore}_state()
      drm/i915: Set all unused color plane offsets to ~0xfff again
      drm/i915: Skip aux plane stuff when there is no aux plane
      drm/i915: s/int/u32/ for aux_offset/alignment
      drm/i915: Mark ininitial fb obj as WT on eLLC machines to avoid
rcu lockup during fbdev init
      drm/i915: Fix MOCS PTE setting for gen9+
      drm/i915: Enable eLLC caching of display buffers for SKL+
      drm/i915: Apply WAC6entrylatency to kbl/cfl
      drm/i915: Mark initial fb obj as WT on eLLC machines to avoid
rcu lockup during fbdev init
      drm/i915: Nuke lspcon_downsampling
      drm/i915: Nuke lspcon_ycbcr420_config()
      drm/i915: Inline intel_dp_ycbcr420_config()
      drm/i915: Move the lspcon resume from .reset() to intel_dp_sink_dpms(=
)
      drm/i915: s/intel_dp_sink_dpms/intel_dp_set_power/
      drm/i915: Reorder hpd init vs. display resume
      drm/i915: Refactor .hpd_irq_setup() calls a bit
      drm/i915: Sort the mess around ICP TC hotplugs regs
      drm/i915: Try to fix the SKL GT3/4 vs. GT3e/4e comments
      drm/i915: Ocd the HSW PCI ID hex numbers
      drm/i915: Sort HSW PCI IDs
      drm/i915: Sort SKL PCI IDs
      drm/i915: Sort KBL PCI IDs
      drm/i915: Sort CML PCI IDs
      drm/i915: Sort CFL PCI IDs
      drm/i915: Sort CNL PCI IDs
      drm/i915: Sort ICL PCI IDs
      drm/i915: Restore ILK-M RPS support
      drm/i915: Read actual GPU frequency from MEMSTAT_ILK on ILK
      drm/i915: Fix potential overflows in ilk ips calculations
      drm/i915: Do gen5_gt_irq_postinstall() before enabling the
master interrupt
      drm/i915: Clean up the irq enable/disable for ilk rps
      drm/i915: Reject 90/270 degree rotated initial fbs
      drm/i915: Use _MMIO_PIPE3() for ilk+ WM0_PIPE registers
      drm/i915: s/PORT_TC/TC_PORT_/
      drm/i915: Add PORT_TCn aliases to enum port
      drm/i915: Give DDI encoders even better names
      drm/i915: Introduce AUX_CH_USBCn
      drm/i915: Pimp AUX CH names
      drm/i915: Use AUX_CH_USBCn for the RKL VBT AUX CH setup
      drm/i915: Parametrize BXT_DE_PORT_HP_DDI with hpd_pin
      drm/i915: Introduce GEN8_DE_PORT_HOTPLUG()
      drm/i915: s/port/hpd_pin/ for icp+ ddi hpd bits
      drm/i915: s/tc_port/hpd_pin/ in GEN11_{TC,TBT}_HOTPLUG()
      drm/i915: s/tc_port/hpd_pin/ in icp+ TC hotplug bits
      drm/i915: Relocate intel_hpd_{enabled,hotplug}_irqs()
      drm/i915: Split gen11_hpd_detection_setup() into tc vs. tbt variants
      drm/i915: Don't enable hpd detection logic from irq_postinstall()
      drm/i915: Rename 'tmp_mask'
      drm/i915: Remove per-platform IIR HPD masking
      drm/i915: Enable hpd logic only for ports that are present
      drm/i915: Use GEN3_IRQ_INIT() to init south interrupts in icp+
      drm/i915: Get rid of ibx_irq_pre_postinstall()
      drm/i915: Sort EHL/JSL PCI IDs
      drm/i915: Include fb modifier in state dumps
      drm/i915: Add plane .{min,max}_width() and .max_height() vfuncs
      drm/i915: Move hw.active assignment into intel_crtc_get_pipe_config()
      drm/i915: s/intel_mode_from_pipe_config/intel_mode_from_crtc_timings/
      drm/i915: Introduce intel_crtc_readout_derived_state()
      drm/i915: Pass intel_atomic_state around
      drm/i915: Nuke intel_atomic_crtc_state_for_each_plane_state()
from skl+ wm code
      drm/i915: Pimp the watermark documentation a bit
      drm/i915: Precompute can_sagv for each wm level
      drm/i915: Store plane relative data rate in crtc_state
      drm/i915: Remove skl_adjusted_plane_pixel_rate()
      drm/i915: Introduce intel_dpll_get_hw_state()
      drm/i915: Move intel_dpll_get_hw_state() into the hsw+ platform
specific functions
      drm/i915: Use actual readout results for .get_freq()
      drm/i915: Relocate cnl_get_ddi_pll()
      drm/i915: Handle max_bpc=3D=3D16
      drm/i915: Fix the DDI encoder names
      drm/i915: Copy the plane hw state directly for Y planes
      drm/i915: Add crtcs affected by bigjoiner to the state
      drm/i915: Add planes affected by bigjoiner to the state
      drm/i915: Get the uapi state from the correct plane when bigjoiner is=
 used
      drm/i915: Disable legacy cursor fastpath for bigjoiner
      drm/i915: Fix cursor src/dst rectangle with bigjoiner
      drm/i915: Add bigjoiner state dump
      drm/i915: Enable bigjoiner

Viresh Kumar (2):
      drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
      drm/lima: Unconditionally call dev_pm_opp_of_remove_table()

Wang Qing (1):
      video: use kobj_to_dev()

Wang ShaoBo (1):
      drm/imx/dcss: fix unused but set variable warnings

Wang Xiaojun (1):
      drm/tidss: use devm_platform_ioremap_resource_byname

Wayne Lin (2):
      drm/amd/display: Calculate CRC on specific frame region
      drm/amd/display: Expose new CRC window property

Wenjing Liu (1):
      drm/amd/display: minor restructuring of pbn calculation functions

Wesley Chalmers (1):
      drm/amd/display: Use provided offset for DPG generation

Wyatt Wood (4):
      drm/amd/display: Hook up PSR residency command to DSAT
      drm/amd/display: Increase sr enter/exit in rn ddr4 watermark table
      drm/amd/display: Clear sticky vsc sdp error bit
      drm/amd/display: Add support for runtime feature detection command

Xiaofei Tan (1):
      fbdev: mx3fb: remove unused variable 'irq'

Xiaojian Du (21):
      drm/amdgpu/powerplay: add new smu messages and feature masks for
vangogh (v2)
      drm/admgpu/powerplay: add smu v11.5 driver interface header for vango=
gh
      drm/amdgpu/powerplay: add smu v11.5 firmware header for vangogh (v2)
      drm/amdgpu/powerplay: add smu v11.5 smc header for vangogh
      drm/amdgpu/powerplay: add vangogh asic name in smu v11 (v2)
      drm/amdgpu/powerplay: add smu initialize funcitons for vangogh (v4)
      drm/amd/pm: update the smu v11.5 smc header for vangogh
      drm/amd/pm: update the smu v11.5 firmware header for vangogh
      drm/amd/pm: add new smc message mapping for vangogh
      drm/amd/pm: add UMD Pstate Msg Parameters for vangogh temporarily
      drm/amd/pm: update the smu v11.5 driver interface header for vangogh
      drm/amd/pm: set the initial value of pm info to zero
      drm/amd/pm: remove some redundant smu message mapping for vangogh
      drm/amd/pm: add one new function to get 32 bit feature mask for vango=
gh
      drm/amd/pm: add some swSMU functions for vangogh.
      drm/amd/pm: enable the rest functions of swSMU for vangogh.
      drm/amd/pm: add the interface to dump smu metrics table for vangogh
      drm/amd/pm: update the swSMU headers for vangogh
      drm/amd/pm: add the fine grain tuning function for vangogh
      drm/amd/pm: enable the fine grain tuning function for vangogh
      drm/amd/pm: remove one unsupported smu function for vangogh

Xiaomeng Hou (1):
      drm/amdgpu: enable IP discovery for vangogh

Xin Ji (2):
      dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter DT schema
      drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP

Xu Wang (3):
      omapfb/dss: Remove redundant null check before
clk_prepare_enable/clk_disable_unprepare
      video: fbdev: sh_mobile_lcdcfb: Remove redundant null check
before clk_prepare_enable/clk_disable_unprepare
      drm/bridge: ti-sn65dsi86: remove redundant null check

Yan Zhao (1):
      drm/i915/gvt: correct a false comment of flag F_UNALIGN

Yang Yingliang (2):
      video: fbdev: atmel_lcdfb: fix return error code in atmel_lcdfb_of_in=
it()
      drm/omap: dmm_tiler: fix return error code in omap_dmm_probe()

Yannick Fertre (2):
      drm/panel: rm68200: allow using non-continuous dsi clock
      drm/panel: rm68200: fix mode to 50fps

Ye Bin (2):
      drm/amdgpu: Fix invalid number of character '{' in amdgpu_acpi_init
      drm/amdgpu: Fix inconsistent of format with argument type in amdgpu_x=
gmi.c

Yejune Deng (1):
      drm/panfrost: Replace devm_reset_control_array_get()

Yifan Zhang (3):
      drm/amd/display: setup system context in dm_init
      drm/amd/display: add S/G support for Renoir
      drm/amd/display: Fix the display corruption issue on Navi10

Yongqiang Sun (15):
      drm/amd/display: Block ABM in case of eDP ODM
      drm/amd/display: Reduce height of visual confirm on right side.
      drm/amd/display: only check available pipe to disable vbios mode.
      drm/amd/display: update dpp dto phase and modulo.
      drm/amd/display: check actual clock value.
      drm/amd/display: cap dpp dto phase not more than modulo.
      drm/amd/display: Program dpp dto based on actual dpp clk
      drm/amd/display: set dpp dto as per requested clk for lower case.
      drm/amd/display: Add dual edp optimization flag.
      drm/amd/display: update vgh bounding box
      drm/amd/display: Enable stutter for dcn3.01.
      drm/amd/display: Add internal display info
      drm/amd/display: Check multiple internal displays for power optimizat=
ion.
      drm/amd/display: remove macro which is in header already
      drm/amd/display: init soc bounding box for dcn3.01.

Yu-Ting Shen (1):
      drm/amd/display: disable seamless boot for VSC_SDP

YueHaibing (1):
      drm/bridge: tpd12s015: Fix irq registering in tpd12s015_probe

Zhan Liu (1):
      drm/amd/display: Properly define DPCS related info for DCN301

Zhang Qilong (1):
      drm/amdgpu: Discard unnecessary breaks

Zou Wei (3):
      drm/i915: Remove unused variable ret
      drm/amd/display: remove useless if/else
      drm/virtio: Make virtgpu_dmabuf_ops with static keyword

Zwane Mwaikambo (1):
      drm/dp_aux_dev: check aux_dev before use in drm_dp_aux_dev_get_by_min=
or()

jinlong zhang (1):
      drm/amd/display: Using udelay for specific dongle while edid return d=
efer

kernel test robot (2):
      drm/amdgpu: kfd_initialized can be static
      drm/amdgpu: fix semicolon.cocci warnings

mengwang (1):
      drm/amd/pm: correct table_clk_vlt memory size due to replacing
one-element array with flexible-array in struct
phm_clock_voltage_dependency_table

shaoyunl (1):
      drm/amdgpu/dce_virtual: Enable vBlank control for vf

xinhui pan (1):
      drm/amdgpu: Fix size calculation when init onchip memory

 .../bindings/display/bridge/analogix,anx7625.yaml  |     95 +
 .../bindings/display/bridge/intel,keembay-dsi.yaml |    101 +
 .../bindings/display/bridge/lontium,lt9611.yaml    |      5 +-
 .../devicetree/bindings/display/bridge/sii902x.txt |      4 +
 .../bindings/display/intel,keembay-display.yaml    |     72 +
 .../bindings/display/intel,keembay-msscam.yaml     |     43 +
 .../bindings/display/mediatek/mediatek,disp.txt    |      4 +-
 .../bindings/display/mediatek/mediatek,dpi.txt     |     42 -
 .../bindings/display/mediatek/mediatek,dpi.yaml    |     98 +
 .../devicetree/bindings/display/msm/gpu.txt        |      7 +
 .../bindings/display/panel/abt,y030xx067a.yaml     |     62 +
 .../bindings/display/panel/novatek,nt36672a.yaml   |     87 +
 .../bindings/display/panel/panel-simple-dsi.yaml   |      7 +
 .../bindings/display/panel/panel-simple.yaml       |      2 +
 .../bindings/display/ti/ti,am65x-dss.yaml          |     11 +
 .../bindings/display/ti/ti,j721e-dss.yaml          |     11 +
 .../devicetree/bindings/vendor-prefixes.yaml       |      6 +
 Documentation/driver-api/dma-buf.rst               |      9 +
 Documentation/gpu/drm-mm.rst                       |      4 +-
 Documentation/gpu/i915.rst                         |      6 +
 Documentation/gpu/todo.rst                         |     74 +-
 Documentation/gpu/vkms.rst                         |     99 +-
 MAINTAINERS                                        |     19 +-
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi        |      4 +
 drivers/dma-buf/dma-buf.c                          |     63 +-
 drivers/dma-buf/dma-resv.c                         |      2 +-
 drivers/dma-buf/heaps/heap-helpers.c               |     10 +-
 drivers/gpu/drm/Kconfig                            |     12 +-
 drivers/gpu/drm/Makefile                           |      1 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |     13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |     68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |     26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |     14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |     27 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |      3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |      2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |     47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |      7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |     34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |     11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c            |      3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |      4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |     52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |     52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h             |      6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    404 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |      2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |     49 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h        |      2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    122 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |     11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c |    141 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.h |     30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |      4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    134 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h            |      5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |     41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |     43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |      7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |      4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |     29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |      2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |     35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |      8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    147 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |      3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |      4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    186 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |      8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c            |     10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c            |    523 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h            |     28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    125 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |     10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    191 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |     23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |     38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |     16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h          |     37 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |      4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |     21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |     24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    401 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |     35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |      7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |      7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |     19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    196 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |     30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vf_error.c       |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |     22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    293 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |     12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |      4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |      4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    112 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |     15 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c            |      1 +
 drivers/gpu/drm/amd/amdgpu/atom.c                  |     24 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |      9 -
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c          |      2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |      4 -
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |      2 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |     18 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |      4 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |      7 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |     10 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |      4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |      5 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |      3 -
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c               |      2 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |    180 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.h               |      9 -
 .../gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c |     54 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    339 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |      4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |     47 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h              |      1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |     29 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |     21 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |     19 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h           |     10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c           |     13 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h           |      2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |     10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |     10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    121 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |      4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |     11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |     33 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    255 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |      4 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             |      7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |      4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |      6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |      2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |      6 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |     18 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |    589 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.h            |     28 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |      2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |     21 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |     50 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |      4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |      4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c             |    341 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h             |     32 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |    159 +-
 drivers/gpu/drm/amd/amdgpu/nv.h                    |      2 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |     54 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |     56 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |      1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |     16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |     16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |     31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |     21 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |     53 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |      2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |     14 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |      2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         |      3 +
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c           |     77 +
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h           |     30 +
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c            |     77 +
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h            |     30 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |     78 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |      4 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |      4 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c              |      4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |     30 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |     10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |     21 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |     21 +-
 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c      |     50 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |     14 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |     19 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |      4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |    258 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |     12 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |      1 +
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |      4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |      2 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |     29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |     43 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |      2 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |      2 +
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |      2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |      3 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |      4 +-
 drivers/gpu/drm/amd/display/Kconfig                |     10 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   1289 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |     25 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |      4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |     43 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |      3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    132 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |     25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |      4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |     67 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |     17 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |    565 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |      5 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |      1 +
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |      4 +
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |      2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |      1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    257 +-
 .../amd/display/dc/bios/command_table_helper2.c    |      7 +-
 .../dc/bios/dce112/command_table_helper2_dce112.c  |     40 -
 .../dc/bios/dce112/command_table_helper2_dce112.h  |      3 -
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |     13 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |      8 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |     36 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |     32 +-
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |      3 +-
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |      7 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |     30 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |    174 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c        |     11 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h  |      1 +
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |     16 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |      9 +
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h       |      2 +
 .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c |    241 +
 .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.h |    164 +
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |    834 +
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h |     53 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    127 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |      4 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |     98 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |     17 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    151 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |     13 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |     45 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |      1 -
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |     12 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |     54 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |      5 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |     10 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     26 -
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     18 -
 drivers/gpu/drm/amd/display/dc/dc_link.h           |     12 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |     11 +-
 drivers/gpu/drm/amd/display/dc/dc_trace.h          |     39 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |     33 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |     20 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |      4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |      4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |     24 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |     51 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |     24 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |    309 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |     21 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h    |     16 +
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |     36 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |     82 -
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |      1 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    126 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h      |      4 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |      9 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |     31 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |     11 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |     11 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |      9 +-
 .../gpu/drm/amd/display/dc/dce60/dce60_resource.c  |      7 -
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |     13 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |      8 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |     26 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |      2 -
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    222 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |      1 -
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |     13 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |      1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |      5 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |     31 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |      3 +
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |     82 -
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |      8 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h  |      8 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h   |      6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |      4 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |      6 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h  |     18 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |     93 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h |      9 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |      2 +-
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |      2 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c   |     12 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h   |      4 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |     64 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |     11 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |      2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c  |    129 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h  |     36 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |      2 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |     19 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h |      2 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |      3 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |    342 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile      |      2 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c  |      1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h  |     83 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |     56 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h   |     23 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c    |     12 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c    |     54 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h    |      5 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h  |      3 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |    123 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h |     10 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  |      5 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c   |     56 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h   |      9 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |    109 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.h  |      3 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c   |     62 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h   |     38 +-
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile     |     47 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c    |     75 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h    |     65 +
 .../display/dc/dcn301/dcn301_dio_link_encoder.c    |    192 +
 .../display/dc/dcn301/dcn301_dio_link_encoder.h    |     82 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c  |     81 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.h  |     60 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.c   |     42 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.h   |     32 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.c    |    145 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.h    |     33 +
 .../drm/amd/display/dc/dcn301/dcn301_panel_cntl.c  |    218 +
 .../drm/amd/display/dc/dcn301/dcn301_panel_cntl.h  |     97 +
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   2055 +
 .../drm/amd/display/dc/dcn301/dcn301_resource.h    |     42 +
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile     |     46 +
 .../gpu/drm/amd/display/dc/dcn302/dcn302_dccg.h    |     41 +
 .../gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.c   |    233 +
 .../gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.h   |     35 +
 .../gpu/drm/amd/display/dc/dcn302/dcn302_init.c    |     39 +
 .../gpu/drm/amd/display/dc/dcn302/dcn302_init.h    |     33 +
 .../drm/amd/display/dc/dcn302/dcn302_resource.c    |   1567 +
 .../drm/amd/display/dc/dcn302/dcn302_resource.h    |     33 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |      4 +-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |     24 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |     42 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |     13 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |      2 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |      6 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |      2 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |     10 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |      4 -
 .../drm/amd/display/dc/dml/display_mode_structs.h  |      4 -
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |      7 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |      3 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |     24 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       |      6 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h       |      4 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |      5 +-
 .../amd/display/dc/gpio/dcn30/hw_factory_dcn30.c   |      2 +-
 .../amd/display/dc/gpio/dcn30/hw_factory_dcn30.h   |      2 +-
 .../amd/display/dc/gpio/dcn30/hw_translate_dcn30.c |      2 +-
 .../amd/display/dc/gpio/dcn30/hw_translate_dcn30.h |      2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |      7 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |      7 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |      3 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     11 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |     41 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |      7 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |      9 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |      2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |      4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h        |      6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |      5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |     86 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |      3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h    |      4 -
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |     19 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |      5 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |      2 -
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |      6 -
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |     15 +-
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h     |      1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |      2 -
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |     10 +-
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |      4 +-
 .../amd/display/dc/irq/dcn30/irq_service_dcn30.c   |      6 +-
 .../amd/display/dc/irq/dcn30/irq_service_dcn30.h   |      2 +-
 .../amd/display/dc/irq/dcn302/irq_service_dcn302.c |    344 +
 .../amd/display/dc/irq/dcn302/irq_service_dcn302.h |     33 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |     30 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |    121 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |      5 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |     23 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |      6 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c  |      5 -
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h  |      2 -
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  |      5 -
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h  |      1 -
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c |     55 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.h |     37 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c |     55 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.h |     37 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |     94 +-
 .../drm/amd/display/include/bios_parser_types.h    |      5 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     16 +-
 drivers/gpu/drm/amd/display/include/dal_types.h    |      2 +
 .../drm/amd/display/include/ddc_service_types.h    |      8 +-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |      1 +
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |      6 -
 .../amd/display/include/grph_object_ctrl_defs.h    |     13 +
 .../drm/amd/display/modules/color/color_gamma.c    |    124 +-
 .../drm/amd/display/modules/color/color_gamma.h    |      6 +-
 .../drm/amd/display/modules/freesync/freesync.c    |    159 +-
 .../amd/display/modules/hdcp/hdcp1_transition.c    |      2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |      2 +-
 .../drm/amd/display/modules/power/power_helpers.c  |      8 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |      2 +
 drivers/gpu/drm/amd/include/arct_ip_offset.h       |      4 +-
 .../amd/include/asic_reg/clk/clk_11_5_0_offset.h   |     50 +
 .../amd/include/asic_reg/clk/clk_11_5_0_sh_mask.h  |     70 +
 .../amd/include/asic_reg/dcn/dcn_3_0_1_offset.h    |  13271 ++
 .../amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h   |  53357 ++++++
 .../amd/include/asic_reg/dcn/dcn_3_0_2_offset.h    |  16159 ++
 .../amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h   |  62376 +++++++
 .../amd/include/asic_reg/gc/gc_10_3_0_default.h    |      1 +
 .../drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h |      2 +
 .../amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h    |     33 +
 .../drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h |      2 +-
 .../include/asic_reg/mmhub/mmhub_2_3_0_default.h   |   1253 +
 .../include/asic_reg/mmhub/mmhub_2_3_0_offset.h    |   2439 +
 .../include/asic_reg/mmhub/mmhub_2_3_0_sh_mask.h   |  10331 ++
 .../drm/amd/include/asic_reg/mp/mp_11_5_0_offset.h |    400 +
 .../amd/include/asic_reg/mp/mp_11_5_0_sh_mask.h    |    942 +
 .../amd/include/asic_reg/nbio/nbio_7_2_0_offset.h  |  31873 ++++
 .../amd/include/asic_reg/nbio/nbio_7_2_0_sh_mask.h | 152495 ++++++++++++++=
++++
 drivers/gpu/drm/amd/include/atombios.h             |     20 +-
 drivers/gpu/drm/amd/include/atomfirmware.h         |     64 +-
 .../drm/amd/include/dimgrey_cavefish_ip_offset.h   |   1049 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |      1 +
 drivers/gpu/drm/amd/include/navi10_ip_offset.h     |      2 +-
 drivers/gpu/drm/amd/include/navi12_ip_offset.h     |      2 +-
 drivers/gpu/drm/amd/include/navi14_ip_offset.h     |      2 +-
 .../gpu/drm/amd/include/sienna_cichlid_ip_offset.h |      2 +-
 drivers/gpu/drm/amd/include/vangogh_ip_offset.h    |   1516 +
 drivers/gpu/drm/amd/include/vega10_ip_offset.h     |     76 +-
 drivers/gpu/drm/amd/include/vega20_ip_offset.h     |      2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |      3 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |     21 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |     63 +-
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                 |     26 +-
 drivers/gpu/drm/amd/pm/inc/pp_thermal.h            |      4 +-
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h              |      3 +-
 drivers/gpu/drm/amd/pm/inc/smu10.h                 |     14 +-
 .../amd/pm/inc/smu11_driver_if_sienna_cichlid.h    |     28 +-
 .../gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h   |    245 +
 drivers/gpu/drm/amd/pm/inc/smu74_discrete.h        |      3 +-
 drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h            |      6 +
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |     74 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |     11 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h        |    123 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h       |    115 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |     19 +
 .../drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |     56 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |     14 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h |      8 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c    |      7 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |    207 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h    |     28 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c  |     24 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h |      6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h  |     66 +
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |    273 +-
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   |    188 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |     22 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |    737 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h    |     20 +
 .../drm/amd/pm/powerplay/hwmgr/smu7_powertune.c    |     34 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  |    114 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |      2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |     31 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |      2 +
 .../pm/powerplay/hwmgr/vega10_processpptables.c    |     90 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    |    131 +-
 .../pm/powerplay/hwmgr/vega12_processpptables.c    |      5 +-
 .../drm/amd/pm/powerplay/hwmgr/vega12_thermal.c    |     82 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    |     54 +-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c          |     18 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          |      2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    |      2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c  |     18 +-
 .../drm/amd/pm/powerplay/smumgr/iceland_smumgr.c   |      4 +-
 .../drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c |    359 +-
 .../drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h |      1 +
 .../gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c |      3 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c  |      1 +
 .../gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c |      2 +-
 .../drm/amd/pm/powerplay/smumgr/vega10_smumgr.c    |     15 +-
 .../drm/amd/pm/powerplay/smumgr/vega12_smumgr.c    |      3 +-
 .../drm/amd/pm/powerplay/smumgr/vega20_smumgr.c    |      6 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c |      5 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    236 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile        |      1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |    130 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    302 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    143 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |     94 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |    761 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h   |     35 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |    216 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |      3 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |     57 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |      4 +
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h        |      9 +-
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |      4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |     26 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |     16 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |      2 -
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |      2 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |      6 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |      2 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |     26 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |      2 +-
 drivers/gpu/drm/armada/armada_crtc.c               |     30 +-
 drivers/gpu/drm/armada/armada_drv.c                |     10 +-
 drivers/gpu/drm/armada/armada_gem.c                |     12 +-
 drivers/gpu/drm/armada/armada_gem.h                |      2 -
 drivers/gpu/drm/armada/armada_overlay.c            |      2 +-
 drivers/gpu/drm/aspeed/Kconfig                     |      1 +
 drivers/gpu/drm/aspeed/aspeed_gfx.h                |      2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |     80 +-
 drivers/gpu/drm/ast/ast_cursor.c                   |     27 +-
 drivers/gpu/drm/ast/ast_drv.c                      |      2 +-
 drivers/gpu/drm/ast/ast_drv.h                      |     10 +-
 drivers/gpu/drm/ast/ast_main.c                     |      7 +-
 drivers/gpu/drm/ast/ast_mode.c                     |     40 +-
 drivers/gpu/drm/ast/ast_tables.h                   |      6 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |     17 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |      2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |      7 +-
 drivers/gpu/drm/bochs/bochs_drv.c                  |      2 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |      1 -
 drivers/gpu/drm/bridge/Kconfig                     |     13 +
 drivers/gpu/drm/bridge/Makefile                    |      1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c     |      6 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |      9 +
 drivers/gpu/drm/bridge/analogix/Makefile           |      1 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |     88 -
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   1850 +
 drivers/gpu/drm/bridge/analogix/anx7625.h          |    390 +
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |   1002 +
 drivers/gpu/drm/bridge/lvds-codec.c                |     11 +-
 drivers/gpu/drm/bridge/sii902x.c                   |    100 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |      2 +-
 drivers/gpu/drm/bridge/tc358764.c                  |    107 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    146 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |      2 +-
 drivers/gpu/drm/drm_atomic.c                       |     39 +-
 drivers/gpu/drm/drm_atomic_helper.c                |     34 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |      2 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    144 +-
 drivers/gpu/drm/drm_blend.c                        |     13 +
 drivers/gpu/drm/drm_bridge_connector.c             |      2 +-
 drivers/gpu/drm/drm_client.c                       |     38 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |      4 +-
 drivers/gpu/drm/drm_connector.c                    |      8 +-
 drivers/gpu/drm/drm_crtc.c                         |     40 +
 drivers/gpu/drm/drm_crtc_internal.h                |      3 +
 drivers/gpu/drm/drm_dp_aux_dev.c                   |      2 +-
 drivers/gpu/drm/drm_dp_helper.c                    |    235 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |      4 +-
 drivers/gpu/drm/drm_drv.c                          |     17 +-
 drivers/gpu/drm/drm_edid.c                         |      6 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    276 +-
 drivers/gpu/drm/drm_file.c                         |      2 +
 drivers/gpu/drm/drm_fourcc.c                       |      1 +
 drivers/gpu/drm/drm_framebuffer.c                  |      2 +-
 drivers/gpu/drm/drm_gem.c                          |     84 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               |    100 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |     53 +-
 drivers/gpu/drm/drm_gem_ttm_helper.c               |     37 +
 drivers/gpu/drm/drm_gem_vram_helper.c              |    300 +-
 drivers/gpu/drm/drm_internal.h                     |     13 +-
 drivers/gpu/drm/drm_ioctl.c                        |      2 +-
 drivers/gpu/drm/drm_mode_object.c                  |      2 +-
 drivers/gpu/drm/drm_modes.c                        |      4 +-
 drivers/gpu/drm/drm_pci.c                          |      6 +-
 drivers/gpu/drm/drm_plane.c                        |     73 +
 drivers/gpu/drm/drm_prime.c                        |     37 +-
 drivers/gpu/drm/drm_scdc_helper.c                  |      2 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |     14 +-
 drivers/gpu/drm/drm_vblank.c                       |     15 +-
 drivers/gpu/drm/drm_vm.c                           |      3 -
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |     18 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |      5 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |     18 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |     27 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |      4 +
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |     78 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |      1 +
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |     16 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |     12 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |     31 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |      1 +
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |     23 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |      2 -
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |      1 +
 drivers/gpu/drm/exynos/exynos_hdmi.c               |      9 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |      8 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |      5 +-
 drivers/gpu/drm/gma500/accel_2d.c                  |    292 -
 drivers/gpu/drm/gma500/cdv_device.c                |      1 -
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |      7 +-
 drivers/gpu/drm/gma500/framebuffer.c               |    110 +-
 drivers/gpu/drm/gma500/gem.c                       |     22 +-
 drivers/gpu/drm/gma500/gem.h                       |      3 +
 drivers/gpu/drm/gma500/gtt.c                       |     52 +-
 drivers/gpu/drm/gma500/gtt.h                       |      3 -
 drivers/gpu/drm/gma500/mdfld_device.c              |      1 -
 drivers/gpu/drm/gma500/oaktrail_device.c           |      1 -
 drivers/gpu/drm/gma500/psb_device.c                |      1 -
 drivers/gpu/drm/gma500/psb_drv.c                   |     14 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |     11 -
 drivers/gpu/drm/hisilicon/hibmc/Makefile           |      2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |     93 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |     22 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |     33 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c    |     99 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |     42 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |     10 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h    |      2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |     79 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |     10 +-
 drivers/gpu/drm/i915/display/intel_atomic.h        |      3 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |    138 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.h  |      9 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |     58 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |     52 +-
 drivers/gpu/drm/i915/display/intel_color.c         |    124 +-
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |     13 +-
 drivers/gpu/drm/i915/display/intel_csr.c           |     12 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |   1009 +-
 drivers/gpu/drm/i915/display/intel_ddi.h           |     11 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   1718 +-
 drivers/gpu/drm/i915/display/intel_display.h       |     43 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |     39 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |    116 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |      3 +
 drivers/gpu/drm/i915/display/intel_display_types.h |    140 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |    798 +-
 drivers/gpu/drm/i915/display/intel_dp.h            |     23 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |      3 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |    554 +-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |     17 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |     40 +-
 drivers/gpu/drm/i915/display/intel_dpio_phy.c      |     23 +-
 drivers/gpu/drm/i915/display/intel_dpio_phy.h      |      2 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |    221 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |     28 +-
 drivers/gpu/drm/i915/display/intel_dsi.c           |      2 +-
 drivers/gpu/drm/i915/display/intel_dsi.h           |      1 +
 drivers/gpu/drm/i915/display/intel_fbc.c           |      7 +
 drivers/gpu/drm/i915/display/intel_gmbus.c         |     15 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |     89 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |     20 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c       |     64 +-
 drivers/gpu/drm/i915/display/intel_hotplug.h       |      3 +-
 drivers/gpu/drm/i915/display/intel_lspcon.c        |     97 +-
 drivers/gpu/drm/i915/display/intel_lspcon.h        |      5 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |     10 +
 drivers/gpu/drm/i915/display/intel_opregion.c      |      6 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |    249 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |     14 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |    235 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |      8 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |     13 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |    201 +-
 drivers/gpu/drm/i915/display/intel_vdsc.h          |      6 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |      8 +
 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |     18 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |     13 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |     23 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |     23 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |     19 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |     21 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |     55 +
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |     48 +
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |     18 +-
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   |     14 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |      6 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |     17 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |     42 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |      6 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |     37 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |      6 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |     11 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c                |     10 +-
 drivers/gpu/drm/i915/gt/intel_gtt.h                |      2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |    129 +-
 drivers/gpu/drm/i915/gt/intel_lrc.h                |      4 -
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |      3 +
 drivers/gpu/drm/i915/gt/intel_mocs.c               |     50 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |     22 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |      8 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |      1 +
 drivers/gpu/drm/i915/gt/intel_rps.c                |     58 +-
 drivers/gpu/drm/i915/gt/intel_sseu.c               |      2 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |    143 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |     29 +-
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |     13 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c             |      8 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |    378 +-
 drivers/gpu/drm/i915/gt/sysfs_engines.c            |     10 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |     24 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c         |    132 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c          |      1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |     31 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fwif.h        |     80 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h         |      5 +
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |      6 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |     28 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |      2 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw_abi.h       |      6 +-
 drivers/gpu/drm/i915/gvt/display.c                 |    194 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |     64 +
 drivers/gpu/drm/i915/gvt/gtt.h                     |      4 +
 drivers/gpu/drm/i915/gvt/gvt.c                     |     13 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |      7 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |     58 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |      2 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |      5 +
 drivers/gpu/drm/i915/gvt/mmio.h                    |      4 +
 drivers/gpu/drm/i915/gvt/mpt.h                     |      2 +-
 drivers/gpu/drm/i915/gvt/reg.h                     |      4 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |      2 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |     67 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |      5 +-
 drivers/gpu/drm/i915/i915_drv.c                    |     74 +-
 drivers/gpu/drm/i915/i915_drv.h                    |     17 +-
 drivers/gpu/drm/i915/i915_gem.c                    |     32 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |      2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |     68 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |     10 +-
 drivers/gpu/drm/i915/i915_irq.c                    |    810 +-
 drivers/gpu/drm/i915/i915_irq.h                    |      3 +
 drivers/gpu/drm/i915/i915_pci.c                    |     28 +-
 drivers/gpu/drm/i915/i915_perf.c                   |     17 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |     96 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |     10 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    468 +-
 drivers/gpu/drm/i915/i915_scatterlist.h            |     19 +-
 drivers/gpu/drm/i915/i915_suspend.c                |     80 +-
 drivers/gpu/drm/i915/i915_suspend.h                |      4 +-
 drivers/gpu/drm/i915/intel_device_info.c           |      1 +
 drivers/gpu/drm/i915/intel_device_info.h           |      1 +
 drivers/gpu/drm/i915/intel_dram.c                  |     23 +-
 drivers/gpu/drm/i915/intel_gvt.c                   |     15 +
 drivers/gpu/drm/i915/intel_gvt.h                   |      5 +
 drivers/gpu/drm/i915/intel_memory_region.c         |      2 +-
 drivers/gpu/drm/i915/intel_pch.c                   |      6 +-
 drivers/gpu/drm/i915/intel_pm.c                    |    322 +-
 drivers/gpu/drm/i915/intel_pm.h                    |      2 -
 drivers/gpu/drm/i915/intel_sideband.c              |     15 +
 drivers/gpu/drm/i915/intel_sideband.h              |      2 +
 drivers/gpu/drm/i915/intel_uncore.c                |    207 +-
 drivers/gpu/drm/i915/intel_uncore.h                |      4 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |      5 +-
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |     13 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |     16 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |      2 -
 drivers/gpu/drm/imx/imx-drm-core.c                 |      2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |     16 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    311 +-
 drivers/gpu/drm/ingenic/ingenic-drm.h              |      3 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |     23 +-
 drivers/gpu/drm/kmb/Kconfig                        |     13 +
 drivers/gpu/drm/kmb/Makefile                       |      2 +
 drivers/gpu/drm/kmb/kmb_crtc.c                     |    214 +
 drivers/gpu/drm/kmb/kmb_drv.c                      |    602 +
 drivers/gpu/drm/kmb/kmb_drv.h                      |     88 +
 drivers/gpu/drm/kmb/kmb_dsi.c                      |   1561 +
 drivers/gpu/drm/kmb/kmb_dsi.h                      |    387 +
 drivers/gpu/drm/kmb/kmb_plane.c                    |    522 +
 drivers/gpu/drm/kmb/kmb_plane.h                    |     67 +
 drivers/gpu/drm/kmb/kmb_regs.h                     |    725 +
 drivers/gpu/drm/lima/lima_devfreq.c                |     13 +-
 drivers/gpu/drm/lima/lima_devfreq.h                |      1 -
 drivers/gpu/drm/lima/lima_drv.c                    |      4 +-
 drivers/gpu/drm/lima/lima_gem.c                    |      6 +-
 drivers/gpu/drm/lima/lima_sched.c                  |     14 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |      6 +-
 drivers/gpu/drm/mediatek/Kconfig                   |      1 +
 drivers/gpu/drm/mediatek/Makefile                  |      3 -
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |     12 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |      5 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |      5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |      9 -
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |     27 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |     47 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |      2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |     39 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |      3 -
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |     31 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.h             |      4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |     27 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |     12 +-
 drivers/gpu/drm/meson/meson_drv.c                  |     14 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |     13 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |      8 +-
 drivers/gpu/drm/meson/meson_venc.c                 |      4 +-
 drivers/gpu/drm/mga/mga_dma.c                      |     10 +-
 drivers/gpu/drm/mga/mga_state.c                    |      2 -
 drivers/gpu/drm/mgag200/mgag200_drv.c              |      2 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |     15 +-
 drivers/gpu/drm/msm/Kconfig                        |      2 +-
 drivers/gpu/drm/msm/Makefile                       |      1 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |     21 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |     20 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |     33 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |     18 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |      4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |    132 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |      5 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |      6 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |      6 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |     49 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |     26 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |     38 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |     27 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |      4 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |     27 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |      2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_blk.c         |      2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |    154 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |     18 +
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h  |     88 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |     56 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |     37 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c        |      3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |     11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |      2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |      8 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c     |     94 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h     |     68 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |      1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |      4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |     22 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |      1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |     47 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |      2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |     34 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |      1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |      2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |     11 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |      8 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |     28 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c           |     11 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |     15 +-
 drivers/gpu/drm/msm/disp/mdp_kms.h                 |      9 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c                |     14 +-
 drivers/gpu/drm/msm/dp/dp_catalog.h                |      1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |    434 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |    272 +-
 drivers/gpu/drm/msm/dp/dp_link.c                   |     41 +-
 drivers/gpu/drm/msm/dp/dp_link.h                   |      1 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |      5 +
 drivers/gpu/drm/msm/dp/dp_power.c                  |     44 +-
 drivers/gpu/drm/msm/dp/dp_power.h                  |      2 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |      2 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |     11 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |     22 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |     23 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |      8 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c         |      5 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c          |      8 +
 drivers/gpu/drm/msm/msm_atomic.c                   |     62 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |     10 +-
 drivers/gpu/drm/msm/msm_drv.c                      |     51 +-
 drivers/gpu/drm/msm/msm_drv.h                      |     90 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |      1 +
 drivers/gpu/drm/msm/msm_gem.c                      |    352 +-
 drivers/gpu/drm/msm/msm_gem.h                      |    137 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |     13 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |    123 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |    157 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    167 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |     25 +-
 drivers/gpu/drm/msm/msm_kms.h                      |     33 +-
 drivers/gpu/drm/msm/msm_rd.c                       |      2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |      3 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |     13 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |      2 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |     24 +-
 drivers/gpu/drm/nouveau/Kconfig                    |      1 +
 drivers/gpu/drm/nouveau/dispnv50/head.c            |     11 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    341 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h               |      6 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |      2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |     14 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |      1 -
 drivers/gpu/drm/nouveau/nouveau_gem.c              |     16 +-
 drivers/gpu/drm/nouveau/nouveau_gem.h              |      4 +-
 drivers/gpu/drm/nouveau/nouveau_mem.c              |      8 +-
 drivers/gpu/drm/nouveau/nouveau_mem.h              |      4 +-
 drivers/gpu/drm/nouveau/nouveau_prime.c            |     22 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |     19 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |     34 +-
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       |      9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c     |      1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c    |      3 -
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c   |      1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c    |      1 -
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |      2 +-
 drivers/gpu/drm/omapdrm/dss/Kconfig                |      4 +-
 drivers/gpu/drm/omapdrm/dss/base.c                 |      2 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |      7 +-
 drivers/gpu/drm/omapdrm/dss/dispc.h                |      2 +-
 drivers/gpu/drm/omapdrm/dss/dispc_coefs.c          |      2 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |     16 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |      7 +-
 drivers/gpu/drm/omapdrm/dss/hdmi.h                 |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |      8 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c            |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.h           |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |      8 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c           |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.h           |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c             |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c             |      2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c              |      2 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |      2 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |      2 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |      2 +-
 drivers/gpu/drm/omapdrm/dss/pll.c                  |      2 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |      7 +-
 drivers/gpu/drm/omapdrm/dss/video-pll.c            |      2 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |      2 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |     23 +-
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |      2 +-
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h            |      2 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |      9 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.h           |      2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |     13 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |      2 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |      2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |      2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |      2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |     23 +-
 drivers/gpu/drm/omapdrm/omap_gem.h                 |      2 -
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |      2 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |      8 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |      2 +-
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |      2 +-
 drivers/gpu/drm/panel/Kconfig                      |     42 +
 drivers/gpu/drm/panel/Makefile                     |      4 +
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c       |    363 +
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |      2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     |    711 +
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |     20 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |     14 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |      7 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |      2 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c  |     40 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |      9 +
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |    351 +
 drivers/gpu/drm/panel/panel-simple.c               |     37 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |      2 +-
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c       |    250 +
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |      7 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |      3 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |      7 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |     11 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |      7 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |      4 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |      2 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |    182 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |      1 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |     14 +-
 drivers/gpu/drm/pl111/pl111_debugfs.c              |      2 +-
 drivers/gpu/drm/pl111/pl111_display.c              |      2 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |      6 +-
 drivers/gpu/drm/qxl/qxl_debugfs.c                  |      2 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |     28 +-
 drivers/gpu/drm/qxl/qxl_draw.c                     |     14 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |     30 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |      5 +-
 drivers/gpu/drm/qxl/qxl_kms.c                      |      4 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |    103 +-
 drivers/gpu/drm/qxl/qxl_object.h                   |     27 +-
 drivers/gpu/drm/qxl/qxl_prime.c                    |     12 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |      4 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    113 +-
 drivers/gpu/drm/r128/ati_pcigart.c                 |      2 +-
 drivers/gpu/drm/radeon/atom.h                      |      7 +
 drivers/gpu/drm/radeon/atombios_crtc.c             |      1 -
 drivers/gpu/drm/radeon/atombios_encoders.c         |      5 +-
 drivers/gpu/drm/radeon/btc_dpm.c                   |      6 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |     27 +-
 drivers/gpu/drm/radeon/cik.c                       |     33 +-
 drivers/gpu/drm/radeon/cik.h                       |     40 +
 drivers/gpu/drm/radeon/cik_sdma.c                  |      7 +-
 drivers/gpu/drm/radeon/cypress_dpm.c               |      6 +-
 drivers/gpu/drm/radeon/dce6_afmt.c                 |      1 +
 drivers/gpu/drm/radeon/dce6_afmt.h                 |     52 +
 drivers/gpu/drm/radeon/evergreen.c                 |     21 +-
 drivers/gpu/drm/radeon/evergreen.h                 |     53 +
 drivers/gpu/drm/radeon/evergreen_cs.c              |      9 +-
 drivers/gpu/drm/radeon/evergreen_dma.c             |      5 +-
 drivers/gpu/drm/radeon/evergreen_hdmi.c            |      1 +
 drivers/gpu/drm/radeon/evergreen_hdmi.h            |     69 +
 drivers/gpu/drm/radeon/kv_dpm.c                    |    205 +-
 drivers/gpu/drm/radeon/ni.c                        |     25 +-
 drivers/gpu/drm/radeon/ni.h                        |     37 +
 drivers/gpu/drm/radeon/ni_dma.c                    |      3 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |      5 +-
 drivers/gpu/drm/radeon/ni_dpm.h                    |      3 +
 drivers/gpu/drm/radeon/r100.c                      |      7 +-
 drivers/gpu/drm/radeon/r300.c                      |      1 +
 drivers/gpu/drm/radeon/r600.c                      |     15 +-
 drivers/gpu/drm/radeon/r600.h                      |     58 +
 drivers/gpu/drm/radeon/r600_cs.c                   |     10 +-
 drivers/gpu/drm/radeon/r600_dma.c                  |      3 +-
 drivers/gpu/drm/radeon/r600_hdmi.c                 |      1 +
 drivers/gpu/drm/radeon/radeon.h                    |     10 +-
 drivers/gpu/drm/radeon/radeon_acpi.c               |      3 +-
 drivers/gpu/drm/radeon/radeon_asic.c               |      1 +
 drivers/gpu/drm/radeon/radeon_asic.h               |      1 +
 drivers/gpu/drm/radeon/radeon_atombios.c           |     11 +-
 drivers/gpu/drm/radeon/radeon_atombios.h           |     45 +
 drivers/gpu/drm/radeon/radeon_audio.c              |     68 +-
 drivers/gpu/drm/radeon/radeon_audio.h              |     12 +
 drivers/gpu/drm/radeon/radeon_combios.c            |      6 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |      4 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |     12 +-
 drivers/gpu/drm/radeon/radeon_device.c             |     28 +-
 drivers/gpu/drm/radeon/radeon_device.h             |     32 +
 drivers/gpu/drm/radeon/radeon_display.c            |     31 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |     16 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |    137 +-
 drivers/gpu/drm/radeon/radeon_drv.h                |      7 +
 drivers/gpu/drm/radeon/radeon_encoders.c           |     10 +-
 drivers/gpu/drm/radeon/radeon_fence.c              |      6 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |     31 +-
 drivers/gpu/drm/radeon/radeon_i2c.c                |      8 -
 drivers/gpu/drm/radeon/radeon_ib.c                 |      1 +
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |      9 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |     53 +-
 drivers/gpu/drm/radeon/radeon_kms.h                |     39 +
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |      1 +
 drivers/gpu/drm/radeon/radeon_legacy_encoders.h    |     36 +
 drivers/gpu/drm/radeon/radeon_mn.c                 |      1 +
 drivers/gpu/drm/radeon/radeon_object.c             |    129 +-
 drivers/gpu/drm/radeon/radeon_object.h             |      7 +-
 drivers/gpu/drm/radeon/radeon_pm.c                 |     30 +-
 drivers/gpu/drm/radeon/radeon_pm.h                 |     29 +
 drivers/gpu/drm/radeon/radeon_prime.c              |     21 +-
 drivers/gpu/drm/radeon/radeon_prime.h              |     40 +
 drivers/gpu/drm/radeon/radeon_ring.c               |      3 +
 drivers/gpu/drm/radeon/radeon_sync.c               |      1 +
 drivers/gpu/drm/radeon/radeon_ttm.c                |    298 +-
 drivers/gpu/drm/radeon/radeon_ttm.h                |     37 +
 drivers/gpu/drm/radeon/radeon_vm.c                 |      8 +-
 drivers/gpu/drm/radeon/rv730_dpm.c                 |      4 +-
 drivers/gpu/drm/radeon/rv740_dpm.c                 |      3 +-
 drivers/gpu/drm/radeon/rv770.c                     |      1 +
 drivers/gpu/drm/radeon/rv770.h                     |     39 +
 drivers/gpu/drm/radeon/rv770_dpm.c                 |      2 +
 drivers/gpu/drm/radeon/si.c                        |     15 +-
 drivers/gpu/drm/radeon/si.h                        |     38 +
 drivers/gpu/drm/radeon/si_dma.c                    |      3 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |     15 +-
 drivers/gpu/drm/radeon/si_dpm.h                    |      5 +
 drivers/gpu/drm/radeon/sumo_dpm.c                  |     20 +
 drivers/gpu/drm/radeon/sumo_dpm.h                  |      1 +
 drivers/gpu/drm/radeon/sumo_smc.c                  |      2 -
 drivers/gpu/drm/radeon/trinity_dpm.c               |     46 +-
 drivers/gpu/drm/radeon/vce.h                       |     35 +
 drivers/gpu/drm/radeon/vce_v1_0.c                  |      1 +
 drivers/gpu/drm/radeon/vce_v2_0.c                  |      1 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |     21 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |      2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |      4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |      9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |     35 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h        |      4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |     24 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |      2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |      1 +
 drivers/gpu/drm/savage/savage_bci.c                |     11 -
 drivers/gpu/drm/scheduler/sched_entity.c           |      7 +-
 drivers/gpu/drm/scheduler/sched_main.c             |      3 +-
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c |     40 +-
 drivers/gpu/drm/selftests/test-drm_framebuffer.c   |      3 +-
 drivers/gpu/drm/selftests/test-drm_mm.c            |      2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c           |      2 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |      6 +-
 drivers/gpu/drm/sti/sti_drv.c                      |      2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |      6 +
 drivers/gpu/drm/sti/sti_hdmi.h                     |      6 -
 drivers/gpu/drm/stm/drv.c                          |      2 +-
 drivers/gpu/drm/stm/ltdc.c                         |      6 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |     17 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |      2 +-
 drivers/gpu/drm/tegra/dc.c                         |     20 +-
 drivers/gpu/drm/tegra/drm.c                        |      9 +-
 drivers/gpu/drm/tegra/gem.c                        |     31 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |     20 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |      9 +-
 drivers/gpu/drm/tidss/tidss_drv.c                  |      2 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |      2 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |     70 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |     46 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |      7 +-
 drivers/gpu/drm/tiny/cirrus.c                      |     12 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |     68 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |      2 +-
 drivers/gpu/drm/tiny/ili9225.c                     |      2 +-
 drivers/gpu/drm/tiny/ili9341.c                     |      2 +-
 drivers/gpu/drm/tiny/ili9486.c                     |      2 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |      2 +-
 drivers/gpu/drm/tiny/repaper.c                     |      2 +-
 drivers/gpu/drm/tiny/st7586.c                      |      2 +-
 drivers/gpu/drm/tiny/st7735r.c                     |      2 +-
 drivers/gpu/drm/ttm/Makefile                       |      5 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |      5 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    290 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    175 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |     43 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |     13 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |   1189 -
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |   1239 -
 drivers/gpu/drm/ttm/ttm_pool.c                     |    667 +
 drivers/gpu/drm/ttm/ttm_range_manager.c            |      4 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |     12 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |    260 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |      6 +-
 drivers/gpu/drm/udl/udl_connector.c                |      8 +-
 drivers/gpu/drm/udl/udl_drv.c                      |      5 +-
 drivers/gpu/drm/udl/udl_drv.h                      |      6 +-
 drivers/gpu/drm/udl/udl_main.c                     |     23 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |     12 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |     38 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |      2 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |      2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |      4 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |     17 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |     28 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |     19 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |      4 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |     12 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |      6 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |     25 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |      3 +-
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h                |      6 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |      4 +-
 drivers/gpu/drm/vc4/vc4_perfmon.c                  |      2 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |     19 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |      4 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |     39 +-
 drivers/gpu/drm/vgem/vgem_fence.c                  |      2 +-
 drivers/gpu/drm/via/via_dma.c                      |      2 -
 drivers/gpu/drm/via/via_mm.c                       |      2 +-
 drivers/gpu/drm/virtio/Makefile                    |      2 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |     26 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |     12 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |      6 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |     79 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    185 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |     34 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |     42 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |     23 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |     48 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |    154 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c              |    164 +
 drivers/gpu/drm/vkms/Makefile                      |      1 -
 drivers/gpu/drm/vkms/vkms_composer.c               |     17 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |     24 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |     32 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |     29 -
 drivers/gpu/drm/vkms/vkms_gem.c                    |    248 -
 drivers/gpu/drm/vkms/vkms_plane.c                  |     12 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |     17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |      8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |     95 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |      6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |      4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |     34 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |     12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |      2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |      2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |      8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |      6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |      4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         |      2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |      6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |      8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |      4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |      4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c                |      2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |    232 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |      2 +-
 drivers/gpu/drm/xen/xen_drm_front.c                |     46 +-
 drivers/gpu/drm/xen/xen_drm_front.h                |      2 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |     33 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.h            |      6 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |     18 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |     16 +-
 drivers/gpu/drm/zte/zx_drm_drv.c                   |      2 +-
 drivers/gpu/drm/zte/zx_vou.c                       |      6 +-
 drivers/gpu/host1x/bus.c                           |      1 +
 drivers/gpu/vga/vga_switcheroo.c                   |      7 +-
 drivers/iommu/io-pgtable-arm.c                     |     21 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |     17 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |     19 +-
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |     21 +-
 drivers/misc/fastrpc.c                             |      6 +-
 drivers/phy/mediatek/Kconfig                       |      7 +
 drivers/phy/mediatek/Makefile                      |      5 +
 .../mediatek/phy-mtk-mipi-dsi-mt8173.c}            |      2 +-
 .../mediatek/phy-mtk-mipi-dsi-mt8183.c}            |      2 +-
 .../mediatek/phy-mtk-mipi-dsi.c}                   |      5 +-
 .../mediatek/phy-mtk-mipi-dsi.h}                   |      0
 drivers/usb/misc/sisusbvga/sisusb_con.c            |     21 -
 drivers/video/console/dummycon.c                   |     20 -
 drivers/video/console/sticore.c                    |     10 +-
 drivers/video/fbdev/atafb.c                        |      8 -
 drivers/video/fbdev/atmel_lcdfb.c                  |      2 +-
 drivers/video/fbdev/aty/radeon_base.c              |      4 +-
 drivers/video/fbdev/cirrusfb.c                     |      3 +-
 drivers/video/fbdev/core/bitblit.c                 |      3 -
 drivers/video/fbdev/core/fbcmap.c                  |      2 +-
 drivers/video/fbdev/core/fbcon.c                   |    113 +-
 drivers/video/fbdev/core/fbcon_ccw.c               |      1 -
 drivers/video/fbdev/core/fbcon_cw.c                |      1 -
 drivers/video/fbdev/core/fbcon_rotate.c            |      4 +-
 drivers/video/fbdev/core/fbcon_ud.c                |      1 -
 drivers/video/fbdev/core/fbmem.c                   |     49 +-
 drivers/video/fbdev/core/softcursor.c              |      2 -
 drivers/video/fbdev/core/tileblit.c                |      6 +-
 drivers/video/fbdev/fsl-diu-fb.c                   |      3 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |      8 +-
 drivers/video/fbdev/mx3fb.c                        |      2 -
 drivers/video/fbdev/nvidia/nv_of.c                 |      3 +-
 .../omap2/omapfb/displays/connector-analog-tv.c    |      7 +-
 .../fbdev/omap2/omapfb/displays/connector-dvi.c    |      7 +-
 .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |      7 +-
 .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |      7 +-
 .../omapfb/displays/panel-sharp-ls037v7dw01.c      |      7 +-
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |      7 +-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |      7 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |     10 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c  |     10 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c    |     10 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c    |     16 +-
 drivers/video/fbdev/omap2/omapfb/dss/venc.c        |      6 +-
 drivers/video/fbdev/omap2/omapfb/dss/video-pll.c   |     20 +-
 drivers/video/fbdev/riva/riva_hw.c                 |     14 +-
 drivers/video/fbdev/sbuslib.c                      |    124 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |      7 +-
 drivers/video/fbdev/sis/300vtbl.h                  |      2 -
 drivers/video/fbdev/sis/sis_accel.h                |     14 +-
 drivers/video/hdmi.c                               |     11 +-
 include/drm/amd_asic_type.h                        |      2 +
 include/drm/drm_atomic.h                           |     16 +-
 include/drm/drm_atomic_helper.h                    |      4 +-
 include/drm/drm_client.h                           |      7 +-
 include/drm/drm_connector.h                        |      2 +-
 include/drm/drm_crtc.h                             |     26 +
 include/drm/drm_device.h                           |      6 +-
 include/drm/drm_dp_helper.h                        |    134 +-
 include/drm/drm_drv.h                              |     92 +-
 include/drm/drm_dsc.h                              |      3 +-
 include/drm/drm_encoder.h                          |      1 -
 include/drm/drm_gem.h                              |      7 +-
 include/drm/drm_gem_cma_helper.h                   |      8 +-
 include/drm/drm_gem_shmem_helper.h                 |      4 +-
 include/drm/drm_gem_ttm_helper.h                   |      6 +
 include/drm/drm_gem_vram_helper.h                  |     25 +-
 include/drm/drm_mode_config.h                      |     25 +-
 include/drm/drm_modeset_helper_vtables.h           |     22 +-
 include/drm/drm_plane.h                            |     21 +
 include/drm/drm_prime.h                            |      5 +-
 include/drm/i915_pciids.h                          |    152 +-
 include/drm/ttm/ttm_bo_api.h                       |    126 +-
 include/drm/ttm/ttm_bo_driver.h                    |    114 +-
 include/drm/ttm/ttm_caching.h                      |     36 +
 include/drm/ttm/ttm_page_alloc.h                   |    122 -
 include/drm/ttm/ttm_placement.h                    |     15 -
 include/drm/ttm/ttm_pool.h                         |     91 +
 include/drm/ttm/ttm_resource.h                     |     12 +-
 include/drm/ttm/ttm_set_memory.h                   |    150 -
 include/drm/ttm/ttm_tt.h                           |     82 +-
 include/linux/console.h                            |      1 -
 include/linux/dma-buf-map.h                        |    266 +
 include/linux/dma-buf.h                            |     18 +-
 include/linux/font.h                               |      3 +-
 include/linux/io-pgtable.h                         |      8 +
 include/linux/iommu.h                              |      1 +
 include/linux/platform_data/shmob_drm.h            |      2 -
 include/linux/scatterlist.h                        |      6 -
 include/uapi/drm/amdgpu_drm.h                      |      6 +-
 include/uapi/drm/drm_fourcc.h                      |    175 +-
 include/uapi/drm/drm_mode.h                        |      6 +
 include/uapi/drm/virtgpu_drm.h                     |     39 +-
 include/uapi/linux/kd.h                            |      2 +-
 include/uapi/linux/media-bus-format.h              |      3 +-
 include/uapi/linux/virtio_gpu.h                    |     78 +
 lib/fonts/font_10x18.c                             |      1 +
 lib/fonts/font_6x10.c                              |      1 +
 lib/fonts/font_6x11.c                              |      1 +
 lib/fonts/font_6x8.c                               |      1 +
 lib/fonts/font_7x14.c                              |      1 +
 lib/fonts/font_8x16.c                              |      1 +
 lib/fonts/font_8x8.c                               |      1 +
 lib/fonts/font_acorn_8x8.c                         |      1 +
 lib/fonts/font_mini_4x6.c                          |      1 +
 lib/fonts/font_pearl_8x8.c                         |      1 +
 lib/fonts/font_sun12x22.c                          |      1 +
 lib/fonts/font_sun8x16.c                           |      1 +
 lib/fonts/font_ter16x32.c                          |      1 +
 tools/testing/scatterlist/main.c                   |      2 +-
 1332 files changed, 397519 insertions(+), 18785 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 create mode 100644
Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
 create mode 100644
Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
 create mode 100755 drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_sm=
u.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_sm=
u.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mg=
r.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mg=
r.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_trace.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_5_0_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_5_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_3_0_default.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_3_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_3_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_5_0_offse=
t.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_5_0_sh_ma=
sk.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_2_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_2_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.=
h
 create mode 100644 drivers/gpu/drm/amd/include/vangogh_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611uxc.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
 create mode 100644 drivers/gpu/drm/kmb/Kconfig
 create mode 100644 drivers/gpu/drm/kmb/Makefile
 create mode 100644 drivers/gpu/drm/kmb/kmb_crtc.c
 create mode 100644 drivers/gpu/drm/kmb/kmb_drv.c
 create mode 100644 drivers/gpu/drm/kmb/kmb_drv.h
 create mode 100644 drivers/gpu/drm/kmb/kmb_dsi.c
 create mode 100644 drivers/gpu/drm/kmb/kmb_dsi.h
 create mode 100644 drivers/gpu/drm/kmb/kmb_plane.c
 create mode 100644 drivers/gpu/drm/kmb/kmb_plane.h
 create mode 100644 drivers/gpu/drm/kmb/kmb_regs.h
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h
 create mode 100644 drivers/gpu/drm/panel/panel-abt-y030xx067a.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36672a.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-sofef00.c
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
 create mode 100644 drivers/gpu/drm/radeon/cik.h
 create mode 100644 drivers/gpu/drm/radeon/dce6_afmt.h
 create mode 100644 drivers/gpu/drm/radeon/evergreen.h
 create mode 100644 drivers/gpu/drm/radeon/evergreen_hdmi.h
 create mode 100644 drivers/gpu/drm/radeon/ni.h
 create mode 100644 drivers/gpu/drm/radeon/r600.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_atombios.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_device.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_kms.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_legacy_encoders.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_pm.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_prime.h
 create mode 100644 drivers/gpu/drm/radeon/radeon_ttm.h
 create mode 100644 drivers/gpu/drm/radeon/rv770.h
 create mode 100644 drivers/gpu/drm/radeon/si.h
 create mode 100644 drivers/gpu/drm/radeon/vce.h
 delete mode 100644 drivers/gpu/drm/ttm/ttm_page_alloc.c
 delete mode 100644 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
 create mode 100644 drivers/gpu/drm/ttm/ttm_pool.c
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_vram.c
 delete mode 100644 drivers/gpu/drm/vkms/vkms_gem.c
 rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c =3D>
phy/mediatek/phy-mtk-mipi-dsi-mt8173.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c =3D>
phy/mediatek/phy-mtk-mipi-dsi-mt8183.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c =3D>
phy/mediatek/phy-mtk-mipi-dsi.c} (97%)
 rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h =3D>
phy/mediatek/phy-mtk-mipi-dsi.h} (100%)
 create mode 100644 include/drm/ttm/ttm_caching.h
 delete mode 100644 include/drm/ttm/ttm_page_alloc.h
 create mode 100644 include/drm/ttm/ttm_pool.h
 delete mode 100644 include/drm/ttm/ttm_set_memory.h
 create mode 100644 include/linux/dma-buf-map.h
