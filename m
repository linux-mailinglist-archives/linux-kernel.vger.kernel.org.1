Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F091DD380
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgEUQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:57:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:46206 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbgEUQ5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:57:11 -0400
IronPort-SDR: kjF61sP2qM8ZuLUGmRs4D8KNmS8vNci+g5JUDB9rUIRjgnQ0bK9zikt8LQHrHXefYQdgMORqa0
 Cp/XNYGIY9lA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:57:10 -0700
IronPort-SDR: TeipsK/N9HFpFReQGpALhDkmQ7gbrf5yJhKh+2sZ8PgWZ6NiphMk8urCwhS9X04rZD18VqS5Cs
 cQRRsz8zTzQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="309094697"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2020 09:57:08 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 2/9] x86: tools/relocs: Support >64K section headers
Date:   Thu, 21 May 2020 09:56:33 -0700
Message-Id: <20200521165641.15940-3-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521165641.15940-1-kristen@linux.intel.com>
References: <20200521165641.15940-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the relocs tool already supports finding the total number
of section headers if vmlinux exceeds 64K sections, it fails to
read the extended symbol table to get section header indexes for symbols,
causing incorrect symbol table indexes to be used when there are > 64K
symbols.

Parse the elf file to read the extended symbol table info, and then
replace all direct references to st_shndx with calls to sym_index(),
which will determine whether the value can be read directly or
whether the value should be pulled out of the extended table.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/tools/relocs.c | 104 ++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..a00dc133f109 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -14,6 +14,10 @@
 static Elf_Ehdr		ehdr;
 static unsigned long	shnum;
 static unsigned int	shstrndx;
+static unsigned int	shsymtabndx;
+static unsigned int	shxsymtabndx;
+
+static int sym_index(Elf_Sym *sym);
 
 struct relocs {
 	uint32_t	*offset;
@@ -32,6 +36,7 @@ struct section {
 	Elf_Shdr       shdr;
 	struct section *link;
 	Elf_Sym        *symtab;
+	Elf32_Word     *xsymtab;
 	Elf_Rel        *reltab;
 	char           *strtab;
 };
@@ -265,7 +270,7 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 		name = sym_strtab + sym->st_name;
 	}
 	else {
-		name = sec_name(sym->st_shndx);
+		name = sec_name(sym_index(sym));
 	}
 	return name;
 }
@@ -335,6 +340,23 @@ static uint64_t elf64_to_cpu(uint64_t val)
 #define elf_xword_to_cpu(x)	elf32_to_cpu(x)
 #endif
 
+static int sym_index(Elf_Sym *sym)
+{
+	Elf_Sym *symtab = secs[shsymtabndx].symtab;
+	Elf32_Word *xsymtab = secs[shxsymtabndx].xsymtab;
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return sym->st_shndx;
+
+	/* calculate offset of sym from head of table. */
+	offset = (unsigned long) sym - (unsigned long) symtab;
+	index = offset/sizeof(*sym);
+
+	return elf32_to_cpu(xsymtab[index]);
+}
+
 static void read_ehdr(FILE *fp)
 {
 	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
@@ -468,31 +490,60 @@ static void read_strtabs(FILE *fp)
 static void read_symtabs(FILE *fp)
 {
 	int i,j;
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
-		if (sec->shdr.sh_type != SHT_SYMTAB) {
+		int num_syms;
+
+		switch (sec->shdr.sh_type) {
+		case SHT_SYMTAB_SHNDX:
+			sec->xsymtab = malloc(sec->shdr.sh_size);
+			if (!sec->xsymtab) {
+				die("malloc of %d bytes for xsymtab failed\n",
+					sec->shdr.sh_size);
+			}
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+				die("Seek to %d failed: %s\n",
+					sec->shdr.sh_offset, strerror(errno));
+			}
+			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp)
+					!= sec->shdr.sh_size) {
+				die("Cannot read extended symbol table: %s\n",
+					strerror(errno));
+			}
+			shxsymtabndx = i;
+			continue;
+
+		case SHT_SYMTAB:
+			num_syms = sec->shdr.sh_size/sizeof(Elf_Sym);
+
+			sec->symtab = malloc(sec->shdr.sh_size);
+			if (!sec->symtab) {
+				die("malloc of %d bytes for symtab failed\n",
+					sec->shdr.sh_size);
+			}
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+				die("Seek to %d failed: %s\n",
+					sec->shdr.sh_offset, strerror(errno));
+			}
+			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
+					!= sec->shdr.sh_size) {
+				die("Cannot read symbol table: %s\n",
+					strerror(errno));
+			}
+			for (j = 0; j < num_syms; j++) {
+				Elf_Sym *sym = &sec->symtab[j];
+
+				sym->st_name  = elf_word_to_cpu(sym->st_name);
+				sym->st_value = elf_addr_to_cpu(sym->st_value);
+				sym->st_size  = elf_xword_to_cpu(sym->st_size);
+				sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
+			}
+			shsymtabndx = i;
+			continue;
+
+		default:
 			continue;
-		}
-		sec->symtab = malloc(sec->shdr.sh_size);
-		if (!sec->symtab) {
-			die("malloc of %d bytes for symtab failed\n",
-				sec->shdr.sh_size);
-		}
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
-		}
-		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
-		    != sec->shdr.sh_size) {
-			die("Cannot read symbol table: %s\n",
-				strerror(errno));
-		}
-		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Sym); j++) {
-			Elf_Sym *sym = &sec->symtab[j];
-			sym->st_name  = elf_word_to_cpu(sym->st_name);
-			sym->st_value = elf_addr_to_cpu(sym->st_value);
-			sym->st_size  = elf_xword_to_cpu(sym->st_size);
-			sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
 		}
 	}
 }
@@ -759,13 +810,14 @@ static void percpu_init(void)
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
-	return (sym->st_shndx == per_cpu_shndx) &&
+	int shndx = sym_index(sym);
+
+	return (shndx == per_cpu_shndx) &&
 		strcmp(symname, "__init_begin") &&
 		strcmp(symname, "__per_cpu_load") &&
 		strncmp(symname, "init_per_cpu_", 13);
 }
 
-
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
@@ -1088,7 +1140,7 @@ static int do_reloc_info(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		sec_name(sec->shdr.sh_info),
 		rel_type(ELF_R_TYPE(rel->r_info)),
 		symname,
-		sec_name(sym->st_shndx));
+		sec_name(sym_index(sym)));
 	return 0;
 }
 
-- 
2.20.1

