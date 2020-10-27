Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D395729C7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829117AbgJ0Suj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1829134AbgJ0Sug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603824619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0Ba8mUgAE+0hU6zaMSaF5/fsLeGgzIX1yGstr4Luok=;
        b=cMHw1ZhaC3EVWWK9skZpX8RQGnGjXJpxEcinu9q9LtnoL8Ezs+duv9HmVpbg+8pRB0RfZI
        sntLomqSyI9iff5aM53stx/ghIELancR1D2DXZ1+oxc3uGgjt5t8OH3yzrbv19k0Gpp3bz
        IZYBWpI4MqNPTE4G752y34YU7xh2iLU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-ZB97D6P6P9mBG0tXGa3pDg-1; Tue, 27 Oct 2020 14:50:17 -0400
X-MC-Unique: ZB97D6P6P9mBG0tXGa3pDg-1
Received: by mail-wm1-f72.google.com with SMTP id b23so907329wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+0Ba8mUgAE+0hU6zaMSaF5/fsLeGgzIX1yGstr4Luok=;
        b=bk11MOHEW7AhzSNeD9gWBfcWowVkcwEWV7MDm8PoX8+S4JmLlfMqJxdOJuImqqIQbD
         sK2VWfXfswO8ImgV4NAmz+Ovv/t9TBqTJd7IF1x5QvhZMFG7xSVe/YEQdRbFzBVN1bso
         XXv4/YGfR9EveIiWWHoVk7+8eevbTPe3KlPc+43BaxosgiNdUQKE4np9Lc5eAP0yiULu
         xPjHDUKA8QsMmNMge2KnQWY1cboigk1mvxe9jBy/9vjN3z3RseDDSE5fQtz4WEyJ/ZhB
         nEpcvroFiY6xE+tSkrrJm/g0c4ETHMixWhqBKslHOuLd0ePuFVtDaXE0hT7PCWsPebBY
         nJaQ==
X-Gm-Message-State: AOAM5302lo7Ok26LkOYb6h8TWVpa/jgzDafz+O6Eq1lIr7GTRx+w8M5I
        MTHabLmmuNZVErvoxeHBvEzKb4RsJYXzjg15O2FxqxrnyMASf4rBXQX4uTOGLO3PJGNZwBkreRG
        sIHC1B0WRzHu4LMdHKUaz9+bG
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4432352wrn.52.1603824615605;
        Tue, 27 Oct 2020 11:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1G9oFzSvrpOHbfb2BWS1dQWrwHlZzXL2MnGZ5QN/1YxSdA1cwYTpx8mRXDExt+HsekkIKpQ==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4432325wrn.52.1603824615356;
        Tue, 27 Oct 2020 11:50:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x81sm2920137wmb.11.2020.10.27.11.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 11:50:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] sched: Add cond_resched_rwlock
To:     Peter Zijlstra <peterz@infradead.org>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20201027164950.1057601-1-bgardon@google.com>
 <20201027164950.1057601-3-bgardon@google.com>
 <20201027184440.GN2628@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31db67e0-bd9f-ff6d-2cee-b60ad52f71b2@redhat.com>
Date:   Tue, 27 Oct 2020 19:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027184440.GN2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/20 19:44, Peter Zijlstra wrote:
> On Tue, Oct 27, 2020 at 09:49:50AM -0700, Ben Gardon wrote:
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index d2003a7d5ab55..ac58e7829a063 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6152,6 +6152,46 @@ int __cond_resched_lock(spinlock_t *lock)
>>  }
>>  EXPORT_SYMBOL(__cond_resched_lock);
>>  
>> +int __cond_resched_rwlock_read(rwlock_t *lock)
>> +{
>> +	int resched = should_resched(PREEMPT_LOCK_OFFSET);
>> +	int ret = 0;
>> +
>> +	lockdep_assert_held(lock);
> 
> 	lockdep_assert_held_read(lock);
> 
>> +
>> +	if (rwlock_needbreak(lock) || resched) {
>> +		read_unlock(lock);
>> +		if (resched)
>> +			preempt_schedule_common();
>> +		else
>> +			cpu_relax();
>> +		ret = 1;
>> +		read_lock(lock);
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(__cond_resched_rwlock_read);
>> +
>> +int __cond_resched_rwlock_write(rwlock_t *lock)
>> +{
>> +	int resched = should_resched(PREEMPT_LOCK_OFFSET);
>> +	int ret = 0;
>> +
>> +	lockdep_assert_held(lock);
> 
> 	lockdep_assert_held_write(lock);
> 
>> +
>> +	if (rwlock_needbreak(lock) || resched) {
>> +		write_unlock(lock);
>> +		if (resched)
>> +			preempt_schedule_common();
>> +		else
>> +			cpu_relax();
>> +		ret = 1;
>> +		write_lock(lock);
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(__cond_resched_rwlock_write);
> 
> If this is the only feedback (the patches look fine to me), don't bother
> resending, I'll edit them when applying.
> 

If that is an Acked-by, I'll merge them through the KVM tree when time
comes.

Paolo

