Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADD42D9F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440894AbgLNSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440379AbgLNS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:29:38 -0500
From:   Catalin Marinas <catalin.marinas@arm.com>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.11
Date:   Mon, 14 Dec 2020 18:28:54 +0000
Message-Id: <20201214182854.14862-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the 5.11 updates from the arm64 tree (I expect the in-kernel
MTE + KASAN changes to come via Andrew Morton). The "arm64: expose
FAR_EL1 tag bits in siginfo" patch is based on some preparatory signal
patches queued via Eric's tree but they appear in the diffstat here as
well. Nothing major otherwise: set_fs() removal, ZONE_DMA defaulting to
32-bit, CPPC FFH support using AMU counters, PMU driver for the ARM
DMC-620 memory controller, switch to vmapped shadow call stacks.

Since the git request-pull diffstat is all over the place (I had to
merge a KVM fix for 64K pages based on v5.9-rc4), I did a local merge
against v5.10 and re-generated the diffstat below.

Thanks.

The following changes since commit 9e5344e0ffc33f4fee899f98b6939a0682b1d9c3:

  arm64: mte: Fix typo in macro definition (2020-11-30 17:36:52 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to d889797530c66f699170233474eab3361471e808:

  Merge remote-tracking branch 'arm64/for-next/fixes' into for-next/core (2020-12-09 18:04:55 +0000)

----------------------------------------------------------------
arm64 updates for 5.11:

- Expose tag address bits in siginfo. The original arm64 ABI did not
  expose any of the bits 63:56 of a tagged address in siginfo. In the
  presence of user ASAN or MTE, this information may be useful. The
  implementation is generic to other architectures supporting tags (like
  SPARC ADI, subject to wiring up the arch code). The user will have to
  opt in via sigaction(SA_EXPOSE_TAGBITS) so that the extra bits, if
  available, become visible in si_addr.

- Default to 32-bit wide ZONE_DMA. Previously, ZONE_DMA was set to the
  lowest 1GB to cope with the Raspberry Pi 4 limitations, to the
  detriment of other platforms. With these changes, the kernel scans the
  Device Tree dma-ranges and the ACPI IORT information before deciding
  on a smaller ZONE_DMA.

- Strengthen READ_ONCE() to acquire when CONFIG_LTO=y. When building
  with LTO, there is an increased risk of the compiler converting an
  address dependency headed by a READ_ONCE() invocation into a control
  dependency and consequently allowing for harmful reordering by the
  CPU.

- Add CPPC FFH support using arm64 AMU counters.

- set_fs() removal on arm64. This renders the User Access Override (UAO)
  ARMv8 feature unnecessary.

- Perf updates: PMU driver for the ARM DMC-620 memory controller, sysfs
  identifier file for SMMUv3, stop event counters support for i.MX8MP,
  enable the perf events-based hard lockup detector.

- Reorganise the kernel VA space slightly so that 52-bit VA
  configurations can use more virtual address space.

- Improve the robustness of the arm64 memory offline event notifier.

- Pad the Image header to 64K following the EFI header definition
  updated recently to increase the section alignment to 64K.

- Support CONFIG_CMDLINE_EXTEND on arm64.

- Do not use tagged PC in the kernel (TCR_EL1.TBID1==1), freeing up 8
  bits for PtrAuth.

- Switch to vmapped shadow call stacks.

- Miscellaneous clean-ups.

----------------------------------------------------------------
Anshuman Khandual (4):
      arm64/smp: Drop the macro S(x,s)
      arm64/mm/hotplug: Register boot memory hot remove notifier earlier
      arm64/mm/hotplug: Enable MEM_OFFLINE event handling
      arm64/mm/hotplug: Ensure early memory sections are all online

Ard Biesheuvel (10):
      arm64: mm: extend linear region for 52-bit VA configurations
      arm64: mm: make vmemmap region a projection of the linear region
      arm64: mm: tidy up top of kernel VA space
      Documentation/arm64: fix RST layout of memory.rst
      arm64: mm: account for hotplug memory when randomizing the linear region
      arm64: mm: don't assume struct page is always 64 bytes
      arm64: omit [_text, _stext) from permanent kernel mapping
      arm64/head: avoid symbol names pointing into first 64 KB of kernel image
      arm64: head: tidy up the Image header definition
      arm64: mm: Set ZONE_DMA size based on early IORT scan

Catalin Marinas (9):
      arm64: Ignore any DMA offsets in the max_zone_phys() calculation
      arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required
      of: unittest: Fix build on architectures without CONFIG_OF_ADDRESS
      Merge branches 'for-next/kvm-build-fix', 'for-next/va-refactor', 'for-next/lto', 'for-next/mem-hotplug', 'for-next/cppc-ffh', 'for-next/pad-image-header', 'for-next/zone-dma-default-32-bit', 'for-next/signal-tag-bits' and 'for-next/cmdline-extended' into for-next/core
      Merge branch 'for-next/uaccess' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge remote-tracking branch 'arm64/for-next/scs' into for-next/core
      Merge remote-tracking branch 'arm64/for-next/fixes' into for-next/core

Helge Deller (1):
      parisc: Drop parisc special case for __sighandler_t

Ionela Voinescu (4):
      arm64: wrap and generalise counter read functions
      arm64: split counter validation function
      arm64: implement CPPC FFH support using AMUs
      arm64: abort counter_read_on_cpu() when irqs_disabled()

Joakim Zhang (3):
      perf/imx_ddr: Add stop event counters support for i.MX8MP
      bindings: perf: imx-ddr: add compatible string
      perf/imx_ddr: Add system PMU identifier for userspace

John Garry (2):
      drivers/perf: hisi: Add identifier sysfs file
      perf/smmuv3: Support sysfs identifier file

Mark Rutland (19):
      arm64: uaccess: move uao_* alternatives to asm-uaccess.h
      arm64: consistently use reserved_pg_dir
      arm64: ensure ERET from kthread is illegal
      arm64: add C wrappers for SET_PSTATE_*()
      arm64: head.S: rename el2_setup -> init_kernel_el
      arm64: head.S: cleanup SCTLR_ELx initialization
      arm64: head.S: always initialize PSTATE
      arm64: sdei: move uaccess logic to arch/arm64/
      arm64: sdei: explicitly simulate PAN/UAO entry
      arm64: uaccess: rename privileged uaccess routines
      arm64: uaccess: simplify __copy_user_flushcache()
      arm64: uaccess: refactor __{get,put}_user
      arm64: uaccess: split user/kernel routines
      arm64: uaccess cleanup macro naming
      arm64: uaccess: remove set_fs()
      arm64: uaccess: remove addr_limit_user_check()
      arm64: uaccess: remove redundant PAN toggling
      arm64: uaccess: remove vestigal UAO support
      arm64: mark __system_matches_cap as __maybe_unused

Masami Hiramatsu (1):
      arm64: kprobes: Remove redundant kprobe_step_ctx

Nicolas Saenz Julienne (6):
      arm64: mm: Move reserve_crashkernel() into mem_init()
      arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
      of/address: Introduce of_dma_get_max_cpu_address()
      of: unittest: Add test for of_dma_get_max_cpu_address()
      arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
      mm: Remove examples from enum zone_type comment

Peter Collingbourne (10):
      arm64: mte: optimize asynchronous tag check fault flag check
      parisc: start using signal-defs.h
      arch: move SA_* definitions to generic headers
      signal: clear non-uapi flag bits when passing/returning sa_flags
      arch: provide better documentation for the arch-specific SA_* flags
      signal: define the SA_UNSUPPORTED bit in sa_flags
      signal: define the SA_EXPOSE_TAGBITS bit in sa_flags
      arm64: expose FAR_EL1 tag bits in siginfo
      kasan: arm64: set TCR_EL1.TBID1 when enabled
      arm64: mte: fix prctl(PR_GET_TAGGED_ADDR_CTRL) if TCF0=NONE

Sami Tolvanen (2):
      scs: switch to vmapped shadow stacks
      arm64: scs: use vmapped IRQ and SDEI shadow stacks

Sudarshan Rajagopalan (1):
      arm64/mm: add fallback option to allocate virtually contiguous memory

Sumit Garg (1):
      arm64: Enable perf events based hard lockup detector

Tuan Phan (1):
      driver/perf: Add PMU driver for the ARM DMC-620 memory controller

Tyler Hicks (2):
      arm64: kaslr: Refactor early init command line parsing
      arm64: Extend the kernel command line from the bootloader

Wang Qing (1):
      perf: remove duplicate check on fwnode

Will Deacon (6):
      arm64: alternatives: Split up alternative.h
      arm64: cpufeatures: Add capability for LDAPR instruction
      arm64: alternatives: Remove READ_ONCE() usage during patch operation
      arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y
      arm64: sdei: Push IS_ENABLED() checks down to callee functions
      arm64: Fix build failure when HARDLOCKUP_DETECTOR_PERF is enabled

Youling Tang (1):
      arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*

 Documentation/arm64/kasan-offsets.sh               |   3 +-
 Documentation/arm64/memory.rst                     |  45 +-
 Documentation/arm64/tagged-pointers.rst            |  25 +-
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   3 +
 arch/alpha/include/uapi/asm/signal.h               |  14 -
 arch/arm/include/asm/signal.h                      |   2 +
 arch/arm/include/uapi/asm/signal.h                 |  27 +-
 arch/arm64/Kconfig                                 |  70 +-
 .../asm/{alternative.h => alternative-macros.h}    |  93 +--
 arch/arm64/include/asm/alternative.h               | 267 +-------
 arch/arm64/include/asm/asm-uaccess.h               |  35 +-
 arch/arm64/include/asm/cpucaps.h                   |   5 +-
 arch/arm64/include/asm/cpufeature.h                |  23 +-
 arch/arm64/include/asm/exception.h                 |   2 +-
 arch/arm64/include/asm/exec.h                      |   1 -
 arch/arm64/include/asm/futex.h                     |   8 +-
 arch/arm64/include/asm/insn.h                      |   3 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   6 -
 arch/arm64/include/asm/kprobes.h                   |   7 -
 arch/arm64/include/asm/memory.h                    |  22 +-
 arch/arm64/include/asm/mmu_context.h               |   6 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |   1 +
 arch/arm64/include/asm/pgtable.h                   |   3 +-
 arch/arm64/include/asm/processor.h                 |   4 +-
 arch/arm64/include/asm/ptrace.h                    |   8 +-
 arch/arm64/include/asm/rwonce.h                    |  73 ++
 arch/arm64/include/asm/signal.h                    |  25 +
 arch/arm64/include/asm/sysreg.h                    |  22 +-
 arch/arm64/include/asm/system_misc.h               |   2 +-
 arch/arm64/include/asm/thread_info.h               |  10 +-
 arch/arm64/include/asm/topology.h                  |   4 +-
 arch/arm64/include/asm/traps.h                     |   6 +-
 arch/arm64/include/asm/uaccess.h                   | 178 +++--
 arch/arm64/kernel/Makefile                         |   1 -
 arch/arm64/kernel/alternative.c                    |   7 +-
 arch/arm64/kernel/armv8_deprecated.c               |   4 +-
 arch/arm64/kernel/asm-offsets.c                    |   3 +-
 arch/arm64/kernel/cpufeature.c                     |  59 +-
 arch/arm64/kernel/debug-monitors.c                 |   5 +-
 arch/arm64/kernel/efi-header.S                     |  84 ++-
 arch/arm64/kernel/entry-common.c                   |   2 -
 arch/arm64/kernel/entry.S                          |  31 +-
 arch/arm64/kernel/head.S                           |  70 +-
 arch/arm64/kernel/irq.c                            |  21 +
 arch/arm64/kernel/kaslr.c                          |  26 +-
 arch/arm64/kernel/mte.c                            |   3 +-
 arch/arm64/kernel/perf_event.c                     |  41 +-
 arch/arm64/kernel/probes/kprobes.c                 |  53 +-
 arch/arm64/kernel/process.c                        |  29 +-
 arch/arm64/kernel/proton-pack.c                    |   5 +-
 arch/arm64/kernel/ptrace.c                         |   7 +-
 arch/arm64/kernel/scs.c                            |  16 -
 arch/arm64/kernel/sdei.c                           | 119 +++-
 arch/arm64/kernel/setup.c                          |   6 +-
 arch/arm64/kernel/signal.c                         |   3 -
 arch/arm64/kernel/sleep.S                          |   2 +-
 arch/arm64/kernel/smp.c                            |  15 +-
 arch/arm64/kernel/suspend.c                        |   1 -
 arch/arm64/kernel/sys_compat.c                     |   5 +-
 arch/arm64/kernel/syscall.c                        |   2 +-
 arch/arm64/kernel/topology.c                       | 136 +++-
 arch/arm64/kernel/traps.c                          |  29 +-
 arch/arm64/kernel/vdso/Makefile                    |   2 +-
 arch/arm64/kernel/vdso32/Makefile                  |   2 +-
 arch/arm64/kernel/vmlinux.lds.S                    |  12 +-
 arch/arm64/lib/clear_user.S                        |   8 +-
 arch/arm64/lib/copy_from_user.S                    |   8 +-
 arch/arm64/lib/copy_in_user.S                      |  16 +-
 arch/arm64/lib/copy_to_user.S                      |   8 +-
 arch/arm64/lib/mte.S                               |   6 +-
 arch/arm64/lib/uaccess_flushcache.c                |   4 +-
 arch/arm64/mm/fault.c                              |  88 +--
 arch/arm64/mm/init.c                               |  56 +-
 arch/arm64/mm/mmu.c                                | 149 +++-
 arch/arm64/mm/proc.S                               |   6 +-
 arch/h8300/include/uapi/asm/signal.h               |  24 -
 arch/ia64/include/uapi/asm/signal.h                |  24 -
 arch/m68k/include/uapi/asm/signal.h                |  24 -
 arch/mips/include/uapi/asm/signal.h                |  12 -
 arch/parisc/include/asm/signal.h                   |   2 +
 arch/parisc/include/uapi/asm/signal.h              |  34 +-
 arch/powerpc/include/uapi/asm/signal.h             |  24 -
 arch/s390/include/uapi/asm/signal.h                |  24 -
 arch/sparc/include/uapi/asm/signal.h               |   4 +-
 arch/x86/include/uapi/asm/signal.h                 |  24 -
 arch/x86/kernel/signal_compat.c                    |   7 -
 arch/xtensa/include/uapi/asm/signal.h              |  24 -
 drivers/acpi/arm64/iort.c                          |  55 ++
 drivers/firmware/arm_sdei.c                        |  14 -
 drivers/of/address.c                               |  42 ++
 drivers/of/unittest.c                              |  21 +
 drivers/perf/Kconfig                               |   7 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/arm_dmc620_pmu.c                      | 748 +++++++++++++++++++++
 drivers/perf/arm_dsu_pmu.c                         |   3 -
 drivers/perf/arm_pmu.c                             |   5 +
 drivers/perf/arm_smmuv3_pmu.c                      |  39 ++
 drivers/perf/fsl_imx8_ddr_perf.c                   | 135 +++-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |  16 +
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |  16 +
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |  16 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |  10 +
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |   7 +
 include/linux/acpi_iort.h                          |   4 +
 include/linux/mmzone.h                             |  20 -
 include/linux/of.h                                 |   7 +
 include/linux/perf/arm_pmu.h                       |   2 +
 include/linux/scs.h                                |  16 +-
 include/linux/signal.h                             |  14 +
 include/linux/signal_types.h                       |  12 +
 include/uapi/asm-generic/signal-defs.h             |  63 ++
 include/uapi/asm-generic/signal.h                  |  29 -
 kernel/scs.c                                       |  71 +-
 kernel/signal.c                                    |  40 ++
 114 files changed, 2392 insertions(+), 1401 deletions(-)
