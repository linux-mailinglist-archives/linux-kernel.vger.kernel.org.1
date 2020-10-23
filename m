Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE129794F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757145AbgJWWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757088AbgJWWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:31:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4924C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh6so1769226plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CMIidr17bY0nuvq5mFiI1YLtV0+bHS4EFgxKb7QBvs=;
        b=P856L+IqL/JYG6D19nomFyXLSn9yz/wQuapYfDyC3ju2N4NqBRbKy4/lEPRIBQ1nID
         rFlOmd0BQXXw9cIC3wIzhDoyGy5ZXyIhbN2nmj2sgl0Xce984JOBMX/8TyKK+HJg8rGN
         cducR6VuAVwdLnKBD9B+lRuAP4sMfqQ1XfsGWPz9MQCBRMP06lxarXxa9LXdTPWmLwrp
         eAwLO2E0bF4mAAmBfoM/iBqJDK8/LLQxP+M5VO8P5u1Jnp6djpoGorJgSKor3+8Qyk0+
         n668oTEQVfgq6GYU9ImNBn4yp48HG4IVFHBEK6YSsiQV6Xj99BjMJAzBwcg5lU3ecZ5E
         gBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CMIidr17bY0nuvq5mFiI1YLtV0+bHS4EFgxKb7QBvs=;
        b=sSj2I80C9Cq9q9FudgJlWq9pq4NowoPOlcwenNpYHLFEKB2nXExhnrZM8RF9efLYv7
         V7+jA3osGUSOjFn9k4b2ZxCHyQRmXTC9HrjAT97xyFMdLdxSXuUnTco9cWBRXSMtS1XL
         0DapfH53+wv10oeBXK6e0q1C1tPznkZLXkG1wPOopyawMywZT8wTeCiR0ZADQp2GbInA
         q6MRihBbr30PNkgoM0U6xDJV1iKFcKrfNXmmQQB36nLt8xHCkhiTqueyUyyportRxFYV
         MaHjiH3KDRU3jYQxFUM7AU+HWEKholetQ3/G6KqieDLlWkhOZ5SwWqkah2qc8ZuIYHxN
         +BoQ==
X-Gm-Message-State: AOAM533ValRwPF1qlAQZIdadm1hatQIjEb6fZtO8QjHeY824AIgILpOy
        09WUqUd91UhS/a5yiK/G6zAN5w==
X-Google-Smtp-Source: ABdhPJxWKqf8VcUixdDg6UhyQ0fU9SJ5yPAMcD1cE5xy/yhRAQUtXtP/CN6K4zdp2L04QAMyexb5cg==
X-Received: by 2002:a17:902:ee0b:b029:d3:c8dc:6db8 with SMTP id z11-20020a170902ee0bb02900d3c8dc6db8mr1109925plb.55.1603492308641;
        Fri, 23 Oct 2020 15:31:48 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o15sm3406457pfp.91.2020.10.23.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:31:46 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/5] ARM: SoC platform updates
Date:   Fri, 23 Oct 2020 15:31:19 -0700
Message-Id: <20201023223122.19189-3-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201023223122.19189-1-olof@lixom.net>
References: <20201023223122.19189-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC changes, a substantial part of this is cleanup of some of the older
platforms that used to have a bunch of board files. In particular:

- Removal of non-DT i.MX platforms that haven't seen activity in years,
it's time to remove them.
- A bunch of cleanup and removal of platform data for TI/OMAP platforms,
moving over to genpd for power/reset control (yay!)
- Major cleanup of Samsung S3C24xx and S3C64xx platforms, moving them
closer to multiplatform support (not quite there yet, but getting
close).

THere are a few other changes too, smaller fixlets, etc. For new
platform support, the primary ones re:

- New SoC: Hisilicon SD5203, ARM926EJ-S platform.
- Cpufreq support for i.MX7ULP



Conflicts:

drivers/mmc/host/Kconfig:
Change/change:
 - Keep MMC_SDHCI on separate line
 - Keep the rest of the longer depends



----------------------------------------------------------------

The following changes since commit cb44fcfbceae86aaad2dd509026ceede1efb6dea:

  Merge branch 'arm/fixes' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

for you to fetch changes up to accdab6d9e8f715068d91ee0ca0424a6999f0d19:

  Merge tag 'imx-soc-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/soc

----------------------------------------------------------------

Alexander A. Klimov (6):
      ARM: OMAP2+: PRM: Replace HTTP links with HTTPS ones
      ARM: OMAP2+: Replace HTTP links with HTTPS ones
      ARM: OMAP2+: hwmod: Replace HTTP links with HTTPS ones
      ARM: OMAP2+: pm33xx-core: Replace HTTP links with HTTPS ones
      ARM: OMAP2+: Replace HTTP links with HTTPS ones
      ARM: stm32: Replace HTTP links with HTTPS ones

Alexandre Belloni (1):
      ARM: at91: pm: remove unnecessary at91sam9x60_idle

Andreas Kemnade (1):
      ARM: omap3: enable off mode automatically

Arnd Bergmann (33):
      ARM: s3c24xx: fix mmc gpio lookup tables
      ARM: s3c24xx: iotiming: make functions static
      ARM: s3c24xx: make S3C24XX_MISCCR access indirect
      ARM: s3c24xx: simplify mach/io.h
      usb: gadget: s3c: use platform resources
      usb: gadget: s3c-hsudc: remove platform header dependency
      ARM: samsung: don't build plat/pm-common for Exynos
      ARM: samsung: remove s3c_pm_debug_init()
      ARM: samsung: make pm-debug platform independent
      ARM: samsung: move CONFIG_DEBUG_S3C_UART to Kconfig.debug
      ARM: exynos: use private samsung_cpu_id copy
      ARM: exynos: stop selecting PLAT_SAMSUNG
      ARM: samsung: move pm check code to drivers/soc
      ARM: s5pv210: use private pm save/restore
      ARM: s5pv210: don't imply CONFIG_PLAT_SAMSUNG
      ARM: s3c64xx: remove mach/hardware.h
      ARM: s3c24xx: move regs-spi.h into spi driver
      ARM: s3c24xx: move irqchip driver back into platform
      ARM: s3c: adc: move header to linux/soc/samsung
      ARM: s3c24xx: move spi fiq handler into platform
      ARM: s3c24xx: move iis pinctrl config into boards
      ARM: s3c24xx: move s3cmci pinctrl handling into board files
      ARM: s3c24xx: include mach/irqs.h where needed
      ARM: s3c24xx: spi: avoid hardcoding fiq number in driver
      ARM: s3c24xx: bast: avoid irq_desc array usage
      fbdev: s3c2410fb: remove mach header dependency
      cpufreq: s3c24xx: split out registers
      ARM: s3c: remove cpufreq header dependencies
      cpufreq: s3c2412: use global s3c2412_cpufreq_setrefresh
      cpufreq: s3c24xx: move low-level clk reg access into platform code
      ARM: s3c24xx: stop including mach/hardware.h from mach/io.h
      ARM: s3c: move into a common directory
      ARM: s3c: make headers local if possible

Christian Lamparter (1):
      MAINTAINERS: extend BCM5301X ARM ARCHITECTURE files

Claudiu Beznea (3):
      ARM: at91: pm: add support for ULP0 fast wakeup
      ARM: at91: pm: add per soc validation of pm modes
      ARM: at91: pm: of_node_put() after its usage

Daniel Palmer (1):
      ARM: mstar: Select MStar intc

Fabio Estevam (25):
      ARM: imx: Place "Cortex-A/Cortex-M" comment in the correct location
      ARM: imx: Remove imx21 support
      ARM: imx: Remove i.MX27 board files
      ARM: imx: Remove i.MX31 board files
      ARM: imx: Remove i.MX35 board files
      ARM: imx: Remove ehci board files
      ARM: imx27: Remove imx27_soc_init()
      ARM: imx27: Remove iomux-v1 board code
      ARM: imx27: Get rid of mm-imx27.c
      ARM: imx27: Retrieve AVIC base address from devicetree
      ARM: imx31: Remove remaining i.MX31 board code
      ARM: imx3: Remove imx3 soc_init()
      ARM: imx: Remove iomux-v3 board code
      ARM: imx: Remove imx device directory
      ARM: imx: Remove remnant board file support pieces
      ARM: imx27: Retrieve the SYSCTRL base address from devicetree
      ARM: imx27: Retrieve the CCM base address from devicetree
      ARM: imx31: Retrieve the IIM base address from devicetree
      ARM: imx3: Retrieve the CCM base address from devicetree
      ARM: imx3: Retrieve the AVIC base address from devicetree
      ARM: imx35: Retrieve the IIM base address from devicetree
      ARM: imx: Remove unused definitions
      clk: imx: imx27: Remove mx27_clocks_init()
      clk: imx: imx31: Remove mx31_clocks_init()
      clk: imx: imx35: Remove mx35_clocks_init()

Florian Fainelli (3):
      ARM: brcmstb: Add debug UART entry for 72614
      ARM: bcm: Enable BCM7038_L1_IRQ for ARCH_BRCMSTB
      ARM: brcmstb: Add debug UART entry for 72615

Geert Uytterhoeven (1):
      ARM: shmobile: rcar-gen2: Make rcar_gen2_{timer_init, reserve}() static

Guillaume Tucker (1):
      ARM: exynos: clear L310_AUX_CTRL_NS_LOCKDOWN in default l2c_aux_val

Kefeng Wang (2):
      ARM: hisi: add support for SD5203 SoC
      ARM: debug: add UART early console support for SD5203

Krzysztof Kozlowski (27):
      MAINTAINERS: drop Vincent Sanders from Simtec S3C boards
      MAINTAINERS: add more name matches for Samsung SoC entries
      ARM: s3c64xx: include header to fix -Wmissing-prototypes
      ARM: s3c24xx: demote kerneldoc comment
      ARM: samsung: fix language typo
      clk: samsung: s3c64xx: declare s3c64xx_clk_init() in shared header
      clk: samsung: s3c24xx: declare s3c24xx_common_clk_init() in shared header
      ARM: s3c: remove plat-samsung/.../samsung-time.h
      ARM: s3c24xx: include common.h header in s3c2443.c
      ARM: s3c24xx: sdhci: include plat/sdhci.h header
      ARM: s3c24xx: ts: include platform data header
      ARM: s3c24xx: ts: document function argument
      ARM: s3c: remove unneeded machine header includes
      mmc: s3cmci: remove unneeded machine header include
      ARM: samsung: fix kerneldoc of s3c_pm_do_restore_core()
      ARM: s3c24xx: drop s3c-camif setup platform code
      ARM: samsung: remove HAVE_S3C2410_WATCHDOG and use direct dependencies
      ARM: s3c64xx: switch to generic watchdog driver reset
      ARM: s3c24xx: fix missing system reset
      ARM: s3c24xx: pass pointer to clk driver via platform data
      usb: gadget: s3c: remove unused 'udc' variable
      Merge tag 'samsung-platdrv-boards' of https://git.kernel.org/.../broonie/sound into next/soc-s3c-cleanup
      ARM: s3c: Cleanup from old plat-samsung include
      ARM: s3c: Avoid naming clash of S3C24xx and S3C64xx timer setup
      ARM: samsung: fix PM debug build with DEBUG_LL but !MMU
      ARM: s3c24xx: fix Wunused-variable warning on !MMU
      ARM: s3c64xx: bring back notes from removed debug-macro.S

Linus Walleij (1):
      ARM: versatile: Remove Integrator and Realview from PHYS_OFFSET

Lukas Bulwahn (1):
      MAINTAINERS: mark linux-samsung-soc list non-moderated

Olof Johansson (13):
      Merge tag 'samsung-soc-s3c-5.10' of https://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'versatile-soc-v5.10-1' of git://git.kernel.org/.../linusw/linux-integrator into arm/soc
      Merge tag 'omap-for-v5.10/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'omap-for-v5.10/ti-sysc-drop-pdata-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'arm-soc/for-5.10/maintainers' of https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'arm-soc/for-5.10/soc' of https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'at91-soc-5.10' of git://git.kernel.org/.../at91/linux into arm/soc
      Merge tag 'renesas-arm-soc-for-v5.10-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/soc
      Merge tag 'samsung-soc-5.10' of https://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'davinci-for-v5.10/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into arm/soc
      Merge tag 'omap-for-v5.10/soc-part2-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'hisi-arm-soc-for-5.10' of git://github.com/hisilicon/linux-hisi into arm/soc
      Merge tag 'imx-soc-5.10' of git://git.kernel.org/.../shawnguo/linux into arm/soc

Peng Fan (1):
      ARM: imx7ulp: enable cpufreq

Qinglang Miao (1):
      ARM: s3c64xx: fix return value check in s3c_usb_otgphy_init()

Randy Dunlap (1):
      arm: mach-omap1: mux.h: delete duplicate word

Stephen Kitt (2):
      ARM: s3c64xx: use simple i2c probe function
      ARM: davinci: use simple i2c probe function

Tony Lindgren (11):
      dt-bindings: omap: Update PRM binding for genpd
      soc: ti: omap-prm: Add basic power domain support
      soc: ti: omap-prm: Configure sgx power domain for am3 and am4
      soc: ti: omap-prm: Configure omap4 and 5 l4_abe power domain
      ARM: dts: Configure am3 and am4 sgx for genpd and drop platform data
      ARM: dts: Configure omap4 and 5 l4_abe for genpd and drop platform data
      soc: ti: pm33xx: Simplify RTC usage to prepare to drop platform data
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 rtc
      ARM: OMAP2+: Drop legacy platform data for dra7 rtcss
      Merge branch 'omap-for-v5.10/omap1' into omap-for-v5.10/soc
      Merge branch 'omap-for-v5.10/prm-genpd' into omap-for-v5.10/ti-sysc-drop-pdata

YueHaibing (1):
      soc: integrator: Drop pointless static qualifier in integrator_soc_init()


 .../devicetree/bindings/arm/omap/prm-inst.txt   |    2 +
 MAINTAINERS                                     |   40 +-
 arch/arm/Kconfig                                |   12 +-
 arch/arm/Kconfig.debug                          |   29 +-
 arch/arm/Makefile                               |    7 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                |    1 -
 arch/arm/boot/dts/am33xx.dtsi                   |    2 +
 arch/arm/boot/dts/am4372.dtsi                   |    2 +
 arch/arm/boot/dts/am437x-l4.dtsi                |    3 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |    4 +
 arch/arm/boot/dts/dra7-l4.dtsi                  |    1 -
 arch/arm/boot/dts/omap4-l4-abe.dtsi             |    6 +-
 arch/arm/boot/dts/omap4.dtsi                    |    6 +
 arch/arm/boot/dts/omap5-l4-abe.dtsi             |    6 +-
 arch/arm/boot/dts/omap5.dtsi                    |    6 +
 arch/arm/configs/imx_v4_v5_defconfig            |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig            |   16 +-
 arch/arm/configs/multi_v5_defconfig             |    2 +-
 arch/arm/include/debug/brcmstb.S                |   26 +-
 arch/arm/mach-at91/pm.c                         |   97 +-
 arch/arm/mach-at91/pm.h                         |    5 +-
 arch/arm/mach-at91/pm_suspend.S                 |   41 +-
 arch/arm/mach-bcm/Kconfig                       |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c        |    5 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        |   10 +-
 arch/arm/mach-exynos/Kconfig                    |    1 -
 arch/arm/mach-exynos/Makefile                   |    4 -
 arch/arm/mach-exynos/common.h                   |    6 +-
 arch/arm/mach-exynos/exynos.c                   |   25 +-
 arch/arm/mach-exynos/include/mach/map.h         |   18 -
 arch/arm/mach-exynos/platsmp.c                  |    4 +-
 arch/arm/mach-exynos/pm.c                       |    8 +-
 arch/arm/mach-hisi/Kconfig                      |   16 +-
 arch/arm/mach-imx/3ds_debugboard.c              |  207 ---
 arch/arm/mach-imx/3ds_debugboard.h              |   11 -
 arch/arm/mach-imx/Kconfig                       |  375 +-----
 arch/arm/mach-imx/Makefile                      |   45 +-
 arch/arm/mach-imx/board-mx31lilly.h             |   28 -
 arch/arm/mach-imx/board-mx31lite.h              |   29 -
 arch/arm/mach-imx/board-mx31moboard.h           |   30 -
 arch/arm/mach-imx/common.h                      |   15 -
 arch/arm/mach-imx/cpu-imx27.c                   |   10 +-
 arch/arm/mach-imx/cpu-imx31.c                   |    9 +-
 arch/arm/mach-imx/cpu-imx35.c                   |    9 +-
 arch/arm/mach-imx/devices-imx21.h               |   56 -
 arch/arm/mach-imx/devices-imx27.h               |   86 --
 arch/arm/mach-imx/devices-imx31.h               |   80 --
 arch/arm/mach-imx/devices-imx35.h               |   87 --
 arch/arm/mach-imx/devices/Kconfig               |   71 -
 arch/arm/mach-imx/devices/Makefile              |   28 -
 arch/arm/mach-imx/devices/devices-common.h      |  293 ----
 arch/arm/mach-imx/devices/devices.c             |   35 -
 arch/arm/mach-imx/devices/platform-fec.c        |   49 -
 arch/arm/mach-imx/devices/platform-flexcan.c    |   45 -
 .../mach-imx/devices/platform-fsl-usb2-udc.c    |   51 -
 arch/arm/mach-imx/devices/platform-gpio-mxc.c   |   31 -
 arch/arm/mach-imx/devices/platform-gpio_keys.c  |   15 -
 arch/arm/mach-imx/devices/platform-imx-dma.c    |   44 -
 arch/arm/mach-imx/devices/platform-imx-fb.c     |   47 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c    |   74 --
 arch/arm/mach-imx/devices/platform-imx-keypad.c |   54 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c    |   86 --
 arch/arm/mach-imx/devices/platform-imx-uart.c   |   92 --
 arch/arm/mach-imx/devices/platform-imx2-wdt.c   |   52 -
 arch/arm/mach-imx/devices/platform-imx21-hcd.c  |   38 -
 arch/arm/mach-imx/devices/platform-imx27-coda.c |   34 -
 arch/arm/mach-imx/devices/platform-ipu-core.c   |  127 --
 arch/arm/mach-imx/devices/platform-mx2-camera.c |   59 -
 arch/arm/mach-imx/devices/platform-mx2-emma.c   |   37 -
 arch/arm/mach-imx/devices/platform-mxc-ehci.c   |   61 -
 arch/arm/mach-imx/devices/platform-mxc-mmc.c    |   72 -
 arch/arm/mach-imx/devices/platform-mxc_nand.c   |   72 -
 arch/arm/mach-imx/devices/platform-mxc_rtc.c    |   43 -
 arch/arm/mach-imx/devices/platform-mxc_w1.c     |   47 -
 arch/arm/mach-imx/devices/platform-pata_imx.c   |   45 -
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c |   64 -
 arch/arm/mach-imx/devices/platform-spi_imx.c    |   78 --
 arch/arm/mach-imx/ehci-imx27.c                  |   74 --
 arch/arm/mach-imx/ehci-imx31.c                  |   74 --
 arch/arm/mach-imx/ehci-imx35.c                  |   89 --
 arch/arm/mach-imx/ehci.h                        |   44 -
 arch/arm/mach-imx/hardware.h                    |    1 -
 arch/arm/mach-imx/imx27-dt.c                    |   26 -
 arch/arm/mach-imx/iomux-imx31.c                 |  161 ---
 arch/arm/mach-imx/iomux-mx21.h                  |  109 --
 arch/arm/mach-imx/iomux-mx27.h                  |  192 ---
 arch/arm/mach-imx/iomux-mx2x.h                  |  217 ---
 arch/arm/mach-imx/iomux-mx3.h                   |  706 ----------
 arch/arm/mach-imx/iomux-mx35.h                  | 1254 ------------------
 arch/arm/mach-imx/iomux-v1.c                    |  174 ---
 arch/arm/mach-imx/iomux-v1.h                    |   81 --
 arch/arm/mach-imx/iomux-v3.c                    |   65 -
 arch/arm/mach-imx/iomux-v3.h                    |  130 --
 arch/arm/mach-imx/mach-armadillo5x0.c           |  562 --------
 arch/arm/mach-imx/mach-bug.c                    |   54 -
 arch/arm/mach-imx/mach-imx27.c                  |   81 ++
 arch/arm/mach-imx/{imx31-dt.c => mach-imx31.c}  |    0
 arch/arm/mach-imx/{imx35-dt.c => mach-imx35.c}  |    0
 arch/arm/mach-imx/mach-imx7ulp.c                |    3 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c           |  291 ----
 arch/arm/mach-imx/mach-mx21ads.c                |  338 -----
 arch/arm/mach-imx/mach-mx27_3ds.c               |  470 -------
 arch/arm/mach-imx/mach-mx27ads.c                |  407 ------
 arch/arm/mach-imx/mach-mx31_3ds.c               |  615 ---------
 arch/arm/mach-imx/mach-mx31ads.c                |  579 --------
 arch/arm/mach-imx/mach-mx31lilly.c              |  312 -----
 arch/arm/mach-imx/mach-mx31lite.c               |  290 ----
 arch/arm/mach-imx/mach-mx35_3ds.c               |  516 -------
 arch/arm/mach-imx/mach-pca100.c                 |  426 ------
 arch/arm/mach-imx/mach-pcm037.c                 |  585 --------
 arch/arm/mach-imx/mach-pcm037_eet.c             |  166 ---
 arch/arm/mach-imx/mach-pcm043.c                 |  412 ------
 arch/arm/mach-imx/mach-qong.c                   |  262 ----
 arch/arm/mach-imx/mach-vpr200.c                 |  306 -----
 arch/arm/mach-imx/mm-imx21.c                    |   84 --
 arch/arm/mach-imx/mm-imx27.c                    |   88 --
 arch/arm/mach-imx/mm-imx3.c                     |  185 +--
 arch/arm/mach-imx/mx21.h                        |  176 ---
 arch/arm/mach-imx/mx27.h                        |  196 ---
 arch/arm/mach-imx/mx31.h                        |  179 ---
 arch/arm/mach-imx/mx31lilly-db.c                |  182 ---
 arch/arm/mach-imx/mx31lite-db.c                 |  154 ---
 arch/arm/mach-imx/mx31moboard-devboard.c        |  238 ----
 arch/arm/mach-imx/mx31moboard-marxbot.c         |  270 ----
 arch/arm/mach-imx/mx31moboard-smartbot.c        |  124 --
 arch/arm/mach-imx/mx35.h                        |  173 ---
 arch/arm/mach-imx/pcm037.h                      |   18 -
 arch/arm/mach-imx/pm-imx27.c                    |   12 +-
 arch/arm/mach-imx/ulpi.h                        |   20 -
 arch/arm/mach-mstar/Kconfig                     |    1 +
 arch/arm/mach-omap1/include/mach/mux.h          |    2 +-
 arch/arm/mach-omap2/Kconfig                     |    1 +
 arch/arm/mach-omap2/am33xx.h                    |    2 +-
 arch/arm/mach-omap2/board-generic.c             |    2 +-
 arch/arm/mach-omap2/clockdomains33xx_data.c     |    2 +-
 arch/arm/mach-omap2/clockdomains81xx_data.c     |    2 +-
 arch/arm/mach-omap2/cm-regbits-33xx.h           |    2 +-
 arch/arm/mach-omap2/cm-regbits-54xx.h           |    2 +-
 arch/arm/mach-omap2/cm-regbits-7xx.h            |    2 +-
 arch/arm/mach-omap2/cm1_54xx.h                  |    2 +-
 arch/arm/mach-omap2/cm1_7xx.h                   |    2 +-
 arch/arm/mach-omap2/cm2_54xx.h                  |    2 +-
 arch/arm/mach-omap2/cm2_7xx.h                   |    2 +-
 arch/arm/mach-omap2/cm33xx.c                    |    2 +-
 arch/arm/mach-omap2/cm33xx.h                    |    2 +-
 arch/arm/mach-omap2/cm81xx.h                    |    2 +-
 arch/arm/mach-omap2/display.c                   |    2 +-
 arch/arm/mach-omap2/dma.c                       |    2 +-
 arch/arm/mach-omap2/l3_2xxx.h                   |    2 +-
 arch/arm/mach-omap2/l3_3xxx.h                   |    2 +-
 arch/arm/mach-omap2/l4_2xxx.h                   |    2 +-
 arch/arm/mach-omap2/omap-iommu.c                |    2 +-
 .../omap_hwmod_33xx_43xx_common_data.h          |    2 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c    |   24 -
 .../omap_hwmod_33xx_43xx_ipblock_data.c         |   77 --
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c      |    5 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |   10 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |   33 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c      |   33 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |   46 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      |    2 +-
 arch/arm/mach-omap2/omap_opp_data.h             |    2 +-
 arch/arm/mach-omap2/omap_phy_internal.c         |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c              |    2 +-
 arch/arm/mach-omap2/opp4xxx_data.c              |    2 +-
 arch/arm/mach-omap2/pm-debug.c                  |    2 -
 arch/arm/mach-omap2/pm.c                        |    2 +
 arch/arm/mach-omap2/pm.h                        |    4 -
 arch/arm/mach-omap2/pm33xx-core.c               |   27 +-
 arch/arm/mach-omap2/pm34xx.c                    |   26 +-
 arch/arm/mach-omap2/powerdomains33xx_data.c     |    2 +-
 arch/arm/mach-omap2/prcm43xx.h                  |    2 +-
 arch/arm/mach-omap2/prcm_mpu54xx.h              |    2 +-
 arch/arm/mach-omap2/prcm_mpu7xx.h               |    2 +-
 arch/arm/mach-omap2/prm-regbits-33xx.h          |    2 +-
 arch/arm/mach-omap2/prm33xx.c                   |    2 +-
 arch/arm/mach-omap2/prm33xx.h                   |    2 +-
 arch/arm/mach-omap2/prm54xx.h                   |    2 +-
 arch/arm/mach-omap2/prm7xx.h                    |    2 +-
 arch/arm/mach-omap2/scrm54xx.h                  |    2 +-
 arch/arm/mach-omap2/sleep33xx.S                 |    2 +-
 arch/arm/mach-omap2/sleep43xx.S                 |    2 +-
 arch/arm/mach-omap2/ti81xx.h                    |    2 +-
 arch/arm/mach-omap2/voltagedomains54xx_data.c   |    2 +-
 arch/arm/{plat-samsung => mach-s3c}/Kconfig     |   72 +-
 .../Kconfig => mach-s3c/Kconfig.s3c24xx}        |   13 -
 .../Kconfig => mach-s3c/Kconfig.s3c64xx}        |    5 +-
 arch/arm/{plat-samsung => mach-s3c}/Makefile    |   16 +-
 .../{mach-s3c24xx => mach-s3c}/Makefile.boot    |    0
 .../Makefile => mach-s3c/Makefile.s3c24xx}      |   22 +-
 .../Makefile => mach-s3c/Makefile.s3c64xx}      |   36 +-
 .../include/plat => mach-s3c}/adc-core.h        |    0
 arch/arm/{plat-samsung => mach-s3c}/adc.c       |    4 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/anubis.h    |    0
 .../ata-core.h => mach-s3c/ata-core-s3c64xx.h}  |    6 +-
 .../backlight-s3c64xx.h}                        |    6 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/bast-ide.c  |    3 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/bast-irq.c  |    8 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/bast.h      |    0
 .../common-smdk-s3c24xx.c}                      |   13 +-
 .../common-smdk-s3c24xx.h}                      |    0
 arch/arm/{plat-samsung => mach-s3c}/cpu.c       |   21 +-
 .../include/plat => mach-s3c}/cpu.h             |   12 -
 .../cpufreq-utils-s3c24xx.c}                    |   40 +-
 .../cpuidle.c => mach-s3c/cpuidle-s3c64xx.c}    |    8 +-
 arch/arm/{mach-s3c64xx => mach-s3c}/crag6410.h  |    2 +-
 .../dev-audio-s3c64xx.c}                        |    9 +-
 .../dev-backlight-s3c64xx.c}                    |    6 +-
 .../dev-uart.c => mach-s3c/dev-uart-s3c64xx.c}  |    5 +-
 arch/arm/{plat-samsung => mach-s3c}/dev-uart.c  |    2 +-
 arch/arm/{plat-samsung => mach-s3c}/devs.c      |   57 +-
 .../include/plat => mach-s3c}/devs.h            |    0
 .../mach/dma.h => mach-s3c/dma-s3c24xx.h}       |    0
 .../mach/dma.h => mach-s3c/dma-s3c64xx.h}       |    0
 arch/arm/mach-s3c/dma.h                         |    9 +
 .../fb-core.h => mach-s3c/fb-core-s3c24xx.h}    |    6 +-
 .../include/plat => mach-s3c}/fb.h              |    0
 .../plat => mach-s3c}/gpio-cfg-helpers.h        |    0
 .../include/plat => mach-s3c}/gpio-cfg.h        |    0
 .../include/plat => mach-s3c}/gpio-core.h       |    2 +-
 .../gpio-samsung-s3c24xx.h}                     |    2 +
 .../gpio-samsung-s3c64xx.h}                     |    0
 .../{plat-samsung => mach-s3c}/gpio-samsung.c   |   18 +-
 arch/arm/mach-s3c/gpio-samsung.h                |    9 +
 arch/arm/{mach-s3c24xx => mach-s3c}/gta02.h     |    2 +-
 .../h1940-bluetooth.c                           |    7 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/h1940.h     |    0
 .../hardware.h => mach-s3c/hardware-s3c24xx.h}  |   13 +-
 .../include/plat => mach-s3c}/iic-core.h        |    0
 arch/arm/mach-s3c/include/mach/io-s3c24xx.h     |   50 +
 arch/arm/mach-s3c/include/mach/io.h             |    8 +
 .../include/mach/irqs-s3c24xx.h}                |    0
 .../include/mach/irqs-s3c64xx.h}                |    0
 arch/arm/mach-s3c/include/mach/irqs.h           |    9 +
 .../plat => mach-s3c/include/mach}/map-base.h   |    0
 arch/arm/{plat-samsung => mach-s3c}/init.c      |    4 +-
 .../iotiming-s3c2410.c                          |   14 +-
 .../iotiming-s3c2412.c                          |    6 +-
 .../irq-pm.c => mach-s3c/irq-pm-s3c24xx.c}      |   16 +-
 .../irq-pm.c => mach-s3c/irq-pm-s3c64xx.c}      |    8 +-
 arch/arm/mach-s3c/irq-s3c24xx-fiq-exports.c     |    9 +
 .../arm/mach-s3c/irq-s3c24xx-fiq.S              |   10 +-
 .../irqchip => arch/arm/mach-s3c}/irq-s3c24xx.c |   23 +-
 .../irq-uart.h => mach-s3c/irq-uart-s3c64xx.h}  |    0
 .../include/plat => mach-s3c}/keypad.h          |    0
 .../{mach-s3c24xx => mach-s3c}/mach-amlm5900.c  |   41 +-
 .../{mach-s3c24xx => mach-s3c}/mach-anubis.c    |   17 +-
 .../{mach-s3c64xx => mach-s3c}/mach-anw6410.c   |   23 +-
 .../{mach-s3c24xx => mach-s3c}/mach-at2440evb.c |   31 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/mach-bast.c |   25 +-
 .../mach-crag6410-module.c                      |    7 +-
 .../{mach-s3c64xx => mach-s3c}/mach-crag6410.c  |   37 +-
 .../arm/{mach-s3c24xx => mach-s3c}/mach-gta02.c |   43 +-
 .../arm/{mach-s3c24xx => mach-s3c}/mach-h1940.c |   55 +-
 arch/arm/{mach-s3c64xx => mach-s3c}/mach-hmt.c  |   19 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/mach-jive.c |   30 +-
 .../{mach-s3c24xx => mach-s3c}/mach-mini2440.c  |   45 +-
 .../{mach-s3c64xx => mach-s3c}/mach-mini6410.c  |   30 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/mach-n30.c  |   39 +-
 arch/arm/{mach-s3c64xx => mach-s3c}/mach-ncp.c  |   17 +-
 .../{mach-s3c24xx => mach-s3c}/mach-nexcoder.c  |   23 +-
 .../mach-osiris-dvs.c                           |    4 +-
 .../{mach-s3c24xx => mach-s3c}/mach-osiris.c    |   27 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/mach-otom.c |   19 +-
 .../{mach-s3c24xx => mach-s3c}/mach-qt2410.c    |   41 +-
 .../{mach-s3c64xx => mach-s3c}/mach-real6410.c  |   26 +-
 .../{mach-s3c24xx => mach-s3c}/mach-rx1950.c    |   44 +-
 .../{mach-s3c24xx => mach-s3c}/mach-rx3715.c    |   29 +-
 .../mach-s3c2416-dt.c                           |    8 +-
 .../mach-s3c64xx-dt.c                           |   23 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smartq.c    |   21 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smartq.h    |    0
 .../{mach-s3c64xx => mach-s3c}/mach-smartq5.c   |   20 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smartq7.c   |   20 +-
 .../{mach-s3c24xx => mach-s3c}/mach-smdk2410.c  |   19 +-
 .../{mach-s3c24xx => mach-s3c}/mach-smdk2413.c  |   30 +-
 .../{mach-s3c24xx => mach-s3c}/mach-smdk2416.c  |   28 +-
 .../{mach-s3c24xx => mach-s3c}/mach-smdk2440.c  |   30 +-
 .../{mach-s3c24xx => mach-s3c}/mach-smdk2443.c  |   19 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smdk6400.c  |   17 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smdk6410.c  |   35 +-
 .../mach-tct_hammer.c                           |   27 +-
 .../{mach-s3c24xx => mach-s3c}/mach-vr1000.c    |   18 +-
 .../arm/{mach-s3c24xx => mach-s3c}/mach-vstms.c |   23 +-
 .../include/plat => mach-s3c}/map-s3c.h         |   12 +-
 .../mach/map.h => mach-s3c/map-s3c24xx.h}       |    6 +-
 .../mach/map.h => mach-s3c/map-s3c64xx.h}       |    4 +-
 .../include/plat => mach-s3c}/map-s5p.h         |    4 +-
 arch/arm/mach-s3c/map.h                         |    9 +
 .../nand-core-s3c24xx.h}                        |    6 +-
 .../onenand-core-s3c64xx.h}                     |    6 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/osiris.h    |    0
 arch/arm/{mach-s3c24xx => mach-s3c}/otom.h      |    0
 arch/arm/{mach-s3c64xx => mach-s3c}/pl080.c     |    6 +-
 .../{plat-samsung => mach-s3c}/platformdata.c   |    4 +-
 .../{mach-s3c24xx => mach-s3c}/pll-s3c2410.c    |    4 +-
 .../pll-s3c2440-12000000.c                      |    4 +-
 .../pll-s3c2440-16934400.c                      |    4 +-
 arch/arm/{plat-samsung => mach-s3c}/pm-common.c |    4 +-
 arch/arm/mach-s3c/pm-common.h                   |   40 +
 .../pm-core.h => mach-s3c/pm-core-s3c24xx.h}    |   10 +-
 .../pm-core.h => mach-s3c/pm-core-s3c64xx.h}    |   50 +-
 arch/arm/mach-s3c/pm-core.h                     |    9 +
 arch/arm/{plat-samsung => mach-s3c}/pm-gpio.c   |    6 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/pm-h1940.S  |    5 +-
 .../arm/{mach-s3c24xx => mach-s3c}/pm-s3c2410.c |   11 +-
 .../arm/{mach-s3c24xx => mach-s3c}/pm-s3c2412.c |   12 +-
 .../arm/{mach-s3c24xx => mach-s3c}/pm-s3c2416.c |    6 +-
 .../pm.c => mach-s3c/pm-s3c24xx.c}              |   14 +-
 .../pm.c => mach-s3c/pm-s3c64xx.c}              |   74 +-
 arch/arm/{plat-samsung => mach-s3c}/pm.c        |   20 +-
 .../include/plat => mach-s3c}/pm.h              |    2 +-
 .../include/plat => mach-s3c}/pwm-core.h        |    0
 .../include/plat => mach-s3c}/regs-adc.h        |    0
 .../regs-clock-s3c24xx.h}                       |    2 +
 .../regs-clock-s3c64xx.h}                       |    0
 arch/arm/mach-s3c/regs-clock.h                  |    9 +
 .../regs-dsc.h => mach-s3c/regs-dsc-s3c24xx.h}  |    6 +-
 .../regs-gpio-memport-s3c64xx.h}                |    0
 .../regs-gpio-s3c24xx.h}                        |    2 +
 .../regs-gpio-s3c64xx.h}                        |    0
 arch/arm/mach-s3c/regs-gpio.h                   |    9 +
 .../regs-irq.h => mach-s3c/regs-irq-s3c24xx.h}  |    2 +
 .../regs-irq.h => mach-s3c/regs-irq-s3c64xx.h}  |    0
 arch/arm/mach-s3c/regs-irq.h                    |    9 +
 .../include/plat => mach-s3c}/regs-irqtype.h    |    0
 .../regs-mem.h => mach-s3c/regs-mem-s3c24xx.h}  |    2 +
 .../regs-modem-s3c64xx.h}                       |    0
 .../mach => mach-s3c}/regs-s3c2443-clock.h      |   50 +
 .../regs-srom-s3c64xx.h}                        |    0
 .../regs-sys.h => mach-s3c/regs-sys-s3c64xx.h}  |    0
 .../regs-syscon-power-s3c64xx.h}                |    0
 .../regs-usb-hsotg-phy-s3c64xx.h}               |    0
 .../rtc-core.h => mach-s3c/rtc-core-s3c24xx.h}  |    6 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2410.c   |   23 +-
 .../{mach-s3c24xx => mach-s3c}/s3c2412-power.h  |    0
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2412.c   |   26 +-
 .../include/mach => mach-s3c}/s3c2412.h         |    2 +
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2416.c   |   36 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2440.c   |   17 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2442.c   |   17 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2443.c   |   30 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c244x.c   |   22 +-
 .../common.c => mach-s3c/s3c24xx.c}             |   33 +-
 .../common.h => mach-s3c/s3c24xx.h}             |   26 +-
 arch/arm/{mach-s3c64xx => mach-s3c}/s3c6400.c   |   16 +-
 arch/arm/{mach-s3c64xx => mach-s3c}/s3c6410.c   |   21 +-
 .../common.c => mach-s3c/s3c64xx.c}             |   54 +-
 .../common.h => mach-s3c/s3c64xx.h}             |   17 +-
 .../include/plat => mach-s3c}/sdhci.h           |    2 +-
 .../setup-fb-24bpp-s3c64xx.c}                   |    6 +-
 .../setup-i2c-s3c24xx.c}                        |    8 +-
 .../setup-i2c0-s3c64xx.c}                       |    4 +-
 .../setup-i2c1-s3c64xx.c}                       |    4 +-
 .../setup-ide-s3c64xx.c}                        |    9 +-
 .../setup-keypad-s3c64xx.c}                     |    6 +-
 .../setup-sdhci-gpio-s3c24xx.c}                 |    7 +-
 .../setup-sdhci-gpio-s3c64xx.c}                 |    6 +-
 .../setup-spi-s3c24xx.c}                        |    6 +-
 .../setup-spi-s3c64xx.c}                        |    5 +-
 .../setup-ts.c => mach-s3c/setup-ts-s3c24xx.c}  |    8 +-
 .../setup-usb-phy-s3c64xx.c}                    |   12 +-
 .../{mach-s3c24xx => mach-s3c}/simtec-audio.c   |   11 +-
 .../arm/{mach-s3c24xx => mach-s3c}/simtec-nor.c |    2 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/simtec-pm.c |   10 +-
 .../arm/{mach-s3c24xx => mach-s3c}/simtec-usb.c |    6 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/simtec.h    |    0
 .../{mach-s3c24xx => mach-s3c}/sleep-s3c2410.S  |    9 +-
 .../{mach-s3c24xx => mach-s3c}/sleep-s3c2412.S  |    5 +-
 .../sleep.S => mach-s3c/sleep-s3c24xx.S}        |    7 +-
 .../sleep.S => mach-s3c/sleep-s3c64xx.S}        |    4 +-
 .../spi-core.h => mach-s3c/spi-core-s3c24xx.h}  |    6 +-
 .../include/plat => mach-s3c}/usb-phy.h         |    0
 arch/arm/{mach-s3c24xx => mach-s3c}/vr1000.h    |    0
 .../{plat-samsung => mach-s3c}/wakeup-mask.c    |    4 +-
 .../include/plat => mach-s3c}/wakeup-mask.h     |    0
 arch/arm/mach-s3c24xx/include/mach/fb.h         |    2 -
 arch/arm/mach-s3c24xx/include/mach/io.h         |  212 ---
 arch/arm/mach-s3c24xx/setup-camif.c             |   67 -
 arch/arm/mach-s3c64xx/include/mach/hardware.h   |   17 -
 arch/arm/mach-s3c64xx/watchdog-reset.h          |   16 -
 arch/arm/mach-s5pv210/Kconfig                   |    2 +-
 arch/arm/mach-s5pv210/Makefile                  |    7 -
 arch/arm/mach-s5pv210/pm.c                      |   51 +-
 arch/arm/mach-s5pv210/regs-clock.h              |    4 +-
 arch/arm/mach-s5pv210/s5pv210.c                 |    2 -
 arch/arm/mach-shmobile/rcar-gen2.h              |    2 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |    4 +-
 arch/arm/mach-stm32/Makefile.boot               |    2 +-
 .../plat-samsung/include/plat/samsung-time.h    |   26 -
 arch/arm/plat-samsung/watchdog-reset.c          |   93 --
 arch/arm64/Kconfig.platforms                    |    1 -
 drivers/clk/imx/clk-imx27.c                     |   73 -
 drivers/clk/imx/clk-imx31.c                     |   71 -
 drivers/clk/imx/clk-imx35.c                     |   68 -
 drivers/clk/samsung/clk-s3c2410-dclk.c          |   15 +-
 drivers/clk/samsung/clk-s3c2410.c               |    1 +
 drivers/clk/samsung/clk-s3c2412.c               |    1 +
 drivers/clk/samsung/clk-s3c2443.c               |    1 +
 drivers/clk/samsung/clk-s3c64xx.c               |    1 +
 drivers/cpufreq/Kconfig.arm                     |    2 -
 drivers/cpufreq/s3c2410-cpufreq.c               |   10 +-
 drivers/cpufreq/s3c2412-cpufreq.c               |   44 +-
 drivers/cpufreq/s3c2440-cpufreq.c               |   29 +-
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c       |    2 +-
 drivers/cpufreq/s3c24xx-cpufreq.c               |   14 +-
 drivers/hwmon/s3c-hwmon.c                       |    2 +-
 drivers/input/touchscreen/s3c2410_ts.c          |   37 +-
 drivers/irqchip/Makefile                        |    1 -
 drivers/mmc/host/Kconfig                        |    2 +-
 drivers/mmc/host/s3cmci.c                       |   72 +-
 drivers/power/supply/s3c_adc_battery.c          |    2 +-
 drivers/pwm/Kconfig                             |    2 +-
 drivers/soc/samsung/Kconfig                     |   49 +-
 drivers/soc/samsung/Makefile                    |    3 +
 .../soc/samsung/s3c-pm-check.c                  |    2 +-
 .../soc/samsung/s3c-pm-debug.c                  |   26 +-
 drivers/soc/ti/omap_prm.c                       |  274 +++-
 drivers/soc/ti/pm33xx.c                         |   47 +-
 drivers/soc/versatile/soc-integrator.c          |    2 +-
 drivers/spi/Kconfig                             |    2 +-
 drivers/spi/Makefile                            |    1 -
 .../spi/spi-s3c24xx-regs.h                      |    9 +-
 drivers/spi/spi-s3c24xx.c                       |   28 +-
 drivers/tty/serial/Kconfig                      |    2 +-
 drivers/usb/gadget/udc/s3c-hsudc.c              |   55 +-
 drivers/usb/gadget/udc/s3c2410_udc.c            |   31 +-
 drivers/usb/gadget/udc/s3c2410_udc.h            |    1 +
 .../usb/gadget/udc/s3c2410_udc_regs.h           |    0
 .../video/fbdev/s3c2410fb-regs-lcd.h            |   28 +-
 drivers/video/fbdev/s3c2410fb.c                 |   16 +-
 drivers/watchdog/Kconfig                        |   10 +-
 include/linux/clk/samsung.h                     |   56 +
 include/linux/platform_data/clk-s3c2410.h       |   19 +
 .../linux/platform_data}/fb-s3c2410.h           |   33 +-
 include/linux/platform_data/mmc-s3cmci.h        |    2 +
 include/linux/platform_data/pm33xx.h            |    3 -
 include/linux/platform_data/s3c-hsudc.h         |    2 +
 .../linux/soc/samsung/s3c-adc.h                 |    6 +-
 .../linux/soc/samsung/s3c-cpu-freq.h            |    4 +
 .../linux/soc/samsung/s3c-cpufreq-core.h        |   14 +-
 .../linux/soc/samsung/s3c-pm.h                  |   69 +-
 .../linux/spi/s3c24xx-fiq.h                     |   10 +
 include/linux/spi/s3c24xx.h                     |    2 +-
 include/media/drv-intf/s3c_camif.h              |    4 -
 sound/soc/samsung/Kconfig                       |    2 +-
 sound/soc/samsung/s3c2412-i2s.c                 |    7 -
 sound/soc/samsung/s3c24xx-i2s.c                 |    7 -
 448 files changed, 2671 insertions(+), 17509 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h
 delete mode 100644 arch/arm/mach-imx/3ds_debugboard.c
 delete mode 100644 arch/arm/mach-imx/3ds_debugboard.h
 delete mode 100644 arch/arm/mach-imx/board-mx31lilly.h
 delete mode 100644 arch/arm/mach-imx/board-mx31lite.h
 delete mode 100644 arch/arm/mach-imx/board-mx31moboard.h
 delete mode 100644 arch/arm/mach-imx/devices-imx21.h
 delete mode 100644 arch/arm/mach-imx/devices-imx27.h
 delete mode 100644 arch/arm/mach-imx/devices-imx31.h
 delete mode 100644 arch/arm/mach-imx/devices-imx35.h
 delete mode 100644 arch/arm/mach-imx/devices/Kconfig
 delete mode 100644 arch/arm/mach-imx/devices/Makefile
 delete mode 100644 arch/arm/mach-imx/devices/devices-common.h
 delete mode 100644 arch/arm/mach-imx/devices/devices.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-fec.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-flexcan.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-gpio-mxc.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-gpio_keys.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx-dma.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx-fb.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx-i2c.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx-keypad.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx-ssi.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx-uart.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx2-wdt.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx21-hcd.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx27-coda.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-ipu-core.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mx2-camera.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mx2-emma.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc-ehci.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc-mmc.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_nand.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_rtc.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_w1.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-pata_imx.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-spi_imx.c
 delete mode 100644 arch/arm/mach-imx/ehci-imx27.c
 delete mode 100644 arch/arm/mach-imx/ehci-imx31.c
 delete mode 100644 arch/arm/mach-imx/ehci-imx35.c
 delete mode 100644 arch/arm/mach-imx/ehci.h
 delete mode 100644 arch/arm/mach-imx/imx27-dt.c
 delete mode 100644 arch/arm/mach-imx/iomux-imx31.c
 delete mode 100644 arch/arm/mach-imx/iomux-mx21.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx27.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx2x.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx3.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx35.h
 delete mode 100644 arch/arm/mach-imx/iomux-v1.c
 delete mode 100644 arch/arm/mach-imx/iomux-v1.h
 delete mode 100644 arch/arm/mach-imx/iomux-v3.c
 delete mode 100644 arch/arm/mach-imx/iomux-v3.h
 delete mode 100644 arch/arm/mach-imx/mach-armadillo5x0.c
 delete mode 100644 arch/arm/mach-imx/mach-bug.c
 create mode 100644 arch/arm/mach-imx/mach-imx27.c
 rename arch/arm/mach-imx/{imx31-dt.c => mach-imx31.c} (100%)
 rename arch/arm/mach-imx/{imx35-dt.c => mach-imx35.c} (100%)
 delete mode 100644 arch/arm/mach-imx/mach-kzm_arm11_01.c
 delete mode 100644 arch/arm/mach-imx/mach-mx21ads.c
 delete mode 100644 arch/arm/mach-imx/mach-mx27_3ds.c
 delete mode 100644 arch/arm/mach-imx/mach-mx27ads.c
 delete mode 100644 arch/arm/mach-imx/mach-mx31_3ds.c
 delete mode 100644 arch/arm/mach-imx/mach-mx31ads.c
 delete mode 100644 arch/arm/mach-imx/mach-mx31lilly.c
 delete mode 100644 arch/arm/mach-imx/mach-mx31lite.c
 delete mode 100644 arch/arm/mach-imx/mach-mx35_3ds.c
 delete mode 100644 arch/arm/mach-imx/mach-pca100.c
 delete mode 100644 arch/arm/mach-imx/mach-pcm037.c
 delete mode 100644 arch/arm/mach-imx/mach-pcm037_eet.c
 delete mode 100644 arch/arm/mach-imx/mach-pcm043.c
 delete mode 100644 arch/arm/mach-imx/mach-qong.c
 delete mode 100644 arch/arm/mach-imx/mach-vpr200.c
 delete mode 100644 arch/arm/mach-imx/mm-imx21.c
 delete mode 100644 arch/arm/mach-imx/mm-imx27.c
 delete mode 100644 arch/arm/mach-imx/mx21.h
 delete mode 100644 arch/arm/mach-imx/mx31lilly-db.c
 delete mode 100644 arch/arm/mach-imx/mx31lite-db.c
 delete mode 100644 arch/arm/mach-imx/mx31moboard-devboard.c
 delete mode 100644 arch/arm/mach-imx/mx31moboard-marxbot.c
 delete mode 100644 arch/arm/mach-imx/mx31moboard-smartbot.c
 delete mode 100644 arch/arm/mach-imx/pcm037.h
 delete mode 100644 arch/arm/mach-imx/ulpi.h
 rename arch/arm/{plat-samsung => mach-s3c}/Kconfig (69%)
 rename arch/arm/{mach-s3c24xx/Kconfig => mach-s3c/Kconfig.s3c24xx} (97%)
 rename arch/arm/{mach-s3c64xx/Kconfig => mach-s3c/Kconfig.s3c64xx} (98%)
 rename arch/arm/{plat-samsung => mach-s3c}/Makefile (62%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/Makefile.boot (100%)
 rename arch/arm/{mach-s3c24xx/Makefile => mach-s3c/Makefile.s3c24xx} (81%)
 rename arch/arm/{mach-s3c64xx/Makefile => mach-s3c/Makefile.s3c64xx} (56%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/adc-core.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/adc.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/anubis.h (100%)
 rename arch/arm/{mach-s3c64xx/ata-core.h => mach-s3c/ata-core-s3c64xx.h} (78%)
 rename arch/arm/{mach-s3c64xx/backlight.h => mach-s3c/backlight-s3c64xx.h} (78%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/bast-ide.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/bast-irq.c (95%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/bast.h (100%)
 rename arch/arm/{mach-s3c24xx/common-smdk.c => mach-s3c/common-smdk-s3c24xx.c} (96%)
 rename arch/arm/{mach-s3c24xx/common-smdk.h => mach-s3c/common-smdk-s3c24xx.h} (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/cpu.c (62%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/cpu.h (89%)
 rename arch/arm/{mach-s3c24xx/cpufreq-utils.c => mach-s3c/cpufreq-utils-s3c24xx.c} (68%)
 rename arch/arm/{mach-s3c64xx/cpuidle.c => mach-s3c/cpuidle-s3c64xx.c} (92%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/crag6410.h (95%)
 rename arch/arm/{mach-s3c64xx/dev-audio.c => mach-s3c/dev-audio-s3c64xx.c} (97%)
 rename arch/arm/{mach-s3c64xx/dev-backlight.c => mach-s3c/dev-backlight-s3c64xx.c} (98%)
 rename arch/arm/{mach-s3c64xx/dev-uart.c => mach-s3c/dev-uart-s3c64xx.c} (95%)
 rename arch/arm/{plat-samsung => mach-s3c}/dev-uart.c (97%)
 rename arch/arm/{plat-samsung => mach-s3c}/devs.c (96%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/devs.h (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/dma.h => mach-s3c/dma-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/dma.h => mach-s3c/dma-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/dma.h
 rename arch/arm/{mach-s3c24xx/fb-core.h => mach-s3c/fb-core-s3c24xx.h} (78%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/fb.h (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/gpio-cfg-helpers.h (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/gpio-cfg.h (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/gpio-core.h (99%)
 rename arch/arm/{mach-s3c24xx/include/mach/gpio-samsung.h => mach-s3c/gpio-samsung-s3c24xx.h} (99%)
 rename arch/arm/{mach-s3c64xx/include/mach/gpio-samsung.h => mach-s3c/gpio-samsung-s3c64xx.h} (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/gpio-samsung.c (99%)
 create mode 100644 arch/arm/mach-s3c/gpio-samsung.h
 rename arch/arm/{mach-s3c24xx => mach-s3c}/gta02.h (94%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/h1940-bluetooth.c (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/h1940.h (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/hardware.h => mach-s3c/hardware-s3c24xx.h} (54%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/iic-core.h (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/io-s3c24xx.h
 create mode 100644 arch/arm/mach-s3c/include/mach/io.h
 rename arch/arm/{mach-s3c24xx/include/mach/irqs.h => mach-s3c/include/mach/irqs-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/irqs.h => mach-s3c/include/mach/irqs-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/irqs.h
 rename arch/arm/{plat-samsung/include/plat => mach-s3c/include/mach}/map-base.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/init.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/iotiming-s3c2410.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/iotiming-s3c2412.c (98%)
 rename arch/arm/{mach-s3c24xx/irq-pm.c => mach-s3c/irq-pm-s3c24xx.c} (93%)
 rename arch/arm/{mach-s3c64xx/irq-pm.c => mach-s3c/irq-pm-s3c64xx.c} (97%)
 create mode 100644 arch/arm/mach-s3c/irq-s3c24xx-fiq-exports.c
 rename drivers/spi/spi-s3c24xx-fiq.S => arch/arm/mach-s3c/irq-s3c24xx-fiq.S (94%)
 rename {drivers/irqchip => arch/arm/mach-s3c}/irq-s3c24xx.c (99%)
 rename arch/arm/{mach-s3c64xx/irq-uart.h => mach-s3c/irq-uart-s3c64xx.h} (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/keypad.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-amlm5900.c (83%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-anubis.c (97%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-anw6410.c (93%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-at2440evb.c (87%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-bast.c (97%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-crag6410-module.c (98%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-crag6410.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-gta02.c (92%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-h1940.c (94%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-hmt.c (95%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-jive.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-mini2440.c (94%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-mini6410.c (95%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-n30.c (94%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-ncp.c (87%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-nexcoder.c (90%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-osiris-dvs.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-osiris.c (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-otom.c (88%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-qt2410.c (88%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-real6410.c (95%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-rx1950.c (94%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-rx3715.c (89%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-s3c2416-dt.c (92%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-s3c64xx-dt.c (70%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq.c (96%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq.h (100%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq5.c (91%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq7.c (92%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2410.c (86%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2413.c (86%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2416.c (93%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2440.c (87%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2443.c (90%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smdk6400.c (87%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smdk6410.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-tct_hammer.c (81%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-vr1000.c (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-vstms.c (88%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/map-s3c.h (87%)
 rename arch/arm/{mach-s3c24xx/include/mach/map.h => mach-s3c/map-s3c24xx.h} (97%)
 rename arch/arm/{mach-s3c64xx/include/mach/map.h => mach-s3c/map-s3c64xx.h} (98%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/map-s5p.h (85%)
 create mode 100644 arch/arm/mach-s3c/map.h
 rename arch/arm/{mach-s3c24xx/nand-core.h => mach-s3c/nand-core-s3c24xx.h} (77%)
 rename arch/arm/{mach-s3c64xx/onenand-core.h => mach-s3c/onenand-core-s3c64xx.h} (82%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/osiris.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/otom.h (100%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/pl080.c (98%)
 rename arch/arm/{plat-samsung => mach-s3c}/platformdata.c (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pll-s3c2410.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pll-s3c2440-12000000.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pll-s3c2440-16934400.c (98%)
 rename arch/arm/{plat-samsung => mach-s3c}/pm-common.c (95%)
 create mode 100644 arch/arm/mach-s3c/pm-common.h
 rename arch/arm/{mach-s3c24xx/include/mach/pm-core.h => mach-s3c/pm-core-s3c24xx.h} (94%)
 rename arch/arm/{mach-s3c64xx/include/mach/pm-core.h => mach-s3c/pm-core-s3c64xx.h} (58%)
 create mode 100644 arch/arm/mach-s3c/pm-core.h
 rename arch/arm/{plat-samsung => mach-s3c}/pm-gpio.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-h1940.S (80%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-s3c2410.c (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-s3c2412.c (94%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-s3c2416.c (95%)
 rename arch/arm/{mach-s3c24xx/pm.c => mach-s3c/pm-s3c24xx.c} (93%)
 rename arch/arm/{mach-s3c64xx/pm.c => mach-s3c/pm-s3c64xx.c} (81%)
 rename arch/arm/{plat-samsung => mach-s3c}/pm.c (94%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/pm.h (98%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/pwm-core.h (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/regs-adc.h (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/regs-clock.h => mach-s3c/regs-clock-s3c24xx.h} (99%)
 rename arch/arm/{mach-s3c64xx/include/mach/regs-clock.h => mach-s3c/regs-clock-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/regs-clock.h
 rename arch/arm/{mach-s3c24xx/regs-dsc.h => mach-s3c/regs-dsc-s3c24xx.h} (77%)
 rename arch/arm/{mach-s3c64xx/regs-gpio-memport.h => mach-s3c/regs-gpio-memport-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/regs-gpio.h => mach-s3c/regs-gpio-s3c24xx.h} (99%)
 rename arch/arm/{mach-s3c64xx/include/mach/regs-gpio.h => mach-s3c/regs-gpio-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/regs-gpio.h
 rename arch/arm/{mach-s3c24xx/include/mach/regs-irq.h => mach-s3c/regs-irq-s3c24xx.h} (98%)
 rename arch/arm/{mach-s3c64xx/include/mach/regs-irq.h => mach-s3c/regs-irq-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/regs-irq.h
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/regs-irqtype.h (100%)
 rename arch/arm/{mach-s3c24xx/regs-mem.h => mach-s3c/regs-mem-s3c24xx.h} (98%)
 rename arch/arm/{mach-s3c64xx/regs-modem.h => mach-s3c/regs-modem-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx/include/mach => mach-s3c}/regs-s3c2443-clock.h (81%)
 rename arch/arm/{mach-s3c64xx/regs-srom.h => mach-s3c/regs-srom-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-sys.h => mach-s3c/regs-sys-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-syscon-power.h => mach-s3c/regs-syscon-power-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-usb-hsotg-phy.h => mach-s3c/regs-usb-hsotg-phy-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/rtc-core.h => mach-s3c/rtc-core-s3c24xx.h} (81%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2410.c (88%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2412-power.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2412.c (92%)
 rename arch/arm/{mach-s3c24xx/include/mach => mach-s3c}/s3c2412.h (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2416.c (84%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2440.c (85%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2442.c (82%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2443.c (83%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c244x.c (90%)
 rename arch/arm/{mach-s3c24xx/common.c => mach-s3c/s3c24xx.c} (97%)
 rename arch/arm/{mach-s3c24xx/common.h => mach-s3c/s3c24xx.h} (85%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/s3c6400.c (88%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/s3c6410.c (87%)
 rename arch/arm/{mach-s3c64xx/common.c => mach-s3c/s3c64xx.c} (91%)
 rename arch/arm/{mach-s3c64xx/common.h => mach-s3c/s3c64xx.h} (80%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/sdhci.h (99%)
 rename arch/arm/{mach-s3c64xx/setup-fb-24bpp.c => mach-s3c/setup-fb-24bpp-s3c64xx.c} (86%)
 rename arch/arm/{mach-s3c24xx/setup-i2c.c => mach-s3c/setup-i2c-s3c24xx.c} (79%)
 rename arch/arm/{mach-s3c64xx/setup-i2c0.c => mach-s3c/setup-i2c0-s3c64xx.c} (90%)
 rename arch/arm/{mach-s3c64xx/setup-i2c1.c => mach-s3c/setup-i2c1-s3c64xx.c} (90%)
 rename arch/arm/{mach-s3c64xx/setup-ide.c => mach-s3c/setup-ide-s3c64xx.c} (89%)
 rename arch/arm/{mach-s3c64xx/setup-keypad.c => mach-s3c/setup-keypad-s3c64xx.c} (86%)
 rename arch/arm/{mach-s3c24xx/setup-sdhci-gpio.c => mach-s3c/setup-sdhci-gpio-s3c24xx.c} (89%)
 rename arch/arm/{mach-s3c64xx/setup-sdhci-gpio.c => mach-s3c/setup-sdhci-gpio-s3c64xx.c} (95%)
 rename arch/arm/{mach-s3c24xx/setup-spi.c => mach-s3c/setup-spi-s3c24xx.c} (85%)
 rename arch/arm/{mach-s3c64xx/setup-spi.c => mach-s3c/setup-spi-s3c64xx.c} (83%)
 rename arch/arm/{mach-s3c24xx/setup-ts.c => mach-s3c/setup-ts-s3c24xx.c} (81%)
 rename arch/arm/{mach-s3c64xx/setup-usb-phy.c => mach-s3c/setup-usb-phy-s3c64xx.c} (92%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-audio.c (86%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-nor.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-pm.c (91%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-usb.c (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/sleep-s3c2410.S (90%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/sleep-s3c2412.S (93%)
 rename arch/arm/{mach-s3c24xx/sleep.S => mach-s3c/sleep-s3c24xx.S} (92%)
 rename arch/arm/{mach-s3c64xx/sleep.S => mach-s3c/sleep-s3c64xx.S} (97%)
 rename arch/arm/{mach-s3c24xx/spi-core.h => mach-s3c/spi-core-s3c24xx.h} (81%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/usb-phy.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/vr1000.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/wakeup-mask.c (94%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c}/wakeup-mask.h (100%)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/fb.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-s3c24xx/setup-camif.c
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-s3c64xx/watchdog-reset.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/samsung-time.h
 delete mode 100644 arch/arm/plat-samsung/watchdog-reset.c
 rename arch/arm/plat-samsung/pm-check.c => drivers/soc/samsung/s3c-pm-check.c (99%)
 rename arch/arm/plat-samsung/pm-debug.c => drivers/soc/samsung/s3c-pm-debug.c (78%)
 rename arch/arm/plat-samsung/include/plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h (89%)
 rename arch/arm/plat-samsung/include/plat/regs-udc.h => drivers/usb/gadget/udc/s3c2410_udc_regs.h (100%)
 rename arch/arm/mach-s3c24xx/include/mach/regs-lcd.h => drivers/video/fbdev/s3c2410fb-regs-lcd.h (84%)
 create mode 100644 include/linux/clk/samsung.h
 create mode 100644 include/linux/platform_data/clk-s3c2410.h
 rename {arch/arm/plat-samsung/include/plat => include/linux/platform_data}/fb-s3c2410.h (57%)
 rename arch/arm/plat-samsung/include/plat/adc.h => include/linux/soc/samsung/s3c-adc.h (85%)
 rename arch/arm/plat-samsung/include/plat/cpu-freq.h => include/linux/soc/samsung/s3c-cpu-freq.h (97%)
 rename arch/arm/plat-samsung/include/plat/cpu-freq-core.h => include/linux/soc/samsung/s3c-cpufreq-core.h (95%)
 rename arch/arm/plat-samsung/include/plat/pm-common.h => include/linux/soc/samsung/s3c-pm.h (55%)
 rename drivers/spi/spi-s3c24xx-fiq.h => include/linux/spi/s3c24xx-fiq.h (66%)
