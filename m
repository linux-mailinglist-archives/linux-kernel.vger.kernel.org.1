Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2B288A80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgJIOQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgJIOQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:16:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 028DF2222C;
        Fri,  9 Oct 2020 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602252981;
        bh=Q8HtyUuOhcjg2Si12GAu9/V6VuqdBw3y71o5bcOHF4I=;
        h=Date:From:To:Cc:Subject:From;
        b=kcHk5FWdtpzIVzO9N1J2MHFaXZyKUSVkAkTyvjZoQ0uMuVkxyx/7E1AOXj9+yxjBN
         705l1V0VKeXGigiMKCjEruXhcvjsN3DtCtedmSL2XDnOJr1mZfaCYq5etfG5A0JVRf
         WVPRV++XY50e70H/L2uhWrp0JxVgJYWzMBY6TnBI=
Date:   Fri, 9 Oct 2020 15:16:16 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 5.10
Message-ID: <20201009141616.GA30637@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following arm64 updates for 5.10. There's quite a lot of
code here, but much of it is due to the addition of a new PMU driver as
well as some arm64-specific selftests which is an area where we've
traditionally been lagging a bit.

In terms of exciting features, this includes support for the Memory Tagging
Extension which narrowly missed 5.9, hopefully allowing userspace to run
with use-after-free detection in production on CPUs that support it. Work
is ongoing to integrate the feature with KASAN for 5.11. Another change
that I'm excited about (assuming they get the hardware right) is preparing
the ASID allocator for sharing the CPU page-table with the SMMU. Those
changes will also come in via Joerg with the IOMMU pull.

We do stray outside of our usual directories in a few places, mostly due
to core changes required by MTE. Although much of this has been Acked,
there were a couple of places where we unfortunately didn't get any review
feedback.

Other than that, we ran into a handful of minor conflicts in -next, but
nothing that should post any issues.

Full summary in the tag.

Cheers,

Will

P.S. I've renewed my pgp subkeys, so you may need to refetch from
pgpkeys.git in order to validate the tag. It was the usual painful
experience when my signatures suddenly started failing and I couldn't
figure out why...

--->8

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to d13027bb35e089bc1bb9f19c4976decf32a09b97:

  Revert "arm64: initialize per-cpu offsets earlier" (2020-10-09 11:24:17 +0100)

----------------------------------------------------------------
arm64 updates for 5.10

- Userspace support for the Memory Tagging Extension introduced by Armv8.5.
  Kernel support (via KASAN) is likely to follow in 5.11.

- Selftests for MTE, Pointer Authentication and FPSIMD/SVE context
  switching.

- Fix and subsequent rewrite of our Spectre mitigations, including the
  addition of support for PR_SPEC_DISABLE_NOEXEC.

- Support for the Armv8.3 Pointer Authentication enhancements.

- Support for ASID pinning, which is required when sharing page-tables with
  the SMMU.

- MM updates, including treating flush_tlb_fix_spurious_fault() as a no-op.

- Perf/PMU driver updates, including addition of the ARM CMN PMU driver and
  also support to handle CPU PMU IRQs as NMIs.

- Allow prefetchable PCI BARs to be exposed to userspace using normal
  non-cacheable mappings.

- Implementation of ARCH_STACKWALK for unwinding.

- Improve reporting of unexpected kernel traps due to BPF JIT failure.

- Improve robustness of user-visible HWCAP strings and their corresponding
  numerical constants.

- Removal of TEXT_OFFSET.

- Removal of some unused functions, parameters and prototypes.

- Removal of MPIDR-based topology detection in favour of firmware
  description.

- Cleanups to handling of SVE and FPSIMD register state in preparation
  for potential future optimisation of handling across syscalls.

- Cleanups to the SDEI driver in preparation for support in KVM.

- Miscellaneous cleanups and refactoring work.

----------------------------------------------------------------
Alexandru Elisei (1):
      arm64: perf: Add missing ISB in armv8pmu_enable_counter()

Amit Daniel Kachhap (12):
      arm64: kprobe: add checks for ARMv8.3-PAuth combined instructions
      arm64: traps: Allow force_signal_inject to pass esr error code
      arm64: ptrauth: Introduce Armv8.3 pointer authentication enhancements
      arm64: cpufeature: Modify address authentication cpufeature to exact
      arm64: kprobe: disable probe of fault prone ptrauth instruction
      arm64: kprobe: clarify the comment of steppable hint instructions
      kselftest/arm64: Add utilities and a test to validate mte memory
      kselftest/arm64: Verify mte tag inclusion via prctl
      kselftest/arm64: Check forked child mte memory accessibility
      kselftest/arm64: Verify all different mmap MTE options
      kselftest/arm64: Verify KSM page merge for MTE pages
      kselftest/arm64: Check mte tagged user address in kernel

Andre Przywara (1):
      arm64: random: Remove no longer needed prototypes

Anshuman Khandual (4):
      arm64/mm/ptdump: Add address markers for BPF regions
      arm64/mm: Change THP helpers to comply with generic MM semantics
      arm64/mm: Enable THP migration
      arm64/cpuinfo: Define HWCAP name arrays per their actual bit definitions

Ard Biesheuvel (1):
      arm64: get rid of TEXT_OFFSET

Boyan Karatotev (4):
      kselftests/arm64: add a basic Pointer Authentication test
      kselftests/arm64: add nop checks for PAuth tests
      kselftests/arm64: add PAuth test for whether exec() changes keys
      kselftests/arm64: add PAuth tests for single threaded consistency and differently initialized keys

Catalin Marinas (17):
      arm64: mte: Use Normal Tagged attributes for the linear map
      arm64: kvm: mte: Hide the MTE CPUID information from the guests
      mm: Preserve the PG_arch_2 flag in __split_huge_page_tail()
      arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE
      arm64: Avoid unnecessary clear_user_page() indirection
      arm64: mte: Tags-aware aware memcmp_pages() implementation
      arm64: mte: Add PROT_MTE support to mmap() and mprotect()
      mm: Introduce arch_validate_flags()
      arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
      mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
      arm64: mte: Allow user control of the tag check mode via prctl()
      arm64: mte: Allow user control of the generated random tags via prctl()
      arm64: mte: Restore the GCR_EL1 register after a suspend
      arm64: mte: Allow {set,get}_tagged_addr_ctrl() on non-current tasks
      arm64: mte: ptrace: Add PTRACE_{PEEK,POKE}MTETAGS support
      arm64: mte: ptrace: Add NT_ARM_TAGGED_ADDR_CTRL regset
      fs: Handle intra-page faults in copy_mount_options()

Clint Sbisa (1):
      arm64: Enable PCI write-combine resources under sysfs

Gavin Shan (17):
      arm64/mm: Remove CONT_RANGE_OFFSET
      arm64/mm: Unify CONT_PTE_SHIFT
      arm64/mm: Unify CONT_PMD_SHIFT
      arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
      firmware: arm_sdei: Remove sdei_is_err()
      firmware: arm_sdei: Common block for failing path in sdei_event_create()
      firmware: arm_sdei: Retrieve event number from event instance
      firmware: arm_sdei: Avoid nested statements in sdei_init()
      firmware: arm_sdei: Unregister driver on error in sdei_init()
      firmware: arm_sdei: Remove duplicate check in sdei_get_conduit()
      firmware: arm_sdei: Remove redundant error message in sdei_probe()
      firmware: arm_sdei: Remove while loop in sdei_event_register()
      firmware: arm_sdei: Remove while loop in sdei_event_unregister()
      firmware: arm_sdei: Cleanup on cross call function
      firmware: arm_sdei: Introduce sdei_do_local_call()
      firmware: arm_sdei: Remove _sdei_event_register()
      firmware: arm_sdei: Remove _sdei_event_unregister()

Jean-Philippe Brucker (2):
      arm64: mm: Pin down ASIDs for sharing mm with devices
      arm64: cpufeature: Export symbol read_sanitised_ftr_reg()

Julien Grall (6):
      arm64/fpsimd: Update documentation of do_sve_acc
      arm64/signal: Update the comment in preserve_sve_context
      arm64/fpsimdmacros: Introduce a macro to update ZCR_EL1.LEN
      arm64/fpsimdmacros: Allow the macro "for" to be used in more cases
      arm64/sve: Implement a helper to flush SVE registers
      arm64/sve: Implement a helper to load SVE registers from FPSIMD state

Julien Thierry (5):
      arm64: perf: Remove PMU locking
      arm64: perf: Defer irq_work to IPI_IRQ_WORK
      KVM: arm64: pmu: Make overflow handler NMI safe
      arm_pmu: Introduce pmu_irq_ops
      arm_pmu: arm64: Use NMIs for PMU

Kevin Brodsky (1):
      mm: Introduce arch_calc_vm_flag_bits()

Leo Yan (1):
      arm64: perf: Add general hardware LLC events for PMUv3

Marc Zyngier (8):
      arm64: Make use of ARCH_WORKAROUND_1 even when KVM is not enabled
      arm64: Run ARCH_WORKAROUND_1 enabling code on all CPUs
      arm64: Run ARCH_WORKAROUND_2 enabling code on all CPUs
      KVM: arm64: Set CSV2 for guests on hardware unaffected by Spectre-v2
      KVM: arm64: Simplify handling of ARCH_WORKAROUND_2
      KVM: arm64: Get rid of kvm_arm_have_ssbd()
      KVM: arm64: Convert ARCH_WORKAROUND_2 to arm64_get_spectre_v4_state()
      arm64: Get rid of arm64_ssbd_state

Mark Brown (10):
      selftests: arm64: Test case for enumeration of SVE vector lengths
      selftests: arm64: Add test for the SVE ptrace interface
      selftests: arm64: Add stress tests for FPSMID and SVE context switching
      selftests: arm64: Add utility to set SVE vector lengths
      selftests: arm64: Add wrapper scripts for stress tests
      selftests: arm64: Add build and documentation for FP tests
      stacktrace: Remove reliable argument from arch_stack_walk() callback
      arm64: stacktrace: Make stack walk callback consistent with generic code
      arm64: stacktrace: Convert to ARCH_STACKWALK
      arm64: Move console stack display code to stacktrace.c

Mark Rutland (2):
      arm64: perf: Avoid PMXEV* indirection
      arm64: initialize per-cpu offsets earlier

Mark Salter (2):
      drivers/perf: xgene_pmu: Fix uninitialized resource struct
      drivers/perf: thunderx2_pmu: Fix memory resource error handling

Pingfan Liu (2):
      arm64/relocate_kernel: remove redundant code
      Documentation/kvm/arm: improve description of HVC_SOFT_RESTART

Qi Liu (1):
      arm64: perf: Remove unnecessary event_idx check

Robin Murphy (2):
      perf: Add Arm CMN-600 DT binding
      perf: Add Arm CMN-600 PMU driver

Shaokun Zhang (2):
      drivers/perf: hisi: Add missing include of linux/module.h
      arm64: perf: Add support caps under sysfs

Steven Price (4):
      mm: Add PG_arch_2 page flag
      mm: Add arch hooks for saving/restoring tags
      arm64: mte: Enable swap of tagged pages
      arm64: mte: Save tags when hibernating

Tian Tao (4):
      arm64: Remove the unused include statements
      arm64: hibernate: Remove unused including <linux/version.h>
      arm64/fpsimd: Fix missing-prototypes in fpsimd.c
      arm64: mm: Fix missing-prototypes in pageattr.c

Tuan Phan (1):
      perf: arm_dsu: Support DSU ACPI devices

Valentin Schneider (1):
      arm64: topology: Stop using MPIDR for topology information

Vincenzo Frascino (7):
      arm64: mte: system register definitions
      arm64: mte: CPU feature detection and initial sysreg configuration
      arm64: mte: Add specific SIGSEGV codes
      arm64: mte: Handle synchronous and asynchronous tag check faults
      arm64: mte: Tags-aware copy_{user_,}highpage() implementations
      arm64: mte: Kconfig entry
      arm64: mte: Add Memory Tagging Extension documentation

Will Deacon (27):
      arm64: vdso32: Remove a bunch of #ifdef CONFIG_COMPAT_VDSO guards
      arm64: vdso: Fix unusual formatting in *setup_additional_pages()
      arm64: Improve diagnostics when trapping BRK with FAULT_BRK_IMM
      arm64: mte: Fix typo in memory tagging ABI documentation
      arm64: Remove Spectre-related CONFIG_* options
      KVM: arm64: Replace CONFIG_KVM_INDIRECT_VECTORS with CONFIG_RANDOMIZE_BASE
      KVM: arm64: Simplify install_bp_hardening_cb()
      arm64: Rename ARM64_HARDEN_BRANCH_PREDICTOR to ARM64_SPECTRE_V2
      arm64: Introduce separate file for spectre mitigations and reporting
      arm64: Rewrite Spectre-v2 mitigation code
      arm64: Group start_thread() functions together
      arm64: Treat SSBS as a non-strict system feature
      arm64: Rename ARM64_SSBD to ARM64_SPECTRE_V4
      arm64: Move SSBD prctl() handler alongside other spectre mitigation code
      arm64: Rewrite Spectre-v4 mitigation code
      KVM: arm64: Allow patching EL2 vectors even with KASLR is not enabled
      arm64: Pull in task_stack_page() to Spectre-v4 mitigation code
      arm64: Add support for PR_SPEC_DISABLE_NOEXEC prctl() option
      arm64: mm: Make flush_tlb_fix_spurious_fault() a no-op
      arm64: dbm: Invalidate local TLB when setting TCR_EL1.HD
      perf: arm-cmn: Fix unsigned comparison to less than zero
      perf: arm-cmn: Fix conversion specifiers for node type
      Merge branches 'for-next/acpi', 'for-next/boot', 'for-next/bpf', 'for-next/cpuinfo', 'for-next/fpsimd', 'for-next/misc', 'for-next/mm', 'for-next/pci', 'for-next/perf', 'for-next/ptrauth', 'for-next/sdei', 'for-next/selftests', 'for-next/stacktrace', 'for-next/svm', 'for-next/topology', 'for-next/tpyos' and 'for-next/vdso' into for-next/core
      Merge branch 'for-next/ghostbusters' into for-next/core
      Merge branch 'for-next/mte' into for-next/core
      Merge branch 'for-next/late-arrivals' into for-next/core
      Revert "arm64: initialize per-cpu offsets earlier"

Xiaoming Ni (1):
      arm64: fix some spelling mistakes in the comments by codespell

Yanfei Xu (1):
      arm64/numa: Fix a typo in comment of arm64_numa_init

Yue Hu (1):
      arm64: traps: Add str of description to panic() in die()

Zenghui Yu (2):
      ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
      ACPI/IORT: Remove the unused inline functions

Zhengyuan Liu (1):
      arm64/mm: return cpu_all_mask when node is NUMA_NO_NODE

 Documentation/admin-guide/perf/arm-cmn.rst         |   65 +
 Documentation/admin-guide/perf/index.rst           |    1 +
 Documentation/arm64/cpu-feature-registers.rst      |    2 +
 Documentation/arm64/elf_hwcaps.rst                 |    4 +
 Documentation/arm64/index.rst                      |    1 +
 Documentation/arm64/memory-tagging-extension.rst   |  305 ++++
 .../devicetree/bindings/perf/arm,cmn.yaml          |   57 +
 Documentation/virt/kvm/arm/hyp-abi.rst             |    6 +-
 arch/arm64/Kconfig                                 |   72 +-
 arch/arm64/Makefile                                |    6 -
 arch/arm64/include/asm/archrandom.h                |    5 -
 arch/arm64/include/asm/boot.h                      |    3 +-
 arch/arm64/include/asm/cpu_ops.h                   |    2 +-
 arch/arm64/include/asm/cpucaps.h                   |    7 +-
 arch/arm64/include/asm/cpufeature.h                |   32 +-
 arch/arm64/include/asm/esr.h                       |    4 +-
 arch/arm64/include/asm/exception.h                 |    1 +
 arch/arm64/include/asm/extable.h                   |    9 +
 arch/arm64/include/asm/fpsimd.h                    |    3 +
 arch/arm64/include/asm/fpsimdmacros.h              |   48 +-
 arch/arm64/include/asm/hwcap.h                     |   11 +-
 arch/arm64/include/asm/insn.h                      |    4 +
 arch/arm64/include/asm/kernel-pgtable.h            |    2 +-
 arch/arm64/include/asm/kvm_arm.h                   |    5 +-
 arch/arm64/include/asm/kvm_asm.h                   |    5 -
 arch/arm64/include/asm/kvm_emulate.h               |   14 -
 arch/arm64/include/asm/kvm_host.h                  |   40 -
 arch/arm64/include/asm/kvm_mmu.h                   |   90 +-
 arch/arm64/include/asm/memory.h                    |   19 +-
 arch/arm64/include/asm/mman.h                      |   56 +-
 arch/arm64/include/asm/mmu.h                       |   14 +-
 arch/arm64/include/asm/mmu_context.h               |   11 +-
 arch/arm64/include/asm/mte.h                       |   86 +
 arch/arm64/include/asm/numa.h                      |    3 +
 arch/arm64/include/asm/page-def.h                  |    5 -
 arch/arm64/include/asm/page.h                      |   19 +-
 arch/arm64/include/asm/pci.h                       |    1 +
 arch/arm64/include/asm/perf_event.h                |    3 +
 arch/arm64/include/asm/pgtable-hwdef.h             |   16 +-
 arch/arm64/include/asm/pgtable-prot.h              |    9 +
 arch/arm64/include/asm/pgtable.h                   |  110 +-
 arch/arm64/include/asm/processor.h                 |   56 +-
 arch/arm64/include/asm/spectre.h                   |   32 +
 arch/arm64/include/asm/stacktrace.h                |    2 +-
 arch/arm64/include/asm/sysreg.h                    |   87 +-
 arch/arm64/include/asm/thread_info.h               |    4 +-
 arch/arm64/include/asm/traps.h                     |    2 +-
 arch/arm64/include/uapi/asm/hwcap.h                |    2 +-
 arch/arm64/include/uapi/asm/kvm.h                  |    9 +
 arch/arm64/include/uapi/asm/mman.h                 |    1 +
 arch/arm64/include/uapi/asm/ptrace.h               |    4 +
 arch/arm64/kernel/Makefile                         |    6 +-
 arch/arm64/kernel/cpu-reset.S                      |    4 +
 arch/arm64/kernel/cpu_errata.c                     |  487 +-----
 arch/arm64/kernel/cpufeature.c                     |  132 +-
 arch/arm64/kernel/cpuinfo.c                        |  178 ++-
 arch/arm64/kernel/debug-monitors.c                 |    2 +-
 arch/arm64/kernel/entry-common.c                   |   21 +
 arch/arm64/kernel/entry-fpsimd.S                   |   25 +
 arch/arm64/kernel/entry.S                          |   45 +-
 arch/arm64/kernel/fpsimd.c                         |    8 +-
 arch/arm64/kernel/head.S                           |   16 +-
 arch/arm64/kernel/hibernate.c                      |  125 +-
 arch/arm64/kernel/image-vars.h                     |    2 -
 arch/arm64/kernel/image.h                          |    1 -
 arch/arm64/kernel/insn.c                           |   11 +-
 arch/arm64/kernel/mte.c                            |  336 ++++
 arch/arm64/kernel/perf_callchain.c                 |    6 +-
 arch/arm64/kernel/perf_event.c                     |  272 ++--
 arch/arm64/kernel/perf_regs.c                      |    2 +-
 arch/arm64/kernel/probes/decode-insn.c             |    9 +-
 arch/arm64/kernel/process.c                        |   71 +-
 arch/arm64/kernel/proton-pack.c                    |  792 ++++++++++
 arch/arm64/kernel/ptrace.c                         |   51 +-
 arch/arm64/kernel/relocate_kernel.S                |   12 -
 arch/arm64/kernel/return_address.c                 |    8 +-
 arch/arm64/kernel/signal.c                         |   12 +-
 arch/arm64/kernel/smp_spin_table.c                 |    4 +-
 arch/arm64/kernel/ssbd.c                           |  129 --
 arch/arm64/kernel/stacktrace.c                     |  117 +-
 arch/arm64/kernel/suspend.c                        |    7 +-
 arch/arm64/kernel/syscall.c                        |   10 +
 arch/arm64/kernel/topology.c                       |   32 +-
 arch/arm64/kernel/traps.c                          |  132 +-
 arch/arm64/kernel/vdso.c                           |   51 +-
 arch/arm64/kernel/vmlinux.lds.S                    |    4 +-
 arch/arm64/kvm/Kconfig                             |    3 -
 arch/arm64/kvm/arm.c                               |   40 +-
 arch/arm64/kvm/hyp/Makefile                        |    3 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   31 -
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   33 -
 arch/arm64/kvm/hyp/nvhe/switch.c                   |    4 -
 arch/arm64/kvm/hyp/vhe/switch.c                    |    4 -
 arch/arm64/kvm/hypercalls.c                        |   33 +-
 arch/arm64/kvm/pmu-emul.c                          |   26 +-
 arch/arm64/kvm/psci.c                              |   74 +-
 arch/arm64/kvm/reset.c                             |    4 -
 arch/arm64/kvm/sys_regs.c                          |   19 +
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |    4 +-
 arch/arm64/lib/Makefile                            |    2 +
 arch/arm64/lib/mte.S                               |  151 ++
 arch/arm64/mm/Makefile                             |    3 +-
 arch/arm64/mm/context.c                            |  105 +-
 arch/arm64/mm/copypage.c                           |   25 +-
 arch/arm64/mm/extable.c                            |    4 +-
 arch/arm64/mm/fault.c                              |   13 +-
 arch/arm64/mm/mmu.c                                |   20 +-
 arch/arm64/mm/mteswap.c                            |   83 +
 arch/arm64/mm/numa.c                               |    8 +-
 arch/arm64/mm/pageattr.c                           |    1 +
 arch/arm64/mm/proc.S                               |   32 +-
 arch/arm64/mm/{dump.c => ptdump.c}                 |    6 +
 arch/s390/kernel/stacktrace.c                      |    4 +-
 arch/x86/kernel/signal_compat.c                    |    2 +-
 arch/x86/kernel/stacktrace.c                       |   10 +-
 drivers/acpi/arm64/iort.c                          |   10 +-
 drivers/firmware/arm_sdei.c                        |  305 ++--
 drivers/firmware/efi/libstub/Makefile              |    1 -
 drivers/firmware/efi/libstub/arm64-stub.c          |    6 +-
 drivers/perf/Kconfig                               |    7 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/arm-cmn.c                             | 1641 ++++++++++++++++++++
 drivers/perf/arm_dsu_pmu.c                         |   63 +-
 drivers/perf/arm_pmu.c                             |  155 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |    1 +
 drivers/perf/thunderx2_pmu.c                       |    7 +-
 drivers/perf/xgene_pmu.c                           |   32 +-
 fs/namespace.c                                     |   25 +-
 fs/proc/page.c                                     |    3 +
 fs/proc/task_mmu.c                                 |    4 +
 include/kvm/arm_pmu.h                              |    1 +
 include/linux/kernel-page-flags.h                  |    1 +
 include/linux/mm.h                                 |    8 +
 include/linux/mman.h                               |   23 +-
 include/linux/page-flags.h                         |    3 +
 include/linux/perf/arm_pmu.h                       |    3 +
 include/linux/pgtable.h                            |   28 +
 include/linux/stacktrace.h                         |    5 +-
 include/trace/events/mmflags.h                     |    9 +-
 include/uapi/asm-generic/siginfo.h                 |    4 +-
 include/uapi/linux/elf.h                           |    1 +
 include/uapi/linux/prctl.h                         |    9 +
 kernel/stacktrace.c                                |    8 +-
 mm/huge_memory.c                                   |    3 +
 mm/mmap.c                                          |    9 +
 mm/mprotect.c                                      |    6 +
 mm/page_io.c                                       |   10 +
 mm/shmem.c                                         |    9 +
 mm/swapfile.c                                      |    2 +
 mm/util.c                                          |    2 +-
 tools/testing/selftests/arm64/Makefile             |    2 +-
 tools/testing/selftests/arm64/fp/.gitignore        |    5 +
 tools/testing/selftests/arm64/fp/Makefile          |   17 +
 tools/testing/selftests/arm64/fp/README            |  100 ++
 tools/testing/selftests/arm64/fp/asm-offsets.h     |   11 +
 tools/testing/selftests/arm64/fp/assembler.h       |   57 +
 tools/testing/selftests/arm64/fp/fpsimd-stress     |   60 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |  482 ++++++
 tools/testing/selftests/arm64/fp/sve-probe-vls.c   |   58 +
 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S  |   33 +
 tools/testing/selftests/arm64/fp/sve-ptrace.c      |  336 ++++
 tools/testing/selftests/arm64/fp/sve-stress        |   59 +
 tools/testing/selftests/arm64/fp/sve-test.S        |  672 ++++++++
 tools/testing/selftests/arm64/fp/vlset.c           |  155 ++
 tools/testing/selftests/arm64/mte/.gitignore       |    6 +
 tools/testing/selftests/arm64/mte/Makefile         |   29 +
 .../selftests/arm64/mte/check_buffer_fill.c        |  475 ++++++
 .../selftests/arm64/mte/check_child_memory.c       |  195 +++
 .../selftests/arm64/mte/check_ksm_options.c        |  159 ++
 .../selftests/arm64/mte/check_mmap_options.c       |  262 ++++
 .../selftests/arm64/mte/check_tags_inclusion.c     |  185 +++
 tools/testing/selftests/arm64/mte/check_user_mem.c |  111 ++
 .../testing/selftests/arm64/mte/mte_common_util.c  |  341 ++++
 .../testing/selftests/arm64/mte/mte_common_util.h  |  118 ++
 tools/testing/selftests/arm64/mte/mte_def.h        |   60 +
 tools/testing/selftests/arm64/mte/mte_helper.S     |  128 ++
 tools/testing/selftests/arm64/pauth/.gitignore     |    2 +
 tools/testing/selftests/arm64/pauth/Makefile       |   39 +
 tools/testing/selftests/arm64/pauth/exec_target.c  |   34 +
 tools/testing/selftests/arm64/pauth/helper.c       |   39 +
 tools/testing/selftests/arm64/pauth/helper.h       |   28 +
 tools/testing/selftests/arm64/pauth/pac.c          |  368 +++++
 .../testing/selftests/arm64/pauth/pac_corruptor.S  |   19 +
 tools/vm/page-types.c                              |    2 +
 184 files changed, 10378 insertions(+), 1896 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/arm-cmn.rst
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 Documentation/devicetree/bindings/perf/arm,cmn.yaml
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/include/asm/spectre.h
 create mode 100644 arch/arm64/kernel/mte.c
 create mode 100644 arch/arm64/kernel/proton-pack.c
 delete mode 100644 arch/arm64/kernel/ssbd.c
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/mteswap.c
 rename arch/arm64/mm/{dump.c => ptdump.c} (97%)
 create mode 100644 drivers/perf/arm-cmn.c
 create mode 100644 tools/testing/selftests/arm64/fp/.gitignore
 create mode 100644 tools/testing/selftests/arm64/fp/Makefile
 create mode 100644 tools/testing/selftests/arm64/fp/README
 create mode 100644 tools/testing/selftests/arm64/fp/asm-offsets.h
 create mode 100644 tools/testing/selftests/arm64/fp/assembler.h
 create mode 100755 tools/testing/selftests/arm64/fp/fpsimd-stress
 create mode 100644 tools/testing/selftests/arm64/fp/fpsimd-test.S
 create mode 100644 tools/testing/selftests/arm64/fp/sve-probe-vls.c
 create mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S
 create mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace.c
 create mode 100755 tools/testing/selftests/arm64/fp/sve-stress
 create mode 100644 tools/testing/selftests/arm64/fp/sve-test.S
 create mode 100644 tools/testing/selftests/arm64/fp/vlset.c
 create mode 100644 tools/testing/selftests/arm64/mte/.gitignore
 create mode 100644 tools/testing/selftests/arm64/mte/Makefile
 create mode 100644 tools/testing/selftests/arm64/mte/check_buffer_fill.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_child_memory.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_ksm_options.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_mmap_options.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_tags_inclusion.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_user_mem.c
 create mode 100644 tools/testing/selftests/arm64/mte/mte_common_util.c
 create mode 100644 tools/testing/selftests/arm64/mte/mte_common_util.h
 create mode 100644 tools/testing/selftests/arm64/mte/mte_def.h
 create mode 100644 tools/testing/selftests/arm64/mte/mte_helper.S
 create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
 create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
 create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.c
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
 create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
 create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S
