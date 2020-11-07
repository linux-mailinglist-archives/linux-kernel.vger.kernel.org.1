Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7215D2AA78D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgKGTLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:11:02 -0500
Received: from mxout04.lancloud.ru ([89.108.124.63]:48192 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGTLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:11:01 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 425A02153BEE
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] module: fix comment style
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <5d621031-43d3-fef5-efbf-9ddddc10f833@omprussia.ru>
Date:   Sat, 7 Nov 2020 22:10:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.144.8]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many comments in this module do not comply with the preferred multi-line
comment style as reported by 'scripts/checkpatch.pl':

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Fix those comments, along with (unreported for some reason?) the starts
of the multi-line comments not being /* on their own line... 

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
This patch is against the 'modules-next' branch of Jessica Yu's 'linux.git'
repo plus my 2 patches posted this week.
I'm not sure such patches are welcome, please let me know if they're not...

 kernel/module.c |  114 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 42 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-   Copyright (C) 2002 Richard Henderson
-   Copyright (C) 2001 Rusty Russell, 2002, 2010 Rusty Russell IBM.
-
-*/
+ * Copyright (C) 2002 Richard Henderson
+ * Copyright (C) 2001 Rusty Russell, 2002, 2010 Rusty Russell IBM.
+ */
 
 #define INCLUDE_VERMAGIC
 
@@ -86,7 +85,8 @@
  * 1) List of modules (also safely readable with preempt_disable),
  * 2) module_use links,
  * 3) module_addr_min/module_addr_max.
- * (delete and add uses RCU list operations). */
+ * (delete and add uses RCU list operations).
+ */
 DEFINE_MUTEX(module_mutex);
 EXPORT_SYMBOL_GPL(module_mutex);
 static LIST_HEAD(modules);
@@ -587,7 +587,8 @@ static bool find_exported_symbol_in_sect
 }
 
 /* Find an exported symbol and return it, along with, (optional) crc and
- * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
+ * (optional) module which owns it.  Needs preempt disabled or module_mutex.
+ */
 static const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
 					const s32 **crc,
@@ -1644,8 +1645,10 @@ static void remove_sect_attrs(struct mod
 	if (mod->sect_attrs) {
 		sysfs_remove_group(&mod->mkobj.kobj,
 				   &mod->sect_attrs->grp);
-		/* We are positive that no one is using any sect attrs
-		 * at this point.  Deallocate immediately. */
+		/*
+		 * We are positive that no one is using any sect attrs
+		 * at this point.  Deallocate immediately.
+		 */
 		free_sect_attrs(mod->sect_attrs);
 		mod->sect_attrs = NULL;
 	}
@@ -2216,8 +2219,10 @@ static void free_module(struct module *m
 
 	mod_sysfs_teardown(mod);
 
-	/* We leave it in list to prevent duplicate loads, but make sure
-	 * that noone uses it while it's being deconstructed. */
+	/*
+	 * We leave it in list to prevent duplicate loads, but make sure
+	 * that noone uses it while it's being deconstructed.
+	 */
 	mutex_lock(&module_mutex);
 	mod->state = MODULE_STATE_UNFORMED;
 	mutex_unlock(&module_mutex);
@@ -2334,8 +2339,10 @@ static int simplify_symbols(struct modul
 			if (!strncmp(name, "__gnu_lto", 9))
 				break;
 
-			/* We compiled with -fno-common.  These are not
-			   supposed to happen.  */
+			/*
+			 * We compiled with -fno-common.  These are not
+			 * supposed to happen.
+			 */
 			pr_debug("Common symbol: %s\n", name);
 			pr_warn("%s: please compile with -fno-common\n",
 			       mod->name);
@@ -2438,16 +2445,20 @@ static long get_offset(struct module *mo
 	return ret;
 }
 
-/* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
-   might -- code, read-only data, read-write data, small data.  Tally
-   sizes, and place the offsets into sh_entsize fields: high bit means it
-   belongs in init. */
+/*
+ * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
+ * might -- code, read-only data, read-write data, small data.  Tally
+ * sizes, and place the offsets into sh_entsize fields: high bit means it
+ * belongs in init.
+ */
 static void layout_sections(struct module *mod, struct load_info *info)
 {
 	static unsigned long const masks[][2] = {
-		/* NOTE: all executable code must be the first section
+		/*
+		 * NOTE: all executable code must be the first section
 		 * in this array; otherwise modify the text_size
-		 * finder in the two loops below */
+		 * finder in the two loops below
+		 */
 		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ SHF_ALLOC, SHF_WRITE | ARCH_SHF_SMALL },
 		{ SHF_RO_AFTER_INIT | SHF_ALLOC, ARCH_SHF_SMALL },
@@ -3062,8 +3073,10 @@ static int rewrite_section_headers(struc
 			return -ENOEXEC;
 		}
 
-		/* Mark all sections sh_addr with their address in the
-		   temporary image. */
+		/*
+		 * Mark all sections sh_addr with their address in the
+		 * temporary image.
+		 */
 		shdr->sh_addr = (size_t)info->hdr + shdr->sh_offset;
 
 #ifndef CONFIG_MODULE_UNLOAD
@@ -3494,9 +3507,11 @@ static struct module *layout_and_allocat
 	if (ndx)
 		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
 
-	/* Determine total sizes, and put offsets in sh_entsize.  For now
-	   this is done generically; there doesn't appear to be any
-	   special cases for the architectures. */
+	/*
+	 * Determine total sizes, and put offsets in sh_entsize.  For now
+	 * this is done generically; there doesn't appear to be any
+	 * special cases for the architectures.
+	 */
 	layout_sections(info->mod, info);
 	layout_symtab(info->mod, info);
 
@@ -3780,8 +3795,10 @@ static int complete_formation(struct mod
 	module_enable_nx(mod);
 	module_enable_x(mod);
 
-	/* Mark state as coming so strong_try_module_get() ignores us,
-	 * but kallsyms etc. can see us. */
+	/*
+	 * Mark state as coming so strong_try_module_get() ignores us,
+	 * but kallsyms etc. can see us.
+	 */
 	mod->state = MODULE_STATE_COMING;
 	mutex_unlock(&module_mutex);
 
@@ -3828,8 +3845,10 @@ static int unknown_module_param_cb(char
 	return 0;
 }
 
-/* Allocate and load the module: note that size of section 0 is always
-   zero, and we rely on this for optional sections. */
+/*
+ * Allocate and load the module: note that size of section 0 is always
+ * zero, and we rely on this for optional sections.
+ */
 static int load_module(struct load_info *info, const char __user *uargs,
 		       int flags)
 {
@@ -3903,8 +3922,10 @@ static int load_module(struct load_info
 
 	init_param_lock(mod);
 
-	/* Now we've got everything in the final locations, we can
-	 * find optional sections. */
+	/*
+	 * Now we've got everything in the final locations, we can
+	 * find optional sections.
+	 */
 	err = find_module_sections(mod, info);
 	if (err)
 		goto free_unload;
@@ -4118,8 +4139,10 @@ static const char *find_kallsyms_symbol(
 
 	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
 
-	/* Scan for closest preceding symbol, and next symbol. (ELF
-	   starts real symbols at 1). */
+	/*
+	 * Scan for closest preceding symbol, and next symbol. (ELF
+	 * starts real symbols at 1).
+	 */
 	for (i = 1; i < kallsyms->num_symtab; i++) {
 		const Elf_Sym *sym = &kallsyms->symtab[i];
 		unsigned long thisval = kallsyms_symbol_value(sym);
@@ -4127,8 +4150,10 @@ static const char *find_kallsyms_symbol(
 		if (sym->st_shndx == SHN_UNDEF)
 			continue;
 
-		/* We ignore unnamed symbols: they're uninformative
-		 * and inserted at a whim. */
+		/*
+		 * We ignore unnamed symbols: they're uninformative
+		 * and inserted at a whim.
+		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0'
 		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
@@ -4158,8 +4183,10 @@ void * __weak dereference_module_functio
 	return ptr;
 }
 
-/* For kallsyms to ask for address resolution.  NULL means not found.  Careful
- * not to lock to avoid deadlock on oopses, simply disable preemption. */
+/*
+ * For kallsyms to ask for address resolution.  NULL means not found.  Careful
+ * not to lock to avoid deadlock on oopses, simply disable preemption.
+ */
 const char *module_address_lookup(unsigned long addr,
 			    unsigned long *size,
 			    unsigned long *offset,
@@ -4417,11 +4444,12 @@ static int m_show(struct seq_file *m, vo
 	return 0;
 }
 
-/* Format: modulename size refcount deps address
-
-   Where refcount is a number or -, and deps is a comma-separated list
-   of depends or -.
-*/
+/*
+ * Format: modulename size refcount deps address
+ *
+ * Where refcount is a number or -, and deps is a comma-separated list
+ * of depends or -.
+ */
 static const struct seq_operations modules_op = {
 	.start	= m_start,
 	.next	= m_next,
@@ -4593,8 +4621,10 @@ void print_modules(void)
 }
 
 #ifdef CONFIG_MODVERSIONS
-/* Generate the signature for all relevant module structures here.
- * If these change, we don't want to try to parse the module. */
+/*
+ * Generate the signature for all relevant module structures here.
+ * If these change, we don't want to try to parse the module.
+ */
 void module_layout(struct module *mod,
 		   struct modversion_info *ver,
 		   struct kernel_param *kp,
