Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8FB2A0C06
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgJ3RBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3RBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:01:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839DAC0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:01:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x6so7680106ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMdzijelkbZc6mxQzWCPjofX1r5jEPxpyQAed1Y4dDc=;
        b=F50WZ11SDhm5TPptkROELzncL5xUQ2qnMPk7ayz8cHM3zlvadoqgBLf2rGEmZMMnJv
         PyivlsKebSBiWJa+mtQYCtTT7KiMp+AFFnt9C4HwsszJe+zbP4+STKUn0mo/1YtT6+Lm
         yJ0ke5LRLwsmTr2dFjF29gyrB1Y979jDugSs9ZBCnPOPmG9Wx9LGMSqv3t0dhTjjfC8f
         98KR+Ttufi5On7jhXTKE4ZWDzj8xyaXeqiDgdLm8Oxh6dMpUEfqaX+SoNENG7XkDwcVl
         NXtlCuZIqOoA9o18i49RCAgHUiVxskoDrofICgFGPssHMOfCBANdsOWDFsb8Ji3XMV1d
         kIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMdzijelkbZc6mxQzWCPjofX1r5jEPxpyQAed1Y4dDc=;
        b=FmfHTqq1IF/2jB/Nr39sbmqRRx1h8txY3ycI28ZQwkQGDKXVlwwyeFqXkbq3RKtDIs
         kas/ONhZiTE183I7HGx4QoL993cVCRXkatG+Tphgrnp1aihH7WxISy77ESils0GnnMrc
         WbF/1PaApQB9NRT2QHentVod8zK7yHXeuZGORKQTmq3CTxiPlhZGhpcEbUjfsT4ZJxY2
         hc5WWVB4okR07wFDzb5TxDVL3LdyNpHujYnfbQR0hdAS0CLqYTxXqw5W0wUH2Cp/eEmZ
         l8u5yH+Hb/omCNQfmdwDiZlafMuFTXJs8YqMymiLPNANKnRuQSaf6H/k5JpaBNIKc1up
         dXVQ==
X-Gm-Message-State: AOAM531U6uQ2bjDpLemVeK+so491wQkSduyN1VCz1oYVsMuWVexDFUht
        AAXCfjM5U/OF8eZu8WZj5hlzzK4uNGod69EeVk8WFzLYQNn/Hw==
X-Google-Smtp-Source: ABdhPJxNIBbkWgC8YsNwrPXjtP5HMr/a0E+XP/FoIPYgjN318kXjHpUdmUQpG8mYRqWMGry1RDevkSjswl7iARkq8es=
X-Received: by 2002:a2e:9985:: with SMTP id w5mr1615992lji.332.1604077309957;
 Fri, 30 Oct 2020 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz> <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
 <20200922151654.GA12990@dhcp22.suse.cz> <CALvZod7jvxEdbMzrmmt6Vrse=Ui4yhhVYyxPkPmmzWC5Z_6rtw@mail.gmail.com>
 <20200922163401.GC12990@dhcp22.suse.cz> <CALvZod753Peyyg6aHUaFoiv3uXEPHqsyrSiariV8bF-vhH6iRA@mail.gmail.com>
 <20200922170106.GE12990@dhcp22.suse.cz>
In-Reply-To: <20200922170106.GE12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 30 Oct 2020 10:01:38 -0700
Message-ID: <CALvZod4Ww1vzxD90HFePVweFaQn+3WDwu8G-gHMA1AeiJGprBg@mail.gmail.com>
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

On Tue, Sep 22, 2020 at 10:01 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 22-09-20 09:51:30, Shakeel Butt wrote:
> > On Tue, Sep 22, 2020 at 9:34 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 22-09-20 09:29:48, Shakeel Butt wrote:
> [...]
> > > > Anyways, what do you think of the in-kernel PSI based
> > > > oom-kill trigger. I think Johannes had a prototype as well.
> > >
> > > We have talked about something like that in the past and established
> > > that auto tuning for oom killer based on PSI is almost impossible to get
> > > right for all potential workloads and that so this belongs to userspace.
> > > The kernel's oom killer is there as a last resort when system gets close
> > > to meltdown.
> >
> > The system is already in meltdown state from the users perspective. I
> > still think allowing the users to optionally set the oom-kill trigger
> > based on PSI makes sense. Something like 'if all processes on the
> > system are stuck for 60 sec, trigger oom-killer'.
>
> We already do have watchdogs for that no? If you cannot really schedule
> anything then soft lockup detector should fire. In a meltdown state like
> that the reboot is likely the best way forward anyway.

Yes, soft lockup detector can catch this situation but I still think
we can do better than panic/reboot.

Anyways, I think we now know the reason for this extreme pressure and
I just wanted to share if someone else might be facing a similar
situation.

There were several thousand TCP delayed ACKs queued on the system. The
system was under memory pressure and alloc_skb(GFP_ATOMIC) for delayed
ACKs were either stealing from reclaimers or failing. For the delayed
ACKs whose allocation failed, the kernel reschedules them infinitely.
So, these failing allocations for delayed ACKs were keeping the system
in this lockup state for hours. The commit a37c2134bed6 ("tcp: add
exponential backoff in __tcp_send_ack()") recently added the fix for
this situation.
