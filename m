Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997072EB7F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhAFB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:59:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbhAFB7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609898300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=soD85oBuoFoOYel/RvfxRXBHF3St3W2ynqAXS24SPmw=;
        b=fZQbRu4/AHhbLZKN7TiGHUaXP03iL4I/iJd436AqXuKHtH3JvsubU6nO6x8VxH1fxPaXHv
        lADtLHLNxnTIGRRfrlVkFTpxqLQaNYcrY3M42VstEDNEAF5wRqHxrRfxoKqCvSLwpsTt2R
        cb+iAdjYvjzHgH25hOw77f9rCqRurIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-JHBlh4rAP6e4dfOFx3YvyQ-1; Tue, 05 Jan 2021 20:58:16 -0500
X-MC-Unique: JHBlh4rAP6e4dfOFx3YvyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97EE4180A089;
        Wed,  6 Jan 2021 01:58:14 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D323B5D735;
        Wed,  6 Jan 2021 01:58:12 +0000 (UTC)
Date:   Tue, 5 Jan 2021 19:58:10 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] x86/entry: use STB_GLOBAL for register restoring thunk
Message-ID: <20210106015810.5p6crnh7jqtmjtv4@treble>
References: <20201224045502.zkm34cc5srdgpddb@treble>
 <20210106004351.79130-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210106004351.79130-1-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:43:51PM -0800, Nick Desaulniers wrote:
> Arnd found a randconfig that produces the warning:
> 
> arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
> offset 0x3e
> 
> when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
> notes:
> 
>   With the LLVM assembler stripping the .text section symbol, objtool
>   has no way to reference this code when it generates ORC unwinder
>   entries, because this code is outside of any ELF function.
> 
> Fangrui notes that this is helpful for reducing images size when
> compiling with -ffunction-sections and -fdata-sections. I have observerd
> on the order of tens of thousands of symbols for the kernel images built
> with those flags. A patch has been authored against GNU binutils to
> match this behavior, with a new flag
> --generate-unused-section-symbols=[yes|no].
> 
> Use a global symbol for the thunk that way
> objtool can generate proper unwind info here with LLVM_IAS=1.

On second thought, there's no need to make the symbol global.  Just
getting rid of the '.L' local label symbol prefix should be enough to
make an ELF symbol:

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index ccd32877a3c4..c9a9fbf1655f 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,7 +31,7 @@ SYM_FUNC_START_NOALIGN(\name)
 	.endif
 
 	call \func
-	jmp  .L_restore
+	jmp  __thunk_restore
 SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
@@ -44,7 +44,7 @@ SYM_FUNC_END(\name)
 #endif
 
 #ifdef CONFIG_PREEMPTION
-SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
+SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -56,6 +56,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %rdi
 	popq %rbp
 	ret
-	_ASM_NOKPROBE(.L_restore)
-SYM_CODE_END(.L_restore)
+	_ASM_NOKPROBE(__thunk_restore)
+SYM_CODE_END(__thunk_restore)
 #endif

