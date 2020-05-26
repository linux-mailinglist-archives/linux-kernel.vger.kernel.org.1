Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274E01DD38B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgEUQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:57:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:28574 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgEUQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:57:36 -0400
IronPort-SDR: +0H7XkbcLp2BpjAtSllhGNpGfv2xCpb2VXGYvqwAgtip8DXHY8cvkLuyd/i6/r/JyyHmtBExk+
 epLTjYp/iIyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:57:36 -0700
IronPort-SDR: P6wEIu2SJuHDHQwXasz9m0NGvmkDLrrsa3c9q3cdsZubQS+kjPmQIawnk21iMKnMaiJT4kinct
 gDO85ZACgdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="309094841"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2020 09:57:34 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 9/9] module: Reorder functions
Date:   Thu, 21 May 2020 09:56:40 -0700
Message-Id: <20200521165641.15940-10-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521165641.15940-1-kristen@linux.intel.com>
References: <20200521165641.15940-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new config option to allow modules to be re-ordered
by function. This option can be enabled independently of the
kernel text KASLR or FG_KASLR settings so that it can be used
by architectures that do not support either of these features.
This option will be selected by default if CONFIG_FG_KASLR is
selected.

If a module has functions split out into separate text sections
(i.e. compiled with the -ffunction-sections flag), reorder the
functions to provide some code diversification to modules.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/Kconfig  |  1 +
 arch/x86/Makefile |  3 ++
 init/Kconfig      | 11 +++++++
 kernel/module.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 50e83ea57d70..d0bdd5c8c432 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2187,6 +2187,7 @@ config FG_KASLR
 	bool "Function Granular Kernel Address Space Layout Randomization"
 	depends on $(cc-option, -ffunction-sections)
 	depends on RANDOMIZE_BASE && X86_64
+	select MODULE_FG_KASLR
 	help
 	  This option improves the randomness of the kernel text
 	  over basic Kernel Address Space Layout Randomization (KASLR)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b65ec63c7db7..8c830c37c74c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -51,6 +51,9 @@ ifdef CONFIG_X86_NEED_RELOCS
         LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
+ifdef CONFIG_MODULE_FG_KASLR
+	KBUILD_CFLAGS_MODULE += -ffunction-sections
+endif
 #
 # Prevent GCC from generating any FP code by mistake.
 #
diff --git a/init/Kconfig b/init/Kconfig
index 74a5ac65644f..b19920413bcc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2227,6 +2227,17 @@ config UNUSED_KSYMS_WHITELIST
 	  one per line. The path can be absolute, or relative to the kernel
 	  source tree.
 
+config MODULE_FG_KASLR
+	depends on $(cc-option, -ffunction-sections)
+	bool "Module Function Granular Layout Randomization"
+	help
+	  This option randomizes the module text section by reordering the text
+	  section by function at module load time. In order to use this
+	  feature, the module must have been compiled with the
+	  -ffunction-sections compiler flag.
+
+	  If unsure, say N.
+
 endif # MODULES
 
 config MODULES_TREE_LOOKUP
diff --git a/kernel/module.c b/kernel/module.c
index 646f1e2330d2..e3cd619c60c2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -53,6 +53,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/random.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2370,6 +2371,83 @@ static long get_offset(struct module *mod, unsigned int *size,
 	return ret;
 }
 
+/*
+ * shuffle_text_list()
+ * Use a Fisher Yates algorithm to shuffle a list of text sections.
+ */
+static void shuffle_text_list(Elf_Shdr **list, int size)
+{
+	int i;
+	unsigned int j;
+	Elf_Shdr *temp;
+
+	for (i = size - 1; i > 0; i--) {
+		/*
+		 * pick a random index from 0 to i
+		 */
+		get_random_bytes(&j, sizeof(j));
+		j = j % (i + 1);
+
+		temp = list[i];
+		list[i] = list[j];
+		list[j] = temp;
+	}
+}
+
+/*
+ * randomize_text()
+ * Look through the core section looking for executable code sections.
+ * Store sections in an array and then shuffle the sections
+ * to reorder the functions.
+ */
+static void randomize_text(struct module *mod, struct load_info *info)
+{
+	int i;
+	int num_text_sections = 0;
+	Elf_Shdr **text_list;
+	int size = 0;
+	int max_sections = info->hdr->e_shnum;
+	unsigned int sec = find_sec(info, ".text");
+
+	if (sec == 0)
+		return;
+
+	text_list = kmalloc_array(max_sections, sizeof(*text_list), GFP_KERNEL);
+	if (!text_list)
+		return;
+
+	for (i = 0; i < max_sections; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+		const char *sname = info->secstrings + shdr->sh_name;
+
+		if (!(shdr->sh_flags & SHF_ALLOC) ||
+		    !(shdr->sh_flags & SHF_EXECINSTR) ||
+		    strstarts(sname, ".init"))
+			continue;
+
+		text_list[num_text_sections] = shdr;
+		num_text_sections++;
+	}
+
+	shuffle_text_list(text_list, num_text_sections);
+
+	for (i = 0; i < num_text_sections; i++) {
+		Elf_Shdr *shdr = text_list[i];
+
+		/*
+		 * get_offset has a section index for it's last
+		 * argument, that is only used by arch_mod_section_prepend(),
+		 * which is only defined by parisc. Since this this type
+		 * of randomization isn't supported on parisc, we can
+		 * safely pass in zero as the last argument, as it is
+		 * ignored.
+		 */
+		shdr->sh_entsize = get_offset(mod, &size, shdr, 0);
+	}
+
+	kfree(text_list);
+}
+
 /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
    might -- code, read-only data, read-write data, small data.  Tally
    sizes, and place the offsets into sh_entsize fields: high bit means it
@@ -2460,6 +2538,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			break;
 		}
 	}
+
+	if (IS_ENABLED(CONFIG_MODULE_FG_KASLR))
+		randomize_text(mod, info);
 }
 
 static void set_license(struct module *mod, const char *license)
-- 
2.20.1

