Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852C72748BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVTEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVTEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600801463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZccvJ/RTL98VlmcqeRA6m6b3FraA4vVy6lTebWRLFU=;
        b=NsdMmRirrJNcsJMaWKMFy8gbGf9ksfhsgxXIcWF75A2c9fyQAYmB3Jow7rdEZ+dlI9fAXg
        ePUSNS8YJYT5jhOxYo4iUEDQUYZ16QsOYSq10UgS4cuy1HIPglckrMFelqkU9OP5pGwu7Z
        fecIlbH+16RpYuclta9AkxatwTr3TIE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-KR1iMKB1M_qmOG6a9-qfXg-1; Tue, 22 Sep 2020 15:04:21 -0400
X-MC-Unique: KR1iMKB1M_qmOG6a9-qfXg-1
Received: by mail-wr1-f71.google.com with SMTP id g6so7825740wrv.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZccvJ/RTL98VlmcqeRA6m6b3FraA4vVy6lTebWRLFU=;
        b=BzN0gu9DDPPeQ8Odi+wW19PbWWnKYWZrMBocB3bCP1GkYM5r2fr9sxEGSVTWnjT3SM
         dYI8XraFmT/XzUw7eko/Jag0yC2YlTy5S+muNfyCAexcjsZSDnKalEy9N0vAS1WhitU7
         hO6IfcQ4VEUNbqnWJpUgBMkockpKlZ0hbkHKJ0iX1Du0W+iwbWXcKT16B7UlKBiAeYi5
         wBukUSuiVXt3udMskVh5QeHvh0lJJIUA+lxQ0VUOuqsnKoWSI+ogP7dtlgvPPD1ReMht
         QRL2L96TMDZOQ2Weppto2Tg7s6Fdp3KoIu4vA9ycb122+MwiBLhYx4mU6/ZncAWM2dZe
         JBNA==
X-Gm-Message-State: AOAM53328B62grwpptwBgnS0W4jzTe79TmZvqeJBPdddQCMUHDz4W+Si
        46K+g2VjJY/mZc6Ffx0N8g9yGTyDNVVbEyUUZKhXds7tBjzoISkCcx1fuxo9bL9mmLLJjXo7TGB
        ntITrAE7LUYUc+dCkviKKVj+j
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr6980292wrt.122.1600801460336;
        Tue, 22 Sep 2020 12:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfNhV5tOvjhDYiyJ2vYzWzaPnYBHHBkujU6kvUsaiZHQMRp9GTJw4X/nb8xieHddSsr/bItg==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr6980278wrt.122.1600801460136;
        Tue, 22 Sep 2020 12:04:20 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id r15sm5343529wmn.24.2020.09.22.12.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 12:04:19 -0700 (PDT)
Subject: Re: [PATCH] sched/rt: Disable RT_RUNTIME_SHARE by default
To:     Wei Wang <wvw@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "J . Avila" <elavila@google.com>, Todd Kjos <tkjos@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
 <CAGXk5yp4ubupTKDg1s+ZbK3cj_aKh9pQJzshWoZ3CvqnQLJX=A@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <64eca989-f2e7-033f-bb49-084f27c7209b@redhat.com>
Date:   Tue, 22 Sep 2020 21:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAGXk5yp4ubupTKDg1s+ZbK3cj_aKh9pQJzshWoZ3CvqnQLJX=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 7:14 PM, Wei Wang wrote:
> On Mon, Sep 21, 2020 at 7:40 AM Daniel Bristot de Oliveira
> <bristot@redhat.com> wrote:
>>
>> The RT_RUNTIME_SHARE sched feature enables the sharing of rt_runtime
>> between CPUs, allowing a CPU to run a real-time task up to 100% of the
>> time while leaving more space for non-real-time tasks to run on the CPU
>> that lend rt_runtime.
>>
>> The problem is that a CPU can easily borrow enough rt_runtime to allow
>> a spinning rt-task to run forever, starving per-cpu tasks like kworkers,
>> which are non-real-time by design.
>>
>> This patch disables RT_RUNTIME_SHARE by default, avoiding this problem.
>> The feature will still be present for users that want to enable it,
>> though.
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  kernel/sched/features.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>> index 7481cd96f391..68d369cba9e4 100644
>> --- a/kernel/sched/features.h
>> +++ b/kernel/sched/features.h
>> @@ -77,7 +77,7 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
>>  SCHED_FEAT(RT_PUSH_IPI, true)
>>  #endif
>>
>> -SCHED_FEAT(RT_RUNTIME_SHARE, true)
>> +SCHED_FEAT(RT_RUNTIME_SHARE, false)
>>  SCHED_FEAT(LB_MIN, false)
>>  SCHED_FEAT(ATTACH_AGE_LOAD, true)
>>
>> --
>> 2.26.2
>>
> 
> Tested on an Android device and can no longer see long running RT
> tasks (yes, Android have those for reasons).
> 

So:

Tested-by: Wei Wang <wvw@google.com>

?

Thanks!
-- Daniel

