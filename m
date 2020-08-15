Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58108245047
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 02:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHOA1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 20:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHOA1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 20:27:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5104C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:27:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so5161338pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eA5hkX4xNHxWO40Nw1BpR0B/AOSewL7fvL2/Um1m3Y0=;
        b=M/ugSCNeEw1bgnvQXIIfjgjhi0yKsyi9jT4UmSnxjC0YgCw2XN9gnkTrvUhKfdDvvt
         UqV/mq8EYHdbAlcwp2ycvJ1gKqShE72oxGG0f62cW1STt8tBl+PAjDwEbwPstSbcV/MK
         O6n+A6fnH9WIgV/k/AXSx8QlUR9kA15fpjjuIdqgrvPXrtCfCPRe9b5eHgzptdUuEGmz
         cxwVZsUUPQ0yJnpwuUPJjTc6GPJB5jC6SRy3ZuU4/TsyQmlAU4/i4BiWYseLnHq2r7b/
         db1rIiLrUaR8vKPVt1iwoCFIu1dsWQIgXUZHyl7AQuSdhPV9OCyuN4HMz9ahuUVtFbnM
         jQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eA5hkX4xNHxWO40Nw1BpR0B/AOSewL7fvL2/Um1m3Y0=;
        b=uOinVPYjXn82SbzOAct+qLVC0HYacmX4Wi/fbQ+dlpV6yCWmNJVIh9PQZ3V0UFRd9s
         pttBRey3xMWWArzKUfusHNsT+JEyz9zuHpDq3EUm95BBmj7ZMGh53XZKqc9uNqPSvStb
         MBmUCcW07FZkpRxck/bS7dRfOOkhWb4N7gxnTGzLIkpg00CkRSHSXChU3T2twa1kWCTD
         yiGDNVV//m0K0VcSMMeOcP6CwM3GeNx3ZpB/hYbLfM/dADTY4UlFE1sCxcNImQ6VpM88
         YXAzjciF0BrSwBrAFZCsGXgMgmlcJUUzlXDrXX/V+fEootTTDCmer9b8D2Omf5vv/2eZ
         s9sw==
X-Gm-Message-State: AOAM533vLPPREUtZq3QQ44n19413o9ITD/8dFab+Eazi3vGay11H2d5s
        /1/1K3IqA7tnKgTEYPNwO3hHhMnO8AmUTqAi8DynIQ==
X-Google-Smtp-Source: ABdhPJxdy4O7cKwu/Cvva3uOWGTlVbJ6L9UubBasY66c4GLooGqAmS0ND8ujhqMASQvYzOWUVc/CEXscWWeZgl1pam0=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr4260629pjb.101.1597451227000;
 Fri, 14 Aug 2020 17:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
 <CA+icZUUjtu3fCNTngY52h3uRL+eUaimNJb0UNwj5v-QwKggs5A@mail.gmail.com>
 <CA+icZUWH5f4B_6eYy2_OOi45VjUkE_kN9akqvcOxxmmmM3TSrg@mail.gmail.com> <CAKwvOdnj6ObdpsdVYkDxWp-dVTTg=xMkBm84y419SNtLuAqfMg@mail.gmail.com>
In-Reply-To: <CAKwvOdnj6ObdpsdVYkDxWp-dVTTg=xMkBm84y419SNtLuAqfMg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 17:26:55 -0700
Message-ID: <CAKwvOdnahyqQQMdWhzpaYkJNi21Ux=8qyBmRnPidiT_RAn0YFw@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 3:57 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Aug 14, 2020 at 2:19 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Aug 14, 2020 at 7:29 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > Thanks for the proposal.
> > >
> > > I have adapted it to fit my patchset against Linux v5.8.
> > >
> > > Both Debian's GCC-10 and a snapshot version of LLVM toolchain
> > > v11.0.0-rc1+ seems to be OK.
> > >
> >
> > Yupp, OK.
> >
> > I was able to boot FreeDOS 1.2 VM in VirtualBox GUI.
>
> Hi Sedat,
> Apologies, but it's not clear to me precisely which patch you tested.
> Can you please confirm whether you tested:
> 1. Arnd's patch that started this thread.
> 2. My proposed diff adding -fno-addrsig to CFLAGS_powernow-k6.o.
> 3. My proposed diff removing __force_order from the kernel.
>
> I'm hoping you were referring to testing 3., but it's not clear to me.

Ah, sorry, I missed your comment on github:
https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674282107

Ok, I will look at more disassembly next week and hopefully have a
patch ready, with your tested by tag.

-- 
Thanks,
~Nick Desaulniers
