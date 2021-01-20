Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6DB2FD926
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392466AbhATTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387437AbhATS5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:57:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:57:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 31so669534plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IjT5vM0wwpC9kpod4C2W/rvy6n2du1gFGDH7SeVYpA=;
        b=FnEQe4NdFtLMCzMpWBm01f0nkqCIXmpGnyv1Isu2e3YosASvuZSZMrYjbK4n8SXMKA
         11bXc0VkJx6niIVERe7ZEenE3e3K51Vv3ClAmmpkWCIHiy5yqtGOEHMojs46e1tudcx4
         +KIkD1vhoSe630IfWDZSi2/JMI5WF+PLk6lbpa61juWxsWRAprfL7r48gLTGHQakJ7YD
         GpY7BfvBRZOrAG4SP79XUJjH/qy1fxHu/YqL/qQLu+kUC2UJ8z64e5jwz8JI222O5pAf
         5k8r0BQXnUgeTXrba1KWIDUD6WLARPQD57kBKzC5P3LoMyPDpd4Tn0qooee6liLjXLjl
         GwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IjT5vM0wwpC9kpod4C2W/rvy6n2du1gFGDH7SeVYpA=;
        b=qqI4ZLEVOIzSg+2i2PbcMmyDyfkUWTlY6RCumVK/+0wiUt4A0z9LZ2XoYZaHaLcAoX
         sNJra89cWgvLhoZW1DwwQ5t4WLZnV2wVMyhnIFeWtpKlz8pRYeVIaTTOsVwT7CQgC/YL
         7wbge/E6xJasYI4paQacUIFoJr3JxUP7KrqSz0gBdLxCuqJRYGsh7O1ZVFPkaN9ZbrLu
         MmOud0H1Cua/Ko0V13vngdEiYAgF1UpMVv2vlf5FFlobrOJOf6AE9SwXFtDxNf88HEZj
         i8QCm7m2GwRONECkABpy/Qk8zM4Jc39MfRuGD+zzzbGKA883C6WxnVIKKWSrcMCmm6c/
         4sOw==
X-Gm-Message-State: AOAM532Em94NqCH9+fwJShuhXRT8/ACL1CBnilvnKLyIWO+b8cuR5mTb
        WloU/DXHRwayevhX5GhsUS3Q4DSSQfmlq1yRSQc1wg==
X-Google-Smtp-Source: ABdhPJwVH5hPIt+TGvLTxRBBzGs/IugUmzu+q+OXrVRQdS4VsRDDJ4BtXntxOzCvUMCUXt5VtXebFAiD2WbdPyv7dOM=
X-Received: by 2002:a17:90b:228f:: with SMTP id kx15mr733291pjb.32.1611169033913;
 Wed, 20 Jan 2021 10:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20210120072547.10221-1-yashsri421@gmail.com> <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
 <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com> <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
In-Reply-To: <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 10:57:03 -0800
Message-ID: <CAKwvOd=HNuB8bqJvXEjvYWorika99QX=jKSfHy2hf0NOKrrc8w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols in
 assembly files
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Aditya <yashsri421@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        dwaipayanray1@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:43 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-01-20 at 18:23 +0530, Aditya wrote:
> > On 20/1/21 2:51 pm, Joe Perches wrote:
> > > On Wed, 2021-01-20 at 12:55 +0530, Aditya Srivastava wrote:
> > > > Local symbols prefixed with '.L' do not emit symbol table entries, as
> > > > they have special meaning for the assembler.
> > > >
> > > > '.L' prefixed symbols can be used within a code region, but should be
> > > > avoided for denoting a range of code via 'SYM_*_START/END' annotations.
> > > >
> > > > Add a new check to emit a warning on finding the usage of '.L' symbols
> > > > in '.S' files, if it lies within SYM_*_START/END annotation pair.
> > >
> > > I believe this needs a test for $file as it won't work well on
> > > patches as the SYM_*_START/END may not be in the patch context.
> > >
> > Okay.
> >
> > > Also, is this supposed to work for local labels like '.L<foo>:'?
> > > I don't think a warning should be generated for those.
> > >
> > Yes, currently it will generate warning for all symbols which start
> > with .L and have non- white character symbol following it, if it is
> > lying within SYM_*_START/END annotation pair.
> >
> > Should I reduce the check to \.L_\S+ instead? (please note "_"
> > following ".L")
>
> Use grep first.  That would still match several existing labels.
>
> > Pardon me, I'm not good with assembly :/
>
> Spending time reading docs can help with that.
>
> Mark?  Can you please comment about the below?
>
> I believe the test should be:
>
>         if ($realfile =~ /\.S$/ &&
>             $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
>                 WARN(...);
>         }
>
> so that only this code currently matches:
>
> $ git grep -P '^\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L' -- '*.S'
> arch/x86/boot/compressed/head_32.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> arch/x86/boot/compressed/head_32.S:SYM_FUNC_END(.Lrelocated)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lrelocated)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lpaging_enabled)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lno_longmode)
> arch/x86/boot/pmjump.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
> arch/x86/boot/pmjump.S:SYM_FUNC_END(.Lin_pm32)
> arch/x86/entry/entry_64.S:SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
> arch/x86/entry/entry_64.S:SYM_CODE_END(.Lbad_gs)
> arch/x86/lib/copy_user_64.S:SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> arch/x86/lib/copy_user_64.S:SYM_CODE_END(.Lcopy_user_handle_tail)
> arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
> arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_clac)
> arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
> arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_8_clac)
> arch/x86/lib/putuser.S:SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
> arch/x86/lib/putuser.S:SYM_CODE_END(.Lbad_put_user_clac)
> arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_START_LOCAL(.Lwakeup_idt)
> arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_END(.Lwakeup_idt)

Josh, I assume objtool does not annotate code under:
arch/x86/boot/
arch/x86/entry/
arch/x86/realmode/
?

The rest, ie
arch/x86/lib/
seem potentially relevant?
-- 
Thanks,
~Nick Desaulniers
