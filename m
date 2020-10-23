Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B002975DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbgJWRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753577AbgJWRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603474585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LjYa5GTgtmX24+4BS4/d9EeRwwz/xERv5Ym1yxS/M6s=;
        b=DQ508YemT/UX/8Oa3HICmG+vGLIJkGfLn6P3g3btI0/mmAT6acVGqWDbRbcL15J7AHWDyX
        IbRy1aYkM2nmQl8iUF39OxTP572nSyO+BSBV/fU1wfom1nlPjyO+tHMUJxvL61gA4Cygnw
        LikfeCww65Sxg9zsWWZ2aifM4oZHcMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-kkeeBFqiNuK0tSQFFNwRXg-1; Fri, 23 Oct 2020 13:36:21 -0400
X-MC-Unique: kkeeBFqiNuK0tSQFFNwRXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 320421084D69;
        Fri, 23 Oct 2020 17:36:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6D755793;
        Fri, 23 Oct 2020 17:36:19 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 5.10
Date:   Fri, 23 Oct 2020 13:36:19 -0400
Message-Id: <20201023173619.2785471-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit e2e1a1c86bf32a8d7458b9024f518cf2434414c8:

  Merge tag 'kvmarm-fixes-5.9-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-master (2020-10-03 05:07:59 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 29cf0f5007a215b51feb0ae25ca5353480d53ead:

  kvm: x86/mmu: NX largepage recovery for TDP MMU (2020-10-23 03:42:16 -0400)

----------------------------------------------------------------
ARM:
- New page table code for both hypervisor and guest stage-2
- Introduction of a new EL2-private host context
- Allow EL2 to have its own private per-CPU variables
- Support of PMU event filtering
- Complete rework of the Spectre mitigation

PPC:
- Fix for running nested guests with in-kernel IRQ chip
- Fix race condition causing occasional host hard lockup
- Minor cleanups and bugfixes

x86:
- allow trapping unknown MSRs to userspace
- allow userspace to force #GP on specific MSRs
- INVPCID support on AMD
- nested AMD cleanup, on demand allocation of nested SVM state
- hide PV MSRs and hypercalls for features not enabled in CPUID
- new test for MSR_IA32_TSC writes from host and guest
- cleanups: MMU, CPUID, shared MSRs
- LAPIC latency optimizations ad bugfixes

For x86, also included in this pull request is a new alternative and
(in the future) more scalable implementation of extended page tables
that does not need a reverse map from guest physical addresses to
host physical addresses.  For now it is disabled by default because
it is still lacking a few of the existing MMU's bells and whistles.
However it is a very solid piece of work and it is already available
for people to hammer on it.

----------------------------------------------------------------

The top 22 patches are the new MMU that I mentioned in the tag message
above.  They have been mostly ready for almost a month, though they were
on a branch and I only froze their commit hashes today, which is why
they appear on top.  

This is the first time that I receive such a large contribution, so
I apologize in advance if you don't like this choice.  The functionality
included here is only the part that could be implemented with zero effect
on other code when the new MMU it's disabled, exactly to mitigate the
issues with the rebase-happy workflow.

The reason of this choice is that, being such a large amount of new code,
it was reviewed by different people each at their own pace.  The remarks
were all very minor but they spread across a relatively long time period.
I decided that the rebasing was an acceptable price to pay for a clean
commit history in the new files, which in turn would make things easier
in the future for people who want to study the new code.

Also a few words on the late pull request, which is not an attempt to
sneak in those patches but simply due to me being busy with non-Linux
stuff through the whole 5.10 development period and having to work on
KVM in (too short) bursts.  This should be over now and I look forward
to the 5.11 merge window for which I am hoping to send my pull request
well before Christmas.  I am also going to talk with other contributors
at KVM Forum next week, and I hope that we can figure out a way to
improve maintainer workload and sanity through co-maintenance, CI or
pehaps something else that I have not thought about.

/me braces for the incoming perkele :)

Thanks,

Paolo

Aaron Lewis (1):
      KVM: x86: Prepare MSR bitmaps for userspace tracked MSRs

Alexander Graf (7):
      KVM: x86: Return -ENOENT on unimplemented MSRs
      KVM: x86: Allow deflecting unknown MSR accesses to user space
      KVM: x86: Add infrastructure for MSR filtering
      KVM: x86: SVM: Prevent MSR passthrough when MSR access is denied
      KVM: x86: VMX: Prevent MSR passthrough when MSR access is denied
      KVM: x86: Introduce MSR filtering
      KVM: selftests: Add test for user space MSR handling

Alexandru Elisei (4):
      KVM: arm64: Try PMD block mappings if PUD mappings are not supported
      KVM: arm64: Do not flush memslot if FWB is supported
      KVM: arm64: Add undocumented return values for PMU device control group
      KVM: arm64: Match PMU error code descriptions with error conditions

Andrew Scull (19):
      KVM: arm64: Remove __activate_vm wrapper
      KVM: arm64: Remove hyp_panic arguments
      KVM: arm64: Remove kvm_host_data_t typedef
      KVM: arm64: Choose hyp symbol based on context
      KVM: arm64: Save chosen hyp vector to a percpu variable
      KVM: arm64: nVHE: Use separate vector for the host
      KVM: arm64: nVHE: Don't consume host SErrors with ESB
      KVM: arm64: Introduce hyp context
      KVM: arm64: Update context references from host to hyp
      KVM: arm64: Restore hyp when panicking in guest context
      KVM: arm64: Share context save and restore macros
      KVM: arm64: nVHE: Switch to hyp context for EL2
      KVM: arm64: nVHE: Handle hyp panics
      KVM: arm64: nVHE: Pass pointers consistently to hyp-init
      smccc: Define vendor hyp owned service call region
      smccc: Use separate variables for args and results
      KVM: arm64: nVHE: Migrate hyp interface to SMCCC
      KVM: arm64: nVHE: Migrate hyp-init to SMCCC
      KVM: arm64: nVHE: Fix pointers during SMCCC convertion

Babu Moger (11):
      KVM: nSVM: Remove unused field
      KVM: SVM: Introduce vmcb_(set_intercept/clr_intercept/_is_intercept)
      KVM: SVM: Change intercept_cr to generic intercepts
      KVM: SVM: Change intercept_dr to generic intercepts
      KVM: SVM: Modify intercept_exceptions to generic intercepts
      KVM: SVM: Modify 64 bit intercept field to two 32 bit vectors
      KVM: SVM: Add new intercept word in vmcb_control_area
      KVM: SVM: Remove set_cr_intercept, clr_cr_intercept and is_cr_intercept
      KVM: X86: Rename and move the function vmx_handle_memory_failure to x86.c
      KVM: X86: Move handling of INVPCID types to x86
      KVM: SVM: Enable INVPCID feature on AMD

Ben Gardon (20):
      KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent
      kvm: mmu: Separate making non-leaf sptes from link_shadow_page
      kvm: x86/mmu: Separate making SPTEs from set_spte
      kvm: x86/mmu: Introduce tdp_iter
      kvm: x86/mmu: Init / Uninit the TDP MMU
      kvm: x86/mmu: Allocate and free TDP MMU roots
      kvm: x86/mmu: Add functions to handle changed TDP SPTEs
      kvm: x86/mmu: Support zapping SPTEs in the TDP MMU
      kvm: x86/mmu: Remove disallowed_hugepage_adjust shadow_walk_iterator arg
      kvm: x86/mmu: Add TDP MMU PF handler
      kvm: x86/mmu: Allocate struct kvm_mmu_pages for all pages in TDP MMU
      kvm: x86/mmu: Support invalidate range MMU notifier for TDP MMU
      kvm: x86/mmu: Add access tracking for tdp_mmu
      kvm: x86/mmu: Support changed pte notifier in tdp MMU
      kvm: x86/mmu: Support dirty logging for the TDP MMU
      kvm: x86/mmu: Support disabling dirty logging for the tdp MMU
      kvm: x86/mmu: Support write protection for nesting in tdp MMU
      kvm: x86/mmu: Support MMIO in the TDP MMU
      kvm: x86/mmu: Don't clear write flooding count for direct roots
      kvm: x86/mmu: NX largepage recovery for TDP MMU

Cfir Cohen (1):
      KVM: SVM: Mark SEV launch secret pages as dirty.

Chenyi Qiang (2):
      KVM: nVMX: Fix VMX controls MSRs setup when nested VMX enabled
      KVM: nVMX: Simplify the initialization of nested_vmx_msrs

David Brazdil (10):
      kvm: arm64: Partially link nVHE hyp code, simplify HYPCOPY
      kvm: arm64: Move nVHE hyp namespace macros to hyp_image.h
      kvm: arm64: Only define __kvm_ex_table for CONFIG_KVM
      kvm: arm64: Remove __hyp_this_cpu_read
      kvm: arm64: Remove hyp_adr/ldr_this_cpu
      kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
      kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
      kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
      kvm: arm64: Set up hyp percpu data for nVHE
      kvm: arm64: Remove unnecessary hyp mappings

Fabiano Rosas (1):
      KVM: PPC: Book3S HV: Do not allocate HPT for a nested guest

Greg Kurz (2):
      KVM: PPC: Book3S HV: XICS: Replace the 'destroy' method by a 'release' method
      KVM: PPC: Don't return -ENOTSUPP to userspace in ioctls

Haiwei Li (2):
      KVM: SVM: use __GFP_ZERO instead of clear_page()
      KVM: SVM: Add tracepoint for cr_interception

Jing Xiangfeng (1):
      KVM: PPC: Book3S: Remove redundant initialization of variable ret

Joe Perches (2):
      kvm x86/mmu: Make struct kernel_param_ops definitions const
      KVM: PPC: Book3S HV: Make struct kernel_param_ops definition const

Krish Sadhukhan (2):
      KVM: nVMX: KVM needs to unset "unrestricted guest" VM-execution control in vmcs02 if vmcs12 doesn't set it
      KVM: nSVM: CR3 MBZ bits are only 63:52

Lai Jiangshan (2):
      KVM: x86: Intercept LA57 to inject #GP fault when it's reserved
      KVM: x86: Let the guest own CR4.FSGSBASE

Li Qiang (2):
      cpuidle-haltpoll: fix error comments in arch_haltpoll_disable
      Documentation: kvm: fix a typo

Liu Shixin (1):
      KVM: arm64: vgic-debug: Convert to use DEFINE_SEQ_ATTRIBUTE macro

Marc Zyngier (13):
      Merge branch 'kvm-arm64/pt-new' into kvmarm-master/next
      Merge branch 'kvm-arm64/nvhe-hyp-context' into kvmarm-master/next
      Merge branch 'kvm-arm64/pt-new' into kvmarm-master/next
      Merge branch 'kvm-arm64/misc-5.10' into kvmarm-master/next
      KVM: arm64: Refactor PMU attribute error handling
      KVM: arm64: Use event mask matching architecture revision
      KVM: arm64: Add PMU event filtering infrastructure
      KVM: arm64: Mask out filtered events in PCMEID{0,1}_EL1
      KVM: arm64: Document PMU filtering API
      Merge branch 'kvm-arm64/pmu-5.9' into kvmarm-master/next
      Merge remote-tracking branch 'arm64/for-next/ghostbusters' into kvm-arm64/hyp-pcpu
      Merge branch 'kvm-arm64/hyp-pcpu' into kvmarm-master/next
      Merge branches 'kvm-arm64/pt-new' and 'kvm-arm64/pmu-5.9' into kvmarm-master/next

Matteo Croce (1):
      x86/kvm: hide KVM options from menuconfig when KVM is not compiled

Mauro Carvalho Chehab (1):
      KVM: arm64: Fix some documentation build warnings

Maxim Levitsky (10):
      KVM: SVM: rename a variable in the svm_create_vcpu
      KVM: nSVM: rename nested vmcb to vmcb12
      KVM: SVM: refactor msr permission bitmap allocation
      KVM: SVM: use __GFP_ZERO instead of clear_page
      KVM: SVM: refactor exit labels in svm_create_vcpu
      KVM: x86: fix MSR_IA32_TSC read for nested migration
      KVM: x86: xen_hvm_config: cleanup return values
      KVM: x86: report negative values from wrmsr emulation to userspace
      KVM: x86: allow kvm_x86_ops.set_efer to return an error value
      KVM: nSVM: implement on demand allocation of the nested state

Oliver Upton (4):
      kvm: x86: encapsulate wrmsr(MSR_KVM_SYSTEM_TIME) emulation in helper fn
      kvm: x86: set wall_clock in kvm_write_wall_clock()
      kvm: x86: only provide PV features if enabled in guest's CPUID
      Documentation: kvm: fix some typos in cpuid.rst

Paolo Bonzini (11):
      Merge branch 'x86-seves-for-paolo' of https://git.kernel.org/.../tip/tip into HEAD
      Merge tag 'kvm-ppc-next-5.10-1' of git://git.kernel.org/.../paulus/powerpc into HEAD
      KVM: SEV: shorten comments around sev_clflush_pages
      KVM: x86: rename KVM_REQ_GET_VMCS12_PAGES
      KVM: nSVM: delay MSR permission processing to first nested VM run
      KVM: x86: do not attempt TSC synchronization on guest writes
      Merge tag 'kvmarm-5.10' of git://git.kernel.org/.../kvmarm/kvmarm into HEAD
      KVM: VMX: Forbid userspace MSR filters for x2APIC
      Merge branch 'kvm-fixes' into 'next'
      KVM: mmu: Separate updating a PTE from kvm_set_pte_rmapp
      KVM: mmu: extract spte.h and spte.c

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Set LPCR[HDICE] before writing HDEC

Peter Xu (2):
      KVM: VMX: Fix x2APIC MSR intercept handling on !APICV platforms
      KVM: Cache as_id in kvm_memory_slot

Qinglang Miao (1):
      KVM: PPC: Book3S HV: XIVE: Convert to DEFINE_SHOW_ATTRIBUTE

Quentin Perret (4):
      KVM: arm64: Add support for stage-2 write-protect in generic page-table
      KVM: arm64: Convert write-protect operation to generic page-table API
      KVM: arm64: Add support for stage-2 cache flushing in generic page-table
      KVM: arm64: Convert memslot cache-flushing code to generic page-table API

Robert Hoo (1):
      KVM: x86: emulating RDPID failure shall return #UD rather than #GP

Rustam Kovhaev (1):
      KVM: use struct_size() and flex_array_size() helpers in kvm_io_bus_unregister_dev()

Sean Christopherson (63):
      KVM: x86: Add kvm_x86_ops hook to short circuit emulation
      KVM: VMX: Move IRQ invocation to assembly subroutine
      KVM: VMX: Invoke NMI handler via indirect call instead of INTn
      KVM: nVMX: Morph notification vector IRQ on nested VM-Enter to pending PI
      KVM: nVMX: Add VM-Enter failed tracepoints for super early checks
      KVM: VMX: Use precomputed MAXPHYADDR for RTIT base MSR check
      KVM: x86: Unexport cpuid_query_maxphyaddr()
      KVM: VMX: Replace MSR_IA32_RTIT_OUTPUT_BASE_MASK with helper function
      KVM: x86: Move illegal GPA helper out of the MMU code
      KVM: VMX: Use "illegal GPA" helper for PT/RTIT output base check
      KVM: VMX: Rename vmx_*_supported() helpers to cpu_has_vmx_*()
      KVM: VMX: Unconditionally clear CPUID.INVPCID if !CPUID.PCID
      KVM: VMX: Rename RDTSCP secondary exec control name to insert "ENABLE"
      KVM: VMX: Add a helper and macros to reduce boilerplate for sec exec ctls
      KVM: x86/mmu: Stash 'kvm' in a local variable in kvm_mmu_free_roots()
      KVM: x86/mmu: Move flush logic from mmu_page_zap_pte() to FNAME(invlpg)
      KVM: x86/mmu: Return -EIO if page fault returns RET_PF_INVALID
      KVM: x86/mmu: Invert RET_PF_* check when falling through to emulation
      KVM: x86/mmu: Return unique RET_PF_* values if the fault was fixed
      KVM: x86/mmu: Bail early from final #PF handling on spurious faults
      KVM: VMX: Rename ops.h to vmx_ops.h
      KVM: x86/mmu: Commit zap of remaining invalid pages when recovering lpages
      KVM: x86/mmu: Refactor the zap loop for recovering NX lpages
      KVM: x86/mmu: Move "huge page disallowed" calculation into mapping helpers
      KVM: x86/mmu: Capture requested page level before NX huge page workaround
      KVM: x86/mmu: Account NX huge page disallowed iff huge page was requested
      KVM: x86/mmu: Rename 'hlevel' to 'level' in FNAME(fetch)
      KVM: x86/mmu: Hoist ITLB multi-hit workaround check up a level
      KVM: x86/mmu: Track write/user faults using bools
      KVM: nVMX: Reset the segment cache when stuffing guest segs
      KVM: nVMX: Reload vmcs01 if getting vmcs12's pages fails
      KVM: nVMX: Explicitly check for valid guest state for !unrestricted guest
      KVM: nVMX: Move free_nested() below vmx_switch_vmcs()
      KVM: nVMX: Ensure vmcs01 is the loaded VMCS when freeing nested state
      KVM: nVMX: Drop redundant VMCS switch and free_nested() call
      KVM: nVMX: WARN on attempt to switch the currently loaded VMCS
      KVM: x86: Add RIP to the kvm_entry, i.e. VM-Enter, tracepoint
      KVM: x86: Read guest RIP from within the kvm_nested_vmexit tracepoint
      KVM: VMX: Add a helper to test for a valid error code given an intr info
      KVM: x86: Add intr/vectoring info and error code to kvm_exit tracepoint
      KVM: x86: Add macro wrapper for defining kvm_exit tracepoint
      KVM: x86: Use common definition for kvm_nested_vmexit tracepoint
      KVM: nVMX: Read EXIT_QUAL and INTR_INFO only when needed for nested exit
      KVM: x86/mmu: Move individual kvm_mmu initialization into common helper
      KVM: x86: Rename "shared_msrs" to "user_return_msrs"
      KVM: VMX: Prepend "MAX_" to MSR array size defines
      KVM: VMX: Rename "vmx_find_msr_index" to "vmx_find_loadstore_msr_slot"
      KVM: VMX: Rename the "shared_msr_entry" struct to "vmx_uret_msr"
      KVM: VMX: Rename vcpu_vmx's "nmsrs" to "nr_uret_msrs"
      KVM: VMX: Rename vcpu_vmx's "save_nmsrs" to "nr_active_uret_msrs"
      KVM: VMX: Rename vcpu_vmx's "guest_msrs_ready" to "guest_uret_msrs_loaded"
      KVM: VMX: Rename "__find_msr_index" to "__vmx_find_uret_msr"
      KVM: VMX: Check guest support for RDTSCP before processing MSR_TSC_AUX
      KVM: VMX: Move uret MSR lookup into update_transition_efer()
      KVM: VMX: Add vmx_setup_uret_msr() to handle lookup and swap
      KVM: VMX: Rename "find_msr_entry" to "vmx_find_uret_msr"
      KVM: VMX: Rename "vmx_set_guest_msr" to "vmx_set_guest_uret_msr"
      KVM: VMX: Rename "vmx_msr_index" to "vmx_uret_msrs_list"
      KVM: VMX: Rename vmx_uret_msr's "index" to "slot"
      KVM: VMX: Ignore userspace MSR filters for x2APIC
      KVM: x86: Invoke vendor's vcpu_after_set_cpuid() after all common updates
      KVM: x86: Move call to update_exception_bitmap() into VMX code
      KVM: VMX: Intercept guest reserved CR4 bits to inject #GP fault

Suravee Suthikulpanit (1):
      KVM: SVM: Initialize prev_ga_tag before use

Tian Tao (1):
      KVM: arm64: Fix inject_fault.c kernel-doc warnings

Tianjia Zhang (1):
      KVM: MIPS: clean up redundant kvm_run parameters in assembly

Tom Lendacky (1):
      KVM: VMX: Do not perform emulation for INVD intercept

Vitaly Kuznetsov (7):
      KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()
      KVM: x86: hyper-v: Mention SynDBG CPUID leaves in api.rst
      KVM: x86: hyper-v: disallow configuring SynIC timers with no SynIC
      x86/kvm: Update the comment about asynchronous page fault in exc_page_fault()
      KVM: x86: disconnect kvm_check_cpuid() from vcpu->arch.cpuid_entries
      KVM: x86: allocate vcpu->arch.cpuid_entries dynamically
      KVM: x86: bump KVM_MAX_CPUID_ENTRIES

Wang Wensheng (1):
      KVM: PPC: Book3S: Fix symbol undeclared warnings

Wanpeng Li (6):
      KVM: LAPIC: Fix updating DFR missing apic map recalculation
      KVM: LAPIC: Return 0 when getting the tscdeadline timer if the lapic is hw disabled
      KVM: LAPIC: Guarantee the timer is in tsc-deadline mode when setting
      KVM: LAPIC: Narrow down the kick target vCPU
      KVM: LAPIC: Reduce world switch latency caused by timer_advance_ns
      KVM: SVM: Analyze is_guest_mode() in svm_vcpu_run()

Will Deacon (19):
      KVM: arm64: Remove kvm_mmu_free_memory_caches()
      KVM: arm64: Add stand-alone page-table walker infrastructure
      KVM: arm64: Add support for creating kernel-agnostic stage-1 page tables
      KVM: arm64: Use generic allocator for hyp stage-1 page-tables
      KVM: arm64: Add support for creating kernel-agnostic stage-2 page tables
      KVM: arm64: Add support for stage-2 map()/unmap() in generic page-table
      KVM: arm64: Convert kvm_phys_addr_ioremap() to generic page-table API
      KVM: arm64: Convert kvm_set_spte_hva() to generic page-table API
      KVM: arm64: Convert unmap_stage2_range() to generic page-table API
      KVM: arm64: Add support for stage-2 page-aging in generic page-table
      KVM: arm64: Convert page-aging and access faults to generic page-table API
      KVM: arm64: Add support for relaxing stage-2 perms in generic page-table code
      KVM: arm64: Convert user_mem_abort() to generic page-table API
      KVM: arm64: Check the pgt instead of the pgd when modifying page-table
      KVM: arm64: Remove unused page-table code
      KVM: arm64: Remove unused 'pgd' field from 'struct kvm_s2_mmu'
      KVM: arm64: Don't constrain maximum IPA size based on host configuration
      KVM: arm64: Pass level hint to TLBI during stage-2 permission fault
      KVM: arm64: Ensure user_mem_abort() return value is initialised

Xiaofei Tan (1):
      KVM: arm64: Fix doc warnings in mmu code

Xiaoyao Li (1):
      KVM: VMX: Extract posted interrupt support to separate files

Yi Li (1):
      kvm/eventfd: move wildcard calculation outside loop

kernel test robot (1):
      KVM: VMX: vmx_uret_msrs_list[] can be static

 .clang-format                                      |   12 +
 .mailmap                                           |  118 +-
 .../testing/sysfs-bus-event_source-devices-hv_24x7 |    2 +-
 Documentation/RCU/lockdep.rst                      |    2 +-
 Documentation/admin-guide/devices.txt              |    2 +-
 Documentation/admin-guide/ext4.rst                 |   23 +-
 Documentation/admin-guide/kernel-parameters.txt    |    5 +-
 .../admin-guide/laptops/thinkpad-acpi.rst          |    2 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |    8 +-
 Documentation/bpf/index.rst                        |    7 +
 .../devicetree/bindings/clock/imx23-clock.yaml     |    2 +-
 .../devicetree/bindings/clock/imx28-clock.yaml     |    2 +-
 .../devicetree/bindings/gpio/gpio-mxs.yaml         |    2 +-
 Documentation/devicetree/bindings/i2c/i2c-mxs.yaml |    2 +-
 .../bindings/interrupt-controller/ti,sci-inta.txt  |   66 -
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   98 ++
 .../bindings/interrupt-controller/ti,sci-intr.txt  |   82 -
 .../bindings/interrupt-controller/ti,sci-intr.yaml |  102 ++
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   10 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |    2 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |    2 +
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml |    2 +-
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |   32 +-
 Documentation/devicetree/bindings/net/dsa/dsa.txt  |    2 +-
 .../bindings/net/ethernet-controller.yaml          |    3 +-
 .../devicetree/bindings/net/renesas,ether.yaml     |   22 +-
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |    8 +
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |    2 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml      |    2 +-
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |    1 +
 .../devicetree/bindings/thermal/imx-thermal.yaml   |    2 +-
 .../devicetree/bindings/timer/sifive,clint.yaml    |   60 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +-
 Documentation/devicetree/writing-schema.rst        |    4 +-
 Documentation/driver-api/fpga/fpga-bridge.rst      |    6 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |    6 +-
 Documentation/driver-api/fpga/fpga-programming.rst |   16 +-
 Documentation/driver-api/fpga/fpga-region.rst      |   18 +-
 Documentation/driver-api/iio/core.rst              |   16 +-
 .../fault-injection/nvme-fault-injection.rst       |    2 +-
 Documentation/filesystems/affs.rst                 |   16 +-
 Documentation/filesystems/ext4/about.rst           |    2 +-
 Documentation/hwmon/abituguru-datasheet.rst        |    6 +-
 Documentation/hwmon/abituguru.rst                  |    4 +-
 Documentation/hwmon/abituguru3.rst                 |    4 +-
 Documentation/kbuild/llvm.rst                      |   26 +-
 Documentation/kbuild/makefiles.rst                 |   18 +-
 Documentation/locking/locktypes.rst                |   24 +-
 .../maintainer/maintainer-entry-profile.rst        |    1 +
 Documentation/networking/bonding.rst               |   18 -
 Documentation/networking/dsa/configuration.rst     |    2 +-
 Documentation/powerpc/syscall64-abi.rst            |    4 +-
 Documentation/process/deprecated.rst               |    2 +-
 Documentation/sound/cards/audigy-mixer.rst         |    2 +-
 Documentation/sound/cards/sb-live-mixer.rst        |    2 +-
 Documentation/sound/designs/timestamping.rst       |    2 +-
 .../translations/it_IT/process/deprecated.rst      |    2 +-
 Documentation/virt/kvm/api.rst                     |  216 ++-
 Documentation/virt/kvm/cpuid.rst                   |   88 +-
 Documentation/virt/kvm/devices/vcpu.rst            |   57 +-
 MAINTAINERS                                        |  132 +-
 Makefile                                           |    7 +-
 arch/alpha/kernel/module.c                         |    2 +-
 arch/alpha/kernel/signal.c                         |    2 +-
 arch/alpha/kernel/traps.c                          |    4 +-
 arch/arc/boot/dts/hsdk.dts                         |    6 +-
 arch/arc/include/asm/pgalloc.h                     |    4 +-
 arch/arc/kernel/disasm.c                           |    2 +-
 arch/arc/kernel/perf_event.c                       |   14 +-
 arch/arc/kernel/signal.c                           |    2 +-
 arch/arc/kernel/troubleshoot.c                     |   77 +-
 arch/arc/kernel/unwind.c                           |    6 +-
 arch/arc/mm/init.c                                 |   27 +-
 arch/arc/plat-eznps/include/plat/ctop.h            |    1 -
 arch/arm/kernel/hw_breakpoint.c                    |   10 +-
 arch/arm/kernel/signal.c                           |    2 +-
 arch/arm/mach-ep93xx/crunch.c                      |    2 +-
 arch/arm/mach-mmp/pm-mmp2.c                        |    8 +-
 arch/arm/mach-mmp/pm-pxa910.c                      |   10 +-
 arch/arm/mach-omap2/id.c                           |    8 -
 arch/arm/mach-omap2/omap_device.c                  |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    4 -
 arch/arm/mach-orion5x/dns323-setup.c               |    2 +-
 arch/arm/mach-rpc/riscpc.c                         |    2 +-
 arch/arm/mach-tegra/reset.c                        |    2 +-
 arch/arm/mm/alignment.c                            |    4 +-
 arch/arm/mm/proc-v7-bugs.c                         |    2 +-
 arch/arm/plat-omap/dma.c                           |    6 +-
 arch/arm/probes/decode.c                           |    2 +-
 arch/arm/probes/kprobes/core.c                     |    2 +-
 arch/arm64/Kconfig                                 |   26 -
 arch/arm64/Makefile                                |   13 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |    2 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   20 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   15 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   20 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   36 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   12 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |    8 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |    4 +-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |   10 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   43 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |   12 +-
 arch/arm64/include/asm/assembler.h                 |   29 +-
 arch/arm64/include/asm/compiler.h                  |    6 +
 arch/arm64/include/asm/cpucaps.h                   |    4 +-
 arch/arm64/include/asm/cpufeature.h                |   24 -
 arch/arm64/include/asm/hyp_image.h                 |   36 +
 arch/arm64/include/asm/irqflags.h                  |    5 +
 arch/arm64/include/asm/kvm_arm.h                   |    3 +-
 arch/arm64/include/asm/kvm_asm.h                   |  231 ++-
 arch/arm64/include/asm/kvm_emulate.h               |   14 -
 arch/arm64/include/asm/kvm_host.h                  |   75 +-
 arch/arm64/include/asm/kvm_hyp.h                   |    9 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  341 +---
 arch/arm64/include/asm/kvm_pgtable.h               |  309 ++++
 arch/arm64/include/asm/kvm_ptrauth.h               |    6 +-
 arch/arm64/include/asm/mmu.h                       |   11 +-
 arch/arm64/include/asm/percpu.h                    |   28 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |   24 -
 arch/arm64/include/asm/pgtable-prot.h              |   19 -
 arch/arm64/include/asm/processor.h                 |   44 +-
 arch/arm64/include/asm/spectre.h                   |   32 +
 arch/arm64/include/asm/stage2_pgtable.h            |  215 ---
 arch/arm64/include/asm/tlbflush.h                  |    6 +-
 arch/arm64/include/uapi/asm/kvm.h                  |   25 +
 arch/arm64/kernel/Makefile                         |    3 +-
 arch/arm64/kernel/acpi.c                           |    2 +-
 arch/arm64/kernel/cpu_errata.c                     |  489 +-----
 arch/arm64/kernel/cpufeature.c                     |   53 +-
 arch/arm64/kernel/cpuinfo.c                        |    1 -
 arch/arm64/kernel/entry.S                          |   31 +-
 arch/arm64/kernel/hibernate.c                      |    6 +-
 arch/arm64/kernel/hw_breakpoint.c                  |    6 +-
 arch/arm64/kernel/image-vars.h                     |    9 +-
 arch/arm64/kernel/module-plts.c                    |    3 +-
 arch/arm64/kernel/module.c                         |    8 +-
 arch/arm64/kernel/process.c                        |   59 +-
 arch/arm64/kernel/proton-pack.c                    |  792 +++++++++
 arch/arm64/kernel/setup.c                          |    1 -
 arch/arm64/kernel/smp.c                            |    2 +-
 arch/arm64/kernel/ssbd.c                           |  129 --
 arch/arm64/kernel/suspend.c                        |    3 +-
 arch/arm64/kernel/vdso32/Makefile                  |    2 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   21 +
 arch/arm64/kvm/Kconfig                             |    3 -
 arch/arm64/kvm/Makefile                            |    2 +-
 arch/arm64/kvm/arm.c                               |  114 +-
 arch/arm64/kvm/handle_exit.c                       |    2 +-
 arch/arm64/kvm/hyp.S                               |   34 -
 arch/arm64/kvm/hyp/Makefile                        |    3 +-
 arch/arm64/kvm/hyp/entry.S                         |  110 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |  168 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h          |   64 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   69 +-
 arch/arm64/kvm/hyp/nvhe/.gitignore                 |    2 +
 arch/arm64/kvm/hyp/nvhe/Makefile                   |   62 +-
 arch/arm64/kvm/hyp/nvhe/host.S                     |  187 +++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |   67 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  117 ++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S                  |   19 +
 arch/arm64/kvm/hyp/nvhe/switch.c                   |   57 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      |    2 -
 arch/arm64/kvm/hyp/pgtable.c                       |  892 ++++++++++
 arch/arm64/kvm/hyp/vgic-v3-sr.c                    |   16 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   40 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c                 |    4 +-
 arch/arm64/kvm/hypercalls.c                        |   33 +-
 arch/arm64/kvm/inject_fault.c                      |    1 +
 arch/arm64/kvm/mmu.c                               | 1761 ++++----------------
 arch/arm64/kvm/pmu-emul.c                          |  195 ++-
 arch/arm64/kvm/pmu.c                               |   13 +-
 arch/arm64/kvm/psci.c                              |   74 +-
 arch/arm64/kvm/reset.c                             |   44 +-
 arch/arm64/kvm/sys_regs.c                          |    8 +-
 arch/arm64/kvm/vgic/vgic-debug.c                   |   24 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |    4 +-
 arch/arm64/mm/context.c                            |    2 +-
 arch/c6x/kernel/signal.c                           |    4 +-
 arch/csky/kernel/signal.c                          |    2 +-
 arch/h8300/kernel/signal.c                         |    2 +-
 arch/hexagon/kernel/module.c                       |    2 +-
 arch/hexagon/kernel/signal.c                       |    2 +-
 arch/ia64/include/asm/pgtable.h                    |    9 +
 arch/ia64/kernel/crash.c                           |    2 +-
 arch/ia64/kernel/ia64_ksyms.c                      |    2 +-
 arch/ia64/kernel/module.c                          |    2 +-
 arch/ia64/kernel/perfmon.c                         |    2 +-
 arch/ia64/kernel/signal.c                          |    2 +-
 arch/ia64/kernel/unaligned.c                       |    6 +-
 arch/ia64/kernel/unwind.c                          |    2 +-
 arch/m68k/atari/atakeyb.c                          |    2 +-
 arch/m68k/kernel/signal.c                          |    2 +-
 arch/m68k/mac/config.c                             |    2 +-
 arch/m68k/mac/via.c                                |    2 +-
 arch/m68k/mm/fault.c                               |    2 +-
 arch/microblaze/kernel/signal.c                    |    2 +-
 arch/microblaze/mm/init.c                          |    3 +
 arch/mips/include/asm/irqflags.h                   |    5 +
 arch/mips/include/asm/kvm_host.h                   |    4 +-
 .../asm/mach-loongson64/cpu-feature-overrides.h    |    2 -
 arch/mips/include/asm/mach-loongson64/irq.h        |    2 -
 arch/mips/include/asm/mach-loongson64/mmzone.h     |    1 -
 arch/mips/include/asm/unroll.h                     |   64 +-
 arch/mips/kernel/perf_event_mipsxx.c               |    4 +-
 arch/mips/kernel/smp-bmips.c                       |    2 +
 arch/mips/kernel/traps.c                           |   12 +
 arch/mips/kvm/entry.c                              |   21 +-
 arch/mips/kvm/mips.c                               |    3 +-
 arch/mips/kvm/trap_emul.c                          |    2 +-
 arch/mips/kvm/vz.c                                 |    2 +-
 arch/mips/mm/c-r4k.c                               |    4 +
 arch/mips/oprofile/op_model_mipsxx.c               |    4 +-
 arch/mips/sni/a20r.c                               |    4 +-
 arch/nds32/include/asm/irqflags.h                  |    5 +
 arch/nds32/kernel/fpu.c                            |   12 +-
 arch/nds32/kernel/signal.c                         |    4 +-
 arch/openrisc/kernel/signal.c                      |    2 +-
 arch/parisc/kernel/signal.c                        |    2 +-
 arch/parisc/kernel/traps.c                         |   11 +-
 arch/parisc/mm/fault.c                             |    4 +-
 arch/powerpc/Kconfig                               |   12 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    8 +-
 arch/powerpc/include/asm/cputable.h                |   15 +-
 arch/powerpc/include/asm/fixmap.h                  |    2 +-
 arch/powerpc/include/asm/hw_irq.h                  |   11 +-
 arch/powerpc/include/asm/kasan.h                   |    9 +-
 arch/powerpc/include/asm/kvm_host.h                |    1 +
 arch/powerpc/include/asm/mce.h                     |    7 +
 arch/powerpc/include/asm/mman.h                    |   31 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |    2 +
 arch/powerpc/include/asm/perf_event.h              |    3 +
 arch/powerpc/include/asm/perf_event_server.h       |    5 +
 arch/powerpc/include/uapi/asm/mman.h               |    2 +-
 arch/powerpc/include/uapi/asm/perf_regs.h          |   20 +-
 arch/powerpc/kernel/cputable.c                     |   22 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |    6 +-
 arch/powerpc/kernel/entry_64.S                     |    4 +
 arch/powerpc/kernel/process.c                      |   12 +-
 arch/powerpc/kernel/setup-common.c                 |    1 +
 arch/powerpc/kvm/book3s.c                          |    8 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |    2 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |    4 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |    2 +-
 arch/powerpc/kvm/book3s_hv.c                       |   24 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S            |    9 +-
 arch/powerpc/kvm/book3s_hv_nested.c                |    2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |    2 +-
 arch/powerpc/kvm/book3s_pr.c                       |    2 +-
 arch/powerpc/kvm/book3s_xics.c                     |   86 +-
 arch/powerpc/kvm/book3s_xive_native.c              |   12 +-
 arch/powerpc/kvm/booke.c                           |    6 +-
 arch/powerpc/mm/book3s32/mmu.c                     |    9 +-
 arch/powerpc/mm/book3s64/hash_utils.c              |    6 +-
 arch/powerpc/net/bpf_jit_comp.c                    |    2 +-
 arch/powerpc/perf/core-book3s.c                    |   24 +-
 arch/powerpc/perf/hv-24x7.c                        |   11 +-
 arch/powerpc/perf/imc-pmu.c                        |    4 +-
 arch/powerpc/perf/perf_regs.c                      |   44 +-
 arch/powerpc/perf/power10-pmu.c                    |    6 +
 arch/powerpc/perf/power9-pmu.c                     |    6 +
 arch/powerpc/platforms/Kconfig.cputype             |    2 +-
 arch/powerpc/platforms/powernv/idle.c              |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   18 +-
 arch/powerpc/platforms/pseries/ras.c               |    1 -
 arch/riscv/Kconfig                                 |    2 +-
 arch/riscv/Kconfig.socs                            |    2 +
 arch/riscv/configs/nommu_virt_defconfig            |    7 +-
 arch/riscv/configs/rv32_defconfig                  |    5 +
 arch/riscv/include/asm/clint.h                     |   39 -
 arch/riscv/include/asm/smp.h                       |   19 +
 arch/riscv/include/asm/timex.h                     |   28 +-
 arch/riscv/kernel/Makefile                         |    2 +-
 arch/riscv/kernel/clint.c                          |   44 -
 arch/riscv/kernel/sbi.c                            |   14 +
 arch/riscv/kernel/setup.c                          |    2 -
 arch/riscv/kernel/signal.c                         |    2 +-
 arch/riscv/kernel/smp.c                            |   44 +-
 arch/riscv/kernel/smpboot.c                        |    4 +-
 arch/riscv/net/bpf_jit_comp32.c                    |    4 +-
 arch/s390/Kconfig                                  |    2 +-
 arch/s390/configs/debug_defconfig                  |    4 +
 arch/s390/configs/defconfig                        |    3 +
 arch/s390/configs/zfcpdump_defconfig               |    1 +
 arch/s390/include/asm/percpu.h                     |   28 +-
 arch/s390/kernel/idle.c                            |    3 +-
 arch/s390/kernel/ptrace.c                          |    7 +-
 arch/s390/kernel/runtime_instr.c                   |    2 +-
 arch/s390/mm/vmem.c                                |    1 +
 arch/s390/pci/pci.c                                |   22 +-
 arch/s390/pci/pci_bus.c                            |   52 +-
 arch/s390/pci/pci_bus.h                            |   13 +
 arch/s390/pci/pci_event.c                          |    7 +-
 arch/sh/drivers/platform_early.c                   |    2 +-
 arch/sh/kernel/disassemble.c                       |    4 +-
 arch/sh/kernel/kgdb.c                              |    2 +-
 arch/sh/kernel/signal_32.c                         |    2 +-
 arch/sparc/kernel/auxio_64.c                       |    1 -
 arch/sparc/kernel/central.c                        |    2 +-
 arch/sparc/kernel/kgdb_32.c                        |    2 +-
 arch/sparc/kernel/kgdb_64.c                        |    2 +-
 arch/sparc/kernel/pcr.c                            |    2 +-
 arch/sparc/kernel/prom_32.c                        |    2 +-
 arch/sparc/kernel/signal32.c                       |    4 +-
 arch/sparc/kernel/signal_32.c                      |    4 +-
 arch/sparc/kernel/signal_64.c                      |    4 +-
 arch/sparc/math-emu/math_32.c                      |    8 +-
 arch/sparc/net/bpf_jit_comp_32.c                   |    2 +-
 arch/um/kernel/signal.c                            |    2 +-
 arch/x86/boot/cmdline.c                            |    4 +-
 arch/x86/boot/compressed/kaslr.c                   |  240 ++-
 arch/x86/boot/compressed/misc.c                    |    7 +-
 arch/x86/boot/compressed/misc.h                    |    4 +-
 arch/x86/boot/string.h                             |    5 +-
 arch/x86/entry/calling.h                           |   10 +-
 arch/x86/entry/common.c                            |   29 +-
 arch/x86/entry/thunk_32.S                          |    5 -
 arch/x86/events/intel/core.c                       |    6 +-
 arch/x86/events/intel/lbr.c                        |    2 +-
 arch/x86/events/intel/uncore_snb.c                 |   52 +-
 arch/x86/include/asm/cpufeatures.h                 |    1 +
 arch/x86/include/asm/efi.h                         |   10 -
 arch/x86/include/asm/entry-common.h                |   12 +-
 arch/x86/include/asm/fpu/internal.h                |    7 +-
 arch/x86/include/asm/kvm_host.h                    |   70 +-
 arch/x86/include/asm/mmu.h                         |    1 +
 arch/x86/include/asm/ptrace.h                      |    2 +-
 arch/x86/include/asm/special_insns.h               |    6 +
 arch/x86/include/asm/svm.h                         |  196 ++-
 arch/x86/include/asm/sync_core.h                   |   34 +-
 arch/x86/include/asm/vmx.h                         |    2 +-
 arch/x86/include/uapi/asm/kvm.h                    |   20 +
 arch/x86/include/uapi/asm/svm.h                    |    2 +
 arch/x86/kernel/alternative.c                      |    2 +-
 arch/x86/kernel/apic/io_apic.c                     |    4 +-
 arch/x86/kernel/apic/probe_32.c                    |    2 +-
 arch/x86/kernel/apic/vector.c                      |   16 +-
 arch/x86/kernel/cpu/cacheinfo.c                    |    2 +-
 arch/x86/kernel/cpu/mce/inject.c                   |    2 +-
 arch/x86/kernel/cpu/mce/intel.c                    |    2 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c                   |    2 +-
 arch/x86/kernel/hw_breakpoint.c                    |    2 +-
 arch/x86/kernel/kgdb.c                             |    4 +-
 arch/x86/kernel/kvm.c                              |    2 +-
 arch/x86/kernel/mpparse.c                          |    4 +-
 arch/x86/kernel/process.c                          |    4 -
 arch/x86/kernel/ptrace.c                           |    2 +-
 arch/x86/kernel/reboot.c                           |    2 +-
 arch/x86/kernel/signal.c                           |    2 +-
 arch/x86/kernel/smpboot.c                          |   26 +-
 arch/x86/kernel/traps.c                            |   65 +-
 arch/x86/kernel/umip.c                             |   40 +-
 arch/x86/kernel/uprobes.c                          |    4 +-
 arch/x86/kvm/Kconfig                               |    1 +
 arch/x86/kvm/Makefile                              |    6 +-
 arch/x86/kvm/cpuid.c                               |  139 +-
 arch/x86/kvm/cpuid.h                               |   15 +
 arch/x86/kvm/emulate.c                             |   24 +-
 arch/x86/kvm/hyperv.c                              |   13 +-
 arch/x86/kvm/irq_comm.c                            |    2 +-
 arch/x86/kvm/kvm_cache_regs.h                      |    2 +-
 arch/x86/kvm/lapic.c                               |   49 +-
 arch/x86/kvm/lapic.h                               |    1 +
 arch/x86/kvm/mmu.h                                 |    5 -
 arch/x86/kvm/mmu/mmu.c                             |  976 ++++-------
 arch/x86/kvm/mmu/mmu_internal.h                    |   88 +-
 arch/x86/kvm/mmu/mmutrace.h                        |   21 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     |   50 +-
 arch/x86/kvm/mmu/spte.c                            |  318 ++++
 arch/x86/kvm/mmu/spte.h                            |  252 +++
 arch/x86/kvm/mmu/tdp_iter.c                        |  182 ++
 arch/x86/kvm/mmu/tdp_iter.h                        |   60 +
 arch/x86/kvm/mmu/tdp_mmu.c                         | 1157 +++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.h                         |   48 +
 arch/x86/kvm/svm/avic.c                            |    7 +-
 arch/x86/kvm/svm/nested.c                          |  394 +++--
 arch/x86/kvm/svm/sev.c                             |   26 +-
 arch/x86/kvm/svm/svm.c                             |  408 +++--
 arch/x86/kvm/svm/svm.h                             |  103 +-
 arch/x86/kvm/trace.h                               |  128 +-
 arch/x86/kvm/vmx/capabilities.h                    |   10 +-
 arch/x86/kvm/vmx/nested.c                          |  178 +-
 arch/x86/kvm/vmx/posted_intr.c                     |  332 ++++
 arch/x86/kvm/vmx/posted_intr.h                     |   99 ++
 arch/x86/kvm/vmx/vmcs.h                            |    7 +
 arch/x86/kvm/vmx/vmenter.S                         |   34 +
 arch/x86/kvm/vmx/vmx.c                             | 1269 ++++++--------
 arch/x86/kvm/vmx/vmx.h                             |  143 +-
 arch/x86/kvm/vmx/{ops.h => vmx_ops.h}              |    0
 arch/x86/kvm/x86.c                                 |  705 ++++++--
 arch/x86/kvm/x86.h                                 |    5 +-
 arch/x86/lib/Makefile                              |    2 +-
 arch/x86/lib/cmdline.c                             |    8 +-
 arch/x86/lib/insn-eval.c                           |    6 +-
 arch/x86/math-emu/errors.c                         |    2 +-
 arch/x86/math-emu/fpu_trig.c                       |    2 +-
 arch/x86/mm/fault.c                                |   91 +-
 arch/x86/mm/ioremap.c                              |    2 +-
 arch/x86/mm/numa_emulation.c                       |    2 +-
 arch/x86/mm/tlb.c                                  |   13 +-
 arch/x86/pci/xen.c                                 |    1 +
 arch/x86/platform/efi/efi.c                        |   69 -
 arch/x86/platform/efi/efi_32.c                     |   44 +-
 arch/x86/platform/efi/efi_64.c                     |    2 +
 arch/xtensa/kernel/signal.c                        |    2 +-
 block/badblocks.c                                  |    2 +-
 block/bfq-cgroup.c                                 |    2 +-
 block/bfq-iosched.c                                |    4 +-
 block/bfq-iosched.h                                |    1 -
 block/bfq-wf2q.c                                   |   12 +-
 block/bio.c                                        |   10 +-
 block/blk-cgroup.c                                 |    8 +-
 block/blk-core.c                                   |    1 +
 block/blk-iocost.c                                 |    5 +-
 block/blk-merge.c                                  |   13 +-
 block/blk-mq-sched.c                               |    9 +
 block/blk-mq.c                                     |   13 +-
 block/blk-stat.c                                   |   17 +-
 block/blk-wbt.c                                    |    2 +-
 block/bsg-lib.c                                    |    2 +-
 block/ioprio.c                                     |    2 +-
 block/partitions/core.c                            |   37 +-
 crypto/af_alg.c                                    |   13 +-
 crypto/drbg.c                                      |    2 +-
 crypto/tcrypt.c                                    |  114 +-
 drivers/accessibility/braille/braille_console.c    |    2 +-
 drivers/accessibility/speakup/Kconfig              |   13 +-
 drivers/accessibility/speakup/Makefile             |    2 +-
 drivers/accessibility/speakup/serialio.c           |    8 +-
 drivers/accessibility/speakup/spk_priv.h           |    1 -
 drivers/accessibility/speakup/spk_ttyio.c          |    7 +
 drivers/accessibility/speakup/spk_types.h          |    1 +
 drivers/accessibility/speakup/synth.c              |    2 +-
 drivers/acpi/acpi_apd.c                            |    4 +-
 drivers/acpi/osl.c                                 |   23 +-
 drivers/ata/ahci.c                                 |    3 +-
 drivers/ata/ahci_brcm.c                            |    2 +-
 drivers/ata/libahci_platform.c                     |    2 +-
 drivers/ata/libata-core.c                          |   21 +-
 drivers/ata/libata-eh.c                            |    6 +-
 drivers/ata/libata-scsi.c                          |   12 +-
 drivers/ata/pata_atp867x.c                         |    4 +-
 drivers/ata/pata_serverworks.c                     |    2 +-
 drivers/ata/sata_mv.c                              |   12 +-
 drivers/ata/sata_promise.c                         |    8 +-
 drivers/ata/sata_sx4.c                             |    2 +-
 drivers/atm/firestream.c                           |    3 +-
 drivers/atm/fore200e.c                             |   16 +-
 drivers/atm/he.c                                   |    4 +-
 drivers/atm/idt77105.c                             |    2 +-
 drivers/atm/lanai.c                                |    2 +-
 drivers/atm/zatm.c                                 |    2 +-
 drivers/auxdisplay/arm-charlcd.c                   |    2 +-
 drivers/auxdisplay/panel.c                         |    6 +-
 drivers/base/core.c                                |   12 +-
 drivers/base/firmware_loader/fallback.c            |    4 +-
 drivers/base/power/main.c                          |   16 +-
 drivers/block/aoe/aoecmd.c                         |    2 +-
 drivers/block/ataflop.c                            |    2 +-
 drivers/block/drbd/drbd_int.h                      |    2 +-
 drivers/block/drbd/drbd_main.c                     |    2 +-
 drivers/block/drbd/drbd_nl.c                       |    2 +-
 drivers/block/drbd/drbd_receiver.c                 |   12 +-
 drivers/block/drbd/drbd_req.c                      |    4 +-
 drivers/block/floppy.c                             |    4 +-
 drivers/block/loop.c                               |   41 +-
 drivers/block/nbd.c                                |    2 +
 drivers/block/null_blk_main.c                      |    2 +-
 drivers/block/paride/pd.c                          |    4 +-
 drivers/block/pktcdvd.c                            |    2 +-
 drivers/block/rbd.c                                |    8 +-
 drivers/block/rnbd/rnbd-srv.c                      |    3 +-
 drivers/block/rsxx/core.c                          |    2 +-
 drivers/block/skd_main.c                           |    2 +-
 drivers/block/virtio_blk.c                         |   31 +-
 drivers/block/xen-blkback/blkback.c                |    2 +-
 drivers/block/xen-blkback/xenbus.c                 |    2 +-
 drivers/block/xen-blkfront.c                       |    5 +-
 drivers/bus/ti-sysc.c                              |    2 +-
 drivers/char/agp/ali-agp.c                         |    2 +-
 drivers/char/hw_random/ingenic-rng.c               |    9 +-
 drivers/char/ipmi/kcs_bmc.c                        |    2 +-
 drivers/char/lp.c                                  |    4 +-
 drivers/char/mem.c                                 |    2 +-
 drivers/char/nvram.c                               |    2 +-
 drivers/clocksource/Kconfig                        |   12 +-
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/timer-cadence-ttc.c            |    4 +-
 drivers/clocksource/timer-clint.c                  |  226 +++
 drivers/clocksource/timer-riscv.c                  |   17 +-
 drivers/cpufreq/cpufreq.c                          |    3 +-
 drivers/cpufreq/intel_pstate.c                     |  236 ++-
 drivers/cpufreq/p4-clockmod.c                      |    2 +-
 drivers/cpufreq/speedstep-lib.c                    |    2 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |   10 +-
 drivers/cpufreq/ti-cpufreq.c                       |    4 +-
 drivers/cpuidle/cpuidle.c                          |   19 +-
 drivers/crypto/Kconfig                             |    3 +
 drivers/crypto/axis/artpec6_crypto.c               |    2 +-
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c       |    4 +-
 drivers/crypto/chelsio/chcr_ktls.c                 |    4 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c |    4 +-
 drivers/crypto/qat/qat_common/adf_admin.c          |    7 +-
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c      |    2 +-
 drivers/crypto/qat/qat_common/qat_uclo.c           |    6 +-
 drivers/crypto/ux500/cryp/cryp.c                   |   12 +-
 drivers/dax/device.c                               |    2 +-
 drivers/dax/super.c                                |    6 +
 drivers/dma/acpi-dma.c                             |    4 +-
 drivers/dma/amba-pl08x.c                           |   10 +-
 drivers/dma/at_hdmac.c                             |   11 +-
 drivers/dma/dma-jz4780.c                           |   38 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |   11 +-
 drivers/dma/fsldma.c                               |    2 +-
 drivers/dma/fsldma.h                               |   12 +-
 drivers/dma/idxd/device.c                          |   26 +
 drivers/dma/idxd/irq.c                             |   12 -
 drivers/dma/imx-dma.c                              |    2 +-
 drivers/dma/iop-adma.h                             |   12 +-
 drivers/dma/nbpfaxi.c                              |    2 +-
 drivers/dma/of-dma.c                               |    8 +-
 drivers/dma/pl330.c                                |   12 +-
 drivers/dma/sh/shdma-base.c                        |    2 +-
 drivers/dma/ti/k3-udma.c                           |   10 +-
 drivers/edac/amd64_edac.c                          |    2 +-
 drivers/edac/ghes_edac.c                           |   10 +-
 drivers/edac/i7core_edac.c                         |    4 +-
 drivers/edac/pnd2_edac.c                           |    4 +-
 drivers/edac/sb_edac.c                             |    4 +-
 drivers/edac/skx_common.c                          |    4 +-
 drivers/firewire/core-device.c                     |    2 +-
 drivers/firewire/core-iso.c                        |    2 +-
 drivers/firewire/core-topology.c                   |    2 +-
 drivers/firewire/core-transaction.c                |    4 +-
 drivers/firewire/ohci.c                            |    4 +-
 drivers/firmware/efi/efi.c                         |    2 +
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   12 +-
 drivers/firmware/ti_sci.c                          |  155 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   |    6 +-
 drivers/gpio/gpio-aspeed.c                         |    6 +-
 drivers/gpio/gpio-ath79.c                          |    2 +-
 drivers/gpio/gpio-eic-sprd.c                       |    4 +-
 drivers/gpio/gpio-stmpe.c                          |    4 +-
 drivers/gpio/gpiolib-acpi.c                        |    2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |   19 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   19 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   94 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   16 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   28 +
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |    3 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   10 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |    4 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    2 +-
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.h    |    2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   24 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   53 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |    8 +
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |   16 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |   14 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |    4 +-
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |    4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |    2 +-
 .../amd/display/dc/dcn30/dcn30_dio_link_encoder.h  |    5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |    1 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |    4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    2 +
 .../drm/amd/display/include/bios_parser_types.h    |    7 +
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |    3 +
 .../drm/amd/display/modules/freesync/freesync.c    |   36 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |   19 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |    9 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    3 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |   32 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |   21 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   44 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c   |   21 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |   10 +-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |   25 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |    2 +
 drivers/gpu/drm/arm/malidp_hw.c                    |    6 +-
 drivers/gpu/drm/ast/ast_main.c                     |    2 +-
 drivers/gpu/drm/bridge/nwl-dsi.c                   |    2 -
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |    4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    6 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    7 +-
 drivers/gpu/drm/drm_bufs.c                         |    2 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |    2 +-
 drivers/gpu/drm/drm_crtc.c                         |    4 +-
 drivers/gpu/drm/drm_dp_helper.c                    |    2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    4 +-
 drivers/gpu/drm/drm_mode_object.c                  |    4 +-
 drivers/gpu/drm/drm_modes.c                        |    2 +-
 drivers/gpu/drm/drm_plane.c                        |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   11 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   11 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   10 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |    6 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |    6 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |    6 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   10 +-
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |   10 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |    4 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   22 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |    7 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   14 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |    8 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |   32 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |    2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   12 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |   22 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |    6 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |    8 -
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |    2 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |    2 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |    2 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c               |   24 +
 drivers/gpu/drm/i915/gvt/gtt.c                     |    2 +-
 drivers/gpu/drm/i915/gvt/gtt.h                     |    2 +
 drivers/gpu/drm/i915/gvt/gvt.h                     |    3 +
 drivers/gpu/drm/i915/gvt/handlers.c                |    2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   20 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   14 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |    2 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |    9 +-
 drivers/gpu/drm/i915/selftests/i915_buddy.c        |   18 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |    3 +
 drivers/gpu/drm/imx/ipuv3-plane.c                  |    2 +-
 drivers/gpu/drm/meson/meson_osd_afbcd.c            |    2 +-
 drivers/gpu/drm/meson/meson_overlay.c              |    4 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   40 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |    2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |    3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    4 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |    2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   20 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    4 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   36 +
 drivers/gpu/drm/msm/msm_drv.c                      |    8 +
 drivers/gpu/drm/msm/msm_ringbuffer.c               |    3 +-
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |    5 +-
 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c         |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |    6 +
 drivers/gpu/drm/nouveau/include/nvif/push507c.h    |    2 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |    2 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    3 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |    2 +-
 drivers/gpu/drm/radeon/r300.c                      |    4 +-
 drivers/gpu/drm/radeon/r420.c                      |    2 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |    4 +-
 drivers/gpu/drm/radeon/radeon_display.c            |    2 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |    2 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |    2 +-
 drivers/gpu/drm/radeon/uvd_v1_0.c                  |    2 +-
 drivers/gpu/drm/savage/savage_state.c              |   10 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    6 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    4 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |    2 +-
 drivers/gpu/drm/tegra/dc.c                         |    2 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    2 +-
 drivers/gpu/drm/via/via_dmablit.c                  |    8 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    1 +
 drivers/gpu/drm/virtio/virtgpu_object.c            |    1 +
 drivers/gpu/drm/xen/xen_drm_front.c                |    3 -
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |    9 +-
 drivers/gpu/ipu-v3/ipu-dc.c                        |    2 +-
 drivers/hid/hid-core.c                             |   15 +-
 drivers/hid/hid-cougar.c                           |    2 +-
 drivers/hid/hid-elan.c                             |    2 +
 drivers/hid/hid-ids.h                              |    6 +
 drivers/hid/hid-input.c                            |    4 +
 drivers/hid/hid-lg-g15.c                           |    2 +-
 drivers/hid/hid-logitech-dj.c                      |    2 +-
 drivers/hid/hid-macally.c                          |    2 +-
 drivers/hid/hid-microsoft.c                        |    5 +-
 drivers/hid/hid-multitouch.c                       |    2 +
 drivers/hid/hid-quirks.c                           |    5 +
 drivers/hid/hid-rmi.c                              |    1 -
 drivers/hid/hid-roccat-kone.c                      |    2 +-
 drivers/hid/hid-uclogic-params.c                   |    2 +-
 drivers/hid/hid-wiimote-core.c                     |    2 -
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   22 +-
 drivers/hid/usbhid/hid-core.c                      |   53 +-
 drivers/hid/usbhid/hiddev.c                        |    5 +-
 drivers/hid/usbhid/usbhid.h                        |    2 -
 drivers/hid/wacom_wac.c                            |   32 +-
 drivers/hsi/clients/ssi_protocol.c                 |    6 +-
 drivers/hsi/controllers/omap_ssi_core.c            |    2 +-
 drivers/hv/hv_kvp.c                                |    2 +-
 drivers/hv/hv_util.c                               |   65 +-
 drivers/hwmon/adt7462.c                            |    8 +-
 drivers/hwmon/applesmc.c                           |   31 +-
 drivers/hwmon/emc1403.c                            |    4 +-
 drivers/hwmon/f71882fg.c                           |    4 +-
 drivers/hwmon/gsc-hwmon.c                          |    1 +
 drivers/hwmon/hwmon-vid.c                          |    4 +-
 drivers/hwmon/ina3221.c                            |    2 +-
 drivers/hwmon/nct6775.c                            |    2 +-
 drivers/hwmon/nct7904.c                            |    4 +-
 drivers/hwmon/occ/common.c                         |    6 +-
 drivers/hwmon/pmbus/isl68137.c                     |    7 +-
 drivers/hwmon/w83627hf.c                           |    2 +-
 drivers/hwmon/w83781d.c                            |    2 +-
 drivers/hwmon/w83795.c                             |    2 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |    1 -
 drivers/hwtracing/coresight/coresight-tmc.c        |    2 -
 drivers/hwtracing/intel_th/sth.c                   |    4 +-
 drivers/i2c/busses/i2c-bcm-iproc.c                 |    4 +-
 drivers/i2c/busses/i2c-omap.c                      |    1 -
 drivers/i2c/busses/i2c-opal.c                      |    2 +-
 drivers/i2c/busses/i2c-rcar.c                      |    1 +
 drivers/i2c/i2c-core-acpi.c                        |   10 -
 drivers/i2c/i2c-core-base.c                        |    2 +-
 drivers/i2c/i2c-core.h                             |    9 -
 drivers/i3c/master/dw-i3c-master.c                 |    2 +-
 drivers/ide/hpt366.c                               |    6 +-
 drivers/ide/ide-cd.c                               |    4 +-
 drivers/ide/ide-floppy.c                           |    2 +-
 drivers/ide/ide-probe.c                            |    2 +-
 drivers/ide/ide-taskfile.c                         |   12 +-
 drivers/ide/sis5513.c                              |    2 +-
 drivers/idle/intel_idle.c                          |   16 -
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/adc/ab8500-gpadc.c                     |    2 +-
 drivers/iio/adc/cpcap-adc.c                        |    2 +-
 drivers/iio/chemical/sps30.c                       |    2 +-
 drivers/iio/dac/ad5592r-base.c                     |    2 -
 drivers/iio/dac/dpot-dac.c                         |    5 +-
 drivers/iio/health/max30102.c                      |    4 +-
 drivers/iio/imu/adis.c                             |    6 +-
 drivers/iio/industrialio-core.c                    |    4 +-
 drivers/iio/light/si1145.c                         |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    2 +-
 drivers/infiniband/core/cm.c                       |   12 +-
 drivers/infiniband/core/cma.c                      |    3 +-
 drivers/infiniband/core/device.c                   |    2 +-
 drivers/infiniband/core/rw.c                       |    1 -
 drivers/infiniband/core/ucma.c                     |    4 +-
 drivers/infiniband/core/uverbs_ioctl.c             |    4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |    2 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |    2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |    4 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |    2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c              |    1 -
 drivers/infiniband/hw/hfi1/tid_rdma.c              |    1 +
 drivers/infiniband/hw/hns/hns_roce_device.h        |    2 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |    2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |    9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |    4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |    5 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |    5 +-
 drivers/infiniband/hw/i40iw/i40iw_hw.c             |    3 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c           |   22 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.c           |    4 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |    8 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |    5 +-
 drivers/infiniband/hw/mlx4/cq.c                    |    4 +-
 drivers/infiniband/hw/mlx4/mcg.c                   |    2 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    6 +-
 drivers/infiniband/hw/mlx5/cq.c                    |    4 +-
 drivers/infiniband/hw/mlx5/mad.c                   |    3 +-
 drivers/infiniband/hw/mlx5/main.c                  |    2 +-
 drivers/infiniband/hw/mlx5/qp.c                    |    4 +-
 drivers/infiniband/hw/mthca/mthca_av.c             |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    4 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    2 +-
 drivers/infiniband/hw/qib/qib_iba6120.c            |    4 +-
 drivers/infiniband/hw/qib/qib_iba7220.c            |    4 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |    6 +-
 drivers/infiniband/hw/qib/qib_mad.c                |   12 +-
 drivers/infiniband/hw/qib/qib_rc.c                 |   18 +-
 drivers/infiniband/hw/qib/qib_sdma.c               |    2 +-
 drivers/infiniband/hw/qib/qib_uc.c                 |    8 +-
 drivers/infiniband/hw/qib/qib_verbs.c              |    2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |    2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |    2 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |    2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |    2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |    2 -
 drivers/infiniband/sw/siw/siw_qp_rx.c              |    4 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c              |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |    2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   10 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    |    1 -
 drivers/input/joystick/fsia6b.c                    |    4 +-
 drivers/input/joystick/gamecon.c                   |    1 -
 drivers/input/tablet/wacom_serial4.c               |    2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |    2 +-
 drivers/input/touchscreen/wm831x-ts.c              |    2 +-
 drivers/iommu/amd/Kconfig                          |    2 +-
 drivers/iommu/amd/init.c                           |   23 +-
 drivers/iommu/amd/iommu.c                          |   26 +-
 drivers/iommu/amd/iommu_v2.c                       |    7 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   11 +-
 drivers/iommu/dma-iommu.c                          |    4 +-
 drivers/iommu/intel/iommu.c                        |  115 +-
 drivers/iommu/intel/irq_remapping.c                |   10 +-
 drivers/iommu/virtio-iommu.c                       |    2 +-
 drivers/irqchip/Kconfig                            |    2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    4 +-
 drivers/irqchip/irq-gic-v3.c                       |    8 +-
 drivers/irqchip/irq-imx-gpcv2.c                    |    2 +-
 drivers/irqchip/irq-ingenic.c                      |    2 +-
 drivers/irqchip/irq-mips-gic.c                     |    2 +-
 drivers/irqchip/irq-mtk-cirq.c                     |    4 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |    4 +-
 drivers/irqchip/irq-stm32-exti.c                   |   14 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   95 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |  152 +-
 drivers/irqchip/irq-vic.c                          |    2 +-
 drivers/irqchip/irqchip.c                          |    2 +-
 drivers/irqchip/qcom-pdc.c                         |    8 +-
 drivers/isdn/hardware/mISDN/avmfritz.c             |    2 +-
 drivers/isdn/hardware/mISDN/hfc_multi_8xx.h        |    1 -
 drivers/isdn/hardware/mISDN/hfcpci.c               |    2 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c              |    2 +-
 drivers/isdn/hardware/mISDN/isdnhdlc.c             |    2 +-
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        |    2 +-
 drivers/isdn/hardware/mISDN/mISDNisar.c            |    8 +-
 drivers/isdn/mISDN/stack.c                         |    2 +-
 drivers/lightnvm/pblk-core.c                       |    2 +-
 drivers/macintosh/adbhid.c                         |    2 +-
 drivers/macintosh/smu.c                            |    2 +-
 drivers/md/bcache/journal.c                        |    2 +-
 drivers/md/bcache/util.c                           |   14 +-
 drivers/md/dm-cache-metadata.c                     |    8 +-
 drivers/md/dm-crypt.c                              |    6 +-
 drivers/md/dm-integrity.c                          |   12 +
 drivers/md/dm-mpath.c                              |   24 +-
 drivers/md/dm-thin-metadata.c                      |   10 +-
 drivers/md/dm-writecache.c                         |   12 +-
 drivers/md/dm.c                                    |    2 +-
 drivers/md/md-autodetect.c                         |    4 +-
 drivers/md/md-bitmap.c                             |    2 +-
 drivers/md/persistent-data/dm-block-manager.c      |   14 +-
 drivers/md/raid5.c                                 |   11 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |   36 +-
 drivers/media/dvb-core/dvb_net.c                   |    2 +-
 drivers/media/dvb-frontends/bcm3510.c              |    2 +-
 drivers/media/dvb-frontends/dib0090.c              |    2 +-
 drivers/media/dvb-frontends/dib3000mb.c            |    2 +-
 drivers/media/dvb-frontends/dib7000p.c             |    2 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |  103 +-
 drivers/media/dvb-frontends/drxd_hard.c            |   12 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   24 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |    2 +-
 drivers/media/dvb-frontends/mt352.c                |    2 +-
 drivers/media/dvb-frontends/mxl5xx.c               |    2 +-
 drivers/media/dvb-frontends/or51132.c              |    2 +-
 drivers/media/dvb-frontends/s5h1411.c              |    2 +-
 drivers/media/dvb-frontends/zl10353.c              |    4 +-
 drivers/media/i2c/Kconfig                          |    4 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |    4 +-
 drivers/media/pci/ddbridge/ddbridge-core.c         |   23 +-
 drivers/media/pci/meye/meye.c                      |    2 +-
 drivers/media/pci/ttpci/av7110.c                   |    4 +-
 drivers/media/pci/ttpci/av7110_hw.c                |    2 +-
 drivers/media/pci/ttpci/av7110_ipack.c             |    2 +-
 drivers/media/pci/ttpci/budget-av.c                |    2 +-
 drivers/media/pci/ttpci/budget.c                   |    4 +-
 drivers/media/platform/sh_vou.c                    |    4 +-
 drivers/media/platform/ti-vpe/cal.h                |    2 +-
 drivers/media/radio/radio-si476x.c                 |    3 +-
 drivers/media/radio/tea575x.c                      |    2 +-
 drivers/media/rc/bpf-lirc.c                        |    2 +-
 drivers/media/rc/gpio-ir-tx.c                      |   16 +-
 drivers/media/rc/ir-rc6-decoder.c                  |    2 +-
 drivers/media/rc/ir-sony-decoder.c                 |    2 +-
 drivers/media/rc/mceusb.c                          |    2 +-
 drivers/media/rc/rc-main.c                         |   44 +-
 drivers/media/test-drivers/vicodec/vicodec-core.c  |    1 +
 drivers/media/tuners/xc5000.c                      |    2 +-
 drivers/media/usb/b2c2/flexcop-usb.c               |    2 +-
 drivers/media/usb/cpia2/cpia2_core.c               |   36 +-
 drivers/media/usb/cx231xx/cx231xx-video.c          |    2 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c        |   12 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |    6 +-
 drivers/media/v4l2-core/v4l2-ctrls.c               |    2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   52 +-
 drivers/media/v4l2-core/videobuf-core.c            |    2 +-
 drivers/memory/omap-gpmc.c                         |    1 -
 drivers/memstick/core/ms_block.c                   |   12 +-
 drivers/memstick/host/jmb38x_ms.c                  |    4 +-
 drivers/memstick/host/tifm_ms.c                    |    4 +-
 drivers/message/fusion/mptbase.c                   |    6 +-
 drivers/message/fusion/mptsas.c                    |    2 +-
 drivers/message/fusion/mptscsih.c                  |    4 +-
 drivers/mfd/db8500-prcmu.c                         |    4 +-
 drivers/mfd/iqs62x.c                               |    6 +-
 drivers/mfd/mfd-core.c                             |   12 +-
 drivers/mfd/mxs-lradc.c                            |    2 +-
 drivers/mfd/omap-usb-host.c                        |    4 +-
 drivers/mfd/rave-sp.c                              |    4 +-
 drivers/mfd/syscon.c                               |    2 +-
 drivers/misc/eeprom/at25.c                         |   10 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   16 +-
 .../misc/habanalabs/common/command_submission.c    |    8 +
 drivers/misc/habanalabs/common/debugfs.c           |    8 +-
 drivers/misc/habanalabs/common/device.c            |    9 +-
 drivers/misc/habanalabs/common/firmware_if.c       |    9 +
 drivers/misc/habanalabs/common/habanalabs.h        |    7 +-
 drivers/misc/habanalabs/common/memory.c            |    9 +-
 drivers/misc/habanalabs/common/mmu.c               |    2 +-
 drivers/misc/habanalabs/common/pci.c               |    8 +-
 drivers/misc/habanalabs/common/sysfs.c             |    7 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   92 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    3 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    8 +-
 drivers/misc/habanalabs/goya/goya.c                |   31 +
 drivers/misc/habanalabs/goya/goya_coresight.c      |    8 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |   40 +-
 drivers/misc/mic/scif/scif_api.c                   |    4 +-
 drivers/misc/mic/scif/scif_rma.c                   |    2 +-
 drivers/misc/sgi-gru/grukservices.c                |    4 +-
 drivers/misc/sgi-xp/xpc_main.c                     |    4 +-
 drivers/misc/sgi-xp/xpc_partition.c                |    4 +-
 drivers/misc/sgi-xp/xpc_uv.c                       |    2 +-
 drivers/mmc/core/host.c                            |    2 +-
 drivers/mmc/host/atmel-mci.c                       |    8 +-
 drivers/mmc/host/davinci_mmc.c                     |    2 +-
 drivers/mmc/host/dw_mmc-k3.c                       |    2 +-
 drivers/mmc/host/dw_mmc.c                          |    6 +-
 drivers/mmc/host/jz4740_mmc.c                      |    4 +-
 drivers/mmc/host/meson-mx-sdio.c                   |    2 +-
 drivers/mmc/host/mtk-sd.c                          |   13 +
 drivers/mmc/host/renesas_sdhi_core.c               |    2 +-
 drivers/mmc/host/sdhci-acpi.c                      |   67 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |    2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   10 +-
 drivers/mmc/host/sdhci-s3c.c                       |    2 +-
 drivers/mmc/host/sdhci-sprd.c                      |    2 +-
 drivers/mmc/host/sdhci-tegra.c                     |   55 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |    2 +-
 drivers/mmc/host/sdhci.c                           |    2 +-
 drivers/mmc/host/tifm_sd.c                         |    2 +-
 drivers/mmc/host/usdhi6rol0.c                      |    6 +-
 drivers/mux/adgs1408.c                             |    2 +-
 drivers/net/appletalk/cops.c                       |    2 +-
 drivers/net/arcnet/arc-rimi.c                      |    6 +-
 drivers/net/arcnet/com20020-isa.c                  |   12 +-
 drivers/net/arcnet/com90io.c                       |    4 +-
 drivers/net/arcnet/com90xx.c                       |    6 +-
 drivers/net/bonding/bond_3ad.c                     |   19 +-
 drivers/net/bonding/bond_alb.c                     |    4 +-
 drivers/net/bonding/bond_main.c                    |   54 +-
 drivers/net/can/at91_can.c                         |    4 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |    2 +-
 drivers/net/can/sja1000/sja1000_platform.c         |    2 +-
 drivers/net/can/slcan.c                            |    4 +-
 drivers/net/can/spi/mcp251x.c                      |    2 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c            |    2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c        |    4 +-
 drivers/net/dsa/b53/b53_common.c                   |    4 +-
 drivers/net/dsa/b53/b53_serdes.c                   |    2 +-
 drivers/net/dsa/bcm_sf2.c                          |    2 +-
 drivers/net/dsa/microchip/ksz9477.c                |    2 +-
 drivers/net/dsa/mt7530.c                           |    9 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    2 +-
 drivers/net/dsa/ocelot/Kconfig                     |    2 +-
 drivers/net/dsa/ocelot/felix.c                     |    1 +
 drivers/net/dsa/sja1105/sja1105_main.c             |    2 +-
 drivers/net/ethernet/3com/3c509.c                  |    4 +-
 drivers/net/ethernet/3com/3c574_cs.c               |    8 +-
 drivers/net/ethernet/8390/axnet_cs.c               |    3 +-
 drivers/net/ethernet/8390/pcnet_cs.c               |    2 +-
 drivers/net/ethernet/alacritech/slicoss.c          |   12 +-
 drivers/net/ethernet/alteon/acenic.c               |    2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   35 +-
 drivers/net/ethernet/amd/amd8111e.c                |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |    6 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |   13 +
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |    4 +-
 drivers/net/ethernet/arc/emac_mdio.c               |    1 +
 drivers/net/ethernet/broadcom/bcmsysport.c         |    6 +-
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |    2 +-
 drivers/net/ethernet/broadcom/bgmac-platform.c     |    2 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   14 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |   14 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  106 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   20 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    4 +-
 drivers/net/ethernet/broadcom/cnic.c               |    4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    6 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   71 +-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c         |    6 +-
 drivers/net/ethernet/brocade/bna/bna_enet.c        |    2 +-
 drivers/net/ethernet/brocade/bna/bna_tx_rx.c       |    2 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |   29 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |   25 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |    2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |    4 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/l2t.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |    8 +-
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |   10 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    6 +-
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |    2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |    2 +-
 drivers/net/ethernet/cortina/gemini.c              |   38 +-
 drivers/net/ethernet/davicom/dm9000.c              |    2 +-
 drivers/net/ethernet/dec/tulip/de4x5.c             |    6 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c        |    2 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c       |    2 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |    2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    4 +-
 drivers/net/ethernet/freescale/fec_main.c          |    4 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    2 +-
 drivers/net/ethernet/freescale/fman/fman_port.c    |    4 +-
 drivers/net/ethernet/freescale/gianfar.c           |    4 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    9 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    8 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |    4 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |    2 +-
 drivers/net/ethernet/ibm/emac/core.c               |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   15 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    1 -
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   35 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    3 +
 drivers/net/ethernet/intel/igb/igb_main.c          |    1 -
 drivers/net/ethernet/intel/igc/igc_main.c          |    5 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |    2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |    2 +-
 drivers/net/ethernet/marvell/mvneta.c              |    4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    4 +-
 drivers/net/ethernet/marvell/skge.c                |    2 +-
 drivers/net/ethernet/marvell/sky2.c                |    4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    6 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c            |    2 +-
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c    |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   18 +-
 drivers/net/ethernet/mellanox/mlxsw/core_env.c     |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   32 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |    6 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   12 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |    2 +-
 drivers/net/ethernet/mscc/ocelot.c                 |    2 +-
 drivers/net/ethernet/natsemi/natsemi.c             |    2 +-
 drivers/net/ethernet/neterion/vxge/vxge-config.c   |    6 +-
 drivers/net/ethernet/netronome/nfp/crypto/tls.c    |    2 +-
 drivers/net/ethernet/netronome/nfp/flower/action.c |    2 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   |    2 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |    2 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |    2 +
 drivers/net/ethernet/netronome/nfp/nfp_asm.c       |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    4 +-
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |    4 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c |    2 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c  |    2 +-
 drivers/net/ethernet/packetengines/yellowfin.c     |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   13 +-
 .../ethernet/qlogic/netxen/netxen_nic_ethtool.c    |    4 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |    4 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |    4 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   10 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |    2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |    4 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  110 +-
 drivers/net/ethernet/rocker/rocker_main.c          |    8 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c |    4 +-
 drivers/net/ethernet/sfc/ef100.c                   |    8 +-
 drivers/net/ethernet/sfc/ef100_nic.c               |   10 +-
 drivers/net/ethernet/sfc/ef100_rx.c                |   13 +-
 drivers/net/ethernet/sfc/ef100_rx.h                |    1 +
 drivers/net/ethernet/sfc/efx.h                     |    8 +
 drivers/net/ethernet/sfc/falcon/ethtool.c          |    2 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |   14 +-
 drivers/net/ethernet/sfc/farch.c                   |   14 +-
 drivers/net/ethernet/sfc/mcdi_filters.c            |    2 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c        |    2 +-
 drivers/net/ethernet/sfc/net_driver.h              |    4 +
 drivers/net/ethernet/sfc/nic.c                     |    4 +
 drivers/net/ethernet/sfc/rx.c                      |    2 +-
 drivers/net/ethernet/sfc/rx_common.c               |    4 +-
 drivers/net/ethernet/sis/sis900.c                  |    2 +-
 drivers/net/ethernet/smsc/smc911x.c                |    2 +-
 drivers/net/ethernet/socionext/netsec.c            |    4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |    7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    2 +-
 drivers/net/ethernet/sun/cassini.c                 |    2 +-
 drivers/net/ethernet/sun/niu.c                     |    4 +-
 drivers/net/ethernet/sun/sungem.c                  |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    2 +
 drivers/net/ethernet/ti/cpsw-phy-sel.c             |    4 +-
 drivers/net/ethernet/ti/cpsw.c                     |    2 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |   29 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |    4 +-
 drivers/net/ethernet/ti/tlan.c                     |    2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |    2 +-
 drivers/net/ethernet/toshiba/spider_net.c          |   28 +-
 drivers/net/ethernet/xircom/xirc2ps_cs.c           |    2 +-
 drivers/net/fddi/skfp/cfm.c                        |   17 +-
 drivers/net/fddi/skfp/fplustm.c                    |    4 -
 drivers/net/fddi/skfp/hwmtm.c                      |    4 -
 drivers/net/fddi/skfp/pcmplc.c                     |    4 +-
 drivers/net/fddi/skfp/smt.c                        |    7 +-
 drivers/net/fjes/fjes_main.c                       |    2 +-
 drivers/net/gtp.c                                  |    1 +
 drivers/net/hamradio/baycom_epp.c                  |    2 +-
 drivers/net/hamradio/mkiss.c                       |    5 +-
 drivers/net/hyperv/netvsc_drv.c                    |    4 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   27 +-
 drivers/net/macvlan.c                              |   23 +-
 drivers/net/mii.c                                  |    2 +-
 drivers/net/netdevsim/bus.c                        |    2 +-
 drivers/net/netdevsim/fib.c                        |    6 +-
 drivers/net/phy/adin.c                             |    4 +-
 drivers/net/phy/dp83640.c                          |    8 +-
 drivers/net/phy/dp83867.c                          |    4 +-
 drivers/net/phy/dp83869.c                          |   12 +-
 drivers/net/phy/fixed_phy.c                        |    4 +-
 drivers/net/phy/mscc/mscc_main.c                   |    4 +-
 drivers/net/phy/phy.c                              |    4 +-
 drivers/net/phy/phy_device.c                       |    2 +-
 drivers/net/phy/phylink.c                          |    4 +-
 drivers/net/phy/sfp-bus.c                          |    4 +-
 drivers/net/phy/sfp.c                              |   12 +-
 drivers/net/plip/plip.c                            |   26 +-
 drivers/net/tun.c                                  |    6 +-
 drivers/net/usb/Kconfig                            |    1 +
 drivers/net/usb/aqc111.c                           |    6 +-
 drivers/net/usb/asix_common.c                      |    2 +-
 drivers/net/usb/catc.c                             |    2 +-
 drivers/net/usb/cdc-phonet.c                       |    2 +-
 drivers/net/usb/dm9601.c                           |    4 +
 drivers/net/usb/lan78xx.c                          |    4 +-
 drivers/net/usb/pegasus.c                          |    4 +-
 drivers/net/usb/r8152.c                            |    6 +-
 drivers/net/usb/rtl8150.c                          |    2 +-
 drivers/net/usb/usbnet.c                           |    6 +-
 drivers/net/veth.c                                 |    8 +-
 drivers/net/virtio_net.c                           |    6 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |    2 +-
 drivers/net/wan/dlci.c                             |    3 +-
 drivers/net/wan/hdlc.c                             |    3 +-
 drivers/net/wan/hdlc_cisco.c                       |    1 +
 drivers/net/wan/hdlc_x25.c                         |   17 +-
 drivers/net/wan/lapbether.c                        |    5 +-
 drivers/net/wan/sdla.c                             |    2 +-
 drivers/net/wan/x25_asy.c                          |    2 +-
 drivers/net/wimax/i2400m/control.c                 |    2 +-
 drivers/net/wimax/i2400m/usb-fw.c                  |    2 +-
 drivers/net/wimax/i2400m/usb-tx.c                  |    2 +-
 drivers/net/wimax/i2400m/usb.c                     |    2 +-
 drivers/net/xen-netback/hash.c                     |    2 +-
 drivers/net/xen-netback/xenbus.c                   |    2 +-
 drivers/net/xen-netfront.c                         |    2 +-
 drivers/nfc/pn533/pn533.c                          |    4 +-
 drivers/nfc/st21nfca/dep.c                         |    2 +-
 drivers/nfc/st95hf/core.c                          |    2 +-
 drivers/nfc/trf7970a.c                             |    4 +-
 drivers/ntb/ntb_transport.c                        |    4 +-
 drivers/nvdimm/dimm_devs.c                         |    1 +
 drivers/nvme/host/core.c                           |  152 +-
 drivers/nvme/host/fabrics.c                        |    1 -
 drivers/nvme/host/fc.c                             |    6 +-
 drivers/nvme/host/multipath.c                      |   69 +-
 drivers/nvme/host/nvme.h                           |   33 +-
 drivers/nvme/host/pci.c                            |   23 +-
 drivers/nvme/host/rdma.c                           |   72 +-
 drivers/nvme/host/tcp.c                            |   85 +-
 drivers/nvme/target/configfs.c                     |    1 +
 drivers/nvme/target/core.c                         |    8 +-
 drivers/nvme/target/fc.c                           |    4 +-
 drivers/nvme/target/fcloop.c                       |    2 +-
 drivers/nvme/target/io-cmd-bdev.c                  |    1 -
 drivers/nvme/target/loop.c                         |    2 +-
 drivers/nvme/target/passthru.c                     |   25 +-
 drivers/nvme/target/rdma.c                         |    4 +-
 drivers/nvme/target/tcp.c                          |   10 +-
 drivers/of/address.c                               |   21 +-
 drivers/opp/core.c                                 |   41 +-
 drivers/opp/opp.h                                  |    2 +-
 drivers/parport/ieee1284.c                         |    6 +-
 drivers/parport/parport_pc.c                       |    2 +-
 drivers/pci/controller/dwc/pci-imx6.c              |    6 +-
 drivers/pci/controller/pci-rcar-gen2.c             |    2 +-
 drivers/pci/hotplug/ibmphp_res.c                   |    2 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |    4 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |   12 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |    4 +-
 drivers/pci/p2pdma.c                               |   10 +-
 drivers/pci/pci.c                                  |    4 +-
 drivers/pci/proc.c                                 |    2 +-
 drivers/pci/quirks.c                               |    4 +-
 drivers/pci/setup-bus.c                            |    2 +-
 drivers/pci/xen-pcifront.c                         |    2 +-
 drivers/pcmcia/db1xxx_ss.c                         |    8 +-
 drivers/perf/arm-ccn.c                             |    2 +-
 drivers/perf/arm_spe_pmu.c                         |    4 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |    2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    8 +-
 drivers/platform/olpc/olpc-xo175-ec.c              |    2 +-
 drivers/platform/x86/acer-wmi.c                    |    8 +-
 drivers/platform/x86/dell-laptop.c                 |    4 +-
 drivers/platform/x86/surfacepro3_button.c          |    8 +-
 drivers/platform/x86/thinkpad_acpi.c               |    6 +-
 drivers/platform/x86/toshiba_acpi.c                |    2 +-
 drivers/power/supply/ab8500_charger.c              |    4 +-
 drivers/power/supply/ab8500_fg.c                   |    4 +-
 drivers/power/supply/abx500_chargalg.c             |   26 +-
 drivers/power/supply/axp20x_usb_power.c            |    2 +-
 drivers/power/supply/cros_usbpd-charger.c          |    2 +-
 drivers/power/supply/max8925_power.c               |    2 +-
 drivers/power/supply/wm831x_power.c                |    2 +-
 drivers/power/supply/wm8350_power.c                |    2 +-
 drivers/ps3/ps3av.c                                |    2 +-
 drivers/ps3/ps3av_cmd.c                            |    4 +-
 drivers/ptp/ptp_clockmatrix.c                      |   56 +-
 drivers/ptp/ptp_clockmatrix.h                      |    2 +
 drivers/rapidio/devices/rio_mport_cdev.c           |    2 +-
 drivers/regulator/axp20x-regulator.c               |    8 +-
 drivers/regulator/core.c                           |    2 +-
 drivers/regulator/slg51000-regulator.c             |    2 +-
 drivers/regulator/twl6030-regulator.c              |    2 +-
 drivers/remoteproc/omap_remoteproc.c               |    1 -
 drivers/reset/reset-imx7.c                         |   14 +-
 drivers/rpmsg/qcom_glink_native.c                  |    4 +-
 drivers/rtc/rtc-m41t80.c                           |    2 +-
 drivers/rtc/rtc-pcf85063.c                         |    2 +-
 drivers/rtc/rtc-pcf8523.c                          |    2 +-
 drivers/rtc/rtc-stmp3xxx.c                         |    2 +-
 drivers/s390/cio/css.c                             |    5 +
 drivers/s390/net/ctcm_fsms.c                       |    2 +-
 drivers/s390/net/ctcm_mpc.c                        |    6 +-
 drivers/s390/net/qeth_core_main.c                  |    4 +-
 drivers/s390/net/qeth_ethtool.c                    |    6 +-
 drivers/s390/net/qeth_l2_main.c                    |    2 +-
 drivers/s390/net/qeth_l3_main.c                    |    2 +-
 drivers/s390/scsi/zfcp_fsf.c                       |    4 +-
 drivers/scsi/53c700.c                              |    2 +-
 drivers/scsi/BusLogic.c                            |    2 +-
 drivers/scsi/FlashPoint.c                          |    9 +-
 drivers/scsi/NCR5380.c                             |    2 +-
 drivers/scsi/aacraid/aachba.c                      |    8 +-
 drivers/scsi/aacraid/commsup.c                     |    2 +-
 drivers/scsi/aacraid/linit.c                       |    2 +-
 drivers/scsi/aic7xxx/aic79xx_core.c                |   40 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c                 |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c                |   28 +-
 drivers/scsi/aic94xx/aic94xx_scb.c                 |   10 +-
 drivers/scsi/aic94xx/aic94xx_tmf.c                 |    2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                   |    2 +-
 drivers/scsi/arm/fas216.c                          |   12 +-
 drivers/scsi/be2iscsi/be_iscsi.c                   |    2 +-
 drivers/scsi/be2iscsi/be_main.c                    |    2 +-
 drivers/scsi/bfa/bfa_fcpim.c                       |    6 +-
 drivers/scsi/bfa/bfa_fcs_lport.c                   |    4 +-
 drivers/scsi/bfa/bfa_fcs_rport.c                   |   14 +-
 drivers/scsi/bfa/bfa_ioc.c                         |    6 +-
 drivers/scsi/bfa/bfa_svc.c                         |    2 +-
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   |    1 -
 drivers/scsi/csiostor/csio_hw.c                    |    2 +-
 drivers/scsi/csiostor/csio_lnode.c                 |    1 -
 drivers/scsi/csiostor/csio_wr.c                    |    2 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                 |    2 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 |    2 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |    2 +-
 drivers/scsi/cxlflash/main.c                       |   28 +-
 drivers/scsi/cxlflash/superpipe.c                  |   10 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c        |    4 +-
 drivers/scsi/esas2r/esas2r_flash.c                 |    2 +-
 drivers/scsi/esas2r/esas2r_init.c                  |    4 +-
 drivers/scsi/esp_scsi.c                            |    4 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |    8 +-
 drivers/scsi/g_NCR5380.c                           |    2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |    2 +-
 drivers/scsi/hpsa.c                                |   10 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |    6 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |    6 +-
 drivers/scsi/imm.c                                 |   14 +-
 drivers/scsi/isci/phy.c                            |    2 +-
 drivers/scsi/isci/remote_device.c                  |    4 +-
 drivers/scsi/isci/remote_node_context.c            |    6 +-
 drivers/scsi/isci/request.c                        |    2 +-
 drivers/scsi/libfc/fc_exch.c                       |    4 +-
 drivers/scsi/libfc/fc_fcp.c                        |    8 +-
 drivers/scsi/libfc/fc_lport.c                      |    2 +-
 drivers/scsi/libfc/fc_rport.c                      |    2 +-
 drivers/scsi/libiscsi.c                            |    6 +-
 drivers/scsi/libiscsi_tcp.c                        |    2 +-
 drivers/scsi/libsas/sas_ata.c                      |    2 +-
 drivers/scsi/libsas/sas_discover.c                 |    2 +-
 drivers/scsi/libsas/sas_expander.c                 |    2 +-
 drivers/scsi/libsas/sas_scsi_host.c                |    2 +-
 drivers/scsi/lpfc/lpfc_ct.c                        |    4 +-
 drivers/scsi/lpfc/lpfc_els.c                       |    2 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |    7 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |    2 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |    2 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |    8 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   28 +-
 drivers/scsi/megaraid.c                            |   12 +-
 drivers/scsi/megaraid/megaraid_mbox.c              |    2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |    2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |    2 +-
 drivers/scsi/mesh.c                                |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                 |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    8 +-
 drivers/scsi/myrb.c                                |    8 +-
 drivers/scsi/ncr53c8xx.c                           |   14 +-
 drivers/scsi/pcmcia/nsp_cs.c                       |    2 +-
 drivers/scsi/ppa.c                                 |   10 +-
 drivers/scsi/qedf/qedf_main.c                      |    2 +-
 drivers/scsi/qla2xxx/qla_dbg.h                     |    3 +
 drivers/scsi/qla2xxx/qla_def.h                     |    1 +
 drivers/scsi/qla2xxx/qla_gs.c                      |   50 +-
 drivers/scsi/qla2xxx/qla_init.c                    |    2 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |    2 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   14 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   22 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   15 +-
 drivers/scsi/qla2xxx/qla_os.c                      |    9 +-
 drivers/scsi/qla2xxx/qla_sup.c                     |    6 +-
 drivers/scsi/qla2xxx/qla_target.c                  |    8 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |    2 +-
 drivers/scsi/qlogicpti.c                           |   20 +-
 drivers/scsi/scsi_debug.c                          |    4 +-
 drivers/scsi/scsi_error.c                          |   28 +-
 drivers/scsi/scsi_ioctl.c                          |    4 +-
 drivers/scsi/scsi_lib.c                            |    2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   17 +-
 drivers/scsi/sr.c                                  |    4 +-
 drivers/scsi/st.c                                  |    8 +-
 drivers/scsi/sun3_scsi.c                           |    4 +-
 drivers/scsi/sym53c8xx_2/sym_fw.c                  |    2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c                |    4 +-
 drivers/scsi/sym53c8xx_2/sym_nvram.c               |    2 +-
 drivers/scsi/ufs/ti-j721e-ufs.c                    |    1 +
 drivers/scsi/ufs/ufs-mediatek.c                    |    2 +-
 drivers/scsi/ufs/ufs_bsg.c                         |    2 +-
 drivers/scsi/ufs/ufshcd-pci.c                      |   16 +-
 drivers/scsi/ufs/ufshcd.c                          |   39 +-
 drivers/scsi/ufs/ufshcd.h                          |    9 +-
 drivers/scsi/virtio_scsi.c                         |    2 +-
 drivers/scsi/vmw_pvscsi.c                          |    2 +-
 drivers/scsi/wd33c93.c                             |    2 +-
 drivers/scsi/xen-scsifront.c                       |    2 +-
 drivers/soc/qcom/socinfo.c                         |   22 +-
 drivers/soc/tegra/pmc.c                            |    2 +-
 drivers/spi/Kconfig                                |    3 +
 drivers/spi/spi-bcm2835aux.c                       |    4 +-
 drivers/spi/spi-fsl-cpm.c                          |    4 +-
 drivers/spi/spi-sprd-adi.c                         |    2 +-
 drivers/spi/spi-stm32.c                            |  100 +-
 drivers/spi/spi.c                                  |   21 +-
 drivers/ssb/driver_chipcommon.c                    |    2 +-
 drivers/ssb/driver_mipscore.c                      |    2 +-
 drivers/ssb/scan.c                                 |    2 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |    2 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |    8 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |    1 -
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |    2 +-
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |    2 +-
 drivers/staging/media/atomisp/pci/sh_css.c         |    2 +-
 drivers/staging/media/hantro/hantro_g1_mpeg2_dec.c |    2 +-
 .../staging/media/hantro/rk3399_vpu_hw_mpeg2_dec.c |    2 +-
 drivers/staging/media/imx/imx-media-csi.c          |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    7 +-
 drivers/staging/media/usbvision/usbvision-i2c.c    |    6 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |    2 +-
 drivers/target/iscsi/iscsi_target.c                |    2 +-
 drivers/target/target_core_pr.c                    |    4 +-
 drivers/target/target_core_sbc.c                   |    2 +-
 drivers/target/target_core_transport.c             |    4 +-
 drivers/target/tcm_fc/tfc_cmd.c                    |    2 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |    4 +-
 drivers/thermal/qcom/tsens-v0_1.c                  |    8 +-
 drivers/thermal/qcom/tsens-v1.c                    |    4 +-
 drivers/thermal/thermal_core.c                     |    5 +-
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   23 +-
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |   10 +-
 drivers/thunderbolt/ctl.c                          |    2 +-
 drivers/thunderbolt/switch.c                       |    2 +-
 drivers/thunderbolt/tunnel.c                       |    4 +-
 drivers/tty/hvc/hvc_xen.c                          |    2 +-
 drivers/tty/mips_ejtag_fdc.c                       |    2 +-
 drivers/tty/n_gsm.c                                |    4 +-
 drivers/tty/n_hdlc.c                               |    2 +-
 drivers/tty/n_r3964.c                              |    1 -
 drivers/tty/serial/8250/8250_em.c                  |    2 +-
 drivers/tty/serial/8250/8250_exar.c                |   24 +-
 drivers/tty/serial/8250/8250_fintek.c              |    2 +-
 drivers/tty/serial/8250/8250_pci.c                 |    2 +-
 drivers/tty/serial/8250/8250_port.c                |   11 +-
 drivers/tty/serial/8250/8250_uniphier.c            |    6 +-
 drivers/tty/serial/Kconfig                         |    1 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/amba-pl011.c                    |   16 +-
 drivers/tty/serial/atmel_serial.c                  |    2 +-
 drivers/tty/serial/omap-serial.c                   |    2 -
 drivers/tty/serial/qcom_geni_serial.c              |   11 +-
 drivers/tty/serial/rda-uart.c                      |    2 +-
 drivers/tty/serial/samsung_tty.c                   |    8 +-
 drivers/tty/serial/serial-tegra.c                  |    2 +-
 drivers/tty/serial/serial_core.c                   |    2 +-
 drivers/tty/serial/stm32-usart.c                   |    2 +-
 drivers/tty/serial/sunsu.c                         |    2 +-
 drivers/tty/serial/sunzilog.c                      |    2 +-
 drivers/tty/serial/xilinx_uartps.c                 |    2 +-
 drivers/tty/tty_ioctl.c                            |    2 +-
 drivers/tty/vt/vt.c                                |   11 +-
 drivers/tty/vt/vt_ioctl.c                          |   12 +-
 drivers/usb/c67x00/c67x00-sched.c                  |    3 +-
 drivers/usb/class/cdc-acm.c                        |   22 +-
 drivers/usb/core/driver.c                          |   40 +-
 drivers/usb/core/generic.c                         |    5 +-
 drivers/usb/core/hcd-pci.c                         |    5 +-
 drivers/usb/core/hub.c                             |    2 +-
 drivers/usb/core/quirks.c                          |    7 +
 drivers/usb/dwc3/core.c                            |    5 +-
 drivers/usb/dwc3/gadget.c                          |  107 +-
 drivers/usb/gadget/function/f_mass_storage.c       |    1 -
 drivers/usb/gadget/function/f_ncm.c                |   81 +-
 drivers/usb/gadget/function/f_tcm.c                |    7 +-
 drivers/usb/gadget/u_f.h                           |   38 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |    2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |    2 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |    4 +-
 drivers/usb/host/isp116x-hcd.c                     |    6 +-
 drivers/usb/host/ohci-exynos.c                     |    5 +-
 drivers/usb/host/pci-quirks.c                      |    3 +-
 drivers/usb/host/xhci-dbgcap.c                     |    2 +-
 drivers/usb/host/xhci-debugfs.c                    |    8 +-
 drivers/usb/host/xhci-hub.c                        |   21 +-
 drivers/usb/host/xhci-mem.c                        |    4 +-
 drivers/usb/host/xhci-pci-renesas.c                |   19 +-
 drivers/usb/host/xhci-ring.c                       |    2 +-
 drivers/usb/host/xhci-tegra.c                      |    4 +-
 drivers/usb/host/xhci.c                            |    5 +-
 drivers/usb/misc/lvstest.c                         |    2 +-
 drivers/usb/misc/yurex.c                           |    2 +-
 drivers/usb/musb/cppi_dma.c                        |    2 +-
 drivers/usb/musb/musb_core.c                       |   13 +-
 drivers/usb/musb/musb_dsps.c                       |    6 +-
 drivers/usb/musb/musb_gadget_ep0.c                 |    4 +-
 drivers/usb/musb/musb_host.c                       |    6 +-
 drivers/usb/musb/musb_virthub.c                    |    2 +-
 drivers/usb/musb/omap2430.c                        |    2 +-
 drivers/usb/musb/tusb6010.c                        |    2 +-
 drivers/usb/phy/phy-jz4770.c                       |    1 +
 drivers/usb/storage/sddr55.c                       |    2 +-
 drivers/usb/storage/uas.c                          |    2 +-
 drivers/usb/storage/unusual_devs.h                 |    2 +-
 drivers/usb/storage/unusual_uas.h                  |   14 +
 drivers/usb/typec/tcpm/tcpci.c                     |    2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   28 +-
 drivers/usb/typec/ucsi/displayport.c               |    9 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  103 +-
 drivers/usb/usbip/stub_dev.c                       |    6 +
 drivers/vdpa/ifcvf/ifcvf_base.h                    |    2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    |    9 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   50 +-
 drivers/vfio/pci/vfio_pci.c                        |    2 +-
 drivers/vfio/pci/vfio_pci_private.h                |    2 +
 drivers/vfio/pci/vfio_pci_rdwr.c                   |  120 +-
 drivers/vfio/vfio_iommu_type1.c                    |   73 +-
 drivers/vhost/iotlb.c                              |    4 +-
 drivers/vhost/vhost.c                              |    2 +-
 drivers/video/backlight/adp8860_bl.c               |    2 +-
 drivers/video/fbdev/acornfb.c                      |    2 +-
 drivers/video/fbdev/arcfb.c                        |    2 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |    4 +-
 drivers/video/fbdev/aty/radeon_pm.c                |    6 +-
 drivers/video/fbdev/cirrusfb.c                     |    4 +-
 drivers/video/fbdev/controlfb.c                    |    4 +-
 drivers/video/fbdev/core/fbcon.c                   |   25 +-
 drivers/video/fbdev/core/fbmem.c                   |    2 +-
 drivers/video/fbdev/efifb.c                        |    2 +-
 drivers/video/fbdev/fsl-diu-fb.c                   |    4 +-
 drivers/video/fbdev/gxt4500.c                      |    2 +-
 drivers/video/fbdev/hyperv_fb.c                    |    4 +-
 drivers/video/fbdev/i740fb.c                       |    2 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c                 |    2 -
 drivers/video/fbdev/nvidia/nv_hw.c                 |    2 +-
 drivers/video/fbdev/offb.c                         |    4 +-
 drivers/video/fbdev/omap/lcdc.c                    |    4 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   20 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |    4 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |    2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |    2 +-
 drivers/video/fbdev/pm2fb.c                        |    4 +-
 drivers/video/fbdev/pxa168fb.c                     |    4 -
 drivers/video/fbdev/pxafb.c                        |    2 +-
 drivers/video/fbdev/riva/fbdev.c                   |    2 +-
 drivers/video/fbdev/s3c-fb.c                       |    6 +-
 drivers/video/fbdev/sa1100fb.c                     |    2 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |    2 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |    4 +-
 drivers/video/fbdev/sis/sis_main.c                 |    8 +-
 drivers/video/fbdev/sm501fb.c                      |    2 +-
 drivers/video/fbdev/stifb.c                        |    4 +-
 drivers/video/fbdev/tdfxfb.c                       |    2 +-
 drivers/video/fbdev/via/lcd.c                      |    2 +-
 drivers/video/fbdev/xen-fbfront.c                  |    2 +-
 drivers/watchdog/sc1200wdt.c                       |    2 +-
 drivers/watchdog/wdrtas.c                          |    2 +-
 drivers/xen/Kconfig                                |   10 +
 drivers/xen/Makefile                               |    1 +
 drivers/xen/balloon.c                              |    4 +-
 drivers/xen/events/events_base.c                   |   16 +-
 drivers/xen/grant-table.c                          |    4 +-
 drivers/xen/privcmd.c                              |    4 +-
 drivers/xen/pvcalls-front.c                        |    2 +-
 drivers/xen/unpopulated-alloc.c                    |  183 ++
 drivers/xen/xen-acpi-memhotplug.c                  |    2 +-
 drivers/xen/xen-pciback/xenbus.c                   |    2 +-
 drivers/xen/xen-scsiback.c                         |    2 +-
 drivers/xen/xenbus/xenbus_client.c                 |   16 +-
 drivers/xen/xenbus/xenbus_probe_frontend.c         |    4 +-
 drivers/xen/xlate_mmu.c                            |    4 +-
 fs/9p/vfs_file.c                                   |    2 +-
 fs/adfs/dir_f.c                                    |   12 +-
 fs/affs/amigaffs.c                                 |   27 +
 fs/affs/file.c                                     |   26 +-
 fs/affs/inode.c                                    |    2 +-
 fs/affs/super.c                                    |    6 +-
 fs/afs/cmservice.c                                 |   16 +-
 fs/afs/dynroot.c                                   |   20 +-
 fs/afs/file.c                                      |    2 +-
 fs/afs/flock.c                                     |    1 -
 fs/afs/fs_operation.c                              |    1 +
 fs/afs/fs_probe.c                                  |    4 +-
 fs/afs/fsclient.c                                  |   42 +-
 fs/afs/internal.h                                  |   14 +-
 fs/afs/misc.c                                      |   18 +-
 fs/afs/proc.c                                      |    5 +
 fs/afs/rotate.c                                    |    2 +-
 fs/afs/rxrpc.c                                     |    6 +-
 fs/afs/vl_list.c                                   |    1 +
 fs/afs/vl_probe.c                                  |   82 +-
 fs/afs/vl_rotate.c                                 |    7 +-
 fs/afs/vlclient.c                                  |   24 +-
 fs/afs/write.c                                     |    2 +-
 fs/afs/yfsclient.c                                 |   50 +-
 fs/aio.c                                           |    2 +-
 fs/binfmt_flat.c                                   |   20 +-
 fs/btrfs/block-group.c                             |    4 +-
 fs/btrfs/ctree.c                                   |    8 +-
 fs/btrfs/ctree.h                                   |    6 +-
 fs/btrfs/disk-io.c                                 |    1 +
 fs/btrfs/extent-tree.c                             |   19 +-
 fs/btrfs/extent_io.c                               |    8 +-
 fs/btrfs/extent_io.h                               |    6 +-
 fs/btrfs/file.c                                    |    2 +-
 fs/btrfs/free-space-cache.c                        |    2 +-
 fs/btrfs/free-space-tree.c                         |    4 +
 fs/btrfs/inode.c                                   |   29 +-
 fs/btrfs/ioctl.c                                   |   27 +-
 fs/btrfs/scrub.c                                   |  122 +-
 fs/btrfs/super.c                                   |    1 +
 fs/btrfs/tree-checker.c                            |    2 +-
 fs/btrfs/tree-log.c                                |   10 +-
 fs/btrfs/volumes.c                                 |    3 +-
 fs/buffer.c                                        |   11 +-
 fs/ceph/caps.c                                     |   14 +-
 fs/ceph/debugfs.c                                  |    4 +-
 fs/ceph/dir.c                                      |   33 +-
 fs/ceph/file.c                                     |    7 +-
 fs/ceph/inode.c                                    |   19 +-
 fs/ceph/mds_client.h                               |    2 +-
 fs/ceph/quota.c                                    |    4 +-
 fs/ceph/super.h                                    |   73 +-
 fs/cifs/cifsglob.h                                 |   15 +
 fs/cifs/cifssmb.c                                  |    2 +-
 fs/cifs/connect.c                                  |   12 +-
 fs/cifs/sess.c                                     |    6 +-
 fs/cifs/smb2pdu.c                                  |    2 +-
 fs/configfs/dir.c                                  |    4 +-
 fs/dax.c                                           |    2 +-
 fs/dlm/lock.c                                      |    2 +-
 fs/erofs/zmap.c                                    |    6 +-
 fs/eventpoll.c                                     |   30 +-
 fs/ext2/file.c                                     |    6 +-
 fs/ext2/inode.c                                    |    4 +-
 fs/ext2/super.c                                    |    2 +-
 fs/ext4/Kconfig                                    |    2 +-
 fs/ext4/balloc.c                                   |   16 +-
 fs/ext4/block_validity.c                           |  159 +-
 fs/ext4/ext4.h                                     |   91 +-
 fs/ext4/ext4_jbd2.c                                |   25 +
 fs/ext4/extents.c                                  |   42 +-
 fs/ext4/file.c                                     |   11 +-
 fs/ext4/hash.c                                     |    4 +-
 fs/ext4/indirect.c                                 |   20 +-
 fs/ext4/inline.c                                   |    4 +-
 fs/ext4/inode.c                                    |   32 +-
 fs/ext4/ioctl.c                                    |   34 +-
 fs/ext4/mballoc.c                                  |  289 +++-
 fs/ext4/mballoc.h                                  |    4 +
 fs/ext4/move_extent.c                              |    4 +-
 fs/ext4/namei.c                                    |   66 +-
 fs/ext4/readpage.c                                 |    4 +-
 fs/ext4/super.c                                    |  268 ++-
 fs/ext4/sysfs.c                                    |   13 +
 fs/ext4/xattr.c                                    |    3 +-
 fs/f2fs/f2fs.h                                     |    2 +-
 fs/f2fs/node.c                                     |    4 +-
 fs/fcntl.c                                         |    4 +-
 fs/fs-writeback.c                                  |  103 +-
 fs/fs_context.c                                    |    2 +-
 fs/fsopen.c                                        |    2 +-
 fs/gfs2/bmap.c                                     |    4 +-
 fs/gfs2/log.c                                      |   31 +
 fs/gfs2/quota.c                                    |    2 +-
 fs/gfs2/trans.c                                    |    1 +
 fs/hfsplus/wrapper.c                               |    2 +-
 fs/io-wq.c                                         |   21 +-
 fs/io_uring.c                                      |  340 ++--
 fs/iomap/seek.c                                    |    4 +-
 fs/jbd2/journal.c                                  |   16 +-
 fs/jbd2/recovery.c                                 |   46 +-
 fs/jbd2/transaction.c                              |   33 +-
 fs/jffs2/fs.c                                      |    2 +-
 fs/jffs2/readinode.c                               |    2 +-
 fs/libfs.c                                         |    4 +-
 fs/locks.c                                         |    6 +-
 fs/nfs/blocklayout/blocklayout.c                   |    2 +-
 fs/nfs/dir.c                                       |    2 +-
 fs/nfs/filelayout/filelayout.c                     |    2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |    4 +-
 fs/nfs/fs_context.c                                |   22 +-
 fs/nfs/nfs3acl.c                                   |    4 +-
 fs/nfs/nfs4file.c                                  |    2 +-
 fs/nfs/nfs4idmap.c                                 |    4 +-
 fs/nfs/nfs4proc.c                                  |   32 +-
 fs/nfs/nfs4state.c                                 |   14 +-
 fs/nfs/pagelist.c                                  |    2 +-
 fs/nfs/pnfs.c                                      |    2 +-
 fs/nfs_common/nfsacl.c                             |    2 +-
 fs/nfsd/blocklayout.c                              |    4 +-
 fs/nfsd/nfs4callback.c                             |    2 +-
 fs/nfsd/nfs4layouts.c                              |    2 +-
 fs/nfsd/nfs4proc.c                                 |    2 +-
 fs/nfsd/nfs4state.c                                |   14 +-
 fs/nfsd/nfsfh.c                                    |    4 +-
 fs/nfsd/nfsproc.c                                  |    2 +-
 fs/nfsd/nfssvc.c                                   |    2 +-
 fs/nfsd/vfs.c                                      |    4 +-
 fs/nilfs2/bmap.c                                   |    2 +-
 fs/nilfs2/recovery.c                               |    2 +-
 fs/nilfs2/segment.c                                |   19 +-
 fs/notify/fanotify/fanotify_user.c                 |    2 +-
 fs/ocfs2/cluster/quorum.c                          |    2 +-
 fs/pstore/zone.c                                   |    1 -
 fs/quota/quota.c                                   |    2 +-
 fs/romfs/storage.c                                 |    4 +-
 fs/seq_file.c                                      |    2 +-
 fs/signalfd.c                                      |    2 +-
 fs/squashfs/block.c                                |    6 +-
 fs/ubifs/lprops.c                                  |    4 +-
 fs/udf/symlink.c                                   |    2 +-
 fs/ufs/util.h                                      |   12 +-
 fs/vboxsf/utils.c                                  |    2 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |    8 +-
 fs/xfs/libxfs/xfs_bmap.c                           |    2 +-
 fs/xfs/libxfs/xfs_ialloc.c                         |    4 +-
 fs/xfs/libxfs/xfs_trans_inode.c                    |    4 +-
 fs/xfs/libxfs/xfs_trans_space.h                    |    2 +-
 fs/xfs/xfs_bmap_util.c                             |    2 +-
 fs/xfs/xfs_file.c                                  |   12 +-
 include/drm/drm_hdcp.h                             |    3 +
 include/drm/drm_modeset_lock.h                     |    9 +-
 include/kvm/arm_pmu.h                              |    5 +
 include/linux/arm-smccc.h                          |   74 +-
 include/linux/bvec.h                               |    9 +-
 include/linux/ceph/ceph_features.h                 |    8 +-
 include/linux/compat.h                             |    6 +-
 include/linux/compiler_attributes.h                |    8 +-
 include/linux/compiler_types.h                     |    4 +-
 include/linux/cpufreq.h                            |    4 +-
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/cpuidle.h                            |   13 +-
 include/linux/dma-direct.h                         |    3 -
 include/linux/dma-mapping.h                        |    5 +-
 include/linux/entry-common.h                       |   51 +-
 include/linux/filter.h                             |    2 +-
 include/linux/fs.h                                 |    7 +-
 include/linux/hid.h                                |   42 +-
 include/linux/irqflags.h                           |   73 +-
 include/linux/jbd2.h                               |    2 +-
 include/linux/jhash.h                              |   26 +-
 include/linux/kernel.h                             |    2 +-
 include/linux/ksm.h                                |    7 -
 include/linux/kvm_host.h                           |    2 +
 include/linux/libata.h                             |    1 +
 include/linux/lockdep.h                            |   18 +-
 include/linux/log2.h                               |    2 +-
 include/linux/memremap.h                           |    9 +-
 include/linux/mm.h                                 |   11 +-
 include/linux/mmu_context.h                        |    5 +
 include/linux/netfilter/nf_conntrack_sctp.h        |    2 +
 include/linux/netfilter/nfnetlink.h                |    3 +-
 include/linux/netfilter_ipv6.h                     |   18 -
 include/linux/pgtable.h                            |    2 +
 include/linux/phylink.h                            |    3 +-
 include/linux/sched.h                              |    2 +-
 include/linux/sched/user.h                         |    3 +
 include/linux/signal.h                             |   12 +-
 include/linux/skbuff.h                             |   25 +-
 include/linux/soc/ti/ti_sci_protocol.h             |   13 +
 include/linux/vm_event_item.h                      |    1 +
 include/math-emu/op-common.h                       |   10 +-
 include/net/addrconf.h                             |    3 +-
 include/net/af_rxrpc.h                             |    2 +-
 include/net/ndisc.h                                |    2 +-
 include/net/netfilter/nf_tables.h                  |    2 +
 include/soc/nps/common.h                           |    6 +
 include/trace/events/ext4.h                        |   85 +-
 include/trace/events/kvm.h                         |    2 +-
 include/trace/events/mmflags.h                     |    2 +
 include/trace/events/rxrpc.h                       |   27 +-
 include/trace/events/writeback.h                   |   14 +-
 include/uapi/linux/bpf.h                           |   10 +-
 include/uapi/linux/in.h                            |    2 +-
 include/uapi/linux/kvm.h                           |   19 +
 include/uapi/linux/netfilter/nf_tables.h           |    2 +-
 include/xen/arm/page.h                             |    6 +-
 include/xen/balloon.h                              |    4 +
 include/xen/xen.h                                  |    9 +
 init/initramfs.c                                   |    2 +-
 ipc/ipc_sysctl.c                                   |    2 +-
 ipc/sem.c                                          |    4 +-
 ipc/shm.c                                          |    4 +-
 kernel/auditfilter.c                               |    2 +-
 kernel/bpf/bpf_iter.c                              |   15 +-
 kernel/bpf/cgroup.c                                |    2 +-
 kernel/bpf/cpumap.c                                |    2 +-
 kernel/bpf/stackmap.c                              |   24 +-
 kernel/bpf/syscall.c                               |    4 +-
 kernel/bpf/task_iter.c                             |    6 +-
 kernel/bpf/verifier.c                              |    4 +-
 kernel/capability.c                                |    2 +-
 kernel/compat.c                                    |    6 +-
 kernel/debug/gdbstub.c                             |    6 +-
 kernel/debug/kdb/kdb_keyboard.c                    |    4 +-
 kernel/debug/kdb/kdb_support.c                     |    6 +-
 kernel/dma/direct.c                                |   13 +-
 kernel/dma/pool.c                                  |  147 +-
 kernel/entry/common.c                              |   38 +-
 kernel/events/core.c                               |    2 +-
 kernel/events/uprobes.c                            |    2 +-
 kernel/fork.c                                      |    2 +-
 kernel/gcov/Kconfig                                |    1 +
 kernel/irq/handle.c                                |    2 +-
 kernel/irq/manage.c                                |    4 +-
 kernel/irq/matrix.c                                |    7 +
 kernel/kallsyms.c                                  |    4 +-
 kernel/locking/lockdep.c                           |   18 +-
 kernel/power/hibernate.c                           |    2 +-
 kernel/power/qos.c                                 |    4 +-
 kernel/relay.c                                     |    1 +
 kernel/sched/core.c                                |    2 +-
 kernel/sched/idle.c                                |   25 +-
 kernel/sched/topology.c                            |    6 +-
 kernel/signal.c                                    |    2 +-
 kernel/sys.c                                       |    2 +-
 kernel/sysctl.c                                    |    3 +-
 kernel/time/hrtimer.c                              |    2 +-
 kernel/time/posix-timers.c                         |    4 +-
 kernel/time/tick-broadcast.c                       |    2 +-
 kernel/time/timer.c                                |    2 +-
 kernel/trace/blktrace.c                            |    2 +-
 kernel/trace/trace_events_filter.c                 |    4 +-
 kernel/watch_queue.c                               |    8 +
 lib/Makefile                                       |    7 +-
 lib/bootconfig.c                                   |    2 +-
 lib/glob.c                                         |    2 +-
 lib/vsprintf.c                                     |    7 +-
 lib/xz/xz_dec_lzma2.c                              |    4 +-
 lib/xz/xz_dec_stream.c                             |   16 +-
 lib/zstd/decompress.c                              |   10 +-
 mm/gup.c                                           |   42 +-
 mm/huge_memory.c                                   |    7 +-
 mm/hugetlb.c                                       |   49 +-
 mm/hugetlb_cgroup.c                                |    4 +-
 mm/khugepaged.c                                    |    4 +-
 mm/ksm.c                                           |   29 +-
 mm/madvise.c                                       |    2 +-
 mm/memcontrol.c                                    |    6 +
 mm/memory.c                                        |  100 +-
 mm/memremap.c                                      |    2 +-
 mm/migrate.c                                       |   29 +-
 mm/page_alloc.c                                    |    7 +-
 mm/rmap.c                                          |    9 +-
 mm/rodata_test.c                                   |    1 +
 mm/slub.c                                          |   12 +-
 mm/vmalloc.c                                       |    2 +
 mm/vmscan.c                                        |    8 +
 mm/vmstat.c                                        |    1 +
 net/8021q/vlan_dev.c                               |    2 +-
 net/9p/trans_xen.c                                 |    2 +-
 net/atm/common.c                                   |    4 +-
 net/atm/lec.c                                      |    2 +-
 net/atm/resources.c                                |    8 +-
 net/batman-adv/bat_v_ogm.c                         |   11 +-
 net/batman-adv/bridge_loop_avoidance.c             |    5 +-
 net/batman-adv/gateway_client.c                    |    6 +-
 net/bpf/test_run.c                                 |    2 +-
 net/bridge/netfilter/ebtables.c                    |    4 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |    8 +-
 net/caif/cfrfml.c                                  |    4 +-
 net/can/j1939/socket.c                             |   16 +-
 net/can/j1939/transport.c                          |  124 +-
 net/ceph/ceph_hash.c                               |   20 +-
 net/ceph/crush/mapper.c                            |    2 +-
 net/ceph/messenger.c                               |    4 +-
 net/ceph/mon_client.c                              |    2 +-
 net/ceph/osd_client.c                              |    4 +-
 net/core/dev.c                                     |   29 +-
 net/core/dev_ioctl.c                               |    6 +-
 net/core/devlink.c                                 |    6 +-
 net/core/drop_monitor.c                            |    2 +-
 net/core/filter.c                                  |   77 +-
 net/core/netpoll.c                                 |    2 +-
 net/core/pktgen.c                                  |    4 +-
 net/core/skbuff.c                                  |   16 +-
 net/core/skmsg.c                                   |    1 -
 net/core/sock.c                                    |    4 +-
 net/dccp/ccids/ccid3.c                             |    2 +-
 net/dccp/feat.c                                    |    3 +-
 net/dccp/input.c                                   |   10 +-
 net/dccp/options.c                                 |    2 +-
 net/dccp/output.c                                  |    8 +-
 net/dccp/proto.c                                   |    8 +-
 net/decnet/af_decnet.c                             |    6 +-
 net/decnet/dn_nsp_in.c                             |    2 +-
 net/decnet/dn_table.c                              |    2 +-
 net/decnet/sysctl_net_decnet.c                     |    2 +-
 net/dsa/slave.c                                    |    2 +-
 net/ethtool/features.c                             |   19 +-
 net/ieee802154/6lowpan/reassembly.c                |    2 +-
 net/ieee802154/6lowpan/rx.c                        |    4 +-
 net/ipv4/Kconfig                                   |   14 +-
 net/ipv4/fib_trie.c                                |    3 +-
 net/ipv4/netfilter/nf_nat_pptp.c                   |    2 +-
 net/ipv4/nexthop.c                                 |    5 +-
 net/ipv4/raw.c                                     |    2 +-
 net/ipv6/addrconf.c                                |   60 +-
 net/ipv6/ip6_tunnel.c                              |   10 +-
 net/ipv6/netfilter.c                               |    3 -
 net/ipv6/sysctl_net_ipv6.c                         |    3 +-
 net/iucv/af_iucv.c                                 |   10 +-
 net/l3mdev/l3mdev.c                                |    2 +-
 net/mac80211/airtime.c                             |  202 ++-
 net/mac80211/sta_info.h                            |    5 +-
 net/mac80211/status.c                              |   43 +-
 net/mpls/af_mpls.c                                 |    2 +-
 net/mptcp/protocol.c                               |   20 +-
 net/ncsi/ncsi-manage.c                             |    4 +-
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |    2 +-
 net/netfilter/ipvs/ip_vs_proto_udp.c               |    2 +-
 net/netfilter/nf_conntrack_pptp.c                  |    2 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |   39 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |    2 +-
 net/netfilter/nf_conntrack_proto_udp.c             |   26 +-
 net/netfilter/nf_tables_api.c                      |   70 +-
 net/netfilter/nfnetlink.c                          |   11 +-
 net/netfilter/nfnetlink_log.c                      |    3 +-
 net/netfilter/nfnetlink_queue.c                    |    2 +-
 net/netfilter/nft_compat.c                         |   37 +-
 net/netfilter/nft_exthdr.c                         |    4 +-
 net/netfilter/nft_flow_offload.c                   |    2 +-
 net/netfilter/nft_payload.c                        |    4 +-
 net/netfilter/nft_set_rbtree.c                     |   57 +-
 net/netfilter/xt_recent.c                          |    2 +-
 net/netlabel/netlabel_domainhash.c                 |   59 +-
 net/netlink/af_netlink.c                           |    2 +-
 net/netlink/policy.c                               |    5 +-
 net/netrom/nr_in.c                                 |    2 +-
 net/netrom/nr_route.c                              |    8 +-
 net/openvswitch/conntrack.c                        |    4 +-
 net/openvswitch/flow.c                             |    2 +-
 net/packet/af_packet.c                             |    9 +-
 net/phonet/pep.c                                   |   10 +-
 net/qrtr/qrtr.c                                    |   20 +-
 net/rds/send.c                                     |    2 +-
 net/rose/rose_in.c                                 |    2 +-
 net/rose/rose_route.c                              |    4 +-
 net/rxrpc/af_rxrpc.c                               |    6 +-
 net/rxrpc/ar-internal.h                            |   13 +-
 net/rxrpc/call_accept.c                            |    2 +-
 net/rxrpc/call_object.c                            |    1 +
 net/rxrpc/conn_client.c                            |    2 +-
 net/rxrpc/input.c                                  |  129 +-
 net/rxrpc/local_object.c                           |    2 +-
 net/rxrpc/output.c                                 |   82 +-
 net/rxrpc/peer_event.c                             |    2 +-
 net/rxrpc/peer_object.c                            |   16 +-
 net/rxrpc/recvmsg.c                                |    2 +-
 net/rxrpc/rtt.c                                    |    3 +-
 net/rxrpc/rxkad.c                                  |    3 +-
 net/rxrpc/sendmsg.c                                |    6 +-
 net/sched/act_ct.c                                 |    2 +-
 net/sched/sch_cake.c                               |    2 +-
 net/sched/sch_red.c                                |   20 +-
 net/sched/sch_taprio.c                             |   30 +-
 net/sctp/ipv6.c                                    |    2 +-
 net/sctp/outqueue.c                                |    6 +-
 net/sctp/sm_make_chunk.c                           |    2 +-
 net/sctp/sm_sideeffect.c                           |    2 +-
 net/sctp/sm_statefuns.c                            |    2 +-
 net/sctp/socket.c                                  |   16 +-
 net/sctp/stream.c                                  |    6 +-
 net/smc/smc_close.c                                |   17 +-
 net/smc/smc_core.c                                 |    3 +
 net/smc/smc_diag.c                                 |   16 +-
 net/smc/smc_llc.c                                  |   15 +-
 net/socket.c                                       |    4 +-
 net/sunrpc/auth_gss/gss_krb5_wrap.c                |    2 +-
 net/sunrpc/auth_gss/trace.c                        |    1 -
 net/sunrpc/clnt.c                                  |   22 +-
 net/sunrpc/xprt.c                                  |    2 +-
 net/sunrpc/xprtrdma/verbs.c                        |    2 +-
 net/sunrpc/xprtsock.c                              |    8 +-
 net/tipc/Kconfig                                   |    1 +
 net/tipc/bearer.c                                  |    2 +-
 net/tipc/crypto.c                                  |   14 +-
 net/tipc/group.c                                   |    2 +-
 net/tipc/link.c                                    |    2 +-
 net/tipc/netlink_compat.c                          |   12 +-
 net/tipc/socket.c                                  |   13 +-
 net/tipc/udp_media.c                               |    8 +-
 net/unix/af_unix.c                                 |    2 +-
 net/wireless/chan.c                                |   19 +-
 net/wireless/mlme.c                                |    2 +-
 net/wireless/nl80211.c                             |   22 +-
 net/wireless/reg.c                                 |    3 +
 net/wireless/scan.c                                |    2 +-
 net/wireless/sme.c                                 |    4 +-
 net/wireless/util.c                                |   12 +-
 net/wireless/wext-compat.c                         |    4 +-
 net/x25/x25_facilities.c                           |    2 +-
 net/x25/x25_in.c                                   |    2 +-
 net/xfrm/xfrm_policy.c                             |    2 +-
 samples/bpf/hbm.c                                  |    2 +-
 scripts/Makefile.extrawarn                         |    2 +-
 scripts/checkpatch.pl                              |    4 +-
 scripts/extract-cert.c                             |    2 +-
 scripts/genksyms/keywords.c                        |    4 +-
 scripts/kconfig/nconf.c                            |    1 -
 scripts/kconfig/qconf.cc                           |  156 +-
 scripts/kconfig/qconf.h                            |    6 +-
 scripts/kconfig/streamline_config.pl               |    5 +-
 security/apparmor/domain.c                         |    2 +-
 security/apparmor/lib.c                            |    4 +-
 security/integrity/ima/ima_appraise.c              |    4 +-
 security/integrity/ima/ima_policy.c                |    8 +-
 security/integrity/ima/ima_template_lib.c          |    2 +-
 security/keys/process_keys.c                       |    6 +-
 security/keys/request_key.c                        |    8 +-
 security/selinux/hooks.c                           |    8 +-
 security/selinux/ss/mls.c                          |    4 +-
 security/smack/smack_lsm.c                         |    2 +-
 security/tomoyo/common.c                           |   18 +-
 security/tomoyo/file.c                             |    2 +-
 sound/core/oss/mulaw.c                             |    4 +-
 sound/core/timer.c                                 |    7 +-
 sound/firewire/amdtp-stream.c                      |    8 +-
 sound/firewire/digi00x/digi00x.c                   |    5 +
 sound/firewire/tascam/tascam.c                     |   33 +-
 sound/hda/hdac_bus.c                               |   12 +
 sound/hda/hdac_controller.c                        |   11 -
 sound/hda/hdac_device.c                            |    2 +
 sound/hda/intel-dsp-config.c                       |   10 +-
 sound/isa/sscape.c                                 |    6 +-
 sound/pci/asihpi/asihpi.c                          |    9 +-
 sound/pci/ca0106/ca0106_main.c                     |    3 +-
 sound/pci/hda/hda_intel.c                          |    7 +-
 sound/pci/hda/hda_tegra.c                          |    7 +
 sound/pci/hda/patch_hdmi.c                         |    7 +
 sound/pci/hda/patch_realtek.c                      |   47 +-
 sound/pci/riptide/riptide.c                        |    6 +-
 sound/pci/rme9652/hdsp.c                           |    6 +-
 sound/pci/rme9652/hdspm.c                          |    7 +-
 sound/ppc/snd_ps3.c                                |    4 +-
 sound/soc/amd/acp3x-rt5682-max9836.c               |    2 +-
 sound/soc/amd/renoir/acp3x-pdm-dma.c               |   29 +-
 sound/soc/atmel/mchp-i2s-mcc.c                     |    2 +-
 sound/soc/codecs/jz4770.c                          |    2 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |    4 +-
 sound/soc/codecs/pcm186x.c                         |    2 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    4 +
 sound/soc/codecs/wm8962.c                          |    2 +-
 sound/soc/codecs/wm8994.c                          |   60 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  154 +-
 sound/soc/fsl/fsl_esai.c                           |    7 +-
 sound/soc/fsl/fsl_ssi.c                            |    2 +-
 sound/soc/fsl/mpc5200_dma.c                        |    1 -
 sound/soc/hisilicon/hi6210-i2s.c                   |    4 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    5 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        |    2 +-
 sound/soc/intel/boards/bytcht_es8316.c             |    2 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    4 +-
 sound/soc/intel/skylake/skl-pcm.c                  |    2 +-
 sound/soc/meson/axg-tdm-interface.c                |   10 +-
 sound/soc/pxa/pxa-ssp.c                            |    2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  210 +--
 sound/soc/qcom/qdsp6/q6routing.c                   |   16 +
 sound/soc/rockchip/rockchip_pdm.c                  |    6 +-
 sound/soc/samsung/i2s.c                            |    2 +-
 sound/soc/sh/siu_pcm.c                             |   10 +-
 sound/soc/soc-component.c                          |    2 +-
 sound/soc/soc-core.c                               |    2 +-
 sound/soc/soc-topology.c                           |    4 +-
 sound/soc/sof/intel/hda-dai.c                      |    4 +-
 sound/soc/sof/pcm.c                                |    4 +-
 sound/soc/tegra/tegra186_dspk.c                    |    4 +-
 sound/soc/tegra/tegra210_admaif.c                  |    4 +-
 sound/soc/tegra/tegra210_ahub.c                    |    4 +-
 sound/soc/tegra/tegra210_dmic.c                    |    4 +-
 sound/soc/tegra/tegra210_i2s.c                     |    4 +-
 sound/soc/ti/davinci-i2s.c                         |    2 +-
 sound/soc/ti/n810.c                                |    2 +-
 sound/soc/ti/omap-dmic.c                           |    4 +-
 sound/soc/ti/omap-mcpdm.c                          |    8 +-
 sound/soc/ti/rx51.c                                |    2 +-
 sound/soc/txx9/txx9aclc.c                          |    7 +-
 sound/soc/zte/zx-i2s.c                             |    4 +-
 sound/soc/zte/zx-spdif.c                           |    2 +-
 sound/usb/midi.c                                   |    7 +-
 sound/usb/misc/ua101.c                             |    7 +-
 sound/usb/mixer.c                                  |    8 +-
 sound/usb/pcm.c                                    |    2 +
 sound/usb/quirks-table.h                           |  112 +-
 sound/usb/quirks.c                                 |   11 +
 sound/usb/usbaudio.h                               |    1 +
 sound/x86/Kconfig                                  |    2 +-
 tools/bpf/bpftool/btf_dumper.c                     |    2 +-
 tools/bpf/bpftool/gen.c                            |   22 +-
 tools/bpf/bpftool/link.c                           |    4 +-
 tools/bpf/bpftool/main.h                           |   10 +-
 tools/bpf/bpftool/pids.c                           |    2 +
 tools/bpf/bpftool/prog.c                           |   16 +-
 tools/bpf/resolve_btfids/main.c                    |   36 +
 tools/include/uapi/linux/bpf.h                     |   10 +-
 tools/include/uapi/linux/perf_event.h              |    2 +-
 tools/lib/bpf/bpf_helpers.h                        |    2 +-
 tools/lib/bpf/btf.c                                |   83 +-
 tools/lib/bpf/btf.h                                |    2 +
 tools/lib/bpf/btf_dump.c                           |   39 +-
 tools/lib/bpf/libbpf.c                             |   34 +-
 tools/lib/bpf/libbpf.map                           |    2 +
 tools/lib/traceevent/event-parse.c                 |    2 +-
 tools/perf/Documentation/perf-record.txt           |    4 +
 tools/perf/Documentation/perf-stat.txt             |    7 +
 tools/perf/bench/synthesize.c                      |    4 +-
 tools/perf/builtin-record.c                        |    2 +-
 tools/perf/builtin-report.c                        |    3 +
 tools/perf/builtin-sched.c                         |    6 +-
 tools/perf/builtin-stat.c                          |    8 +-
 tools/perf/builtin-top.c                           |    2 +
 tools/perf/pmu-events/jevents.c                    |    2 +-
 tools/perf/tests/bpf.c                             |    2 +-
 tools/perf/tests/parse-events.c                    |    4 +-
 tools/perf/tests/parse-metric.c                    |    3 +
 tools/perf/ui/browsers/hists.c                     |    3 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |    6 +-
 tools/perf/util/cs-etm.c                           |    9 +-
 tools/perf/util/intel-pt.c                         |    9 +-
 tools/perf/util/machine.c                          |    6 -
 tools/perf/util/map.c                              |   16 +
 tools/perf/util/map.h                              |    9 +-
 tools/perf/util/parse-events.c                     |   31 +-
 tools/perf/util/parse-events.y                     |    8 +-
 tools/perf/util/session.c                          |    2 +-
 tools/perf/util/stat-display.c                     |    2 +-
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/symbol.c                           |    1 +
 tools/perf/util/zstd.c                             |    2 +-
 tools/testing/selftests/bpf/.gitignore             |    1 -
 tools/testing/selftests/bpf/Makefile               |    2 +-
 .../testing/selftests/bpf/prog_tests/bpf_obj_id.c  |    8 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |   27 +-
 .../testing/selftests/bpf/prog_tests/core_extern.c |    4 +-
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |   20 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |    6 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |    2 +-
 .../testing/selftests/bpf/prog_tests/global_data.c |    6 +-
 tools/testing/selftests/bpf/prog_tests/mmap.c      |   19 +-
 .../selftests/bpf/prog_tests/prog_run_xattr.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c |    1 +
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c   |    2 +-
 .../selftests/bpf/prog_tests/test_global_funcs.c   |    2 +-
 tools/testing/selftests/bpf/prog_tests/varlen.c    |    8 +-
 .../testing/selftests/bpf/progs/core_reloc_types.h |   69 +-
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |   41 +
 tools/testing/selftests/bpf/progs/test_varlen.c    |    6 +-
 tools/testing/selftests/bpf/test_btf.c             |    8 +-
 tools/testing/selftests/bpf/test_maps.c            |    2 +
 tools/testing/selftests/bpf/test_progs.c           |    4 +-
 tools/testing/selftests/bpf/test_progs.h           |    5 +
 tools/testing/selftests/kvm/.gitignore             |    1 +
 tools/testing/selftests/kvm/Makefile               |    2 +
 tools/testing/selftests/kvm/include/x86_64/vmx.h   |    2 +-
 tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c |  168 ++
 tools/testing/selftests/kvm/x86_64/user_msr_test.c |  248 +++
 tools/testing/selftests/net/icmp_redirect.sh       |    2 +
 tools/testing/selftests/netfilter/nft_flowtable.sh |  130 +-
 tools/testing/selftests/powerpc/mm/.gitignore      |    1 +
 tools/testing/selftests/powerpc/mm/Makefile        |    4 +-
 tools/testing/selftests/powerpc/mm/prot_sao.c      |   43 +
 tools/testing/selftests/x86/test_vsyscall.c        |   22 +-
 tools/usb/Build                                    |    2 +
 tools/usb/Makefile                                 |   53 +-
 virt/kvm/eventfd.c                                 |    4 +-
 virt/kvm/kvm_main.c                                |   16 +-
 2162 files changed, 23091 insertions(+), 14460 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
 create mode 100644 arch/arm64/include/asm/hyp_image.h
 create mode 100644 arch/arm64/include/asm/kvm_pgtable.h
 create mode 100644 arch/arm64/include/asm/spectre.h
 create mode 100644 arch/arm64/kernel/proton-pack.c
 delete mode 100644 arch/arm64/kernel/ssbd.c
 delete mode 100644 arch/arm64/kvm/hyp.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/.gitignore
 create mode 100644 arch/arm64/kvm/hyp/nvhe/host.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp-main.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S
 create mode 100644 arch/arm64/kvm/hyp/pgtable.c
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 arch/x86/kvm/mmu/spte.c
 create mode 100644 arch/x86/kvm/mmu/spte.h
 create mode 100644 arch/x86/kvm/mmu/tdp_iter.c
 create mode 100644 arch/x86/kvm/mmu/tdp_iter.h
 create mode 100644 arch/x86/kvm/mmu/tdp_mmu.c
 create mode 100644 arch/x86/kvm/mmu/tdp_mmu.h
 create mode 100644 arch/x86/kvm/vmx/posted_intr.c
 create mode 100644 arch/x86/kvm/vmx/posted_intr.h
 rename arch/x86/kvm/vmx/{ops.h => vmx_ops.h} (100%)
 create mode 100644 drivers/clocksource/timer-clint.c
 create mode 100644 drivers/xen/unpopulated-alloc.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/user_msr_test.c
 create mode 100644 tools/testing/selftests/powerpc/mm/prot_sao.c
 create mode 100644 tools/usb/Build

