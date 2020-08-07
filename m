Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1428E23EC84
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgHGLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 07:30:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgHGLai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596799837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCKj1Ub5pGUVjIAFPQ0S7mbJ7Aa0u7tibFTJP9aEVbI=;
        b=djPTtHlC1oS0xTyeLYuPglb6Khe0ducXyXDJ0uZahBvEOvx1luRx2QxJZEclA+YD8fq7/2
        y2+bElYbBFgrLwGXCSrOo+tQG/YdWHZ3SHql2A0VSgbxE9DknsY9v5hCWJspYPDBQt3SYS
        u98meIDK8Hkfe/9OLINdOn3ToNXrPBM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Ps2iHvHFNZCgOxR622X66A-1; Fri, 07 Aug 2020 07:30:35 -0400
X-MC-Unique: Ps2iHvHFNZCgOxR622X66A-1
Received: by mail-ej1-f71.google.com with SMTP id sd23so779367ejb.14
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 04:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCKj1Ub5pGUVjIAFPQ0S7mbJ7Aa0u7tibFTJP9aEVbI=;
        b=eusPGlO7UNwgS2A5dk23JhYNPdsRMA+bZWGtmEVMzD3elqX5KfJUNFQra0tWbzVWV4
         jVxSElyjkPtm8xdQwBF3yLFCYQDIcBp6rlBhFhMTyX+1G37XdUCu6s/LAp7xAdE0d198
         vwzfpXMo+xZ8l1goeTq35nKAXyUoNYUJsfPw71b7XiB8gWUPqGCcDvzHcVNB0xAoVcRk
         RNoNLhTqp6cgL55xHV3Mjzn9gqiMxD1nuQ78MAZrO9W5X/5URJdOX0vI1FAK1CPTGh6D
         Pb4GWPV48Fqh5qNDSP0PqsJtXIJfybwXTgNaCCaIFAMBeZV8rzBSWWKFw6egcGkBq65k
         qWpw==
X-Gm-Message-State: AOAM533Bwii6JTQxZ+ei66b/3us4gN//T9XRh9Uh68ea/IJOK1idLho6
        XEUNLFDNAbYYTaPxIE6l8659J8UT94oZsrPIfY94xzhkXg8gjbaEydJsmYbN07Zk92ASmz69BeQ
        Oq8Zf75gISR/lckLbD1hZd5RG
X-Received: by 2002:a17:906:95d4:: with SMTP id n20mr9384648ejy.485.1596799834377;
        Fri, 07 Aug 2020 04:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3MwfwkXe4uLrNhb+rWQK0dJYBQ+SHlXRwTYpdoCxLlpdFKx8XXBJpgx7MCxjK6XTJ+j3B6Q==
X-Received: by 2002:a17:906:95d4:: with SMTP id n20mr9384621ejy.485.1596799834122;
        Fri, 07 Aug 2020 04:30:34 -0700 (PDT)
Received: from x1.bristot.me (host-87-16-204-193.retail.telecomitalia.it. [87.16.204.193])
        by smtp.gmail.com with ESMTPSA id dc23sm4924819edb.50.2020.08.07.04.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 04:30:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
To:     peterz@infradead.org, Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807104618.GH2674@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <383e33a0-bace-a387-b47e-30fbec4f18db@redhat.com>
Date:   Fri, 7 Aug 2020 13:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807104618.GH2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 12:46 PM, peterz@infradead.org wrote:
> On Fri, Aug 07, 2020 at 11:56:04AM +0200, Juri Lelli wrote:
>> Starting deadline server for lower priority classes right away when
>> first task is enqueued might break guarantees, as tasks belonging to
>> intermediate priority classes could be uselessly preempted. E.g., a well
>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
>> there are still CPU cycles available for NORMAL tasks to run, as they'll
>> be running inside the fair deadline server for some period of time.
>>
>> To prevent this issue, implement a starvation monitor mechanism that
>> starts the deadline server only if a (fair in this case) task hasn't
>> been scheduled for some interval of time after it has been enqueued.
>> Use pick/put functions to manage starvation monitor status.
> One thing I considerd was scheduling this as a least-laxity entity --
> such that it runs late, not early -- and start the server when
> rq->nr_running != rq->cfs.h_nr_running, IOW when there's !fair tasks
> around.
> 
> Not saying we should do it like that, but that's perhaps more
> deterministic than this.
> 

I agree, what we want here is something that schedules the server if it still
retains some runtime when the laxity is 0. But this is easier said than done, as
this would require another scheduler (other pros and cons and analysis (and
hours of work)...).

But, for the starvation monitor purpose, the goal is not (necessarily) to
provide a deterministic guarantee for the starving task, but to avoid system
issues while minimizing the damage to the "real" real-time workload. With that
in mind, we could relax our ambitions...

Thoughts?

-- Daniel

