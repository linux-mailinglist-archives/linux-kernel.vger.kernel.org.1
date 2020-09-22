Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3122746BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgIVQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:34:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgIVQeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:34:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600792442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNjP76fYrDsqjYRwTgd7xRv6MvI1xnz7esaTtRdl7wI=;
        b=pmNZz6QVn09U7CdlYg3tNgajGHTpBKUww+4C6v2YL7m8Q2q0k7RtD2FbWUw1+PGmsc6Qfu
        gsjCFNOGp4jpT55WRVniT67RAKGKtdtIvOlD6/TNb9IcSOJn2QiDUtMcRLs9aa84yadN8+
        GuSWz2NfFZQC0qitNcS2dUOIE1icgQY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 174DDAC4F;
        Tue, 22 Sep 2020 16:34:39 +0000 (UTC)
Date:   Tue, 22 Sep 2020 18:34:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: Machine lockups on extreme memory pressure
Message-ID: <20200922163401.GC12990@dhcp22.suse.cz>
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz>
 <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
 <20200922151654.GA12990@dhcp22.suse.cz>
 <CALvZod7jvxEdbMzrmmt6Vrse=Ui4yhhVYyxPkPmmzWC5Z_6rtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7jvxEdbMzrmmt6Vrse=Ui4yhhVYyxPkPmmzWC5Z_6rtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 09:29:48, Shakeel Butt wrote:
> On Tue, Sep 22, 2020 at 8:16 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 22-09-20 06:37:02, Shakeel Butt wrote:
[...]
> > > I talked about this problem with Johannes at LPC 2019 and I think we
> > > talked about two potential solutions. First was to somehow give memory
> > > reserves to oomd and second was in-kernel PSI based oom-killer. I am
> > > not sure the first one will work in this situation but the second one
> > > might help.
> >
> > Why does your oomd depend on memory allocation?
> >
> 
> It does not but I think my concern was the potential allocations
> during syscalls.

So what is the problem then? Why your oomd cannot kill anything?

> Anyways, what do you think of the in-kernel PSI based
> oom-kill trigger. I think Johannes had a prototype as well.

We have talked about something like that in the past and established
that auto tuning for oom killer based on PSI is almost impossible to get
right for all potential workloads and that so this belongs to userspace.
The kernel's oom killer is there as a last resort when system gets close
to meltdown.
-- 
Michal Hocko
SUSE Labs
