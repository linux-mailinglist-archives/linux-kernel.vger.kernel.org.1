Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC92D3F09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgLIJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:44:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbgLIJn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:43:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4756233FA;
        Wed,  9 Dec 2020 09:43:18 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kmw0C-00HKn3-JQ; Wed, 09 Dec 2020 09:43:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Dec 2020 09:43:16 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yezengruan <yezengruan@huawei.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvmarm@lists.cs.columbia.edu,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
In-Reply-To: <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
 <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: joelaf@google.com, sergey.senozhatsky@gmail.com, yezengruan@huawei.com, will@kernel.org, linux-kernel@vger.kernel.org, suleiman@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com, qperret@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2020-12-08 20:02, Joel Fernandes wrote:
> On Fri, Sep 11, 2020 at 4:58 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
>> 
>> My apologies for the slow reply.
>> 
>> On (20/08/17 13:25), Marc Zyngier wrote:
>> >
>> > It really isn't the same thing at all. You are exposing PV spinlocks,
>> > while Sergey exposes preemption to vcpus.
>> >
>> 
>> Correct, we see vcpu preemption as a "fundamental" feature, with
>> consequences that affect scheduling, which is a core feature :)
>> 
>> Marc, is there anything in particular that you dislike about this RFC
>> patch set? Joel has some ideas, which we may discuss offline if that
>> works for you.
> 
> Hi Marc, Sergey, Just checking what is the latest on this series?

I was planning to give it a go, but obviously got sidetracked. :-(

> 
> About the idea me and Sergey discussed, at a high level we discussed
> being able to share information similar to "Is the vCPU preempted?"
> using a more arch-independent infrastructure. I do not believe this
> needs to be arch-specific. Maybe the speciifc mechanism about how to
> share a page of information needs to be arch-specific, but the actual
> information shared need not be.

We already have some information sharing in the form of steal time
accounting, and I believe this "vcpu preempted" falls in the same
bucket. It looks like we could implement the feature as an extension
of the steal-time accounting, as the two concepts are linked
(one describes the accumulation of non-running time, the other is
instantaneous).

> This could open the door to sharing
> more such information in an arch-independent way (for example, if the
> scheduler needs to know other information such as the capacity of the
> CPU that the vCPU is on).

Quentin and I have discussed potential ways of improving guest 
scheduling
on terminally broken systems (otherwise known as big-little), in the
form of a capacity request from the guest to the host. I'm not really
keen on the host exposing its own capacity, as that doesn't tell the
host what the guest actually needs.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
