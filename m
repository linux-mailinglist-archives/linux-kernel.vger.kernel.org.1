Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F120B2BA5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgKTJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKTJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:19:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:19:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c66so7286050pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IygXYP7GoIR4IgC4uGQkuOXO7d8DopxXyT6+x9GrikY=;
        b=OTdVN10FOYhL0/gJqBWg2CC2lNAb8Ofmz+oL4HxCgQCw7HultqxETm8stIfLHCTIR/
         jZqep2nxW0vXOdEV2sRBQMzipd/4mZSBnbgUjVhFQjxwxfp9eSv/SKZ+Ff65XKra4XgA
         aJpehStWemRssTlaL4zSpGKxoFMRaPX6SrKdBC0+l+3kApvvsy96VWt5errqjcOSLS2+
         7JvdhhPqNDLxsco1aKn24NHVd6wNnFm+A4dfUX6En/xaG3VG3onZu1Y1OrdGFUx8pUQh
         lj5+uafktlJmEkOMDjI3Yt9Gh0U7A12fYveTIJMiLPgQHmyp41oGaaKaWkOgbOzII7l2
         B/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IygXYP7GoIR4IgC4uGQkuOXO7d8DopxXyT6+x9GrikY=;
        b=VIuaBgt2Y3e6+a8S9NlnogUxQbOJax8oHOGq4s33rz1FQluyK3x+pZbT4BPzEYAXJ0
         YAL4Ls63phMY1+NHoVCUy0hegyOKBnDi00WboAVNP0AAkKygjDhidk9tRzH+N1HJr171
         hJkvjzX6qiqq89mBqqZnWmi+saYThjGWTy5y2YqijQOeiI6ums4z6DB9mlEA28e5m333
         IfJ2iCJz0H6dguQkq/eAL39Cn1Xr7Lid43uUyegXrdGP3DoC/bT28kOJ8WtYoXjO4jUV
         JEMT6YcFdFDzvxSZAs/hnMVjAPWnoVSfvfhEllW48c2N7YVIrxjrP7rg8AGPeCrWJWPO
         PDtw==
X-Gm-Message-State: AOAM531Y+sPi0ILu+X5/2ftpbv+OXGVXaekGkkRJAtoudbdE4YYp1aYO
        qe1yDTMg0hDAgEb8g0IouuRpeQ==
X-Google-Smtp-Source: ABdhPJykh61i3oEEXP5vKhrqRbMeITZKn7AShK9em5yjq8+cshPtTMAPHknfR8oAunQtpo4gXamESQ==
X-Received: by 2002:a63:194d:: with SMTP id 13mr16807910pgz.317.1605863946567;
        Fri, 20 Nov 2020 01:19:06 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id w13sm2911340pfd.49.2020.11.20.01.19.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 01:19:05 -0800 (PST)
Date:   Fri, 20 Nov 2020 14:49:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201120091904.6zvovj2yxjxtnq2x@vireshk-i7>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201120085653.GA3092@hirez.programming.kicks-ass.net>
 <20201120091356.GA2653684@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120091356.GA2653684@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-20, 09:13, Quentin Perret wrote:
> On Friday 20 Nov 2020 at 09:56:53 (+0100), Peter Zijlstra wrote:
> > On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
> > >  - In saturated scenarios task movement will cause some transient dips,
> > >    suppose we have a CPU saturated with 4 tasks, then when we migrate a task
> > >    to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
> > >    new CPU will gain 0.25. This is inevitable and time progression will
> > >    correct this. XXX do we still guarantee f_max due to no idle-time?
> 
> The sugov_cpu_is_busy() logic should mitigate that, but looking at it
> again I just realized we don't apply it to the 'shared' update path. I
> can't recall why. Anybody?

t b7eaf1aab9f8bd2e49fceed77ebc66c1b5800718
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Wed Mar 22 00:08:50 2017 +0100

    cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely
   
   [skip]
    
    This is unlikely to be an issue on systems where cpufreq policies are
    shared between multiple CPUs, because in those cases the policy
    utilization is computed as the maximum of the CPU utilization values
    over the whole policy and if that turns out to be low, reducing the
    frequency for the policy most likely is a good idea anyway.  On
    systems with one CPU per policy, however, it may affect performance
    adversely and even lead to increased energy consumption in some cases.
    
    On those systems it may be addressed by taking another utilization
    metric into consideration, like whether or not the CPU whose
    frequency is about to be reduced has been idle recently, because if
    that's not the case, the CPU is likely to be busy in the near future
    and its frequency should not be reduced.

-- 
viresh
