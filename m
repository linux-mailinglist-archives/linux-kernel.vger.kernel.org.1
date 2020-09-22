Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C02746FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIVQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:51:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:51:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so18820292lfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmG4gWH7mH9Yym3rTKQITk7kl2T0JyBGiXJV3JhogtU=;
        b=h56pNQpbRuJmaQ/iAcYPzBagq4xzwkoUCflfi5oHkyEYg384lzsM5puRFSYQp/cDMM
         gkGXZHco6Ta+r9ZyRpfSANfZt6lPGnUpBS7EsqjfVfv3fq1FxSeN9AxmzvTpvjnHyx7f
         whsvt3IbKszYKHDDbFElCrd9VzT+bYOPHi+V67DwZihVNZpsRjT6vk35cXi9obP9NHjo
         L3Th6YqkI3RTL40MGp78aB3igMsn7xn7MDpA3JDGXlV3SUJFezdPKVML7DJWWvBWpDkf
         JjfEMnKmowbd9TZ5QHtoHjxn6WUvgZGTSuMSEg/hA4lQcA4D6uEUaa2zcxXPLh/ChE69
         MlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmG4gWH7mH9Yym3rTKQITk7kl2T0JyBGiXJV3JhogtU=;
        b=PSffeQh8l+q+aDtuhMqa/1qOPEPsuUnvhIuHQbBujRNr8jFlMjL9prisZIymzC5EjM
         ovJUEy/mHxcX9neNPV5hP/EiJeQCisltH9gt6PIY9TlyIYIWocRjX/ImZNMNq6itqrLy
         a8Tc0NL5ea/Pmj1KKTFPScsAU4mWYII2WnnFtG4tOfVN+mFkOkKBXcF3lmyUosFATIoU
         QiWx9ZW5NIsAwrix3zgf4Dz2rslwjsm3StnLkP1f1TN6HMK/9TjF2LEgtNoR0oNfF71+
         ip0jKrewg4v0uWHBifeYGyouqe3uZTDKmIzlh8zTvSVGHSwKZiLXXjZiJw+R8lN9oZdC
         H8ww==
X-Gm-Message-State: AOAM531JlPHx3E4rRMyStfwyXCmW3JdWQqkRMSqmEbP4IxZ2GJfgH9GW
        IoBulWrykc21NOods94mN497odj4uySnBZoEnSW4Iw==
X-Google-Smtp-Source: ABdhPJzvdN6z6GZ+Y9LPlyAqmPBcusa4j8dDsWFrAOqj1gGESHXbahMf1uaByCLmMISg8t0LDsEJJqDdE1v+MBFxVJc=
X-Received: by 2002:ac2:59da:: with SMTP id x26mr2122036lfn.346.1600793502076;
 Tue, 22 Sep 2020 09:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz> <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
 <20200922151654.GA12990@dhcp22.suse.cz> <CALvZod7jvxEdbMzrmmt6Vrse=Ui4yhhVYyxPkPmmzWC5Z_6rtw@mail.gmail.com>
 <20200922163401.GC12990@dhcp22.suse.cz>
In-Reply-To: <20200922163401.GC12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Sep 2020 09:51:30 -0700
Message-ID: <CALvZod753Peyyg6aHUaFoiv3uXEPHqsyrSiariV8bF-vhH6iRA@mail.gmail.com>
Subject: Re: Machine lockups on extreme memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 9:34 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 22-09-20 09:29:48, Shakeel Butt wrote:
> > On Tue, Sep 22, 2020 at 8:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 22-09-20 06:37:02, Shakeel Butt wrote:
> [...]
> > > > I talked about this problem with Johannes at LPC 2019 and I think we
> > > > talked about two potential solutions. First was to somehow give memory
> > > > reserves to oomd and second was in-kernel PSI based oom-killer. I am
> > > > not sure the first one will work in this situation but the second one
> > > > might help.
> > >
> > > Why does your oomd depend on memory allocation?
> > >
> >
> > It does not but I think my concern was the potential allocations
> > during syscalls.
>
> So what is the problem then? Why your oomd cannot kill anything?
>

From the dump, it seems like it is not able to get the CPU. I am still
trying to extract the reason though.

> > Anyways, what do you think of the in-kernel PSI based
> > oom-kill trigger. I think Johannes had a prototype as well.
>
> We have talked about something like that in the past and established
> that auto tuning for oom killer based on PSI is almost impossible to get
> right for all potential workloads and that so this belongs to userspace.
> The kernel's oom killer is there as a last resort when system gets close
> to meltdown.

The system is already in meltdown state from the users perspective. I
still think allowing the users to optionally set the oom-kill trigger
based on PSI makes sense. Something like 'if all processes on the
system are stuck for 60 sec, trigger oom-killer'.
