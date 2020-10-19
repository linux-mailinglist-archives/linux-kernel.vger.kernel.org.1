Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8446D292E87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgJSTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730832AbgJSTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1DxwUE3x0ocWEiFJRpe2w2FlExAsYaAotI1SZezXvI=;
        b=gKAjwINBizu315LE5+aJfZVVvDnV2he9c+Xhk6JAfWS37Lnj38/8dAKT7vOwu/Miwp0aQ5
        HXeOhqAyLa+h902VSti2McWgTuA6Yr3KDHNSUIbqFEJbgxQmZ+NJI7OQOdSczIChGcDdaH
        lnQQPIwmMMf0L0PqgOAn7TTg0FL7QDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-m--WBt5dNzaF4NQNaqw7jw-1; Mon, 19 Oct 2020 15:34:25 -0400
X-MC-Unique: m--WBt5dNzaF4NQNaqw7jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A36803651;
        Mon, 19 Oct 2020 19:33:29 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-116.rdu2.redhat.com [10.10.118.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69BED60FC2;
        Mon, 19 Oct 2020 19:33:28 +0000 (UTC)
Subject: Re: slowdown due to reader-owned rwsem time-based spinning
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>
References: <alpine.DEB.2.22.394.2010151315190.2869@hadrien>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ddbf4694-10c2-cd7e-b0ed-3ae54f262bde@redhat.com>
Date:   Mon, 19 Oct 2020 15:33:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2010151315190.2869@hadrien>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 7:38 AM, Julia Lawall wrote:
> Hello,
>
> Phoenix is an implementation of map reduce:
>
> https://github.com/kozyraki/phoenix
>
> The phoenix-2.0/tests subdirectory contains some benchmarks, including
> word_count.
>
> At the same time, on my server, since v5.8, the kernel has changed from
> using the governor intel_pstate by default to using intel_cpufreq.
> Intel_cpufreq causes kworkers to run on all cores every 0.004 seconds,
> while intel_pstate involves very few such stray processes.
>
> Suprisingly, all those kworkers cause the word_count benchmark to run 2-3
> times faster.  I bisected the problem back to the following commit, whcih
> was introduced in v5.3:
>
> commit 7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358
> Author: Waiman Long <longman@redhat.com>
> Date:   Mon May 20 16:59:13 2019 -0400
>
>      locking/rwsem: Enable time-based spinning on reader-owned rwsem
>
> Representative traces are attached.  word_count_5.9pwrsvpassive_1.pdf is
> the one with the kworkers.
>
> I don't know the Phoenix code in detail, but the problem seems to be in
> the infrastructure not the specific word count aplication, because most of
> the benchmarks seem to suffer similarly.  Some of the other benchmarks
> seem to take a variable and long amount of time to get started in the
> active mode, so perhaps the problem could be in reading the initial
> dataset.
>
> Before I plunge into it, do you have any suggestions as to what could be
> the problem?

I am a bit confused as to what you are looking for. So you said this 
patch make the benchmark run 2-3 times faster. Is this a problem? What 
are you trying to achieve? Is it to make the passive case similar to the 
active case?

What this patch does is to allow writer waiting for a rwsem to spin for 
a while hoping the readers will release the lock soon to acquire the 
lock. Before that, the writer will go to sleep immediately when the 
rwsem is owned by readers. Probably because of that, the kworkers keep 
on running for a much longer time as long as there are no other tasks 
competing for the CPUs.

Cheers,
Longman


