Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E298D275475
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWJZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIWJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:25:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD45EC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:25:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so22120326qkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elg0wH+6sMQCekNWlDCJHXKeUDnzoRr2E8YDp7Z6TBY=;
        b=FSw7j7LMuIMumMry8IHTk67bV7xlIBLO63QFS3h3Ny0QdqhDS4+3UPmkUZhS3o6x2u
         d9RbtHOCV11fclnkZV60uadtuzWQ2GpsWuPQdsIvnL6Ah2MZu/jNIGqwdo8myOaEGluq
         7tVEKQhjlrwDHQkDxM1wb89TXEBmGcMb63KEuXrWVFANeF7WfNSHVLlqLbPRx1+SheZ3
         QafG4iOsE+RC3y8CvI228r6KVHYubg6S2lOsZ0c8MBjEe/rYqUhQdbQp4edhxwyZQ36k
         iDjj1lOL6vAIiCqry5X9ixu/ukWyVjeWniH3qZta79ltGDJ1WTQ1iFLrzpS2E+exJqul
         EMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elg0wH+6sMQCekNWlDCJHXKeUDnzoRr2E8YDp7Z6TBY=;
        b=EOIwob3FHIztODW7A5I/YwJhViqkbOq+Qi+9x5UV32dAMgMjnCFBB7AIZ8/lx1jC+Y
         Di8dg+lATVZFlB6bA04B7/GUrgGDUP/EVSszFYxlBeeIXmj8k32HDTRlNHv1ln6zuIi1
         EBDD9fORZd4DHNV9uLshWUGuhZKEFqR+cD/WnrexEPZ8JrL4NKo5JLRFR9nPM6Bz7QtF
         Ayidss7EUatsZN4DtLT66HttqVOMgF6IlTtBqpi6oCG0lK1XXEEN9otW6AwPab0kK4EG
         d38XuoL3XeQi2ygmcf3JsW+HQOymXuL33t3LmYceOKcNe+7ndPuQymwln82DteeK845l
         UMNA==
X-Gm-Message-State: AOAM530mnH7MgINLqxUHPETKK+x5cHvXS5OqjnZj/OJpThZwWEwXBC6u
        SsvbWIBEebWnxnzrxApCHym3BQQCOMbdehaXcw7KMg==
X-Google-Smtp-Source: ABdhPJz4XvVM2iguquzjpe0KfCxvbY4E4m/J7Ivq1psqXwziKKLzijNXsIBRrryXo11h7vm+R9mdwM2CYtgRnsCOUOU=
X-Received: by 2002:a37:54a:: with SMTP id 71mr8199361qkf.407.1600853099325;
 Wed, 23 Sep 2020 02:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic> <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic>
In-Reply-To: <20200923090336.GD28545@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Sep 2020 11:24:48 +0200
Message-ID: <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:03 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 22, 2020 at 11:56:04AM -0700, Nick Desaulniers wrote:
> > So I think there's an issue with "deterministically reproducible."
> > The syzcaller report has:
> > > > Unfortunately, I don't have any reproducer for this issue yet.
>
> Yeah, Dmitry gave two other links of similar reports, the first one
> works for me:
>
> https://syzkaller.appspot.com/bug?extid=1dccfcb049726389379c
>
> and that one doesn't have a reproducer either. The bytes look familiar
> though:
>
> Code: c1 e8 03 42 80 3c 20 00 74 05 e8 79 7a a7 00 49 8b 47 10 48 89 05 f6 d8 ef 09 49 8d 7f 08 48 89 f8 48 c1 e8 03 42 80 3c 00 00 <00> 00 e8 57 7a a7 00 49 8b 47 08 48 89 05 dc d8 ef 09 49 8d 7f 18
> All code
> ========
>    0:   c1 e8 03                shr    $0x3,%eax
>    3:   42 80 3c 20 00          cmpb   $0x0,(%rax,%r12,1)
>    8:   74 05                   je     0xf
>    a:   e8 79 7a a7 00          callq  0xa77a88
>    f:   49 8b 47 10             mov    0x10(%r15),%rax
>   13:   48 89 05 f6 d8 ef 09    mov    %rax,0x9efd8f6(%rip)        # 0x9efd910
>   1a:   49 8d 7f 08             lea    0x8(%r15),%rdi
>   1e:   48 89 f8                mov    %rdi,%rax
>   21:   48 c1 e8 03             shr    $0x3,%rax
>   25:   42 80 3c 00 00          cmpb   $0x0,(%rax,%r8,1)
>   2a:*  00 00                   add    %al,(%rax)               <-- trapping instruction
>   2c:   e8 57 7a a7 00          callq  0xa77a88
>   31:   49 8b 47 08             mov    0x8(%r15),%rax
>   35:   48 89 05 dc d8 ef 09    mov    %rax,0x9efd8dc(%rip)        # 0x9efd918
>   3c:   49 8d 7f 18             lea    0x18(%r15),%rdi
>
> 4 zero bytes again. And that .config has kasan stuff enabled too so
> could the failure be related to having kasan stuff enabled and it
> messing up offsets?
>
> That is, provided this is the mechanism how it would happen. We still
> don't know what and when wrote those zeroes in there. Not having a
> reproducer is nasty but looking at those reports above and if I'm
> reading this correctly, rIP points to
>
> RIP: 0010:update_pvclock_gtod arch/x86/kvm/x86.c:1743 [inline]
>
> each time and the URL says they're 9 crashes total. And each have
> happened at that rIP. So all we'd need is set a watchpoint when that
> address is being written and dump stuff.
>
> Dmitry, can the syzkaller do debugging stuff like that?

syzbot does not have direct support for such things.
It uses CONFIG_DEBUG_AID_FOR_SYZBOT=y:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches
But that's generally useful for linux-next only and the clang build is
on the upstream tree...

Options I see:
1. Add stricter debug checks for code that overwrites code. Then maybe
we can catch it red handed.
2. Setup clang instance on linux-next
3. Run syzkaller locally with custom patches.


> > Following my hypothesis about having a bad address calculation; the
> > tricky part is I'd need to look through the relocations and try to see
> > if any could resolve to the address that was accidentally modified.  I
> > suspect objtool could be leveraged for that;
>
> If you can find this at compile time...
>
> > maybe it could check whether each `struct jump_entry`'s `target`
> > member referred to either a NOP or a CMP, and error otherwise? (Do we
> > have other non-NOP or CMP targets? IDK)
>
> Follow jump_label_transform() - it does verify what it is going to
> patch. And while I'm looking at this, I realize that the jump labels
> patch 5 bytes but the above zeroes are 4 bytes. In the other opcode
> bytes I decoded it is 4 bytes too. So this might not be caused by the
> jump labels patching...
>
> > This hypothesis might also be incorrect, and thus would be chasing a
> > red herring...not really sure how else to pursue debugging this.
>
> Yeah, this one is tricky to debug.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
