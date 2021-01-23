Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14930123E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAWC1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbhAWC1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611368778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJX45dFL81O/CxuAJek1TRpHKAzDl0ox2asYfOyKPaQ=;
        b=eejmuTD9rZZkHl+LdDLjiQC9OCNTV8uTNv4t3dsAawA+aYhzWG9flV+3ITCGjTACD163yx
        S83DVAHYuErsErsXTcEPbgQLgAEYrZrqSj+j9stjlAaUfF4FgVVMGzfxAntRjzze5wjbvL
        8WDqietqOfJcg4R7o9WuyQaOni1kcgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-Ek-tnCOaM1Osdmp0eicttg-1; Fri, 22 Jan 2021 21:26:14 -0500
X-MC-Unique: Ek-tnCOaM1Osdmp0eicttg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F3A9180A09D;
        Sat, 23 Jan 2021 02:26:12 +0000 (UTC)
Received: from treble (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFA7D5DA33;
        Sat, 23 Jan 2021 02:26:10 +0000 (UTC)
Date:   Fri, 22 Jan 2021 20:26:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
Message-ID: <20210123022609.n7xsj2a4potoijz7@treble>
References: <cover.1611263461.git.jpoimboe@redhat.com>
 <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble>
 <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
 <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:32:43PM -0800, Nick Desaulniers wrote:
> > In this specific case, find_func_by_offset returns NULL for
> > .text..L.cfi.jumptable.43 at addend 0x8, because Clang doesn't emit
> > jump table symbols for static functions:
> >
> > 0000000000000000 <__typeid__ZTSFjmiE_global_addr>:
> >    0:   e9 00 00 00 00          jmpq   5 <__typeid__ZTSFjmiE_global_addr+0x5>
> >                         1: R_X86_64_PLT32       io_serial_in-0x4
> >    5:   cc                      int3
> >    6:   cc                      int3
> >    7:   cc                      int3
> >    8:   e9 00 00 00 00          jmpq   d <__typeid__ZTSFjmiE_global_addr+0xd>
> >                         9: R_X86_64_PLT32       mem32_serial_in-0x4
> >    d:   cc                      int3
> >    e:   cc                      int3
> >    f:   cc                      int3
> >
> > Nick, do you remember if there were plans to change this?
> 
> Do you have a link to any previous discussion to help jog my mind; I
> don't really remember this one.
> 
> Is it that `__typeid__ZTSFjmiE_global_addr` is the synthesized jump
> table, and yet there is no `__typeid__ZTSFjmiE_global_addr` entry in
> the symbol table?

I think he means there's not a 'mem32_serial_in.cfi_jt' symbol at
'__typeid__ZTSFjmiE_global_addr+8'.  Probably more aggressive symbol
pruning from the assembler.

It's fine though.  I just need to rewrite the CFI support a bit.

But that can come later.  For now I'll just drop the two CFI-related
patches from this set so I can merge the others next week.

-- 
Josh

