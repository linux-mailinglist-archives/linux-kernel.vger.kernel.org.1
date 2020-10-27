Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672A029AB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899550AbgJ0Ls2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:48:28 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39535 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897227AbgJ0Ls0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:48:26 -0400
Received: by mail-pl1-f175.google.com with SMTP id x23so617569plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFoX/nPlMdfVA5ftTW+3xAKSzT05mQ8RbVahvp6lNY0=;
        b=qCyUwwqt7rpSBuYVKF4yqy7bF1pi3AV7jHWr1VCycFqyW3QNWqkoS0EOBuo2rkXwpm
         Py166u7NDG+jFS2hrFZccsCfo9UigarNhMBh7fp73DqvJrPCK6mVGDsA1+Y5VgI1X7JM
         XiWKzOifUlrhbUqqbT/G3iJ+75IWo752Ww5X1V7Zb5LYvzUxQKsTuJIfnkJWv2QUlL/Y
         XoEFMQe3OBHH8vprDnZUD0BrpOOBbJPanrFrw/NXmcGkswduyfi03rrhVYYOfMwS06qI
         bL6Wd7qrgRtXYHreqpHFJ5UXWHzQC0V8yPfkPYdvz7E8u/NHMjrlXrXVQehsP+BmFUDa
         y9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFoX/nPlMdfVA5ftTW+3xAKSzT05mQ8RbVahvp6lNY0=;
        b=I2pfqtSYhIC0aMKy7Ox1IPAJwbS/nk02U7n3dNJG67LerSJcojYsNrjdwaI6rW/L04
         v96OVVP36UzfcJNmAMgYrxX07CD09OaVpI7aD7RT58weP+rHo5ClHAIuITlgbiNPBXdU
         1It8CXu6lpIuVFx1SI+yFeeBQUFkDNpPkeToyEgU9YviS0wGiHjqLOmWdLV22PSAMxrN
         HEaxAGsE2f/kwnhND+3n5oMe1rwLh8TqY0x5CDwcD1Wmzb97Lto/gTE8ZPOrL6TX6PNC
         O1Lo76CuAFwBqLc6a5AP8LpWVGsP/Rvgg3/Ej48Z94/EZdN3JwPZ6BahgHVa8VqAFCqF
         2mMg==
X-Gm-Message-State: AOAM530pu6a61y4k7A77x0h/tkxm2Zh2kqjYamtFV5Ooe7b4cowNfppI
        hAsuxp1cDjuXYmxnptLJ17m7jQ==
X-Google-Smtp-Source: ABdhPJx+Rt0FrtY6sTkGXCX1xWUhXXmPLg/IT6YgUlkLQi0vVWpxEgVrwjp7rdpD1IamJ+344Bfq5g==
X-Received: by 2002:a17:90a:e697:: with SMTP id s23mr1627362pjy.16.1603799305891;
        Tue, 27 Oct 2020 04:48:25 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id f5sm1867196pgi.86.2020.10.27.04.48.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 04:48:24 -0700 (PDT)
Date:   Tue, 27 Oct 2020 17:18:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201027114822.vsh7vpwfnh2tvmpz@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201022071145.GM2628@hirez.programming.kicks-ass.net>
 <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <20201027111133.ajlxn5lbnfeocfgb@e107158-lin>
 <jhjlffrq58y.mognet@arm.com>
 <20201027114214.irsgdlfvyo46jpww@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027114214.irsgdlfvyo46jpww@e107158-lin>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-10-20, 11:42, Qais Yousef wrote:
> On 10/27/20 11:26, Valentin Schneider wrote:
> > 
> > On 27/10/20 11:11, Qais Yousef wrote:
> > > On 10/22/20 14:02, Peter Zijlstra wrote:
> > >> However I do want to retire ondemand, conservative and also very much
> > >> intel_pstate/active mode. I also have very little sympathy for
> > >> userspace.
> > >
> > > Userspace is useful for testing and sanity checking. Not sure if people use it
> > > to measure voltage/current at each frequency to generate
> > > dynamic-power-coefficient for their platform. Lukasz, Dietmar?
> > >
> > 
> > It's valuable even just for cpufreq sanity checking - we have that test
> > that goes through increasing frequencies and asserts the work done is
> > monotonically increasing. This has been quite useful in the past to detect
> > broken bits.
> > 
> > That *should* still be totally doable with any other governor by using the
> > scaling_{min, max}_freq sysfs interface.
> 
> True. This effectively makes every governor a potential user space governor.
> 
> /me not sure to be happy or grumpy about it

Userspace governor should be kept as is, it is very effective to get
unnecessary governor code out of the path when testing basic
functioning of the hardware/driver. It is quite useful when things
don't work as expected.

-- 
viresh
