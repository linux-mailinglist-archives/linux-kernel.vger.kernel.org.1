Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE632F2278
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbhAKWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:10:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388713AbhAKWKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610402959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8xcEaScocMaIAyGo9r9RJw+Py5fHWtPNocsWnO7jC4=;
        b=Xc1wAeFBFbJqlgNxh7v2bPeJ1NEuz4xMH6P6FZ4jh+t8FBRPf816KPPdULp0vVpTrlDYt0
        EMknXiYLEzjaY+TyMKG+Vap1HmthLisndHetnccRpZg9QX/AKwXRny3FNt5lcGffLb4p2E
        1Oyi1GqZx8Laf+zy2czXYCFZBpxyVS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-W4ny10YCPTGLemtj538iuw-1; Mon, 11 Jan 2021 17:09:15 -0500
X-MC-Unique: W4ny10YCPTGLemtj538iuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41733809DCC;
        Mon, 11 Jan 2021 22:09:13 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 830315C5DF;
        Mon, 11 Jan 2021 22:09:11 +0000 (UTC)
Date:   Mon, 11 Jan 2021 16:09:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210111220909.2wexjehwiria7jem@treble>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210111205814.m6bbvekdhqs7pnhr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111205814.m6bbvekdhqs7pnhr@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:58:14PM -0800, Fangrui Song wrote:
> On 2021-01-11, Nick Desaulniers wrote:
> > Arnd found a randconfig that produces the warning:
> > 
> > arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
> > offset 0x3e
> > 
> > when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
> > notes:
> > 
> >  With the LLVM assembler stripping the .text section symbol, objtool
> >  has no way to reference this code when it generates ORC unwinder
> >  entries, because this code is outside of any ELF function.
> > 
> > Fangrui notes that this optimization is helpful for reducing images size
> > when compiling with -ffunction-sections and -fdata-sections. I have
> > observerd on the order of tens of thousands of symbols for the kernel
> > images built with those flags. A patch has been authored against GNU
> > binutils to match this behavior, with a new flag
> > --generate-unused-section-symbols=[yes|no].
> 
> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=d1bcae833b32f1408485ce69f844dcd7ded093a8
> has been committed. The patch should be included in binutils 2.37.
> The maintainers are welcome to the idea, but fixing all the arch-specific tests is tricky.
> 
> H.J. fixed the x86 tests and enabled this for x86. When binutils 2.37
> come out, some other architectures may follow as well.
> 
> > We can omit the .L prefix on a label to emit an entry into the symbol
> > table for the label, with STB_LOCAL binding.  This enables objtool to
> > generate proper unwind info here with LLVM_IAS=1.
> 
> Josh, I think objtool orc generate needs to synthesize STT_SECTION
> symbols even if they do not exist in object files.

I'm guessing you don't mean re-adding *all* missing STT_SECTIONs, as
that would just be undoing these new assembler features.

We could re-add STT_SECTION only when there's no other corresponding
symbol associated with the code, but then objtool would have to start
updating the symbol table (which right now it manages to completely
avoid).  But that would only be for the niche cases, like
'SYM_CODE.*\.L' as you mentioned.

I'd rather avoid making doing something so pervasive for such a small
number of edge cases.  It's hopefully easier and more robust to just say
"all code must be associated with a symbol".  I suspect we're already
~99.99% there anyway.

  $ git grep -e 'SYM_CODE.*\.L'
  arch/x86/entry/entry_64.S:SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
  arch/x86/entry/entry_64.S:SYM_CODE_END(.Lbad_gs)
  arch/x86/entry/thunk_64.S:SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
  arch/x86/entry/thunk_64.S:SYM_CODE_END(.L_restore)
  arch/x86/lib/copy_user_64.S:SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
  arch/x86/lib/copy_user_64.S:SYM_CODE_END(.Lcopy_user_handle_tail)
  arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
  arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_clac)
  arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
  arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_8_clac)
  arch/x86/lib/putuser.S:SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
  arch/x86/lib/putuser.S:SYM_CODE_END(.Lbad_put_user_clac)

Alternatively, the assemblers could add an option to only strip
-ffunction-sections and -fdata-sections STT_SECTION symbols, e.g. leave
".text" and friends alone.

-- 
Josh

