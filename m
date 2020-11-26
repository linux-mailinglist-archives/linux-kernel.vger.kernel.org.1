Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1E2C4DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbgKZDFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732425AbgKZDFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606359935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Df+7exZ3hv2z9eba20+NxhLFS3WKhK1S603rVKR8sjU=;
        b=Z/x5MilcnRaszEcghk8iq9yjYZkXoW4b+YIgXupOJGw86u9BhZFAPTkyzTDTf/f3/61g1l
        JzU1SgFPLoEcyBDIhc7X/G0qW1xuzMQe9ULGTyKiQv26t/pYNVdbOjRCeNY67o7NWfdxfa
        mk+YuYuEYtSYWI7FDxoBaesUom3uyOQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-6K9lIBFjPvCq1hlbyaXQEA-1; Wed, 25 Nov 2020 22:05:33 -0500
X-MC-Unique: 6K9lIBFjPvCq1hlbyaXQEA-1
Received: by mail-qk1-f198.google.com with SMTP id c71so525514qkg.21
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Df+7exZ3hv2z9eba20+NxhLFS3WKhK1S603rVKR8sjU=;
        b=rBmVXdMRk8w5f4TSmLzRYwXFygCMWd0oxp/XU2phacsvM6lCbzT9NLg7onVSsv5EKX
         /CjAx4dvxGFRMlI8k3WrTiLtmVbsETdV8Y8x5L/EOgK8YPFkUUp01dwPpLnsTs32v01t
         h+9QxY5IAXLK2ONnsDvnpUquKd3lgOJFvTMFkE5UKfBYz6cWfrQlDfi61VfCBMr+gu5o
         rsIK+ISFM1i5CLfnDVwMTGDfJmWwgIR8rX/hrAoVpLUkGYGtnsTEWIMe4A7nEWzdSs+e
         HWl0In1V1+ig4WYz05zodv+vDsIQb5KXB0PIPzgv6nza2eDCTRoI10rClIrdc+7mrriT
         lbKQ==
X-Gm-Message-State: AOAM532XgFStqv4OGYl3AON9WrxjLGXVfZCnso6gYmHENwwtjsjdmCE7
        TDAcsoNMqRwfKJZrCmRju9VTFm2h0bdaJ9ewLO2cStLMejxcdSaM8si7e6TdIhoS2k2MkUiv+FL
        mtT/OHQTLxfBox1bCCLp4JU8w
X-Received: by 2002:a37:6786:: with SMTP id b128mr1243223qkc.7.1606359933369;
        Wed, 25 Nov 2020 19:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuUDkPSSsWgzrGtjxxwedSx4DE6TYAqtoErLr31goiz2AE91CYjPrMuP9Yuyi3NdxtseukBg==
X-Received: by 2002:a37:6786:: with SMTP id b128mr1243205qkc.7.1606359933067;
        Wed, 25 Nov 2020 19:05:33 -0800 (PST)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id l62sm1470148qkf.121.2020.11.25.19.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 19:05:32 -0800 (PST)
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
 <5c382ef4-c505-5629-a85c-abae67c05c7c@redhat.com>
 <87pn41j7jx.fsf@nanos.tec.linutronix.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <1d3d00ac-c7a0-7168-0450-8a0e1499ea2b@redhat.com>
Date:   Wed, 25 Nov 2020 22:05:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87pn41j7jx.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 7:17 PM, Thomas Gleixner wrote:
> Carlos, Petr,
> 
> On Wed, Nov 25 2020 at 15:37, Carlos O'Donell wrote:
>> On 11/19/20 7:14 PM, Thomas Gleixner wrote:
>>> So from my point of view asking for distorted time still _is_ a request
>>> for ponies.
>>
>> I'm happy if you say it's more work than the value it provides.
> 
> Thinking more about it. Would a facility which provides:
> 
>          CLOCK_FAKE_MONOTONIC|BOOTTIME|REALTIME
> 
> where you can go wild on setting time to whatever you want solve
> your problem?

We would need a way to inject CLOCK_FAKE_* in lieu of the real
constants.

There are only two straight forward ways I know how to do that
and they aren't very useful e.g. alternative build, syscall hot-path
debug code to alter the constant.

We might write a syscall interception framework using seccomp
and SECCOMP_RET_TRACE, but that involves ptrace'ing the process
under test, and is equivalent to a micro-sandbox. I'm not against
that idea for testing; we would test what we ship.

I don't think eBPF can modify the incoming arguments.

I need to go check if systemtap can modify incoming arguments;
I've never done that in any script.

In what other ways can we inject the new constants?

-- 
Cheers,
Carlos.

