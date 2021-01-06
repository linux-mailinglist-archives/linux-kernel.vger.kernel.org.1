Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCCD2EB946
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 06:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbhAFFWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 00:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbhAFFV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 00:21:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 110DF22CB9;
        Wed,  6 Jan 2021 05:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609910478;
        bh=boxdZNrCes9phB/H6KelJrXD4jwDAkI2Od6BcLKPhD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aT0KDthGB3PXY1hrTcQvMM4tEqpTcsN2AVS8fv6ZQC9lUKG/OX7N/MkL+Xrim2f0v
         AQ+rHzRP8uNGE02iQHg4ZNFX03N8bnr7RVufFI259hi65Gd4bdP6+YoxrAhpOdEMDk
         /qH/dNnLNigs0SgzA6YuPXOSc7joKR0j5sD7vJ4woKx5RSjq8zffspqfXJi36f7xlE
         5iSwSHFmEpcg1kMxkWmgebIUB4AAeLTRmZjnk5cmCLkz4qPs+aEmz7M6RlqQFkXXoI
         B19F43O/4XNYNxW+2QABSOJVj3Xy6hcP3Eb3xy3J8jLPYZCceu4ND+Ch/AVNeBYc72
         2aqiIP9SCvIYQ==
Date:   Wed, 6 Jan 2021 14:21:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 03/19] x86/insn: Add an insn_decode() API
Message-Id: <20210106142114.5e9ce2cc107f6386e36b4ff4@kernel.org>
In-Reply-To: <20201230092833.GE22022@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
        <20201223174233.28638-4-bp@alien8.de>
        <20201228101510.49082d470ed328d81486ef04@kernel.org>
        <20201229200654.GF29947@zn.tnic>
        <20201230180052.7e1931b4e1b17079023b65b7@kernel.org>
        <20201230092833.GE22022@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 10:28:33 +0100
Borislav Petkov <bp@alien8.de> wrote:

> I still haven't thought about what do to exactly there wrt making
> sync-check.sh happy but the aspect of failing the build is a nice one.

So I think it is possible to introduce a keyword in a comment
for ignoring sync check something like below. This will allow us
a generic pattern matching.

The keyword is just an example, "no-sync-check" etc. is OK.

What would you think about it?

Thank you,

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 4cf2ad521f65..ff3d119610f5 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/inat_types.h>
+#include <asm/inat_types.h>	/* Different from tools */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index a8c3d284fa46..dda4fe208659 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
+#include <asm/inat.h>	/* Different from tools */
 
 struct insn_field {
 	union {
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 877827b7c2c3..1fcfb4efb5f4 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "inat_types.h"
+#include "inat_types.h"	/* Different from kernel */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 52c6262e6bfd..702135ddb4fd 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include "inat.h"
+#include "inat.h"	/* Different from kernel */
 
 struct insn_field {
 	union {
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index dded93a2bc89..b112d68c5513 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -137,8 +137,8 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
-check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
-check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
+check arch/x86/include/asm/inat.h     '-I "^.*/\* Different from \(tools\|kernel\) \*/"'
+check arch/x86/include/asm/insn.h     '-I "^.*/\* Different from \(tools\|kernel\) \*/"'
 check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
 check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
-- 
Masami Hiramatsu <mhiramat@kernel.org>
