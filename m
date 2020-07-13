Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13CB219BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgGIJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:09:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A592C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:09:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so834657pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dfRkitREAl1cCOBzHtF2sXnD7um5XaadlgUl3USHzOw=;
        b=vRZqKThIDXkF1WZVYjCd+lAU6Yw2xjVCcYtJIao696XqXbwd91uA7uJ5g1mR35cCFB
         rZr5VYDRmnjk9boh6Jl5KyqMTPrY2H0G8FIPX9kZMMCJPuMs+cBqkQKxNe1W3lYR78eH
         FaDvwzxnmHT5f6eztfFL7bkqinHccld+C1fydY+Qf2Rf7XdsUzJs1yIBEsg04ZFanFWe
         CFTvMh7apsM6QnpAVOUY5cjzNo85yhDwcicI+HX+8QaqeD9tHp0W2Rw4UnVEHSDGHPIR
         LEpTCKYLqF5yE0phZTENtyuOY4JTQ61JAFBPpDquOfQkBPwEsUM6VfBzbZKzL88cLkdf
         uAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dfRkitREAl1cCOBzHtF2sXnD7um5XaadlgUl3USHzOw=;
        b=ZmTsgvTVKuC73JCgsRR4Al8wLizMrEgkTDBxyGLlViYzgvTJF9bE52YVAKUd0hLy80
         c5q7J/qiIcs7Y/YA2AEB14abYDlXqBA/mYXMyPCgW547WiuadIsXefAAZmRxkwtFMmvc
         chMAl3bQBOSSo3JmbXR2LA/D3X7yBG0ABfUCtmvxnBqLDavBSMH/lPnh60SQu4tvHA9Y
         /B1wCe/yYlg3U5xP+wF0DHzG7YS4rHUnJv6KH5KwLnHAe3Th9Dj4Id0hqFDmF1uUktY4
         dfrybN0MUP11sDnDvqxNejhdtAGdbplckSmUSLU12H0YwJ12nExW48mElhQ3No1Yq0K7
         GBeQ==
X-Gm-Message-State: AOAM531M1kRoebOpzdKEgSxoOxn/ytVjLMGJgG9g4r2xX9RdQTtGL+vH
        N9CCV1kABYBBT44bcltrL5ROvw==
X-Google-Smtp-Source: ABdhPJxrn0x/9eaXzBdCUMoLFcH5nlz8yRsfA6f4zpfmqLIKKts2GJNGLlHeTT9csCf0DTwa8Bx4bA==
X-Received: by 2002:a17:90a:b00e:: with SMTP id x14mr14377506pjq.57.1594285755440;
        Thu, 09 Jul 2020 02:09:15 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id u19sm2364195pfk.98.2020.07.09.02.09.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 02:09:14 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:39:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
Message-ID: <20200709090912.vapouiruidgypxzc@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
 <20200701133330.GA32736@arm.com>
 <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
 <20200702025818.s4oh7rzz3tr6zwqr@vireshk-i7>
 <20200702114425.GB28120@arm.com>
 <389dd87f-fed0-e4ea-81f3-5491fd2a54d1@arm.com>
 <20200709085354.GA5623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709085354.GA5623@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-20, 09:53, Ionela Voinescu wrote:
> On Monday 06 Jul 2020 at 14:14:47 (+0200), Dietmar Eggemann wrote:
> > Why can't we just move the arch_set_freq_scale() call from cpufreq
> > driver to cpufreq core w/o introducing a FIE related driver flag?
> > 
> > Current scenario for Frequency Invariance Engine (FIE) on arm/arm64.
> > 
> > +------------------------------+       +------------------------------+
> > |                              |       |                              |
> > | cpufreq core:                |       | arch: (arm, arm64)           |
> > 
> > |                              |       |                              |
> > | weak arch_set_freq_scale() {}|       |                              |
> > |                              |       |                              |
> > +------------------------------+       |                              |
> >                                        |                              |
> > +------------------------------+       |                              |
> > |                              |       |                              |
> > | cpufreq driver:              |       |                              |
> > |                            +-----------> arch_set_freq_scale()      |
> > |                              |       |   {                          |
> > +------------------------------+       |      if (use counters)       |
> >                                        |        return;               |
> > +------------------------------+       |      ...                     |
> > |                              |       |   }                          |
> > | task scheduler:              |       |                              |
> > |                            +-----------> arch_scale_freq_tick()*    |
> > |                              |       |   {                          |
> > 
> > |                              |       |      if (!use counters)      |
> > |                              |       |        return;               |
> > |                              |       |      ...                     |
> > |                              |       |   }                          |
> > +------------------------------+       +------------------------------+
> > 
> > * defined as topology_scale_freq_tick() in arm64
> > 
> > Only Arm/Arm64 defines arch_set_freq_scale() to get the 'legacy' CPUfreq
> > based FIE. This would still be the case when we move
> > arch_set_freq_scale() from individual cpufreq drivers to cpufreq core.
> > 
> > Arm64 is the only arch which has to runtime-choose between two different
> > FIEs. This is currently done by bailing out early in one of the FIE
> > functions based on 'use counters'.
> > 
> > X86 (and others) will continue to not define arch_set_freq_scale().
> > 
> > The issue with CONFIG_BL_SWITCHER (vexpress-spc-cpufreq.c) could be
> > solved arm/arm64 internally (arch_topology.c) by putting
> > arch_set_freq_scale() under a !CONFIG_BL_SWITCHER guard.
> > I doubt that there are any arm bL systems out there running it. At least
> > I'm not aware of any complaints due to missing FIE support in bl
> > switcher setups so far.

I agree to that.

> Thank you Dietmar, for your review.
> 
> I was trying to suggest the same in my other replies.

I am sorry, I must have overlooked that part in your replies,
otherwise I may agreed to it :)

> Rafael, Viresh, would you mind confirming whether you still consider
> having an 'opt in' flag is preferable here?

Well, we wanted an opt-in flag instead of an opt-out one. And no flag
is certainly better.

-- 
viresh
