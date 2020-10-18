Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C11929166F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJRI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 04:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgJRI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603009643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lBT3OTVFipCR4zZkozYGoBkHRhMOkVqglG62jYQatI=;
        b=M/AVa9X82wGv/azCMR4i4Z9lYRu2IPNUWDk69eQ41cN++uXodHxa8NImvOvzdc8K8rqZ7c
        /kkrCct7dRRjfrImyw7HbOMZL2gBksFXISsyVPRgFguQ+dPoobp4XVjER7H2cVl3arfU44
        R+zi395bYCD/vMKjbltI2feMK2tXh2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-lIRewBZLOUi2dwr3LdQXrA-1; Sun, 18 Oct 2020 04:27:21 -0400
X-MC-Unique: lIRewBZLOUi2dwr3LdQXrA-1
Received: by mail-wr1-f70.google.com with SMTP id f11so5887081wro.15
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/lBT3OTVFipCR4zZkozYGoBkHRhMOkVqglG62jYQatI=;
        b=F1PNaJxleM1EmLTZRA870VTsjCousjeEpgplQoky/ru0rnlIJ0ddxbm1Hp8DTZeVLT
         EjrePvi57TyVmlz0HkSO1t43Ykasxzbz+eSvaJZaATBQoKf3+r/C9Z8q89ZWr9rMyJAs
         yWgXBKIh1hmFY2j8CVKTI9lCXEZ6t31L/wkq+XZ19jSxOGHYm/vCl6eUsr2c1LA3FPWD
         NjEmFgnvTP7z0vZpjvYVmwGkb5TH1sXMab6nxl41RvUFF+Z3DTCnOJVKYQevsZKWO8sb
         qTx2ZZ5X3E/69aifN/ITHnrf/AxaFd/ZiEV+dF54+RjWqVLs+M4BoujGLXO/ciPA4XAd
         jLYA==
X-Gm-Message-State: AOAM533zzY2oerOL1us3nQbG9jUEyy6AYOkxuSg6x9Cey5kXkyh0aQp4
        /JXGSQO3BPEI11QtarpH9aA7xONXnsUbWeZlXPmDe4JjUQli6MP/7SQTj6ky6KryHDdE0YPCIop
        O+/W0kDNwvyYhivjMlvYloIhs
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr13779086wrn.257.1603009640141;
        Sun, 18 Oct 2020 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAgCPSumCgfVdKfGznnm7YeSUUw2RZd8R4TsnET+Z4/8ID3k5gFkvBsav4aIlMXzHcTGpBzw==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr13779058wrn.257.1603009639883;
        Sun, 18 Oct 2020 01:27:19 -0700 (PDT)
Received: from x1.bristot.me (host-79-33-206-95.retail.telecomitalia.it. [79.33.206.95])
        by smtp.gmail.com with ESMTPSA id u202sm11287729wmu.23.2020.10.18.01.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 01:27:19 -0700 (PDT)
Subject: Re: [PATCH v6 0/2] sched/deadline: Fix and optimize
 sched_dl_global_validate()
To:     Juri Lelli <juri.lelli@redhat.com>, Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, valentin.schneider@arm.com, raistlin@linux.it
References: <cover.1602171061.git.iwtbavbm@gmail.com>
 <20201014133247.GC219214@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <5ce38799-f7cd-6dcb-3e10-5e4767510094@redhat.com>
Date:   Sun, 18 Oct 2020 10:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014133247.GC219214@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/20 3:32 PM, Juri Lelli wrote:
> Hi,
> 
> On 08/10/20 23:47, Peng Liu wrote:
>> When change global rt bandwidth, we check to make sure that new
>> settings could accommodate the allocated dl bandwidth.
>>
>> Under SMP, the dl_bw is on a per root domain basis, currently we check
>> and update the new settings one cpu by one cpu, but not in the unit of
>> root domain, which is either overdoing or error.
>>
>> patch 1 removed the superfluous checking and updating
>> patch 2 fixed the error validation
>>
>> For details, please see the corresponding patch.
>>
>> ----------------
>> v6 <-- v5:
>>  - no functional changes, just revert visit_gen back to u64;
>>
>> v5 <-- v4:
>>  - no functional changes, just split the v4 single patch to two to
>>    obey the "one patch do only one thing" rule;
>>  - turn root_domain::visit_gen from u64 to u32;
>>    both suggested by Juri.
>>  - refine changelog;
>>
>> v4 <-- v3:
>>  - refine changelog;
>>  - eliminate the ugly #ifdef guys with Peter's method;
>>
>> v3 <-- v2:
>>  - fix build error for !CONFIG_SMP, reported by kernel test robot;
>>
>> v2 <-- v1:
>>  - replace cpumask_weight(cpu_rq(cpu)->rd->span) with dl_bw_cpus(cpu),
>>    suggested by Juri;
>>
>> Peng Liu (2):
>>   sched/deadline: Optimize sched_dl_global_validate()
>>   sched/deadline: Fix sched_dl_global_validate()
>>
>>  kernel/sched/deadline.c | 44 +++++++++++++++++++++++++++--------
>>  kernel/sched/sched.h    | 51 ++++++++++++++++++++++-------------------
>>  kernel/sched/topology.c |  1 +
>>  3 files changed, 63 insertions(+), 33 deletions(-)
> 
> These look now good to me. Thanks a lot!
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>


I just found a minor thing in a comment:

"It's *monotonously* increasing."

I tried to find the usage of "monotonously increasing" for monotonic functions,
and I did not find it. The (as least most used) term is "monotonically," so the
sentence would be like "It is a monotonically increasing value." But it is just
a minor thing. Anyways:

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

