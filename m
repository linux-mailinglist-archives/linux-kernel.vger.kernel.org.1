Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772662E243A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgLXE4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgLXE4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608785713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxMGyDVUabqfaUQArhDMx1wL+LPwE8Hrvq2QXIAisfo=;
        b=VAl+6GJ3vG9/cu19NFZA5/uCMGSbo1WeeNMgFYGJdJJZisdtGKGJZuW7L/xB8z1WmpOdmJ
        4In/pyX8MEbDifbQ+kPcFo1oChEJtoO+AcAb23biJ8Z/uEonERydPMe3Z7dEqbZOtqf1AO
        F95f91l7pfghctnMXh5jBHWm9STVI7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-PgAS-Z4qPvG7cIlDNuIt7Q-1; Wed, 23 Dec 2020 23:55:09 -0500
X-MC-Unique: PgAS-Z4qPvG7cIlDNuIt7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CA3E107ACFE;
        Thu, 24 Dec 2020 04:55:07 +0000 (UTC)
Received: from treble (ovpn-117-91.rdu2.redhat.com [10.10.117.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28DC527C20;
        Thu, 24 Dec 2020 04:55:04 +0000 (UTC)
Date:   Wed, 23 Dec 2020 22:55:02 -0600
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
Subject: Re: [PATCH] x86/entry: use STB_GLOBAL for register restoring thunk
Message-ID: <20201224045502.zkm34cc5srdgpddb@treble>
References: <20201223232126.759416-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223232126.759416-1-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 03:21:26PM -0800, Nick Desaulniers wrote:
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
> This behavior was implemented as an optimization in LLVM 5 years ago,
> but it's not the first time this has caused issues for objtool.  A patch
> has been authored against LLVM to revert the behavior, which may or may
> not be accepted.  Until then use a global symbol for the thunk that way
> objtool can generate proper unwind info here with LLVM_IAS=1.

As Fangrui pointed out, the section symbol stripping is useful for when
there are a ton of sections like '-ffunction-sections' and
'-fdata-sections'.  Maybe add that justification to the patch
description.

We can try to support it, though I suspect other tools may also end up
getting surprised.

> Cc: Fangrui Song <maskray@google.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1209
> Link: https://reviews.llvm.org/D93783
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Code looks familiar ;-)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

