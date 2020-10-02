Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2091280D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgJBFiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgJBFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 01:38:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE1C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 22:38:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s14so326488pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 22:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xa3NGRE4EmU+gshR6rwAMIftLPd2DJTnRqHtGa9nIBw=;
        b=dUcAQaVyKvDnf4aSGotN0wJ5i4EEDqmRPgPayl8YHc9YYwrLSObWBPgSYLrNCmxxNO
         /oJ2b1uh+HzhN/71IDhzZpL2B6U3FroPJJyRcIL53C7A0aWQGr/6jKwqMso5jr9Nk5sj
         LPZZK9+HR40fZ1hor/73Q0f+LDfvRORtd3TUGxurp+dn1aZyG7CxGU5dW6zTnREX2/pn
         5jtYV4LcUlVsVZp02Pha4MraCEPKXI4MCIy0m2VKYhXKTFdB5Blzoi3vf7Cl0UQA/qkA
         ZfGUeBM4c5MIL2/ClFDOH7Q90MO8fp1AMHkgxHWHYFrR50LysEp5vLGN2gbfKMg1fhxh
         m45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xa3NGRE4EmU+gshR6rwAMIftLPd2DJTnRqHtGa9nIBw=;
        b=tnv3hPVbG2xS2gPYpUoWNadvckU1Zh31vZtL/BBw97oUnkWHk3ys/8Vyuoth62BlsN
         xHtmvV8lTJnJVrhi8ImpfsXHWh0DfiS5UmvcHHFUXGR9dIhJNl8XfgHYjau35vGeGt7P
         nvQjXvfXSvwspcyCYlXtD6gyGnwcNWt1wU2rd9GIsyQQ59no7pTdfvGSswjrVItvEuZm
         wZjFOqg/W7BnBYuZKjJSDpXaFKXTR6J/rHq70SPfOQ+EH8okMXrpvUVrgCFud2QAxsTJ
         xWwhpDvO2gvZ9n3zobUjQPrY5HdDTam1wucyRd8MHZiNCmdi7+5YpFkE+aI/XftK7vPa
         rdVw==
X-Gm-Message-State: AOAM530lSViqNtx/6iBZ7Ig8HWy7sNXRvbbIVoIFpqjJs+8UgerP4PZJ
        7h3pSxOkU7XZYV5jsMWkzAUwc6Gs6QPPHA==
X-Google-Smtp-Source: ABdhPJybBI94qyBUbFpH+VcPS71XBvnTPXFISyEXdXP+brVsBRxezB4oQepDoAU8GniWriGgXyufpQ==
X-Received: by 2002:a17:90a:62c4:: with SMTP id k4mr954441pjs.174.1601617100275;
        Thu, 01 Oct 2020 22:38:20 -0700 (PDT)
Received: from ubuntu (1-171-243-75.dynamic-ip.hinet.net. [1.171.243.75])
        by smtp.gmail.com with ESMTPSA id a1sm432744pfr.12.2020.10.01.22.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 22:38:19 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:38:12 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if
 user set to default value
Message-ID: <20201002053812.GA176142@ubuntu>
References: <20200928082643.133257-1-hsiang023167@gmail.com>
 <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:12:51PM +0200, Dietmar Eggemann wrote:
Hi Dietmar,

> Hi Yun,
> 
> On 28/09/2020 10:26, Yun Hsiang wrote:
> > If the user wants to release the util clamp and let cgroup to control it,
> > we need a method to reset.
> > 
> > So if the user set the task uclamp to the default value (0 for UCLAMP_MIN
> > and 1024 for UCLAMP_MAX), reset the user_defined flag to release control.
> > 
> > Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> 
> could you explain with a little bit more detail why you would need this
> feature?
> 
> Currently we assume that once the per-task uclamp (user-defined) values
> are set, you could only change the effective uclamp values of this task
> by (1) moving it into another taskgroup or (2) changing the system
> default uclamp values.
> 

Assume a module that controls group (such as top-app in android) uclamp and
task A in the group.
Once task A set uclamp, it will not be affected by the group setting.
If task A doesn't want to control itself anymore,
it can not go back to the initial state to let the module(group) control.
But the other tasks in the group will be affected by the group.

The policy might be
1) if the task wants to control it's uclamp, use task uclamp value
(but under group uclamp constraint)
2) if the task doesn't want to control it's uclamp, use group uclamp value.

If the policy is proper, we need a reset method for per-task uclamp.

> > ---
> >  kernel/sched/core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9a2fbf98fd6f..fa63d70d783a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1187,6 +1187,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  				  const struct sched_attr *attr)
> >  {
> >  	enum uclamp_id clamp_id;
> > +	bool user_defined;
> >  
> >  	/*
> >  	 * On scheduling class change, reset to default clamps for tasks
> > @@ -1210,14 +1211,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> >  		return;
> >  
> > +	user_defined = attr->sched_util_min == 0 ? false : true;
> >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> > -			      attr->sched_util_min, true);
> > +			      attr->sched_util_min, user_defined);
> >  	}
> >  
> > +	user_defined = attr->sched_util_max == 1024 ? false : true;
> >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> > -			      attr->sched_util_max, true);
> > +			      attr->sched_util_max, user_defined);
> >  	}
> >  }
