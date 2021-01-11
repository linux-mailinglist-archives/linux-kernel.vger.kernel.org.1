Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ECF2F227F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbhAKWNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732176AbhAKWNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610403135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2SRQaJi68oIpDWEDot6m4+vdPC0oqlKXjoXJCK3EU8=;
        b=TAt0wI0vt5OCDmJf3r5DTtjaRzOyn3IVbYE+VddpQx97HlxxkoW5OHianp/JX+Q0hGW1C2
        FnciXONTE5H4kkC7eUJCvXuXWJvZfdh+UQeGIZdF01AoYPA9RRZi4J70Y/twLpBmnBqz64
        nNb6UEw7+KmnTk44hS4b8v+8qT76O6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-g1YzdYylM4OYtp5p5gL-PQ-1; Mon, 11 Jan 2021 17:12:12 -0500
X-MC-Unique: g1YzdYylM4OYtp5p5gL-PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4BF7B8101;
        Mon, 11 Jan 2021 22:12:10 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA925C232;
        Mon, 11 Jan 2021 22:12:09 +0000 (UTC)
Date:   Mon, 11 Jan 2021 16:12:07 -0600
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
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210111221207.3hdgzhhis7ubcyrb@treble>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111203807.3547278-1-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:38:06PM -0800, Nick Desaulniers wrote:
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
> Fangrui notes that this optimization is helpful for reducing images size

"image"

> when compiling with -ffunction-sections and -fdata-sections. I have
> observerd on the order of tens of thousands of symbols for the kernel

"observed"

> images built with those flags. A patch has been authored against GNU
> binutils to match this behavior, with a new flag
> --generate-unused-section-symbols=[yes|no].
> 
> We can omit the .L prefix on a label to emit an entry into the symbol
> table for the label, with STB_LOCAL binding.  This enables objtool to
> generate proper unwind info here with LLVM_IAS=1.
> 
> Cc: Fangrui Song <maskray@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1209
> Link: https://reviews.llvm.org/D93783
> Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
> Link: https://sourceware.org/pipermail/binutils/2020-December/114671.html
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v2 -> v3:
> * rework to use STB_LOCAL rather than STB_GLOBAL by dropping .L prefix,
>   as per Josh.
> * rename oneline to drop STB_GLOBAL in commit message.
> * add link to GAS docs on .L prefix.
> * drop Josh's ack since patch changed.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

