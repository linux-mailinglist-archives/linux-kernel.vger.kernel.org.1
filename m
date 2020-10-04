Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CD282E43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJDXRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 19:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 19:17:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF8C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 16:17:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u8so8681406lff.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Vn5qp24Wpt85e1jA//fu1xePNpWjd3QXl30e1roFozM=;
        b=ekR1FHGKfRNdO0bjeO27FnxpR5HeQo9DX60VrvqVGOP6w0ko/k+vy7t+ORttKLOmeo
         QuAmulrIiNO6U1NLIlSjqkhnW0NmmqyWzpvBx7whyZgXr53uBhopMTaotkA5Wh3Tki7b
         srkgEVQxwEp6Te9Bo+rTo5Ocz0iDbQ4IpERik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Vn5qp24Wpt85e1jA//fu1xePNpWjd3QXl30e1roFozM=;
        b=LWkcCBDhkjg7+AxpNxeVKszzL+OWhK5aGGm0AhnrmOrQcktdnNTZnd0IDzut6JpOMP
         L40ygh9kTi7/+z/59wRRQR8S7qhgLW8j7jJPVjj46QfhlWtk2UEyEx6ZZvVcJYvUBI/z
         d56FRlQ6qLMWWcCoxX5V/hMOLmRVjsOX7Xu8v5DcSoM125446IfMAlaj46z3z8KRfSkl
         S0cy/tBeNrNwnpGMz6ad47bGLl2LlxmcKC2md1KC7OZZYUCPOm0ENCSXx1OxECTkRX0o
         hml0zczPng8aP3c1TDaCqnKb5kf+JV9f6qw6ZjXYBlDPFMxIEvKwmNIfA14XNf7pi49C
         dK/Q==
X-Gm-Message-State: AOAM533kcN00AfJrwph05OIqcn/uuAjApL+4Fjy2Bhs0G/+dptpTNxRp
        9uojYNphgAOmqXw58cBT/9iKMO1CsZcDoQ==
X-Google-Smtp-Source: ABdhPJw8Qdxk79pGdHmqI1YVAxLleLnqUTe6Ckm2bAvb/B+eBS4MWUabaPfpDUs9Djt3zQdUM12tyg==
X-Received: by 2002:a19:b03:: with SMTP id 3mr2296916lfl.67.1601853466363;
        Sun, 04 Oct 2020 16:17:46 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p4sm2509111lfr.68.2020.10.04.16.17.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 16:17:45 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y2so8652545lfy.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 16:17:45 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr4799120lfb.133.1601853464648;
 Sun, 04 Oct 2020 16:17:44 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Oct 2020 16:17:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
Message-ID: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
Subject: Linux 5.9-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So things have been pretty calm, and rc8 is fairly small. I'm still
waiting for a networking pull with some fixes, so it's not like I
could have made a final 5.9 release even if I had wanted to, but there
was nothing scary going on this past week, and it all feels ready for
a final 5.9 next weekend.

In fact, a lot of the emails I'm seeing are about the next merge
window, and I already have one pull request ready to go, which is all
good. That's how it's all supposed to work.

Anyway, the changes in rc8 are mostly driver fixlets, with some AMD
GPU header file updates being a fairly noticeable part of the patch.
That's not some scary big change - it' just the usual register
definition update (and much smaller than the wholesale big ones we've
had).

Outside of the driver stuff, we do have a few filesystem fixes (btrfs
and nfs), and a couple of core fixes (tiny fallout from the VM
changes, but also a pipe splice race fixlet for stable and a couple of
epoll fixes). And slime other small noise (small arch and DT fixes).
Quite a small diffstat overall - which it obviously should be this
late in the release.

One final push for testing this week,

                Linus

---

Adrian Huang (1):
      iommu/amd: Fix the overwritten field in IVMD header

Ahmad Fatoum (1):
      gpio: siox: explicitly support only threaded irqs

Al Viro (4):
      epoll: do not insert into poll queues until all sanity checks are don=
e
      epoll: replace ->visited/visited_list with generation count
      epoll: EPOLL_CTL_ADD: close the race in decision to take fast path
      ep_create_wakeup_source(): dentry name can change under you...

Alex Deucher (6):
      drm/amdgpu: add the GC 10.3 VRS registers
      drm/amdgpu: add VCN 3.0 AV1 registers
      drm/amdgpu: use the AV1 defines for VCN 3.0
      drm/amdgpu: remove experimental flag from navi12
      drm/amdgpu/display: fix CFLAGS setup for DCN30
      drm/amdgpu/swsmu/smu12: fix force clock handling for mclk

Andy Shevchenko (3):
      gpiolib: Fix line event handling in syscall compatible mode
      gpio: pca953x: Use bitmap API over implicit GCC extension
      gpio: pca953x: Correctly initialize registers 6 and 7 for PCA957x

Anup Patel (1):
      RISC-V: Check clint_time_val before use

Ard Biesheuvel (1):
      arm64: permit ACPI core to map kernel memory used for table overrides

Bartosz Golaszewski (1):
      gpio: mockup: fix resource leak in error path

Bryan O'Donoghue (1):
      USB: gadget: f_ncm: Fix NDP16 datagram validation

Chris Packham (1):
      pinctrl: mvebu: Fix i2c sda definition for 98DX3236

Dan Carpenter (1):
      phy: ti: am654: Fix a leak in serdes_am654_probe()

Dinh Nguyen (1):
      clk: socfpga: stratix10: fix the divider for the emac_ptp_free_clk

Dirk Gouders (1):
      drm/amd/display: remove duplicate call to rn_vbios_smu_get_smu_versio=
n()

Dmitry Baryshkov (2):
      iio: adc: qcom-spmi-adc5: fix driver name
      pinctrl: qcom: sm8250: correct sdc2_clk

Ed Wildgoose (1):
      gpio: amd-fch: correct logic of GPIO_LINE_DIRECTION

Eli Cohen (1):
      vhost: Fix documentation

Eric Biggers (1):
      scripts/spelling.txt: fix malformed entry

Eric Farman (1):
      mm, slub: restore initial kmem_cache flags

Evan Quan (1):
      drm/amd/pm: setup APU dpm clock table in SMU HW initialization

Filipe Manana (1):
      btrfs: fix filesystem corruption after a device replace

Flora Cui (1):
      drm/amd/display: fix return value check for hdcp_work

Hanks Chen (1):
      pinctrl: mediatek: check mtk_is_virt_gpio input parameter

Hans de Goede (2):
      pinctrl: cherryview: Preserve CHV_PADCTRL1_INVRXTX_TXDATA flag on GPI=
Os
      mmc: sdhci: Workaround broken command queuing on Intel GLK based
IRBIS models

Hao Xu (1):
      io_uring: fix async buffered reads when readahead is disabled

Jason A. Donenfeld (1):
      mm: do not rely on mm =3D=3D current->mm in __get_user_pages_locked

Jason Wang (1):
      vhost-vdpa: fix backend feature ioctls

Jean Delvare (2):
      i2c: i801: Exclude device from suspend direct complete optimization
      drm/amdgpu: restore proper ref count in amdgpu_display_crtc_set_confi=
g

Jeffrey Mitchell (1):
      nfs: Fix security label length not being reset

Jens Axboe (2):
      io_uring: always delete double poll wait entry on match
      io_uring: fix potential ABBA deadlock in ->show_fdinfo()

Jeremy Kerr (2):
      gpio/aspeed-sgpio: enable access to all 80 input & output sgpios
      gpio/aspeed-sgpio: don't enable all interrupts by default

Jiansong Chen (2):
      drm/amdgpu: remove gpu_info fw support for sienna_cichlid etc.
      drm/amdgpu: disable gfxoff temporarily for navy_flounder

Jiri Kosina (1):
      Input: i8042 - add nopnp quirk for Acer Aspire 5 A515

Joonsoo Kim (1):
      mm/page_alloc: handle a missing case for
memalloc_nocma_{save/restore} APIs

Josef Bacik (2):
      btrfs: move btrfs_scratch_superblocks into btrfs_dev_replace_finishin=
g
      btrfs: move btrfs_rm_dev_replace_free_srcdev outside of all locks

Juergen Gross (1):
      xen/events: don't use chip_data for legacy IRQs

Kai-Heng Feng (1):
      memstick: Skip allocating card when removing host

Likun Gao (1):
      drm/amdgpu: add device ID for sienna_cichlid (v2)

Linus Torvalds (3):
      autofs: use __kernel_write() for the autofs pipe writing
      pipe: remove pipe_wait() and fix wakeup race with splice
      Linux 5.9-rc8

Lorenzo Pieralisi (1):
      PCI: rockchip: Fix bus checks in rockchip_pcie_valid_device()

Lu Baolu (1):
      iommu/vt-d: Fix lockdep splat in iommu_flush_dev_iotlb()

M. Vefa Bicakci (4):
      Revert "usbip: Implement a match function to fix usbip"
      usbcore/driver: Fix specific driver selection
      usbcore/driver: Fix incorrect downcast
      usbcore/driver: Accommodate usbip

Marc Zyngier (1):
      KVM: arm64: Restore missing ISB on nVHE __tlb_switch_to_guest

Marek Beh=C3=BAn (1):
      dt-bindings: leds: cznic,turris-omnia-leds: fix error in binding

Marek Szyprowski (2):
      clk: samsung: Keep top BPLL mux on Exynos542x enabled
      clk: samsung: exynos4: mark 'chipid' clock as CLK_IGNORE_UNUSED

Mark Mielke (1):
      scsi: iscsi: iscsi_tcp: Avoid holding spinlock while calling getpeern=
ame()

Maxime Ripard (1):
      ARM: dts: bcm2835: Change firmware compatible from simple-bus to
simple-mfd

Mircea Caprioru (1):
      iio: adc: ad7124: Fix typo in device name

Nicolas VINCENT (1):
      i2c: cpm: Fix i2c_ram structure

Olga Kornievskaia (1):
      NFSv4.2: fix client's attribute cache management for copy_file_range

Pali Roh=C3=A1r (1):
      MAINTAINERS: Add Pali Roh=C3=A1r as aardvark PCI maintainer

Palmer Dabbelt (1):
      clocksource: clint: Export clint_time_val for modules

Paolo Bonzini (1):
      KVM: VMX: update PFEC_MASK/PFEC_MATCH together with PF intercept

Philip Yang (1):
      drm/amdgpu: prevent double kfree ttm->sg

Rob Herring (1):
      dt-bindings: Fix 'reg' size issues in zynqmp examples

Roman Gushchin (1):
      mm: memcg/slab: fix slab statistics in !SMP configuration

Steven Rostedt (VMware) (2):
      tracing: Fix trace_find_next_entry() accounting of temp buffer size
      ftrace: Move RCU is watching check after recursion check

Sudhakar Panneerselvam (1):
      scsi: target: Fix lun lookup for TARGET_SCF_LOOKUP_LUN_FROM_TAG case

Sudheesh Mavila (1):
      drm/amd/pm: Removed fixed clock in auto mode DPM

Taiping Lai (1):
      gpio: sprd: Clear interrupt when setting the type as edge

Tali Perry (1):
      i2c: npcm7xx: Clear LAST bit after a failed transaction.

Tao Ren (1):
      gpio: aspeed: fix ast2600 bank properties

Tero Kristo (1):
      dt-bindings: crypto: sa2ul: fix a DT binding check warning

Thibaut Sautereau (1):
      random32: Restore __latent_entropy attribute on net_rand_state

Thierry Reding (3):
      clk: tegra: Capitalization fixes
      clk: tegra: Always program PLL_E when enabled
      clk: tegra: Fix missing prototype for tegra210_clk_register_emc()

Tony Lindgren (1):
      gpio: omap: Fix warnings if PM is disabled

Trond Myklebust (2):
      pNFS/flexfiles: Ensure we initialise the mirror bsizes correctly on r=
ead
      pNFS/flexfiles: Be consistent about mirror index types

Ulf Hansson (1):
      ARM: imx6q: Fixup RCU usage for cpuidle

Uwe Kleine-K=C3=B6nig (1):
      scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting

Vincent Huang (1):
      Input: trackpoint - enable Synaptics trackpoints

Vladimir Murzin (1):
      dmaengine: dmatest: Prevent to run on misconfigured channel

Ye Li (1):
      gpio: pca953x: Fix uninitialized pending variable

Yoann Congal (1):
      Documentation: PM: Fix a reStructuredText syntax error

Yu Kuai (1):
      iommu/exynos: add missing put_device() call in exynos_iommu_of_xlate(=
)

Zack Rusin (1):
      drm/vmwgfx: Fix error handling in get_node

Zhang Rui (1):
      cpufreq: intel_pstate: Fix missing return statement

dillon min (1):
      gpio: tc35894: fix up tc35894 interrupt configuration

yangerkun (1):
      blk-mq: call commit_rqs while list empty but error happen
