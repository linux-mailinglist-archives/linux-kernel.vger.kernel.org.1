Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E204E2F6201
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbhANN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:28:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52306 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbhANN24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:28:56 -0500
Received: from zn.tnic (p200300ec2f1aa9000d5c8ff8171504e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:d5c:8ff8:1715:4e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DA2F1EC04F3;
        Thu, 14 Jan 2021 14:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610630895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Gsx3hXRw+pWKKzqut1Ush7pyeSMmp2ZCnERRJ1prroQ=;
        b=F4XklBpuOo2kav+B+Hj/WlCU2yiyhQVshdz0xeJoNAAPK8BiaQI8qNIfPsfOaEDNBUjh+3
        HhoaRWIRvLPVwFlEHE03osTFDF7+sZTo7UJTYzNVtn54egCQzmAwwVMgaPM+SZolKuKnfB
        1kwj9tzbs+roaO+KJee2+FO/goS9SAM=
Date:   Thu, 14 Jan 2021 14:28:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: [PATCH] x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument
Message-ID: <20210114132809.GC12284@zn.tnic>
References: <20210112115421.GB13086@zn.tnic>
 <20210112194625.4181814-1-ndesaulniers@google.com>
 <20210112210154.GI4646@sirena.org.uk>
 <20210113165923.acvycpcu5tzksbbi@treble>
 <CAKwvOdnAMsYF-v1LAqttBV3e3rHhSFZmPcRRV0+v=+9AyMFgNA@mail.gmail.com>
 <20210114103928.GB12284@zn.tnic>
 <YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:36:45PM +0100, Peter Zijlstra wrote:
> And while looking, I suppose we can delete the put_ret_addr_in_rdi crud,
> but that's another patch.

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 14 Jan 2021 14:25:35 +0100
Subject: [PATCH] x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument

That logic is unused since

  320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")

Remove it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/entry/thunk_64.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index c9a9fbf1655f..496b11ec469d 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -10,7 +10,7 @@
 #include <asm/export.h>
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
-	.macro THUNK name, func, put_ret_addr_in_rdi=0
+	.macro THUNK name, func
 SYM_FUNC_START_NOALIGN(\name)
 	pushq %rbp
 	movq %rsp, %rbp
@@ -25,11 +25,6 @@ SYM_FUNC_START_NOALIGN(\name)
 	pushq %r10
 	pushq %r11
 
-	.if \put_ret_addr_in_rdi
-	/* 8(%rbp) is return addr on stack */
-	movq 8(%rbp), %rdi
-	.endif
-
 	call \func
 	jmp  __thunk_restore
 SYM_FUNC_END(\name)
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
