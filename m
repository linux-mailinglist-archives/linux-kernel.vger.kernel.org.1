Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AC1E7A12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgE2KJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2KJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:09:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6ADC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 03:08:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so2869312wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGCTr//CJ/0Q2eA0EeEmXyU8B15617Zs/uV0IexoscQ=;
        b=Y11uIhOmRXyo7ieDj5COXVZGcR2zPt8sa+tZoxdWPwOhh82K5aMgVHdKX8MwCKQog6
         R5xkeI26afEweBp7Mx7N7MkVhsgf+2kKhl8P2I8yKYZyAHWvoHSt/vK1imWNu4m3iKGH
         pOwGMBJuSK1v0vztOth0Idw9xsAZeoIm1s9KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGCTr//CJ/0Q2eA0EeEmXyU8B15617Zs/uV0IexoscQ=;
        b=U1iYa22nRLgQ+snv9PACZtgiRVcUXTFPl/gd62JEFulOsYi7oiw3WS34qpMfvXbgUF
         0Wyh1jy059QPUD1zbjz9xnhGbt/4wRTDXAO4GecYWWrpRFT9lRERjZ8Ou7umaQs2bhsh
         nqHl+Oj9yqBAN9biHh9Hven7WYbDBzzp8q5f8Wv75f22AZnaBpwAt4KinDyqOZJI0bI+
         HQhXl16g6MWBd3HloOKvC56XmmsurbUgpAY2G/EdY5lZaEF5nvopdjPZ5yFsiQDrH3F+
         Y0ew1kNSGUuE3dfINbTG+th65qodZ7MKjUhfItEMyGonpskVPbWFpxMDuWBzGnFwRM/e
         A21g==
X-Gm-Message-State: AOAM532oWWa56l0ioCMpfygNAQKv5SOQ6lLh/JiW/I9iT+8cYWBlAC8n
        YvqvtFfZmnAcJucpGbDnW23Hyw==
X-Google-Smtp-Source: ABdhPJz4oOMKF3Tw/lvTsl28+bPqerfZ7GakdrKgkU82JOD5fD05mK5sPA441ncYZFjSEnddQ8N/rQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr5190933wrq.328.1590746938609;
        Fri, 29 May 2020 03:08:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id z12sm10088964wrg.9.2020.05.29.03.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:08:58 -0700 (PDT)
Date:   Fri, 29 May 2020 11:08:58 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200529100858.GA98458@chrisdown.name>
References: <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
 <20200521184505.GA815980@cmpxchg.org>
 <20200528163101.GJ27484@dhcp22.suse.cz>
 <20200528164848.GB839178@chrisdown.name>
 <20200529073118.GE4406@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200529073118.GE4406@dhcp22.suse.cz>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>> > > task->memcg_nr_pages_over_high is not vague, it's a best-effort
>> > > mechanism to distribute fairness. It's the current task's share of the
>> > > cgroup's overage, and it allows us in the majority of situations to
>> > > distribute reclaim work and sleeps in proportion to how much the task
>> > > is actually at fault.
>> >
>> > Agreed. But this stops being the case as soon as the reclaim target has
>> > been reached and new reclaim attempts are enforced because the memcg is
>> > still above the high limit. Because then you have a completely different
>> > reclaim target - get down to the limit. This would be especially visible
>> > with a large memcg_nr_pages_over_high which could even lead to an over
>> > reclaim.
>>
>> We actually over reclaim even before this patch -- this patch doesn't bring
>> much new in that regard.
>>
>> Tracing try_to_free_pages for a cgroup at the memory.high threshold shows
>> that before this change, we sometimes even reclaim on the order of twice the
>> number of pages requested. For example, I see cases where we requested 1000
>> pages to be reclaimed, but end up reclaiming 2000 in a single reclaim
>> attempt.
>
>This is interesting and worth looking into. I am aware that we can
>reclaim potentially much more pages during the icache reclaim and that
>there was a heated discussion without any fix merged in the end IIRC.
>Do you have any details?

Sure, we can look into this more, but let's do it separately from this patch -- 
I don't see that its merging should be contingent on that discussion :-)
