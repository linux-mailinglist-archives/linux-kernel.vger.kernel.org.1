Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DFB2C4926
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgKYUiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729947AbgKYUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606336679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJcBHUa5q245able4He9GSxvMxFj8YT9oIgh1BWou6g=;
        b=bXyQWcOz7PdS4CtNOX7zMa+vXFBaiotl45FUFbJD58sgpEO9mi/P/it9i+TAaAQ7zqdzpq
        lKATtBt7ePlOsnhQK+Ow5TJMaHO/bTzBoUU3TnRC4YU9Ht/djesqX2CQjCBWwUob1cZDqV
        TNpA0b5rFBYicq2toBbaYYUI2w4xk5E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-8K4lb5UgNNyNj9lletKbzw-1; Wed, 25 Nov 2020 15:37:57 -0500
X-MC-Unique: 8K4lb5UgNNyNj9lletKbzw-1
Received: by mail-qk1-f197.google.com with SMTP id o25so3360882qkj.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IJcBHUa5q245able4He9GSxvMxFj8YT9oIgh1BWou6g=;
        b=Z78UD8CZHRT1i/bwVWMZJW6t+NlRtuE/q8aUPVWEYJJ2+5J8beoqrJ1Hgq/XtALZI/
         xVNQ2nqwFK0vgzWojMbnkiUhPr7n0tou64gdLGudnwD/976FTayWMymSa3CWv8rWAOhg
         xojTsGeyFyuE1IK+Mo+/25t/BFqYz7afELxtRUwRH4VwKvurCWpnqyxBuPs0vhdBg9II
         XhpAQ7HIAKS4ZAMd+Cgi6plI1q8zNFggWRVp4nxPbAoUVPj/JhPwkzwVWXFlyHcaID59
         cPZ1Yv8DGxYc/UZto8T5I5sFXx/GnUoeKI7/mLo8EFsiKEpIQalBTZ2cgYuSwDBAvYMC
         xVXg==
X-Gm-Message-State: AOAM530vNGj20OhfU3rr8coD1GznJMybBZ2lE9d2zWcPd1HRcj9hYdcC
        gM2S3i6GveaWrG1VzAH/Gn1dDSiPLNP3QKYTeteHAeeLi3gVVhBGemJD5mCiKqZElmTvAp/6EzN
        Magr2+C33XaIroiWDN1tFDoWq
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr726705qkv.173.1606336677400;
        Wed, 25 Nov 2020 12:37:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPfz+fhdZGh/lgK1kAs5zgS5US+ZNzvHwy9bybWAsRBZme/uyVy4vkWuJx2sq5cLUKbWfhRQ==
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr726690qkv.173.1606336677144;
        Wed, 25 Nov 2020 12:37:57 -0800 (PST)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id i7sm427129qkl.94.2020.11.25.12.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 12:37:56 -0800 (PST)
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <petr.spacek@nic.cz>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan>
 <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
 <87sg9vn40t.fsf@nanos.tec.linutronix.de>
 <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
 <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
 <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
 <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
 <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com>
 <87y2jej8mp.fsf@nanos.tec.linutronix.de>
 <d88ede3f-5f50-24a2-5009-6418f3cfaf4c@redhat.com>
 <87wnygopen.fsf@nanos.tec.linutronix.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <5c382ef4-c505-5629-a85c-abae67c05c7c@redhat.com>
Date:   Wed, 25 Nov 2020 15:37:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87wnygopen.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 7:14 PM, Thomas Gleixner wrote:
> I hope you are aware that the time namespace offsets have to be set
> _before_ the process starts and can't be changed afterwards,
> i.e. settime() is not an option.

I not interested in settime(). I saw Petr's request and forwarded it on
here to further the educational conversation about CLOCK_REALTIME and
cement a consensus around this issue. I'm happy to evangelize that we
won't support settime() for the specific reasons you call out and that
way I can give architectural guidance to setup systems in a particular
way to use CRIU or VM+container if needed.
 
> That might limit the usability for your use case and this can't be
> changed at all because there might be armed timers and other time
> related things which would start to go into full confusion mode.

The use of time in these cases, from first principles, seems to
degenerate into:

* Verify a time-dependent action is correct.

In glibc's case:

* Verify various APIs after y2038.

In Petr's case he could split the test into two such tests
but he would have to reproduce the system state for the second
test and I expect he wants to avoid that.

In that case I think Petr has to use CRIU to start the container,
stop it, advance time, and restart. That should work perfectly
in that use case and solve all the problems by relying on the work
done by CRIU.
 
> The supported use case is container life migration and that _is_ very
> careful about restoring time and armed timers and if their user space
> tools screw it up then they can keep the bits and pieces.

Agreed.
 
> So in order to utilize that you'd have to checkpoint the container,
> manipulate the offsets and restore it.

Or use the same mechanisms CRIU uses.

I can't rely on CRIU because I have to bootstrap a toolchain and userspace.
We should be able to write a thin veneer into our own testing wrapper and
emulate whatever CRIU does. We know apriori that our test framework starts
the test without anything having been executed yet. So we have that benefit.
Currently we unshare() for NEWUSER/NEWPID/NEWNS, but I expect that will
get a little more advanced. Already having these namespaces helps immensely
when adding fs-related tests.

> Aside of this, there are other things, e.g. file times, packet
> timestamps etc. which are based on CLOCK_REALTIME. What to do about
> them? Translate these to/from name space time or not? There is a long
> list of other horrors which are related to that.

We haven't even started testing for the upcoming negative leap second ;-)
 
> So _you_ might say, that you don't care about file times, RTC, timers
> expiring at the wrong time, packet timestamps and whatever.

I do care about them, but only given certain contexts.
 
> But then the next test dude comes around and want's to test exactly
> these interfaces and we have to slap the time namespace conversions for
> REALTIME and TAI all over the place because we already support the
> minimal thing.

That's a decision you need to make when asked those questions.
 
> Can you see why this is a slippery slope and why I'm extremly reluctant
> to even provide the minimal 'distort realtime when the namespace starts'
> support?

I would argue this is a slippery slope fallacy. If and when we get better
vm+container support we just tear all this code out and tell people to
start using those frameworks. The vm+container frameworks have independent
reasons to exist and so will continue to improve for security isolation
purposes and end up solving time testing issues by allowing us complete
control over the VMs time.

>> Hopefully this ilustrates that real time name space is not "request for
>> ponny" :-)
> 
> I can understand your pain and why you want to distort time, but please
> understand that timekeeping is complex. The primary focus must be
> correctness, scalability and maintainability which is already hard
> enough to achieve. Just for the perspective: It took us only 8 years to
> get the kernel halfways 2038 ready (filesystems still outstanding).

I agree. The upstream glibc community has been working on y2038 since 2018;
not as long as the kernel.
 
> So from my point of view asking for distorted time still _is_ a request
> for ponies.

I'm happy if you say it's more work than the value it provides.

> The fixed offsets for clock MONOTONIC/BOOTTIME are straight forward,
> absolutely make sense and they have a limited scope of exposure. clock
> REALTIME/TAI are very different beasts which entail a slew of horrors.
> Adding settime() to the mix makes it exponentially harder.
 
Right.

-- 
Cheers,
Carlos.

