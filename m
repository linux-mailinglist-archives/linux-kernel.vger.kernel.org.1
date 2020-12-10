Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB962D559C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbgLJIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgLJIqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:46:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B3422CA1;
        Thu, 10 Dec 2020 08:45:25 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knHZi-00013B-TO; Thu, 10 Dec 2020 08:45:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Dec 2020 08:45:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Joel Fernandes <joelaf@google.com>,
        Quentin Perret <qperret@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yezengruan <yezengruan@huawei.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvmarm@lists.cs.columbia.edu,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
In-Reply-To: <CAJWu+ooy=r=G+AnyriQDA9_4CJqfO6hkf=c8heV8HV+yNea_PQ@mail.gmail.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
 <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
 <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
 <CAJWu+ooy=r=G+AnyriQDA9_4CJqfO6hkf=c8heV8HV+yNea_PQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <78091359dab0d8decfc452f7c5c25971@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: joelaf@google.com, qperret@google.com, sergey.senozhatsky@gmail.com, yezengruan@huawei.com, will@kernel.org, linux-kernel@vger.kernel.org, suleiman@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-10 01:39, Joel Fernandes wrote:

[...]

>> Quentin and I have discussed potential ways of improving guest
>> scheduling
>> on terminally broken systems (otherwise known as big-little), in the
>> form of a capacity request from the guest to the host. I'm not really
>> keen on the host exposing its own capacity, as that doesn't tell the
>> host what the guest actually needs.
> 
> I am not sure how a capacity request could work well. It seems the
> cost of a repeated hypercall could be prohibitive. In this case, a
> lighter approach might be for KVM to restrict vCPU threads to run on
> certain types of cores, and pass the capacity information to the guest
> at guest's boot time.

That seems like a very narrow use case. If you actually pin vcpus to
physical CPU classes, DT is the right place to put things, because
it is completely static. This is effectively creating a virtual
big-little, which is in my opinion a userspace job.

> This would be a one-time cost to pay. And then,
> then the guest scheduler can handle the scheduling appropriately
> without any more hypercalls. Thoughts?

Anything that is a one-off belongs to firmware configuration, IMO.

The case I'm concerned with is when vcpus are allowed to roam across
the system, and hit random physical CPUs because the host has no idea
of the workload the guest deals with (specially as the AMU counters
are either absent or unusable on any available core).

The cost of a hypercall really depends on where you terminate it.
If it is a shallow exit, that's only a few hundred cycles on any half
baked CPU. Go all the way to userspace, and the host scheduler is the
limit. But the frequency of that hypercall obviously matters too.

How often do you expect the capacity request to fire? Probably not
on each and every time slice, right?

Quentin, can you shed some light on this?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
