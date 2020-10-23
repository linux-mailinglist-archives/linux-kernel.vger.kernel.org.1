Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B6297950
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757154AbgJWWbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757088AbgJWWbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:31:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820ACC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so2464261pgk.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Edx03jHqA1XnqADzKbqfggsFFBNfUXa9nAUlpq9B24Q=;
        b=fKG35dstguVQWaru/eLfc8SkSaxJzz35s3r78GnwBjDw7K2kTOMqjRE/1gEIFikeyb
         Ymd42SvODJRO3eS+gfGIoV0pFopSJoX7v356dGNhFTl0CcsST3cMkRZX9ej8l4kEhCS7
         EDZmiCRvRBO88Q5/mbbGR3HIQMtVIzWrVCrKDqv8mLHZCk6og5Jl8J+sBYzVPQ3zhgyW
         HkdqQw6KrGhSuEYDdym9yN18SC+FZCAarYyoV7+tazhC5x0vBCALrl4V4jsNz4fWH+GO
         tMhtdMlkLaqJa8ma3P1rbv4Lk3wY48ao0xId8z+8EsPS/qv4cvfgHbouU14suUXwmOdk
         ih8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Edx03jHqA1XnqADzKbqfggsFFBNfUXa9nAUlpq9B24Q=;
        b=C2moWdTrqj3WH7ykySI4NpAEqf/Yc1oh0qUu7CchEceTJYEz6urOPso/+qOcJu5BAl
         e/+zPd1EMq+jNwbEZzb3LBn7smmWTeGRk4nDVtMMsPclEUioBucxxoNTg6NMtV1NTFZt
         F4Pu29dggDjVEN4/PTNkgaSeNYuW911t9eJV/RwZVe4k+LiNyQ8QAGCcTwi5kZTy+stS
         He5wTqWdmVN+uE4DggkIK68CmUFlF6GtNbwZTAE1ZwE8RMhDUGzHx9RY6D+/5Nc9C80g
         mI80xQ2s5lOHOpPYezo0Jbo/ivQ3b7cfhVakq8Mu4gRJ0swQyloDRU41Nd7n33FdjzYe
         ebfA==
X-Gm-Message-State: AOAM530knmxa3SrVnLLfcDY7ffqYzIhxNt1RgZayzfjWcbiRcabWBpld
        ZLkhwXl9+AmldIuGzAEhqCL0FUkS9hctBA==
X-Google-Smtp-Source: ABdhPJxZgKqdzD4PlBuc+2FVi549bD58w76jP3DWQ2Aww+/olXqhKx7/Jq2cUakR5q5aeobQHe7uDQ==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr5453392pjb.192.1603492311805;
        Fri, 23 Oct 2020 15:31:51 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o15sm3406457pfp.91.2020.10.23.15.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:31:49 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/5] ARM: SoC-related driver updates
Date:   Fri, 23 Oct 2020 15:31:20 -0700
Message-Id: <20201023223122.19189-4-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201023223122.19189-1-olof@lixom.net>
References: <20201023223122.19189-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various driver updates for platforms. A bulk of this is smaller fixes or
cleanups, but some of the new material this time around is:

- Support for Nvidia Tegra234 SoC
- Ring accelerator support for TI AM65x
- PRUSS driver for TI platforms
- Renesas support for R-Car V3U SoC
- Reset support for Cortex-M4 processor on i.MX8MQ

There are also new socinfo entries for a handful of different SoCs
and platforms.


Conflicts:

drivers/reset/reset-imx7.c:
Add/change: Keep new case, remove fallthrough comments


----------------------------------------------------------------

The following changes since commit 7da6ec9d4d45cceffd541dc1dba66fa76eb78353:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

for you to fetch changes up to 9f7f26930035f557838e215797cb620b563b98ab:

  Merge tag 'v5.9-next-soc' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/drivers

----------------------------------------------------------------

Alain Volmat (1):
      reset: sti: reset-syscfg: fix struct description warnings

Alex Dewar (1):
      memory: brcmstb_dpfe: Fix memory leak

Anson Huang (2):
      soc: imx: gpcv2: Use dev_err_probe() to simplify error handling
      reset: imx7: Support module build

Cedric Neveux (1):
      driver: tee: Handle NULL pointer indication from client

Cristian Marussi (2):
      firmware: arm_scmi: Add system power protocol support
      firmware: arm_scmi: Add SCMI device for system power protocol

Dan Carpenter (2):
      memory: omap-gpmc: Fix a couple off by ones
      memory: emif: Remove bogus debugfs error handling

Dennis YC Hsieh (9):
      soc: mediatek: cmdq: add address shift in jump
      soc: mediatek: cmdq: add write_s function
      soc: mediatek: cmdq: add write_s_mask function
      soc: mediatek: cmdq: add read_s function
      soc: mediatek: cmdq: add write_s value function
      soc: mediatek: cmdq: add write_s_mask value function
      soc: mediatek: cmdq: add jump function
      soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
      drm/mediatek: reduce clear event

Douglas Anderson (2):
      soc: qcom: socinfo: add SC7180 entry to soc_id array
      soc: qcom-geni-se: Don't use relaxed writes when writing commands

Fabien Parent (2):
      dt-bindings: memory: mediatek: Add binding for MT8167 SMI
      memory: mtk-smi: add support for MT8167

Florian Fainelli (8):
      bus: brcmstb_gisb: Shorten prints
      soc: bcm: brcmstb: biuctrl: Enable Read-ahead cache
      soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72164
      soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72165
      soc: bcm: brcmstb: biuctrl: Change RAC prefetch distance from +/-1 to +/- 2
      soc: bcm: brcmstb: biuctrl: Change RAC data line prefetching after 4 consecutive lines
      dt-bindings: bus: Document breakpoint interrupt for gisb-arb
      bus: brcmstb_gisb: Add support for breakpoint interrupts

Geert Uytterhoeven (1):
      Merge tag 'renesas-r8a779a0-dt-binding-defs-tag' into renesas-drivers-for-v5.10

Grygorii Strashko (2):
      soc: ti: k3: ringacc: add am65x sr2.0 support
      bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk

Grzegorz Jaszczyk (3):
      dt-bindings: soc: ti: Add TI PRUSS bindings
      dt-bindings: soc: ti: Update TI PRUSS bindings regarding clock-muxes
      soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX

Jason Yan (2):
      soc: sunxi: sram: remove unneeded semicolon
      soc: fsl: dpio: remove set but not used 'addr_cena'

John Hubbard (1):
      tee: convert get_user_pages() --> pin_user_pages()

Jorge Ramirez-Ortiz (2):
      drivers: optee: allow op-tee to access devices on the i2c bus
      drivers: optee: fix i2c build issue

Kathiravan T (1):
      soc: qcom: socinfo: add soc id for IPQ6018

Kevin Hilman (1):
      soc: amlogic: pm-domains: use always-on flag

Konrad Dybcio (1):
      soc: qcom: socinfo: Add msm8992/4 and apq8094 SoC IDs

Krzysztof Kozlowski (22):
      memory: samsung: exynos5422-dmc: Document mutex scope
      memory: omap-gpmc: remove unneeded asm/mach-types.h inclusion
      memory: omap-gpmc: remove unused file-scope phys_base and mem_size
      memory: omap-gpmc: return meaningful error codes in gpmc_cs_set_timings()
      memory: omap-gpmc: remove GPMC_SET_ONE_CD_MAX macro for safety
      memory: omap-gpmc: use WARN() instead of BUG() on wrong free
      memory: omap-gpmc: consistently use !res for NULL checks
      memory: renesas-rpc-if: simplify with PTR_ERR_OR_ZERO
      memory: tegra: tegra210-emc: fix indentation
      memory: brcmstb_dpfe: add separate entry for compile test
      memory: Enable compile testing for most of the drivers
      memory: samsung: exynos5422-dmc: rename timing register fields variables
      memory: samsung: exynos5422-dmc: remove unused exynos5_dmc members
      memory: samsung: exynos5422-dmc: add missing and fix kerneldoc
      memory: brcmstb_dpfe: Simplify with dev_err_probe()
      memory: tegra186-emc: Simplify with dev_err_probe()
      memory: fsl-corenet-cf: Fix handling of platform_get_irq() error
      memory: omap-gpmc: Fix compile test on SPARC
      Add missing '#' to fix schema errors:
      soc: fsl: qbman: Fix return value on success
      reset: Fix and extend kerneldoc
      soc: mediatek: mtk-infracfg: Fix kerneldoc

Kuninori Morimoto (4):
      soc: renesas: Use menu for Renesas SoC
      soc: renesas: Align driver description titles
      soc: renesas: Use ARM32/ARM64 for menu description
      soc: renesas: Sort driver description title

Li Yang (1):
      soc: fsl: qman: fix -Wpacked-not-aligned warnings

Liu Shixin (1):
      soc: fsl: qman: convert to use be32_add_cpu()

Lukasz Luba (1):
      memory: samsung: exynos5422-dmc: Additional locking for 'curr_rate'

Markus Mayer (1):
      memory: brcmstb_dpfe: fix array index out of bounds

Neil Armstrong (2):
      dt-bindings: power: amlogic, meson-ee-pwrc: add Amlogic AXG power controller bindings
      soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs

Nicolin Chen (1):
      memory: tegra: Correct shift value of apew

Olof Johansson (21):
      Merge tag 'optee-i2c-for-v5.10' of git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'tee-memref-null-for-v5.10' of git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'tee-pin-user-pages-for-5.10' of git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'optee-i2c-fix-for-v5.10' of git://git.linaro.org:/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'renesas-drivers-for-v5.10-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'memory-controller-drv-5.10' of https://git.kernel.org/.../krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'arm-soc/for-5.10/drivers' of https://github.com/Broadcom/stblinux into arm/drivers
      Merge tag 'scmi-updates-5.10' of git://git.kernel.org/.../sudeep.holla/linux into arm/drivers
      Merge tag 'renesas-drivers-for-v5.10-tag2' of git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'tee-dev-cleanup-for-v5.10' of git://git.linaro.org:/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'tegra-for-5.10-soc' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.10-firmware' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'drivers_soc_for_5.10' of git://git.kernel.org/.../ssantosh/linux-keystone into arm/drivers
      Merge tag 'sunxi-drivers-for-5.10-1' of https://git.kernel.org/.../sunxi/linux into arm/drivers
      Merge tag 'imx-drivers-5.10' of git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'soc-fsl-next-v5.10' of git://git.kernel.org/.../leo/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.10' of https://git.kernel.org/.../qcom/linux into arm/drivers
      Merge tag 'amlogic-drivers' of https://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      Merge tag 'reset-for-v5.10' of git://git.pengutronix.de/pza/linux into arm/drivers
      Merge tag 'memory-controller-drv-5.10-2' of https://git.kernel.org/.../krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'v5.9-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into arm/drivers

Peng Fan (3):
      firmware: imx: scu-pd: ignore power domain not owned
      dt-bindings: reset: imx8mq: add m4 reset
      reset: imx7: add the cm4 reset for i.MX8MQ

Peter Ujfalusi (2):
      soc: ti: k3-socinfo: Add entry for J7200
      dmaengine: ti: k3-udma-glue: Fix parameters for rx ring pair request

Qilong Zhang (1):
      soc: qcom: llcc: use devm_platform_ioremap_resource_byname()

Qinglang Miao (3):
      memory: tegra: Convert to DEFINE_SHOW_ATTRIBUTE
      memory: emif: Convert to DEFINE_SHOW_ATTRIBUTE
      soc: ti: Convert to DEFINE_SHOW_ATTRIBUTE

Rikard Falkeborn (3):
      cpufreq: arm_scmi: Constify scmi_perf_ops pointers
      firmware: arm_scmi: Constify ops pointers in scmi_handle
      firmware: arm_scmi: Constify static scmi-ops

Sai Krishna Potthuri (2):
      dt-bindings: reset: Updated binding for Versal reset driver
      reset: reset-zynqmp: Added support for Versal platform

Sibi Sankar (1):
      soc: qcom: apr: Fixup the error displayed on lookup failure

Stephen Boyd (1):
      soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free

Sudeep Holla (7):
      firmware: arm_scmi: Fix NULL pointer dereference in mailbox_chan_free
      firmware: smccc: Export both smccc functions
      firmware: arm_scmi: Move scmi bus init and exit calls into the driver
      firmware: arm_scmi: Move scmi protocols registration into the driver
      firmware: arm_scmi: Enable building as a single module
      tee: replace cdev_add + device_add with cdev_device_add
      tee: avoid explicit sysfs_create/delete_group by initialising dev->groups

Suman Anna (6):
      soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
      soc: ti: pruss: Add support for PRU-ICSSs on AM437x SoCs
      soc: ti: pruss: Add support for PRU-ICSS subsystems on AM57xx SoCs
      soc: ti: pruss: Add support for PRU-ICSS subsystems on 66AK2G SoC
      soc: ti: pruss: Enable support for ICSSG subsystems on K3 AM65x SoCs
      soc: ti: pruss: Enable support for ICSSG subsystems on K3 J721E SoCs

Tero Kristo (2):
      soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one
      firmware: ti_sci: allow frequency change for disabled clocks by default

Thierry Reding (9):
      memory: tegra: Remove GPU from DRM IOMMU group
      soc/tegra: fuse: Extract tegra_get_platform()
      soc/tegra: fuse: Implement tegra_is_silicon()
      soc/tegra: fuse: Add Tegra234 support
      soc/tegra: misc: Add Tegra234 support
      soc/tegra: pmc: Reorder reset sources/levels definitions
      soc/tegra: pmc: Add Tegra234 support
      Merge branch 'for-5.10/soc' into for-5.10/firmware
      firmware: tegra: Enable BPMP support on Tegra234

Wang Hai (1):
      soc: fsl: qe: Remove unnessesary check in ucc_set_tdm_rxtx_clk

Ye Bin (1):
      memory: tegra: Delete duplicated argument to '|' in function tegra210_emc_r21021_periodic_compensation

Yoshihiro Shimoda (3):
      soc: renesas: Identify R-Car V3U
      soc: renesas: rcar-rst: Add support for R-Car V3U
      soc: renesas: r8a779a0-sysc: Add r8a779a0 support

YueHaibing (2):
      memory: omap-gpmc: Fix build error without CONFIG_OF
      memory: omap-gpmc: Fix -Wunused-function warnings

Álvaro Fernández Rojas (9):
      dt-bindings: soc: brcm: add BCM63xx power domain binding
      MIPS: BMIPS: add BCM6328 power domain definitions
      MIPS: BMIPS: add BCM6362 power domain definitions
      MIPS: BMIPS: add BCM63268 power domain definitions
      MIPS: BMIPS: add BCM6318 power domain definitions
      soc: bcm: add BCM63xx power domain driver
      MIPS: BMIPS: dts: add BCM6328 power domain support
      MIPS: BMIPS: dts: add BCM6362 power domain support
      MIPS: BMIPS: dts: add BCM63268 power domain support


 .../devicetree/bindings/bus/brcm,gisb-arb.txt   |   3 +-
 .../memory-controllers/mediatek,smi-common.txt  |   3 +-
 .../memory-controllers/mediatek,smi-larb.txt    |   3 +-
 .../bindings/power/amlogic,meson-ee-pwrc.yaml   |  23 +-
 .../bindings/power/brcm,bcm63xx-power.yaml      |  44 ++
 .../bindings/reset/xlnx,zynqmp-reset.txt        |  11 +-
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml  |   6 -
 .../devicetree/bindings/soc/ti/ti,pruss.yaml    | 439 ++++++++++++++++++
 MAINTAINERS                                     |   1 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi           |   6 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi            |   6 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi            |   6 +
 drivers/bus/brcmstb_gisb.c                      | 100 ++++-
 drivers/cpufreq/scmi-cpufreq.c                  |   6 +-
 drivers/dma/ti/k3-udma-glue.c                   |   2 +-
 drivers/firmware/Kconfig                        |   2 +-
 drivers/firmware/Makefile                       |   2 +-
 drivers/firmware/arm_scmi/Makefile              |   6 +-
 drivers/firmware/arm_scmi/bus.c                 |   6 +-
 drivers/firmware/arm_scmi/clock.c               |   9 +-
 drivers/firmware/arm_scmi/common.h              |  26 +-
 drivers/firmware/arm_scmi/driver.c              |  31 +-
 drivers/firmware/arm_scmi/mailbox.c             |   4 +-
 drivers/firmware/arm_scmi/notify.c              |   2 +-
 drivers/firmware/arm_scmi/perf.c                |   9 +-
 drivers/firmware/arm_scmi/power.c               |   9 +-
 drivers/firmware/arm_scmi/reset.c               |   9 +-
 drivers/firmware/arm_scmi/sensors.c             |   9 +-
 drivers/firmware/arm_scmi/smc.c                 |   2 +-
 drivers/firmware/arm_scmi/system.c              | 131 ++++++
 drivers/firmware/imx/scu-pd.c                   |   4 +
 drivers/firmware/smccc/smccc.c                  |   2 +
 drivers/firmware/tegra/bpmp.c                   |   3 +-
 drivers/firmware/ti_sci.c                       |   6 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c         |   2 +-
 drivers/mailbox/tegra-hsp.c                     |   9 +-
 drivers/memory/Kconfig                          |  52 ++-
 drivers/memory/Makefile                         |   2 +-
 drivers/memory/brcmstb_dpfe.c                   |  46 +-
 drivers/memory/emif.c                           |  55 +--
 drivers/memory/fsl-corenet-cf.c                 |   6 +-
 drivers/memory/mtk-smi.c                        |  23 +
 drivers/memory/omap-gpmc.c                      | 272 ++++++-----
 drivers/memory/renesas-rpc-if.c                 |   4 +-
 drivers/memory/samsung/exynos5422-dmc.c         | 108 +++--
 drivers/memory/tegra/tegra124-emc.c             |  14 +-
 drivers/memory/tegra/tegra124.c                 |   1 -
 drivers/memory/tegra/tegra186-emc.c             |  10 +-
 drivers/memory/tegra/tegra210-emc-cc-r21021.c   |   3 +-
 drivers/memory/tegra/tegra210.c                 |   2 +-
 drivers/reset/Kconfig                           |   5 +-
 drivers/reset/core.c                            |   3 +-
 drivers/reset/reset-imx7.c                      |  13 +-
 drivers/reset/reset-zynqmp.c                    |  50 ++-
 drivers/reset/sti/reset-syscfg.c                |   7 +-
 drivers/soc/amlogic/meson-ee-pwrc.c             |  30 +-
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c         |   4 +-
 drivers/soc/bcm/Kconfig                         |  10 +
 drivers/soc/bcm/Makefile                        |   1 +
 drivers/soc/bcm/bcm63xx/Kconfig                 |  12 +
 drivers/soc/bcm/bcm63xx/Makefile                |   2 +
 drivers/soc/bcm/bcm63xx/bcm63xx-power.c         | 378 ++++++++++++++++
 drivers/soc/bcm/brcmstb/biuctrl.c               | 105 ++++-
 drivers/soc/fsl/dpio/qbman-portal.c             |   2 -
 drivers/soc/fsl/qbman/bman.c                    |   2 +-
 drivers/soc/fsl/qbman/qman_test_api.c           |   2 +-
 drivers/soc/fsl/qe/ucc.c                        |   2 +-
 drivers/soc/imx/gpcv2.c                         |  15 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c          | 113 ++++-
 drivers/soc/mediatek/mtk-infracfg.c             |   4 +-
 drivers/soc/qcom/apr.c                          |   2 +-
 drivers/soc/qcom/llcc-qcom.c                    |   7 +-
 drivers/soc/qcom/rpmh-internal.h                |   4 +
 drivers/soc/qcom/rpmh-rsc.c                     | 115 +++--
 drivers/soc/qcom/socinfo.c                      |   5 +
 drivers/soc/renesas/Kconfig                     | 354 ++++++++-------
 drivers/soc/renesas/Makefile                    |   1 +
 drivers/soc/renesas/r8a779a0-sysc.c             | 448 +++++++++++++++++++
 drivers/soc/renesas/rcar-rst.c                  |   6 +
 drivers/soc/renesas/renesas-soc.c               |   8 +
 drivers/soc/sunxi/sunxi_sram.c                  |   2 +-
 drivers/soc/tegra/fuse/fuse-tegra.c             |   8 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c           |  30 ++
 drivers/soc/tegra/fuse/fuse.h                   |  10 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c          |  26 ++
 drivers/soc/tegra/pmc.c                         | 146 ++++--
 drivers/soc/ti/Kconfig                          |  11 +
 drivers/soc/ti/Makefile                         |   1 +
 drivers/soc/ti/k3-ringacc.c                     |  33 +-
 drivers/soc/ti/k3-socinfo.c                     |   1 +
 drivers/soc/ti/knav_dma.c                       |  16 +-
 drivers/soc/ti/knav_qmss_queue.c                |  14 +-
 drivers/soc/ti/pruss.c                          | 354 +++++++++++++++
 drivers/soc/ti/ti_sci_pm_domains.c              | 251 +++++------
 drivers/tee/optee/core.c                        |   7 +
 drivers/tee/optee/optee_msg.h                   |  21 +
 drivers/tee/optee/optee_private.h               |   1 +
 drivers/tee/optee/optee_smc.h                   |   3 +
 drivers/tee/optee/rpc.c                         |  95 ++++
 drivers/tee/tee_core.c                          |  89 ++--
 drivers/tee/tee_shm.c                           |  32 +-
 include/dt-bindings/power/meson-axg-power.h     |  14 +
 include/dt-bindings/reset/imx8mq-reset.h        |   5 +-
 include/dt-bindings/reset/xlnx-versal-resets.h  | 105 +++++
 include/dt-bindings/soc/bcm6318-pm.h            |  17 +
 include/dt-bindings/soc/bcm63268-pm.h           |  21 +
 include/dt-bindings/soc/bcm6328-pm.h            |  17 +
 include/dt-bindings/soc/bcm6362-pm.h            |  21 +
 include/linux/mailbox/mtk-cmdq-mailbox.h        |   6 +-
 include/linux/pruss_driver.h                    |  54 +++
 include/linux/qcom-geni-se.h                    |   4 +-
 include/linux/scmi_protocol.h                   |  32 +-
 include/linux/soc/mediatek/mtk-cmdq.h           |  93 +++-
 include/linux/tee_drv.h                         |   3 +
 include/soc/fsl/qman.h                          |   4 +-
 include/soc/tegra/fuse.h                        |   3 +
 include/uapi/linux/tee.h                        |  13 +
 117 files changed, 3901 insertions(+), 912 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm63xx-power.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
 create mode 100644 drivers/firmware/arm_scmi/system.c
 create mode 100644 drivers/soc/bcm/bcm63xx/Kconfig
 create mode 100644 drivers/soc/bcm/bcm63xx/Makefile
 create mode 100644 drivers/soc/bcm/bcm63xx/bcm63xx-power.c
 create mode 100644 drivers/soc/renesas/r8a779a0-sysc.c
 create mode 100644 drivers/soc/ti/pruss.c
 create mode 100644 include/dt-bindings/power/meson-axg-power.h
 create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h
 create mode 100644 include/dt-bindings/soc/bcm6318-pm.h
 create mode 100644 include/dt-bindings/soc/bcm63268-pm.h
 create mode 100644 include/dt-bindings/soc/bcm6328-pm.h
 create mode 100644 include/dt-bindings/soc/bcm6362-pm.h
 create mode 100644 include/linux/pruss_driver.h
