Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999F9301269
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhAWCsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:48:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbhAWCsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611370004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cxv8yeNTpR9XS/lBII/no4JZ344/E/lNrITT32lKLQg=;
        b=FCbX+wSwkRX+9RjTIPXHVdTKEIvCml2mWidnWMn5atDY0RSRe43y/DSUUdY/+W9TcU4CFk
        HCG+X2xy+BwG58MjS8Cb5OD4u47mAJkCDieNYTKzkhm1y6bGNnuOqLpD1sO35zhAglS6CI
        hMdUoiX5e2KyO8MT/DVP2rWUeaT2Wi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-JeLdl3hpN1iGRYxRxolM9A-1; Fri, 22 Jan 2021 21:46:40 -0500
X-MC-Unique: JeLdl3hpN1iGRYxRxolM9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34472806661;
        Sat, 23 Jan 2021 02:46:38 +0000 (UTC)
Received: from treble (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DEF560C43;
        Sat, 23 Jan 2021 02:46:36 +0000 (UTC)
Date:   Fri, 22 Jan 2021 20:46:34 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
Message-ID: <20210123024634.qu62tyq3nkqusken@treble>
References: <cover.1611263461.git.jpoimboe@redhat.com>
 <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble>
 <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
 <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com>
 <20210123022609.n7xsj2a4potoijz7@treble>
 <CA+icZUX9mYAFE6aFdmGS+rnJbeBMMMeVBrSs_pC6ragzXCjT7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUX9mYAFE6aFdmGS+rnJbeBMMMeVBrSs_pC6ragzXCjT7w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 03:31:20AM +0100, Sedat Dilek wrote:
> On Sat, Jan 23, 2021 at 3:26 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Jan 22, 2021 at 05:32:43PM -0800, Nick Desaulniers wrote:
> > > > In this specific case, find_func_by_offset returns NULL for
> > > > .text..L.cfi.jumptable.43 at addend 0x8, because Clang doesn't emit
> > > > jump table symbols for static functions:
> > > >
> > > > 0000000000000000 <__typeid__ZTSFjmiE_global_addr>:
> > > >    0:   e9 00 00 00 00          jmpq   5 <__typeid__ZTSFjmiE_global_addr+0x5>
> > > >                         1: R_X86_64_PLT32       io_serial_in-0x4
> > > >    5:   cc                      int3
> > > >    6:   cc                      int3
> > > >    7:   cc                      int3
> > > >    8:   e9 00 00 00 00          jmpq   d <__typeid__ZTSFjmiE_global_addr+0xd>
> > > >                         9: R_X86_64_PLT32       mem32_serial_in-0x4
> > > >    d:   cc                      int3
> > > >    e:   cc                      int3
> > > >    f:   cc                      int3
> > > >
> > > > Nick, do you remember if there were plans to change this?
> > >
> > > Do you have a link to any previous discussion to help jog my mind; I
> > > don't really remember this one.
> > >
> > > Is it that `__typeid__ZTSFjmiE_global_addr` is the synthesized jump
> > > table, and yet there is no `__typeid__ZTSFjmiE_global_addr` entry in
> > > the symbol table?
> >
> > I think he means there's not a 'mem32_serial_in.cfi_jt' symbol at
> > '__typeid__ZTSFjmiE_global_addr+8'.  Probably more aggressive symbol
> > pruning from the assembler.
> >
> > It's fine though.  I just need to rewrite the CFI support a bit.
> >
> > But that can come later.  For now I'll just drop the two CFI-related
> > patches from this set so I can merge the others next week.
> >
> 
> Two CFI-related patches?
> 
> What's the other than "objtool: Add CONFIG_CFI_CLANG support"?

I was referring to patches 10 and 11:

  objtool: Move unsuffixed symbol conversion to a helper function
  objtool: Add CONFIG_CFI_CLANG support

You can just drop those patches from your testing (and don't test with
CFI).

> Do you plan (or offer) a v3 of objtool-vmlinux?

Not unless there are any more comments.

-- 
Josh

