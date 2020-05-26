Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018871DD37E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgEUQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:57:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:46206 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbgEUQ5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:57:06 -0400
IronPort-SDR: ctcZwyo0VeUnJ/QjdP/V77Q98FI5qfbk2zGk/tpBlwrx1RC1Rhj6Jdm3mxSPa4wOuyzjI8I9mE
 IUEE7H821CgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:57:05 -0700
IronPort-SDR: GDu0AE+ARIYtin+MvSNXQy5yQWheRh35nBBasTrUJ+oWZ5PJP9U4MOs64Ob+Ilw8PdTF7i/zN/
 rPA3zY0UTwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="309094621"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2020 09:57:02 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v2 0/9] Function Granular KASLR
Date:   Thu, 21 May 2020 09:56:31 -0700
Message-Id: <20200521165641.15940-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function Granular Kernel Address Space Layout Randomization (fgkaslr)
---------------------------------------------------------------------

This patch set is an implementation of finer grained kernel address space
randomization. It rearranges your kernel code at load time 
on a per-function level granularity, with only around a second added to
boot time.

Changes in v2:
--------------
* Fix to address i386 build failure
* Allow module reordering patch to be configured separately so that
  arm (or other non-x86_64 arches) can take advantage of module function
  reordering. This support has not be tested by me, but smoke tested by
  Ard Biesheuvel <ardb@kernel.org> on arm.
* Fix build issue when building on arm as reported by
  Ard Biesheuvel <ardb@kernel.org> 
* minor chages for certain checkpatch warnings and review feedback.

Patches to objtool are included because they are dependencies for this
patchset, however they have been submitted by their maintainer separately.

Background
----------
KASLR was merged into the kernel with the objective of increasing the
difficulty of code reuse attacks. Code reuse attacks reused existing code
snippets to get around existing memory protections. They exploit software bugs
which expose addresses of useful code snippets to control the flow of
execution for their own nefarious purposes. KASLR moves the entire kernel
code text as a unit at boot time in order to make addresses less predictable.
The order of the code within the segment is unchanged - only the base address
is shifted. There are a few shortcomings to this algorithm.

1. Low Entropy - there are only so many locations the kernel can fit in. This
   means an attacker could guess without too much trouble.
2. Knowledge of a single address can reveal the offset of the base address,
   exposing all other locations for a published/known kernel image.
3. Info leaks abound.

Finer grained ASLR has been proposed as a way to make ASLR more resistant
to info leaks. It is not a new concept at all, and there are many variations
possible. Function reordering is an implementation of finer grained ASLR
which randomizes the layout of an address space on a function level
granularity. We use the term "fgkaslr" in this document to refer to the
technique of function reordering when used with KASLR, as well as finer grained
KASLR in general.

Proposed Improvement
--------------------
This patch set proposes adding function reordering on top of the existing
KASLR base address randomization. The over-arching objective is incremental
improvement over what we already have. It is designed to work in combination
with the existing solution. The implementation is really pretty simple, and
there are 2 main area where changes occur:

* Build time

GCC has had an option to place functions into individual .text sections for
many years now. This option can be used to implement function reordering at
load time. The final compiled vmlinux retains all the section headers, which
can be used to help find the address ranges of each function. Using this
information and an expanded table of relocation addresses, individual text
sections can be suffled immediately after decompression. Some data tables
inside the kernel that have assumptions about order require re-sorting
after being updated when applying relocations. In order to modify these tables,
a few key symbols are excluded from the objcopy symbol stripping process for
use after shuffling the text segments.

Some highlights from the build time changes to look for:

The top level kernel Makefile was modified to add the gcc flag if it
is supported. Currently, I am applying this flag to everything it is
possible to randomize. Anything that is written in C and is a function is
randomized. Future work could turn off this flags for selected
files or even entire subsystems, although obviously at the cost of security.

The relocs tool is updated to add relative relocations. This information
previously wasn't included because it wasn't necessary when moving the
entire .text segment as a unit. 

A new file was created to contain a list of symbols that objcopy should
keep. We use those symbols at load time as described below.

* Load time

The boot kernel was modified to parse the vmlinux elf file after
decompression to check for our interesting symbols that we kept, and to
look for any .text.* sections to randomize. We then shuffle the sections
and update any tables that need to be updated or resorted. The existing
code which updated relocation addresses was modified to account for not
just a fixed delta from the load address, but the offset that the function
section was moved to. This requires inspection of each address to see if
it was impacted by a randomization. We use a bsearch to make this less
horrible on performance.

In order to hide our new layout, symbols reported through /proc/kallsyms
will be sorted by name alphabetically rather than by address.

Security Considerations
-----------------------
The objective of this patch set is to improve a technology that is already
merged into the kernel (KASLR). This code will not prevent all attacks,
but should instead be considered as one of several tools that can be used.
In particular, this code is meant to make KASLR more effective in the presence
of info leaks.

How much entropy we are adding to the existing entropy of standard KASLR will
depend on a few variables. Firstly and most obviously, the number of functions
that are randomized matters. This implementation keeps the existing .text
section for code that cannot be randomized - for example, because it was
assembly code. The less sections to randomize, the less entropy. In addition,
due to alignment (16 bytes for x86_64), the number of bits in a address that
the attacker needs to guess is reduced, as the lower bits are identical.

Performance Impact
------------------
There are two areas where function reordering can impact performance: boot
time latency, and run time performance.

* Boot time latency
This implementation of finer grained KASLR impacts the boot time of the kernel
in several places. It requires additional parsing of the kernel ELF file to
obtain the section headers of the sections to be randomized. It calls the
random number generator for each section to be randomized to determine that
section's new memory location. It copies the decompressed kernel into a new
area of memory to avoid corruption when laying out the newly randomized
sections. It increases the number of relocations the kernel has to perform at
boot time vs. standard KASLR, and it also requires a lookup on each address
that needs to be relocated to see if it was in a randomized section and needs
to be adjusted by a new offset. Finally, it re-sorts a few data tables that
are required to be sorted by address.

Booting a test VM on a modern, well appointed system showed an increase in
latency of approximately 1 second.

* Run time
The performance impact at run-time of function reordering varies by workload.
Using kcbench, a kernel compilation benchmark, the performance of a kernel
build with finer grained KASLR was about 1% slower than a kernel with standard
KASLR. Analysis with perf showed a slightly higher percentage of 
L1-icache-load-misses. Other workloads were examined as well, with varied
results. Some workloads performed significantly worse under FGKASLR, while
others stayed the same or were mysteriously better. In general, it will
depend on the code flow whether or not finer grained KASLR will impact
your workload, and how the underlying code was designed. Because the layout
changes per boot, each time a system is rebooted the performance of a workload
may change.

Future work could identify hot areas that may not be randomized and either
leave them in the .text section or group them together into a single section
that may be randomized. If grouping things together helps, one other thing to
consider is that if we could identify text blobs that should be grouped together
to benefit a particular code flow, it could be interesting to explore
whether this security feature could be also be used as a performance
feature if you are interested in optimizing your kernel layout for a
particular workload at boot time. Optimizing function layout for a particular
workload has been researched and proven effective - for more information
read the Facebook paper "Optimizing Function Placement for Large-Scale
Data-Center Applications" (see references section below).

Image Size
----------
Adding additional section headers as a result of compiling with
-ffunction-sections will increase the size of the vmlinux ELF file.
With a standard distro config, the resulting vmlinux was increased by
about 3%. The compressed image is also increased due to the header files,
as well as the extra relocations that must be added. You can expect fgkaslr
to increase the size of the compressed image by about 15%.

Memory Usage
------------
fgkaslr increases the amount of heap that is required at boot time,
although this extra memory is released when the kernel has finished
decompression. As a result, it may not be appropriate to use this feature on
systems without much memory.

Building
--------
To enable fine grained KASLR, you need to have the following config options
set (including all the ones you would use to build normal KASLR)

CONFIG_FG_KASLR=y

In addition, fgkaslr is only supported for the X86_64 architecture.

Modules
-------
Modules are randomized similarly to the rest of the kernel by shuffling
the sections at load time prior to moving them into memory. The module must
also have been build with the -ffunction-sections compiler option.

Although fgkaslr for the kernel is only supported for the X86_64 architecture,
it is possible to use fgkaslr with modules on other architectures. To enable
this feature, select

CONFIG_MODULE_FG_KASLR=y

This option is selected automatically for X86_64 when CONFIG_FG_KASLR is set.

Disabling
---------
Disabling normal KASLR using the nokaslr command line option also disables
fgkaslr. It is also possible to disable fgkaslr separately by booting with
fgkaslr=off on the commandline.

References
----------
There are a lot of academic papers which explore finer grained ASLR.
This paper in particular contributed the most to my implementation design
as well as my overall understanding of the problem space:

Selfrando: Securing the Tor Browser against De-anonymization Exploits,
M. Conti, S. Crane, T. Frassetto, et al.

For more information on how function layout impacts performance, see:

Optimizing Function Placement for Large-Scale Data-Center Applications,
G. Ottoni, B. Maher

Kees Cook (1):
  x86/boot: Allow a "silent" kaslr random byte fetch

Kristen Carlson Accardi (8):
  objtool: Do not assume order of parent/child functions
  x86: tools/relocs: Support >64K section headers
  x86: Makefile: Add build and config option for CONFIG_FG_KASLR
  x86: Make sure _etext includes function sections
  x86/tools: Add relative relocs for randomized functions
  x86: Add support for function granular KASLR
  kallsyms: Hide layout
  module: Reorder functions

 Documentation/security/fgkaslr.rst       | 155 +++++
 Documentation/security/index.rst         |   1 +
 Makefile                                 |   4 +
 arch/x86/Kconfig                         |  14 +
 arch/x86/Makefile                        |   3 +
 arch/x86/boot/compressed/Makefile        |  10 +-
 arch/x86/boot/compressed/fgkaslr.c       | 823 +++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c         |   4 -
 arch/x86/boot/compressed/misc.c          | 109 ++-
 arch/x86/boot/compressed/misc.h          |  34 +
 arch/x86/boot/compressed/utils.c         |  12 +
 arch/x86/boot/compressed/vmlinux.symbols |  17 +
 arch/x86/include/asm/boot.h              |  15 +-
 arch/x86/kernel/vmlinux.lds.S            |  18 +-
 arch/x86/lib/kaslr.c                     |  18 +-
 arch/x86/tools/relocs.c                  | 143 +++-
 arch/x86/tools/relocs.h                  |   4 +-
 arch/x86/tools/relocs_common.c           |  15 +-
 include/asm-generic/vmlinux.lds.h        |   2 +-
 include/uapi/linux/elf.h                 |   1 +
 init/Kconfig                             |  11 +
 kernel/kallsyms.c                        | 138 +++-
 kernel/module.c                          |  81 +++
 tools/objtool/elf.c                      |   8 +-
 24 files changed, 1578 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/security/fgkaslr.rst
 create mode 100644 arch/x86/boot/compressed/fgkaslr.c
 create mode 100644 arch/x86/boot/compressed/utils.c
 create mode 100644 arch/x86/boot/compressed/vmlinux.symbols


base-commit: b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
-- 
2.20.1

