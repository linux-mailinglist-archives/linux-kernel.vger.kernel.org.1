Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF28026965B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgINUYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:24:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgINUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:23:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600114979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0wfLZ0uYBLfAv6Tql/b2JqWp+4rVtLisrjtqK8ycp4=;
        b=3c8skZ59/xzAZZZp4Z+4ovwLPez/sz6q0DBzv6UMDN/DlDIoE+fRGmGlTzzgqa2rboXGRd
        kKSVAj5iZ5CAlIdiIkQWLVqOSlt4kJb4Alend5up+cyKKPfsXm7Am0cywiR+fqOaVrCqSX
        CRkUUuL8V3bk2Rakj/e5AaXGVCwN+26Eu/nyl2X2hOjXUdGeKWBbG8C/HfS7HHcwm5TD6i
        DI2+jUCaYNKM/XmDyaQovGgzjoy43OyqD6rm1/qFtgb+FcqN4fILUTRVN43BsVtm1JfWE+
        IA0DJxuUBS0Nyv06qLU+t68uGxIFCLa/7cn3xJ4HS7J70wI4nlLHeGTH+7IKMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600114979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0wfLZ0uYBLfAv6Tql/b2JqWp+4rVtLisrjtqK8ycp4=;
        b=U2fMCUyQntR2d4BUcbWISYNvXjgqMmN5EdqANELCzmmxUE0BASxc0DX3BdoywLRG+A4fZl
        ocGojm8RQivNPuAQ==
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in syscall_exit_to_user_mode
In-Reply-To: <202009141304.811BAC4A0@keescook>
References: <00000000000018a47605af074c7d@google.com> <202009121050.0D9CAB95@keescook> <87sgblpi4l.fsf@nanos.tec.linutronix.de> <202009141304.811BAC4A0@keescook>
Date:   Mon, 14 Sep 2020 22:22:59 +0200
Message-ID: <87a6xsp0po.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14 2020 at 13:06, Kees Cook wrote:
> On Sun, Sep 13, 2020 at 09:54:34PM +0200, Thomas Gleixner wrote:
>> On Sat, Sep 12 2020 at 10:52, Kees Cook wrote:
>> >> ------------[ cut here ]------------
>> >> syscall 56 left IRQs disabled
>> >
>> > This WARN appears reachable. :)
>> 
>> The above is hardly a problem of the new entry code. It's just detecting
>> the wreckage...
>
> Oh, well that's actually even better! :)

Of course I can't reproduce here ...

>> > I also see on the dashboard these other problems with the new entry
>> > code:
>> 
>> > https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47
>>
>> This one is also just the messenger. That's the
>> 
>>      lockdep_assert_irqs_disabled();
>> 
>> in irqentry_exit() if I'm reading the reports correctly. That's a #PF
>> returning with interrupts enabled for whatever weird reason. Let me
>> stare at that...
>
> Cool; thanks.

No idea so far.

>> > https://syzkaller.appspot.com/bug?extid=c4af95386364bc59b13e
>> 
>> This one is not a new entry code problem either:
>> [...]
>> The new entry code is just in the stack trace because that task was
>> preempted after a timer interrupt.
>
> This seems a bit like the first issue: it's just getting noticed now?

IIRC, I've seen such reports on older kernels as well, but not with the
new entry code in the traces.

Thanks,

        tglx
