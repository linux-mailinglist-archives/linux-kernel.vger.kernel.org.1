Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAC20AE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgFZIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgFZIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:09:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F5C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:09:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t194so8482663wmt.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rbLxPkU5zn6HuEV/rtbUuP7BkhVC3DU9UZS2cCgUUqs=;
        b=UrQ53aSAoNkLtJVEW6BDnSQ+6v0IYcarF2DEe3WeSNTvG7qhv/sVQjRNLftA1/WvTd
         rNga5sYIc0HtDHBmVny1DPoauZqqRn8iO8KpontGuzATd0MHdoAWU2xr9Xj1OdEZFShN
         YDyZbpxLiDck3HTKArsqvk3lNFCR9A3pAYLmA6qSCdm8CfqftPGBgmrcX9TEKwjrXI2N
         5hHn8+dFFTpVRNncH7Cjn1dfaEH2KxtiaeXc3itC4vpSwRpS8lfJSsx5i4+AdUM9twU8
         4t6q0s/b2Yh5yiyi4k3UnlXnyjPddkjPNH2OvXBekElzPhoJferFRvZJdJjRxutlfkZL
         jeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbLxPkU5zn6HuEV/rtbUuP7BkhVC3DU9UZS2cCgUUqs=;
        b=WZ9eL1rLVZyaVBPMgDjG6b0msUbJDke6aILCMt+hthflLL82lCyZBAHDdS9LSDXAbx
         AoRL+s2pCpsKhXRsBsPP4Fny/vXus3n5Hkbn28clno273vEZe6/t8UMCubD4JMNZet87
         tww6f1BJ8wAuXG+3Hd9xgulWj9cYAjn68MSklWpix+CFWXHac3OG5fjnRZZnByA03GN5
         j7rw1eXjxmXZ00xnDOIvUvsv5Fq7pSXl0PlVkxq81/rIwEv+ffnyHcA9rPZ8hXHEUgEW
         mWDNADZCXIjdotmveNky3ctrDWHN43g0Vg8Jt3kxgl1snl4Fwy1WxIxBgwvFAB0iTDyh
         dr0Q==
X-Gm-Message-State: AOAM5325fH0+WvqNS2spOf5mSJHR2NowO4xzNc5bhYjomdT0dXIA31Ll
        vkFHNkI+smy0DDMmlxEXtxZ5vU+5mfUVmw==
X-Google-Smtp-Source: ABdhPJx1PfO/ReemODrB6fHZaYmkTV/XN0aLHdRmjz7wS+SEB2F1Yigl4vidu1EkS+IX0ywuZs+W1w==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr2196788wmh.73.1593158968078;
        Fri, 26 Jun 2020 01:09:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id d2sm35925710wrs.95.2020.06.26.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:09:27 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:09:24 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200626080924.GA281178@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200626025346.z3g3ikdcin56gjlo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626025346.z3g3ikdcin56gjlo@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 Jun 2020 at 08:23:46 (+0530), Viresh Kumar wrote:
> On 23-06-20, 15:21, Quentin Perret wrote:
> > @@ -2789,7 +2796,13 @@ static int __init cpufreq_core_init(void)
> >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> >  	BUG_ON(!cpufreq_global_kobject);
> >  
> > +	mutex_lock(&cpufreq_governor_mutex);
> > +	if (!default_governor)
> 
> Also is this check really required ? The pointer will always be NULL
> at this point, isn't it ?

Not necessarily in this implementation -- the governors are registered
at core_initcall time too, so I don't think we can assume any ordering
there.

But it looks like your new version has fixed that by design, so I'll go
look at it some more, and try it out.

Thanks for the help!
Quentin
> 
> > +		default_governor = cpufreq_default_governor();
> > +	mutex_unlock(&cpufreq_governor_mutex);
> > +
> >  	return 0;
> >  }
> >  module_param(off, int, 0444);
> > +module_param_string(default_governor, cpufreq_param_governor, CPUFREQ_NAME_LEN, 0444);
> >  core_initcall(cpufreq_core_init);
> > -- 
> > 2.27.0.111.gc72c7da667-goog
> 
> -- 
> viresh
