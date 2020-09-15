Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84427269D76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgIOE1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 00:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOE1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 00:27:38 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 21:27:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y11so2208023qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9TLWvjLEgk7IiR9iMV2UUcOkQ+5AWB3T7KBIvwdPwc=;
        b=Gyc6nvikoqzEZ9Kt2nE/WpMon2HotrzvQIiCimjgylT+u4GtA2Tcu4tkTIMssJ20PW
         uRQWZ9eq1uBFc2sGPACFM8rntj1KBJYAOdwViIllZqTtHlgTgWziHQePRu4vx1NOItWg
         yP+KhDfY09dow7boz4qmVEIuMDeM1GwDZV0zzbYpMLI6m/T3BHD/I0X/zidUJTlB1JKX
         gCeBjPBnrDj8AlfUwXqUOmAoGjATHEcUY1ttx7Rd+QK37qujPGn+7E54dTh+BpITqMdb
         6Xd+lVCETA5VjNS1bM19xPkPw2SXPoQZFrS1Hl/q/kox/lBpUhus6qKT7N18KQ/5ZBjZ
         2caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9TLWvjLEgk7IiR9iMV2UUcOkQ+5AWB3T7KBIvwdPwc=;
        b=aoa6PsHyv/67SfouVtwvipIJuY36volqlvYb6yNVPbwHmY0SO9sMEq/qrXJR0W8CR5
         rNkDDuKK2CQ3vcMSO8cQF7FYCGvAYGmWcsIQrYKUaX/tpD4GnuNI5+YK+4ox0Asxje5c
         ZbmiqxMR4I++HhsiVxbGvRSxwhN7NyVepaJTkaSvEEukvc6jLBN0R8wmXINc1rTad6Tg
         wzHmlxOOvC1b+TtatDQiBNTDgxKY7xZcn3TNGqITTz2GAG0DA4qWeFa8KhNDm+RwPpyk
         4nl7mJjW8jbEj1O4/DVa66v+KTBHwixmBMN8/P31Lrb0cwW5jQhMcLzqM/rZmb0a91pg
         tNwQ==
X-Gm-Message-State: AOAM531WtsfdQk1Y31Jy9Eef5L8f3wuDB9n57vvulDxWDKe8MUGbtS2z
        NDVgDvHn3T2Vv/RKV1dF5XBQH5GAPPTLh7/WFMI1hA==
X-Google-Smtp-Source: ABdhPJwGjN7ZRO2U6kfHA6sbdLjiWpTp908o8jUqvdC8CSaM0i1xs8ghPcbF5yZwiajrXC9AubCCrIoefvtN7gL2zSU=
X-Received: by 2002:aed:26a7:: with SMTP id q36mr16117369qtd.57.1600144056595;
 Mon, 14 Sep 2020 21:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b02cf05aed302f3@google.com> <87lfhdpeum.fsf@nanos.tec.linutronix.de>
 <20200914164927.t476jnlkmdibgqvn@treble> <20200914165113.l5iloshztgykyqxy@treble>
In-Reply-To: <20200914165113.l5iloshztgykyqxy@treble>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Sep 2020 06:27:25 +0200
Message-ID: <CACT4Y+b_NJ5x=Xi=gtChTdnp94hdG2BZgFCN1KbHOasF_xduDQ@mail.gmail.com>
Subject: Re: WARNING: can't access registers at asm_sysvec_call_function_single
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com>,
        alexandre.chartre@oracle.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:51 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > On Tue, Sep 08 2020 at 13:16, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    f4d51dff Linux 5.9-rc4
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1455d4f9900000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=bc9dbf05dcc151e9b972
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com
> > > >
> > > > WARNING: can't access registers at asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:589
> > >
> > > That's the ORC unwinder complaining, but I have no idea why...
> >
> > 0000000000000cd0 <asm_sysvec_call_function_single>:
> >      cd0:     90                      nop
> >      cd1:     90                      nop
> >      cd2:     90                      nop
> >      cd3:     6a ff                   pushq  $0xffffffffffffffff
> >      cd5:     e8 b6 03 00 00          callq  1090 <error_entry>
> >      cda:     48 89 e7                mov    %rsp,%rdi
> >      cdd:     e8 00 00 00 00          callq  ce2 <asm_sysvec_call_function_single+0x12>
> >                       cde: R_X86_64_PLT32     sysvec_call_function_single-0x4
> >      ce2:     e9 69 04 00 00          jmpq   1150 <error_return>
> >      ce7:     66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
> >      cee:     00 00
> >
> > This is a head scratcher.  The ORC data looks ok, at least when I build
> > it on my system.  It's expecting to find pt_regs at the top of the stack
> > after returning from sysvec_call_function_single().  But it can't
> > dereference the regs for some reason.
> >
> > So either it's a bug in ORC data or unwinder (not likely) or the stack
> > pointer got corrupted somehow (also seems unlikely)...
>
> The true bug may be revealed elsewhere on the stack... I probably need
> to start enabling ORC stack dumps like I did for FP.

Hi Josh,

Is there a config for this? We could enable it on syzbot. More
informative kernel diagnostics are always better.
