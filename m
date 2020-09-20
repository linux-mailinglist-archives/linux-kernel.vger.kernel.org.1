Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574142718B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITXzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 19:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgITXze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:55:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1DC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 16:55:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so9611935ljm.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LuilMyCwF9ufGDtrKTIYSWPEZnv99UWuIG8ugmN+hEs=;
        b=F0dTp29vrj4qMTxRIqVi+dbv3lnAbcMO74OGKVCnXQAUYhSxh3tfVT0m5veoZEczKX
         vAWzcbWBTfeJcVQhuW6J9trlZoTEhQIJduc2tOHLyu//EAb41hg8nCW+JF7Xsfkecr0i
         B7g1Ush8PWDIb2yz0rN2liPqmSC+XZ1Ma+g0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LuilMyCwF9ufGDtrKTIYSWPEZnv99UWuIG8ugmN+hEs=;
        b=gXWcH0h5BDUoVQy7dmKMWN/JSm85TLQjY5QzPITuYJ71+cRGXBGloVsdrOXGezx7bZ
         /veopwAyMXc/dBnosaGKctZjrtnZSyS55lkdpfKAW+89h0FxsBpWIzADXqU0UdZkHbti
         aA8zd31VOuqqfHTKkciVdn2XFNeJ8bj2gnRv187dwQJqG+6L4ZBGA/EQ8epAh26I7t1R
         JN0i6bPmaNlaWdFk8CLKJIuQkA9BBXjqnn9FQFO/STLhw8vQQA+2M+lilrwVAmub7wyu
         3++5HnuH88OMpLvTBalmCOK3KVFROpBl0H+ZFSsMLLM45l4Arl1s8u9uphW+yf93X5ie
         28Og==
X-Gm-Message-State: AOAM533a0ZHMZINhxNUJapEQtpLAuS1ey1fgNX9BLbc2hQeLxc01sIpC
        eb9W1gFRmNd91GO2qpoPCUJTRhgLIhSWXw==
X-Google-Smtp-Source: ABdhPJws6iQBaaG6se5cXjtFOx6hj9XOkFAkw+E4lxUCGR4XhflNalUbbzn2Bct38O2CWKqFCpzIqw==
X-Received: by 2002:a2e:958:: with SMTP id 85mr16361543ljj.151.1600646132243;
        Sun, 20 Sep 2020 16:55:32 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k10sm2095984lfb.302.2020.09.20.16.55.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 16:55:31 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x69so12044930lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 16:55:31 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr16290653lfg.603.1600646130758;
 Sun, 20 Sep 2020 16:55:30 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 16:55:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
Message-ID: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
Subject: Linux 5.9-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another rc, and things look fairly normal: the diffstat
looks fairly flat (implying small changes) and we don't have any
unusual amount of activity.

The one thing that does show up in the diffstat is the softscroll
removal (both fbcon and vgacon), and there are people who want to save
that, but we'll see if some maintainer steps up. I'm not willing to
resurrect it in the broken form it was in, so I doubt that will happen
in 5.9, but we'll see what happens.

The other stats also look normal: about 60% of the patch is drivers
(and yes, the softscroll is a noticeable part, but not overwhelmingly
so - there's sound, gpu, mtd, i2c, usb etc). And the usual arch
updates, along with some vm fixes (including the fix for the
performance regression noted last rc) and perf tooling updates.

We also have a (test regression (not the performance one) in the VM
that we know about - the test that triggers this was admittedly buggy,
but if the test was buggy it is quite possible that real uses are
buggy too. We don't actually have any known case of any such real user
breakage, but we do have a nice fix for the test regression that is
very  much the RightThing(tm) to do in the long run, so that has been
actively discussed.

We know what the fix looks like, and a few initial patches have been
floating around, but a final patch doesn't exist yet, and depending on
how that goes this might be something that pushes out the final 5.9 by
a week. We'll see.

So there's still some development going on, but honestly, that VM case
is a very odd corner case that normal users should never hit, so it
should not keep anybody from testing this in the meantime.

Holler if you see anything odd,

                  Linus

---

Adrian Huang (1):
      dax: Fix stack overflow when mounting fsdax pmem device

Alexey Kardashevskiy (1):
      powerpc/dma: Fix dma_map_ops::get_required_mask

Amol Grover (1):
      device_cgroup: Fix RCU list debugging warning

Andrew Jones (1):
      arm64: paravirt: Initialize steal time when cpu is online

Andrey Grodzovsky (1):
      drm/amdgpu: Include sienna_cichlid in USBC PD FW support.

Aneesh Kumar K.V (2):
      powerpc/book3s64/radix: Fix boot failure with large amount of guest m=
emory
      powerpc/mm: Remove DEBUG_VM_PGTABLE support on powerpc

Ard Biesheuvel (1):
      efi: efibc: check for efivars write capability

Arnaldo Carvalho de Melo (2):
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers UAPI: update linux/in.h copy

Arvind Sankar (1):
      x86/boot/compressed: Disable relocation relaxation

Bhawanpreet Lakha (2):
      drm/amd/display: Don't use DRM_ERROR() for DTM add topology
      drm/amd/display: Don't log hdcp module warnings in dmesg

Borislav Petkov (2):
      EDAC/ghes: Clear scanned data on unload
      EDAC/ghes: Check whether the driver is on the safe list correctly

Brent Lu (1):
      ASoC: intel: atom: Add period size constraint

Byron Stanoszek (1):
      tmpfs: restore functionality of nr_inodes=3D0

Camel Guo (2):
      ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
      ASoC: tlv320adcx140: Wake up codec before accessing register

Cezary Rojewski (2):
      ASoC: Intel: haswell: Fix power transition refactor
      ASoC: core: Do not cleanup uninitialized dais on soc_pcm_open failure

Changbin Du (1):
      kcsan: kconfig: move to menu 'Generic Kernel Debugging Instruments'

Chris Wilson (4):
      drm/i915/gem: Delay tracking the GEM context until it is registered
      drm/i915/gem: Reduce context termination list iteration guard to RCU
      drm/i915: Be wary of data races when reading the active execlists
      drm/i915: Filter wake_flags passed to default_wake_function

Christian K=C3=B6nig (1):
      drm/radeon: revert "Prefer lower feedback dividers"

Christophe JAILLET (1):
      clk: davinci: Use the correct size when allocating memory

Christophe Leroy (1):
      selftests/vm: fix display of page size in map_hugetlb

Chun-Kuang Hu (1):
      drm/mediatek: Use CPU when fail to get cmdq event

Damien Le Moal (1):
      riscv: Fix Kendryte K210 device tree

Dan Carpenter (1):
      scsi: libsas: Fix error path in sas_notify_lldd_dev_found()

Dan Williams (1):
      dm/dax: Fix table reference counts

Daniel D=C3=ADaz (1):
      x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig

David Sharp (1):
      perf record: Set PERF_RECORD_PERIOD if attr->freq is set.

Dennis Li (2):
      drm/kfd: fix a system crash issue during GPU recovery
      drm/amdkfd: fix a memory leak issue

Dexuan Cui (1):
      Drivers: hv: vmbus: hibernation: do not hang forever in vmbus_bus_res=
ume()

Dinghao Liu (1):
      ASoC: qcom: common: Fix refcount imbalance on error

Eddie James (1):
      i2c: aspeed: Mask IRQ status to relevant bits

Filipe Manana (1):
      btrfs: fix wrong address when faulting in pages in the search ioctl

Gautham R. Shenoy (1):
      cpuidle: pseries: Fix CEDE latency conversion from tb to us

Greentime Hu (1):
      riscv: Add sfence.vma after early page table changes

Hans de Goede (3):
      ASoC: Intel: bytcr_rt5640: Add quirk for MPMAN Converter9 2-in-1
      Input: i8042 - add Entroware Proteus EL07R4 to nomux and reset lists
      i2c: core: Call i2c_acpi_install_space_handler() before
i2c_acpi_register_devices()

Harald Freudenberger (1):
      s390/zcrypt: fix kmalloc 256k failure

Heikki Krogerus (2):
      usb: typec: ucsi: acpi: Increase command completion timeout value
      usb: typec: ucsi: Prevent mode overrun

Henry Burns (1):
      perf vendor events amd: Remove trailing commas

Hou Tao (1):
      locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count

Hugh Dickins (4):
      ksm: reinstate memcg charge on copied pages
      mm: migration of hugetlbfs page skip memcg
      mm: fix check_move_unevictable_pages() on THP
      mlock: fix unevictable_pgs event counts on THP

Hui Wang (1):
      ALSA: hda/realtek - The Mic on a RedmiBook doesn't work

Ian Rogers (3):
      perf bench: Fix 2 memory sanitizer warnings
      perf record: Don't clear event's period if set by a term
      perf test: Leader sampling shouldn't clear sample period

Ilias Apalodimas (1):
      arm64: bpf: Fix branch offset in JIT

Ilya Leoshkevich (1):
      s390/init: add missing __init annotations

Jan Kara (1):
      dm: Call proper helper to determine dax support

Janosch Frank (1):
      s390: add 3f program exception handler

Jean Delvare (1):
      i2c: i801: Simplify the suspend callback

Jerome Brunet (1):
      ASoC: meson: axg-toddr: fix channel order on g12 platforms

Jiansong Chen (2):
      drm/amd/pm: support runtime pptable update for sienna_cichlid etc.
      drm/amdgpu: declare ta firmware for navy_flounder

Jing Xiangfeng (1):
      clk: qcom: lpass: Correct goto target in lpass_core_sc7180_probe()

Jiri Olsa (1):
      perf test: Fix the "signal" test inline assembly

Jitao Shi (1):
      drm/mediatek: dsi: Fix scrolling of panel with small hfp or hbp

Joao Martins (1):
      iommu/amd: Fix potential @entry null deref

Johan Hovold (2):
      serial: core: fix port-lock initialisation
      serial: core: fix console port-lock regression

Josh Poimboeuf (2):
      x86/unwind/fp: Fix FP unwinding in ret_from_fork
      objtool: Fix noreturn detection for ignored functions

Jun Lei (1):
      drm/amd/display: update nv1x stutter latencies

Kees Cook (2):
      core/entry: Report syscall correctly for trace and audit
      mailmap: add older email addresses for Kees Cook

Kuninori Morimoto (3):
      ASoC: pcm3168a: ignore 0 Hz settings
      ASoC: ti: fixup ams_delta_mute() function name
      ASoC: soc-core: add snd_soc_find_dai_with_mutex()

Leon Romanovsky (1):
      MAINTAINERS: Fix Max's and Shravan's emails

Linus Torvalds (6):
      fbcon: remove soft scrollback code
      fbcon: remove now unusued 'softback_lines' cursor() argument
      vgacon: remove software scrollback support
      mm: allow a controlled amount of unfairness in the page lock
      mm: fix wake_page_function() comment typos
      Linux 5.9-rc6

Luke D Jones (1):
      ALSA: hda: fixup headset for ASUS GX502 laptop

Madhusudanarao Amara (1):
      usb: typec: intel_pmc_mux: Handle SCU IPC error conditions

Marc Zyngier (1):
      arm64: Allow CPUs unffected by ARM erratum 1418040 to come in late

Masahiro Yamada (3):
      kconfig: qconf: use delete[] instead of delete to free array (again)
      kconfig: qconf: fix incomplete type 'struct gstr' warning
      kconfig: qconf: revive help message in the info view

Mateusz Gorski (1):
      ASoC: Intel: skl_hda_dsp_generic: Fix NULLptr dereference in
autosuspend delay

Matthias Schiffer (1):
      i2c: mxs: use MXS_DMA_CTRL_WAIT4END instead of DMA_CTRL_ACK

Maxime Ripard (1):
      clk: bcm: dvp: Select the reset framework

Michael Ellerman (2):
      selftests/powerpc: Skip PROT_SAO test in guests/LPARS
      Revert "powerpc/build: vdso linker warning for orphan sections"

Michael Kelley (1):
      Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload

Michel D=C3=A4nzer (1):
      drm/amdgpu/dc: Require primary plane to be enabled whenever the CRTC =
is

Mika Westerberg (1):
      thunderbolt: Retry DROM read once if parsing fails

Muchun Song (1):
      kprobes: fix kill kprobe which has been marked as gone

Namhyung Kim (10):
      perf test: Free aliases for PMU event map aliases test
      perf metric: Fix some memory leaks
      perf metric: Fix some memory leaks - part 2
      perf evlist: Fix cpu/thread map leak
      perf parse-event: Fix memory leak in evsel->unit
      perf test: Fix memory leaks in parse-metric test
      perf metric: Release expr_parse_ctx after testing
      perf metric: Free metric when it failed to resolve
      perf metric: Do not free metric when failed to resolve
      perf test: Free formats for perf pmu parse test

Nathan Chancellor (1):
      clk: rockchip: Fix initialization of mux_pll_src_4plls_p

Niklas Schnelle (1):
      s390/pci: fix leak of DMA tables on hard unplug

Oliver Neukum (2):
      USB: UAS: fix disconnect by unplugging a hub
      usblp: fix race between disconnect() and read()

Palmer Dabbelt (2):
      RISC-V: Take text_mutex in ftrace_init_nop()
      RISC-V: Resurrect the MMIO timer implementation for M-mode systems

Pavel Tatashin (1):
      mm/memory_hotplug: drain per-cpu pages again during memory offline

Penghao (1):
      USB: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for BYD
zhaoxin notebook

Peter Zijlstra (5):
      s390/idle: fix suspicious RCU usage
      ACPI: processor: Use CPUIDLE_FLAG_TIMER_STOP
      ACPI: processor: Use CPUIDLE_FLAG_TLB_FLUSHED
      cpuidle: Allow cpuidle drivers to take over RCU-idle
      ACPI: processor: Take over RCU-idle for C3-BM idle

Qi Liu (1):
      perf stat: Fix the ratio comments of miss-events

Qii Wang (2):
      i2c: mediatek: Fix generic definitions for bus frequency
      i2c: mediatek: Send i2c master code at more than 1MHz

Quentin Perret (1):
      ehci-hcd: Move include to keep CRC stable

Ralph Campbell (1):
      mm/thp: fix __split_huge_pmd_locked() for migration PMD

Rander Wang (1):
      ASoC: Intel: tgl_max98373: fix a runtime pm issue in multi-thread cas=
e

Ricardo Neri (1):
      powercap: RAPL: Add support for Lakefield

Rich Felker (2):
      sh: remove spurious circular inclusion from asm/smp.h
      sh: fix syscall tracing

Stephan Gerhold (1):
      ASoC: qcom: Set card->owner to avoid warnings

Stephane Eranian (1):
      perf record: Prevent override of attr->sample_period for libpfm4 even=
ts

Sumera Priyadarsini (1):
      clk: versatile: Add of_node_put() before return statement

Sunghyun Jin (1):
      percpu: fix first chunk size calculation for populated bitmap

Suravee Suthikulpanit (1):
      iommu/amd: Restore IRTE.RemapEn bit for amd_iommu_activate_guest_mode

Sven Schnelle (1):
      lockdep: fix order in trace_hardirqs_off_caller()

Sylwester Nawrocki (2):
      ASoC: wm8994: Skip setting of the WM8994_MICBIAS register for WM1811
      ASoC: wm8994: Ensure the device is resumed in wm89xx_mic_detect funct=
ions

Tetsuo Handa (1):
      fbcon: Fix user font detection test at fbcon_resize().

Thomas Bogendoerfer (2):
      MIPS: SNI: Fix MIPS_L1_CACHE_SHIFT
      MIPS: SNI: Fix spurious interrupts

Tobias Diedrich (1):
      serial: 8250_pci: Add Realtek 816a and 816b

Tobias Klauser (3):
      ftrace: let ftrace_enable_sysctl take a kernel pointer buffer
      stackleak: let stack_erasing_sysctl take a kernel pointer buffer
      fs/fs-writeback.c: adjust dirtytime_interval_handler definition
to match prototype

Vaibhav Jain (1):
      powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribu=
te

Vincent Huang (1):
      Input: trackpoint - add new trackpoint variant IDs

Vinod Koul (5):
      ASoC: max98373: Fix return check for devm_regmap_init_sdw()
      ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
      ASoC: rt711: Fix return check for devm_regmap_init_sdw()
      ASoC: rt715: Fix return check for devm_regmap_init_sdw()
      ASoC: rt700: Fix return check for devm_regmap_init_sdw()

Volker R=C3=BCmelin (1):
      i2c: i801: Fix resume bug

Wang Hai (1):
      drm/mediatek: Remove duplicated include

Yicong Yang (2):
      Revert "mtd: spi-nor: Disable the flash quad mode in spi_nor_restore(=
)"
      Revert "mtd: spi-nor: Add capability to disable flash quad mode"

Yu Kuai (4):
      drm/mediatek: Add missing put_device() call in mtk_ddp_comp_init()
      drm/mediatek: Add exception handing in mtk_drm_probe() if
component init fail
      drm/mediatek: Add missing put_device() call in mtk_drm_kms_init()
      drm/mediatek: Add missing put_device() call in mtk_hdmi_dt_parse_pdat=
a()

peterz@infradead.org (1):
      locking/lockdep: Fix "USED" <- "IN-NMI" inversions
