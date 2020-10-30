Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23652A10BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgJ3WTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgJ3WTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604096384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ezf5O993hVcI/W1aSY0g4scUTmj4FCUzbeplrh9LUEI=;
        b=R3J2JRAPa4pBk8Kpu/OmugyktA78WZmcui/u7WgRvNHqcJaMefFmG8clLMx99XUaBwSrW4
        hRNxyRke8J4V4N5iSUtg7fVEIRuOszLzB1Nu9DWQGDGL69AdtAP3H6WNa9NVtId4xPAAQH
        f4u5E+RKVGxYVGoubVIdQOR6IiLF2Eg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-An3JzYWSO_-L8sNupig0mA-1; Fri, 30 Oct 2020 18:19:42 -0400
X-MC-Unique: An3JzYWSO_-L8sNupig0mA-1
Received: by mail-qv1-f70.google.com with SMTP id d16so4663427qvy.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ezf5O993hVcI/W1aSY0g4scUTmj4FCUzbeplrh9LUEI=;
        b=m+lF2TzH6Z55FvFPMI2bbQSDvdNB9jTZGHCJEWFdutQgWEOWvKbrGcACjUo+lYVglK
         +Sdk2daM+wgkrBR+Ww+46ACOehwZBXMnLK9tZ+zjsHiF261hFheTUFHqERhNnKwvXa+f
         am7ugZwkkFyLYz8/xChqnbYbYr2B6lcqE6J8cC/MUtvIycyHKwM15bETAXLcKTAm8b/y
         u1Xk+mYEtsT1pXz0SVUPte9ZMKWcn7B0yifLzlSZsdbKFwgue9jarDC70Y1VNL/atp9P
         pNWqxjRlREavPpNAWrx1l0uMGMZlnVfPehm8oy5xAJ4gHo3Te+pmALR0bbFcYd6MK03i
         2RcQ==
X-Gm-Message-State: AOAM5331D4wgQRaZRda7M+z4M7Q8Ogx/IDPvfdD0pHOvXqf4caRnVwod
        3IQwLdnANXW+pcz/Qh5PssfP5QfeEKs3OtmEKf1AG0+1kMitzDnwkfvok6PvJNZy4wmOct6ZfJH
        HkrdvF9eCAKs4xuDB0FERfRSZ
X-Received: by 2002:ac8:5ac1:: with SMTP id d1mr3978261qtd.82.1604096381287;
        Fri, 30 Oct 2020 15:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcRixONHe7hXu+lOaEciz3f9ib3g1q86eQDNF3Jz4pi/gbY+8HfD6UGdEWBhsG2aTcG2Y79Q==
X-Received: by 2002:ac8:5ac1:: with SMTP id d1mr3978243qtd.82.1604096381064;
        Fri, 30 Oct 2020 15:19:41 -0700 (PDT)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id g9sm3473930qti.86.2020.10.30.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 15:19:39 -0700 (PDT)
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan>
 <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
 <87sg9vn40t.fsf@nanos.tec.linutronix.de>
 <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
 <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
Date:   Fri, 30 Oct 2020 18:19:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 4:06 PM, Thomas Gleixner wrote:
> On Fri, Oct 30 2020 at 12:58, Carlos O'Donell wrote:
>> I expect that more requests for further time isolation will happen
>> given the utility of this in containers.
> 
> There was a lengthy discussion about this and the only "usecase" which
> was brought up was having different NTP servers in name spaces, i.e. the
> leap second ones and the smearing ones.

In the non-"request for ponies" category:

* Running legacy 32-bit applications in containers with CLOCK_REALTIME set
  to some value below y2038.

* Testing kernel and userspace clock handling code without needing to
  run on bare-metal, VM, or other.
 
> Now imagine 1000 containers each running their own NTP. Guess what the
> host does in each timer interrupt? Chasing 1000 containers and update
> their notion of CLOCK_REALTIME. In the remaining 5% CPU time the 1000
> containers can do their computations.

How is this different than balancing any other resource that you give
to a container/vm on a host?

Can you enable 1000 containers running smbd/nmbd and expect to get
great IO performance?
 
> But even if you restrict it to a trivial offset without NTP
> capabilities, what's the semantics of that offset when the host time is
> set?

Now you're talking about an implementation. This thread is simply
"Would we implement CLOCK_REALTIME?" Is the answer "Maybe, if we solve
all these other problems?"

>> If we have to use qemu today then that's where we're at, but again
>> I expect our use case is representative of more than just glibc.
> 
> For testing purposes it might be. For real world use cases not so
> much. People tend to rely on the coordinated nature of CLOCK_TAI and
> CLOCK_REALTIME.

Except we have two real world use cases, at the top of this email, 
that could extend to a lot of software. We know legacy 32-bit 
applications exist that will break with CLOCK_REALTIME past
y2038. Software exists that manipulates time and needs testing
with specific time values e.g. month crossings, day crossings,
leap year crossings, etc.
 
>> Does checkpointing work robustly when userspace APIS use 
>> CLOCK_REALTIME (directly or indirectly) in the container?
> 
> AFAICT, yes. That was the conclusion over the lenghty discussion about
> time name spaces and their requirements.

If this is the case then have we established behaviours that
happen when such processes are migrated to other systems with
different CLOCK_REALTIME clocks? Would these behaviours serve
as the basis of how CLOCK_REALTIME in a namespace would behave?

That is to say that migrating a container to a system with a
different CLOCK_REALTIME should behave similarly to what happens
when CLOCK_REALTIME is changed locally and you have a container
with a unique CLOCK_REALTIME?

> Here is the Linux plumber session related to that:
>      https://www.youtube.com/watch?v=sjRUiqJVzOA

Thanks. I watched the session. Informative :-)

-- 
Cheers,
Carlos.

