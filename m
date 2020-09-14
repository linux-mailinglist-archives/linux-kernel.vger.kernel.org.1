Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78F269233
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgINQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:55:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726172AbgINQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600102176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mbvYuND3lRjyeQVUwoOKkvygq3qV13+cH0GnP7z9uA=;
        b=dndrQIoMPV5FZKBkE7c1JYpSC8VYIWTu9kM3apPuIgWQQghsj993bgP1Dyn7xHCJWDAWyz
        USVN5xET7Sv0EIG7bpuvBW9l4QfSC87EAlph2RrlejBgVyrntum4dY3udBPJNUUYMI3ARS
        JOdPQo/+1tuFz32GYznMbVS5K5/6vO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-hsI6WwqjPLqpr6ELOWLFww-1; Mon, 14 Sep 2020 12:49:32 -0400
X-MC-Unique: hsI6WwqjPLqpr6ELOWLFww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C72D018B9F01;
        Mon, 14 Sep 2020 16:49:30 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 425267512A;
        Mon, 14 Sep 2020 16:49:29 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:49:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com>,
        alexandre.chartre@oracle.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at
 asm_sysvec_call_function_single
Message-ID: <20200914164927.t476jnlkmdibgqvn@treble>
References: <0000000000002b02cf05aed302f3@google.com>
 <87lfhdpeum.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lfhdpeum.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:05:21PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 08 2020 at 13:16, syzbot wrote:
> 
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f4d51dff Linux 5.9-rc4
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1455d4f9900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=bc9dbf05dcc151e9b972
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com
> >
> > WARNING: can't access registers at asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:589
> 
> That's the ORC unwinder complaining, but I have no idea why...

0000000000000cd0 <asm_sysvec_call_function_single>:
     cd0:	90                   	nop
     cd1:	90                   	nop
     cd2:	90                   	nop
     cd3:	6a ff                	pushq  $0xffffffffffffffff
     cd5:	e8 b6 03 00 00       	callq  1090 <error_entry>
     cda:	48 89 e7             	mov    %rsp,%rdi
     cdd:	e8 00 00 00 00       	callq  ce2 <asm_sysvec_call_function_single+0x12>
			cde: R_X86_64_PLT32	sysvec_call_function_single-0x4
     ce2:	e9 69 04 00 00       	jmpq   1150 <error_return>
     ce7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     cee:	00 00

This is a head scratcher.  The ORC data looks ok, at least when I build
it on my system.  It's expecting to find pt_regs at the top of the stack
after returning from sysvec_call_function_single().  But it can't
dereference the regs for some reason.

So either it's a bug in ORC data or unwinder (not likely) or the stack
pointer got corrupted somehow (also seems unlikely)...

-- 
Josh

