Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE35C2746AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgIVQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgIVQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:30:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:30:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so18736853lfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Bx8gekgm2SEOvt6u33teukzzHIcXbMrSd4fJ3huDS4=;
        b=k9V3cN/rbuswExLp67fruMpypgqAsZd+NisBoTQvS+xzFFj+/mdrPU/GcSAmSlXgsR
         3I01CvoEm2O8zkQOEw8J0Y2KZKyD5QSMRhtcVQcUQx3drK5Lje0kTDvU8eFnJx5PDa4k
         E3blL8kFwcTLssklMilM9R2qGHtef2b1DVXhkyhjS1/juNyd4ISZXq+c9sOb9tzJkcWB
         glwO4W3iGR7SJ/isjmflyTnALmC+fYbI8+eCeDFKbH+cH3GxyHG+CYsrDi6RUgNpH58+
         CW7rbZ/pM5i0JcOz+7yRy0O0rbNXrDqHgw9pSTahiSPmSRVewNxhaYn//AF8o2roPDyH
         BE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Bx8gekgm2SEOvt6u33teukzzHIcXbMrSd4fJ3huDS4=;
        b=NoXIGT4rixD1mt9D5p3+f0zourZwsWDxhcICaPPoNZCweglVFbQlv+lpJ5McEeKd8c
         AkQWyPn6WeglVMXNO9N5RA50vP9WM7EhDUOCCNksvuDxpml/IhtLFBGRHyLiZLfzdSCa
         kk4YBr7CNW/aJu+ziAHNOhKriQFnCY5pYgsE9lC2mGiV/fe2u2eeZ498awbnEH3UtiCz
         jYdjtsup063PxWSFB8Zv6SfZ1SeeldOVJ1NCCzboLP30zQd0kp0THeNmhGgq+eehp6FH
         yYFV12/BL1sCVMvTp/HSVO3H0UWc/UoaTYh5gXr4258gJsEyjmZwOpHEXMaKrsF5cETj
         K/vA==
X-Gm-Message-State: AOAM531cxhHOlv5Zrd5fQIxhN9Gk76zyAEeKeEfD5RiZLVonFauQ0f9G
        MNiSS9DLMxe7UAe3QE5JzHIKti1C7IK8D0phrzlBHg==
X-Google-Smtp-Source: ABdhPJyirm0v+rO7vqImS4UsI+KLO3mtBjQY6yfGaAUPyv3UQn89NbK8UvFvw9pzcyMGvD4manAbbc7DR8AwSP6QVPU=
X-Received: by 2002:a19:4084:: with SMTP id n126mr1793874lfa.54.1600792199501;
 Tue, 22 Sep 2020 09:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz> <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
 <20200922151654.GA12990@dhcp22.suse.cz>
In-Reply-To: <20200922151654.GA12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Sep 2020 09:29:48 -0700
Message-ID: <CALvZod7jvxEdbMzrmmt6Vrse=Ui4yhhVYyxPkPmmzWC5Z_6rtw@mail.gmail.com>
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

On Tue, Sep 22, 2020 at 8:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 22-09-20 06:37:02, Shakeel Butt wrote:
> [...]
> > > I would recommend to focus on tracking down the who is blocking the
> > > further progress.
> >
> > I was able to find the CPU next in line for the list_lock from the
> > dump. I don't think anyone is blocking the progress as such but more
> > like the spinlock in the irq context is starving the spinlock in the
> > process context. This is a high traffic machine and there are tens of
> > thousands of potential network ACKs on the queue.
>
> So there is a forward progress but it is too slow to have any reasonable
> progress in userspace?

Yes.

>
> > I talked about this problem with Johannes at LPC 2019 and I think we
> > talked about two potential solutions. First was to somehow give memory
> > reserves to oomd and second was in-kernel PSI based oom-killer. I am
> > not sure the first one will work in this situation but the second one
> > might help.
>
> Why does your oomd depend on memory allocation?
>

It does not but I think my concern was the potential allocations
during syscalls. Anyways, what do you think of the in-kernel PSI based
oom-kill trigger. I think Johannes had a prototype as well.
