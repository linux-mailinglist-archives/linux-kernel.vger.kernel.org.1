Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE841DD385
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgEUQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:57:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:46221 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbgEUQ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:57:23 -0400
IronPort-SDR: ehHRPUeZaZL8/NJ8Q/kHzkRZpV6nGOOwqYjKbMrGOPaHkV+846CqKgAmrCtLxJpcvsu+DCe2RW
 mYPLJJe94eog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:57:23 -0700
IronPort-SDR: njCmB4gTQK2dXMgbbspYYmVit8ug7SUj50qxN2fydRgyxBuD1iCtuub5OK15JFfabU7bfQ1djv
 BPXbA74Drzfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="309094746"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2020 09:57:21 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 6/9] x86/tools: Add relative relocs for randomized functions
Date:   Thu, 21 May 2020 09:56:37 -0700
Message-Id: <20200521165641.15940-7-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521165641.15940-1-kristen@linux.intel.com>
References: <20200521165641.15940-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reordering functions, the relative offsets for relocs that
are either in the randomized sections, or refer to the randomized
sections will need to be adjusted. Add code to detect whether a
reloc satisifies these cases, and if so, add them to the appropriate
reloc list.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/boot/compressed/Makefile |  7 +++-
 arch/x86/tools/relocs.c           | 55 ++++++++++++++++++++++++-------
 arch/x86/tools/relocs.h           |  4 +--
 arch/x86/tools/relocs_common.c    | 15 ++++++---
 4 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5f7c262bcc99..3a5a004498de 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -117,6 +117,11 @@ $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
+
+ifdef CONFIG_FG_KASLR
+	RELOCS_ARGS += --fg-kaslr
+endif
+
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
@@ -124,7 +129,7 @@ targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relo
 
 CMD_RELOCS = arch/x86/tools/relocs
 quiet_cmd_relocs = RELOCS  $@
-      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
+      cmd_relocs = $(CMD_RELOCS) $(RELOCS_ARGS) $< > $@;$(CMD_RELOCS) $(RELOCS_ARGS) --abs-relocs $<
 $(obj)/vmlinux.relocs: vmlinux FORCE
 	$(call if_changed,relocs)
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index a00dc133f109..bf51ff1854ff 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -42,6 +42,8 @@ struct section {
 };
 static struct section *secs;
 
+static int fg_kaslr;
+
 static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 /*
  * Following symbols have been audited. There values are constant and do
@@ -351,8 +353,8 @@ static int sym_index(Elf_Sym *sym)
 		return sym->st_shndx;
 
 	/* calculate offset of sym from head of table. */
-	offset = (unsigned long) sym - (unsigned long) symtab;
-	index = offset/sizeof(*sym);
+	offset = (unsigned long)sym - (unsigned long)symtab;
+	index = offset / sizeof(*sym);
 
 	return elf32_to_cpu(xsymtab[index]);
 }
@@ -500,22 +502,22 @@ static void read_symtabs(FILE *fp)
 			sec->xsymtab = malloc(sec->shdr.sh_size);
 			if (!sec->xsymtab) {
 				die("malloc of %d bytes for xsymtab failed\n",
-					sec->shdr.sh_size);
+				    sec->shdr.sh_size);
 			}
 			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
 				die("Seek to %d failed: %s\n",
-					sec->shdr.sh_offset, strerror(errno));
+				    sec->shdr.sh_offset, strerror(errno));
 			}
 			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp)
-					!= sec->shdr.sh_size) {
+			    != sec->shdr.sh_size) {
 				die("Cannot read extended symbol table: %s\n",
-					strerror(errno));
+				    strerror(errno));
 			}
 			shxsymtabndx = i;
 			continue;
 
 		case SHT_SYMTAB:
-			num_syms = sec->shdr.sh_size/sizeof(Elf_Sym);
+			num_syms = sec->shdr.sh_size / sizeof(Elf_Sym);
 
 			sec->symtab = malloc(sec->shdr.sh_size);
 			if (!sec->symtab) {
@@ -818,6 +820,32 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 		strncmp(symname, "init_per_cpu_", 13);
 }
 
+static int is_function_section(struct section *sec)
+{
+	const char *name;
+
+	if (!fg_kaslr)
+		return 0;
+
+	name = sec_name(sec->shdr.sh_info);
+
+	return(!strncmp(name, ".text.", 6));
+}
+
+static int is_randomized_sym(ElfW(Sym) *sym)
+{
+	const char *name;
+
+	if (!fg_kaslr)
+		return 0;
+
+	if (sym->st_shndx > shnum)
+		return 0;
+
+	name = sec_name(sym_index(sym));
+	return(!strncmp(name, ".text.", 6));
+}
+
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
@@ -842,13 +870,17 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
 		/*
-		 * PC relative relocations don't need to be adjusted unless
-		 * referencing a percpu symbol.
+		 * we need to keep pc relative relocations for sections which
+		 * might be randomized, and for the percpu section.
+		 * We also need to keep relocations for any offset which might
+		 * reference an address in a section which has been randomized.
 		 *
 		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
 		 */
-		if (is_percpu_sym(sym, symname))
+		if (is_function_section(sec) || is_randomized_sym(sym) ||
+		    is_percpu_sym(sym, symname))
 			add_reloc(&relocs32neg, offset);
+
 		break;
 
 	case R_X86_64_PC64:
@@ -1158,8 +1190,9 @@ static void print_reloc_info(void)
 
 void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
-	     int show_reloc_info)
+	     int show_reloc_info, int fgkaslr)
 {
+	fg_kaslr = fgkaslr;
 	regex_init(use_real_mode);
 	read_ehdr(fp);
 	read_shdrs(fp);
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 43c83c0fd22c..05504052c846 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -31,8 +31,8 @@ enum symtype {
 
 void process_32(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int fg_kaslr);
 void process_64(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int fg_kaslr);
 #endif /* RELOCS_H */
diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
index 6634352a20bc..1407db72367a 100644
--- a/arch/x86/tools/relocs_common.c
+++ b/arch/x86/tools/relocs_common.c
@@ -12,14 +12,14 @@ void die(char *fmt, ...)
 
 static void usage(void)
 {
-	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode]" \
-	    " vmlinux\n");
+	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode|" \
+	    "--fg-kaslr] vmlinux\n");
 }
 
 int main(int argc, char **argv)
 {
 	int show_absolute_syms, show_absolute_relocs, show_reloc_info;
-	int as_text, use_real_mode;
+	int as_text, use_real_mode, fg_kaslr;
 	const char *fname;
 	FILE *fp;
 	int i;
@@ -30,6 +30,7 @@ int main(int argc, char **argv)
 	show_reloc_info = 0;
 	as_text = 0;
 	use_real_mode = 0;
+	fg_kaslr = 0;
 	fname = NULL;
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -54,6 +55,10 @@ int main(int argc, char **argv)
 				use_real_mode = 1;
 				continue;
 			}
+			if (strcmp(arg, "--fg-kaslr") == 0) {
+				fg_kaslr = 1;
+				continue;
+			}
 		}
 		else if (!fname) {
 			fname = arg;
@@ -75,11 +80,11 @@ int main(int argc, char **argv)
 	if (e_ident[EI_CLASS] == ELFCLASS64)
 		process_64(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, fg_kaslr);
 	else
 		process_32(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, fg_kaslr);
 	fclose(fp);
 	return 0;
 }
-- 
2.20.1

