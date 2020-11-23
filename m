Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1F2C194C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgKWXK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgKWXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:10:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C04C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:10:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606173054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvfZCOaArWd6c+q0YW2bhXL6hYZ7OClqLqH43z5poDk=;
        b=Cs0+t6uySmiG6i3CC8Sh8UzLfR3Ie89erQx3laofZXPEEuvQPYVgMgT58WCQ7VryekKX+3
        sVUo9qBnmkAl70jGXswpsgEApH7KAnu9cL5bcvDn958xgW7NGO0X+Y/qmY9aUqhE3csivm
        C8uduK9PWizAyYSTpSuc4XDxGyfvJ0Dpvipqw8Bk3R3RIFqvy2Z5yB7faB2id5uG6ipLxY
        lAdpStaUivqtOWZSxh9OcMpnL6C6kksFiJxb/jPhuWCNUMFMowHqwByJsj2FGttfKFf1RM
        bpFIUCy7xHP7M2o6stWqM10tRyWKOKa9yvN245YbQ5+rHgvZ7ihIzKQqz8bh6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606173054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvfZCOaArWd6c+q0YW2bhXL6hYZ7OClqLqH43z5poDk=;
        b=0ChmFgQedEpgUd652A2O7mrsWb531cnBzuTZLDyu6Am6xRBW0nZ+tAsCrwrMj1X29dc9jK
        9lZwxXH9EufQ/FCA==
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent of RT
In-Reply-To: <9BAD6F21-4DB5-4277-A38D-BB1FA038F2D7@amacapital.net>
References: <87h7pfn4u3.fsf@nanos.tec.linutronix.de> <9BAD6F21-4DB5-4277-A38D-BB1FA038F2D7@amacapital.net>
Date:   Tue, 24 Nov 2020 00:10:54 +0100
Message-ID: <87zh37lldt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23 2020 at 14:07, Andy Lutomirski wrote:
>> On Nov 23, 2020, at 1:25 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> =EF=BB=BFOn Mon, Nov 23 2020 at 22:15, Thomas Gleixner wrote:
>>>> On Sun, Nov 22 2020 at 15:16, Andy Lutomirski wrote:
>>>>
>>>> The common case of a CPU switching back and forth between a small
>>>> number of mms would have no significant overhead.
>>>=20
>>> For CPUs which do not support PCID this sucks, which is everything pre
>>> Westmere and all of 32bit. Yes, 32bit. If we go there then 32bit has to
>>> bite the bullet and use the very same mechanism. Not that I care much
>>> TBH.
>>=20
>> Bah, I completely forgot that AMD does not support PCID before Zen3
>> which is a major showstopper.
>
> Why?  Couldn=E2=80=99t we rig up the code so we still track all the ASIDs=
 even
> if there is no CPU support?  We would take the TLB flush hit on every
> context switch, but we pay that cost anyway. We would avoid the extra
> copy in the same cases in which we would avoid it if we had PCID.

Did not think about that indeed. Yes, that should do the trick and
should not be worse than what we have now.

Sometimes one just can't see the forest for the trees :)

Thanks,

        tglx
