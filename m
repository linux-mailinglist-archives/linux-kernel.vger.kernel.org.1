Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06D826B71E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgIPARe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgIOOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600179722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7tOUCbvchEF23vGuX1y5hjmJAc/2g8w+mpy7mOTMKU=;
        b=Rdly8DqrNRel/s4B8OdXVQ+rxQaewC5NX970R3g8IsPpgzKFgu3byMHT3z/upfUY/CGk96
        LLP/6Wj74HzSZBs5JB6XESeMSEH972nQNGXJW9igg534B4//I96zTnQ4F7zU+bBSWAtLry
        Ju0HcfiJTlG+87NkyXwZb7ShgZ4qVPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-2D9_a9TsM9ieYkje_BxIsg-1; Tue, 15 Sep 2020 10:19:20 -0400
X-MC-Unique: 2D9_a9TsM9ieYkje_BxIsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A95E801FDA;
        Tue, 15 Sep 2020 14:19:18 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E155C1CF;
        Tue, 15 Sep 2020 14:19:15 +0000 (UTC)
Date:   Tue, 15 Sep 2020 09:19:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com>,
        alexandre.chartre@oracle.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING: can't access registers at
 asm_sysvec_call_function_single
Message-ID: <20200915141913.qmuupewr2wqrko35@treble>
References: <0000000000002b02cf05aed302f3@google.com>
 <87lfhdpeum.fsf@nanos.tec.linutronix.de>
 <20200914164927.t476jnlkmdibgqvn@treble>
 <20200914165113.l5iloshztgykyqxy@treble>
 <CACT4Y+b_NJ5x=Xi=gtChTdnp94hdG2BZgFCN1KbHOasF_xduDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+b_NJ5x=Xi=gtChTdnp94hdG2BZgFCN1KbHOasF_xduDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:27:25AM +0200, Dmitry Vyukov wrote:
> On Mon, Sep 14, 2020 at 6:51 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > > On Tue, Sep 08 2020 at 13:16, syzbot wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    f4d51dff Linux 5.9-rc4
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1455d4f9900000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=bc9dbf05dcc151e9b972
> > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com
> > > > >
> > > > > WARNING: can't access registers at asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:589
> > > >
> > > > That's the ORC unwinder complaining, but I have no idea why...
> > >
> > > 0000000000000cd0 <asm_sysvec_call_function_single>:
> > >      cd0:     90                      nop
> > >      cd1:     90                      nop
> > >      cd2:     90                      nop
> > >      cd3:     6a ff                   pushq  $0xffffffffffffffff
> > >      cd5:     e8 b6 03 00 00          callq  1090 <error_entry>
> > >      cda:     48 89 e7                mov    %rsp,%rdi
> > >      cdd:     e8 00 00 00 00          callq  ce2 <asm_sysvec_call_function_single+0x12>
> > >                       cde: R_X86_64_PLT32     sysvec_call_function_single-0x4
> > >      ce2:     e9 69 04 00 00          jmpq   1150 <error_return>
> > >      ce7:     66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
> > >      cee:     00 00
> > >
> > > This is a head scratcher.  The ORC data looks ok, at least when I build
> > > it on my system.  It's expecting to find pt_regs at the top of the stack
> > > after returning from sysvec_call_function_single().  But it can't
> > > dereference the regs for some reason.
> > >
> > > So either it's a bug in ORC data or unwinder (not likely) or the stack
> > > pointer got corrupted somehow (also seems unlikely)...
> >
> > The true bug may be revealed elsewhere on the stack... I probably need
> > to start enabling ORC stack dumps like I did for FP.
> 
> Hi Josh,
> 
> Is there a config for this? We could enable it on syzbot. More
> informative kernel diagnostics are always better.

Unfortunately the ORC dump code doesn't exist upstream yet.  I need to
dust the patches off and post.

-- 
Josh

