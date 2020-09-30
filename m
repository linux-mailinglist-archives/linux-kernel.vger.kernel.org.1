Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BA27F0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgI3SBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:01:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58406 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:01:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601488860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KADJNPeYkWLc4rv8X/2/vXEWW8tE11yqvvL4qWKRvO8=;
        b=BSjiTsAgr+uTzss3nQXMZ+WzxJYsoCjd6YJEo8+xvOIl7XdjUXzTvmGbjOLvYZcT+6arAR
        bJOzE2yj9g3n097eYG1TmM8NB2j1y4n1sp/xXHnJAw+TESsWNjKpAh9NZSnQxwkVBjHjOB
        wmS4f9pn0v5sBloT4w3uo9Ms0udYEkzdqOtQSdz0y2MjLy0OztbnGMrJdb2MLnuWMpKErO
        3l7hlmT+MGU7JnMF0jysY9qApxFFxEW3GaKP5jltOZQrgFAYAZSgXqEB+rQ39nxHFMYTgY
        VXFzpCi5FrhidMchzrPCW1WA7+FMwgqdnk60cla9EOCVQPkFdf4h1TcUU8aPjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601488860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KADJNPeYkWLc4rv8X/2/vXEWW8tE11yqvvL4qWKRvO8=;
        b=HhBebLGR2jX8C8/UN9xgaqH89dGt3AM7CL3hc1jCQ41H/WBZb4VQQITKHcDUSb/mr4hq9r
        nEB3HQNeHsUSrPBg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <sblbir@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars in enable_l1d_flush_for_task()
In-Reply-To: <20200930170316.GB2628@hirez.programming.kicks-ass.net>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com> <20200929071211.GJ2628@hirez.programming.kicks-ass.net> <20200929083709.GC2651@hirez.programming.kicks-ass.net> <87eemji887.fsf@nanos.tec.linutronix.de> <20200930170316.GB2628@hirez.programming.kicks-ass.net>
Date:   Wed, 30 Sep 2020 20:00:59 +0200
Message-ID: <87blhni1pg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30 2020 at 19:03, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 05:40:08PM +0200, Thomas Gleixner wrote:
> Also, that preempt_disable() in there doesn't actually do anything.
> Worse, preempt_disable(); for_each_cpu(); is an anti-pattern. It mixes
> static_cpu_has() and boot_cpu_has() in the same bloody condition and has
> a pointless ret variable.

I absolutely agree and I really missed it when looking at it before
merging. cpus_read_lock()/unlock() is the right thing to do if at all.

> It's shoddy code, that only works if you align the planets right. We
> really shouldn't provide interfaces that are this bad.
>
> It's correct operation is only by accident.

True :(

I understand Balbirs problem and it makes some sense to provide a
solution. We can:

    1) reject set_affinity() if the task has that flush muck enabled
       and user space tries to move it to a SMT enabled core

    2) disable the muck if if detects that it is runs on a SMT enabled
       core suddenly (hotplug says hello)

       This one is nasty because there is no feedback to user space
       about the wreckage.

Thanks,

        tglx
