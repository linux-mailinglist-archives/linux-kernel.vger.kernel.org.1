Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6326BC03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 07:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIPF4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:56:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CDC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:56:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so978124pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PyJpRejCCxPh/nnkiT5lYQR6vzYVBlBqRRVevWzgDgs=;
        b=oQP/qoI9cm0wd9Lhiy/DNnRpKfa08CLU5u97M6Xsdt53si7+wRG+lDpjBpCjVLF7YA
         /qYHS1+zmPngFnWwdSnadxnb0btTE4D83lVCApQmTQcEufHkj884KNFFDJtMqwnRSbBe
         6amLunedN5FBNeWKn7mykbOz366IlZM+c9Ci+uH68GuPMlmaUpY45N2nvaXrdqKcET/e
         tQOcwvSHrflxwsVzrL6thF/dZlibhSfuRbhN93zzZ8Elb+cFL5WjWmlfkmck07od/oPL
         aqT0LFBQ2Feo91KWNe5YWx0Fp8DkbcDSfbeWXbO8UeqZjc8znfF4BwOShEt2vAw55J3j
         lQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PyJpRejCCxPh/nnkiT5lYQR6vzYVBlBqRRVevWzgDgs=;
        b=O+22EbSi4Xl8qImTU0m+Ya+8xsRe7i9kfCxfIaqGuu91BYjDzBxpHJShAfKqAL+WYB
         b3FQ6zwT38WKH5Bh0UxViRdLrkiHZzmC0nYxXfF9cD705CztmYBqT7SV4d3FKeIqw9rJ
         3EmJwcMoNESnEF/5rhg4Hu5COJHv7mLHZe2FW4xhywTdsYkNiJuEzUirLRwxFppgi6vD
         xzEniV0UUlOzgweQYM4ldnjGzHQBeZld+LcF02M1LptY8/zek6gZoDxmf5nt75jv0Ze2
         P60iu08Y+dZNEwdHXipbt4oSnMOwD6HNOBK+6DvGQyYCg+Ez4n7WPycl1ehv6oy2ZRBi
         i/jw==
X-Gm-Message-State: AOAM530afxF/9IJoyoPkn39EuV4PHmRr2sAr0a7EKh2UNk8lz0vQJIvt
        /Gl3Ykq5zG0qz5VS1f2VUJ7/MQ==
X-Google-Smtp-Source: ABdhPJytCYV1eL6dVOXXq/TtuS96mBhckOBdmELoYmq8WFkj/WAskbMrE/JW90tE0oUK/LQ+lMANXw==
X-Received: by 2002:a17:90a:8a04:: with SMTP id w4mr2542531pjn.72.1600235806982;
        Tue, 15 Sep 2020 22:56:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id g129sm3801342pfb.9.2020.09.15.22.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 22:56:45 -0700 (PDT)
Date:   Wed, 16 Sep 2020 11:26:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200916055641.g654zoukjeqpjmwz@vireshk-i7>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
 <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
 <bd6e6d93-7491-0971-3bed-27d1885c38cd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6e6d93-7491-0971-3bed-27d1885c38cd@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-09-20, 11:04, Lukasz Luba wrote:
> Hi Viresh,
> 
> On 9/2/20 8:24 AM, Viresh Kumar wrote:
> > In order to prepare for lock-less stats update, add support to defer any
> > updates to it until cpufreq_stats_record_transition() is called.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
> >   1 file changed, 56 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index 94d959a8e954..fdf9e8556a49 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -22,17 +22,22 @@ struct cpufreq_stats {
> 
> Would it be possible to move this structure in the
> linux/cpufreq.h header? Any subsystem could have access to it,
> like to the cpuidle stats.

Hmm, I am not sure why we should be doing it. In case of cpuidle many
parts of the kernel are playing with cpuidle code, like drivers/idle/,
drivers/cpuidle, etc.

Something should land in include/ only if you want others to use it,
but in case of cpufreq no one should be using cpufreq stats.

So unless you have a real case where that might be beneficial, I am
going to keep it as is.

> Apart from that (and the comment regarding the 'atomic_t' field)
> I don't see any issues.

Thanks.

-- 
viresh
