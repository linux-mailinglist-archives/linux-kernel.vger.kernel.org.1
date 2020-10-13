Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB728CC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgJMLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbgJMLIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:08:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A93EAD57;
        Tue, 13 Oct 2020 11:08:30 +0000 (UTC)
Date:   Tue, 13 Oct 2020 13:08:19 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/seves for v5.10
Message-ID: <20201013110819.GC32151@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the pile which enables Linux to run as an SEV-ES guest on an
AMD hypervisor.

Thx.

---
The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.10

for you to fetch changes up to 0ddfb1cf3b6b07c97cff16ea69931d986f9622ee:

  x86/sev-es: Use GHCB accessor for setting the MMIO scratch buffer (2020-09-25 17:12:41 +0200)

----------------------------------------------------------------
This feature enhances the current guest memory encryption support
called SEV by also encrypting the guest register state, making the
registers inaccessible to the hypervisor by en-/decrypting them on world
switches. Thus, it adds additional protection to Linux guests against
exfiltration, control flow and rollback attacks.

With SEV-ES, the guest is in full control of what registers the
hypervisor can access. This is provided by a guest-host exchange
mechanism based on a new exception vector called VMM Communication
Exception (#VC), a new instruction called VMGEXIT and a shared
Guest-Host Communication Block which is a decrypted page shared between
the guest and the hypervisor.

Intercepts to the hypervisor become #VC exceptions in an SEV-ES guest so
in order for that exception mechanism to work, the early x86 init code
needed to be made able to handle exceptions, which, in itself, brings
a bunch of very nice cleanups and improvements to the early boot code
like an early page fault handler, allowing for on-demand building of the
identity mapping. With that, !KASLR configurations do not use the EFI
page table anymore but switch to a kernel-controlled one.

The main part of this series adds the support for that new exchange
mechanism. The goal has been to keep this as much as possibly
separate from the core x86 code by concentrating the machinery in two
SEV-ES-specific files:

 arch/x86/kernel/sev-es-shared.c
 arch/x86/kernel/sev-es.c

Other interaction with core x86 code has been kept at minimum and behind
static keys to minimize the performance impact on !SEV-ES setups.

Work by Joerg Roedel and Thomas Lendacky and others.

----------------------------------------------------------------
Borislav Petkov (3):
      Merge 'x86/kaslr' to pick up dependent bits
      Merge 'x86/cpu' to pick up dependent bits
      KVM: SVM: Use __packed shorthand

Doug Covelli (1):
      x86/vmware: Add VMware-specific handling for VMMCALL under SEV-ES

Joerg Roedel (50):
      KVM: SVM: nested: Don't allocate VMCB structures on stack
      KVM: SVM: Add GHCB Accessor functions
      x86/traps: Move pf error codes to <asm/trap_pf.h>
      x86/insn: Make inat-tables.c suitable for pre-decompression code
      x86/umip: Factor out instruction fetch
      x86/umip: Factor out instruction decoding
      x86/insn: Add insn_get_modrm_reg_off()
      x86/insn: Add insn_has_rep_prefix() helper
      x86/boot/compressed/64: Disable red-zone usage
      x86/boot/compressed/64: Add IDT Infrastructure
      x86/boot/compressed/64: Rename kaslr_64.c to ident_map_64.c
      x86/boot/compressed/64: Add page-fault handler
      x86/boot/compressed/64: Always switch to own page table
      x86/boot/compressed/64: Don't pre-map memory in KASLR code
      x86/boot/compressed/64: Change add_identity_map() to take start and end
      x86/boot/compressed/64: Add stage1 #VC handler
      x86/boot/compressed/64: Call set_sev_encryption_mask() earlier
      x86/boot/compressed/64: Check return value of kernel_ident_mapping_init()
      x86/boot/compressed/64: Add set_page_en/decrypted() helpers
      x86/boot/compressed/64: Setup a GHCB-based VC Exception handler
      x86/boot/compressed/64: Unmap GHCB page before booting the kernel
      x86/fpu: Move xgetbv()/xsetbv() into a separate header
      x86/idt: Split idt_data setup out of set_intr_gate()
      x86/head/64: Install startup GDT
      x86/head/64: Load GDT after switch to virtual addresses
      x86/head/64: Load segment registers earlier
      x86/head/64: Switch to initial stack earlier
      x86/head/64: Install a CPU bringup IDT
      x86/idt: Make IDT init functions static inlines
      x86/head/64: Move early exception dispatch to C code
      x86/sev-es: Add SEV-ES Feature Detection
      x86/sev-es: Print SEV-ES info into the kernel log
      x86/sev-es: Compile early handler code into kernel image
      x86/sev-es: Setup an early #VC handler
      x86/sev-es: Setup GHCB-based boot #VC handler
      x86/sev-es: Allocate and map an IST stack for #VC handler
      x86/sev-es: Adjust #VC IST Stack on entering NMI handler
      x86/dumpstack/64: Add noinstr version of get_stack_info()
      x86/entry/64: Add entry code for #VC handler
      x86/sev-es: Wire up existing #VC exit-code handlers
      x86/sev-es: Handle instruction fetches from user-space
      x86/sev-es: Handle MMIO String Instructions
      x86/sev-es: Handle #AC Events
      x86/sev-es: Handle #DB Events
      x86/paravirt: Allow hypervisor-specific VMMCALL handling under SEV-ES
      x86/realmode: Add SEV-ES specific trampoline entry point
      x86/smpboot: Load TSS and getcpu GDT entry before loading IDT
      x86/head/64: Don't call verify_cpu() on starting APs
      x86/sev-es: Support CPU offline/online
      x86/sev-es: Handle NMI State

Martin Radev (1):
      x86/sev-es: Check required CPU features for SEV-ES

Tom Lendacky (20):
      KVM: SVM: Add GHCB definitions
      x86/cpufeatures: Add SEV-ES CPU feature
      x86/sev-es: Add support for handling IOIO exceptions
      x86/sev-es: Add CPUID handling to #VC handler
      x86/sev-es: Setup per-CPU GHCBs for the runtime handler
      x86/sev-es: Add a Runtime #VC Exception Handler
      x86/sev-es: Handle MMIO events
      x86/sev-es: Handle MSR events
      x86/sev-es: Handle DR7 read/write events
      x86/sev-es: Handle WBINVD Events
      x86/sev-es: Handle RDTSC(P) Events
      x86/sev-es: Handle RDPMC Events
      x86/sev-es: Handle INVD Events
      x86/sev-es: Handle MONITOR/MONITORX Events
      x86/sev-es: Handle MWAIT/MWAITX Events
      x86/sev-es: Handle VMMCALL Events
      x86/kvm: Add KVM-specific VMMCALL handling under SEV-ES
      x86/realmode: Setup AP jump table
      x86/efi: Add GHCB mappings when SEV-ES is active
      x86/sev-es: Use GHCB accessor for setting the MMIO scratch buffer

 arch/x86/Kconfig                           |    1 +
 arch/x86/boot/compressed/Makefile          |   11 +-
 arch/x86/boot/compressed/cpuflags.c        |    4 -
 arch/x86/boot/compressed/head_64.S         |   33 +-
 arch/x86/boot/compressed/ident_map_64.c    |  349 +++++++
 arch/x86/boot/compressed/idt_64.c          |   54 ++
 arch/x86/boot/compressed/idt_handlers_64.S |   77 ++
 arch/x86/boot/compressed/kaslr.c           |  266 ++----
 arch/x86/boot/compressed/kaslr_64.c        |  153 ---
 arch/x86/boot/compressed/misc.c            |    7 +
 arch/x86/boot/compressed/misc.h            |   54 +-
 arch/x86/boot/compressed/sev-es.c          |  214 +++++
 arch/x86/entry/entry_64.S                  |   80 ++
 arch/x86/include/asm/cpu_entry_area.h      |   33 +-
 arch/x86/include/asm/cpufeatures.h         |    2 +
 arch/x86/include/asm/desc.h                |   27 +
 arch/x86/include/asm/desc_defs.h           |   10 +
 arch/x86/include/asm/fpu/internal.h        |   33 +-
 arch/x86/include/asm/fpu/xcr.h             |   34 +
 arch/x86/include/asm/idtentry.h            |   50 +
 arch/x86/include/asm/insn-eval.h           |    6 +
 arch/x86/include/asm/mem_encrypt.h         |    5 +
 arch/x86/include/asm/msr-index.h           |    3 +
 arch/x86/include/asm/page_64_types.h       |    1 +
 arch/x86/include/asm/pgtable.h             |    2 +-
 arch/x86/include/asm/processor.h           |    1 +
 arch/x86/include/asm/proto.h               |    1 +
 arch/x86/include/asm/realmode.h            |    7 +
 arch/x86/include/asm/segment.h             |    2 +-
 arch/x86/include/asm/setup.h               |    6 +-
 arch/x86/include/asm/sev-es.h              |  114 +++
 arch/x86/include/asm/special_insns.h       |    6 +
 arch/x86/include/asm/stacktrace.h          |    2 +
 arch/x86/include/asm/svm.h                 |  106 ++-
 arch/x86/include/asm/sync_core.h           |   34 +-
 arch/x86/include/asm/trap_pf.h             |   24 +
 arch/x86/include/asm/trapnr.h              |    1 +
 arch/x86/include/asm/traps.h               |   20 +-
 arch/x86/include/asm/x86_init.h            |   16 +-
 arch/x86/include/uapi/asm/svm.h            |   11 +
 arch/x86/kernel/Makefile                   |    3 +
 arch/x86/kernel/cpu/amd.c                  |    3 +-
 arch/x86/kernel/cpu/common.c               |   25 +
 arch/x86/kernel/cpu/scattered.c            |    1 +
 arch/x86/kernel/cpu/vmware.c               |   50 +-
 arch/x86/kernel/dumpstack.c                |    7 +-
 arch/x86/kernel/dumpstack_64.c             |   46 +-
 arch/x86/kernel/head64.c                   |  122 ++-
 arch/x86/kernel/head_64.S                  |  165 +++-
 arch/x86/kernel/idt.c                      |   41 +-
 arch/x86/kernel/kvm.c                      |   35 +-
 arch/x86/kernel/nmi.c                      |   15 +
 arch/x86/kernel/sev-es-shared.c            |  507 ++++++++++
 arch/x86/kernel/sev-es.c                   | 1404 ++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c                  |    2 +-
 arch/x86/kernel/traps.c                    |   48 +
 arch/x86/kernel/umip.c                     |   89 +-
 arch/x86/kvm/cpuid.c                       |    2 +-
 arch/x86/kvm/svm/nested.c                  |   47 +-
 arch/x86/kvm/svm/svm.c                     |    2 +
 arch/x86/lib/insn-eval.c                   |  130 +++
 arch/x86/mm/cpu_entry_area.c               |    3 +-
 arch/x86/mm/extable.c                      |    1 +
 arch/x86/mm/mem_encrypt.c                  |   38 +-
 arch/x86/mm/mem_encrypt_identity.c         |    3 +
 arch/x86/platform/efi/efi_64.c             |   10 +
 arch/x86/realmode/init.c                   |   24 +-
 arch/x86/realmode/rm/header.S              |    3 +
 arch/x86/realmode/rm/trampoline_64.S       |   20 +
 arch/x86/tools/gen-insn-attr-x86.awk       |   50 +-
 tools/arch/x86/tools/gen-insn-attr-x86.awk |   50 +-
 71 files changed, 4195 insertions(+), 611 deletions(-)
 create mode 100644 arch/x86/boot/compressed/ident_map_64.c
 create mode 100644 arch/x86/boot/compressed/idt_64.c
 create mode 100644 arch/x86/boot/compressed/idt_handlers_64.S
 delete mode 100644 arch/x86/boot/compressed/kaslr_64.c
 create mode 100644 arch/x86/boot/compressed/sev-es.c
 create mode 100644 arch/x86/include/asm/fpu/xcr.h
 create mode 100644 arch/x86/include/asm/sev-es.h
 create mode 100644 arch/x86/include/asm/trap_pf.h
 create mode 100644 arch/x86/kernel/sev-es-shared.c
 create mode 100644 arch/x86/kernel/sev-es.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
