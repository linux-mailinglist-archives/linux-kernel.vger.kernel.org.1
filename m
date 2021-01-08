Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB72EF7CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbhAHTA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbhAHTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:00:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4198C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:59:48 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a3100c075099205e185af.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3100:c075:992:5e1:85af])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A894D1EC0328;
        Fri,  8 Jan 2021 19:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610132386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUoJXj/vTymDF3/jxZ64o94H44yC8XlpdtvlaPk7+dM=;
        b=YBX5hUOxRj/hxbLDljqPlxOs+Pxf9x+L3KQHktha5WmlCLgxjGNCrUJs7yfLAt9k7QVp5s
        /xS4SOcFyeCtOjN+OEOxGVmcmKLbPQlgoL0ZuWKtZzyX90GHhgPUZ8Yi/GMrC562YsHAKV
        oGF99pX5MrwEmUTdgo6whktOrhr7y64=
Date:   Fri, 8 Jan 2021 19:59:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 03/19] x86/insn: Add an insn_decode() API
Message-ID: <20210108185950.GG4042@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-4-bp@alien8.de>
 <20201228101510.49082d470ed328d81486ef04@kernel.org>
 <20201229200654.GF29947@zn.tnic>
 <20201230180052.7e1931b4e1b17079023b65b7@kernel.org>
 <20201230092833.GE22022@zn.tnic>
 <20210106142114.5e9ce2cc107f6386e36b4ff4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210106142114.5e9ce2cc107f6386e36b4ff4@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 02:21:14PM +0900, Masami Hiramatsu wrote:
> So I think it is possible to introduce a keyword in a comment
> for ignoring sync check something like below. This will allow us
> a generic pattern matching.
> 
> The keyword is just an example, "no-sync-check" etc. is OK.
> 
> What would you think about it?

Yeah, I'd prefer a single keyword which to slap everywhere, see below.
The patch is only for demonstration, though, it is not complete.

And while playing with that after having commented out INSN_MODE_KERN in
the tools/ version, I realized that the build would always fail because
insn.c references it:

In file included from arch/x86/decode.c:12:
arch/x86/../../../arch/x86/lib/insn.c: In function ‘insn_decode’:
arch/x86/../../../arch/x86/lib/insn.c:751:11: error: ‘INSN_MODE_KERN’ undeclared (first use in this function); did you mean ‘INSN_MODE_64’?
  751 |  if (m == INSN_MODE_KERN)
      |           ^~~~~~~~~~~~~~
      |           INSN_MODE_64

and making that work would turn pretty ugly because I wanna avoid
slapping that __ignore_sync_check__ or whatever on more than one line.

So I need to think about a better solution here... 

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
index 9f1910284861..601eac7a4973 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
+#include <asm/inat.h> /* __ignore_sync_check__ */
 
 struct insn_field {
 	union {
@@ -99,7 +99,7 @@ enum insn_mode {
 	INSN_MODE_32,
 	INSN_MODE_64,
 	/* Mode is determined by the current kernel build. */
-	INSN_MODE_KERN,
+	INSN_MODE_KERN, /* __ignore_sync_check__ */
 	INSN_NUM_MODES,
 };
 
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
index 2ab1d0256313..1295003fb4f7 100644
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
index f8772b371452..b12329de4e6e 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include "inat.h"
+#include "inat.h" /* __ignore_sync_check__ */
 
 struct insn_field {
 	union {
@@ -99,7 +99,7 @@ enum insn_mode {
 	INSN_MODE_32,
 	INSN_MODE_64,
 	/* Mode is determined by the current kernel build. */
-	INSN_MODE_KERN,
+	/* INSN_MODE_KERN, __ignore_sync_check__ */
 	INSN_NUM_MODES,
 };
 
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
index c224e1569034..0824ae531019 100644
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
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index dded93a2bc89..46ee37c87a80 100755
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
+  check $i '-I "^.*\/*.*__ignore_sync_check__ \*/.*$"'
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
