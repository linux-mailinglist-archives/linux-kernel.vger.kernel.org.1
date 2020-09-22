Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157FD27471A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVRBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:01:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVRBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:01:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600794066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoRTNE0li2f5w49NlqYezoCQ6/u5c+NnH/4Xsxw2QEg=;
        b=VxXRGDcwBaxWDlnWl8EMkQZcVSoulvuH49g/1H+HNKBZSsYLV0zzQGYzFbX/84Hv6eYTnO
        kmstxEdnmN7X5K0MJdrKyqtb7/WviBsn5HZ8lqgSY1EZt4DNe4lEPUKEekk6C1tqLtDcUi
        LNmia1RBx6qxn7ceJU+FL80ZvAa38zc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CB1FAD0B;
        Tue, 22 Sep 2020 17:01:43 +0000 (UTC)
Date:   Tue, 22 Sep 2020 19:01:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: Machine lockups on extreme memory pressure
Message-ID: <20200922170106.GE12990@dhcp22.suse.cz>
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz>
 <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
 <20200922151654.GA12990@dhcp22.suse.cz>
 <CALvZod7jvxEdbMzrmmt6Vrse=Ui4yhhVYyxPkPmmzWC5Z_6rtw@mail.gmail.com>
 <20200922163401.GC12990@dhcp22.suse.cz>
 <CALvZod753Peyyg6aHUaFoiv3uXEPHqsyrSiariV8bF-vhH6iRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod753Peyyg6aHUaFoiv3uXEPHqsyrSiariV8bF-vhH6iRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 09:51:30, Shakeel Butt wrote:
> On Tue, Sep 22, 2020 at 9:34 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 22-09-20 09:29:48, Shakeel Butt wrote:
[...]
> > > Anyways, what do you think of the in-kernel PSI based
> > > oom-kill trigger. I think Johannes had a prototype as well.
> >
> > We have talked about something like that in the past and established
> > that auto tuning for oom killer based on PSI is almost impossible to get
> > right for all potential workloads and that so this belongs to userspace.
> > The kernel's oom killer is there as a last resort when system gets close
> > to meltdown.
> 
> The system is already in meltdown state from the users perspective. I
> still think allowing the users to optionally set the oom-kill trigger
> based on PSI makes sense. Something like 'if all processes on the
> system are stuck for 60 sec, trigger oom-killer'.

We already do have watchdogs for that no? If you cannot really schedule
anything then soft lockup detector should fire. In a meltdown state like
that the reboot is likely the best way forward anyway.
-- 
Michal Hocko
SUSE Labs
