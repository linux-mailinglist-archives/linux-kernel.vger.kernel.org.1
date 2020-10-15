Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243C828EA26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgJOBdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgJOBdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:33:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D836C0613B3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:33:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qp15so1246737ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mAr0fUouMC/7EHq5GuG9nqtr1Acfkvpsl4AB48v70Ms=;
        b=t2ckOjETOL0pImJV6vqcpO6ZqbmgQg2PN+2hHsOX5WiJLLcLiuYkYrC5As5z3hbjwO
         VisHoHJOwWUUPHtySd03fbj4sajibcad9zIMAM9oz/BFDXH+V8qXtHVoKEgIfJTde/mM
         FjT3Ba6Dyh6NHWHgFLj2TBTEdcFUDal0yKsbxy99lGkST+3Rlm4HSdRn/bM3flhUjfFB
         I5UkKaw7if1bXxyy+6D+/PN8LvpL7CjAd3NGIHmvkmBA8vrVozXa7UvNJEwlyLC9HBVn
         Sxg+KrxP6N7+hl8CPHVHSeGII/cVB05GX/4lKDfxiU4oVC3i3oiUouKtz4cfXC4EOynu
         bT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mAr0fUouMC/7EHq5GuG9nqtr1Acfkvpsl4AB48v70Ms=;
        b=cXrBdVP7dwXMtjWdZUWU+0Vr8s7a0B/DILrUhkOiFo+qGz8u0f+U4lnwPQaakHd3iV
         wFc3MBkpJ6kphXXYh6sB4/0oZX15SJwPfj2ut/kq43Uyl2hHXoA806jUxXbaLoVNPHXL
         TnbXD77EgBTecux0jI6G179kTAapKRFPXeITpzUzCApBm9NxhJZqVdXgADc/+vQ4bNUV
         SBwyFQcawU47Z7f3sw3iX6AzlE6qA9vj/07OYg+oxZuy+9ygKp4M6BAK7Cs/CnlxqRn/
         TL1zoO0Q8FsUOn0YAkIQx/xKCrUE1kNXOSLo3k8fsuSlHLIPesKwV8bRT4f8VjsDA0S+
         fl5Q==
X-Gm-Message-State: AOAM532Qd/Mj+EoEZrdneLKlAR0qUadmV3f2mDg2PEPpuAC+CRDiOD5c
        Lwt9q9dygblgwn0kAHEJ0X7KiRHjYw8hE8mygqhvSi5wKC8=
X-Google-Smtp-Source: ABdhPJz17mUVu/svO0mAiEVUsiMrFbY873qwANKT70pHcuRjqWNvlUeFXo+0eYBlBbyJZlKl8bmODZEVzAKOKpafgrs=
X-Received: by 2002:a17:906:3bc9:: with SMTP id v9mr1925824ejf.340.1602725600563;
 Wed, 14 Oct 2020 18:33:20 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 15 Oct 2020 11:33:08 +1000
Message-ID: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
Subject: [git pull] drm next pull for 5.10-rc1
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

This is the main drm pull request for 5.10.

Not a major amount of change, the i915 trees got split into display
and gt trees to better facilitate higher level review, and there's a
major refactoring of i915 GEM locking to use more core kernel concepts
(like ww-mutexes). msm gets per-process pagetables, older AMD SI cards
get DC support, nouveau got a bump in displayport support with common
code extraction from i915.

There are a bunch of conflicts but none of them seemed overly scary,
and sfr has provided resolutions for them all. I've put a tree up with
my merge results, so you can tell me I did it wrong here:
https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-next-5.10-merged

Outside of drm:
It contains a couple of patches for hexint moduleparams which you've acked.
It contains a virtio common code tree that you should also get via
it's regular path but I don't see that in your tree yet, feel free to
hold off on merging this until that comes in, I'm sending this today
as I'm on a mandatory company holiday tomorrow. (will be around for
anything urgent).

Dave.

drm-next-2020-10-15:
drm next for 5.10-rc1

New driver:
Cadence MHDP8546 DisplayPort bridge driver

core:
- cross-driver scatterlist cleanups
- devm_drm conversions
- remove drm_dev_init
- devm_drm_dev_alloc conversion

ttm:
- lots of refactoring and cleanups

bridges:
- chained bridge support in more drivers

panel:
- misc new panels

scheduler:
- cleanup priority levels

displayport:
- refactor i915 code into helpers for nouveau

i915:
- split into display and GT trees
- WW locking refactoring in GEM
- execbuf2 extension mechanism
- syncobj timeline support
- GEN 12 HOBL display powersaving
- Rocket Lake display additions
- Disable FBC on Tigerlake
- Tigerlake Type-C + DP improvements
- Hotplug interrupt refactoring

amdgpu:
- Sienna Cichlid updates
- Navy Flounder updates
- DCE6 (SI) support for DC
- Plane rotation enabled
- TMZ state info ioctl
- PCIe DPC recovery support
- DC interrupt handling refactor
- OLED panel fixes

amdkfd:
- add SMI events for thermal throttling
- SMI interface events ioctl update
- process eviction counters

radeon:
- move to dma_ for allocations
- expose sclk via sysfs

msm:
- DSI support for sm8150/sm8250
- per-process GPU pagetable support
- Displayport support

mediatek:
- move HDMI phy driver to PHY
- convert mtk-dpi to bridge API
- disable mt2701 tmds

tegra:
- bridge support

exynos:
- misc cleanups

vc4:
- dual display cleanups

ast:
- cleanups

gma500:
- conversion to GPIOd API

hisilicon:
- misc reworks

ingenic:
- clock handling and format improvements

mcde:
- DSI support

mgag200:
- desktop g200 support

mxsfb:
- i.MX7 + i.MX8M
- alpha plane support

panfrost:
- devfreq support
- amlogic SoC support

ps8640:
- EDID from eDP retrieval

tidss:
- AM65xx YUV workaround

virtio:
- virtio-gpu exported resources

rcar-du:
- R8A7742, R8A774E1 and R8A77961 support
- YUV planar format fixes
- non-visible plane handling
- VSP device reference count fix
- Kconfig fix to avoid displaying disabled options in .config
The following changes since commit 856deb866d16e29bd65952e0289066f6078af773=
:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-15

for you to fetch changes up to 640eee067d9aae0bb98d8706001976ff1affaf00:

  Merge tag 'drm-misc-next-fixes-2020-10-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2020-10-14
07:31:53 +1000)

----------------------------------------------------------------
drm next for 5.10-rc1

New driver:
Cadence MHDP8546 DisplayPort bridge driver

core:
- cross-driver scatterlist cleanups
- devm_drm conversions
- remove drm_dev_init
- devm_drm_dev_alloc conversion

ttm:
- lots of refactoring and cleanups

bridges:
- chained bridge support in more drivers

panel:
- misc new panels

scheduler:
- cleanup priority levels

displayport:
- refactor i915 code into helpers for nouveau

i915:
- split into display and GT trees
- WW locking refactoring in GEM
- execbuf2 extension mechanism
- syncobj timeline support
- GEN 12 HOBL display powersaving
- Rocket Lake display additions
- Disable FBC on Tigerlake
- Tigerlake Type-C + DP improvements
- Hotplug interrupt refactoring

amdgpu:
- Sienna Cichlid updates
- Navy Flounder updates
- DCE6 (SI) support for DC
- Plane rotation enabled
- TMZ state info ioctl
- PCIe DPC recovery support
- DC interrupt handling refactor
- OLED panel fixes

amdkfd:
- add SMI events for thermal throttling
- SMI interface events ioctl update
- process eviction counters

radeon:
- move to dma_ for allocations
- expose sclk via sysfs

msm:
- DSI support for sm8150/sm8250
- per-process GPU pagetable support
- Displayport support

mediatek:
- move HDMI phy driver to PHY
- convert mtk-dpi to bridge API
- disable mt2701 tmds

tegra:
- bridge support

exynos:
- misc cleanups

vc4:
- dual display cleanups

ast:
- cleanups

gma500:
- conversion to GPIOd API

hisilicon:
- misc reworks

ingenic:
- clock handling and format improvements

mcde:
- DSI support

mgag200:
- desktop g200 support

mxsfb:
- i.MX7 + i.MX8M
- alpha plane support

panfrost:
- devfreq support
- amlogic SoC support

ps8640:
- EDID from eDP retrieval

tidss:
- AM65xx YUV workaround

virtio:
- virtio-gpu exported resources

rcar-du:
- R8A7742, R8A774E1 and R8A77961 support
- YUV planar format fixes
- non-visible plane handling
- VSP device reference count fix
- Kconfig fix to avoid displaying disabled options in .config

----------------------------------------------------------------
Abhinav Kumar (10):
      drm/msm/dp: store dp_display in the driver data
      drm/msm/dp: add audio support for Display Port on MSM
      drm/msm/dp: add hook_plugged_cb hdmi-codec op for MSM DP driver
      drm/msm/dp: signal the hotplug disconnect in the event handler
      drm/msm/dp: wait for audio notification before disabling clocks
      drm/msm/dp: add debugfs support to DP driver
      drm/msm/dp: move debugfs node to /sys/kernel/debug/dri/*/
      drm/msm/dp: add debugfs nodes for video pattern tests
      drm/msm/dp: remove mode hard-coding in case of DP CTS
      drm/msm/dp: fix incorrect function prototype of dp_debug_get()

Aidan Gratton (1):
      drm/amd/display: Increase Max EDID Size Constant

Akhil P Oommen (2):
      drm/msm: Fix premature purging of BO
      drm/msm: Leave inuse count intact on map failure

Alex Deucher (66):
      drm/amdgpu/powerplay: add some documentation about memory clock
      drm/amdgpu: add some required DCE6 registers (v7)
      drm/amdgpu/si: initial support for GPU reset
      Revert "drm/amdgpu: Fix NULL dereference in dpm sysfs handlers"
      drm/amdgpu/smu: rework i2c adpater registration
      drm/amdgpu: handle bo size 0 in amdgpu_bo_create_kernel_at (v2)
      drm/amdgpu: use create_at for the stolen pre-OS buffer
      drm/amdgpu: use a define for the memory size of the vga emulator
      drm/amdgpu: move stolen vga bo from amdgpu to amdgpu.gmc
      drm/amdgpu: move keep stolen memory check into gmc core
      drm/amdgpu: add support for extended stolen vga memory
      drm/amdgpu/gmc: add new helper to get the FB size used by pre-OS cons=
ole
      drm/amdgpu/gmc6: switch to using amdgpu_gmc_get_vbios_allocations
      drm/amdgpu/gmc7: switch to using amdgpu_gmc_get_vbios_allocations
      drm/amdgpu/gmc8: switch to using amdgpu_gmc_get_vbios_allocations
      drm/amdgpu/gmc9: switch to using amdgpu_gmc_get_vbios_allocations
      drm/amdgpu/gmc10: switch to using amdgpu_gmc_get_vbios_allocations
      drm/amdgpu: drop the CPU pointers for the stolen vga bos
      drm/amdgpu/gmc: disable keep_stolen_vga_memory on arcturus
      drm/amdgpu: move stolen memory from gmc to mman
      drm/amdgpu: move IP discovery data to mman
      drm/amdgpu: move vram usage by vbios to mman (v2)
      drm/amdgpu/display: drop unused function
      drm/amdgpu: print where we get the vbios image from
      drm/amdgpu: note what type of reset we are using
      drm/amdgpu: drop log message in amdgpu_dpm_baco_reset()
      drm/amdgpu/pm: remove duplicate check
      drm/amdgpu/swsmu: implement voltage metrics for RENOIR
      drm/amdgpu/swsmu: implement power metrics for RENOIR
      drm/amdgpu/pm: only hide average power on SI and pre-RENOIR APUs
      drm/amdgpu: fix up DCHUBBUB_SDPIF_MMIO_CNTRL_0 handling
      drm/amdgpu: add an asic callback for pre asic init
      drm/amdgpu: add pre_asic_init callback for SI
      drm/amdgpu: add pre_asic_init callback for CIK
      drm/amdgpu: add pre_asic_init callback for VI
      drm/amdgpu: add pre_asic_init callback for SOC15
      drm/amdgpu: add pre_asic_init callback for navi
      drm/amdgpu: add a wrapper for atom asic_init
      drm/amdgpu: report DC not supported if virtual display is enabled (v2=
)
      drm/amdgpu: Fix buffer overflow in INFO ioctl
      drm/amdgpu/swsmu: add new callback for getting fan parameters
      drm/amdgpu/swsmu: add get_fan_parameters callbacks for smu11 asics
      drm/amdgpu/swsmu: drop get_fan_speed_percent (v2)
      drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)
      drm/amdgpu/swsmu: add smu11 helper to get manual fan speed (v2)
      drm/amdgpu/swsmu: handle manual fan readback on SMU11
      drm/amdgpu/gmc9: print client id string for gfxhub
      drm/amdgpu/gmc10: print client id string for gfxhub
      drm/amdgpu/gmc9: print client id string for mmhub
      drm/amdgpu/mmhub2.0: print client id string for mmhub
      drm/amdgpu: Fail to load on RAVEN if SME is active
      drm/amdgpu/gmc9: remove mmhub client duplicated case
      drm/amdgpu: unmap register bar on device init failure
      drm/amdgpu: add the GC 10.3 VRS registers
      drm/amdgpu: add VCN 3.0 AV1 registers
      drm/amdgpu: use the AV1 defines for VCN 3.0
      drm/amdgpu: remove experimental flag from navi12
      drm/amdgpu/display: fix CFLAGS setup for DCN30
      drm/amdgpu: store noretry parameter per driver instance
      drm/amdgpu: add an auto setting to the noretry parameter
      drm/amdgpu: fix a warning in amdgpu_ras.c (v2)
      drm/amdgpu/swsmu/smu12: fix force clock handling for mclk
      drm/amdgpu/swsmu: add interrupt work function
      drm/amdgpu/swsmu: add interrupt work handler for smu11 parts
      drm/amdgpu/swsmu: fix ARC build errors
      drm/amdgpu: prevent spurious warning

Alex Dewar (4):
      drm/amd/pm: Remove unnecessary cast
      drm/amd/pm: use kmemdup() rather than kmalloc+memcpy
      video: fbdev: sstfb: replace spurious snprintf() with sprintf()
      drm/bridge: dw-mipi-dsi: Use kmemdup cf. kmalloc+memcpy

Alex Sierra (2):
      drm/amdgpu: enable ih1 ih2 for Arcturus only
      drm/amdgpu: align frag_end to covered address space

Alexander Monakov (1):
      drm/amd/display: use correct scale for actual_brightness

Alexei Podtelezhnikov (1):
      drm/i915: Remove dubious Valleyview PCI IDs

Alvin Lee (7):
      drm/amd/display: Don't compare dppclk before updating DTO
      drm/amd/display: Separate pipe disconnect from rest of progrmaming
      drm/amd/display: Revert regression
      drm/amd/display: Disconnect pipe separetely when disable pipe split
      drm/amd/display: Compare plane when looking for pipe split being lost
      drm/amd/display: Update NV1x SR latency values
      drm/amd/display: Don't allow pstate if no support in blank

Andrey Grodzovsky (9):
      drm/amdgpu: Implement DPC recovery
      drm/amdgpu: Avoid accessing HW when suspending SW state
      drm/amdgpu: Block all job scheduling activity during DPC recovery
      drm/amdgpu: Fix SMU error failure
      drm/amdgpu: Fix consecutive DPC recovery failures.
      drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
      drm/amdgpu: Disable DPC for XGMI for now.
      drm/amdgpu: Minor checkpatch fix
      drm/amdgpu: Include sienna_cichlid in USBC PD FW support.

Angelo Ribeiro (1):
      drm/bridge: dw-mipi-dsi.c: Add VPG runtime config through debugfs

Anshuman Gupta (2):
      drm/i915/hdcp: Add update_pipe early return
      drm/i915/hdcp: No direct access to power_well desc

Anthony Koo (13):
      drm/amd/display: [FW Promotion] Release 0.0.26
      drm/amd/display: [FW Promotion] Release 0.0.27
      drm/amd/display: Fix LFC multiplier changing erratically
      drm/amd/display: Switch to immediate mode for updating infopackets
      drm/amd/display: [FW Promotion] Release 0.0.28
      drm/amd/display: 3.2.98
      drm/amd/display: [FW Promotion] Release 0.0.29
      drm/amd/display: [FW Promotion] Release 0.0.30
      drm/amd/display: [FW Promotion] Release 0.0.31
      drm/amd/display: [FW Promotion] Release 0.0.32
      drm/amd/display: [FW Promotion] Release 0.0.33
      drm/amd/display: [FW Promotion] Release 0.0.34
      drm/amd/display: [FW Promotion] Release 0.0.35

Antonio Borneo (3):
      drm/bridge/synopsys: dsi: allow LP commands in video mode
      drm/bridge/synopsys: dsi: allow sending longer LP commands
      drm/bridge/synopsys: dsi: add support for non-continuous HS clock

Anusha Srivatsa (1):
      drm/i915/pll: Centralize PLL_ENABLE register lookup

Aric Cyr (15):
      drm/amd/display: 3.2.96
      drm/amd/display: Fix DP Compliance tests 4.3.2.1 and 4.3.2.2
      drm/amd/display: AMD OUI (DPCD 0x00300) skipped on some sink
      drm/amd/display: 3.2.97
      drm/amd/display: Fix incorrect backlight register offset for DCN
      drm/amd/display: 3.2.99
      drm/amd/display: 3.2.100
      drm/amd/display: Triplebuffering should not be used by default
      drm/amd/display: 3.2.101
      drm/amd/display: Flip pending check timeout due to disabled hubp
      drm/amd/display: Multi display cause system lag on mode change
      drm/amd/display: 3.2.102
      drm/amd/display: 3.2.103
      drm/amd/display: 3.2.104
      drm/amd/display: Revert check for flip pending before locking pipes

Arunpravin (1):
      drm/amdgpu: Enable P2P dmabuf over XGMI

Ashley Thomas (1):
      drm/amd/display: Power eDP panel back ON before link training retry

Aurabindo Pillai (3):
      drm/amdgpu: Move existing pflip fields into separate struct
      drm/amd/display: Refactor to prevent crtc state access in DM IRQ hand=
ler
      drm/amd/display: Move disable interrupt into commit tail

Bernard Zhao (7):
      drm/panel: remove return value of function drm_panel_add
      drm/msm/adreno: remove return value of function XX_print
      gpu/drm: cleanup coding style a bit
      drm/amd/display: optimize code runtime a bit
      drm/radeon: fix typoes in comments
      drm/amd: fix typoes in comments
      drm/amd/display: optimize code runtime a bit

Bhawanpreet Lakha (9):
      drm/amd/display: Use seperate dmcub firmware for navy_flounder
      drm/amd/display: Use proper abm/backlight functions for DCN3
      drm/amdgpu: parse ta firmware for navy_flounder
      drm/amd/display: Add DSC_DBG_EN shift/mask for dcn3
      drm/amd/display: Add dsc_to_stream_resource for dcn3
      drm/amd/display: Add DPCS regs for dcn3 link encoder
      drm/amd/display: Don't use DRM_ERROR() for DTM add topology
      drm/amd/display: Don't log hdcp module warnings in dmesg
      drm/amd/display: Add missing "Copy GSL groups when committing a
new context"

Biju Das (2):
      dt-bindings: display: bridge: lvds-codec: Document power-supply prope=
rty
      drm/bridge: lvds-codec: Add support for regulator

Bilal Wasim (1):
      docs: fb: Correcting the location of FRAMEBUFFER_CONSOLE option.

Bokun Zhang (2):
      drm/amdgpu: Update VF2PF interface
      drm/amdgpu: Implement new guest side VF2PF message transaction (v2)

Boyuan Zhang (1):
      drm/amdgpu: update dec ring test for VCN 3.0

Brandon Syu (1):
      drm/amd/display: Keep current gain when ABM disable immediately

CK Hu (3):
      drm/mediatek: Move tz_disabled from mtk_hdmi_phy to mtk_hdmi driver
      drm/mediatek: Separate mtk_hdmi_phy to an independent module
      phy: mediatek: Move mtk_hdmi_phy driver into drivers/phy/mediatek fol=
der

Chandan Uddaraju (3):
      drm: add constant N value in helper file
      drm/msm/dp: add displayPort driver support
      drm/msm/dp: add support for DP PLL driver

Changfeng (4):
      Revert "drm/amd/powerplay: drop unnecessary message support check"
      drm/amd/powerplay: drop unnecessary message support check(v2)
      drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
      drm/amdgpu: add ta DTM/HDCP print in amdgpu_firmware_info for apu

Chen Zhou (1):
      drm/amd/display: Remove duplicate include

Chiawen Huang (2):
      drm/amd/display: disable stream if pixel clock changed with link acti=
ve
      drm/amd/display: disable stream if pixel clock changed with link acti=
ve

Chris Park (6):
      drm/amd/display: Call DMUB for eDP power control
      drm/amd/display: Assign correct left shift
      drm/amd/display: Reset scrambling on Test Pattern
      drm/amd/display: Call DMUB for eDP power control
      drm/amd/display: TMDS Fallback transition
      drm/amd/display: Change to correct unit on audio rate

Chris Wilson (53):
      drm/i915: Provide the perf pmu.module
      drm/i915/selftests: Downgrade severity of CS/SRM frequency scaling te=
sts
      drm/i915: Copy default modparams to mock i915_device
      drm/i915/selftests: Add compiler paranoia for checking HWSP values
      drm/i915: Remove gen check before calling intel_rps_boost
      drm/i915/display: Check for an LPSP encoder before dereferencing
      drm/i915: Add a couple of missing i915_active_fini()
      drm/i915: Reduce i915_request.lock contention for i915_request_wait
      drm/i915/selftests: Mock the status_page.vma for the kernel_context
      drm/i915: Soften the tasklet flush frequency before waits
      drm/i915/gem: Remove disordered per-file request list for throttling
      drm/i915/gt: Disable preparser around xcs invalidations on tgl
      drm/i915/gt: Delay taking the spinlock for grabbing from the buffer p=
ool
      drm/i915/selftests: Flush the active barriers before asserting
      drm/i915/gt: Fix termination condition for freeing all buffer objects
      drm/i915/gem: Delay tracking the GEM context until it is registered
      drm/i915/gt: Support multiple pinned timelines
      drm/i915/gt: Pull release of node->age under the spinlock
      drm/i915/selftests: Drop stale timeline constructor assert
      drm/i915: Skip taking acquire mutex for no ref->active callback
      drm/i915: Export a preallocate variant of i915_active_acquire()
      drm/i915: Keep the most recently used active-fence upon discard
      drm/i915: Make the stale cached active node available for any timelin=
e
      drm/i915: Reduce locking around i915_active_acquire_preallocate_barri=
er()
      drm/i915: Provide a fastpath for waiting on vma bindings
      drm/i915: Remove requirement for holding i915_request.lock for breadc=
rumbs
      drm/i915/gt: Replace intel_engine_transfer_stale_breadcrumbs
      drm/i915/gt: Only transfer the virtual context to the new engine if a=
ctive
      drm/i915/gt: Distinguish the virtual breadcrumbs from the irq breadcr=
umbs
      drm/i915: Preallocate stashes for vma page-directories
      drm/i915/gt: Switch to object allocations for page directories
      drm/i915/gt: Shrink i915_page_directory's slab bucket
      drm/i915/gt: Move intel_breadcrumbs_arm_irq earlier
      drm/i915/gt: Hold context/request reference while breadcrumbs are act=
ive
      drm/i915/selftests: Prevent selecting 0 for our random width/align
      drm/i915/gem: Reduce context termination list iteration guard to RCU
      drm/i915/gem: Free the fence after a fence-chain lookup failure
      drm/i915: Be wary of data races when reading the active execlists
      drm/i915: Remove i915_request.lock requirement for execution callback=
s
      drm/i915: Filter wake_flags passed to default_wake_function
      drm/i915: Initialise outparam for error return from wait_for_register
      drm/i915/selftests: Push the fake iommu device from the stack to data
      drm/i915/gem: Avoid implicit vmap for highmem on x86-32
      drm/i915/gem: Prevent using pgprot_writecombine() if PAT is not suppo=
rted
      drm/i915/gt: Clear the buffer pool age before use
      drm/i915: Break up error capture compression loops with cond_resched(=
)
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

Christian Hewitt (1):
      drm/panfrost: increase readl_relaxed_poll_timeout values

Christian K=C3=B6nig (35):
      drm/radeon: stop using TTM_MEMTYPE_FLAG_MAPPABLE
      drm/amdgpu: stop using TTM_MEMTYPE_FLAG_MAPPABLE
      drm/ttm: remove TTM_MEMTYPE_FLAG_MAPPABLE
      drm/ttm: fix pipelined gutting for evictions v2
      drm/ttm: initialize the system domain with defaults v2
      drm/ttm: remove TTM_MEMTYPE_FLAG_FIXED v2
      drm/radeon: stop implementing init_mem_type
      drm/amdgpu: stop implementing init_mem_type
      drm/vmwgfx: stop implementing init_mem_type v2
      drm/nouveau: stop implementing init_mem_type
      drm/qxl: stop implementing init_mem_type
      drm/vram-helper: stop implementing init_mem_type
      drm/ttm: remove the init_mem_type callback
      drm/amdgpu: make sure userptr ttm is allocated
      drm/ttm: rename ttm_resource_manager_func callbacks
      drm/ttm: give resource functions their own [ch] files
      drm/radeon: drop superflous AGP handling
      drm/amdgpu: revert "fix system hang issue during GPU reset"
      drm/ttm: fix broken merge between drm-next and drm-misc-next
      drm/ttm: make sure that we always zero init mem.bus v2
      drm/nouveau: move io_reserve_lru handling into the driver v5
      drm/ttm: remove io_reserve_lru handling v3
      drm/amdgpu: fix max_entries calculation v4
      drm/qxl: don't touch mem.bus.offset
      drm/ttm: merge offset and base in ttm_bus_placement
      drm/vram-helper: stop using TTM placement flags
      drm/nouveau: stop using TTM placement flags
      drm/vmwgfx: stop setting multiple domain flags
      drm/ttm: nuke memory type flags
      drm/ttm: remove default caching
      drm/nouveau: explicitly specify caching to use
      drm/ttm: remove available_caching
      drm/radeon: revert "Prefer lower feedback dividers"
      drm/ttm: some cleanups
      drm/ttm: remove superflous extern attribute from funcs

Christophe JAILLET (3):
      drm/radeon: avoid a useless memset
      drm/radeon: switch from 'pci_' to 'dma_' API
      drm: amdgpu: Use the correct size when allocating memory

Chun-Kuang Hu (1):
      MAINTAINERS: add files for Mediatek DRM drivers

Clint Taylor (1):
      drm/i915/gt: Implement WA_1406941453

Cl=C3=A9ment P=C3=A9ron (10):
      drm/panfrost: avoid static declaration
      drm/panfrost: clean headers in devfreq
      drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
      drm/panfrost: introduce panfrost_devfreq struct
      drm/panfrost: use spinlock instead of atomic
      drm/panfrost: properly handle error in probe
      drm/panfrost: rename error labels in device_init
      drm/panfrost: move devfreq_init()/fini() in device
      drm/panfrost: dynamically alloc regulators
      drm/panfrost: add regulators to devfreq

Colin Ian King (10):
      drm/amd/display: remove redundant initialization of variable result
      drm/amdgpu: fix spelling mistake "paramter" -> "parameter"
      drm/gma500: fix spelling mistake "pannel" -> "panel"
      drm/virtgpu: remove redundant assignments to width and height
      drm/amd/display: fix potential integer overflow when shifting 32
bit variable bl_pwm
      drm/omap: fix spelling mistake "propert" -> "property"
      drm/mgag200: fix spelling mistake "expeced" -> "expected"
      drm/i915/vlv_dsi_pll: fix spelling mistake "Cant" -> "Can't"
      video: fbdev: vga16fb: fix setting of pixclock because a
pass-by-value error
      omapfb: fix spelling mistake "propert" -> "property"

Colin Xu (2):
      drm/i915/gvt: Add F_CMD_ACCESS for some GEN9 SKU WA MMIO access
      drm/i915/gvt: Init vreg GUC_STATUS to GS_MIA_IN_RESET

Dan Carpenter (5):
      drm/amd/powerplay: off by one bugs in smu_cmn_to_asic_specific_index(=
)
      drm/amd/display: Indent an if statement
      drm/vc4: hdmi: Fix off by ones in vc4_hdmi_read/write()
      drm/vc4: hdmi: Fix NULL vs IS_ERR() checks in vc5_hdmi_init_resources=
()
      drm/i915: Fix an error code i915_gem_object_copy_blt()

Daniel Kolesa (2):
      drm/amdgpu/display: use GFP_ATOMIC in dcn20_validate_bandwidth_intern=
al
      drm/amd/display: add DCN support for aarch64

Daniel Vetter (14):
      drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
      drm/syncobj: Tune down unordered timeline DRM_ERROR
      drm/managed: Cleanup of unused functions and polishing docs
      drm/armada: Use devm_drm_dev_alloc
      drm/armada: Don't use drm_device->dev_private
      drm/aspeed: Use managed drmm_mode_config_cleanup
      drm/vgem: Use devm_drm_dev_alloc
      drm/vkms: Use devm_drm_dev_alloc
      drm/xlnx: Use devm_drm_dev_alloc
      Merge v5.9-rc5 into drm-next
      dma-resv: lockdep-prime address_space->i_mmap_rwsem for dma-resv
      drm/i915/selftest: Create mock_destroy_device
      drm/i915/selftests: align more to real device lifetimes
      drm/dev: Remove drm_dev_init

Dave Airlie (118):
      drm/vmwgfx: consolidate ttm object creation and populate
      drm/vmwgfx: drop bo map/unmap dma functions.
      nouveau: use ttm populate mapping functions. (v2)
      qxl/ttm: drop the unusued no wait flag to reserve function
      drm/ttm/amdgpu: consolidate ttm reserve paths
      drm/ttm: use a helper for unlocked moves to the lru tail
      drm/vram-helper: remove populate/unpopulate
      drm/ttm: export memory type debug entrypoint.
      drm/nouveau/ttm: don't fill in blank ttm debug callback
      drm/vmwgfx/gmrid: don't provide pointless ttm debug callback
      drm/qxl/ttm: call ttm manager debug (v2)
      drm/vram-helper: call the ttm manager debug function
      drm/ttm: split the mm manager init code (v2)
      drm/ttm: provide a driver-led init path for range mm manager. (v2)
      drm/amdgpu/ttm: init managers from the driver side.
      drm/radeon: use new ttm man init path
      drm/qxl/ttm: use new init path for manager
      drm/vram_helper: use new ttm manager init function
      drm/nouveau: use new memory manager init paths
      drm/vmwgfx/ttm: convert vram mm init to new code paths
      drm/vmwgfx/ttm: switch gmrid allocator to new init paths.
      drm/ttm: convert system manager init to new code.
      drm/ttm: purge old manager init path.
      drm/ttm: pass man around instead of mem_type in some places
      drm/ttm: make some inline helper functions for cleanup paths. (v2)
      drm/ttm: start allowing drivers to use new takedown path (v2)
      drm/amdgpu/ttm: use new takedown path
      drm/vmwgfx: takedown vram manager
      drm/vram_helper: call explicit mm takedown
      drm/nouveau: use new cleanup paths
      drm/radeon/ttm: use new takedown paths
      drm/qxl/ttm: use new takedown path
      drm/vmwgfx: fix gmrid takedown paths to new interface
      drm/ttm: remove range manager legacy takedown path
      drm/ttm: make TTM responsible for cleaning system only.
      drm/ttm: add wrapper to get manager from bdev.
      drm/amdgfx/ttm: use wrapper to get ttm memory managers
      drm/vram-helper: use wrapper to access memory managers
      drm/nouveau/ttm: use wrapper to access memory managers
      drm/qxl/ttm: use wrapper to access memory manager
      drm/radeon/ttm: use wrapper to access memory manager
      drm/vmwgfx/ttm: use wrapper to access memory manager
      drm/ttm: rename manager variable to make sure wrapper is used.
      drm/ttm: allow drivers to provide their own manager subclasses
      drm/amdgpu/ttm: use bo manager subclassing for vram/gtt mgrs
      drm/ttm: make ttm_range_man_init/takedown take type + args
      drm/ttm: move range manager to subclassed driver allocation
      drm/vmwgfx/ttm: move thp to driver managed
      drm/vmwgfx/gmrid: convert to driver controlled allocation.
      drm/nouveau/ttm: move to driver allocated manager
      drm/ttm: drop priv pointer in memory manager
      drm/amdgpu/ttm: remove man->bdev references.
      drm/ttm: drop man->bdev link.
      drm/ttm: drop list of memory managers from device. (v2)
      drm/ttm: drop type manager has_type
      drm/ttm: add a wrapper for checking if manager is in use
      drm/ttm: rename bo manager to range manager.
      drm/ttm: rename ttm_mem_type_manager -> ttm_resource_manager.
      drm/ttm: rename ttm_mem_reg to ttm_resource.
      drm/amdgpu/ttm: move vram/gtt mgr allocations to mman.
      drm/amdgpu/ttm: drop the adev link from vram mgr
      drm/vmwgfx/ttm: fix the non-THP cleanup path.
      drm/ttm: init mem->bus in common code.
      drm/ttm: drop bus.size from bus placement.
      Merge tag 'drm-misc-next-2020-08-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2020-08-24-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      drm/amdgpu/ttm: remove unused parameter to move blit
      drm/radeon/ttm: don't store driver copy of device pointer.
      drm/ttm: remove bdev from ttm_tt
      Merge tag 'v5.9-rc4' into drm-next
      Merge tag 'amd-drm-next-5.10-2020-09-03' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Backmerge drm-fixes merge into drm-next
      Merge tag 'drm-intel-gt-next-2020-09-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      drm/ttm: introduce ttm_bo_move_null
      drm/ttm: add optional bind/unbind via driver.
      drm/qxl: move bind/unbind/destroy to the driver function table.
      drm/ttm/agp: export bind/unbind/destroy for drivers to use.
      drm/radeon/ttm: move to driver binding/destroy functions. (v2)
      drm/nouveau/ttm: use driver bind/unbind/destroy functions.
      drm/vmwgfx: move to driver binding functions
      drm/amdgpu/ttm: move to driver backend binding funcs
      drm/gem_vram/ttm: move to driver backend destroy function.
      drm/ttm/agp: drop back end bindings from agp
      drm/ttm: get rid of agp specific populate/unpopulate paths.
      drm/ttm/agp: remove bdev from agp helpers
      drm/ttm: drop the tt backend function paths.
      Merge tag
'topic/nouveau-i915-dp-helpers-and-cleanup-2020-08-31-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      drm/ttm/tt: add wrappers to set tt state.
      drm/ttm: wrap tt destroy. (v2)
      drm/ttm: tt destroy move null check to outer function.
      drm/ttm: split populate out from binding.
      drm/ttm: move ttm binding/unbinding out of ttm_tt paths.
      drm/ttm: split bound/populated flags.
      drm/ttm: move populated state into page flags
      Merge branch 'for-5.10-drm-sg-fix' of
https://github.com/mszyprow/linux into drm-next
      drm/ttm: protect against reentrant bind in the drivers
      drm/ttm: flip tt destroy ordering.
      drm/ttm: move unbind into the tt destroy.
      drm/ttm/drivers: call the bind function directly.
      drm/ttm: add a simple assign mem to bo wrapper
      drm/ttm: move ghost object creation to a common function
      drm/ttm: make common function for wait/free node path.
      drm/ttm: drop special pipeline accel cleanup function.
      drm/ttm: drop evicted from ttm_bo.
      Merge tag 'du-next-20200922' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm/tegra/for-5.10-rc1' of
ssh://git.freedesktop.org/git/tegra/linux into drm-next
      Merge tag 'exynos-drm-next-v5.10' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'cdns-mhdp-5.10' of
git://git.kernel.org/.../tomba/linux into drm-next
      Merge tag 'drm-intel-next-2020-09-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-next-5.10-2020-09-18' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2020-09-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-msm-next-2020-09-27' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'mediatek-drm-next-5.10' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-next
      drm/vmwgfx: fix regression in thp code due to ttm init refactor.
      Merge tag 'drm-misc-next-fixes-2020-10-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2020-10-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-fixes-5.10-2020-10-09' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2020-10-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Dave Stevenson (7):
      drm/vc4: Add support for the BCM2711 HVS5
      drm/vc4: plane: Change LBM alignment constraint on LBM
      drm/vc4: plane: Optimize the LBM allocation size
      drm/vc4: hdmi: Use reg-names to retrieve the HDMI audio registers
      drm/vc4: hdmi: Reset audio infoframe on encoder_enable if
previously streaming
      drm/vc4: hdmi: Set the b-frame marker to the match ALSA's default.
      drm/vc4: hdmi: Add audio-related callbacks

David Galiffi (1):
      drm/amd/display: Fix incorrect backlight register offset for DCN

David Stevens (4):
      virtio: add dma-buf support for exported objects
      virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
      drm/virtio: Support virtgpu exported resources
      virtio: fix build for configs without dma-bufs

Dennis Li (12):
      drm/amdgpu: fix system hang issue during GPU reset
      drm/amdgpu: unlock mutex on error
      drm/amdgpu: annotate a false positive recursive locking
      drm/amdgpu: refine codes to avoid reentering GPU recovery
      drm/amdgpu: change reset lock from mutex to rw_semaphore
      drm/amdgpu: fix the nullptr issue when reenter GPU recovery
      drm/amdgpu: refine message print for devices of hive
      drm/amdgpu: refine create and release logic of hive info
      drm/amdgpu: annotate a false positive recursive locking
      drm/amdgpu: block ring buffer access during GPU recovery
      drm/kfd: fix a system crash issue during GPU recovery
      drm/amdkfd: fix a memory leak issue

Derek Basehore (2):
      drm/panel: Add helper for reading DT rotation
      drm/panel: Read panel orientation for BOE TV101WUM-NL6

Dinghao Liu (3):
      drm/amd/display: Fix memleak in amdgpu_dm_mode_config_init
      drm/crc-debugfs: Fix memleak in crc_control_write
      video: fbdev: radeon: Fix memleak in radeonfb_pci_register

Dirk Gouders (2):
      drm/amd/display: remove duplicate call to rn_vbios_smu_get_smu_versio=
n()
      drm/amdgpu: fix NULL pointer dereference for Renoir

Dmitry Osipenko (6):
      drm/panel: lvds: Read panel orientation
      drm/panel-simple: Read panel orientation
      drm/tegra: output: Don't leak OF node on error
      drm/tegra: output: Support DRM bridges
      drm/tegra: output: rgb: Support LVDS encoder bridge
      drm/tegra: output: rgb: Wrap directly-connected panel into DRM bridge

Dmytro Laktyushkin (8):
      drm/amd/display: Clean up global sync param retrieval
      drm/amd/display: populate new dml variable
      drm/amd/display: fix dcn3 wide timing dsc validation
      drm/amd/display: make dcn20 stream_gating use a pointer for dsc_pg_co=
ntrol
      drm/amd/display: update dcn30_optc header with missing declarations
      amd/drm/display: avoid dcn3 on flip opp change for slave pipes
      drm/amd/display: add pipe reassignment prevention code to dcn3
      drm/amd/display: Fix OPTC_DATA_FORMAT programming

Doug Horn (1):
      Fix use after free in get_capset_info callback.

Douglas Anderson (2):
      dt-bindings: display: simple: Add KD116N21-30NV-A010 compatible
      drm: panel: simple: Add KD116N21-30NV-A010

Emily.Deng (3):
      drm/amdgpu: Fix dead lock issue for vblank
      drm/amdgpu: Remove some useless code
      drm/amdgpu: Remove warning for virtual_display

Enric Balletbo i Serra (7):
      drm/bridge_connector: Set default status connected for eDP connectors
      drm/bridge: ps8640: Get the EDID from eDP control
      drm/bridge: ps8640: Return an error for incorrect attach flags
      drm/bridge: ps8640: Print an error if VDO control fails
      drm/mediatek: mtk_dpi: Rename bridge to next_bridge
      drm/mediatek: mtk_dpi: Convert to bridge driver
      drm/bridge: ps8640: Rework power state handling

Eric Bernstein (3):
      drm/amd/display: Update virtual stream encoder
      drm/amd/display: Use parameter for call to set output mux
      drm/amd/display: Add dp_set_dsc_pps_info_packet to virtual stream enc=
oder

Eric Yang (1):
      drm/amd/display: implement notify stream mask

Eryk Brol (15):
      drm/amd/display: Rename bytes_pp to the correct bits_pp
      drm/amd/display: Fix naming of DSC Debugfs entry
      drm/amd/display: DSC Clock enable debugfs write entry
      drm/amd/display: DSC Slice width debugfs write entry
      drm/amd/display: DSC Slice height debugfs write entry
      drm/amd/display: DSC Bit target rate debugfs write entry
      drm/amd/display: Comments on how to use DSC debugfs some entries
      drm/amd/display: Fix DSC force enable on SST
      drm/amd/display: Add debugfs for connector's FEC & DSC capabilities
      drm/amd/display: Add connector HPD trigger debugfs entry
      drm/amd/display: Add DSC force disable to dsc_clock_en debugfs entry
      drm/amd/display: Add trigger connector unplug
      drm/amd/display: Return the number of bytes parsed than allocated
      drm/amd/display: Calculate DSC number of slices in debugfs when force=
d
      drm/amd/display: Add connector to the state if DSC debugfs is set

Evan Quan (76):
      drm/amd/powerplay: revise the outputs layout of amdgpu_pm_info debugf=
s
      drm/amd/powerplay: grant Arcturus softmin/max setting on latest
PM firmware
      drm/amd/powerplay: define an universal data structure for gpu metrics=
 (V4)
      drm/amd/powerplay: add new sysfs interface for retrieving gpu metrics=
(V2)
      drm/amd/powerplay: implement SMU V11 common APIs for retrieving
link speed/width
      drm/amd/powerplay: add Arcturus support for gpu metrics export
      drm/amd/powerplay: update the data structure for NV12 SmuMetrics
      drm/amd/powerplay: add Navi1x support for gpu metrics export
      drm/amd/powerplay: add Sienna Cichlid support for gpu metrics export
      drm/amd/powerplay: add Renoir support for gpu metrics export(V2)
      drm/amd/powerplay: enable gpu_metrics export on legacy powerplay rout=
ines
      drm/amd/powerplay: add Vega20 support for gpu metrics export
      drm/amd/powerplay: add Vega12 support for gpu metrics export
      drm/amd/powerplay: add control method to bypass metrics cache on Arct=
urus
      drm/amd/powerplay: add control method to bypass metrics cache on Navi=
10
      drm/amd/powerplay: add control method to bypass metrics cache on
Sienna Cichlid
      drm/amd/powerplay: add control method to bypass metrics cache on Reno=
ir
      drm/amd/powerplay: add control method to bypass metrics cache on Vega=
20
      drm/amd/powerplay: add control method to bypass metrics cache on Vega=
12
      drm/amd/powerplay: update swSMU VCN/JPEG PG logics
      drm/amd/powerplay: put VCN/JPEG into PG ungate state before dpm
table setup(V3)
      drm/amd/powerplay: correct Vega20 cached smu feature state
      drm/amd/powerplay: correct UVD/VCE PG state on custom pptable uploadi=
ng
      drm/amd/powerplay: update the metrics table cache interval as 1ms
      drm/amd/powerplay: maximum the code sharing around metrics table
retrieving
      drm/amd/powerplay: bump NAVI12 driver if version
      drm/amd/powerplay: optimize the interface for mgpu fan boost enableme=
nt
      drm/amd/powerplay: enable swSMU mgpu fan boost support
      drm/amd/powerplay: enable Navi1X mgpu fan boost feature(V2)
      drm/amd/powerplay: enable Sienna Cichlid mgpu fan boost feature
      drm/amd/powerplay: suppress the kernel test robot warning
      drm/amd/pm: drop redundant MEM_TYPE_* macros
      drm/amd/powerplay: optimize amdgpu_dpm_set_clockgating_by_smu()
implementation
      drm/amd/powerplay: drop unnecessary pp_funcs checker
      drm/amd/powerplay: optimize i2c bus access implementation
      drm/amd/powerplay: put those exposed power interfaces in amdgpu_dpm.c
      drm/amd/pm: optimize the power related source code layout
      drm/amd/pm: disable/enable gfx ulv on UMD pstate enter/exit
      drm/amd/pm: add SMU11 common gfx ulv control interface
      drm/amd/pm: disable/enable deep sleep features on UMD pstate enter/ex=
it
      drm/amd/pm: add SMU11 common deep sleep control interface
      drm/amd/pm: correct Vega10 swctf limit setting
      drm/amd/pm: correct Vega12 swctf limit setting
      drm/amd/pm: correct Vega20 swctf limit setting
      drm/amd/pm: correct the thermal alert temperature limit settings
      drm/amd/pm: avoid false alarm due to confusing
softwareshutdowntemp setting
      drm/amd/pm: suppress static checker warning
      drm/amd/pm: wrapper for postponing some setup job after DAL
initializatioa(V2)
      drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL initialization(=
V2)
      drm/amd/pm: put Navi1X umc cdr workaround in post_smu_init
      drm/amd/pm: revise the umc hybrid cdr workaround
      drm/amd/pm: allocate a new buffer for pstate dummy reading
      drm/amd/pm: implement a new umc cdr workaround
      drm/amd/pm: apply the CDR workarounds only with some specific
UMC firmwares(V2)
      drm/amd/pm: correct the requirement for umc cdr workaround
      drm/amd/pm: make namings and comments more readable
      drm/amd/pm: drop unnecessary feature->mutex lock protections(V2)
      drm/amd/pm: drop unnecessary smu_baco->mutex lock protections(V2)
      drm/amd/pm: drop unnecessary table existence and dpm enablement check
      drm/amd/pm: minor cleanups
      drm/amd/pm: drop dead code
      drm/amd/pm: drop unnecessary wrappers around watermark setting
      drm/amd/pm: add Renoir watermark WmType setting
      drm/amd/pm: add Raven2 watermark WmType setting
      drm/amd/pm: process pending AC/DC switch interrupt
      drm/amd/pm: apply no power source workaround if dc reported by gpio
      drm/amd/pm: move NAVI1X power mode switching workaround to post_init
      drm/amd/pm: lower Raven UMD Stable Pstate VCN values
      drm/amd/pm: correct Renoir UMD Stable Pstate settings
      drm/amd/pm: apply dummy reads workaround for CDR enabled only
      drm/amd/powerplay: optimize the mclk dpm policy settings
      drm/amd/pm: correct the pmfw version check for Navi14
      drm/amd/pm: decouple the watermark table setting from socclk/uclk dpm=
s
      drm/amd/pm: drop redundant watermarks bitmap setting
      drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K monitors
      drm/amd/pm: setup APU dpm clock table in SMU HW initialization

Evgeny Novikov (1):
      fbdev: sm712fb: handle ioremap() errors in probe

Fangzhi Zuo (2):
      drm/amd/display: Further fix of psr eDP p-state warning
      drm/amd/display: HDMI remote sink need mode validation for Linux

Felix Kuehling (5):
      Revert "drm/amdkfd: Fix spurious debug exception on gfx10"
      Revert "drm/amdkfd: Unify gfx9/gfx10 context save area layouts"
      drm/amdkfd: call amdgpu_amdkfd_get_unique_id directly
      drm/amdkfd: call amdgpu_amdkfd_get_hive_id directly
      drm/amdgpu: Fix handling of KFD initialization failures

Flora Cui (2):
      drm/amdgpu: drop BOOLEAN define in display part
      drm/amd/display: fix return value check for hdcp_work

Frank Wunderlich (2):
      dt-bindings: mediatek: add mt7623 display-nodes
      drm/mediatek: Add ddp routing for mt7623

Furquan Shaikh (1):
      drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object to
0 in amdgpu_dm_update_backlight_caps

Gary Li (1):
      drm/amd/display: Enable DP YCbCr420 mode support for DCN10

George Kennedy (1):
      fbmem: add margin check to fb_check_caps()

George Shen (2):
      drm/amd/display: Change null plane state swizzle mode to 4kb_s
      drm/amd/display: Rename set_mst_bandwidth to align with DP spec

George Spelvin (1):
      drm/i915/selftests: Avoid passing a random 0 into ilog2

Georgi Djakov (1):
      drm/msm: Remove depends on interconnect

Gerd Hoffmann (7):
      drm/qxl: don't take vga ports on rev5+
      drm/virtio: fix unblank
      drm/virtio: drop virtio_gpu_output->enabled
      drm: allow limiting the scatter list size.
      drm/virtio: use drmm_mode_config_init
      drm/virtio: return virtio_gpu_queue errors
      drm/virtio: add virtio_gpu_cmd_unref_resource error handling

Guchun Chen (21):
      drm/amdgpu: add printing after executing page reservation to eeprom
      drm/amdgpu: add bad page count threshold in module parameter(v3)
      drm/amdgpu: validate bad page threshold in ras(v3)
      drm/amdgpu: add bad gpu tag definition
      drm/amdgpu: break driver init process when it's bad GPU(v5)
      drm/amdgpu: skip bad page reservation once issuing from eeprom write
      drm/amdgpu: schedule ras recovery when reaching bad page threshold(v2=
)
      drm/amdgpu: break GPU recovery once it's in bad state(v4)
      drm/amdgpu: restore ras flags when user resets eeprom(v2)
      drm/amdgpu: add one definition for RAS's sysfs/debugfs name(v2)
      drm/amdgpu: decouple sysfs creating of bad page node
      drm/amdgpu: disable page reservation when amdgpu_bad_page_threshold =
=3D 0
      drm/amdgpu: update eeprom once specifying one bigger threshold(v3)
      drm/amdgpu: bypass querying ras error count registers
      drm/amdgpu: add debugfs node to toggle ras error cnt harvest
      drm/amdgpu: fix NULL pointer access issue when unloading driver
      drm/amdgpu: guard ras debugfs creation/removal based on CONFIG_DEBUG_=
FS
      drm/amdgpu: correct SE number for arcturus gfx ras
      drm/amdgpu: clean up ras sysfs creation (v2)
      drm/amdgpu: fix incorrect comment
      drm/amdgpu: drop duplicated ecc check for vega10 (v5)

Guido G=C3=BCnther (5):
      dt-bindings: panel: rocktech,jh057n00900: Modernize
      dt-bindings: panel: rocktech,jh057n00900: Add myself as maintainer
      dt-bindings: vendor-prefixes: Add mantix vendor prefix
      dt-bindings: Add Mantix MLAF057WE51-X panel bindings
      drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel

Gurchetan Singh (3):
      drm/virtio: Revert "drm/virtio: Call the right shmem helpers"
      drm/virtio: fix uninitialized variable
      drm/virtio: report uuid in debugfs

Gustavo A. R. Silva (2):
      fbdev: Use fallthrough pseudo-keyword
      drm/virtio: Use struct_size() helper in kmalloc()

Hans de Goede (17):
      ACPI / LPSS: Resume Cherry Trail PWM controller in no-irq phase
      ACPI / LPSS: Save Cherry Trail PWM ctx registers only once (at activa=
tion)
      pwm: lpss: Fix off by one error in base_unit math in pwm_lpss_prepare=
()
      pwm: lpss: Add range limit check for the base_unit register value
      pwm: lpss: Add pwm_lpss_prepare_enable() helper
      pwm: lpss: Make pwm_lpss_apply() not rely on existing hardware state
      pwm: lpss: Remove suspend/resume handlers
      pwm: crc: Fix period / duty_cycle times being off by a factor of 256
      pwm: crc: Fix off-by-one error in the clock-divider calculations
      pwm: crc: Fix period changes not having any effect
      pwm: crc: Enable/disable PWM output on enable/disable
      pwm: crc: Implement apply() method to support the new atomic PWM API
      pwm: crc: Implement get_state() method
      drm/i915: panel: Add get_vbt_pwm_freq() helper
      drm/i915: panel: Honor the VBT PWM frequency for devs with an
external PWM controller
      drm/i915: panel: Honor the VBT PWM min setting for devs with an
external PWM controller
      drm/i915: panel: Use atomic PWM API for devs with an external
PWM controller

Harmanprit Tatla (2):
      drm/amd/display: Add CP_IRQ clear capability
      drm/amd/display: Fix CP_IRQ clear bit and logic

Harry Wentland (1):
      drm/amd/display: Fix logger context

Hawking Zhang (4):
      drm/amdgpu: add helper function for indirect reg access (v3)
      drm/amdgpu: switch to indirect reg access helper
      drm/amdgpu: support indirect access reg outside of mmio bar (v2)
      drm/amdgpu: enable GDDR6 save-restore support for navy_flounder

Hoegeun Kwon (1):
      drm/vc4: hdmi: Add pixel BVB clock control

Huang Rui (8):
      drm/amdgpu: add member to store vm fault interrupt masks
      drm/amdgpu: abstract set_vm_fault_masks function to refine the progra=
mming
      drm/amdgpu: add vmhub funcs helper (v2)
      drm/amdgpu: move get_invalidate_req function into gfxhub/mmhub level
      drm/amdgpu: won't include gc and mmhub register headers in GMC block
      drm/amdgpu: skip crit temperature values on APU (v2)
      drm/amdkfd: fix the wrong sdma instance query for renoir
      drm/amdkfd: implement the dGPU fallback path for apu (v6)

Icenowy Zheng (3):
      drm/panel: ilitek-ili9881c: prepare for adding support for extra pane=
ls
      dt-bindings: ili9881c: add compatible string for Feixin K101-IM2BYL02
      drm/panel: ilitek-ili9881c: add support for Feixin K101-IM2BYL02 pane=
l

Igor Kravchenko (2):
      drm/amd/display: Read VBIOS Golden Settings Tbl
      drm/amd/display: Display goes blank after inst

Imre Deak (4):
      drm/i915/ddi: Don't frob the DP link scramble disabling flag
      drm/i915/ddi: Don't rewrite DDI_BUF_CTL reg during DP link training
      drm/i915/tgl: Make sure TC-cold is blocked before enabling TC
AUX power wells
      drm/i915/tgl: Fix TC-cold block/unblock sequence

Jaehyun Chung (3):
      drm/amd/display: Blank stream before destroying HDCP session
      drm/amd/display: Mask DPCD field to avoid reading unsupported field v=
alue
      drm/amd/display: Revert HDCP disable sequence change

Jagan Teki (2):
      dt-bindings: display: simple: Add AM-1280800N3TZQW-T00H
      drm/panel: simple: Add AM-1280800N3TZQW-T00H

James Zhu (6):
      drm/amdgpu/jpeg: Remove extra asic type check
      drm/amdgpu: Remove extra asic type check
      drm/amdgpu/jpeg3.0: remove extra asic type check
      drm/amdgpu/vcn3.0: remove extra asic type check
      Revert "drm/amdgpu/vcn3.0: remove extra asic type check"
      drm/amdgpu/vcn3.0: only SIENNA_CICHLID need specify instance for dec/=
enc

Jani Nikula (7):
      drm/i915: split intel_modeset_init() pre/post gem init
      drm/i915: move more display related probe to intel_modeset_init_noirq=
()
      drm/i915: split out intel_modeset_driver_remove_nogem() and simplify
      drm/i915: remove the extra modeset init layer
      drm/i915: disable all display features when no display
      drm/i915: move gen4 GCDGMBUS save/restore to display save/restore
      drm/i915: move gmbus restore to i915_restore_display

Jason Yan (6):
      video: fbdev: kyro: remove set but not used 'ulBestVCO'
      video: fbdev: kyro: remove set but not used 'ulCoreClock'
      drm/i810: make i810_flush_queue() return void
      drm: xlnx: remove defined but not used 'scaling_factors_666'
      drm/amd/display: make get_color_space_type() static
      drm/amd/display: make two symbols static

Jay Cornwall (2):
      drm/amdkfd: Fix spurious debug exception on gfx10
      drm/amdkfd: Fix spurious debug exception on gfx10

Jean Delvare (1):
      drm/amdgpu: restore proper ref count in amdgpu_display_crtc_set_confi=
g

Jeykumar Sankaran (1):
      drm/msm/dpu: add display port support in DPU

Jia Yang (1):
      drm: fix double free for gbo in drm_gem_vram_init and drm_gem_vram_cr=
eate

Jiansong Chen (17):
      drm/amd/powerplay: update driver if version for navy_flounder
      drm/amdgpu: update GC golden setting for navy_flounder
      drm/amdgpu: enable GFXOFF for navy_flounder
      drm/amdgpu: disable gfxoff for navy_flounder
      Revert "drm/amdgpu: disable gfxoff for navy_flounder"
      drm/amd/pm: update driver if version for navy_flounder
      drm/amd/pm: enable run_btc callback for sienna_cichlid
      drm/amd/pm: set VCN pg per instances
      drm/amdgpu/gfx10: refine mgcg setting
      drm/amdgpu: use MODE1 reset for navy_flounder by default
      drm/amdgpu: disable runtime pm for navy_flounder
      drm/amd/pm: enable MP0 DPM for sienna_cichlid
      drm/amd/pm: update driver if version for navy_flounder
      drm/amd/pm: support runtime pptable update for sienna_cichlid etc.
      drm/amdgpu: declare ta firmware for navy_flounder
      drm/amdgpu: remove gpu_info fw support for sienna_cichlid etc.
      drm/amdgpu: disable gfxoff temporarily for navy_flounder

Jiawei (1):
      drm/amdgpu: simplify hw status clear/set logic

JinZe.Xu (2):
      drm/amd/display: Use helper function to check for HDMI signal
      drm/amd/display: Detect plane change when detect pipe change.

Jing Xiangfeng (1):
      fbcon: Remove the superfluous break

Jingwen Chen (3):
      drm/amd/pm: Skip smu_post_init in SRIOV
      drm/amd/pm: Skip use smc fw data in SRIOV
      drm/amd: Skip not used microcode loading in SRIOV

Joe Perches (2):
      drm: Remove unnecessary drm_panel_attach and drm_panel_detach
      video: fbdev: tgafb: Avoid comma separated statements

John Clements (9):
      drm/amdgpu: expand sienna chichlid reg access  support
      drm/amdgpu: move umc specific macros to header
      drm/amdgpu: add umc v8_7_0 IP headers
      drm/amdgpu: add support for umc 8.7 ras functions
      drm/amdgpu: enable umc 8.7 functions in gmc v10
      drm/amdgpu: enable RAS support for sienna cichlid
      drm/amdgpu: added RAS EEPROM device support check
      drm/amdgpu: Update RAS init handling
      drm/amdgpu: disable sienna chichlid UMC RAS

Jonathan Kim (1):
      drm/amdgpu: stop resetting xgmi perfmons on disable

Jonathan Marek (3):
      drm/msm/dsi: remove unused clk_pre/clk_post in msm_dsi_dphy_timing
      drm/msm/dsi: add DSI config for sm8150 and sm8250
      drm/msm/dsi: add support for 7nm DSI PHY/PLL

Jordan Crouse (10):
      drm/msm: Add a context pointer to the submitqueue
      drm/msm: Drop context arg to gpu->submit()
      drm/msm: Set the global virtual address range from the IOMMU domain
      drm/msm: Add support to create a local pagetable
      drm/msm: Add support for private address space instances
      drm/msm/a6xx: Add support for per-instance pagetables
      drm/msm: Allow a5xx to mark the RPTR shadow as privileged
      drm/msm: a6xx: Use WHERE_AM_I for eligible targets
      drm/msm: Get rid of the REG_ADRENO offsets
      drm/msm: Fix the a650 hw_apriv check

Joshua Aberback (4):
      drm/amd/display: Adjust static-ness of resource functions
      drm/amd/display: Compare mpcc_inst to mpcc_count instead of a constan=
t
      drm/amd/display: Update idle optimization handling
      drm/amd/display: Calc DLG from dummy p-state if full p-state unsuppor=
ted

Josip Pavic (1):
      drm/amd/display: remove dc context from transfer function

Jos=C3=A9 Roberto de Souza (15):
      drm/i915/display: Implement HOBL
      drm/i915: Implement WA 14011294188
      drm/i915/tgl: Set subplatforms
      drm/i915/tgl: Add new voltage swing table
      drm/i915: Initial implementation of PSR2 selective fetch
      drm/i915/display: Implement WA 1408330847
      drm/i915: Update TGL and RKL DMC firmware versions
      drm/i915: Update TGL and RKL HuC firmware versions
      drm/i915/display: Compute has_drrs after compute has_psr
      drm/i915/display: Disable DRRS when needed in fastsets
      drm/i915/display: Fix DRRS debugfs
      drm/i915/tgl: Fix stepping WA matching
      drm/i915/display/tgl: Use TGL DP tables for eDP ports without
low power support
      drm/i915/display/ehl: Use EHL DP tables for eDP ports without
low power support
      drm/i915/ehl: Update voltage swing table

Julia Lawall (1):
      agp: use semicolons rather than commas to separate statements

Jun Lei (3):
      drm/amd/display: Disable idle optimizations before programming DCN
      drm/amd/display: update nv1x stutter latencies
      drm/amd/display: get socBB from VBIOS

Kai Vehmanen (1):
      drm/i915: fix regression leading to display audio probe failure on GL=
K

Kai-Heng Feng (1):
      drm/radeon: Prefer lower feedback dividers

Kalyan Thota (1):
      drm/msm/dpu: add support for clk and bw scaling for display

Kenneth Feng (1):
      drm/amd/powerplay: remove the dpm checking in the boot sequence

Kent Russell (3):
      drm/amdkfd: Calculate CPU VCRAT size dynamically (v2)
      drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT
      drm/amdgpu: Use SKU instead of DID for FRU check v2

Kevin Wang (5):
      drm/amd/swsmu: allow asic to handle sensor type by itself
      drm/amdgpu: fix uninit-value in arcturus_log_thermal_throttling_event=
()
      drm/amdgpu: fix amdgpu_bo_release_notify() comment error
      drm/amdgpu: add condition check for trace_amdgpu_cs()
      drm/amd/pm: fix is_dpm_running() run error on 32bit system

Kristian H. Kristensen (1):
      udmabuf: Add missing compact_ioctl

Krunoslav Kovac (1):
      drm/amd/display: fix pow() crashing when given base 0

Krzysztof Kozlowski (2):
      drm/exynos: dsi: Simplify with dev_err_probe()
      drm/exynos: hdmi: Simplify with dev_err_probe()

Kuninori Morimoto (4):
      dt-bindings: display: renesas: du: Document the r8a77961 bindings
      dt-bindings: display: renesas: dw-hdmi: Tidyup example compatible
      dt-bindings: display: renesas: dw-hdmi: Add R8A77961 support
      drm: rcar-du: Add r8a77961 support

Kuogee Hsieh (1):
      drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets

Lad Prabhakar (5):
      dt-bindings: display: renesas,du: Document the r8a7742 bindings
      drm: rcar-du: Add r8a7742 support
      dt-bindings: display: renesas,lvds: Document r8a7742 bindings
      drm: rcar-du: lvds: Add r8a7742 support
      drm: rcar-du: Update description for DRM_RCAR_DW_HDMI Kconfig entry

Laurent Morichetti (1):
      drm/amdkfd: Unify gfx9/gfx10 context save area layouts

Laurent Pinchart (27):
      drm: mxsfb: Remove fbdev leftovers
      drm: mxsfb: Use drm_panel_bridge
      drm: mxsfb: Use BIT() macro to define register bitfields
      drm: mxsfb: Remove unused macros from mxsfb_regs.h
      drm: mxsfb: Clarify format and bus width configuration
      drm: mxsfb: Pass mxsfb_drm_private pointer to mxsfb_reset_block()
      drm: mxsfb: Use LCDC_CTRL register name explicitly
      drm: mxsfb: Remove register definitions from mxsfb_crtc.c
      drm: mxsfb: Remove unneeded includes
      drm: mxsfb: Rename mxsfb_crtc.c to mxsfb_kms.c
      drm: mxsfb: Stop using DRM simple display pipeline helper
      drm: mxsfb: Move vblank event arm to CRTC .atomic_flush()
      drm: mxsfb: Don't touch AXI clock in IRQ context
      drm: mxsfb: Enable vblank handling
      drm: mxsfb: Remove mxsfb_devdata unused fields
      drm: mxsfb: Add i.MX7 and i.MX8M to the list of supported SoCs in Kco=
nfig
      drm: mxsfb: Update internal IP version number for i.MX6SX
      drm: mxsfb: Drop non-OF support
      drm: mxsfb: Turn mxsfb_set_pixel_fmt() into a void function
      drm: mxsfb: Merge mxsfb_set_pixel_fmt() and mxsfb_set_bus_fmt()
      drm: mxsfb: Remove unnecessary spaces after tab
      drm: mxsfb: Support the alpha plane
      drm: panel: Fix bus format for OrtusTech COM43H4M85ULC panel
      drm: panel: Fix bpc for OrtusTech COM43H4M85ULC panel
      drm: rcar-du: Fix pitch handling for fully planar YUV formats
      drm: rcar-du: Fix crash when enabling a non-visible plane
      drm: rcar-du: Put reference to VSP device

Laurentiu Palcu (6):
      drm/imx: compile imx directory by default
      drm/imx: Add initial support for DCSS on iMX8MQ
      drm/imx/dcss: use drm_bridge_connector API
      MAINTAINERS: Add entry for i.MX 8MQ DCSS driver
      dt-bindings: display: imx: add bindings for DCSS
      drm/imx/dcss: fix compilation issue on 32bit

Leo Liu (1):
      drm/amdgpu/jpeg: remove redundant check when it returns

Lewis Huang (3):
      drm/amd/display: Add extra T3 delay
      drm/amd/display: update clock when non-seamless boot stream exist
      drm/amd/display: [FIX] update clock under two conditions

Li Heng (2):
      drm/amdgpu: Remove redundant NULL check
      drm/amd/powerplay: Remove unneeded cast from memory allocation

Likun Gao (10):
      drm/amd/powerplay: skip invalid msg when smu set mp1 state
      drm/amd/powerplay: add msg map for mode1 reset
      drm/amd/powerplay: correct smu message for vf mode
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/powerplay: update driver if file for sienna_cichlid
      drm/amd/powerplay: update driver if file for sienna_cichlid
      drm/amdgpu: use mode1 reset by default for sienna_cichlid
      drm/amd/pm: update driver if file for sienna cichlid
      drm/amdgpu: add device ID for sienna_cichlid (v2)
      drm/amd/pm: update driver if file for sienna cichlid

Linus Walleij (18):
      drm: pl111: Update documentation
      omapfb/dss: Include the right header
      drm/panel-notatek-nt35510: Fix MTP read init
      drm/mcde: Rename flow function
      drm/mcde: Fix display data flow control
      drm/mcde: Improve pixel fetcher FIFO depth setting
      drm/mcde: Support using DSI in LP mode
      drm/mcde: Fix display pipeline restart
      drm/mcde: Enable the DSI link with display
      drm/mcde: Retry DSI read/write transactions
      drm: gma500: Convert to GPIO descriptors
      drm: omapdrm: Delete surplus GPIO includes
      drm/panel: s6e63m0: Break out SPI transport
      drm/panel: s6e63m0: Add DSI transport
      drm/panel: s6e63m0: Add reading functionality
      drm/panel: s6e63m0: Add code to identify panel
      drm/panel: s6e63m0: Order enable/disable sequence
      drm/panel: s6e63m0: Fix up DRM_DEV* regression

Lionel Landwerlin (3):
      drm/i915: introduce a mechanism to extend execbuf2
      drm/i915: add syncobj timeline support
      drm/i915: break TGL pci-ids in GT 1 & 2

Liu ChengZhe (4):
      drm/amdgpu: fix PSP autoload twice in FLR
      drm amdgpu: Skip tmr load for SRIOV
      drm/amdgpu: Skip some registers config for SRIOV
      drm/amdgpu: Do gpu recovery when no job is running

Liu Shixin (2):
      drm/amd/pm: simplify the return expression of smu_hw_fini
      drm/amdgpu/gmc9: simplify the return expression of gmc_v9_0_suspend

Luben Tuikov (8):
      drm/scheduler: Scheduler priority fixes (v2)
      drm/scheduler: Remove priority macro INVALID (v2)
      drm/amdgpu: drm_device to amdgpu_device by inline-f (v2)
      drm/amdgpu: Get DRM dev from adev by inline-f
      drm/amdgpu: Embed drm_device into amdgpu_device (v3)
      drm/amdgpu: Remove superfluous NULL check
      drm/amdgpu: No sysfs, not an error condition
      drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)

Luca Weiss (1):
      drm/msm/adreno: fix probe without iommu

Lukas Bulwahn (2):
      drm/amd/display: remove unintended executable mode
      MAINTAINERS: make linux-aspeed list remarks consistent

Luo Jiaxing (1):
      drm/msm/dpu: remove unused variables new_cnt and old_cnt in
dpu_encoder_phys_vid_vblank_irq()

Lyude Paul (20):
      drm/nouveau/kms: Fix some indenting in nouveau_dp_detect()
      drm/nouveau/kms/nv50-: Remove open-coded drm_dp_read_desc()
      drm/nouveau/kms/nv50-: Just use drm_dp_dpcd_read() in nouveau_dp.c
      drm/nouveau/kms/nv50-: Use macros for DP registers in nouveau_dp.c
      drm/nouveau/kms: Don't clear DP_MST_CTRL DPCD in nv50_mstm_new()
      drm/nouveau/kms: Search for encoders' connectors properly
      drm/nouveau/kms/nv50-: Use drm_dp_dpcd_(readb|writeb)() in
nv50_sor_disable()
      drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling
      drm/i915/dp: Extract drm_dp_read_mst_cap()
      drm/nouveau/kms: Use new drm_dp_read_mst_cap() helper for
checking MST caps
      drm/nouveau/kms: Move drm_dp_cec_unset_edid() into
nouveau_connector_detect()
      drm/nouveau/kms: Only use hpd_work for reprobing in HPD paths
      drm/i915/dp: Extract drm_dp_read_downstream_info()
      drm/nouveau/kms/nv50-: Use downstream DP clock limits for mode valida=
tion
      drm/i915/dp: Extract drm_dp_read_sink_count_cap()
      drm/i915/dp: Extract drm_dp_read_sink_count()
      drm/nouveau/kms/nv50-: Add support for DP_SINK_COUNT
      drm/nouveau/kms: Don't change EDID when it hasn't actually changed
      drm/i915/dp: Extract drm_dp_read_dpcd_caps()
      drm/nouveau/kms: Start using drm_dp_read_dpcd_caps()

Maarten Lankhorst (25):
      Revert "drm/i915/gem: Async GPU relocations only"
      drm/i915: Revert relocation chaining commits.
      Revert "drm/i915/gem: Drop relocation slowpath".
      Revert "drm/i915/gem: Split eb_vma into its own allocation"
      drm/i915: Add an implementation for i915_gem_ww_ctx locking, v2.
      drm/i915: Remove locking from i915_gem_object_prepare_read/write
      drm/i915: Parse command buffer earlier in eb_relocate(slow)
      drm/i915: Use per object locking in execbuf, v12.
      drm/i915: Use ww locking in intel_renderstate.
      drm/i915: Add ww context handling to context_barrier_task
      drm/i915: Nuke arguments to eb_pin_engine
      drm/i915: Pin engine before pinning all objects, v5.
      drm/i915: Rework intel_context pinning to do everything outside
of pin_mutex
      drm/i915: Make sure execbuffer always passes ww state to i915_vma_pin=
.
      drm/i915: Convert i915_gem_object/client_blt.c to use ww locking
as well, v2.
      drm/i915: Kill last user of intel_context_create_request outside
of selftests
      drm/i915: Convert i915_perf to ww locking as well
      drm/i915: Dirty hack to fix selftests locking inversion
      drm/i915/selftests: Fix locking inversion in lrc selftest.
      drm/i915: Use ww pinning for intel_context_create_request()
      drm/i915: Move i915_vma_lock in the selftests to avoid lock inversion=
, v3.
      drm/i915: Add ww locking to vm_fault_gtt
      drm/i915: Add ww locking to pin_to_display_plane, v2.
      drm/i915: Fix slightly botched merge in __reloc_entry_gpu
      drm/i915: Fix uninitialised variable in intel_context_create_request.

Marek Szyprowski (27):
      drm: prime: add common helper to check scatterlist contiguity
      drm: prime: use sgtable iterators in drm_prime_sg_to_page_addr_arrays=
()
      drm: core: fix common struct sg_table related issues
      drm: armada: fix common struct sg_table related issues
      drm: etnaviv: fix common struct sg_table related issues
      drm: exynos: use common helper for a scatterlist contiguity check
      drm: exynos: fix common struct sg_table related issues
      drm: i915: fix common struct sg_table related issues
      drm: lima: fix common struct sg_table related issues
      drm: mediatek: use common helper for a scatterlist contiguity check
      drm: mediatek: use common helper for extracting pages array
      drm: msm: fix common struct sg_table related issues
      drm: omapdrm: use common helper for extracting pages array
      drm: panfrost: fix common struct sg_table related issues
      drm: rockchip: use common helper for a scatterlist contiguity check
      drm: rockchip: fix common struct sg_table related issues
      drm: tegra: fix common struct sg_table related issues
      drm: v3d: fix common struct sg_table related issues
      drm: virtio: fix common struct sg_table related issues
      drm: vmwgfx: fix common struct sg_table related issues
      drm: xen: fix common struct sg_table related issues
      xen: gntdev: fix common struct sg_table related issues
      drm: host1x: fix common struct sg_table related issues
      drm: rcar-du: fix common struct sg_table related issues
      dmabuf: fix common struct sg_table related issues
      samples: vfio-mdev/mbochs: fix common struct sg_table related issues
      drm/exynos: Fix dma_parms allocation

Marek Vasut (8):
      dt-bindings: Add vendor prefix for Powertip
      dt-bindings: Add DT bindings for Powertip PH800480T013
      drm/panel: simple: Add Powertip PH800480T013 panel
      dt-bindings: Add vendor prefix for Chefree
      dt-bindings: Add DT bindings for Chefree CH101OLHLWH-002
      drm/panel: simple: Add Chefree CH101OLHLWH-002 panel
      dt-bindings: Add DT bindings for Toshiba TC358762 DSI-to-DPI bridge
      drm/bridge: tc358762: Add basic driver for Toshiba TC358762
DSI-to-DPI bridge

Marian-Cristian Rotariu (5):
      dt-bindings: display: renesas,du: Document r8a774e1 bindings
      drm: rcar-du: Add support for R8A774E1 SoC
      dt-bindings: display: renesas,lvds: Document r8a774e1 bindings
      dt-bindings: display: renesas,dw-hdmi: Add r8a774e1 support
      drm: rcar-du: lvds: Add support for R8A774E1 SoC

Martin Leung (1):
      drm/amd/display: adding pathway to retrieve stutter period

Martin Tsai (1):
      drm/amd/display: Check lane status again after link training done

Matt Atwood (1):
      drm/i915: Apply Wa_14011264657:gen11+

Matt Roper (8):
      drm/i915/rkl: Handle new DPCLKA_CFGCR0 layout
      drm/i915/rkl: Add initial workarounds
      drm/i915/rkl: Add DPLL4 support
      drm/i915/rkl: Handle HTI
      drm/i915/rkl: Add Wa_14011224835 for PHY B initialization
      drm/i915: Update bw_buddy pagemask table
      Revert "drm/i915/rkl: Add Wa_14011224835 for PHY B initialization"
      drm/i915/kbl: Fix revision ID checks

Matthew Auld (1):
      drm/i915: check i915_vm_alloc_pt_stash for errors

Mauro Rossi (26):
      drm/amd/display: add asics info for SI parts
      drm/amd/display: dc/dce: add initial DCE6 support (v10)
      drm/amd/display: dc/core: add SI/DCE6 support (v2)
      drm/amd/display: dc/bios: add support for DCE6
      drm/amd/display: dc/gpio: add support for DCE6 (v2)
      drm/amd/display: dc/irq: add support for DCE6 (v4)
      drm/amd/display: amdgpu_dm: add SI support (v4)
      drm/amd/display: dc/clk_mgr: add support for SI parts (v2)
      drm/amd/display: dc/dce60: set max_cursor_size to 64
      drm/amd/display: dce_audio: add DCE6 specific macros,functions
      drm/amd/display: dce_dmcu: add DCE6 specific macros,functions
      drm/amd/display: dce_hwseq: add DCE6 specific macros,functions
      drm/amd/display: dce_ipp: add DCE6 specific macros,functions
      drm/amd/display: dce_link_encoder: add DCE6 specific macros,functions
      drm/amd/display: dce_mem_input: add DCE6 specific macros,functions (v=
2)
      drm/amd/display: dce_opp: add DCE6 specific macros,functions
      drm/amd/display: dce_transform: add DCE6 specific macros,functions
      drm/amd/display: dce_transform: DCE6 Scaling Horizontal Filter Init (=
v2)
      drm/amd/display: dce60_hw_sequencer: add DCE6 specific functions (v2)
      drm/amd/display: dce60_hw_sequencer: add DCE6 specific .cursor_lock
      drm/amd/display: dce60_timing_generator: add DCE6 specific functions =
(v2)
      drm/amd/display: dc/dce60: use DCE6 headers (v6)
      drm/amd/display: create plane rotation property for Bonaire and later
      drm/amdgpu: enable DC support for SI parts (v2)
      drm/amd/display: enable SI support in the Kconfig (v2)
      drm/amd/display: dc/clk_mgr: make function static

Maxime Ripard (79):
      Merge v5.9-rc1 into drm-misc-next
      drm/sun4i: lvds: Invert the LVDS polarity
      dt-bindings: display: Add support for the BCM2711 HVS
      drm/vc4: hvs: Boost the core clock during modeset
      drm/vc4: plane: Create more planes
      drm/vc4: crtc: Deal with different number of pixel per clock
      drm/vc4: crtc: Use a shared interrupt
      drm/vc4: crtc: Move the cob allocation outside of bind
      drm/vc4: crtc: Rename HVS channel to output
      drm/vc4: crtc: Use local chan variable
      drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
      drm/vc4: kms: Convert to for_each_new_crtc_state
      drm/vc4: crtc: Assign output to channel automatically
      drm/vc4: crtc: Add FIFO depth to vc4_crtc_data
      drm/vc4: crtc: Add function to compute FIFO level bits
      drm/vc4: crtc: Rename HDMI encoder type to HDMI0
      drm/vc4: crtc: Add HDMI1 encoder type
      drm/vc4: crtc: Disable color management for HVS5
      drm/vc4: crtc: Turn pixelvalve reset into a function
      drm/vc4: crtc: Move PV dump to config_pv
      drm/vc4: crtc: Move HVS init and close to a function
      drm/vc4: crtc: Move the HVS gamma LUT setup to our init function
      drm/vc4: hvs: Make sure our channel is reset
      drm/vc4: crtc: Remove mode_set_nofb
      drm/vc4: crtc: Remove redundant pixelvalve reset
      drm/vc4: crtc: Move HVS channel init before the PV initialisation
      drm/vc4: encoder: Add finer-grained encoder callbacks
      drm/vc4: crtc: Add a delay after disabling the PixelValve output
      drm/vc4: crtc: Clear the PixelValve FIFO on disable
      drm/vc4: crtc: Clear the PixelValve FIFO during configuration
      drm/vc4: hvs: Make the stop_channel function public
      drm/vc4: hvs: Introduce a function to get the assigned FIFO
      drm/vc4: crtc: Move the CRTC disable out
      drm/vc4: drv: Disable the CRTC at boot time
      dt-bindings: display: vc4: pv: Add BCM2711 pixel valves
      drm/vc4: crtc: Add BCM2711 pixelvalves
      drm/vc4: hdmi: Use debugfs private field
      drm/vc4: hdmi: Move structure to header
      drm/vc4: hdmi: rework connectors and encoders
      drm/vc4: hdmi: Remove DDC argument to connector_init
      drm/vc4: hdmi: Rename hdmi to vc4_hdmi
      drm/vc4: hdmi: Move accessors to vc4_hdmi
      drm/vc4: hdmi: Use local vc4_hdmi directly
      drm/vc4: hdmi: Add container_of macros for encoders and connectors
      drm/vc4: hdmi: Pass vc4_hdmi to CEC code
      drm/vc4: hdmi: Retrieve the vc4_hdmi at unbind using our device
      drm/vc4: hdmi: Remove vc4_dev hdmi pointer
      drm/vc4: hdmi: Remove vc4_hdmi_connector
      drm/vc4: hdmi: Introduce resource init and variant
      drm/vc4: hdmi: Implement a register layout abstraction
      drm/vc4: hdmi: Add reset callback
      drm/vc4: hdmi: Add PHY init and disable function
      drm/vc4: hdmi: Add PHY RNG enable / disable function
      drm/vc4: hdmi: Add a CSC setup callback
      drm/vc4: hdmi: Add a set_timings callback
      drm/vc4: hdmi: Store the encoder type in the variant structure
      drm/vc4: hdmi: Deal with multiple debugfs files
      drm/vc4: hdmi: Move CEC init to its own function
      drm/vc4: hdmi: Add CEC support flag
      drm/vc4: hdmi: Remove unused CEC_CLOCK_DIV define
      drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
      drm/vc4: hdmi: Adjust HSM clock rate depending on pixel rate
      drm/vc4: hdmi: Use clk_set_min_rate instead
      drm/vc4: hdmi: Deal with multiple ALSA cards
      drm/vc4: hdmi: Remove register dumps in enable
      drm/vc4: hdmi: Always recenter the HDMI FIFO
      drm/vc4: hdmi: Implement finer-grained hooks
      drm/vc4: hdmi: Do the VID_CTL configuration at once
      drm/vc4: hdmi: Switch to blank pixels when disabled
      drm/vc4: hdmi: Support the BCM2711 HDMI controllers
      dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI controllers binding=
s
      dt-bindings: display: vc4: Document BCM2711 VC5
      drm/vc4: drv: Support BCM2711
      Merge drm/drm-next into drm-misc-next
      Merge branch 'virtio-shm' of
git://git.kernel.org/.../mszeredi/fuse into drm-misc-next
      drm/vc4: hvs: Pull the state of all the CRTCs prior to PV muxing
      drm/vc4: kms: Assign a FIFO to enabled CRTCs instead of active
      drm/vc4: crtc: Rework a bit the CRTC state code
      drm/vc4: crtc: Keep the previously assigned HVS FIFO

Mazin Rezk (1):
      drm/amd/display: Clear dm_state for fast updates

Melissa Wen (4):
      drm/vkms: fix xrgb on compute crc
      drm/vkms: guarantee vblank when capturing crc
      drm/vkms: add alpha-premultiplied color blending
      MAINTAINERS: add entry for VKMS

Michel D=C3=A4nzer (2):
      drm/amdgpu/dc: Simplify drm_crtc_state::active checks
      drm/amdgpu/dc: Require primary plane to be enabled whenever the CRTC =
is

Mika Kuoppala (1):
      drm/i915: Fix cmd parser desc matching with masks

Mike Rapoport (1):
      fbdev: remove mbx framebuffer driver

Monk Liu (2):
      drm/amdgpu: introduce a new parameter to configure how many KCQ
we want(v5)
      drm/amdgpu: fix reload KMD hang on GFX10 KIQ

Mukul Joshi (8):
      drm/amdkfd: Add thermal throttling SMI event
      drm/amdkfd: Replace bitmask with event idx in SMI event msg
      drm/amdkfd: Initialize SDMA activity counter to 0
      drm/amdkfd: sparse: Fix warning in reading SDMA counters
      drm/amdkfd: Add GPU reset SMI event
      include/uapi/linux: Fix indentation in kfd_smi_event enum
      drm/amdgpu: Enable SDMA utilization for Arcturus
      drm/amdkfd: Move process doorbell allocation into kfd device

Nadezda Lutovinova (1):
      drm/brige/megachips: Add checking if ge_b850v3_lvds_init() is
working correctly

Nathan Chancellor (3):
      drm/i915/display: Ensure that ret is always initialized in
icl_combo_phy_verify_state
      drm/vc4: Update type of reg parameter in vc4_hdmi_{read,write}
      drm/vc4: Fix bitwise OR versus ternary operator in vc4_plane_mode_set

Naveed Ashfaq (1):
      drm/amd/display: Fixed Intermittent blue screen on OLED panel

Navid Emamdoost (1):
      drm/panfrost: perfcnt: fix ref count leak in
panfrost_perfcnt_enable_locked

Neil Armstrong (5):
      drm/bridge: dw-mipi-dsi: fix dw_mipi_dsi_debugfs_show/write warnings
      drm/bridge: dw-mipi-dsi: permit configuring the escape clock rate
      drm/panfrost: add support for vendor quirk
      drm/panfrost: add amlogic reset quirk callback
      drm/panfrost: add Amlogic GPU integration quirks

Nicholas Kazlauskas (8):
      drm/amd/display: Store tiling_flags and tmz_surface on dm_plane_state
      drm/amd/display: Reset plane when tiling flags change
      drm/amd/display: Avoid using unvalidated tiling_flags and
tmz_surface in prepare_planes
      drm/amd/display: Use validated tiling_flags and tmz_surface in commit=
_tail
      drm/amd/display: Reset plane for anything that's not a FAST update
      drm/amd/display: Drop dm_determine_update_type_for_commit
      drm/amd/display: Reject overlay plane configurations in
multi-display scenarios
      drm/amd/powerplay: Fix hardmins not being sent to SMU for RV

Nirmoy Das (3):
      drm/amdgpu: pass NULL pointer instead of 0
      drm/amdgpu: fix compiler warnings
      drm/amdgpu: disable gpu-sched load balance for uvd

Oak Zeng (4):
      drm/amdgpu: Use function pointer for some mmhub functions
      drm/amdgpu: Add comment to function amdgpu_ttm_alloc_gart
      drm/amdgpu: More accurate description of a function param
      drm/amdgpu: use function pointer for gfxhub functions

Oleg Vasilev (4):
      drm: report dp downstream port type as a subconnector property
      drm/i915: utilize subconnector property for DP
      drm/amdgpu: utilize subconnector property for DP through atombios
      drm/amdgpu: utilize subconnector property for DP through DisplayManag=
er

Ondrej Jirman (1):
      MAINTAINERS: Update entry for st7703 driver after the rename

Paul Cercueil (15):
      drm/ingenic: Handle errors of drm_atomic_get_plane_state
      drm/ingenic: Validate mode in a .mode_valid callback
      drm/ingenic: ipu: Only restart manually on older SoCs
      drm/ingenic: ipu: Remove YUV422 from supported formats on JZ4725B
      drm/ingenic: ipu: Only enable clock when needed
      drm/panel: novatek,nt39016: Handle backlight the standard way
      drm/panel: novatek,nt39016: Add missing CR to error messages
      drm/panel: simple: Convert sharp,ls020b1dd01d from timings to videomo=
de
      drm/panel: simple: Tweak timings of sharp,ls020b1dd01d for perfect 60=
Hz
      drm/panel: simple: Add 50Hz mode for sharp,ls020b1dd01d
      drm/panel: novatek,nt39016: Reorder calls in probe
      drm/panel: novatek,nt39016: Remove 'dev' field in priv struct
      gpu/drm: ingenic: Add option to mmap GEM buffers cached
      Revert "gpu/drm: ingenic: Add option to mmap GEM buffers cached"
      drm/ingenic: Fix bad revert

Paul Hsieh (1):
      drm/amd/display: Fix DFPstate hang due to view port changed

Paul Menzel (3):
      kernel/params.c: Align last argument with a tab
      moduleparams: Add hexint type parameter
      drm/amdgpu: Change type of module param `ppfeaturemask` to hexint

Peikang Zhang (2):
      drm/amd/display: Bug in dce_is_panel_backlight_on()
      drm/amd/display: eDP intermittent black screen during PnP

Peilin Ye (1):
      drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()

Pekka Paalanen (1):
      drm/doc: device hot-unplug for userspace

Philip Cox (4):
      drm/amdkfd: Add some eveiction debugging code
      drm/amdkfd: Add process eviction counters to sysfs
      drm/amdkfd: Reduce eviction/restore message levels
      drm/amdkfd: Fix kfd init stack dump

Philip Yang (2):
      drm/amdkfd: option to disable system mem limit
      drm/amdgpu: prevent double kfree ttm->sg

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: new ids flag for tmz (v2)

Prike.Liang (2):
      drm/amdgpu: enable ATHUB clock gatting
      drm/amdgpu: enable HDP clock gatting

Qian Cai (1):
      drm: rcar-du: Make DRM_RCAR_WRITEBACK depends on DRM_RCAR_DU

Qinglang Miao (7):
      drm/vgem: add missing platform_device_unregister() in vgem_init()
      drm/vkms: add missing platform_device_unregister() in vkms_init()
      drm/v3d: convert to use module_platform_driver
      drm/amd/display: convert to use le16_add_cpu()
      drm/msm/dpu: Convert to DEFINE_SHOW_ATTRIBUTE
      drm/amdgpu/mes: simplify the return expression of mes_v10_1_ring_init
      drm/amdgpu: simplify the return expression

Qingqing Zhuo (1):
      drm/amd/display: Screen corruption on dual displays (DP+USB-C)

Ramesh Errabolu (4):
      drm/amd/amdgpu: Clean up header file of symbols that are defined
to be static
      drm/amd/amdgpu: Prepare implementation to support reporting of CU usa=
ge
      drm/amd/amdgpu: Define and implement a function that collects
number of waves that are in flight.
      drm/amd/amdkfd: Surface files in Sysfs to allow users to get
number of compute units that are in use.

Randy Dunlap (6):
      drm: ast: fix double __iomem sparse warning
      amdgpu: fix Documentation builds for pm/ file movement
      drm: virtio: fix kconfig dependency warning
      dma-buf: fix kernel-doc warning in dma-fence.c
      dma-buf: fix kernel-doc warning in <linux/dma-buf.h>
      drm: amd/display: fix spelling of "function"

Reza Amini (1):
      drm/amd/display: Allow asic specific FSFT timing optimization

Rikard Falkeborn (5):
      drm/amd/display: Constify dcn20_res_pool_funcs
      drm/amd/display: Constify dcn21_res_pool_funcs
      drm/amd/display: Constify dcn30_res_pool_funcs
      drm/sun4i: Constify static structs
      drm/gma500: Constify static structs

Rob Clark (13):
      drm/msm: drop cache sync hack
      drm/msm/dpu: move vblank events to complete_commit()
      drm/msm/dpu: clean up some impossibilities
      drm/msm/gpu: Add GPU freq_change traces
      drm/msm: Convert shrinker msgs to tracepoints
      drm/msm/gpu: Add suspend/resume tracepoints
      drm/msm: Remove dangling submitqueue references
      drm/msm: Add private interface for adreno-smmu
      drm/msm/gpu: Add dev_to_gpu() helper
      drm/msm: Set adreno_smmu as gpu's drvdata
      drm/msm: Show process names in gem_describe
      drm/msm/dp: Fix crash if no DP device
      drm/msm: fix 32b build warns

Robert Chiras (1):
      drm/panel: rm67191: Remove CLOCK_NON_CONTINUOUS flag

Robin Murphy (2):
      drm/panfrost: Set DMA max segment size
      drm/msm: Drop local dma_parms

Rodrigo Alencar (1):
      video: fbdev: ssd1307fb: Added support to Column offset

Rodrigo Siqueira (5):
      drm/vkms: Decouple crc operations from composer
      drm/vkms: Compute CRC without change input data
      drm/vkms: Add support for writeback
      drm/amd/display: Check clock table return
      drm/amd/display: Avoid set zero in the requested clk

Rodrigo Vivi (6):
      drm/i915: Update DRIVER_DATE to 20200824
      Merge drm/drm-next into drm-intel-next-queued
      Merge tag 'gvt-next-2020-09-10' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200914
      drm/i915: Update DRIVER_DATE to 20200914
      drm/i915: Update DRIVER_DATE to 20200917

Roman Li (2):
      drm/amd/display: remove early return from dm_late_init
      drm/amd/display: fix compile warning in dml

Ryan Taylor (2):
      drm/amdgpu: Add initial kernel documentation for the
amd_ip_block_type structure. v3
      drm/include: add PP_FEATURE_MASK comments (v3)

Sai Prakash Ranjan (2):
      drm/msm/mdp4: Remove unused downstream bus scaling apis
      drm/msm/mdp5: Remove unused downstream bus scaling apis

Sam McNally (1):
      drm/dp_mst: Support remote i2c writes

Sam Ravnborg (22):
      drm/panel: add connector type to boe,hv070wsa-100 panel
      drm/panel: panel-simple: validate panel description
      drm/panel: panel-simple: add default connector_type
      drm/bridge: tc358764: drop drm_connector_(un)register
      drm/bridge: tc358764: add drm_panel_bridge support
      drm/bridge: parade-ps8622: add drm_panel_bridge support
      drm/bridge: megachips: add helper to create connector
      drm/bridge: megachips: get drm_device from bridge
      drm/bridge: megachips: enable detect bridge operation
      drm/bridge: megachips: add get_edid bridge operation
      drm/bridge: megachips: make connector creation optional
      drm/bridge: tc358767: add detect bridge operation
      drm/bridge: tc358767: add get_edid bridge operation
      drm/bridge: tc358767: add drm_panel_bridge support
      drm/bridge: nxp-ptn3460: add get_edid bridge operation
      drm/bridge: nxp-ptn3460: add drm_panel_bridge support
      drm/mgag200: fix build on alpha arch
      drm/panel: samsung: Use dev_ based logging
      drm/panel: leadtek: Use dev_ based logging
      drm/panel: raydium: Use dev_ based logging
      drm/panel: sitronix: Use dev_ based logging
      drm/panel: Use dev_ based logging

Samson Tam (1):
      drm/amd/display: Fix passive dongle mistaken as active dongle in
EDID emulation

Sandeep Raghuraman (4):
      drm/amdgpu: Fix bug where DPM is not enabled after hibernate and resu=
me
      drm/amdgpu: Specify get_argument function for ci_smu_funcs
      drm/amdgpu: Fix bug in reporting voltage for CIK
      drm/radeon: Add sclk frequency as hwmon sensor

Sean Paul (17):
      drm/i915: Fix sha_text population code
      drm/i915: Clear the repeater bit on HDCP disable
      drm/i915: WARN if HDCP signalling is enabled upon disable
      drm/i915: Intercept Aksv writes in the aux hooks
      drm/i915: Use the cpu_transcoder in intel_hdcp to toggle HDCP signall=
ing
      drm/i915: Factor out hdcp->value assignments
      drm/i915: Protect workers against disappearing connectors
      drm/i915: Clean up intel_hdcp_disable
      drm/i915: Don't fully disable HDCP on a port if multiple pipes
are using it
      drm/i915: Support DP MST in enc_to_dig_port() function
      drm/i915: Use ddi_update_pipe in intel_dp_mst
      drm/i915: Factor out HDCP shim functions from dp for use by dp_mst
      drm/i915: Plumb port through hdcp init
      drm/i915: Add connector to hdcp_shim->check_link()
      drm/mst: Add support for QUERY_STREAM_ENCRYPTION_STATUS MST
sideband message
      drm/i915: Print HDCP version info for all connectors
      drm/i915: Add HDCP 1.4 support for MST connectors

Sebastien Boeuf (3):
      virtio: Add get_shm_region method
      virtio: Implement get_shm_region for PCI transport
      virtio: Implement get_shm_region for MMIO transport

Shashank Sharma (1):
      drm/amdgpu: add new trace event for page table update

Shirish S (2):
      amdgpu/gmc_v9: Warn if SDPIF_MMIO_CNTRL_0 is not set
      drm/amd/display: fix crash/reboot while accessing sysfs files

Sidong Yang (2):
      drm/qxl: Replace deprecated function in qxl_display
      drm/vkms: avoid warning in vkms_get_vblank_timestamp

Stanley.Yang (3):
      drm/amdkfd: fix set kfd node ras properties value
      drm/amdgpu: update athub interrupt harvesting handle
      drm/amdgpu: fix hdp register access error

Stefan Agner (1):
      drm: mxsfb: check framebuffer pitch

Stephen Boyd (4):
      drm/msm: Avoid div-by-zero in dpu_crtc_atomic_check()
      drm/msm: Drop debug print in _dpu_crtc_setup_lm_bounds()
      drm/msm/dp: Use qmp phy for DP PLL and PHY
      drm/msm/dp: Sleep properly in dp_hpd_handler kthread

Steven Price (1):
      drm/panfrost: Ensure GPU quirks are always initialised

Stu Hsieh (1):
      drm/mediatek: dpi/dsi: Change the getting possible_crtc way

Stylon Wang (2):
      drm/amd/display: Fix dmesg warning from setting abm level
      drm/amd/display: Fix EDID parsing after resume from suspend

Sudheesh Mavila (1):
      drm/amd/pm: Removed fixed clock in auto mode DPM

Sung Lee (1):
      drm/amd/display: Send DISPLAY_OFF after power down on boot

Sven Schneider (1):
      lib/fonts: add font 6x8 for OLED display

Swapnil Jakhade (4):
      phy: Add new PHY attribute max_link_rate
      phy: cadence-torrent: Set Torrent PHY attributes
      drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge
      drm: bridge: cdns-mhdp8546: Add TI J721E wrapper

Swathi Dhanavanthri (1):
      drm/i915/tgl, rkl: Make Wa_1606700617/22010271021 permanent

Taimur Hassan (1):
      drm/amd/display: Check for flip pending before locking pipes.

Tanmay Shah (1):
      drm/msm/dp: Add Display Port HPD feature

Tao Zhou (1):
      drm/amdgpu: add asd fw check before loading asd

Thierry Reding (1):
      drm/tegra: Properly reference count the DDC I2C adapter

Thomas Hellstr=C3=B6m (1):
      drm/i915: Unlock the shared hwsp_gtt object after pinning

Thomas Zimmermann (27):
      drm/ast: Embed CRTC and connector in struct ast_private
      drm/ast: Separate DRM driver from PCI code
      drm/ast: Replace driver load/unload functions with device create/dest=
roy
      drm/ast: Replace struct_drm_device.dev_private with to_ast_private()
      drm/ast: Don't use ast->dev if dev is available
      drm/ast: Embed struct drm_device in struct ast_private
      drm/ast: Managed release of ast firmware
      drm/ast: Manage release of firmware backup memory
      drm/ast: Managed device release
      drm/mgag200: Enable caching for SHMEM pages
      drm/mgag200: Move register initialization into helper function
      drm/mgag200: Initialize PCI registers early during device setup
      drm/mgag200: Enable MGA mode during device register initialization
      drm/mgag200: Set MISC memory flags in mm init code
      drm/mgag200: Clear <page> field during MM init
      drm/mgag200: Move G200SE's unique id into model-specific data
      drm/mgag200: Add support for G200 desktop cards
      fbdev: Remove trailing whitespace
      drm/mgag200: Set PCI option register in G200SE models
      Merge drm/drm-next into drm-misc-next
      drm/malidp: Use struct drm_gem_object_funcs.get_sg_table internally
      drm/vboxvideo: Use drm_gem_vram_vmap() interfaces
      MAINTAINERS: Add Thomas as reviewer for ast, mgag200 and udl
      drm/ast: Set format registers in primary plane's update
      drm/ast: Disable planes while switching display modes
      drm/ast: Program display mode in CRTC's atomic_enable()
      drm/ast: Enable CRTC before planes

Tian Tao (13):
      drm/hisilicon: Fixed the warning: Assignment of 0/1 to bool variable
      drm/hisilicon: Remove the unused include statements
      drm/hisilicon: Code refactoring for hibmc_drv_de
      drm/hisilicon: Fix build error of no type of module_init
      MAINTAINERS: Change maintainer for hisilicon DRM driver
      drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_ttm
      drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_vdac
      drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_de
      drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_drv
      drm/hisilicon: Removed the dependency on the mmu
      drm/scheduler: fix sched_fence.c kernel-doc warnings
      drm/vc4: Handing the return value of drm_universal_plane_init
      drm/ttm: update kernel-doc line comments

Tianci.Yin (2):
      drm/amdgpu: add interface amdgpu_gfx_init_spm_golden for Navi1x
      drm/amdgpu: reconfigure spm golden settings on Navi1x after
GFXOFF exit(v3)

Tianjia Zhang (3):
      drm/amd/display: Fix wrong return value in dm_update_plane_state()
      drm/i915: Fix wrong return value
      drm/i915: Fix wrong return value in intel_atomic_check()

Tiecheng Zhou (1):
      drm/amdgpu: stop data_exchange work thread before reset

Tom Rix (3):
      video: fbdev: pvr2fb: initialize variables
      drm/gma500: fix error check
      video: fbdev: sis: fix null ptr dereference

Tom St Denis (3):
      drm/amd/amdgpu: Fix compiler warning in df driver
      drm/amd/amdgpu: Add RLC_CGTT_MGCG_OVERRIDE to gfx 10.3 headers
      drm/amd/amdgpu: add mmUVD_FW_STATUS register to uvd700

Tomeu Vizoso (2):
      drm/panfrost: Make sure GPU is powered on when reading GPU_LATEST_FLU=
SH_ID
      drm/panfrost: Add compatible string for bifrost

Tomi Valkeinen (3):
      drm/tidss: implement WA for AM65xx erratum i2000
      Merge tag 'phy-attrs-5.10' of
git://git.kernel.org/.../phy/linux-phy into 5.10/dp-pull
      drm: bridge: cdns-mhdp8546: fix compile warning

Tong Zhang (1):
      drm/amd/display: should check error using DC_OK

Uma Shankar (1):
      drm/i915/display/fbc: Disable fbc by default on TGL

Vaibhav Gupta (15):
      fbdev: gxfb: use generic power management
      fbdev: lxfb: use generic power management
      fbdev: via-core: use generic power management
      fbdev: aty: use generic power management
      fbdev: aty128fb: use generic power management
      fbdev: nvidia: use generic power management
      fbdev: savagefb: use generic power management
      fbdev: cyber2000fb: use generic power management
      fbdev: i740fb: use generic power management
      fbdev: vt8623fb: use generic power management
      fbdev: s3fb: use generic power management
      fbdev: arkfb: use generic power management
      video: fbdev: aty: radeon_pm: remove redundant CONFIG_PM container
      fbdev: radeonfb: use generic power management
      fbdev: aty: remove CONFIG_PM container

Victor Lu (1):
      drm/amd/display: Add debugfs for forcing stream timing sync

Ville Syrj=C3=A4l=C3=A4 (53):
      drm/todo: Plumb drm_atomic_state all over
      drm/i915/fbc: Limit cfb to the first 256MiB of stolen on g4x+
      drm/i915: Pack struct intel_cdclk_vals
      drm/i915: Fix some whitespace
      drm/i915: Make i830 .get_cdclk() assignment less confusing
      drm/i915: Move WaDisableDopClockGating:skl to skl_init_clock_gating()
      drm: Nuke mode->private_flags
      drm: Replace mode->export_head with a boolean
      drm/i915: Nuke dpio_phy_iosf_port[]
      drm/i915: Kill unused savePCH_PORT_HOTPLUG
      drm/i915: Nuke the magic FBC_CONTROL save/restore
      drm/i915: Nuke MI_ARB_STATE save/restore
      drm/i915: Nuke CACHE_MODE_0 save/restore
      drm/i915: Fix g4x+ sprite dotclock limit for upscaling
      drm/i915: Use fb->format->is_yuv for the g4x+ sprite RGB vs. YUV chec=
k
      drm/atomic-helper: Extract drm_atomic_helper_calc_timestamping_consta=
nts()
      drm/atomic-helper: Remove the timestamping constant update from
drm_atomic_helper_update_legacy_modeset_state()
      drm/i915: Drop the drm_atomic_helper_calc_timestamping_constants() ca=
ll
      drm/i915: Reduce INTEL_DISPLAY_ENABLED to just removing the outputs
      drm/i915: Reduce INTEL_DISPLAY_ENABLED to just treat outputs as
disconnected
      drm/i915: Add more AUX CHs to the enum
      drm/i915: Add PORT_{H,I} to intel_port_to_power_domain()
      drm/i915: Add AUX_CH_{H,I} power domain handling
      drm/i915: Add VBT DVO ports H and I
      drm/i915: Add VBT AUX CH H and I
      drm/i915: Nuke the redundant TC/TBT HPD bit defines
      drm/i915: Configure GEN11_{TBT,TC}_HOTPLUG_CTL for ports TC5/6
      drm/i915: Split icp_hpd_detection_setup() into ddi vs. tc parts
      drm/i915: Move hpd_pin setup to encoder init
      drm/i915: Introduce HPD_PORT_TC<n>
      drm/i915: Introduce intel_hpd_hotplug_irqs()
      drm/i915: Nuke pointless variable
      drm/dp: Dump downstream facing port caps
      drm/i915/lspcon: Do not send infoframes to non-HDMI sinks
      drm/dp: Define protocol converter DPCD registers
      drm/dp: Define more downstream facing port caps
      drm/i915: Reworkd DFP max bpc handling
      drm/dp: Add helpers to identify downstream facing port types
      drm/dp: Pimp drm_dp_downstream_max_bpc()
      drm/dp: Redo drm_dp_downstream_max_clock() as
drm_dp_downstream_max_dotclock()
      drm/i915: Reworkd DP DFP clock handling
      drm/dp: Add drm_dp_downstream_{min,max}_tmds_clock()
      drm/i915: Deal with TMDS DFP clock limits
      drm/i915: Configure DP 1.3+ protocol converted HDMI mode
      drm/dp: Add drm_dp_downstream_mode()
      drm/i915: Handle downstream facing ports w/o EDID
      drm/i915: Extract intel_hdmi_has_audio()
      drm/i915: DP->HDMI TMDS clock limits vs. deep color
      drm/dp: Add helpers for DFP YCbCr 4:2:0 handling
      drm/i915: Do YCbCr 444->420 conversion via DP protocol converters
      drm/i915: Remove the old global state stuff
      drm/i915: Nuke force_min_cdclk_changed
      drm/i915: Fix state checker hw.active/hw.enable readout

Vinay Simha BN (3):
      dt-binding: Add DSI/LVDS TC358775 bridge bindings
      display/drm/bridge: TC358775 DSI/LVDS driver
      drm/bridge/tc358775: Fix for PTR_ERR

Vinod Koul (4):
      dt-bindings: vendor-prefixes: Add Lontium vendor prefix
      dt-bindings: display: bridge: Add documentation for LT9611
      drm/bridge: Introduce LT9611 DSI to HDMI bridge
      drm/bridge: Fix the dsi remote end-points

Wang Hai (1):
      drm/amd/powerplay: remove duplicate include

Wang Qing (2):
      drm: fix spelling error in comments
      gpu/drm/radeon: fix spelling typo in comments

Wayne Lin (2):
      drm/amd/display: Send H14b-VSIF specified in HDMI
      drm/amd/display: Retry AUX write when fail occurs

Wenhui Sheng (3):
      drm/amdgpu: add RAP TA header file
      drm/amdgpu: enable RAP TA load
      drm/amdgpu: add debugfs interface for RAP test

Wenjing Liu (4):
      drm/amd/display: create a function to decide mst link settings
      drm/amd/display: add option to override cr training pattern
      drm/amd/display: always use 100us for cr aux rd interval
      drm/amd/display: allow DP RX to use more cr aux rd interval delay

Wesley Chalmers (4):
      drm/amd/display: Only use offset for first ODM pipe
      drm/amd/display: Fix ODM policy implementation
      drm/amd/display: Increase timeout for DP Disable
      drm/amd/display: Add debug param to force dio disable

Wyatt Wood (3):
      drm/amd/display: Use hw lock mgr
      drm/amd/display: Implement PSR wait for enable/disable
      drm/amd/display: Ensure all debug bits are passed to fw

Xiaodong Yan (1):
      drm/amd/display: mpcc black color should not be impacted by
pixel encoding format

Xiaojian Du (1):
      drm/amd/powerplay: add one sysfs file to support the feature to
modify gfx clock on Raven/Raven2/Picasso APU.

Xiaoliang Pang (1):
      drm/amdgpu/powerplay: hwmgr - modify the return value

Yan Zhao (4):
      drm/i915/gvt: rename F_IN_CTX flag to F_SR_IN_CTX
      drm/i915/gvt: remove flag F_CMD_ACCESSED
      drm/i915/gvt: add/modify interfaces for flag F_CMD_ACCESS
      drm/i915/gvt: remove F_CMD_ACCESS flag for some registers

Ye Bin (4):
      drm/amdgpu/gfx10: Delete some duplicated argument to '|'
      drm/amd/display: Remove set but used 'temp'
      drm/amd/display: Delete duplicated argument to '&&' or '||'
      drm/amdgpu: Fix invalid number of character '{' in amdgpu_acpi_init

Yongqiang Sun (2):
      drm/amd/display: Change ABM config init interface
      drm/amd/display: Add read backlight interface

Youling Tang (1):
      gpu: amd: Remove duplicate semicolons at the end of line

YueHaibing (4):
      drm/panel: s6e63m0: Add missing MODULE_LICENSE
      drm/amdkfd: Fix -Wunused-const-variable warning
      drm/amd/display: Fix possible memleak in dp_trigger_hotplug()
      drm/amd/display: Create trigger_hotplug entry

Yuti Amonkar (1):
      dt-bindings: drm/bridge: Document Cadence MHDP8546 bridge bindings

Zhan Liu (2):
      drm/amd/display: Enabling PSR on DCN30 on driver side
      drm/amd/display: Disable idle optimization when PSR is enabled

Zheng Bin (9):
      drm/bridge/tc358775: Remove unneeded semicolon
      drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in
amdgpu_atpx_handler.c
      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c

Zhenzhong Duan (1):
      drm/msm/a6xx: fix a potential overflow issue

chunhui dai (1):
      drm/mediatek: Disable tmds on mt2701

hersen wu (2):
      drm/amd/display: dchubbub p-state warning during surface planes switc=
h
      drm/amd/display: PSR eDP p-state warning occurs intermittently
after unplug DP

jqdeng (2):
      drm/amdgpu: Fix repeatly flr issue
      drm/amdgpu: Limit the error info print rate

kernel test robot (2):
      video: fbdev: udlfb: fix kobj_to_dev.cocci warnings
      drm/amdgpu: kfd_initialized can be static

shiwu.zhang (1):
      drm/amdgpu: update gc golden register for arcturus

xinhui pan (2):
      drm/amdgpu: Fix a redundant kfree
      drm/amd/display: Fix a list corruption

 .../bindings/display/brcm,bcm2711-hdmi.yaml        |  117 +
 .../bindings/display/brcm,bcm2835-hvs.yaml         |   18 +-
 .../bindings/display/brcm,bcm2835-pixelvalve0.yaml |    5 +
 .../bindings/display/brcm,bcm2835-vc4.yaml         |    1 +
 .../bindings/display/bridge/cdns,mhdp8546.yaml     |  169 ++
 .../bindings/display/bridge/lontium,lt9611.yaml    |  176 ++
 .../bindings/display/bridge/lvds-codec.yaml        |    3 +
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |    4 +-
 .../bindings/display/bridge/renesas,lvds.yaml      |    2 +
 .../bindings/display/bridge/toshiba,tc358762.yaml  |  127 +
 .../bindings/display/bridge/toshiba,tc358775.yaml  |  215 ++
 .../bindings/display/imx/nxp,imx8mq-dcss.yaml      |  108 +
 .../bindings/display/mediatek/mediatek,disp.txt    |    2 +-
 .../bindings/display/mediatek/mediatek,dpi.txt     |    2 +-
 .../bindings/display/mediatek/mediatek,dsi.txt     |    4 +-
 .../bindings/display/mediatek/mediatek,hdmi.txt    |    4 +
 .../devicetree/bindings/display/msm/dsi.txt        |    6 +-
 .../bindings/display/panel/ilitek,ili9881c.yaml    |    4 +-
 .../display/panel/mantix,mlaf057we51-x.yaml        |   70 +
 .../bindings/display/panel/panel-simple.yaml       |    8 +
 .../display/panel/rocktech,jh057n00900.yaml        |   40 +-
 .../devicetree/bindings/display/renesas,du.txt     |    6 +
 .../devicetree/bindings/display/ssd1307fb.txt      |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    8 +
 Documentation/driver-api/driver-model/devres.rst   |    2 +-
 Documentation/fb/fbcon.rst                         |    4 +-
 Documentation/gpu/amdgpu.rst                       |   37 +-
 Documentation/gpu/drm-uapi.rst                     |  114 +-
 Documentation/gpu/pl111.rst                        |    8 +-
 Documentation/gpu/todo.rst                         |   46 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 -
 MAINTAINERS                                        |   43 +-
 drivers/acpi/acpi_lpss.c                           |   22 +-
 drivers/char/agp/amd-k7-agp.c                      |    2 +-
 drivers/char/agp/nvidia-agp.c                      |    2 +-
 drivers/char/agp/sworks-agp.c                      |    2 +-
 drivers/dma-buf/dma-fence.c                        |    1 +
 drivers/dma-buf/dma-resv.c                         |    5 +
 drivers/dma-buf/heaps/heap-helpers.c               |   13 +-
 drivers/dma-buf/udmabuf.c                          |   10 +-
 drivers/gpu/drm/Makefile                           |    2 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  110 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |    7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  188 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  216 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  811 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h             |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   39 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h        |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  125 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |   35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h     |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   71 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h         |   43 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  100 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |   92 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c            |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  105 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  221 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c            |  127 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h            |   30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  313 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |  138 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |   42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h          |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  382 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   67 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  251 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |  102 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  117 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  221 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |  276 +++
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c         |   22 +-
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |   24 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |   36 +-
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c          |    2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    7 +
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |    7 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   94 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |   96 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  104 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   94 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |   79 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |   27 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  105 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   61 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   63 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h              |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              |   37 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c           |   13 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h           |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |  117 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h           |   10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |  115 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h           |   12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  296 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   13 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   13 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  531 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |   26 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |    7 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |    7 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   32 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h            |   14 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |  170 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h            |   11 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |   55 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h            |   12 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |   21 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |   21 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   30 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   48 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   68 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   13 -
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |   54 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  111 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         |   15 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   78 +-
 drivers/gpu/drm/amd/amdgpu/ta_rap_if.h             |   84 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |   14 -
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c              |  331 +++
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h              |   51 +
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   35 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   20 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   28 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  174 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |    7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   33 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   51 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   29 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   52 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    8 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   40 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |   10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   59 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  193 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |  105 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h        |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   53 +-
 drivers/gpu/drm/amd/display/Kconfig                |   10 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 1007 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |    3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  668 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |    4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_irq_params.h   |   37 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   55 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  102 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |    4 +
 drivers/gpu/drm/amd/display/dc/bios/Makefile       |    9 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   71 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    4 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   33 +-
 .../drm/amd/display/dc/bios/command_table_helper.c |    8 +
 .../drm/amd/display/dc/bios/command_table_helper.h |    3 +
 .../amd/display/dc/bios/command_table_helper2.c    |    8 +
 .../amd/display/dc/bios/command_table_helper2.h    |    3 +
 .../dc/bios/dce60/command_table_helper_dce60.c     |  354 +++
 .../dc/bios/dce60/command_table_helper_dce60.h     |   33 +
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |    7 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |   18 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    6 +
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |    3 +-
 .../amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  174 ++
 .../amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h   |   36 +
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |    8 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |    3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  169 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |    8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   98 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   29 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   63 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   13 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |    7 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   14 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |    4 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   16 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    2 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    1 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |    3 +
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |   12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |  131 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h     |   23 +
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |   37 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.c     |    9 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   18 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |   46 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h       |   49 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  369 +++
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.h  |   38 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |  176 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h |  103 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |  205 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h       |   49 +
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |   18 +-
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.h    |    6 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    6 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |  330 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h |  178 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |   32 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h      |    2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  100 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |    2 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile      |   34 +
 .../drm/amd/display/dc/dce60/dce60_hw_sequencer.c  |  432 ++++
 .../drm/amd/display/dc/dce60/dce60_hw_sequencer.h  |   37 +
 .../gpu/drm/amd/display/dc/dce60/dce60_resource.c  | 1527 ++++++++++++
 .../gpu/drm/amd/display/dc/dce60/dce60_resource.h  |   47 +
 .../amd/display/dc/dce60/dce60_timing_generator.c  |  266 ++
 .../amd/display/dc/dce60/dce60_timing_generator.h  |   39 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |    7 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |    4 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    3 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  156 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    6 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |   11 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   83 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |   10 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |    4 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h   |    1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   44 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |    3 +
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |    2 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |    8 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   20 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |    1 -
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |    4 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |    3 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |    7 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile      |   18 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |    4 -
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   30 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c  |   13 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h  |    4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |  259 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.h  |    8 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    4 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   13 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   11 +-
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.h  |    2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h        |    2 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |    2 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |   20 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |    2 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.h  |    2 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |    5 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   20 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |   12 +
 .../amd/display/dc/gpio/dce120/hw_factory_dce120.c |    2 +-
 .../amd/display/dc/gpio/dce60/hw_factory_dce60.c   |  175 ++
 .../amd/display/dc/gpio/dce60/hw_factory_dce60.h   |   32 +
 .../amd/display/dc/gpio/dce60/hw_translate_dce60.c |  411 ++++
 .../amd/display/dc/gpio/dce60/hw_translate_dce60.h |   32 +
 .../amd/display/dc/gpio/dcn10/hw_factory_dcn10.c   |    2 +-
 .../amd/display/dc/gpio/dcn20/hw_factory_dcn20.c   |    2 +-
 .../amd/display/dc/gpio/dcn21/hw_factory_dcn21.c   |    2 +-
 .../amd/display/dc/gpio/dcn30/hw_factory_dcn30.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |   10 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |   10 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    8 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |   11 +
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |    4 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |   11 +
 .../amd/display/dc/irq/dce60/irq_service_dce60.c   |  395 +++
 .../amd/display/dc/irq/dce60/irq_service_dce60.h   |   40 +
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |    3 +
 drivers/gpu/drm/amd/display/dc/os_types.h          |    4 +
 .../display/dc/virtual/virtual_stream_encoder.c    |   29 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  156 +-
 .../drm/amd/display/include/bios_parser_types.h    |    6 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   40 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |    3 +
 .../drm/amd/display/include/link_service_types.h   |    1 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |    8 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |    1 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |   17 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.h    |    2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |    2 +-
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    2 +-
 .../amd/display/modules/info_packet/info_packet.c  |   16 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   19 +-
 .../drm/amd/display/modules/power/power_helpers.h  |    4 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |  115 +-
 .../drm/amd/include/asic_reg/dce/dce_12_0_offset.h |    2 -
 .../gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h   |   76 +
 .../drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h |  104 +
 .../amd/include/asic_reg/dcn/dcn_3_0_0_offset.h    |    0
 .../amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h   |   22 +
 .../amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h   |    0
 .../amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h  |    0
 .../amd/include/asic_reg/gc/gc_10_3_0_default.h    |    2 +
 .../drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h |    6 +
 .../amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h    |   75 +
 .../drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h  |    4 +-
 .../amd/include/asic_reg/umc/umc_8_7_0_offset.h    |   33 +
 .../amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h   |   79 +
 .../drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h  |    3 +
 .../drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h |   20 +
 .../amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h   |   34 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   15 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  110 +
 drivers/gpu/drm/amd/pm/Makefile                    |   46 +
 drivers/gpu/drm/amd/{amdgpu =3D> pm}/amdgpu_dpm.c    |  479 +++-
 drivers/gpu/drm/amd/{amdgpu =3D> pm}/amdgpu_pm.c     |  957 +++-----
 .../drm/amd/{powerplay =3D> pm}/inc/amd_powerplay.h  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/inc}/amdgpu_dpm.h    |   37 +-
 drivers/gpu/drm/amd/{amdgpu =3D> pm/inc}/amdgpu_pm.h |    8 -
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/amdgpu_smu.h |   28 +-
 .../drm/amd/{powerplay =3D> pm}/inc/arcturus_ppsmc.h |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/cz_ppsmc.h   |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/fiji_ppsmc.h |    0
 .../amd/{powerplay =3D> pm}/inc/hardwaremanager.h    |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/hwmgr.h  |    6 +
 .../amd/{powerplay =3D> pm}/inc/polaris10_pwrvirus.h |    0
 .../drm/amd/{powerplay =3D> pm}/inc/power_state.h    |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/pp_debug.h   |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/pp_endian.h  |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/pp_thermal.h |    0
 .../drm/amd/{powerplay =3D> pm}/inc/ppinterrupt.h    |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/rv_ppsmc.h   |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu10.h  |    0
 .../amd/{powerplay =3D> pm}/inc/smu10_driver_if.h    |    3 +-
 .../amd/{powerplay =3D> pm}/inc/smu11_driver_if.h    |    0
 .../inc/smu11_driver_if_arcturus.h                 |    0
 .../{powerplay =3D> pm}/inc/smu11_driver_if_navi10.h |   39 +
 .../inc/smu11_driver_if_sienna_cichlid.h           |   22 +-
 .../amd/{powerplay =3D> pm}/inc/smu12_driver_if.h    |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu7.h   |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu71.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu71_discrete.h |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu72.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu72_discrete.h |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu73.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu73_discrete.h |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu74.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu74_discrete.h |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu75.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu75_discrete.h |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu7_common.h    |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu7_discrete.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu7_fusion.h    |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/smu7_ppsmc.h |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu8.h   |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu8_fusion.h    |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu9.h   |    0
 .../drm/amd/{powerplay =3D> pm}/inc/smu9_driver_if.h |    0
 drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h    |  194 ++
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/smu_types.h  |    3 +
 .../amd/{powerplay =3D> pm}/inc/smu_ucode_xfer_cz.h  |    0
 .../amd/{powerplay =3D> pm}/inc/smu_ucode_xfer_vi.h  |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v11_0.h  |   30 +-
 .../amd/{powerplay =3D> pm}/inc/smu_v11_0_7_ppsmc.h  |    0
 .../{powerplay =3D> pm}/inc/smu_v11_0_7_pptable.h    |    0
 .../amd/{powerplay =3D> pm}/inc/smu_v11_0_ppsmc.h    |    9 +-
 .../amd/{powerplay =3D> pm}/inc/smu_v11_0_pptable.h  |    0
 .../gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v12_0.h  |    2 +
 .../amd/{powerplay =3D> pm}/inc/smu_v12_0_ppsmc.h    |    0
 drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smumgr.h |    0
 .../drm/amd/{powerplay =3D> pm}/inc/tonga_ppsmc.h    |    0
 .../drm/amd/{powerplay =3D> pm}/inc/vega10_ppsmc.h   |    0
 .../{powerplay =3D> pm}/inc/vega12/smu9_driver_if.h  |    0
 .../drm/amd/{powerplay =3D> pm}/inc/vega12_ppsmc.h   |    0
 .../drm/amd/{powerplay =3D> pm}/inc/vega20_ppsmc.h   |    0
 drivers/gpu/drm/amd/{ =3D> pm}/powerplay/Makefile    |   23 +-
 .../gpu/drm/amd/{ =3D> pm}/powerplay/amd_powerplay.c |   35 +-
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/cik_dpm.h |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/Makefile  |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ci_baco.c |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ci_baco.h |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/common_baco.c |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/common_baco.h |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/fiji_baco.c   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/fiji_baco.h   |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/hardwaremanager.c |    5 +-
 .../gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/hwmgr.c   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/hwmgr_ppt.h   |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/polaris_baco.c    |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/polaris_baco.h    |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/pp_overdriver.c   |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/pp_overdriver.h   |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pp_psm.c  |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pp_psm.h  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/ppatomctrl.c  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/ppatomctrl.h  |    9 -
 .../amd/{ =3D> pm}/powerplay/hwmgr/ppatomfwctrl.c    |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/ppatomfwctrl.h    |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/ppevvmath.h   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/pppcielanes.c |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/pppcielanes.h |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/pptable_v1_0.h    |    0
 .../powerplay/hwmgr/process_pptables_v1_0.c        |    0
 .../powerplay/hwmgr/process_pptables_v1_0.h        |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/processpptables.c |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/processpptables.h |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu10_hwmgr.c |  105 +-
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu10_hwmgr.h |    3 +-
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu10_inc.h   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_baco.c   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_baco.h   |    0
 .../powerplay/hwmgr/smu7_clockpowergating.c        |    0
 .../powerplay/hwmgr/smu7_clockpowergating.h        |    0
 .../{ =3D> pm}/powerplay/hwmgr/smu7_dyn_defaults.h   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_hwmgr.c  |   16 +-
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_hwmgr.h  |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/smu7_powertune.c  |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/smu7_powertune.h  |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/smu7_thermal.c    |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/smu7_thermal.h    |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu8_hwmgr.c  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu8_hwmgr.h  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu9_baco.c   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu9_baco.h   |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu_helper.c  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/smu_helper.h  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/tonga_baco.c  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/tonga_baco.h  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_baco.c |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_baco.h |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega10_hwmgr.c    |    2 +-
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega10_hwmgr.h    |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_inc.h  |    0
 .../{ =3D> pm}/powerplay/hwmgr/vega10_powertune.c    |    0
 .../{ =3D> pm}/powerplay/hwmgr/vega10_powertune.h    |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega10_pptable.h  |    0
 .../powerplay/hwmgr/vega10_processpptables.c       |    0
 .../powerplay/hwmgr/vega10_processpptables.h       |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega10_thermal.c  |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega10_thermal.h  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_baco.c |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_baco.h |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega12_hwmgr.c    |  140 +-
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega12_hwmgr.h    |    1 +
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_inc.h  |    1 -
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega12_pptable.h  |    0
 .../powerplay/hwmgr/vega12_processpptables.c       |    2 +-
 .../powerplay/hwmgr/vega12_processpptables.h       |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega12_thermal.c  |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega12_thermal.h  |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_baco.c |    0
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_baco.h |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega20_hwmgr.c    |  154 +-
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega20_hwmgr.h    |    1 +
 .../drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_inc.h  |    0
 .../{ =3D> pm}/powerplay/hwmgr/vega20_powertune.c    |    0
 .../{ =3D> pm}/powerplay/hwmgr/vega20_powertune.h    |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega20_pptable.h  |    0
 .../powerplay/hwmgr/vega20_processpptables.c       |    8 +-
 .../powerplay/hwmgr/vega20_processpptables.h       |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega20_thermal.c  |    0
 .../amd/{ =3D> pm}/powerplay/hwmgr/vega20_thermal.h  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/kv_dpm.c  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/kv_dpm.h  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/kv_smc.c  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/ppsmc.h   |    0
 .../drm/amd/{amdgpu =3D> pm/powerplay}/r600_dpm.h    |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/si_dpm.c  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/si_dpm.h  |    0
 .../gpu/drm/amd/{amdgpu =3D> pm/powerplay}/si_smc.c  |    0
 .../amd/{amdgpu =3D> pm/powerplay}/sislands_smc.h    |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/Makefile |    0
 .../drm/amd/{ =3D> pm}/powerplay/smumgr/ci_smumgr.c  |    0
 .../drm/amd/{ =3D> pm}/powerplay/smumgr/ci_smumgr.h  |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/fiji_smumgr.c    |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/fiji_smumgr.h    |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/iceland_smumgr.c |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/iceland_smumgr.h |    0
 .../{ =3D> pm}/powerplay/smumgr/polaris10_smumgr.c   |    0
 .../{ =3D> pm}/powerplay/smumgr/polaris10_smumgr.h   |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu10_smumgr.c   |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu10_smumgr.h   |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu7_smumgr.c    |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu7_smumgr.h    |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu8_smumgr.c    |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu8_smumgr.h    |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/smu9_smumgr.c    |    7 -
 .../amd/{ =3D> pm}/powerplay/smumgr/smu9_smumgr.h    |    0
 .../gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smumgr.c |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/tonga_smumgr.c   |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/tonga_smumgr.h   |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vega10_smumgr.c  |   12 +-
 .../amd/{ =3D> pm}/powerplay/smumgr/vega10_smumgr.h  |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vega12_smumgr.c  |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vega12_smumgr.h  |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vega20_smumgr.c  |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vega20_smumgr.h  |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vegam_smumgr.c   |    0
 .../amd/{ =3D> pm}/powerplay/smumgr/vegam_smumgr.h   |    0
 drivers/gpu/drm/amd/pm/swsmu/Makefile              |   36 +
 .../drm/amd/{powerplay =3D> pm/swsmu}/amdgpu_smu.c   |  223 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile        |   33 +
 .../{powerplay =3D> pm/swsmu/smu11}/arcturus_ppt.c   |  146 +-
 .../{powerplay =3D> pm/swsmu/smu11}/arcturus_ppt.h   |    0
 .../amd/{powerplay =3D> pm/swsmu/smu11}/navi10_ppt.c |  497 ++--
 .../amd/{powerplay =3D> pm/swsmu/smu11}/navi10_ppt.h |    3 -
 .../swsmu/smu11}/sienna_cichlid_ppt.c              |  239 +-
 .../swsmu/smu11}/sienna_cichlid_ppt.h              |    3 -
 .../amd/{powerplay =3D> pm/swsmu/smu11}/smu_v11_0.c  |  329 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile        |   31 +
 .../amd/{powerplay =3D> pm/swsmu/smu12}/renoir_ppt.c |  270 +-
 .../amd/{powerplay =3D> pm/swsmu/smu12}/renoir_ppt.h |    1 +
 .../amd/{powerplay =3D> pm/swsmu/smu12}/smu_v12_0.c  |   12 +
 .../gpu/drm/amd/{powerplay =3D> pm/swsmu}/smu_cmn.c  |   56 +-
 .../gpu/drm/amd/{powerplay =3D> pm/swsmu}/smu_cmn.h  |   12 +
 .../drm/amd/{powerplay =3D> pm/swsmu}/smu_internal.h |    6 +-
 drivers/gpu/drm/arm/malidp_planes.c                |    2 +-
 drivers/gpu/drm/armada/armada_crtc.c               |    4 +-
 drivers/gpu/drm/armada/armada_debugfs.c            |    2 +-
 drivers/gpu/drm/armada/armada_drm.h                |    2 +
 drivers/gpu/drm/armada/armada_drv.c                |   30 +-
 drivers/gpu/drm/armada/armada_fbdev.c              |    4 +-
 drivers/gpu/drm/armada/armada_gem.c                |   28 +-
 drivers/gpu/drm/armada/armada_overlay.c            |    8 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |   15 +-
 drivers/gpu/drm/ast/ast_cursor.c                   |   11 +-
 drivers/gpu/drm/ast/ast_dp501.c                    |   23 +-
 drivers/gpu/drm/ast/ast_drv.c                      |   82 +-
 drivers/gpu/drm/ast/ast_drv.h                      |   45 +-
 drivers/gpu/drm/ast/ast_main.c                     |   74 +-
 drivers/gpu/drm/ast/ast_mm.c                       |    2 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  143 +-
 drivers/gpu/drm/ast/ast_post.c                     |    6 +-
 drivers/gpu/drm/bridge/Kconfig                     |   33 +
 drivers/gpu/drm/bridge/Makefile                    |    4 +
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   12 -
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    9 -
 drivers/gpu/drm/bridge/cadence/Kconfig             |   24 +
 drivers/gpu/drm/bridge/cadence/Makefile            |    4 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    | 2532 ++++++++++++++++=
+++
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |  400 +++
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c   |   78 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h   |   19 +
 drivers/gpu/drm/bridge/lontium-lt9611.c            | 1230 ++++++++++
 drivers/gpu/drm/bridge/lvds-codec.c                |   29 +
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  109 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  101 +-
 drivers/gpu/drm/bridge/panel.c                     |    7 -
 drivers/gpu/drm/bridge/parade-ps8622.c             |  100 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |   91 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  155 +-
 drivers/gpu/drm/bridge/tc358762.c                  |  280 +++
 drivers/gpu/drm/bridge/tc358764.c                  |  109 +-
 drivers/gpu/drm/bridge/tc358767.c                  |  123 +-
 drivers/gpu/drm/bridge/tc358775.c                  |  749 ++++++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    3 -
 drivers/gpu/drm/drm_atomic_helper.c                |   24 +-
 drivers/gpu/drm/drm_bridge_connector.c             |    1 +
 drivers/gpu/drm/drm_cache.c                        |    2 +-
 drivers/gpu/drm/drm_connector.c                    |   94 +-
 drivers/gpu/drm/drm_debugfs_crc.c                  |    4 +-
 drivers/gpu/drm/drm_dp_helper.c                    |  632 ++++-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  278 ++-
 drivers/gpu/drm/drm_drv.c                          |  119 +-
 drivers/gpu/drm/drm_edid.c                         |   28 +
 drivers/gpu/drm/drm_framebuffer.c                  |    9 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               |   23 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |   16 +-
 drivers/gpu/drm/drm_gem_ttm_helper.c               |    5 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |  169 +-
 drivers/gpu/drm/drm_internal.h                     |    1 +
 drivers/gpu/drm/drm_managed.c                      |   15 +-
 drivers/gpu/drm/drm_panel.c                        |   85 +-
 drivers/gpu/drm/drm_prime.c                        |  104 +-
 drivers/gpu/drm/drm_syncobj.c                      |    2 +-
 drivers/gpu/drm/drm_vblank.c                       |    4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |   15 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   27 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    8 -
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   14 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   10 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   23 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    7 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    9 -
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |    2 +-
 drivers/gpu/drm/gma500/framebuffer.c               |    6 +-
 drivers/gpu/drm/gma500/mdfld_device.c              |   20 +
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |    2 +-
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |   55 +-
 drivers/gpu/drm/gma500/mdfld_dsi_output.h          |    2 +-
 drivers/gpu/drm/gma500/mdfld_output.h              |    2 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |    1 -
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig            |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |   70 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |   33 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |    3 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    6 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    2 +-
 drivers/gpu/drm/i810/i810_dma.c                    |    6 +-
 drivers/gpu/drm/i915/Makefile                      |    1 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |    1 +
 drivers/gpu/drm/i915/display/intel_atomic.c        |   39 -
 drivers/gpu/drm/i915/display/intel_atomic.h        |    4 -
 drivers/gpu/drm/i915/display/intel_audio.c         |    5 -
 drivers/gpu/drm/i915/display/intel_bios.c          |   10 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   13 +-
 drivers/gpu/drm/i915/display/intel_cdclk.h         |    3 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |    3 +
 drivers/gpu/drm/i915/display/intel_csr.c           |    8 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  279 ++-
 drivers/gpu/drm/i915/display/intel_ddi.h           |    2 +
 drivers/gpu/drm/i915/display/intel_display.c       |  241 +-
 drivers/gpu/drm/i915/display/intel_display.h       |    6 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |   39 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   18 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   54 +-
 drivers/gpu/drm/i915/display/intel_dp.c            | 1210 ++++-----
 drivers/gpu/drm/i915/display/intel_dp.h            |   13 +-
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       |  703 ++++++
 .../gpu/drm/i915/display/intel_dp_link_training.c  |   19 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   23 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   87 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |    6 +
 drivers/gpu/drm/i915/display/intel_fbc.c           |   17 +
 drivers/gpu/drm/i915/display/intel_fbdev.c         |    3 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |    2 +
 drivers/gpu/drm/i915/display/intel_gmbus.c         |    2 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  208 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h          |    2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  117 +-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |    2 +
 drivers/gpu/drm/i915/display/intel_hotplug.c       |   28 +-
 drivers/gpu/drm/i915/display/intel_lspcon.c        |    2 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |    8 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |  106 +-
 drivers/gpu/drm/i915/display/intel_panel.h         |    2 +
 drivers/gpu/drm/i915/display/intel_psr.c           |  110 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |    5 +
 drivers/gpu/drm/i915/display/intel_sdvo.c          |    6 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |   12 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |    3 +
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |   10 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |    1 +
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c         |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |   89 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |  162 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |   15 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |   80 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     | 1637 ++++++++-----
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   51 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   40 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |  152 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.h     |    3 +
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |   10 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   30 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_throttle.c       |   67 +-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |    2 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |   11 +-
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |    2 +-
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |   50 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  146 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |    2 +-
 .../drm/i915/gem/selftests/i915_gem_execbuffer.c   |   75 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |   45 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_object.c   |    2 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c |    4 +-
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   |    7 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |  106 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.h               |    5 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |  181 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |  305 ++-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.h        |   36 +
 drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h  |   47 +
 drivers/gpu/drm/i915/gt/intel_context.c            |  319 ++-
 drivers/gpu/drm/i915/gt/intel_context.h            |   13 +
 drivers/gpu/drm/i915/gt/intel_context_types.h      |    5 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |   29 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   34 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |  106 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |    3 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   31 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |   97 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   23 +-
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c     |  105 +-
 .../gpu/drm/i915/gt/intel_gt_buffer_pool_types.h   |    6 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |    1 +
 drivers/gpu/drm/i915/gt/intel_gtt.c                |  300 +--
 drivers/gpu/drm/i915/gt/intel_gtt.h                |  142 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  184 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c              |  150 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.c        |   73 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.h        |    9 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |    1 +
 drivers/gpu/drm/i915/gt/intel_ring.c               |   10 +-
 drivers/gpu/drm/i915/gt/intel_ring.h               |    3 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   42 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |    1 +
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   28 +-
 drivers/gpu/drm/i915/gt/intel_timeline.h           |   24 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  183 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |   30 +-
 drivers/gpu/drm/i915/gt/selftest_context.c         |    2 +
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |    5 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |   22 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c             |   34 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |   36 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |    4 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |    9 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   44 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   32 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |    3 +
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   17 +-
 drivers/gpu/drm/i915/i915_active.c                 |  244 +-
 drivers/gpu/drm/i915/i915_active.h                 |   31 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   10 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |    2 +
 drivers/gpu/drm/i915/i915_drv.c                    |  162 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  144 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  107 +-
 drivers/gpu/drm/i915/i915_gem.h                    |   12 +
 drivers/gpu/drm/i915/i915_getparam.c               |    1 +
 drivers/gpu/drm/i915/i915_gpu_error.c              |    3 +
 drivers/gpu/drm/i915/i915_irq.c                    |  228 +-
 drivers/gpu/drm/i915/i915_params.c                 |    5 +
 drivers/gpu/drm/i915/i915_params.h                 |    1 +
 drivers/gpu/drm/i915/i915_pci.c                    |    1 +
 drivers/gpu/drm/i915/i915_perf.c                   |   57 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   70 +-
 drivers/gpu/drm/i915/i915_request.c                |  248 +-
 drivers/gpu/drm/i915/i915_request.h                |    8 -
 drivers/gpu/drm/i915/i915_suspend.c                |   46 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |   10 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   67 +-
 drivers/gpu/drm/i915/i915_vma.h                    |   13 +-
 drivers/gpu/drm/i915/intel_device_info.c           |   27 +
 drivers/gpu/drm/i915/intel_device_info.h           |    1 +
 drivers/gpu/drm/i915/intel_pm.c                    |   16 +-
 drivers/gpu/drm/i915/intel_sideband.c              |   16 +-
 drivers/gpu/drm/i915/intel_uncore.c                |    3 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   41 +
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |    2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   77 +-
 drivers/gpu/drm/i915/selftests/i915_perf.c         |    4 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |   22 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |    4 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   |   10 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   56 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.h   |    2 +
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |   26 +-
 drivers/gpu/drm/imx/Kconfig                        |    2 +
 drivers/gpu/drm/imx/Makefile                       |    1 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |    9 +
 drivers/gpu/drm/imx/dcss/Makefile                  |    6 +
 drivers/gpu/drm/imx/dcss/dcss-blkctl.c             |   70 +
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |  219 ++
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c              |  424 ++++
 drivers/gpu/drm/imx/dcss/dcss-dev.c                |  325 +++
 drivers/gpu/drm/imx/dcss/dcss-dev.h                |  177 ++
 drivers/gpu/drm/imx/dcss/dcss-dpr.c                |  562 +++++
 drivers/gpu/drm/imx/dcss/dcss-drv.c                |  138 ++
 drivers/gpu/drm/imx/dcss/dcss-dtg.c                |  409 ++++
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |  198 ++
 drivers/gpu/drm/imx/dcss/dcss-kms.h                |   44 +
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |  405 +++
 drivers/gpu/drm/imx/dcss/dcss-scaler.c             |  826 +++++++
 drivers/gpu/drm/imx/dcss/dcss-ss.c                 |  180 ++
 drivers/gpu/drm/imx/imx-ldb.c                      |   10 -
 drivers/gpu/drm/imx/parallel-display.c             |    6 -
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   41 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |   38 +-
 drivers/gpu/drm/lima/lima_gem.c                    |   11 +-
 drivers/gpu/drm/lima/lima_vm.c                     |    5 +-
 drivers/gpu/drm/mcde/mcde_display.c                |  218 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |   67 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |   81 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |  276 ++-
 drivers/gpu/drm/mediatek/Kconfig                   |    2 +-
 drivers/gpu/drm/mediatek/Makefile                  |    5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   80 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   38 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   23 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   37 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    6 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   21 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |    1 -
 drivers/gpu/drm/mgag200/Kconfig                    |   12 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |  227 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |   19 +-
 drivers/gpu/drm/mgag200/mgag200_mm.c               |    8 +
 drivers/gpu/drm/mgag200/mgag200_mode.c             |  153 +-
 drivers/gpu/drm/mgag200/mgag200_reg.h              |    4 +
 drivers/gpu/drm/msm/Kconfig                        |   19 +-
 drivers/gpu/drm/msm/Makefile                       |   18 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   65 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   77 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   82 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |   21 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  120 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |   12 +
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |    2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |    5 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |    3 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  182 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   10 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   12 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  105 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   82 +-
 drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h        |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c       |   15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |  109 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  132 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   55 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |    5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |    4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  145 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |    4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |    9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   84 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |    4 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c   |   51 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h           |   13 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  |   47 -
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |    7 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c   |   24 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c       |   68 -
 drivers/gpu/drm/msm/dp/dp_audio.c                  |  638 +++++
 drivers/gpu/drm/msm/dp/dp_audio.h                  |   72 +
 drivers/gpu/drm/msm/dp/dp_aux.c                    |  535 ++++
 drivers/gpu/drm/msm/dp/dp_aux.h                    |   30 +
 drivers/gpu/drm/msm/dp/dp_catalog.c                | 1019 ++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h                |  131 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 1869 ++++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |   36 +
 drivers/gpu/drm/msm/dp/dp_debug.c                  |  485 ++++
 drivers/gpu/drm/msm/dp/dp_debug.h                  |   74 +
 drivers/gpu/drm/msm/dp/dp_display.c                | 1463 +++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h                |   39 +
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  164 ++
 drivers/gpu/drm/msm/dp/dp_drm.h                    |   18 +
 drivers/gpu/drm/msm/dp/dp_hpd.c                    |   69 +
 drivers/gpu/drm/msm/dp/dp_hpd.h                    |   80 +
 drivers/gpu/drm/msm/dp/dp_link.c                   | 1210 +++++++++
 drivers/gpu/drm/msm/dp/dp_link.h                   |  155 ++
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  463 ++++
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  100 +
 drivers/gpu/drm/msm/dp/dp_parser.c                 |  293 +++
 drivers/gpu/drm/msm/dp/dp_parser.h                 |  136 ++
 drivers/gpu/drm/msm/dp/dp_power.c                  |  372 +++
 drivers/gpu/drm/msm/dp/dp_power.h                  |  107 +
 drivers/gpu/drm/msm/dp/dp_reg.h                    |  306 +++
 drivers/gpu/drm/msm/dsi/dsi.h                      |    2 +
 drivers/gpu/drm/msm/dsi/dsi.xml.h                  |  423 ++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |    5 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |    2 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |    1 -
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |  102 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |    6 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  255 ++
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.c              |    4 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.h              |   10 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c          |  904 +++++++
 drivers/gpu/drm/msm/msm_drv.c                      |   28 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   97 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   75 +-
 drivers/gpu/drm/msm/msm_gem.h                      |   10 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |    2 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |    5 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |    8 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   14 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   56 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   22 +-
 drivers/gpu/drm/msm/msm_gpu_trace.h                |   83 +
 drivers/gpu/drm/msm/msm_gpummu.c                   |   17 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |  208 +-
 drivers/gpu/drm/msm/msm_mmu.h                      |   16 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |    1 +
 drivers/gpu/drm/msm/msm_submitqueue.c              |    7 +-
 drivers/gpu/drm/mxsfb/Kconfig                      |    8 +-
 drivers/gpu/drm/mxsfb/Makefile                     |    2 +-
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 |  343 ---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  273 +--
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |   42 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  571 +++++
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |   99 -
 drivers/gpu/drm/mxsfb/mxsfb_regs.h                 |  107 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |    9 +-
 drivers/gpu/drm/nouveau/dispnv04/dac.c             |    2 +-
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |    7 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |   29 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.h            |    4 +
 drivers/gpu/drm/nouveau/dispnv04/overlay.c         |    4 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |    2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  311 +--
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    3 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  440 ++--
 drivers/gpu/drm/nouveau/nouveau_bo.h               |   29 +-
 drivers/gpu/drm/nouveau/nouveau_bo0039.c           |    4 +-
 drivers/gpu/drm/nouveau/nouveau_bo5039.c           |    2 +-
 drivers/gpu/drm/nouveau/nouveau_bo74c1.c           |    2 +-
 drivers/gpu/drm/nouveau/nouveau_bo85b5.c           |    2 +-
 drivers/gpu/drm/nouveau/nouveau_bo9039.c           |    2 +-
 drivers/gpu/drm/nouveau/nouveau_bo90b5.c           |    2 +-
 drivers/gpu/drm/nouveau/nouveau_boa0b5.c           |    2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |    4 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  132 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |    1 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |   72 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |    3 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |    6 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c               |  210 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    4 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |    6 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |   48 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    5 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   34 +-
 drivers/gpu/drm/nouveau/nouveau_mem.c              |    8 +-
 drivers/gpu/drm/nouveau/nouveau_mem.h              |   10 +-
 drivers/gpu/drm/nouveau/nouveau_prime.c            |   13 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |   66 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |  193 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.h              |    9 +-
 drivers/gpu/drm/nouveau/nv17_fence.c               |    7 +-
 drivers/gpu/drm/nouveau/nv50_fence.c               |    7 +-
 drivers/gpu/drm/nouveau/nv84_fence.c               |   13 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |    1 -
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |    1 -
 drivers/gpu/drm/omapdrm/dss/venc.c                 |    2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   17 -
 drivers/gpu/drm/omapdrm/omap_gem.c                 |   14 +-
 drivers/gpu/drm/panel/Kconfig                      |   34 +-
 drivers/gpu/drm/panel/Makefile                     |    3 +
 drivers/gpu/drm/panel/panel-arm-versatile.c        |    4 +-
 .../gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c   |    6 +-
 drivers/gpu/drm/panel/panel-boe-himax8279d.c       |   48 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   12 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c       |   51 +-
 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c  |   23 +-
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |   25 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |    7 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |  277 ++-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   35 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |    4 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |   37 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c |   58 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |   49 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c          |    4 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |    4 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |   13 +-
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c   |  328 +++
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c       |    4 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c      |   60 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |   46 +-
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |    4 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   13 +-
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |    4 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |    4 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |    6 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |   40 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |   18 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |   20 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |    7 +-
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |   27 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |    9 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |    9 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c  |  139 ++
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c  |  101 +
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |  174 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.h      |   13 +
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |    6 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |    7 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |    4 +-
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |    4 +-
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c    |    4 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |    4 +-
 drivers/gpu/drm/panel/panel-simple.c               |  232 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |   14 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |   61 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |    4 +-
 drivers/gpu/drm/panel/panel-sony-acx424akp.c       |   85 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |    7 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |    4 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |    6 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |   42 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c        |   63 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |   41 +-
 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c   |   51 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  175 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.h        |   30 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |   61 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |   17 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   27 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |    4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   37 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.h            |    2 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |   10 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |    7 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |   10 +-
 drivers/gpu/drm/panfrost/panfrost_regs.h           |    4 +
 drivers/gpu/drm/pl111/pl111_drv.c                  |   20 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                      |    2 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   22 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |    6 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |    2 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |   34 +-
 drivers/gpu/drm/qxl/qxl_object.h                   |    4 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |  112 +-
 drivers/gpu/drm/radeon/radeon.h                    |   10 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |    2 +-
 drivers/gpu/drm/radeon/radeon_display.c            |    2 +-
 drivers/gpu/drm/radeon/radeon_gart.c               |   10 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |   10 +-
 drivers/gpu/drm/radeon/radeon_mn.c                 |    2 +-
 drivers/gpu/drm/radeon/radeon_object.c             |   46 +-
 drivers/gpu/drm/radeon/radeon_object.h             |    2 +-
 drivers/gpu/drm/radeon/radeon_pm.c                 |   29 +-
 drivers/gpu/drm/radeon/radeon_prime.c              |    4 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |  333 +--
 drivers/gpu/drm/radeon/radeon_vm.c                 |    6 +-
 drivers/gpu/drm/radeon/uvd_v1_0.c                  |    4 +-
 drivers/gpu/drm/radeon/uvd_v2_2.c                  |    2 +-
 drivers/gpu/drm/radeon/uvd_v4_2.c                  |    2 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |    5 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   37 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   54 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.h              |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |   17 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |    8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   47 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    9 -
 drivers/gpu/drm/scheduler/sched_fence.c            |    2 +-
 drivers/gpu/drm/scheduler/sched_main.c             |    4 +-
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c |   17 +
 drivers/gpu/drm/sti/sti_dvo.c                      |    2 -
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    2 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |    2 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |    2 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   11 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   13 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    6 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |    6 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |    5 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |    2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |    2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |    2 +-
 drivers/gpu/drm/tegra/drm.h                        |    2 +
 drivers/gpu/drm/tegra/dsi.c                        |    4 +-
 drivers/gpu/drm/tegra/gem.c                        |   29 +-
 drivers/gpu/drm/tegra/output.c                     |   34 +-
 drivers/gpu/drm/tegra/plane.c                      |   15 +-
 drivers/gpu/drm/tegra/rgb.c                        |  102 +-
 drivers/gpu/drm/tegra/sor.c                        |    7 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |   32 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |    4 +
 drivers/gpu/drm/ttm/Makefile                       |    3 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |   45 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |  513 ++--
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  402 +--
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   46 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |   12 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |    9 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |    6 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |    6 +-
 .../ttm/{ttm_bo_manager.c =3D> ttm_range_manager.c}  |   84 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |  146 ++
 drivers/gpu/drm/ttm/ttm_tt.c                       |   93 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |   13 +-
 drivers/gpu/drm/v3d/v3d_mmu.c                      |   13 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   10 +-
 drivers/gpu/drm/vc4/Makefile                       |    1 +
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  368 ++-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    5 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |   45 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 1650 ++++++++-----
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |  184 ++
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                 |  521 ++++
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h                |  442 ++++
 drivers/gpu/drm/vc4/vc4_hvs.c                      |  269 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |  256 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  224 +-
 drivers/gpu/drm/vc4/vc4_regs.h                     |  177 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |    4 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |   57 +-
 drivers/gpu/drm/virtio/Kconfig                     |    3 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |    1 +
 drivers/gpu/drm/virtio/virtgpu_display.c           |   13 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |    3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   23 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |    3 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   14 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |   36 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |   96 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |  120 +-
 drivers/gpu/drm/vkms/Makefile                      |    9 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |  171 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    5 +
 drivers/gpu/drm/vkms/vkms_drv.c                    |   56 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   10 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    4 +
 drivers/gpu/drm/vkms/vkms_writeback.c              |  142 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   70 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |   73 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |   60 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c                |   71 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  253 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |    5 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |    6 -
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |   27 +-
 drivers/gpu/host1x/job.c                           |   22 +-
 drivers/media/platform/vsp1/vsp1_drm.c             |    8 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |    4 +
 drivers/phy/mediatek/Kconfig                       |    7 +
 drivers/phy/mediatek/Makefile                      |    5 +
 .../mediatek/phy-mtk-hdmi-mt2701.c}                |    4 +-
 .../mediatek/phy-mtk-hdmi-mt8173.c}                |    2 +-
 .../mtk_hdmi_phy.c =3D> phy/mediatek/phy-mtk-hdmi.c} |    6 +-
 .../mtk_hdmi_phy.h =3D> phy/mediatek/phy-mtk-hdmi.h} |    3 +-
 drivers/pwm/pwm-crc.c                              |  128 +-
 drivers/pwm/pwm-lpss-platform.c                    |    1 -
 drivers/pwm/pwm-lpss.c                             |   85 +-
 drivers/pwm/pwm-lpss.h                             |    3 -
 drivers/video/fbdev/Kconfig                        |   19 -
 drivers/video/fbdev/Makefile                       |    1 -
 drivers/video/fbdev/arcfb.c                        |    2 +-
 drivers/video/fbdev/arkfb.c                        |   41 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |    2 +-
 drivers/video/fbdev/aty/aty128fb.c                 |   51 +-
 drivers/video/fbdev/aty/atyfb.h                    |    4 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   50 +-
 drivers/video/fbdev/aty/radeon_base.c              |   12 +-
 drivers/video/fbdev/aty/radeon_pm.c                |   38 +-
 drivers/video/fbdev/aty/radeonfb.h                 |    3 +-
 drivers/video/fbdev/core/fbcon.c                   |    2 -
 drivers/video/fbdev/core/fbmem.c                   |   14 +-
 drivers/video/fbdev/cyber2000fb.c                  |   13 +-
 drivers/video/fbdev/geode/gxfb.h                   |    5 -
 drivers/video/fbdev/geode/gxfb_core.c              |   36 +-
 drivers/video/fbdev/geode/lxfb.h                   |    5 -
 drivers/video/fbdev/geode/lxfb_core.c              |   37 +-
 drivers/video/fbdev/geode/lxfb_ops.c               |    4 -
 drivers/video/fbdev/geode/suspend_gx.c             |    4 -
 drivers/video/fbdev/i740fb.c                       |   40 +-
 drivers/video/fbdev/kyro/STG4000InitDevice.c       |    7 +-
 drivers/video/fbdev/mbx/Makefile                   |    4 -
 drivers/video/fbdev/mbx/mbxdebugfs.c               |  232 --
 drivers/video/fbdev/mbx/mbxfb.c                    | 1053 --------
 drivers/video/fbdev/mbx/reg_bits.h                 |  614 -----
 drivers/video/fbdev/mbx/regs.h                     |  196 --
 drivers/video/fbdev/nvidia/nvidia.c                |   64 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |    2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |    2 +-
 drivers/video/fbdev/omap2/omapfb/dss/venc.c        |    2 +-
 drivers/video/fbdev/pvr2fb.c                       |    2 +
 drivers/video/fbdev/s3fb.c                         |   39 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |   53 +-
 drivers/video/fbdev/sis/init.c                     |   11 +-
 drivers/video/fbdev/sm712fb.c                      |    8 +
 drivers/video/fbdev/ssd1307fb.c                    |    8 +-
 drivers/video/fbdev/sstfb.c                        |    2 +-
 drivers/video/fbdev/tgafb.c                        |   12 +-
 drivers/video/fbdev/udlfb.c                        |    4 +-
 drivers/video/fbdev/vga16fb.c                      |   14 +-
 drivers/video/fbdev/via/via-core.c                 |   39 +-
 drivers/video/fbdev/vt8623fb.c                     |   41 +-
 drivers/virtio/Kconfig                             |    7 +
 drivers/virtio/Makefile                            |    1 +
 drivers/virtio/virtio.c                            |    6 +
 drivers/virtio/virtio_dma_buf.c                    |   88 +
 drivers/virtio/virtio_mmio.c                       |   31 +
 drivers/virtio/virtio_pci_modern.c                 |   95 +
 drivers/xen/gntdev-dmabuf.c                        |   13 +-
 include/drm/bridge/dw_mipi_dsi.h                   |    1 +
 include/drm/drm_atomic_helper.h                    |    3 +
 include/drm/drm_connector.h                        |    3 +
 include/drm/drm_device.h                           |    2 +-
 include/drm/drm_dp_helper.h                        |   90 +-
 include/drm/drm_dp_mst_helper.h                    |   47 +-
 include/drm/drm_drv.h                              |   20 +-
 include/drm/drm_edid.h                             |    4 +
 include/drm/drm_gem_vram_helper.h                  |   10 +-
 include/drm/drm_mm.h                               |    2 +-
 include/drm/drm_mode_config.h                      |    6 +
 include/drm/drm_modes.h                            |   26 +-
 include/drm/drm_panel.h                            |   15 +-
 include/drm/drm_prime.h                            |    5 +-
 include/drm/gpu_scheduler.h                        |   13 +-
 include/drm/i915_pciids.h                          |   18 +-
 include/drm/ttm/ttm_bo_api.h                       |  123 +-
 include/drm/ttm/ttm_bo_driver.h                    |  458 ++--
 include/drm/ttm/ttm_execbuf_util.h                 |   19 +-
 include/drm/ttm/ttm_memory.h                       |   26 +-
 include/drm/ttm/ttm_placement.h                    |    9 +-
 include/drm/ttm/ttm_resource.h                     |  237 ++
 include/drm/ttm/ttm_tt.h                           |   98 +-
 include/linux/adreno-smmu-priv.h                   |   36 +
 include/linux/dma-buf.h                            |    3 +-
 include/linux/fb.h                                 |   18 +-
 include/linux/font.h                               |    4 +-
 include/linux/moduleparam.h                        |    7 +-
 include/linux/phy/phy.h                            |    2 +
 include/linux/via-core.h                           |    2 -
 include/linux/virtio.h                             |    1 +
 include/linux/virtio_config.h                      |   17 +
 include/linux/virtio_dma_buf.h                     |   37 +
 include/uapi/drm/amdgpu_drm.h                      |    1 +
 include/uapi/drm/drm_mode.h                        |   21 +-
 include/uapi/drm/i915_drm.h                        |   59 +-
 include/uapi/linux/kfd_ioctl.h                     |   11 +-
 include/uapi/linux/virtio_gpu.h                    |   19 +
 include/uapi/linux/virtio_mmio.h                   |   11 +
 include/uapi/linux/virtio_pci.h                    |   11 +-
 include/video/mbxfb.h                              |   99 -
 kernel/params.c                                    |   17 +-
 lib/fonts/Kconfig                                  |    7 +
 lib/fonts/Makefile                                 |    1 +
 lib/fonts/font_6x8.c                               | 2576 ++++++++++++++++=
++++
 lib/fonts/fonts.c                                  |    3 +
 samples/vfio-mdev/mbochs.c                         |    3 +-
 1308 files changed, 65247 insertions(+), 20239 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
 create mode 100644
Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_rap_if.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_par=
ams.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_=
mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce60/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dc=
e60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dc=
e60.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dc=
e60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dc=
e60.h
 mode change 100755 =3D> 100644
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
 mode change 100755 =3D> 100644
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
 mode change 100755 =3D> 100644
drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
 mode change 100755 =3D> 100644
drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/pm/Makefile
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm}/amdgpu_dpm.c (76%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm}/amdgpu_pm.c (81%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/amd_powerplay.h (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/inc}/amdgpu_dpm.h (93%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/inc}/amdgpu_pm.h (84%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/amdgpu_smu.h (96%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/arcturus_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/cz_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/fiji_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/hardwaremanager.h (100%=
)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/hwmgr.h (98%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/polaris10_pwrvirus.h (1=
00%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/power_state.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/pp_debug.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/pp_endian.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/pp_thermal.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/ppinterrupt.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/rv_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu10.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu10_driver_if.h (98%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu11_driver_if.h (100%=
)
 rename drivers/gpu/drm/amd/{powerplay =3D>
pm}/inc/smu11_driver_if_arcturus.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu11_driver_if_navi10.=
h (97%)
 rename drivers/gpu/drm/amd/{powerplay =3D>
pm}/inc/smu11_driver_if_sienna_cichlid.h (98%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu12_driver_if.h (100%=
)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu7.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu71.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu71_discrete.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu72.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu72_discrete.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu73.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu73_discrete.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu74.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu74_discrete.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu75.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu75_discrete.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu7_common.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu7_discrete.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu7_fusion.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu8.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu8_fusion.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu9.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu9_driver_if.h (100%)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_types.h (98%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_ucode_xfer_cz.h (10=
0%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_ucode_xfer_vi.h (10=
0%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v11_0.h (90%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v11_0_7_ppsmc.h (10=
0%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v11_0_7_pptable.h (=
100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v11_0_ppsmc.h (95%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v11_0_pptable.h (10=
0%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v12_0.h (96%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smu_v12_0_ppsmc.h (100%=
)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/smumgr.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/tonga_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/vega10_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/vega12/smu9_driver_if.h=
 (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/vega12_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm}/inc/vega20_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/Makefile (70%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/amd_powerplay.c (98%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/cik_dpm.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/Makefile (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ci_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ci_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/common_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/common_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/fiji_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/fiji_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/hardwaremanager.c (9=
9%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/hwmgr.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/hwmgr_ppt.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/polaris_baco.c (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/polaris_baco.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pp_overdriver.c (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pp_overdriver.h (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pp_psm.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pp_psm.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ppatomctrl.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ppatomctrl.h (98%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ppatomfwctrl.c (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ppatomfwctrl.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/ppevvmath.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pppcielanes.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pppcielanes.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/pptable_v1_0.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/process_pptables_v1_0.c (100%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/process_pptables_v1_0.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/processpptables.c (1=
00%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/processpptables.h (1=
00%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu10_hwmgr.c (92%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu10_hwmgr.h (98%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu10_inc.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/smu7_clockpowergating.c (100%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/smu7_clockpowergating.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_dyn_defaults.h =
(100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_hwmgr.c (99%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_hwmgr.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_powertune.c (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_powertune.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_thermal.c (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu7_thermal.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu8_hwmgr.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu8_hwmgr.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu9_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu9_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu_helper.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/smu_helper.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/tonga_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/tonga_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_hwmgr.c (99%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_hwmgr.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_inc.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_powertune.c (=
100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_powertune.h (=
100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_pptable.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/vega10_processpptables.c (100%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/vega10_processpptables.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_thermal.c (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega10_thermal.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_hwmgr.c (95%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_hwmgr.h (99%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_inc.h (97%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_pptable.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/vega12_processpptables.c (99%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/vega12_processpptables.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_thermal.c (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega12_thermal.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_baco.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_baco.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_hwmgr.c (96%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_hwmgr.h (99%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_inc.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_powertune.c (=
100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_powertune.h (=
100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_pptable.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/vega20_processpptables.c (99%)
 rename drivers/gpu/drm/amd/{ =3D>
pm}/powerplay/hwmgr/vega20_processpptables.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_thermal.c (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/hwmgr/vega20_thermal.h (10=
0%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/kv_dpm.c (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/kv_dpm.h (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/kv_smc.c (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/ppsmc.h (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/r600_dpm.h (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/si_dpm.c (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/si_dpm.h (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/si_smc.c (100%)
 rename drivers/gpu/drm/amd/{amdgpu =3D> pm/powerplay}/sislands_smc.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/Makefile (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/ci_smumgr.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/ci_smumgr.h (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/fiji_smumgr.c (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/fiji_smumgr.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/iceland_smumgr.c (1=
00%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/iceland_smumgr.h (1=
00%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/polaris10_smumgr.c =
(100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/polaris10_smumgr.h =
(100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu10_smumgr.c (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu10_smumgr.h (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu7_smumgr.c (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu7_smumgr.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu8_smumgr.c (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu8_smumgr.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu9_smumgr.c (94%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smu9_smumgr.h (100%=
)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/smumgr.c (100%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/tonga_smumgr.c (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/tonga_smumgr.h (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vega10_smumgr.c (98=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vega10_smumgr.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vega12_smumgr.c (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vega12_smumgr.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vega20_smumgr.c (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vega20_smumgr.h (10=
0%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vegam_smumgr.c (100=
%)
 rename drivers/gpu/drm/amd/{ =3D> pm}/powerplay/smumgr/vegam_smumgr.h (100=
%)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/Makefile
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu}/amdgpu_smu.c (94%)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu11}/arcturus_ppt.c =
(95%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu11}/arcturus_ppt.h =
(100%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu11}/navi10_ppt.c (8=
7%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu11}/navi10_ppt.h (9=
6%)
 rename drivers/gpu/drm/amd/{powerplay =3D>
pm/swsmu/smu11}/sienna_cichlid_ppt.c (94%)
 rename drivers/gpu/drm/amd/{powerplay =3D>
pm/swsmu/smu11}/sienna_cichlid_ppt.h (92%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu11}/smu_v11_0.c (88=
%)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu12}/renoir_ppt.c (8=
2%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu12}/renoir_ppt.h (9=
6%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu/smu12}/smu_v12_0.c (95=
%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu}/smu_cmn.c (92%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu}/smu_cmn.h (89%)
 rename drivers/gpu/drm/amd/{powerplay =3D> pm/swsmu}/smu_internal.h (94%)
 create mode 100644 drivers/gpu/drm/bridge/cadence/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/cadence/Makefile
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611.c
 create mode 100644 drivers/gpu/drm/bridge/tc358762.c
 create mode 100644 drivers/gpu/drm/bridge/tc358775.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dp_hdcp.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_breadcrumbs.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
 create mode 100644 drivers/gpu/drm/imx/dcss/Kconfig
 create mode 100644 drivers/gpu/drm/imx/dcss/Makefile
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-blkctl.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-crtc.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ctxld.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.h
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dpr.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-drv.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dtg.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.h
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-plane.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-scaler.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ss.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_audio.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_audio.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_aux.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_aux.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_catalog.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_catalog.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_ctrl.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_ctrl.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_debug.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_debug.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_display.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_display.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_drm.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_drm.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_link.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_link.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_panel.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_panel.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_parser.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_parser.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_power.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_power.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_reg.h
 create mode 100644 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
 create mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c
 delete mode 100644 drivers/gpu/drm/mxsfb/mxsfb_crtc.c
 create mode 100644 drivers/gpu/drm/mxsfb/mxsfb_kms.c
 delete mode 100644 drivers/gpu/drm/mxsfb/mxsfb_out.c
 create mode 100644 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
 rename drivers/gpu/drm/ttm/{ttm_bo_manager.c =3D> ttm_range_manager.c} (63=
%)
 create mode 100644 drivers/gpu/drm/ttm/ttm_resource.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.h
 create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi_regs.h
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
 rename drivers/{gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c =3D>
phy/mediatek/phy-mtk-hdmi-mt2701.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c =3D>
phy/mediatek/phy-mtk-hdmi-mt8173.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.c =3D>
phy/mediatek/phy-mtk-hdmi.c} (96%)
 rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.h =3D>
phy/mediatek/phy-mtk-hdmi.h} (95%)
 delete mode 100644 drivers/video/fbdev/mbx/Makefile
 delete mode 100644 drivers/video/fbdev/mbx/mbxdebugfs.c
 delete mode 100644 drivers/video/fbdev/mbx/mbxfb.c
 delete mode 100644 drivers/video/fbdev/mbx/reg_bits.h
 delete mode 100644 drivers/video/fbdev/mbx/regs.h
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/drm/ttm/ttm_resource.h
 create mode 100644 include/linux/adreno-smmu-priv.h
 create mode 100644 include/linux/virtio_dma_buf.h
 delete mode 100644 include/video/mbxfb.h
 create mode 100644 lib/fonts/font_6x8.c
