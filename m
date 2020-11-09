Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DA2AB037
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgKIEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgKIEjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:39:15 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7BC0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 20:39:15 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v12so6901799pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 20:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcFk/6OejFKlL0VZatZUqxcmH+heZ7DzTu7vp8WJaEQ=;
        b=xJ3qNvvXSqqSYWHG9AjgIondMGPCb0Zf/U44Hbf6JroDbgs97cWX9z6R3WRt2+rBSy
         f32WYgvCQ7MFheSVFJfp08+rXUROc+pekj3nPPPB1sLj0KCqb8K79VbhqSwjLCY1jEc1
         vb+P5xB0fqZD/I+/ogNq7JQDgrGWSvTnoI2Ayn13GJ5yFB5hKuGTDT7cPYET/aflYrVg
         Qww5Q28HNa3EsP4CV/QP77cxQbGMdDKQKo6OfhFwLsrNJXOndSDma5vPxhZaXzoQq/Pg
         lJbztwS8r9I+5e52b/NJAODM1p3z2B3wUsYnTaHkdfEjCiIy+xphisAUPTmCw9vrstaY
         PIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcFk/6OejFKlL0VZatZUqxcmH+heZ7DzTu7vp8WJaEQ=;
        b=OELrjZR/YyGWmCByU4DseCmg/UzW3Mt6XxZcizYhvdBkpQo9BFcuyCJQbi6TjC7NJ4
         JPDLfltlCqOlp6x5F1x2vvDFLUakjph7XO2eahSVhPYRMWa4jdSAYlTCiG3ZiIXrm9em
         f8c5whXFj2SwaB7+lurZYkj/9rP+sIFVVeje/fbD23K19OUsYDy7cWeojkKH0vIVNfZu
         rv5Duass12o8L2Qgv3JhFcy6zp6BpLWJbf2fKUbvDEjXd6A+KYtIqtLrOIwEMKoKUBKE
         maNRgn/IxIHVhUD6iStjkbWiHmgXcazBz6NHvPHtajjupuiTEL3fjAcPoiBpVLIPD3GR
         mp+g==
X-Gm-Message-State: AOAM530oOI5HKN5XuVZ2+w+jtkpKEk1VETpWdeg9J+d4LpVAQfF5eA9g
        k96Cgl4ywacvih3zRZRF092lWw==
X-Google-Smtp-Source: ABdhPJymvcg14EqyzrhTx9fxmYBVUt+rK4PBKr3VmOFJT6bL3w1VYplzKkSxeEuev3h9rCrs2SPjqw==
X-Received: by 2002:a63:381:: with SMTP id 123mr11974313pgd.112.1604896755123;
        Sun, 08 Nov 2020 20:39:15 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id h3sm9452763pfo.170.2020.11.08.20.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 20:39:14 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:09:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: Introduce target min and max frequency hints
Message-ID: <20201109043912.7zvfhi42yhr7goy4@vireshk-i7>
References: <7417968.Ghue05m4RV@kreacher>
 <2233690.N3OVLkotou@kreacher>
 <20201106100712.u336gbtblaxr2cit@vireshk-i7>
 <CAJZ5v0gT07K-oPa0=f8+Fq6tevqZJ8iWYjtf9YDNUJw1GJEBBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gT07K-oPa0=f8+Fq6tevqZJ8iWYjtf9YDNUJw1GJEBBA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-20, 18:02, Rafael J. Wysocki wrote:
> On Fri, Nov 6, 2020 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 05-11-20, 19:23, Rafael J. Wysocki wrote:
> > > Index: linux-pm/include/linux/cpufreq.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/cpufreq.h
> > > +++ linux-pm/include/linux/cpufreq.h
> > > @@ -63,6 +63,8 @@ struct cpufreq_policy {
> > >
> > >       unsigned int            min;    /* in kHz */
> > >       unsigned int            max;    /* in kHz */
> > > +     unsigned int            target_min; /* in kHz */
> > > +     unsigned int            target_max; /* in kHz */
> > >       unsigned int            cur;    /* in kHz, only needed if cpufreq
> > >                                        * governors are used */
> > >       unsigned int            suspend_freq; /* freq to set during suspend */
> >
> > Rafael, honestly speaking I didn't like this patch very much.
> 
> So what's the concern, specifically?
> 
> > We need to fix a very specific problem with the intel-pstate driver when it is
> > used with powersave/performance governor to make sure the hard limits
> > are enforced. And this is something which no one else may face as
> > well.
> 
> Well, I predict that the CPPC driver will face this problem too at one point.
> 
> As well as any other driver which doesn't select OPPs directly for
> that matter, at least to some extent (note that intel_pstate in the
> "passive" mode without HWP has it too, but since there is no way to
> enforce the target max in that case, it is not relevant).
> 
> > What about doing something like this instead in the intel_pstate
> > driver only to get this fixed ?
> >
> >         if (!strcmp(policy->governor->name, "powersave") ||
> >             !strcmp(policy->governor->name, "performance"))
> >                 hard-limit-to-be-enforced;
> >
> > This would be a much simpler and contained approach IMHO.
> 
> I obviously prefer to do it the way I did in this series, because it
> is more general and it is based on the governor telling the driver
> what is needed instead of the driver trying to figure out what the
> governor is and guessing what may be needed because of that.
> 
> But if you have a very specific technical concern regarding my
> approach, I can do it the other way too.

I was concerned about adding those fields in the policy structure, but
I get that you want to do it in a more generic way.

What about adding a field name "fixed" (or something else) in the
governor's structure which tells us that the frequency is fixed and
must be honored by the driver.

-- 
viresh
