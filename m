Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC317241AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgHKMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbgHKMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:05:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35156C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:05:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597147513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dK8WotNUMQfxKOXF2AcU6HDIE1VmkJ89HicTROKHMo=;
        b=mvVp9Vol15NrOMBy1pOO9HLG4HsFrbYsf3ARXETIr4zrdsOqiDYATiUZkluYMGgqNdeLt2
        LahmEMEEFl3KWxB8FhNyshFsOCJZsM++I7I5WFPQPbT/DOn51RoI5lXBGAFIstn9V0VXHZ
        nuoIGiy7RvD9rLFw8a2qsZDYYcY2vXned40evQYhb6XeDLQ3m3o12E/0CBU9gsjuk8lyiD
        4h5+Bt0IOgwgddhhray4vufb42rj6zcMbq+MjZsmezdPaMDlA1WMG9kkcmQdrFwzUYHBjA
        MzBiUOEAwtAXcW8aCoYoRCj6xuZ/rvfNHgqyrZ+THcqt0b+XdEi0EGUc86xnyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597147513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dK8WotNUMQfxKOXF2AcU6HDIE1VmkJ89HicTROKHMo=;
        b=nXG5qTaYy1OOViAbbTSHHHexYsZzlHPXAXraJ7gk+05OyrnRF3CMuQXgK2oSuQJIKWNq3x
        6woX2fWJ6PFjpaDw==
To:     Petr Mladek <pmladek@suse.com>, Orson Zhai <orsonzhai@gmail.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and real
In-Reply-To: <20200811094413.GA12903@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com> <20200811094413.GA12903@alley>
Date:   Tue, 11 Aug 2020 14:05:12 +0200
Message-ID: <87zh7175hj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:
> On Tue 2020-08-11 12:40:22, Orson Zhai wrote:
>> This is an updated version which comes from patch [1] written by Thomas
>> and suggestion [2] about VMCORE_INFO given by Linus.

All of that want's to be properly distangled into seperate patches.
 
>> This patch has been tested in qemu-x86-system. One problem is the timestamp
>> in kernel log will be printed [    0.000000] for longer time than before. 
>
> This would be a regression. People put huge effort into having early boot
> timestamps, see
> https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com/
> Adding some active people from this patchset into CC.
>
> I wonder if we could have these early timestamps also in the mono
> clock.

Not really. timekeeping init happens way after the early TSC (or
whatever clock) is registered as sched_clock(). And there is no
realistic way to move timekeeping init earlier.

What we could do instead is to utilize sched_clock() up to the point
where timekeeping becomes available and ensure that monotonic time is
not jumping backwards vs. sched_clock() when switching over. For this
early boot phase, clock realtime timestamps would be invalid of course
and they can stay invalid even after timekeeping is initialized on
systems where the RTC is not available in the early boot process.

> At least "crash" tool would need an update anyway. AFAIK, it checks
> the size of struct printk_log and refuses to read it when it changes.
>
> It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> needed because we would need to update the crashdump-related tools anyway.
>
> Well, the timing is good. We are about to switch the printk ring
> buffer into a lockless one. It requires updating the crashdump tools
> as well. We could do this at the same time. The lockless ring buffer
> already is in linux-next. It is aimed for 5.10 or 5.11.
...
> It would be great to synchronize all these changes changes of the
> printk log buffer structures.

I agree that having one update is a good thing, but pretty please can we
finally make progress with this and not create yet another dependency?

Thanks,

        tglx
