Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC952B42D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgKPL3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:29:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKPL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:29:18 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605526156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TXA8C//OAiETe8IM0ulyE5+aluYy8UWpM/42a1HSXU=;
        b=1/RDjHnJgcbQCbstpEJCAPFhnId2nhImvkGUfQnUYHGMcL2mNGesTgbdS0K0piuy4P+jAt
        K9rzbtZGxlopQSIXJUuzO4jEVlz+ES3859Koi6bdkMv8vURj1+m2duNxOInyIWw/1KQCmC
        40BG+rdNclbVzMOKBAJHrJ4gNsMKSgUeRKblLGATMHIHYortgOCd1ZCjt9VciNQyLW5xi+
        lFXqp2lXkg5/B6F8j1bmhjc/waCr3KeHwdE+furrMnsdrDkVTpkRfz50aWgAhGsteNDhhr
        o644Ekdb65ovFzh7tw6jYPkMXw4oRFMGL5gtHIVbYS4HrnU0ez609+B7XuFhVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605526156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TXA8C//OAiETe8IM0ulyE5+aluYy8UWpM/42a1HSXU=;
        b=MQOiW7TralESTKON3A2siO0qCk6yh+Qm1OJjQ7hsNppYpSczlChg0fGLt7opYc3nVk828C
        CTd6eCym0K1ZpgBw==
To:     Yunfeng Ye <yeyunfeng@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tick/nohz: Reduce the critical region for jiffies_seq
In-Reply-To: <66c172ec-72a1-022a-d387-6c836a698912@huawei.com>
References: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com> <87h7pq8kyc.fsf@nanos.tec.linutronix.de> <66c172ec-72a1-022a-d387-6c836a698912@huawei.com>
Date:   Mon, 16 Nov 2020 12:29:16 +0100
Message-ID: <87o8jxzgj7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 14:07, Yunfeng Ye wrote:
> On 2020/11/16 3:43, Thomas Gleixner wrote:
>>> and the conflict between jiffies_lock and jiffies_seq increases,
>>> especially in multi-core scenarios.
>> 
>> This does not make sense. The sequence counter is updated when holding
>> the lock, so there is no conflict between the lock and the sequence
>> count.
>> 
> Yes, there is no conflict between the lock and the sequence count, but
> when tick_do_update_jiffies64() is called one by one, the sequence count
> will be updated, it will affect the latency of tick_nohz_next_event(),
> because the priority of read seqcount is less than writer.

It's clear to me because I know how that code works, but for someone who
is not familiar with it your description of the problem is confusing at
best.

> During a tick period,

'During a tick period' is misleading. The tick period is the reciprocal
value ot the tick frequency.

What you want to explain is that if jiffies require an update, i.e.

     now > last_update + period

then multiple CPUs might contend on it until last_update is forwarded
and the quick check is preventing it again.

> the tick_do_update_jiffies64() is called concurrency, and the
> time is up to 30+us. so the lockless quick check in tick_do_update_jiffies64()
> cannot intercept all concurrency.

It cannot catch all of it, right. 

There are quite some other inefficiencies in that code and the seqcount
held time can be reduced way further. Let me stare at it.

Thanks,

        tglx
