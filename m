Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2291AB324
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442302AbgDOVJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 17:09:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:64180 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438738AbgDOVGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:06:10 -0400
IronPort-SDR: 6OaJ7Y1J8DwBP2GfhIMryDrcsZLGgBIkXm7iJfUVIu8yAReAfbKf7TIOB1E8B24XUlYhKRWYP6
 eqVxjN+WWycw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 14:05:34 -0700
IronPort-SDR: RY3uSsYr+VE1WD3XE9+Y3RYlY5cWVya4Tm6IOq3nV0BccKzcwUWNJ0U5y37tjwefBQJDo+WXMt
 DpUdJ9mxkw0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="455035607"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.116.191])
  by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 14:05:30 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        x86@kernel.org
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com,
        linux-doc@vger.kernel.org
Subject: [PATCH 7/9] x86: Add support for function granular KASLR
Date:   Wed, 15 Apr 2020 14:04:49 -0700
Message-Id: <20200415210452.27436-8-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415210452.27436-1-kristen@linux.intel.com>
References: <20200415210452.27436-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time, find all the function sections that have separate .text
sections, shuffle them, and then copy them to new locations. Adjust
any relocations accordingly.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 Documentation/security/fgkaslr.rst       | 151 +++++
 Documentation/security/index.rst         |   1 +
 arch/x86/boot/compressed/Makefile        |   3 +
 arch/x86/boot/compressed/fgkaslr.c       | 809 +++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c         |   7 +-
 arch/x86/boot/compressed/misc.c          | 107 ++-
 arch/x86/boot/compressed/misc.h          |  31 +
 arch/x86/boot/compressed/utils.c         |  12 +
 arch/x86/boot/compressed/vmlinux.symbols |  18 +
 arch/x86/include/asm/boot.h              |  15 +-
 include/uapi/linux/elf.h                 |   1 +
 11 files changed, 1139 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/security/fgkaslr.rst
 create mode 100644 arch/x86/boot/compressed/fgkaslr.c
 create mode 100644 arch/x86/boot/compressed/utils.c
 create mode 100644 arch/x86/boot/compressed/vmlinux.symbols

diff --git a/Documentation/security/fgkaslr.rst b/Documentation/security/fgkaslr.rst
new file mode 100644
index 000000000000..d08a2fbdb475
--- /dev/null
+++ b/Documentation/security/fgkaslr.rst
@@ -0,0 +1,151 @@
+=====================================================================
+Function Granular Kernel Address Space Layout Randomization (fgkaslr)
+=====================================================================
+
+:Date: 6 April 2020
+:Author: Kristen Accardi
+
+Kernel Address Space Layout Randomization (KASLR) was merged into the kernel
+with the objective of increasing the difficulty of code reuse attacks. Code
+reuse attacks reused existing code snippets to get around existing memory
+protections. They exploit software bugs which expose addresses of useful code
+snippets to control the flow of execution for their own nefarious purposes.
+KASLR as it was originally implemented moves the entire kernel code text as a
+unit at boot time in order to make addresses less predictable. The order of the
+code within the segment is unchanged - only the base address is shifted. There
+are a few shortcomings to this algorithm.
+
+1. Low Entropy - there are only so many locations the kernel can fit in. This
+   means an attacker could guess without too much trouble.
+2. Knowledge of a single address can reveal the offset of the base address,
+   exposing all other locations for a published/known kernel image.
+3. Info leaks abound.
+
+Finer grained ASLR has been proposed as a way to make ASLR more resistant
+to info leaks. It is not a new concept at all, and there are many variations
+possible. Function reordering is an implementation of finer grained ASLR
+which randomizes the layout of an address space on a function level
+granularity. We use the term "fgkaslr" in this document to refer to the
+technique of function reordering when used with KASLR, as well as finer grained
+KASLR in general.
+
+Implementation Details
+======================
+
+The over-arching objective of the fgkaslr implementation is incremental
+improvement over what we already have, as well as something that can be
+merged and deployed with as little disruption to our existing kernel/ecosystem
+as possible. It is designed to work with the existing solution, and there are
+two main area where code changes occur: Build time, and Load time.
+
+Build time
+----------
+
+GCC has an option to place functions into individual .text sections. We can
+use this option to implement function reordering at load time. The final
+compiled vmlinux retains all the section headers, which can be used to help
+us find the address ranges of each function. Using this information and
+an expanded table of relocation addresses, we can shuffle the individual
+text sections immediately after decompression. You are probably asking
+yourself how this could possibly work given the number of tables of
+addresses that exist inside the kernel today for features such as exception
+handling and kprobes. Most of these tables generate relocations and
+require a simple update, and some tables that have assumptions about order
+require sorting after the update. In order to modify these tables, we
+preserve a few key symbols from the objcopy symbol stripping process for use
+after shuffling the text segments.
+
+Load time
+---------
+
+The boot kernel was modified to parse the vmlinux elf file after
+decompression to check for our interesting symbols that we kept, and to
+look for any .text.* sections to randomize. We then shuffle the sections
+and update any tables that need to be updated or resorted. The existing
+code which updated relocation addresses was modified to account for not
+just a fixed delta from the load address, but the offset that the function
+section was moved to. This requires inspection of each address to see if
+it was impacted by a randomization. In order to hide our new layout,
+symbols reported through /proc/kallsyms will be sorted by name alphabetically
+rather than by address.
+
+Security Considerations
+=======================
+
+The objective of this patch set is to improve a technology that is already
+merged into the kernel (KASLR). Obviously, this code is not a one stop
+shopping place for blocking code reuse attacks, but should instead be
+considered as one of several tools that can be used. In particular, this
+code is meant to make KASLR more effective in the presence of info leaks.
+A key point to note is that we are basically accepting that there are
+many and various ways to leak address today and in the future, and rather
+than assume that we can stop them all, we should find a method which makes
+individual info leaks less important. How much entropy we are adding to
+the existing entropy of standard KASLR will depend on a few variables.
+Firstly and most obviously, the number of functions you randomize matters.
+This implementation keeps the existing .text section for code that cannot be
+randomized - for example, because it was assembly code, or we opted out of
+randomization for performance reasons. The less sections to randomize, the
+less entropy. In addition, due to alignment (16 bytes for x86_64), the number
+of bits in a address that the attacker needs to guess is reduced, as the lower
+bits are identical.
+
+Performance Impact
+==================
+
+There are two areas where function reordering can impact performance: boot
+time latency, and run time performance.
+
+Boot time latency
+-----------------
+
+This implementation of finer grained KASLR impacts the boot time of the kernel
+in several places. It requires additional parsing of the kernel ELF file to
+obtain the section headers of the sections to be randomized. It calls the
+random number generator for each section to be randomized to determine that
+section's new memory location. It copies the decompressed kernel into a new
+area of memory to avoid corruption when laying out the newly randomized
+sections. It increases the number of relocations the kernel has to perform at
+boot time vs. standard KASLR, and it also requires a lookup on each address
+that needs to be relocated to see if it was in a randomized section and needs
+to be adjusted by a new offset. Finally, it re-sorts a few data tables that
+are required to be sorted by address.
+
+Booting a test VM on a modern, well appointed system showed an increase in
+latency of approximately 1 second.
+
+Run time
+--------
+
+The performance impact at run-time of function reordering varies by workload.
+Randomly reordering the functions will cause an increase in cache misses
+for some workloads. You should expect to see some workloads perform
+significantly worse under FGKASLR, while others stay the same or even
+mysteriously improve. In general, it will depend on the code flow whether or
+not finer grained KASLR will impact your workload, and how the underlying code
+was designed.
+
+Image Size
+==========
+
+fgkaslr increases the size of the kernel binary due to the extra section
+headers that are included, as well as the extra relocations that need to
+be added. You can expect fgkaslr to increase the size of the resulting
+vmlinux by about 3%, and the compressed image (bzImage) by 15%.
+
+Building
+========
+
+To enable fine grained KASLR, you need to have the following config options
+set (including all the ones you would use to build normal KASLR)
+
+``CONFIG_FG_KASLR=y``
+
+In addition, fgkaslr is only supported for the X86_64 architecture.
+
+Modules
+=======
+
+Modules are randomized similarly to the rest of the kernel by shuffling
+the sections at load time prior to moving them into memory. The module must
+also have been build with the -ffunction-sections compiler option.
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..5e370c409ad2 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -7,6 +7,7 @@ Security Documentation
 
    credentials
    IMA-templates
+   fgkaslr
    keys/index
    lsm
    lsm-development
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a5a004498de..0ad5a31f1f0a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -80,10 +80,12 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
+vmlinux-objs-$(CONFIG_FG_KASLR) += $(obj)/utils.o
 ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
+	vmlinux-objs-$(CONFIG_FG_KASLR) += $(obj)/fgkaslr.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
@@ -120,6 +122,7 @@ OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 
 ifdef CONFIG_FG_KASLR
 	RELOCS_ARGS += --fg-kaslr
+	OBJCOPYFLAGS += --keep-symbols=$(srctree)/$(src)/vmlinux.symbols
 endif
 
 $(obj)/vmlinux.bin: vmlinux FORCE
diff --git a/arch/x86/boot/compressed/fgkaslr.c b/arch/x86/boot/compressed/fgkaslr.c
new file mode 100644
index 000000000000..d45016840cdd
--- /dev/null
+++ b/arch/x86/boot/compressed/fgkaslr.c
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fgkaslr.c
+ *
+ * This contains the routines needed to reorder the kernel text section
+ * at boot time.
+ */
+#include "misc.h"
+#include "error.h"
+#include "pgtable.h"
+#include "../string.h"
+#include "../voffset.h"
+#include <linux/sort.h>
+#include <linux/bsearch.h>
+#include "../../include/asm/extable.h"
+#include "../../include/asm/orc_types.h"
+
+/*
+ * Longest parameter of 'fgkaslr=' is 'off' right now, plus an extra '\0'
+ * for termination.
+ */
+#define MAX_FGKASLR_ARG_LENGTH 4
+int nofgkaslr;
+
+/*
+ * Use normal definitions of mem*() from string.c. There are already
+ * included header files which expect a definition of memset() and by
+ * the time we define memset macro, it is too late.
+ */
+#undef memcpy
+#undef memset
+#define memzero(s, n)	memset((s), 0, (n))
+#define memmove		memmove
+
+void *memmove(void *dest, const void *src, size_t n);
+
+static unsigned long percpu_start;
+static unsigned long percpu_end;
+
+static long kallsyms_names;
+static long kallsyms_offsets;
+static long kallsyms_num_syms;
+static long kallsyms_relative_base;
+static long kallsyms_markers;
+static long __start___ex_table_addr;
+static long __stop___ex_table_addr;
+static long _stext;
+static long _etext;
+static long _sinittext;
+static long _einittext;
+static long __start_orc_unwind_ip;
+static long __stop_orc_unwind_ip;
+static long __start_orc_unwind;
+static long __stop_orc_unwind;
+
+/* addresses in mapped address space */
+static int *base;
+static u8 *names;
+static unsigned long relative_base;
+static unsigned int *markers_addr;
+
+struct kallsyms_name {
+	u8 len;
+	u8 indecis[256];
+};
+struct kallsyms_name *names_table;
+
+struct orc_entry *cur_orc_table;
+int *cur_orc_ip_table;
+
+/*
+ * This is an array of pointers to sections headers for randomized sections
+ */
+Elf64_Shdr **sections;
+
+/*
+ * This is an array of all section headers, randomized or otherwise.
+ */
+Elf64_Shdr *sechdrs;
+
+/*
+ * The number of elements in the randomized section header array (sections)
+ */
+int sections_size;
+
+static bool is_text(long addr)
+{
+	if ((addr >= _stext && addr < _etext) ||
+	   (addr >= _sinittext && addr < _einittext))
+		return true;
+	return false;
+}
+
+bool is_percpu_addr(long pc, long offset)
+{
+	unsigned long ptr;
+	long address;
+
+	address = pc + offset + 4;
+
+	ptr = (unsigned long) address;
+
+	if (ptr >= percpu_start && ptr < percpu_end)
+		return true;
+
+	return false;
+}
+
+static int cmp_section_addr(const void *a, const void *b)
+{
+	unsigned long ptr = (unsigned long)a;
+	Elf64_Shdr *s = *(Elf64_Shdr **)b;
+	unsigned long end = s->sh_addr + s->sh_size;
+
+	if (ptr >= s->sh_addr && ptr < end)
+		return 0;
+
+	if (ptr < s->sh_addr)
+		return -1;
+
+	return 1;
+}
+
+/*
+ * Discover if the address is in a randomized section and if so, adjust
+ * by the saved offset.
+ */
+Elf64_Shdr *adjust_address(long *address)
+{
+	Elf64_Shdr **s;
+	Elf64_Shdr *shdr;
+
+	if (nofgkaslr)
+		return NULL;
+
+	s = bsearch((const void *)*address, sections, sections_size, sizeof(*s),
+			cmp_section_addr);
+	if (s != NULL) {
+		shdr = *s;
+		*address += shdr->sh_offset;
+		return shdr;
+	}
+
+	return NULL;
+}
+
+void adjust_relative_offset(long pc, long *value, Elf64_Shdr *section)
+{
+	Elf64_Shdr *s;
+	long address;
+
+	if (nofgkaslr)
+		return;
+
+	/*
+	 * sometimes we are updating a relative offset that would
+	 * normally be relative to the next instruction (such as a call).
+	 * In this case to calculate the target, you need to add 32bits to
+	 * the pc to get the next instruction value. However, sometimes
+	 * targets are just data that was stored in a table such as ksymtab
+	 * or cpu alternatives. In this case our target is not relative to
+	 * the next instruction.
+	 */
+
+	/*
+	 * Calculate the address that this offset would call.
+	 */
+	if (!is_text(pc))
+		address = pc + *value;
+	else
+		address = pc + *value + 4;
+
+	/*
+	 * if the address is in section that was randomized,
+	 * we need to adjust the offset.
+	 */
+	s = adjust_address(&address);
+	if (s != NULL)
+		*value += s->sh_offset;
+
+	/*
+	 * If the PC that this offset was calculated for was in a section
+	 * that has been randomized, the value needs to be adjusted by the
+	 * same amount as the randomized section was adjusted from it's original
+	 * location.
+	 */
+	if (section != NULL)
+		*value -= section->sh_offset;
+
+}
+
+static void kallsyms_swp(void *a, void *b, int size)
+{
+	int idx1, idx2;
+	int temp;
+	struct kallsyms_name name_a;
+
+	/* determine our index into the array */
+	idx1 = (int *)a - base;
+	idx2 = (int *)b - base;
+	temp = base[idx1];
+	base[idx1] = base[idx2];
+	base[idx2] = temp;
+
+	/* also swap the names table */
+	memcpy(&name_a, &names_table[idx1], sizeof(name_a));
+	memcpy(&names_table[idx1], &names_table[idx2],
+		sizeof(struct kallsyms_name));
+	memcpy(&names_table[idx2], &name_a, sizeof(struct kallsyms_name));
+}
+
+static int kallsyms_cmp(const void *a, const void *b)
+{
+	int addr_a, addr_b;
+	unsigned long uaddr_a, uaddr_b;
+
+	addr_a = *(int *)a;
+	addr_b = *(int *)b;
+
+	if (addr_a >= 0)
+		uaddr_a = addr_a;
+	if (addr_b >= 0)
+		uaddr_b = addr_b;
+
+	if (addr_a < 0)
+		uaddr_a = relative_base - 1 - addr_a;
+	if (addr_b < 0)
+		uaddr_b = relative_base - 1 - addr_b;
+
+	if (uaddr_b > uaddr_a)
+		return -1;
+
+	return 0;
+}
+
+static void deal_with_names(int num_syms)
+{
+	int num_bytes;
+	int i, j;
+	int offset;
+
+
+	/* we should have num_syms kallsyms_name entries */
+	num_bytes = num_syms * sizeof(*names_table);
+	names_table = malloc(num_syms * sizeof(*names_table));
+	if (names_table == NULL) {
+		debug_putstr("\nbytes requested: ");
+		debug_puthex(num_bytes);
+		error("\nunable to allocate space for names table\n");
+	}
+
+	/* read all the names entries */
+	offset = 0;
+	for (i = 0; i < num_syms; i++) {
+		names_table[i].len = names[offset];
+		offset++;
+		for (j = 0; j < names_table[i].len; j++) {
+			names_table[i].indecis[j] = names[offset];
+			offset++;
+		}
+	}
+}
+
+static void write_sorted_names(int num_syms)
+{
+	int i, j;
+	int offset = 0;
+	unsigned int *markers;
+
+	/*
+	 * we are going to need to regenerate the markers table, which is a
+	 * table of offsets into the compressed stream every 256 symbols.
+	 * this code copied almost directly from scripts/kallsyms.c
+	 */
+	markers = malloc(sizeof(unsigned int) * ((num_syms + 255) / 256));
+	if (!markers) {
+		debug_putstr("\nfailed to allocate heap space of ");
+		debug_puthex(((num_syms + 255) / 256));
+		debug_putstr(" bytes\n");
+		error("Unable to allocate space for markers table");
+	}
+
+	for (i = 0; i < num_syms; i++) {
+		if ((i & 0xFF) == 0)
+			markers[i >> 8] = offset;
+
+		names[offset] = (u8) names_table[i].len;
+		offset++;
+		for (j = 0; j < names_table[i].len; j++) {
+			names[offset] = (u8) names_table[i].indecis[j];
+			offset++;
+		}
+	}
+
+	/* write new markers table over old one */
+	for (i = 0; i < ((num_syms + 255) >> 8); i++)
+		markers_addr[i] = markers[i];
+
+	free(markers);
+	free(names_table);
+}
+
+static void sort_kallsyms(unsigned long map)
+{
+	int num_syms;
+	int i;
+
+	debug_putstr("\nRe-sorting kallsyms ...");
+
+	num_syms = *(int *)(kallsyms_num_syms + map);
+	base = (int *)(kallsyms_offsets + map);
+	relative_base = *(unsigned long *)(kallsyms_relative_base + map);
+	markers_addr = (unsigned int *)(kallsyms_markers + map);
+	names = (u8 *)(kallsyms_names + map);
+
+	/*
+	 * the kallsyms table was generated prior to any randomization.
+	 * it is a bunch of offsets from "relative base". In order for
+	 * us to check if a symbol has an address that was in a randomized
+	 * section, we need to reconstruct the address to it's original
+	 * value prior to handle_relocations.
+	 */
+	for (i = 0; i < num_syms; i++) {
+		unsigned long addr;
+		int new_base;
+
+		/*
+		 * according to kernel/kallsyms.c, positive offsets are absolute
+		 * values and negative offsets are relative to the base.
+		 */
+		if (base[i] >= 0)
+			addr = base[i];
+		else
+			addr = relative_base - 1 - base[i];
+
+		if (adjust_address(&addr)) {
+			/* here we need to recalcuate the offset */
+			new_base = relative_base - 1 - addr;
+			base[i] = new_base;
+		}
+	}
+
+	/*
+	 * here we need to read in all the kallsyms_names info
+	 * so that we can regenerate it.
+	 */
+	deal_with_names(num_syms);
+
+	sort(base, num_syms, sizeof(int), kallsyms_cmp, kallsyms_swp);
+
+	/* write the newly sorted names table over the old one */
+	write_sorted_names(num_syms);
+}
+
+#define ARCH_HAS_SEARCH_EXTABLE
+#include "../../../../lib/extable.c"
+
+static inline unsigned long
+ex_fixup_handler(const struct exception_table_entry *x)
+{
+	return ((unsigned long)&x->handler + x->handler);
+}
+
+static inline unsigned long
+ex_fixup_addr(const struct exception_table_entry *x)
+{
+	return ((unsigned long)&x->fixup + x->fixup);
+}
+
+static void update_ex_table(unsigned long map)
+{
+	struct exception_table_entry *start_ex_table = (struct exception_table_entry *) (__start___ex_table_addr + map);
+	struct exception_table_entry *stop_ex_table = (struct exception_table_entry *) (__stop___ex_table_addr + map);
+	int num_entries = (__stop___ex_table_addr - __start___ex_table_addr) / sizeof(struct exception_table_entry);
+	int i;
+
+	debug_putstr("\nUpdating exception table...\n");
+	for (i = 0; i < num_entries; i++) {
+		unsigned long insn = ex_to_insn(&start_ex_table[i]);
+		unsigned long fixup = ex_fixup_addr(&start_ex_table[i]);
+		unsigned long handler = ex_fixup_handler(&start_ex_table[i]);
+		unsigned long addr;
+		Elf64_Shdr *s;
+
+		/* check each address to see if it needs adjusting */
+		addr = insn - map;
+		s = adjust_address(&addr);
+		if (s != NULL)
+			start_ex_table[i].insn += s->sh_offset;
+
+		addr = fixup - map;
+		s = adjust_address(&addr);
+		if (s != NULL)
+			start_ex_table[i].fixup += s->sh_offset;
+
+		addr = handler - map;
+		s = adjust_address(&addr);
+		if (s != NULL)
+			start_ex_table[i].handler += s->sh_offset;
+	}
+}
+
+static void sort_ex_table(unsigned long map)
+{
+	struct exception_table_entry *start_ex_table = (struct exception_table_entry *) (__start___ex_table_addr + map);
+	struct exception_table_entry *stop_ex_table = (struct exception_table_entry *) (__stop___ex_table_addr + map);
+
+	debug_putstr("\nRe-sorting exception table...\n");
+
+	sort_extable(start_ex_table, stop_ex_table);
+}
+
+static inline unsigned long orc_ip(const int *ip)
+{
+	return (unsigned long)ip + *ip;
+}
+
+static void orc_sort_swap(void *_a, void *_b, int size)
+{
+	struct orc_entry *orc_a, *orc_b;
+	struct orc_entry orc_tmp;
+	int *a = _a, *b = _b, tmp;
+	int delta = _b - _a;
+
+	/* Swap the .orc_unwind_ip entries: */
+	tmp = *a;
+	*a = *b + delta;
+	*b = tmp - delta;
+
+	/* Swap the corresponding .orc_unwind entries: */
+	orc_a = cur_orc_table + (a - cur_orc_ip_table);
+	orc_b = cur_orc_table + (b - cur_orc_ip_table);
+	orc_tmp = *orc_a;
+	*orc_a = *orc_b;
+	*orc_b = orc_tmp;
+}
+
+static int orc_sort_cmp(const void *_a, const void *_b)
+{
+	struct orc_entry *orc_a;
+	const int *a = _a, *b = _b;
+	unsigned long a_val = orc_ip(a);
+	unsigned long b_val = orc_ip(b);
+
+	if (a_val > b_val)
+		return 1;
+	if (a_val < b_val)
+		return -1;
+
+	/*
+	 * The "weak" section terminator entries need to always be on the left
+	 * to ensure the lookup code skips them in favor of real entries.
+	 * These terminator entries exist to handle any gaps created by
+	 * whitelisted .o files which didn't get objtool generation.
+	 */
+	orc_a = cur_orc_table + (a - cur_orc_ip_table);
+	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
+}
+
+static void sort_orc_table(unsigned long map)
+{
+	int num_entries = (__stop_orc_unwind_ip - __start_orc_unwind_ip) / sizeof(int);
+
+	cur_orc_ip_table = (int *)(__start_orc_unwind_ip + map);
+	cur_orc_table = (struct orc_entry *)(__start_orc_unwind + map);
+
+	debug_putstr("\nRe-sorting orc tables...\n");
+	sort(cur_orc_ip_table, num_entries, sizeof(int),
+		orc_sort_cmp, orc_sort_swap);
+}
+
+void post_relocations_cleanup(unsigned long map)
+{
+	if (!nofgkaslr) {
+		update_ex_table(map);
+		sort_ex_table(map);
+		sort_orc_table(map);
+	}
+
+	/*
+	 * maybe one day free will do something. So, we "free" this memory
+	 * in either case
+	 */
+	free(sections);
+	free(sechdrs);
+}
+
+void pre_relocations_cleanup(unsigned long map)
+{
+	if (nofgkaslr)
+		return;
+
+	sort_kallsyms(map);
+}
+
+static void shuffle_sections(int *list, int size)
+{
+	int i;
+	unsigned long j;
+	int temp;
+
+	for (i = size - 1; i > 0; i--) {
+		j = kaslr_get_random_long(NULL) % (i + 1);
+
+		temp = list[i];
+		list[i] = list[j];
+		list[j] = temp;
+	}
+}
+
+static void move_text(int num_sections, char *secstrings, Elf64_Shdr *text,
+			void *source, void *dest, Elf64_Phdr *phdr)
+{
+	unsigned long adjusted_addr;
+	int copy_bytes;
+	void *stash;
+	Elf64_Shdr **sorted_sections;
+	int *index_list;
+
+	memmove(dest, source + text->sh_offset, text->sh_size);
+	copy_bytes = text->sh_size;
+	dest += text->sh_size;
+	adjusted_addr = text->sh_addr + text->sh_size;
+
+	/*
+	 * we leave the sections sorted in their original order
+	 * by s->sh_addr, but shuffle the indexes in a random
+	 * order for copying.
+	 */
+	index_list = malloc(sizeof(int) * num_sections);
+	if (!index_list)
+		error("Failed to allocate space for index list");
+
+	for (int i = 0; i < num_sections; i++)
+		index_list[i] = i;
+
+	shuffle_sections(index_list, num_sections);
+
+	/*
+	 * to avoid overwriting earlier sections before they can get
+	 * copied to dest, stash everything into a buffer first.
+	 * this will cause our source address to be off by
+	 * phdr->p_offset though, so we'll adjust s->sh_offset below.
+	 *
+	 * TBD: ideally we'd simply decompress higher up so that our
+	 * copy wasn't in danger of overwriting anything important.
+	 */
+	stash = malloc(phdr->p_filesz);
+	if (!stash)
+		error("Failed to allocate space for text stash");
+
+	memcpy(stash, source + phdr->p_offset, phdr->p_filesz);
+
+	/* now we'd walk through the sections. */
+	for (int j = 0; j < num_sections; j++) {
+		unsigned long aligned_addr;
+		Elf64_Shdr *s;
+		const char *sname;
+		void *src;
+		int pad_bytes;
+
+		s = sections[index_list[j]];
+
+		sname = secstrings + s->sh_name;
+
+		/* align addr for this section */
+		aligned_addr = ALIGN(adjusted_addr, s->sh_addralign);
+
+		/*
+		 * copy out of stash, so adjust offset
+		 */
+		src = stash + s->sh_offset - phdr->p_offset;
+
+		/*
+		 * Fill any space between sections with int3
+		 */
+		pad_bytes = aligned_addr - adjusted_addr;
+		for (int i = 0; i < pad_bytes; i++)
+			((u8 *)dest)[i] = 0xcc;
+
+		dest = (void *) ALIGN((unsigned long)dest, s->sh_addralign);
+
+		memmove(dest, src, s->sh_size);
+
+		dest += s->sh_size;
+		copy_bytes += s->sh_size + pad_bytes;
+		adjusted_addr = aligned_addr + s->sh_size;
+
+		/* we can blow away sh_offset for our own uses */
+		s->sh_offset = aligned_addr - s->sh_addr;
+	}
+
+	free(index_list);
+
+	/*
+	 * move remainder of text segment. Ok to just use original source
+	 * here since this area is untouched.
+	 */
+	memmove(dest, source + text->sh_offset + copy_bytes,
+		phdr->p_filesz - copy_bytes);
+	free(stash);
+}
+
+#define GET_SYM(name) \
+	do { \
+		if (strcmp(#name, strtab + sym->st_name) == 0) {\
+			name = sym->st_value;			\
+			continue;				\
+		}						\
+	} while (0)
+
+static void parse_symtab(Elf64_Sym *symtab, char *strtab, long num_syms)
+{
+	Elf64_Sym *sym;
+
+	if (symtab == NULL || strtab == NULL)
+		return;
+
+	debug_putstr("\nLooking for symbols... ");
+
+	/*
+	 * walk through the symbol table looking for the symbols
+	 * that we care about.
+	 */
+	for (sym = symtab; --num_syms >= 0; sym++) {
+		if (!sym->st_name)
+			continue;
+
+		GET_SYM(kallsyms_num_syms);
+		GET_SYM(kallsyms_offsets);
+		GET_SYM(kallsyms_relative_base);
+		GET_SYM(kallsyms_names);
+		GET_SYM(kallsyms_markers);
+		GET_SYM(_stext);
+		GET_SYM(_etext);
+		GET_SYM(_sinittext);
+		GET_SYM(_einittext);
+		GET_SYM(__start_orc_unwind_ip);
+		GET_SYM(__stop_orc_unwind_ip);
+		GET_SYM(__start_orc_unwind);
+		GET_SYM(__stop_orc_unwind);
+
+		/* these have to be renamed */
+		if (strcmp("__start___ex_table", strtab + sym->st_name) == 0) {
+			 __start___ex_table_addr = sym->st_value;
+			continue;
+		}
+
+		if (strcmp("__stop___ex_table", strtab + sym->st_name) == 0) {
+			 __stop___ex_table_addr = sym->st_value;
+			continue;
+		}
+	}
+}
+
+void parse_sections_headers(void *output, Elf64_Ehdr *ehdr, Elf64_Phdr *phdrs)
+{
+	Elf64_Phdr *phdr;
+	Elf64_Shdr *s;
+	Elf64_Shdr *text = NULL;
+	Elf64_Shdr *percpu = NULL;
+	char *secstrings;
+	const char *sname;
+	int num_sections = 0;
+	Elf64_Sym *symtab = NULL;
+	char *strtab = NULL;
+	long num_syms = 0;
+	void *dest;
+	int i;
+	char arg[MAX_FGKASLR_ARG_LENGTH];
+	Elf64_Shdr shdr;
+	unsigned long shnum;
+	unsigned int shstrndx;
+
+	debug_putstr("\nParsing ELF section headers... ");
+
+	/*
+	 * Even though fgkaslr may have been disabled, we still
+	 * need to parse through the section headers to get the
+	 * start and end of the percpu section. This is because
+	 * if we were built with CONFIG_FG_KASLR, there are more
+	 * relative relocations present in vmlinux.relocs than
+	 * just the percpu, and only the percpu relocs need to be
+	 * adjusted when using just normal base address kaslr.
+	 */
+	if (cmdline_find_option("fgkaslr", arg, sizeof(arg)) == 3 &&
+		!strncmp(arg, "off", 3)) {
+		warn("FG_KASLR disabled on cmdline.");
+		nofgkaslr = 1;
+	}
+
+	/* read the first section header */
+	shnum = ehdr->e_shnum;
+	shstrndx = ehdr->e_shstrndx;
+	if (shnum == SHN_UNDEF || shstrndx == SHN_XINDEX) {
+		memcpy(&shdr, output + ehdr->e_shoff, sizeof(shdr));
+		if (shnum == SHN_UNDEF)
+			shnum = shdr.sh_size;
+		if (shstrndx == SHN_XINDEX)
+			shstrndx = shdr.sh_link;
+	}
+
+	/* we are going to need to allocate space for the section headers */
+	sechdrs = malloc(sizeof(*sechdrs) * shnum);
+	if (!sechdrs)
+		error("Failed to allocate space for shdrs");
+
+	sections = malloc(sizeof(*sections) * shnum);
+	if (!sections)
+		error("Failed to allocate space for section pointers");
+
+	memcpy(sechdrs, output + ehdr->e_shoff,
+		sizeof(*sechdrs) * shnum);
+
+	/* we need to allocate space for the section string table */
+	s = &sechdrs[shstrndx];
+
+	secstrings = malloc(s->sh_size);
+	if (!secstrings)
+		error("Failed to allocate space for shstr");
+
+	memcpy(secstrings, output + s->sh_offset, s->sh_size);
+
+	/*
+	 * now we need to walk through the section headers and collect the
+	 * sizes of the .text sections to be randomized.
+	 */
+	for (i = 0; i < shnum; i++) {
+		s = &sechdrs[i];
+		sname = secstrings + s->sh_name;
+
+		if (s->sh_type == SHT_SYMTAB) {
+			/* only one symtab per image */
+			symtab = malloc(s->sh_size);
+			if (!symtab)
+				error("Failed to allocate space for symtab");
+
+			memcpy(symtab, output + s->sh_offset, s->sh_size);
+			num_syms = s->sh_size/sizeof(*symtab);
+			continue;
+		}
+
+		if (s->sh_type == SHT_STRTAB && (i != ehdr->e_shstrndx)) {
+			strtab = malloc(s->sh_size);
+			if (!strtab)
+				error("Failed to allocate space for strtab");
+
+			memcpy(strtab, output + s->sh_offset, s->sh_size);
+		}
+
+		if (!strcmp(sname, ".text")) {
+			text = s;
+			continue;
+		}
+
+		if (!strcmp(sname, ".data..percpu")) {
+			/* get start addr for later */
+			percpu = s;
+		}
+
+		if (!(s->sh_flags & SHF_ALLOC) ||
+		    !(s->sh_flags & SHF_EXECINSTR) ||
+		    !(strstarts(sname, ".text")))
+			continue;
+
+		sections[num_sections] = s;
+
+		num_sections++;
+	}
+	sections[num_sections] = NULL;
+	sections_size = num_sections;
+
+	parse_symtab(symtab, strtab, num_syms);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		switch (phdr->p_type) {
+		case PT_LOAD:
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+			dest = output;
+			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
+			if (!nofgkaslr &&
+			    (text && (phdr->p_offset == text->sh_offset))) {
+				move_text(num_sections, secstrings, text,
+					  output, dest, phdr);
+			} else {
+				if (percpu &&
+				    (phdr->p_offset == percpu->sh_offset)) {
+					percpu_start = percpu->sh_addr;
+					percpu_end = percpu_start +
+							phdr->p_filesz;
+				}
+				memmove(dest, output + phdr->p_offset,
+					phdr->p_filesz);
+			}
+			break;
+		default: /* Ignore other PT_* */
+			break;
+		}
+	}
+
+	/* we need to keep the section info to redo relocs */
+	free(secstrings);
+
+	free(phdrs);
+}
+
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..07ef5d2ea49a 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -39,10 +39,6 @@
 #include <generated/utsrelease.h>
 #include <asm/efi.h>
 
-/* Macros used by the included decompressor code below. */
-#define STATIC
-#include <linux/decompress/mm.h>
-
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled;
 unsigned int pgdir_shift __ro_after_init = 39;
@@ -897,7 +893,8 @@ void choose_random_location(unsigned long input,
 {
 	unsigned long random_addr, min_addr;
 
-	if (cmdline_find_option_bool("nokaslr")) {
+	nokaslr = cmdline_find_option_bool("nokaslr");
+	if (nokaslr) {
 		warn("KASLR disabled: 'nokaslr' on cmdline.");
 		return;
 	}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 9652d5c2afda..2e108fdc7757 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -26,9 +26,6 @@
  * it is not safe to place pointers in static structures.
  */
 
-/* Macros used by the included decompressor code below. */
-#define STATIC		static
-
 /*
  * Use normal definitions of mem*() from string.c. There are already
  * included header files which expect a definition of memset() and by
@@ -49,6 +46,8 @@ struct boot_params *boot_params;
 
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
+unsigned long malloc_ptr;
+int malloc_count;
 
 static char *vidmem;
 static int vidport;
@@ -203,10 +202,20 @@ static void handle_relocations(void *output, unsigned long output_len,
 	if (IS_ENABLED(CONFIG_X86_64))
 		delta = virt_addr - LOAD_PHYSICAL_ADDR;
 
-	if (!delta) {
-		debug_putstr("No relocation needed... ");
-		return;
+	/*
+	 * it is possible to have delta be zero and
+	 * still have enabled fg kaslr. We need to perform relocations
+	 * for fgkaslr regardless of whether the base address has moved.
+	 */
+	if (!IS_ENABLED(CONFIG_FG_KASLR) || nokaslr) {
+		if (!delta) {
+			debug_putstr("No relocation needed... ");
+			return;
+		}
 	}
+
+	pre_relocations_cleanup(map);
+
 	debug_putstr("Performing relocations... ");
 
 	/*
@@ -230,35 +239,106 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 */
 	for (reloc = output + output_len - sizeof(*reloc); *reloc; reloc--) {
 		long extended = *reloc;
+		long value;
+
+		/*
+		 * if using fgkaslr, we might have moved the address
+		 * of the relocation. Check it to see if it needs adjusting
+		 * from the original address.
+		 */
+		(void) adjust_address(&extended);
+
 		extended += map;
 
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("32-bit relocation outside of kernel!\n");
 
-		*(uint32_t *)ptr += delta;
+		value = *(int32_t *)ptr;
+
+		/*
+		 * If using fgkaslr, the value of the relocation
+		 * might need to be changed because it referred
+		 * to an address that has moved.
+		 */
+		adjust_address(&value);
+
+		value += delta;
+
+		*(uint32_t *)ptr = value;
 	}
 #ifdef CONFIG_X86_64
 	while (*--reloc) {
 		long extended = *reloc;
+		long value;
+		long oldvalue;
+		Elf64_Shdr *s;
+
+		/*
+		 * if using fgkaslr, we might have moved the address
+		 * of the relocation. Check it to see if it needs adjusting
+		 * from the original address.
+		 */
+		s = adjust_address(&extended);
+
 		extended += map;
 
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("inverse 32-bit relocation outside of kernel!\n");
 
-		*(int32_t *)ptr -= delta;
+		value = *(int32_t *)ptr;
+		oldvalue = value;
+
+		/*
+		 * If using fgkaslr, these relocs will contain
+		 * relative offsets which might need to be
+		 * changed because it referred
+		 * to an address that has moved.
+		 */
+		adjust_relative_offset(*reloc, &value, s);
+
+		/*
+		 * only percpu symbols need to have their values adjusted for
+		 * base address kaslr since relative offsets within the .text
+		 * and .text.* sections are ok wrt each other.
+		 */
+		if (is_percpu_addr(*reloc, oldvalue))
+			value -= delta;
+
+		*(int32_t *)ptr = value;
 	}
 	for (reloc--; *reloc; reloc--) {
 		long extended = *reloc;
+		long value;
+
+		/*
+		 * if using fgkaslr, we might have moved the address
+		 * of the relocation. Check it to see if it needs adjusting
+		 * from the original address.
+		 */
+		(void) adjust_address(&extended);
+
 		extended += map;
 
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("64-bit relocation outside of kernel!\n");
 
-		*(uint64_t *)ptr += delta;
+		value = *(int64_t *)ptr;
+
+		/*
+		 * If using fgkaslr, the value of the relocation
+		 * might need to be changed because it referred
+		 * to an address that has moved.
+		 */
+		(void) adjust_address(&value);
+
+		value += delta;
+
+		*(uint64_t *)ptr = value;
 	}
+	post_relocations_cleanup(map);
 #endif
 }
 #else
@@ -296,6 +376,15 @@ static void parse_elf(void *output)
 
 	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
 
+	if (IS_ENABLED(CONFIG_FG_KASLR)) {
+		if (!nokaslr) {
+			parse_sections_headers(output, &ehdr, phdrs);
+			return;
+		} else {
+			warn("FG_KASLR disabled: 'nokaslr' on cmdline.");
+		}
+	}
+
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		phdr = &phdrs[i];
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..f68f7fc39543 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -39,7 +39,12 @@
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+#define STATIC
+#define STATIC_RW_DATA extern
+#include <linux/decompress/mm.h>
+
 extern struct boot_params *boot_params;
+extern int nokaslr;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
@@ -74,6 +79,32 @@ struct mem_vector {
 	unsigned long long size;
 };
 
+#ifdef CONFIG_X86_64
+#define Elf_Ehdr Elf64_Ehdr
+#define Elf_Phdr Elf64_Phdr
+#define Elf_Shdr Elf64_Shdr
+#else
+#define Elf_Ehdr Elf32_Ehdr
+#define Elf_Phdr Elf32_Phdr
+#define Elf_Shdr Elf32_Shdr
+#endif
+
+#if CONFIG_FG_KASLR
+void parse_sections_headers(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs);
+void pre_relocations_cleanup(unsigned long map);
+void post_relocations_cleanup(unsigned long map);
+Elf_Shdr *adjust_address(long *address);
+void adjust_relative_offset(long pc, long *value, Elf_Shdr *section);
+bool is_percpu_addr(long pc, long offset);
+#else
+static inline void parse_sections_headers(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs) { }
+static inline void pre_relocations_cleanup(unsigned long map) { }
+static inline void post_relocations_cleanup(unsigned long map) { }
+static inline Elf_Shdr *adjust_address(long *address) { return NULL; }
+static inline void adjust_relative_offset(long pc, long *value, Elf_Shdr *section) { }
+static inline bool is_percpu_addr(long pc, long offset) { return true; }
+#endif /* CONFIG_FG_KASLR */
+
 #if CONFIG_RANDOMIZE_BASE
 /* kaslr.c */
 void choose_random_location(unsigned long input,
diff --git a/arch/x86/boot/compressed/utils.c b/arch/x86/boot/compressed/utils.c
new file mode 100644
index 000000000000..ceefc58d7c71
--- /dev/null
+++ b/arch/x86/boot/compressed/utils.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * utils.c
+ *
+ * This contains various libraries that are needed for fgkaslr
+ */
+#define __DISABLE_EXPORTS
+#define _LINUX_KPROBES_H
+#define NOKPROBE_SYMBOL(fname)
+#include "../../../../lib/sort.c"
+#include "../../../../lib/bsearch.c"
+
diff --git a/arch/x86/boot/compressed/vmlinux.symbols b/arch/x86/boot/compressed/vmlinux.symbols
new file mode 100644
index 000000000000..f48a4c396966
--- /dev/null
+++ b/arch/x86/boot/compressed/vmlinux.symbols
@@ -0,0 +1,18 @@
+kallsyms_offsets
+kallsyms_addresses
+kallsyms_num_syms
+kallsyms_relative_base
+kallsyms_names
+kallsyms_token_table
+kallsyms_token_index
+kallsyms_markers
+__start___ex_table
+__stop___ex_table
+_sinittext
+_einittext
+_stext
+_etext
+__start_orc_unwind_ip
+__stop_orc_unwind_ip
+__stop_orc_unwind
+__start_orc_unwind
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 680c320363db..6918d33eb5ef 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -26,8 +26,19 @@
 
 #ifdef CONFIG_KERNEL_BZIP2
 # define BOOT_HEAP_SIZE		0x400000
-#else /* !CONFIG_KERNEL_BZIP2 */
-# define BOOT_HEAP_SIZE		 0x10000
+#elif CONFIG_FG_KASLR
+/*
+ * We need extra boot heap when using fgkaslr because we make a copy
+ * of the original decompressed kernel to avoid issues with writing
+ * over ourselves when shuffling the sections. We also need extra
+ * space for resorting kallsyms after shuffling. This value could
+ * be decreased if free() would release memory properly, or if we
+ * could avoid the kernel copy. It would need to be increased if we
+ * find additional tables that need to be resorted.
+ */
+# define BOOT_HEAP_SIZE		0x4000000
+#else /* !CONFIG_KERNEL_BZIP2 && !CONFIG_FG_KASLR */
+# define BOOT_HEAP_SIZE		0x10000
 #endif
 
 #ifdef CONFIG_X86_64
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4290fe..a85d1792d5a8 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -298,6 +298,7 @@ typedef struct elf64_phdr {
 #define SHN_LIVEPATCH	0xff20
 #define SHN_ABS		0xfff1
 #define SHN_COMMON	0xfff2
+#define SHN_XINDEX	0xffff
 #define SHN_HIRESERVE	0xffff
  
 typedef struct elf32_shdr {
-- 
2.20.1

