Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E88301FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 02:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAYBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 20:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbhAYBHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 20:07:50 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F7C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:07:00 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a25so12181348ljn.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RUhKL8+aA3RKLPg6CR1uywJo423nxGlZ86Z1HgKnO4g=;
        b=gZq/pBgMlORO+hBhDXqTA9YlG9574ec+6IjmbbYmg6TaVWgQenQDTD/Prlw7Yvrb4G
         Wa+zUXTOKeLLJaGwaAqn/0e2z30d3hrEGSrlwGQpD6Td0Fke+JhENlIV6VVyVZDfi/2H
         TDy5dq6chpsVDGwOHx5WFPGcThbB7AtDSNHkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RUhKL8+aA3RKLPg6CR1uywJo423nxGlZ86Z1HgKnO4g=;
        b=HLOaoD6rQdsd1aD9ofd23UNqxIgRd0CiY598Tyt66maH5KSLssqh4As9bQPYnk7OpF
         Q8lyx/cwDyONspz5HPgb9KLXsieUHBXV5+NUrdZbWr0d6lOpXdFOppjqZcG54Ob5ScvX
         Aqc2TnsJtcIkA6roWSI1uMVpltYuNvavnyA1/Z7lkT/7a6w9kbN2ZXrUh9F23DmSqiEb
         em1+WPJvube1XoN0cxAd8857ysWVGL/FGgx/QrIhAAVYtfSGo2twJFLGwpBZVTI3C7UA
         40MDl25BvSa2l/TphWso2f5m9GTY4rpiIgTT33KbzReOW/HB+SxbiL4qThXc6zt6lMsW
         Q6GQ==
X-Gm-Message-State: AOAM533CVjwxKdlsrdHbne6IUO2tt1xOranN93zifYQkyS4fWehBN1zj
        fUzuZleIWh3xVxm/Or3QVe3+CxVljpxl2g==
X-Google-Smtp-Source: ABdhPJxZdYsGvA2IqZulJA/RsszhNozTBIiv8sEBVj3iucnW5CVO6d1fEhV+5DpqLxyrTgPzIN3ArQ==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr12267ljc.46.1611536818380;
        Sun, 24 Jan 2021 17:06:58 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a30sm1931601ljq.96.2021.01.24.17.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:06:57 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id v67so15393279lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:06:57 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr1013722lfu.40.1611536816470;
 Sun, 24 Jan 2021 17:06:56 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jan 2021 17:06:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
Message-ID: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
Subject: Linux 5.11-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this rc looked fairly calm and small, all the way up until today.

In fact, over 40% of the non-merge commits came in today, as people
unloaded their work for the week on me. The end result is a slightly
larger than usual rc5 (but both 5.10 and 5.8 were bigger, so not some
kind of odd outlier).

Nothing particularly stands out. We had a couple of splice()
regressions that came in during the previous release as part of the
"get rid of set_fs()" development, but they were for odd cases that
most people would never notice. I think it's just that 5.10 is now
getting more widely deployed so people see the fallout from that
rather fundamental change in the last release.  And the only reason I
even reacted to those is just because I ended up being involved with
some of the tty patches during the early calm period of the past week.
There's a few more still pending.

But the bulk of it all is all the usual miscellaneous fixes all over
the place, and a lot of it is truly trivial one- or few-liners. Just
under half the patch is for drivers, with the rest being the usual mix
of tooling, arch updates, filesystem and core (mm, scheduling,
networking).

Nothing here makes me go "Uhhuh" in other words.

            Linus

---

Aaron Liu (1):
      drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3

Adrian Hunter (2):
      scsi: docs: ABI: sysfs-driver-ufs: Add DeepSleep power mode
      perf evlist: Fix id index for heterogeneous systems

Al Cooper (1):
      mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix errors in port-reset handling

Alban Bedel (1):
      net: mscc: ocelot: Fix multicast to the CPU port

Alex Leibovich (1):
      mmc: sdhci-xenon: fix 1.8v regulator stabilization

Alexander Guril (1):
      Kernel: fork.c: Fix coding style: Do not use {} around
single-line statements

Alexander Lobakin (2):
      PHY: Ingenic: fix unconditional build of phy-ingenic-usb
      skbuff: back tiny skbs with kmalloc() in __netdev_alloc_skb() too

Alexander Shishkin (1):
      intel_th: pci: Add Alder Lake-P support

Alexandru Ardelean (1):
      iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()

Andrey Konovalov (4):
      kasan, arm64: fix pointer tags in KASAN reports
      kasan: fix HW_TAGS boot parameters
      kasan, mm: fix conflicts with init_on_alloc/free
      kasan, mm: fix resetting page_alloc tags for HW_TAGS

Andrii Nakryiko (2):
      bpf: Allow empty module BTFs
      libbpf: Allow loading empty BTFs

Andy Lutomirski (2):
      x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
      x86/mmx: Use KFPU_387 for MMX string operations

Andy Shevchenko (1):
      sh: Drop ARCH_NR_GPIOS definition

Anshuman Gupta (2):
      drm/i915/hdcp: Update CP property in update_pipe
      drm/i915/hdcp: Get conn while content_type changed

Aric Cyr (1):
      drm/amd/display: Allow PSTATE chnage when no displays are enabled

Arnd Bergmann (4):
      phy: mediatek: allow compile-testing the dsi phy
      scsi: megaraid_sas: Fix MEGASAS_IOC_FIRMWARE regression
      crypto: omap-sham - Fix link error without crypto-engine
      ubsan: disable unsigned-overflow check for i386

Arnold Gozum (1):
      platform/x86: intel-vbtn: Support for tablet mode on Dell Inspiron 73=
52

Baruch Siach (1):
      gpio: mvebu: fix pwm .get_state period calculation

Billy Tsai (1):
      pinctrl: aspeed: g6: Fix PWMG0 pinctrl setting

Bing Guo (1):
      drm/amd/display: Change function decide_dp_link_settings to
avoid infinite looping

Bj=C3=B6rn T=C3=B6pel (1):
      MAINTAINERS: Update my email address

Bongsu Jeon (1):
      net: nfc: nci: fix the wrong NCI_CORE_INIT parameters

Borislav Petkov (1):
      x86/topology: Make __max_die_per_package available unconditionally

Brian King (1):
      scsi: ibmvfc: Set default timeout to avoid crash during migration

Chaitanya Kulkarni (1):
      nvmet: set right status on error in id-ns handler

Chao Leng (2):
      nvme-rdma: avoid request double completion for concurrent
nvme_rdma_timeout
      nvme-tcp: avoid request double completion for concurrent nvme_tcp_tim=
eout

Chris Chiu (1):
      ALSA: hda/realtek - Limit int mic boost on Acer Aspire E5-575T

Chris Wilson (2):
      drm/i915/gt: Prevent use of engine->wa_ctx after error
      drm/i915: Check for rq->hwsp validity after acquiring RCU lock

Christian K=C3=B6nig (1):
      drm/ttm: stop using GFP_TRANSHUGE_LIGHT

Christoph Hellwig (6):
      sh: remove CONFIG_IDE from most defconfig
      nvme-pci: refactor nvme_unmap_data
      nvme-pci: fix error unwind in nvme_map_data
      kernfs: implement ->read_iter
      kernfs: implement ->write_iter
      kernfs: wire up ->splice_read and ->splice_write

Christophe Leroy (1):
      spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set in spi->mod=
e

Chuck Lever (1):
      SUNRPC: Move the svc_xdr_recvfrom tracepoint again

Chunguang Xu (1):
      timekeeping: Remove unused get_seconds()

Cong Wang (1):
      cls_flower: call nla_ok() before nla_next()

Dan Carpenter (2):
      iio: sx9310: Off by one in sx9310_read_thresh()
      net: dsa: b53: fix an off by one in checking "vlan->vid"

Dan Williams (1):
      mm: fix page reference leak in soft_offline_page()

Daniel Borkmann (1):
      bpf: Fix signed_{sub,add32}_overflows type handling

Daniel Latypov (4):
      Documentation: kunit: include example of a parameterized test
      kunit: tool: surface and address more typing issues
      kunit: tool: fix minor typing issue with None status
      kunit: tool: move kunitconfig parsing into __init__, make it optional

Daniel Vetter (1):
      drm/syncobj: Fix use-after-free

David Gow (1):
      kunit: tool: Fix spelling of "diagnostic" in kunit_parser

David Lechner (1):
      counter:ti-eqep: remove floor

David Sterba (1):
      btrfs: no need to run delayed refs after commit_fs_roots during commi=
t

Dexuan Cui (1):
      x86/hyperv: Initialize clockevents after LAPIC is initialized

Dinghao Liu (1):
      scsi: fnic: Fix memleak in vnic_dev_init_devcmd2

Douglas Anderson (4):
      pinctrl: qcom: Allow SoCs to specify a GPIO function that's not 0
      pinctrl: qcom: No need to read-modify-write the interrupt status
      pinctrl: qcom: Properly clear "intr_ack_high" interrupts when unmaski=
ng
      pinctrl: qcom: Don't clear pending interrupts when enabling

Enke Chen (1):
      tcp: fix TCP_USER_TIMEOUT with zero window

Eric Biggers (1):
      fs: fix lazytime expiration handling in __writeback_single_inode()

Eric Dumazet (4):
      net_sched: reject silly cell_log in qdisc_get_rtab()
      net_sched: gen_estimator: support large ewma log
      net_sched: avoid shift-out-of-bounds in tcindex_set_parms()
      tcp: do not mess with cloned skbs in tcp_add_backlog()

Eugene Korenevsky (1):
      ehci: fix EHCI host controller initialization sequence

Fabio Estevam (1):
      Revert "i2c: imx: Remove unused .id_table support"

Felix Fietkau (3):
      mac80211: fix fast-rx encryption check
      mac80211: fix encryption key selection for 802.3 xmit
      mac80211: do not drop tx nulldata packets on encrypted links

Filipe Manana (1):
      btrfs: send: fix invalid clone operations when cloning from the
same file and root

Gayatri Kammela (1):
      x86/cpu: Add another Alder Lake CPU to the Intel family

Geert Uytterhoeven (7):
      platform/surface: SURFACE_PLATFORMS should depend on ACPI
      sh/intc: Restore devm_ioremap() alignment
      ntp: Fix RTC synchronization on 32-bit platforms
      mdio-bitbang: Export mdiobb_{read,write}()
      sh_eth: Make PHY access aware of Runtime PM to fix reboot crash
      openrisc: io: Add missing __iomem annotation to iounmap()
      sh_eth: Fix power down vs. is_opened flag ordering

Gilad Reti (2):
      bpf: Support PTR_TO_MEM{,_OR_NULL} register spilling
      selftests/bpf: Add verifier test for PTR_TO_MEM spill

Grant Grundler (1):
      net: usb: cdc_ncm: don't spew notifications

Greg Kroah-Hartman (1):
      Revert "driver core: Reorder devices on successful probe"

Guillaume Nault (2):
      udp: mask TOS bits in udp_v4_early_demux()
      netfilter: rpfilter: mask ecn bits before fib lookup

Hangbin Liu (1):
      selftests: net: fib_tests: remove duplicate log test

Hannes Reinecke (1):
      dm: avoid filesystem lookup in dm_get_dev_t()

Hans de Goede (4):
      platform/x86: touchscreen_dmi: Add swap-x-y quirk for Goodix
touchscreen on Estar Beauty HD tablet
      platform/x86: intel-vbtn: Drop HP Stream x360 Convertible PC 11
from allow-list
      platform/x86: hp-wmi: Don't log a warning on
HPWMI_RET_UNKNOWN_COMMAND errors
      ACPI: scan: Make acpi_bus_get_device() clear return pointer on error

Heikki Krogerus (1):
      platform/x86: i2c-multi-instantiate: Don't create platform
device for INT3515 ACPI nodes

Hsin-Yi Wang (1):
      pinctrl: mediatek: Fix fallback call path

Huacai Chen (1):
      irqchip/loongson-liointc: Fix build warnings

Huang Rui (1):
      drm/amdgpu: remove gpu info firmware of green sardine

Hyunwook (Wooky) Baek (1):
      x86/sev-es: Handle string port IO to kernel memory properly

Ignat Korchagin (1):
      dm crypt: fix copy and paste bug in crypt_alloc_req_aead

Ilan Peer (1):
      cfg80211: Save the regulatory domain with a lock

Ilya Dryomov (3):
      libceph: zero out session key and connection secret
      libceph, ceph: disambiguate ceph_connection_operations handlers
      libceph: fix "Boolean result is used in bitwise operation" warning

J. Bruce Fields (1):
      nfsd4: readdirplus shouldn't return parent of export

JC Kuo (1):
      xhci: tegra: Delay for disabling LFPS detector

Jaegeuk Kim (2):
      scsi: ufs: Fix livelock of ufshcd_clear_ua_wluns()
      scsi: ufs: Fix tm request when non-fatal error happens

Jake Wang (1):
      drm/amd/display: Update dram_clock_change_latency for DCN2.1

Jann Horn (1):
      signal: Add missing __user annotation to copy_siginfo_from_user_any

Javed Hasan (1):
      scsi: libfc: Avoid invoking response handler twice if ep is
already completed

Jeannie Stevenson (1):
      platform/x86: thinkpad_acpi: Add P53/73 firmware to
fan_quirk_table for dual fan control

Jens Axboe (4):
      task_work: unconditionally run task_work from get_signal()
      io_uring: iopoll requests should also wake task ->in_idle state
      io_uring: fix SQPOLL IORING_OP_CLOSE cancelation state
      io_uring: account io_uring internal files as REQ_F_INFLIGHT

Jiapeng Zhong (2):
      fs/cifs: Assign boolean values to a bool variable
      fs/cifs: Simplify bool comparison.

Jiaxun Yang (1):
      platform/x86: ideapad-laptop: Disable touchpad_switch for ELAN0634

Jin Yao (1):
      perf script: Fix overrun issue for dynamically-allocated PMU type num=
ber

Jinyang He (1):
      sh: Remove unused HAVE_COPY_THREAD_TLS macro

Jinzhou Su (1):
      drm/amdgpu: modify GCR_GENERAL_CNTL for Vangogh

Jiri Olsa (1):
      bpf: Prevent double bpf_prog_put call from bpf_tracing_prog_attach

Jisheng Zhang (1):
      mmc: sdhci-of-dwcmshc: fix rpmb access

Johannes Berg (1):
      cfg80211/mac80211: fix kernel-doc for SAR APIs

John Garry (4):
      driver core: platform: Add extra error check in
devm_platform_get_irqs_affinity()
      Driver core: platform: Add extra error check in
devm_platform_get_irqs_affinity()
      perf metricgroup: Fix for metrics containing duration_time
      perf metricgroup: Fix system PMU metrics

John Ogness (3):
      printk: ringbuffer: fix line counting
      printk: fix kmsg_dump_get_buffer length calulations
      printk: fix buffer overflow potential for print_text()

Josef Bacik (4):
      btrfs: don't get an EINTR during drop_snapshot for reloc
      btrfs: do not double free backref nodes on error
      btrfs: fix lockdep splat in btrfs_recover_relocation
      btrfs: don't clear ret in btrfs_start_dirty_block_groups

Josh Poimboeuf (3):
      objtool: Don't add empty symbols to the rbtree
      objtool: Don't fail the kernel build on fatal errors
      objtool: Don't fail on missing symbol table

KP Singh (3):
      bpf: Local storage helpers should check nullness of owner ptr passed
      bpf: Fix typo in bpf_inode_storage.c
      bpf: Update local storage test to check handling of null ptrs

Kai Vehmanen (2):
      ALSA: hda: Add AlderLake-P PCI ID and HDMI codec vid
      ASoC: SOF: Intel: fix page fault at probe if i915 init fails

Kai-Chuan Hsieh (1):
      ALSA: hda: Add Cometlake-R PCI ID

Kai-Heng Feng (4):
      ASoC: SOF: Intel: hda: Resume codec to do jack detection
      ASoC: SOF: Intel: hda: Modify existing helper to disable WAKEEN
      ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
      ALSA: hda: Balance runtime/system PM if direct-complete is disabled

Kent Gibson (3):
      gpiolib: cdev: fix frame size warning in gpio_ioctl()
      tools: gpio: fix %llu warning in gpio-event-mon.c
      tools: gpio: fix %llu warning in gpio-watch.c

Kirill Tkhai (1):
      crypto: xor - Fix divide error in do_xor_speed()

Klaus Jensen (1):
      nvme-pci: allow use of cmb on v1.4 controllers

Krzysztof Kozlowski (1):
      i2c: sprd: depend on COMMON_CLK to fix compile tests

Kuniyuki Iwashima (1):
      tcp: Fix potential use-after-free due to double kfree()

Lai Jiangshan (1):
      workqueue: Use cpu_possible_mask instead of cpu_active_mask to
break affinity

Lars-Peter Clausen (1):
      iio: ad5504: Fix setting power-down state

Lecopzer Chen (2):
      kasan: fix unaligned address is unhandled in kasan_remove_zero_shadow
      kasan: fix incorrect arguments passing in kasan_add_zero_shadow

Levi Yun (1):
      mm/memblock: Fix typo in comment of memblock_phys_alloc_try_nid()

Linus Torvalds (3):
      tty: implement write_iter
      tty: fix up hung_up_tty_write() conversion
      Linux 5.11-rc5

Longfang Liu (1):
      USB: ehci: fix an interrupt calltrace error

Lorenzo Bianconi (2):
      iio: common: st_sensors: fix possible infinite loop in
st_sensors_irq_thread
      mac80211: check if atf has been disabled in __ieee80211_schedule_txq

Lukas Bulwahn (1):
      scsi: docs: ABI: sysfs-driver-ufs: Rectify table formatting

Marc Zyngier (1):
      irqchip/bcm2836: Fix IPI acknowledgement after conversion to
handle_percpu_devid_irq

Mark Pearson (1):
      platform/x86: thinkpad_acpi: correct palmsensor error checking

Martin Blumenstingl (1):
      mtd: rawnand: intel: check the mtd name only after setting the variab=
le

Martin Wilck (1):
      scsi: scsi_transport_srp: Don't block target in failfast state

Mathias Kresin (1):
      irqchip/mips-cpu: Set IPI domain parent chip

Mathias Nyman (1):
      xhci: make sure TRB is fully written before giving it to the controll=
er

Matteo Croce (2):
      ipv6: create multicast route with RTPROT_KERNEL
      ipv6: set multicast flag on the multicast route

Mauro Carvalho Chehab (2):
      MAINTAINERS: update references to stm32 audio bindings
      cfg80211: fix a kerneldoc markup

Maxim Mikityanskiy (1):
      xsk: Clear pool even for inactive queues

Meng Li (1):
      drivers core: Free dma_range_map when driver probe failed

Michael Ellerman (1):
      selftests/powerpc: Only test lwm/stmw on big endian

Michael Hennerich (1):
      spi: cadence: cache reference clock rate during probe

Mika Westerberg (1):
      thunderbolt: Drop duplicated 0x prefix from format string

Mike Rapoport (3):
      ia64: fix build failure caused by memory model changes
      x86/setup: don't remove E820_TYPE_RAM for pfn 0
      mm: fix initialization of struct page for holes in memory layout

Mikko Perttunen (2):
      i2c: tegra: Wait for config load atomically while in ISR
      i2c: bpmp-tegra: Ignore unknown I2C_M flags

Mikulas Patocka (2):
      dm integrity: fix a crash if "recalculate" used without "internal_has=
h"
      dm integrity: conditionally disable "recalculate" feature

Miquel Raynal (3):
      mtd: rawnand: nandsim: Fix the logic when selecting Hamming soft
ECC engine
      mtd: spinand: Fix MTD_OPS_AUTO_OOB requests
      mtd: rawnand: omap: Use BCH private fields in the specific OOB layout

Mircea Cirjaliu (1):
      bpf: Fix helper bpf_map_peek_elem_proto pointing to wrong callback

Nathan Chancellor (2):
      pinctrl: nomadik: Remove unused variable in nmk_gpio_dbg_show_one
      MAINTAINERS: add a couple more files to the Clang/LLVM section

Necip Fazil Yildiran (1):
      sh: dma: fix kconfig dependency for G2_DMA

Nicholas Kazlauskas (1):
      drm/amd/display: Use hardware sequencer functions for PG control

Nicholas Piggin (1):
      powerpc/64s: fix scv entry fallback flush vs interrupt

Nicolas Saenz Julienne (1):
      drm/vc4: Unify PCM card's driver_name

Nikita Shubin (1):
      gpiolib: add a warning on gpiochip->to_irq defined

Oded Gabbay (5):
      habanalabs: fix dma_addr passed to dma_mmap_coherent
      habanalabs: fix reset process in case of failures
      habanalabs: prevent soft lockup during unmap
      habanalabs: fix backward compatibility of idle check
      habanalabs: disable FW events on device removal

Ofir Bitton (1):
      habanalabs: zero pci counters packet before submit to FW

Oleksandr Mazur (1):
      net: core: devlink: use right genl user_ptr when handling port
param get/set

Pali Roh=C3=A1r (1):
      serial: mvebu-uart: fix tx lost characters at power off

Pan Bian (3):
      drm/atomic: put state on error path
      net: systemport: free dev before on error path
      lightnvm: fix memory leak when submit fails

Patrik Jakobsson (1):
      usb: bdc: Make bdc pci driver depend on BROKEN

Paul Cercueil (2):
      pinctrl: ingenic: Fix JZ4760 support
      pinctrl: ingenic: Rename registers from JZ4760_GPIO_* to JZ4770_GPIO_=
*

Pavel Begunkov (5):
      io_uring: fix false positive sqo warning on flush
      io_uring: fix uring_flush in exit_files() warning
      io_uring: fix skipping disabling sqo on exec
      io_uring: fix short read retries for non-reg files
      io_uring: fix sleeping under spin in __io_clean_op

Peter Chen (4):
      usb: cdns3: imx: fix writing read-only memory issue
      usb: cdns3: imx: fix can't create core device the second time issue
      usb: cdns3: imx: improve driver .remove API
      MAINTAINERS: update Peter Chen's email address

Peter Collingbourne (1):
      mmc: core: don't initialize block size from ext_csd if not present

Peter Zijlstra (13):
      x86/entry: Fix noinstr fail
      x86/sev: Fix nonistr violation
      locking/lockdep: Cure noinstr fail
      locking/lockdep: Avoid noinstr warning for DEBUG_LOCKDEP
      x86/mce: Remove explicit/superfluous tracing
      x86: __always_inline __{rd,wr}msr()
      sched: Don't run cpu-online with balance_push() enabled
      kthread: Extract KTHREAD_IS_PER_CPU
      workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
      workqueue: Restrict affinity change to rescuer
      sched: Prepare to use balance_push in ttwu()
      sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
      sched: Relax the set_cpus_allowed_ptr() semantics

Prike Liang (1):
      drm/amdgpu/pm: no need GPU status set since
mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL added in FSDL

Qais Yousef (1):
      arm64: kprobes: Fix Uexpected kernel BRK exception at EL1

Qinglang Miao (2):
      sh: intc: Convert to DEFINE_SHOW_ATTRIBUTE
      sh: mm: Convert to DEFINE_SHOW_ATTRIBUTE

Rafael J. Wysocki (2):
      x86: PM: Register syscore_ops for scale invariance
      driver core: Extend device_is_dependent()

Randy Dunlap (5):
      platform/surface: surface_gpe: Fix non-PM_SLEEP build warnings
      arch/sh: hyphenate Non-Uniform in Kconfig prompt
      scsi: ufs: ufshcd-pltfrm depends on HAS_IOMEM
      x86/xen: fix 'nopvspin' build error
      gpio: sifive: select IRQ_DOMAIN_HIERARCHY rather than depend on it

Rasmus Villemoes (1):
      net: dsa: mv88e6xxx: also read STU state in mv88e6250_g1_vtu_getnext

Revanth Rajashekar (1):
      nvme: check the PRINFO bit before deciding the host buffer length

Ricky Wu (1):
      misc: rtsx: init value of aspm_enabled

Roger Quadros (1):
      MAINTAINERS: Update address for Cadence USB3 driver

Roman Gushchin (1):
      mm: memcg/slab: optimize objcg stock draining

Ronnie Sahlberg (1):
      cifs: do not fail __smb_send_rqst if non-fatal signals are pending

Ryan Chen (1):
      usb: gadget: aspeed: fix stop dma register setting.

Sandipan Das (1):
      selftests/powerpc: Fix exit status of pkey tests

Saravana Kannan (1):
      driver core: Fix device link device name collision

Sean Nyekjaer (1):
      mtd: rawnand: gpmi: fix dst bit offset when extracting raw payload

Shakeel Butt (2):
      mm: memcg: fix memcg file_dirty numa stat
      mm: fix numa stats for thp migration

Shayne Chen (1):
      mac80211: fix incorrect strlen of .write in debugfs

Shin'ichiro Kawasaki (1):
      scsi: target: tcmu: Fix use-after-free of se_cmd->priv

Shyam Sundar S K (1):
      platform/x86: amd-pmc: Fix CONFIG_DEBUG_FS check

Slaveyko Slaveykov (1):
      drivers: iio: temperature: Add delay after the addressed reset
command in mlx90632.c

Song Liu (1):
      bpf: Reject too big ctx_size_in for raw_tp test run

Sowjanya Komatineni (1):
      i2c: tegra: Create i2c_writesl_vi() to use with VI I2C for filling TX=
 FIFO

Srinivas Kandagatla (2):
      MAINTAINERS: update maintainers of qcom audio
      MAINTAINERS: update qcom ASoC drivers list

Srinivas Pandruvada (2):
      tools/power/x86/intel-speed-select: Set scaling_max_freq to base_freq=
uency
      tools/power/x86/intel-speed-select: Set higher of
cpuinfo_max_freq or base_frequency

Stafford Horne (1):
      soc: litex: Fix compile warning when device tree is not configured

Stanislav Fomichev (1):
      bpf: Don't leak memory in bpf getsockopt when optlen =3D=3D 0

Stephan Gerhold (2):
      ASoC: hdmi-codec: Fix return value in hdmi_codec_set_jack()
      dt-bindings: iio: accel: bma255: Fix bmc150/bmi055 compatible

Stephen Boyd (1):
      iio: sx9310: Fix semtech,avg-pos-strength setting when > 16

Suman Anna (1):
      irqchip/pruss: Simplify the TI_PRUSS_INTC Kconfig

Sung Lee (1):
      drm/amd/display: DCN2X Find Secondary Pipe properly in MPO + ODM Case

Takashi Iwai (8):
      ALSA: usb-audio: Always apply the hw constraints for implicit fb sync
      ALSA: hda/via: Add minimum mute flag
      ALSA: seq: oss: Fix missing error check in snd_seq_oss_synth_make_inf=
o()
      ALSA: usb-audio: Fix UAC1 rate setup for secondary endpoints
      ALSA: usb-audio: Set sample rate for all sharing EPs on UAC1
      ALSA: usb-audio: Avoid implicit feedback on Pioneer devices
      cachefiles: Drop superfluous readpages aops NULL check
      ALSA: usb-audio: Fix hw constraints dependencies

Tariq Toukan (1):
      net: Disable NETIF_F_HW_TLS_RX when RXCSUM is disabled

Thierry Reding (1):
      gpio: tegra: Add missing dependencies

Thinh Nguyen (1):
      usb: udc: core: Use lock when write to soft_connect

Thomas Gleixner (5):
      genirq: Export irq_check_status_bit()
      sparc/mm/highmem: flush cache and TLB
      mm/highmem: prepare for overriding set_pte_at()
      mips/mm/highmem: use set_pte() for kmap_local()
      powerpc/mm/highmem: use __set_pte_at() for kmap_local()

Thomas Zimmermann (1):
      drm/vram-helper: Reuse existing page mappings in vmap

Tianjia Zhang (1):
      X.509: Fix crash caused by NULL pointer

Tony Lindgren (1):
      phy: cpcap-usb: Fix warning for missing regulator_disable

Tvrtko Ursulin (1):
      drm/i915/pmu: Don't grab wakeref when enabling events

Tyrel Datwyler (1):
      scsi: ibmvfc: Fix missing cast of ibmvfc_event pointer to u64 handle

Valentin Schneider (1):
      sched/core: Print out straggler tasks in sched_cpu_dying()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Only enable DFP 4:4:4->4:2:0 conversion when
outputting YCbCr 4:4:4

Vincent Mailhol (3):
      can: dev: can_restart: fix use after free bug
      can: vxcan: vxcan_xmit: fix use after free bug
      can: peak_usb: fix use after free bugs

Vladimir Oltean (1):
      net: mscc: ocelot: allow offloading of bridge on top of LAG

Vladimir Stempen (1):
      drm/amd/display: Fixed corruptions on HPDRX link loss restore

Wang Hui (1):
      stm class: Fix module init return on allocation failure

Wang Qing (2):
      arch: sh: remove duplicate include
      sh: mach-sh03: remove duplicate include

Wolfram Sang (1):
      i2c: octeon: check correct size of maximum RECV_LEN packet

Xiao Ni (1):
      md: Set prev_flush_start and flush_bio in an atomic way

Xiaoming Ni (1):
      proc_sysctl: fix oops caused by incorrect command parameters

Yanfei Xu (1):
      kthread: remove comments about old _do_fork() helper

Yazen Ghannam (1):
      x86/cpu/amd: Set __max_die_per_package on AMD

Yingjie Wang (1):
      octeontx2-af: Fix missing check bugs in rvu_cgx.c

Yuchung Cheng (1):
      tcp: fix TCP socket rehash stats mis-accounting

Zenghui Yu (1):
      genirq/msi: Initialize msi_alloc_info before calling
msi_domain_prepare_irqs()

Zheng Yongjun (1):
      irqchip/irq-sl28cpld: Convert comma to semicolon

lianzhi chang (1):
      udf: fix the problem that the disc content is not displayed
