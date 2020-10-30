Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E72A094E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgJ3PK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3PK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:10:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C0AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:10:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604070626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wGjxMvPHeaomJM6gSl6Q4fS9j3pKCTwNKb3PNq3yZo=;
        b=LQFVw4VUE7tdqEBCFqu31Pz7As2+jhO0blrnSzV5nUp0hVM16cQGyQmsZSzkSCmIyZ3qFj
        Po0pj2R3tixui1jUox7SIBiwSdzC4mxePcZwOHKRIDIb0bl4/ZrzR2HMxYZD0P31ZRiGFX
        dR3+uInKvkT8vGEwzMrf0Judr7/X5iYcW512fa8F0e0ZArODZKUEaVsuWuhwIsMdWtgPFb
        lRFIu1a5KB+zEKNQO7IZUU5IgvtXQTUT4O/6lrHR7nC5cE5JuRPYcxxKMwXJl4B/dU4293
        d0rZ8ik/Hi0MJEQxrKaww9raLmyJ4VjK4Y2bxUl3Ye9O9qeKW2iHpGoiuQ68Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604070626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wGjxMvPHeaomJM6gSl6Q4fS9j3pKCTwNKb3PNq3yZo=;
        b=b4KDRU00/mUt7SdS5Y+Dcay+FeC0fPmUHW8pIiJbNaLNqIXlR0lFb5AQsA2TzNmt6u+QdB
        6g/5FLd2CTMbHsCw==
To:     Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Lukasz Majewski <lukma@denx.de>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan> <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
Date:   Fri, 30 Oct 2020 16:10:26 +0100
Message-ID: <87sg9vn40t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 10:02, Zack Weinberg wrote:
> On Fri, Oct 30, 2020 at 9:57 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>> > According to patch description [1] and time_namespaces documentation
>> > [2] the CLOCK_REALTIME is not supported (for now?) to avoid complexity
>> > and overhead in the kernel.
> ...
>> > To be more specific - [if this were supported] it would be possible to modify time after time_t
>> > 32 bit overflow (i.e. Y2038 bug) on the process running Y2038
>> > regression tests on the host system (64 bit one). By using Linux time
>> > namespaces the system time will not be affected in any way.
>>
>> And what's exactly wrong with moving the system time forward for a
>> duration of the test?
>
> Interference with other processes on the same computer?  Some of us
> *do* like to run the glibc test suite on computers not entirely
> devoted to glibc CI.

That's what virtual machines are for.
