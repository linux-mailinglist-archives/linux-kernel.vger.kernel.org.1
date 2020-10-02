Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59F281743
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbgJBP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJBP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601654280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fow1rKoT5hjh0fNFBET8jAgxpaNLWzof7WSQoWO/K/E=;
        b=KsnWvOqLacIjOjZNo72rLkRhmWZddvZpKu4gyEBq6bn3TDIHbJt/0Vuruv93Ly9P3tcZgZ
        Q58VXiCwTef1LeFu7knYNExtPXlBcpQ1zZLXeVETT/QuhTtVEtbX0D5CrIkAQA2O2DERmK
        kYIxoenb/gPWc8WKRf9cTO7OruM7mYw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-wv9ENSdmMCOrk2pYfhVy3A-1; Fri, 02 Oct 2020 11:57:59 -0400
X-MC-Unique: wv9ENSdmMCOrk2pYfhVy3A-1
Received: by mail-qt1-f197.google.com with SMTP id g44so1314938qtb.15
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fow1rKoT5hjh0fNFBET8jAgxpaNLWzof7WSQoWO/K/E=;
        b=C8lfF5COaLDpxCHGTEAV9EsViwbXjUn6rn6sPpY7tb1O0P/Fm5NsKCCvQL0ksI0iJZ
         8b1p9i/N7NPM6FywKXTxmVXF02FZs5YDZhHcsTmQZeWa1qgG53PMJG9wh7iEOII2h1Q8
         6ch9YBIDo5MeqHYS3GRprbBVl2KI5M6xxoQrxNs4+jfplMZAej3sIdKrjLI4XUOh5qp/
         wcPwKALTpA/GQtThk/uP9pq4vuUCPDG+M+VAHiVPs5okzQiFEGKh8qhsM8BW0BB8zz2l
         uo9/EzVHLVFuTGWIEwXCybL1HNofVBVMh0Jt1JbRml1wILSmiRf3YDuGI10ftFVRcp4p
         6vwQ==
X-Gm-Message-State: AOAM532jO7+ZFxDvF7UZHBBnsRfOq8qEbX7hdQzM5GLfsMy6mIH4HA8u
        s1gpFV2BCvy3UzcC3V4KC6CjDsVnpLNVyVshjJ0//6MGVrVDGKi1sBTFwM8VxLnzUBikcI4Qw/A
        TVh37c1O7mBMi0K2m/2+r821c
X-Received: by 2002:ac8:1a43:: with SMTP id q3mr2958815qtk.41.1601654277165;
        Fri, 02 Oct 2020 08:57:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw5pnn7qdXl3emd/Wk2Og1Wcj3jG2wqYdWcuE9dTEtKjC8RWzDMeRGgU0i4V0ZnnV7AX2tTw==
X-Received: by 2002:ac8:1a43:: with SMTP id q3mr2958789qtk.41.1601654276839;
        Fri, 02 Oct 2020 08:57:56 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id p30sm1272205qtd.89.2020.10.02.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 08:57:55 -0700 (PDT)
Subject: Re: [PATCH] sched/deadline: Unthrottle PI boosted threads while
 enqueuing
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Simmons <msimmons@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
 <20200918060026.GC261845@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f4316f5a-eccd-ec96-3f7b-85900f5f3124@redhat.com>
Date:   Fri, 2 Oct 2020 17:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918060026.GC261845@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 8:00 AM, Juri Lelli wrote:
> Hi Daniel,
> 
> On 16/09/20 09:06, Daniel Bristot de Oliveira wrote:
>> stress-ng has a test (stress-ng --cyclic) that creates a set of threads
>> under SCHED_DEADLINE with the following parameters:
>>
>>     dl_runtime   =  10000 (10 us)
>>     dl_deadline  = 100000 (100 us)
>>     dl_period    = 100000 (100 us)
>>
>> These parameters are very aggressive. When using a system without HRTICK
>> set, these threads can easily execute longer than the dl_runtime because
>> the throttling happens with 1/HZ resolution.
>>
>> During the main part of the test, the system works just fine because
>> the workload does not try to run over the 10 us. The problem happens at
>> the end of the test, on the exit() path. During exit(), the threads need
>> to do some cleanups that require real-time mutex locks, mainly those
>> related to memory management, resulting in this scenario:
>>
>> Note: locks are rt_mutexes...
>>  ------------------------------------------------------------------------
>>     TASK A:		TASK B:				TASK C:
>>     activation
>> 							activation
>> 			activation
>>
>>     lock(a): OK!	lock(b): OK!
>>     			<overrun runtime>
>>     			lock(a)
>>     			-> block (task A owns it)
>> 			  -> self notice/set throttled
>>  +--<			  -> arm replenished timer
>>  |    			switch-out
>>  |    							lock(b)
>>  |    							-> <C prio > B prio>
>>  |    							-> boost TASK B
>>  |  unlock(a)						switch-out
>>  |  -> handle lock a to B
>>  |    -> wakeup(B)
>>  |      -> B is throttled:
>>  |        -> do not enqueue
>>  |     switch-out
>>  |
>>  |
>>  +---------------------> replenishment timer
>> 			-> TASK B is boosted:
>> 			  -> do not enqueue
>>  ------------------------------------------------------------------------
>>
>> BOOM: TASK B is runnable but !enqueued, holding TASK C: the system
>> crashes with hung task C.
>>
>> This problem is avoided by removing the throttle state from the boosted
>> thread while boosting it (by TASK A in the example above), allowing it to
>> be queued and run boosted.
>>
>> The next replenishment will take care of the runtime overrun, pushing
>> the deadline further away. See the "while (dl_se->runtime <= 0)" on
>> replenish_dl_entity() for more information.
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Reported-by: Mark Simmons <msimmons@redhat.com>
>> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
>> Tested-by: Mark Simmons <msimmons@redhat.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>>
>> ---
> 
> Thanks for this fix.
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

This is a gentle ping... [we are facing this bug in practice :-(].

-- Daniel

> Best,
> Juri
> 

