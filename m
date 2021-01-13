Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9752F51AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbhAMSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:06:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbhAMSGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:06:50 -0500
Received: from zn.tnic (p200300ec2f0b5c0053dfdcdd1c139e2a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:53df:dcdd:1c13:9e2a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEB8D1EC0423;
        Wed, 13 Jan 2021 19:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610561169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ecb58dV5s1Q6ZkbAHlIZLthrr/+0Gu1KFqXCmL6iNQo=;
        b=EGQ3ALvr+Scr+so54frXBNdjhWypBvU/uP1MiT4VYSvV7xPo5OVAgYrhluTHlOUTXuIJLb
        Pb9jag1rkd40sl+NRhw8567fnNimM7dCn6pISiUk5O2r3mDeGyd1tDDiL8Yv+K+7Ovvm+Z
        wmlXWPQwvOx+lrFjX+yd9Js2FuERufw=
Date:   Wed, 13 Jan 2021 19:06:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 03/19] x86/insn: Add an insn_decode() API
Message-ID: <20210113180609.GH16960@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-4-bp@alien8.de>
 <20201228101510.49082d470ed328d81486ef04@kernel.org>
 <20201229200654.GF29947@zn.tnic>
 <20201230180052.7e1931b4e1b17079023b65b7@kernel.org>
 <20201230092833.GE22022@zn.tnic>
 <20210106142114.5e9ce2cc107f6386e36b4ff4@kernel.org>
 <20210108185950.GG4042@zn.tnic>
 <20210112203446.04c37db1cbb329f37b4b4a5c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112203446.04c37db1cbb329f37b4b4a5c@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 08:34:46PM +0900, Masami Hiramatsu wrote:
> Or, add one definition before that line.
> 
> #define INSN_MODE_KERN -1	/* __ignore_sync_check__ */

I like that idea, thanks! And it seems to work:

---

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 4cf2ad521f65..b56c5741581a 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/inat_types.h>
+#include <asm/inat_types.h> /* __ignore_sync_check__ */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 9f1910284861..6df0d3da0d86 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
+#include <asm/inat.h> /* __ignore_sync_check__ */
 
 struct insn_field {
 	union {
diff --git a/arch/x86/lib/inat.c b/arch/x86/lib/inat.c
index 12539fca75c4..b0f3b2a62ae2 100644
--- a/arch/x86/lib/inat.c
+++ b/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/insn.h>
+#include <asm/insn.h> /* __ignore_sync_check__ */
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 2ab1d0256313..aa6ee796a987 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -10,13 +10,13 @@
 #else
 #include <string.h>
 #endif
-#include <asm/inat.h>
-#include <asm/insn.h>
+#include <asm/inat.h> /*__ignore_sync_check__ */
+#include <asm/insn.h> /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 
-#include <asm/emulate_prefix.h>
+#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
@@ -748,6 +748,8 @@ int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mod
 {
 	int ret;
 
+/* #define INSN_MODE_KERN	-1 __ignore_sync_check__ mode is only valid in the kernel */
+
 	if (m == INSN_MODE_KERN)
 		insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
 	else
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 877827b7c2c3..a61051400311 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "inat_types.h"
+#include "inat_types.h" /* __ignore_sync_check__ */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index f8772b371452..4f219e3ae817 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include "inat.h"
+#include "inat.h" /* __ignore_sync_check__ */
 
 struct insn_field {
 	union {
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
index 4f5ed49e1b4e..dfbcc6405941 100644
--- a/tools/arch/x86/lib/inat.c
+++ b/tools/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "../include/asm/insn.h"
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index c224e1569034..13e8615edc15 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -10,13 +10,13 @@
 #else
 #include <string.h>
 #endif
-#include "../include/asm/inat.h"
-#include "../include/asm/insn.h"
+#include "../include/asm/inat.h" /* __ignore_sync_check__ */
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 
-#include "../include/asm/emulate_prefix.h"
+#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
@@ -748,6 +748,8 @@ int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mod
 {
 	int ret;
 
+#define INSN_MODE_KERN	-1 /* __ignore_sync_check__ mode is only valid in the kernel */
+
 	if (m == INSN_MODE_KERN)
 		insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
 	else
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 606a4b5e929f..4bbabaecab14 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -16,11 +16,14 @@ arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 include/linux/static_call_types.h
-arch/x86/include/asm/inat.h     -I '^#include [\"<]\(asm/\)*inat_types.h[\">]'
-arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
-arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
-arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+
+SYNC_CHECK_FILES='
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/insn.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+'
 fi
 
 check_2 () {
@@ -63,3 +66,9 @@ while read -r file_entry; do
 done <<EOF
 $FILES
 EOF
+
+if [ "$SRCARCH" = "x86" ]; then
+	for i in $SYNC_CHECK_FILES; do
+		check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+	done
+fi
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index dded93a2bc89..07857dfb4d91 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -75,6 +75,13 @@ include/uapi/asm-generic/mman-common.h
 include/uapi/asm-generic/unistd.h
 '
 
+SYNC_CHECK_FILES='
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/insn.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+'
+
 # These copies are under tools/perf/trace/beauty/ as they are not used to in
 # building object files only by scripts in tools/perf/trace/beauty/ to generate
 # tables that then gets included in .c files for things like id->string syscall
@@ -129,6 +136,10 @@ for i in $FILES; do
   check $i -B
 done
 
+for i in $SYNC_CHECK_FILES; do
+  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+done
+
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
@@ -137,10 +148,6 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
-check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
-check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
-check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
