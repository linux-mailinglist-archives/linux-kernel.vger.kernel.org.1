Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516930126D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbhAWCve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhAWCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:51:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1758C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:50:33 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e22so15342307iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/woc6EL8jvqhcMt0g673arBuUVAjXUttmH8btu3PCdo=;
        b=DYp8gZV0X0zQcDWLtW2FrBHeGrUIMnrFSaSGFzH7ECNNywMYrQnz/cplyZLXkkwdW7
         lGinjJYto2neWOMYCGdXJ0id7ThsGhB0nyMSqoNJBq9L5PuST5ltXAvN9fz+uK5KyDim
         orEJWbpA2Yyx1YfzV+9JEiVWXWDXLxsM4VUrKq+GQpFOl8u5nIHrxwnttqDEghAn71Su
         RnfPN80z08lbI92cUw49yqmWfIvrNgoOX5WgknZqPb4DmtwmiLjdBti1fpHrcsrGQ1ta
         sDKWS1t9/iKzd0LbiC+9RAGuXucMjlW4j/3fzJPWLi187QFrBrtmFuz9PPCG+CKbgWbz
         ByXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/woc6EL8jvqhcMt0g673arBuUVAjXUttmH8btu3PCdo=;
        b=VBGc+sOLvhrrapGh3q6fgHl8K1Wexa6sExRM5dBeTStWi7UbX36iPbyTqjiDUJYzMU
         qdkLFlDV8njb0OJIcb7+32oLp1v44mBR/JCD4NCQUIGO0DxyWi12O53p4iqnprzjpCqX
         Imuq72yiHdRPdRpE4Bq38JwGnRzns5PBB740TKMhfqc34urtFl/9qnJPS3BG5YuG+n2p
         FgciigqrebYmpI/CGEGWUZ4L1i1Ndstsy9X9C5QMkJMKbfYUZD+asvxAgag2jiQ8bNS+
         DXMK2x3wBJ7ZsaG+j51TSmc3Nl5ULKHXIgyBEaSYGqXToEf6Q3pmyl8nFYEvRwZ3atKM
         5Ccw==
X-Gm-Message-State: AOAM5302Lgy10K7snB83aXXAhqxBTI1p5Xg7D3sKfMgv5u7bL7KxYGPm
        e0fWvL2XZsU/eWlryBwB4SY/y/bq31jYg2M7FEk=
X-Google-Smtp-Source: ABdhPJw09T+KI9qBQYhXvvaYnzjqMO3xkQA4YlDuEy19+E9hES5mawhyybxbNFmqV4h54YT22MDFkQ6HSSKnxP0hVus=
X-Received: by 2002:a5e:970c:: with SMTP id w12mr2455196ioj.171.1611370233360;
 Fri, 22 Jan 2021 18:50:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611263461.git.jpoimboe@redhat.com> <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
 <20210122154158.lylubqugmcxehugg@treble> <CABCJKueaW1BEEBKLQzyp77VwTL+bE4x=kOLV3TWmc1s6-r3PeQ@mail.gmail.com>
 <CAKwvOdkcoCFKD63xtQzRdFikDk-GUUfUG5EEKiCTA3cueEZQNA@mail.gmail.com>
 <20210123022609.n7xsj2a4potoijz7@treble> <CA+icZUX9mYAFE6aFdmGS+rnJbeBMMMeVBrSs_pC6ragzXCjT7w@mail.gmail.com>
 <20210123024634.qu62tyq3nkqusken@treble>
In-Reply-To: <20210123024634.qu62tyq3nkqusken@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 23 Jan 2021 03:50:21 +0100
Message-ID: <CA+icZUVSiL5tCTjNaCjuRwF7U5Z6OcXMVoODhNfzuLePN+1SFA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 3:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Jan 23, 2021 at 03:31:20AM +0100, Sedat Dilek wrote:
> > On Sat, Jan 23, 2021 at 3:26 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, Jan 22, 2021 at 05:32:43PM -0800, Nick Desaulniers wrote:
> > > > > In this specific case, find_func_by_offset returns NULL for
> > > > > .text..L.cfi.jumptable.43 at addend 0x8, because Clang doesn't emit
> > > > > jump table symbols for static functions:
> > > > >
> > > > > 0000000000000000 <__typeid__ZTSFjmiE_global_addr>:
> > > > >    0:   e9 00 00 00 00          jmpq   5 <__typeid__ZTSFjmiE_global_addr+0x5>
> > > > >                         1: R_X86_64_PLT32       io_serial_in-0x4
> > > > >    5:   cc                      int3
> > > > >    6:   cc                      int3
> > > > >    7:   cc                      int3
> > > > >    8:   e9 00 00 00 00          jmpq   d <__typeid__ZTSFjmiE_global_addr+0xd>
> > > > >                         9: R_X86_64_PLT32       mem32_serial_in-0x4
> > > > >    d:   cc                      int3
> > > > >    e:   cc                      int3
> > > > >    f:   cc                      int3
> > > > >
> > > > > Nick, do you remember if there were plans to change this?
> > > >
> > > > Do you have a link to any previous discussion to help jog my mind; I
> > > > don't really remember this one.
> > > >
> > > > Is it that `__typeid__ZTSFjmiE_global_addr` is the synthesized jump
> > > > table, and yet there is no `__typeid__ZTSFjmiE_global_addr` entry in
> > > > the symbol table?
> > >
> > > I think he means there's not a 'mem32_serial_in.cfi_jt' symbol at
> > > '__typeid__ZTSFjmiE_global_addr+8'.  Probably more aggressive symbol
> > > pruning from the assembler.
> > >
> > > It's fine though.  I just need to rewrite the CFI support a bit.
> > >
> > > But that can come later.  For now I'll just drop the two CFI-related
> > > patches from this set so I can merge the others next week.
> > >
> >
> > Two CFI-related patches?
> >
> > What's the other than "objtool: Add CONFIG_CFI_CLANG support"?
>
> I was referring to patches 10 and 11:
>
>   objtool: Move unsuffixed symbol conversion to a helper function
>   objtool: Add CONFIG_CFI_CLANG support
>

OK, thanks.

I will test with a revert of these two patches in another scenario
where I have problems with Clang's IAS but not with GNU AS.

- Sedat -

> You can just drop those patches from your testing (and don't test with
> CFI).
>
> > Do you plan (or offer) a v3 of objtool-vmlinux?
>
> Not unless there are any more comments.
>
> --
> Josh
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210123024634.qu62tyq3nkqusken%40treble.
