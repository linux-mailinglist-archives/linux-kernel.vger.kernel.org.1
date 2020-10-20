Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C87293374
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbgJTDJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 23:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390961AbgJTDJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 23:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603163363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSVZCAmJHCM2CBDzdhDUaxBN5h4qvS5ZTmFdURMG624=;
        b=AcFwO1yjThq/GYiVKZC0QBJhpBGfTdj0V7hOYwpLPS9i5byhjKGBN1T5GaZWlZsf2yOw11
        f1RlT4QPmK22t5tBPLyVFuBsPWD/TbLJpOkZmitD36Q9IaF4jeYm1NKBl8xZ5OSeb/fuUh
        bthYJsSzW9uvm2Ftd5H8q9szPFkt73w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-iGtja8zbNVqZD8kYTwlhpA-1; Mon, 19 Oct 2020 23:09:18 -0400
X-MC-Unique: iGtja8zbNVqZD8kYTwlhpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD45A107AFDB;
        Tue, 20 Oct 2020 03:09:16 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-116.rdu2.redhat.com [10.10.118.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE735D9D2;
        Tue, 20 Oct 2020 03:09:15 +0000 (UTC)
Subject: Re: slowdown due to reader-owned rwsem time-based spinning
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>
References: <alpine.DEB.2.22.394.2010151315190.2869@hadrien>
 <ddbf4694-10c2-cd7e-b0ed-3ae54f262bde@redhat.com>
 <alpine.DEB.2.22.394.2010192143290.2781@hadrien>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <31a92ff6-280a-12f6-9b5a-a904501ceb04@redhat.com>
Date:   Mon, 19 Oct 2020 23:09:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2010192143290.2781@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 3:48 PM, Julia Lawall wrote:
>
> On Mon, 19 Oct 2020, Waiman Long wrote:
>
>> On 10/15/20 7:38 AM, Julia Lawall wrote:
>>> Hello,
>>>
>>> Phoenix is an implementation of map reduce:
>>>
>>> https://github.com/kozyraki/phoenix
>>>
>>> The phoenix-2.0/tests subdirectory contains some benchmarks, including
>>> word_count.
>>>
>>> At the same time, on my server, since v5.8, the kernel has changed from
>>> using the governor intel_pstate by default to using intel_cpufreq.
>>> Intel_cpufreq causes kworkers to run on all cores every 0.004 seconds,
>>> while intel_pstate involves very few such stray processes.
>>>
>>> Suprisingly, all those kworkers cause the word_count benchmark to run 2-3
>>> times faster.  I bisected the problem back to the following commit, whcih
>>> was introduced in v5.3:
>>>
>>> commit 7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358
>>> Author: Waiman Long <longman@redhat.com>
>>> Date:   Mon May 20 16:59:13 2019 -0400
>>>
>>>       locking/rwsem: Enable time-based spinning on reader-owned rwsem
>>>
>>> Representative traces are attached.  word_count_5.9pwrsvpassive_1.pdf is
>>> the one with the kworkers.
>>>
>>> I don't know the Phoenix code in detail, but the problem seems to be in
>>> the infrastructure not the specific word count aplication, because most of
>>> the benchmarks seem to suffer similarly.  Some of the other benchmarks
>>> seem to take a variable and long amount of time to get started in the
>>> active mode, so perhaps the problem could be in reading the initial
>>> dataset.
>>>
>>> Before I plunge into it, do you have any suggestions as to what could be
>>> the problem?
>> I am a bit confused as to what you are looking for. So you said this patch
>> make the benchmark run 2-3 times faster. Is this a problem? What are you
>> trying to achieve? Is it to make the passive case similar to the active case?
> Sorry, it seems that I was not clear.  Prior to the commit above the
> active case had good performance,  The patch caused the active case to
> slow down by 2-3 times.  Adding lots of kworkers that interrupt the
> threads eliminated the slowdown.
>
>> What this patch does is to allow writer waiting for a rwsem to spin for a
>> while hoping the readers will release the lock soon to acquire the lock.
>> Before that, the writer will go to sleep immediately when the rwsem is owned
>> by readers. Probably because of that, the kworkers keep on running for a much
>> longer time as long as there are no other tasks competing for the CPUs.
> No, the kworkers don't run for a long time.  My hypothesis is that the
> kworkers interrupt a thread that is spinning waiting for a lock and thus
> allow the thread that is holding the lock to run.
>
Thanks for the clarification. Now I see what you mean by thinking this 
is a problem?

However, the reader spinning is about 25us max. So I am puzzled by the 
long idle period in between busy period in the active chart. I will need 
to reproduce this condition myself to see what has gone wrong. What is 
configuration of your test machine as well as config option you used for 
the kernel and the boot command line parameters?

Thanks,
Longman

