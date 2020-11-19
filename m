Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E72B9AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgKSSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:37:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729055AbgKSSh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605811046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9xzIJUV8CDpyZy3ojrYBHeDyO6RxNbzAmwRgNP6xos=;
        b=ZNyST0XRgfM1rpOeD3xcOxHkQfjKV+b5ghpDs1CJd289sCz+/8bXaAharZ+19OMUNxf+X+
        7QYtGEq19HP/I0KFvElmaZIZlB+IDbbhsuh4SykhBHgx0x+Xc0E5PEPrSJ+s87Nzy04tRc
        lMeqXai0PGbOLGcsduk58fpjTpPs/5k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-PLlz2IFyP1er9s8VDLy7wQ-1; Thu, 19 Nov 2020 13:37:23 -0500
X-MC-Unique: PLlz2IFyP1er9s8VDLy7wQ-1
Received: by mail-qv1-f72.google.com with SMTP id d41so5186264qvc.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H9xzIJUV8CDpyZy3ojrYBHeDyO6RxNbzAmwRgNP6xos=;
        b=bUA6KrevvrygY8n12eF59fHjGNZ0WIIRBmIbVvecd2ttEYSfa07dTVj5Yns0nJSUyN
         HdYtQ9KreNv+eaXWG7GzJk+1o/w8/Sf+fy1hvj1U7hbEikiX1djntbvDO57Ac7yzsv3g
         +XkzgUdUJ+ho+R0b/lcsH4cjANHOJ5W2qhkpGWuqUWbUd60sQSObDnQMk9B+aZf9pINc
         p6GlTDjickGpPd5Fdun3idm+nC4RtkpbQWaGDiLtXUhfcLGSAP2gQhpPvygYhAAnQX6s
         YMmb+RwMoBeVthLMWbY68uNPUV0njNm9Dqzz1iK9bOa3/RAJESxJHwOBjRP79KXTdkQn
         wYbA==
X-Gm-Message-State: AOAM530QG4sfgNgOgR+a02cQC4OaTTqNNQ6eLPvSSPrFjLwUZmF6FfGQ
        jMXp+/wyp7AwThxTwTS5e9vr0TSvP/kp+S+Y6XmBFWVPKMHyIkJ4c8cTX0WpLiX94eBbg+LA0bd
        6FxX0FHnrotAwVh/+5j3P/dvY
X-Received: by 2002:a37:458e:: with SMTP id s136mr12135351qka.17.1605811042721;
        Thu, 19 Nov 2020 10:37:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvHJk53uceOA3GpcfF90o5nQRD/2O2h36NCirKOyMc4Ac9Ddaj/1ifFM6fISbQd9gEKEolhw==
X-Received: by 2002:a37:458e:: with SMTP id s136mr12135326qka.17.1605811042458;
        Thu, 19 Nov 2020 10:37:22 -0800 (PST)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id g19sm398612qkl.86.2020.11.19.10.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 10:37:21 -0800 (PST)
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
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <d88ede3f-5f50-24a2-5009-6418f3cfaf4c@redhat.com>
Date:   Thu, 19 Nov 2020 13:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87y2jej8mp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/20 7:47 PM, Thomas Gleixner wrote:
> On Thu, Nov 05 2020 at 12:25, Carlos O'Donell wrote:
>> On 10/30/20 9:38 PM, Thomas Gleixner wrote:
>> If kata grows up quickly perhaps this entire problem becomes solved, but until
>> then I continue to have a testing need for a distinct CLOCK_REALTIME in a
>> time namespace (and it need not be unconditional, if I have to engage magic
>> then I'm happy to do that).
> 
> Conditional, that might be a way to go.
> 
> Would CONFIG_DEBUG_DISTORTED_CLOCK_REALTIME be a way to go? IOW,
> something which is clearly in the debug section of the kernel which wont
> get turned on by distros (*cough*) and comes with a description that any
> bug reports against it vs. time correctness are going to be ignored.

Yes. I would be requiring CONFIG_DEBUG_DISTORTED_CLOCK_REALTIME.

Let me be clear though, the distros have *+debug kernels for which this
CONFIG_DEBUG_* could get turned on? In Fedora *+debug kernels we enable all
sorts of things like CONFIG_DEBUG_OBJECTS_* and CONFIG_DEBUG_SPINLOCK etc.
etc. etc.

I would push Fedora/RHEL to ship this in the *+debug kernels. That way I can have
this on for local test/build cycle. Would you be OK with that?

We could have it disabled by default but enabled via proc like
unprivileged_userns_clone was at one point? I want to avoid accidental use in
Fedora *+debug kernels unless the developer is actively going to run tests that
require time manipulation e.g. thousands of DNSSEC tests with timeouts [1].

I also need a way to determine the feature is enabled or disabled so I can XFAIL
the tests and tell the developer they need to turn on the feature in the host
kernel (and not to complain when CLOCK_REALTIME is wrong). A proc interface solves
this in a straight forward way.

I could then also tell my hardware partners to turn it on during certain test/build
cycles. It violates "ship what you test" but increases test coverage and can be
run as a distinct test cycle. I could also have our internal builders turn this
feature on so we can run rpm %check phases with this feature enabled (operations
might refuse, but in that case my day-to-day developer testing still helps by
orders of magnitude).

Notes:
[1] Petr Špaček commented on DNSSEC and expiration testing as another real-world testing
scenario: https://sourceware.org/pipermail/libc-alpha/2020-November/119785.html
Still a testing scenario, but an example outside of glibc for networking, where they
have a need to execute thousands of tests with accelerated timeout. If vm+containers
catches up, and I think they will, we'll have a solution in a few years.

>> * Adding CLOCK_REALTIME to the kernel is a lot of work given the expected
>>   guarantees for a local system.
> 
> Correct.
> 
>> * CLOCK_REALTIME is an expensive resource to maintain, even more expensive
>>   than other resources where the kernel can balance their usage.
> 
> Correct.
> 
>> * On balance it would be better to use vm or vm+containers e.g. kata as a
>>   solution to having CLOCK_REALTIME distinct in the container.
> 
> That'd be the optimal solution, but the above might be a middle ground.

Agreed.

-- 
Cheers,
Carlos.

