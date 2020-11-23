Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13F32C17A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgKWVZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKWVZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:25:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A97C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 13:25:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606166724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTdlVvBzV3X2SG+m6YMVXF6nkX8krtH6dkjkxUwZQiI=;
        b=tV3mvNn5VOSOSSOSh7rd2+BkGQupxGyTIae5Huj5qkYERwvHsr9wwdxb3jF+CZKlfv8u6D
        Xb4Wazs9s/Ip5RGlMxFqvqwoTkCi2EUW9vaf18T7DAQ05woNPX5zvPQjri+xrAMw61NoVN
        03gMP34yzQocgadp7XCMj1hVoD/wu1FsYF9T36dTvH3JNhj5KugNUIy0m8oBUs+Y5vzmh3
        EmTOJu0qeYQdfV168bVT/yxZkgQqDeSAFRZoA4ASsvyNq1J9VGcvPFEEcW4AtsDbOlH1iV
        +S/XahVOkFfP0GF0hg+r1tQjEco5I4aF3vXZgiQbMwhuzTSYXul6IAC/Fi7vCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606166724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTdlVvBzV3X2SG+m6YMVXF6nkX8krtH6dkjkxUwZQiI=;
        b=Jy9SH6vPX9Nh5MsIwQRQ0leykfm4dF6xZwKpAQHhnLTyqfYcQIdSc2a1e/yCvwOGRDF7SZ
        GwO0NwtwLoui1cDg==
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <87mtz7n5ae.fsf@nanos.tec.linutronix.de>
References: <20201118194838.753436396@linutronix.de> <20201118204007.269943012@linutronix.de> <20201119093834.GH3306@suse.de> <20201119111411.GL3121378@hirez.programming.kicks-ass.net> <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com> <20201119182843.GA2414@hirez.programming.kicks-ass.net> <87tutkolq1.fsf@nanos.tec.linutronix.de> <20201120092928.GA3021@hirez.programming.kicks-ass.net> <CALCETrWHzHXLKuD4JWxDyBULAuFivP55csFp=6feireZhianVw@mail.gmail.com> <87mtz7n5ae.fsf@nanos.tec.linutronix.de>
Date:   Mon, 23 Nov 2020 22:25:24 +0100
Message-ID: <87h7pfn4u3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23 2020 at 22:15, Thomas Gleixner wrote:
> On Sun, Nov 22 2020 at 15:16, Andy Lutomirski wrote:
>> On Fri, Nov 20, 2020 at 1:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> The common case of a CPU switching back and forth between a small
>> number of mms would have no significant overhead.
>
> For CPUs which do not support PCID this sucks, which is everything pre
> Westmere and all of 32bit. Yes, 32bit. If we go there then 32bit has to
> bite the bullet and use the very same mechanism. Not that I care much
> TBH.

Bah, I completely forgot that AMD does not support PCID before Zen3
which is a major showstopper.

Thanks,

        tglx
