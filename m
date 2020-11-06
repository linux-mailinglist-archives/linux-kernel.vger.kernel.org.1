Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294EF2AA098
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgKFW7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgKFW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:59:20 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 14:59:19 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c20so2764326pfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lPzksUR9ZyZwSsQ8tnKwK0p0kGK7K1utClt0jJk/L8I=;
        b=PLQlbnYDD6tHrqH2zfCgx9joRW/t6JIVQKXStdygoYx0y1YGrmnpXvFDJZPyKbNlxc
         oMpQ6KCY2VhlJ4ozLKpr0nFQn+yQiQfYtwLauMc0h3Wx6yL4xbrpdLJZTJAtHkIOKLDd
         vS4yiBJWcxc/R5K0T8Rs4kB0vTLEIVE6d2SIFAZut2XjrHgha0xLUvzjnyK0qGDUL8Ed
         Onqpa1Ara4s9pyDAslidDQg8HhncryPu8J/EeVl/693fshl+M29eLlo181YOFNvIQ5ym
         y0RX4tTwaUDpGDHpqlyh3CpXm0qakig9E9iqhx6AvjgWfrk5cuFhvfKLhvSCIL6pGDnW
         P+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lPzksUR9ZyZwSsQ8tnKwK0p0kGK7K1utClt0jJk/L8I=;
        b=A4YGKdcJQ7uHzL0DcHP5Jl8EgYMAb2TWHy8Bl8raYJeg0V2wPi729zUqB/f58/O4a6
         FAA9BzxB9fnrVjhGZzV9hNRcGSfEbxgptBs+X95/NP/fGlmHrMIzZYGU2tDt8O9G2Jwj
         hkPpIYP3NkIlTI7Hf7K8tluYn6iwMs172c7eSJa9+qikPnLeAsy43M4XlBy6z2zpjvE1
         eOMuGPMojQ8vsg+mJnRmMGpkv1D3wjtw4Rh7vvE9cQ+pZ5IA+HfpNVT932TyXtWINDwV
         teNmAYwE3KupwvwAhWLyrVfgxyh9psIFN4Kt+/GS1/z+SeNI9vHSm6AdN2/O2Xu7XPw4
         7TrA==
X-Gm-Message-State: AOAM532budhGBtO2nScXmHXKhswqDtPyO4q8aADc6PGJB03gW8UOJJwR
        8dcYt0oBnXIh2dK1MDHYOLQU65aHVww=
X-Google-Smtp-Source: ABdhPJxx2uc6cJXbM/n0hMuIvPfZ+Ku4/iGm9oaaJFo7H4nBel3IiiCzmB5eVGVWTUG3Tr3iIWCu6w==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr1899256pjb.102.1604703559474;
        Fri, 06 Nov 2020 14:59:19 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id g7sm3643399pjl.11.2020.11.06.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 14:59:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 6 Nov 2020 14:59:16 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: introduce oom_kill_disable sysctl knob
Message-ID: <20201106225916.GA1383786@google.com>
References: <20201106203238.1375577-1-minchan@kernel.org>
 <57a31f2e-bb08-7303-e5fc-fe00e832cee6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a31f2e-bb08-7303-e5fc-fe00e832cee6@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:46:47PM -0800, Randy Dunlap wrote:
> Hi,
> 
> Fix a few typos:
> 
> On 11/6/20 12:32 PM, Minchan Kim wrote:
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 14 ++++++++++++++
> >  include/linux/mm.h                      |  2 ++
> >  include/linux/oom.h                     |  1 +
> >  kernel/sysctl.c                         |  9 +++++++++
> >  mm/oom_kill.c                           | 24 ++++++++++++++++++++++++
> >  5 files changed, 50 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index f455fa00c00f..49dcedfaf0c0 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -694,6 +694,20 @@ is used in oom_kill_allocating_task.
> >  
> >  The default value is 0.
> >  
> > +oom_kill_disable
> > +================
> > +
> > +This disables or enables OOM killing in out-of-memory situations.
> > +
> > +If this is set to one, the OOM killer is disabled so OOM kill never
> > +hapens in out-of-memory situation. It could cause system dangerous
> 
>    happens                            It could cause a dangerous system
> 
> > +state due to memory allocation failure so user should be careful to
> 
>                                                             careful when
> > +use it.
> 
>    using it.
> 
> > +
> > +If this is set to zero, the OOM killer is enabled so OOM kill happens
> > +in out-of-memory situations.
> > +
> > +The default value is 0.
> >  
> >  overcommit_kbytes
> >  =================
> 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 8b84661a6410..0f48cdeeb1e7 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> 
> >  #ifdef CONFIG_NUMA
> >  /**
> >   * oom_cpuset_eligible() - check task eligiblity for kill
> 
>                                          eligibility
> 
> but that's not in your patch, so don't bother with it. :)

Sure, I will resend it with fixing after waiting some feedback.

Thanks for the review, Randy.
