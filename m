Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37F27AA01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1IzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1IzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:55:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D255C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:55:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so263416pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UL/lVkSmikJzYStgGU/M4soguRl9I/oKkU7pcTJ2KgY=;
        b=WDPRDV59OnPMjfOSSjLrFBblWexDaJ+Mjpz2mCqna8N9xSjdi4kqfBwWO7Nb22/ssd
         OUInVy1PkH5YwWsLeTbJmp3H0TFKMNcyrLqJ15sw7jinrI55adDYm9AP7Azy/wkG+DAz
         nuSfnea19KXH3N9LujfWC1KXVsiiQGaSDXQ7DnmTMPhdU+wldVvrGK+a5RamHIIyipcW
         +Uu1+RF9FEsxnRnWQ/iSPxFDnf74XE9cnxAVpWph2K1qkPog7qShGY1OElijT8CaDoe5
         jLTI+5EZ3DOQrIIdRH6EOZJba97V05zhguZUtfSXFHVGKNzYFZ0Ld8WtvoWwXFxaZ759
         V15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UL/lVkSmikJzYStgGU/M4soguRl9I/oKkU7pcTJ2KgY=;
        b=jd082wFtwbVaNtfmmF1S+xOnmuw+DdomB2P1iZhE12z1Zy6bTJeQdrhD7NrvrNmO4m
         oUn1AKdvIPtelqj8IK+gWE1BhttobUh3PrZrILRt6QdhkCcbHYDSowu5wXjZIePhEKOn
         JY/NVxx/eNIn232rwooyCygdxeBuq1rx53xUEfPCKaR3ZNpucbsocN8XqrDAjkTlXr1o
         HJHVVrneM+aaGoECOHIZMxcZ1RyutRu1VFX6qT1HXNiqtTRBHztL+nT+HFKYqrjIiT8i
         BblEzKUPop4hTE+NoVKcSm0z/QxMnVSoEmhwMSOsprTyrbPgxQbKcm+nrKCsBzRwEuiZ
         njBw==
X-Gm-Message-State: AOAM5316cW5y4gnQwOyX4HvsWjd809KKBPEEwTd9NI2SIrdJRJ4mUfhB
        3mXDXJiYzO0ft1xVOxTGd0vf8A==
X-Google-Smtp-Source: ABdhPJwxpOfXuv6cotmFZzp741peUAfZ1DvM/42bXPMHZ3Hu6NNBifSzcW5IDaES8dfStVLCixJ3Xg==
X-Received: by 2002:a17:902:d695:b029:d2:86d0:b6fb with SMTP id v21-20020a170902d695b02900d286d0b6fbmr637844ply.41.1601283299897;
        Mon, 28 Sep 2020 01:54:59 -0700 (PDT)
Received: from [10.86.118.224] ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q5sm697744pfb.184.2020.09.28.01.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 01:54:59 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
Date:   Mon, 28 Sep 2020 16:54:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928073202.GA2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/9/28 下午3:32, Peter Zijlstra 写道:
> On Mon, Sep 28, 2020 at 12:11:30AM +0800, Chengming Zhou wrote:
>> The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
>> deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
>> deadlock on rq lock in the printk path.
> It also shouldn't happen in the first place, so who bloody cares.

Yes, but if our box deadlock just because a WARN_ON_ONCE, we have to
reboot : (

So these WARN_ON_ONCE have BUG_ON effect ?  Or we should change to use
BUG_ON ?

Thanks.

>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  kernel/sched/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2d95dc3f4644..81d8bf614225 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4444,6 +4444,7 @@ static void __sched notrace __schedule(bool preempt)
>>  	 */
>>  	rq_lock(rq, &rf);
>>  	smp_mb__after_spinlock();
>> +	printk_deferred_enter();
>>  
>>  	/* Promote REQ to ACT */
>>  	rq->clock_update_flags <<= 1;
>> @@ -4530,6 +4531,7 @@ static void __sched notrace __schedule(bool preempt)
>>  		rq_unlock_irq(rq, &rf);
>>  	}
>>  
>> +	printk_deferred_exit();
>>  	balance_callback(rq);
>>  }
> NAK printk_deferred is an abomination, kill that.
