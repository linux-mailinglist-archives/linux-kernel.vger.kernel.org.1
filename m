Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938122EB4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbhAEVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAEVgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:36:14 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB6C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:35:34 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q205so1140077oig.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0hmHryJfbf/XT9z825YcWQkO0BUnqygh/hnGzawmTrY=;
        b=ulzDg2IasU4VsBB0KyNVFZxes1bxHLiVNF/IhndXx0/HSPvfKmMt3cBCtUJHxjWu7w
         C0Q4SrWmKapNA8Wsr861GbH/g+uH75/m+kXBeGchxMklBe9rYzJZ6KgP2F9YQLuV6duU
         vZ94xR1xktoGZvvSxbqw3Ibo78we4eI6TXvJR8MEWFmQV3C/J66qSjiMRj8NaCNr8DYk
         811SPpXl0e5iMH97feJnxm8ANn4PHHtVr+UfeqAho94TMgvDHDc3/iVOnhMw+I+4LLAl
         F1K/SsUTZ7C2+/VJf5icCjpptLOW34t2RQ0wjVlZtNcliYZcL0Wzg1CH1ooUpox46P00
         amcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0hmHryJfbf/XT9z825YcWQkO0BUnqygh/hnGzawmTrY=;
        b=SIOxyYrrcTyqQRPpx3ino6vlz2qQqEmGRvF6uNKcZOWzxE6r2KDIU5P32zJRJdUAzF
         5aR47TGe2hVb7j6ZFs8AjFGjFSp1zhcJgUeh+4zTJcXF+zLFmWzIsGc2pQEUvXi3xJmW
         /SnHLUf+Y1m8Bm3zvwoY9NNRMFVILcnYgjWnCQTKLxCms8ffbbwLpUnk4yY3BxmSmqaV
         5XKcJsiZaYMaGTftZ8KcOwp1v1KjP8s6sltuDrftIo7vNZHzl47PRs6+sJBSYKTUYfDd
         uu/GMz1DWmRtD8we1uO4tipqkGc9AQu8BjPLo64QXGvLq8idDiGbr1wNTJSK+RI4NamS
         hILw==
X-Gm-Message-State: AOAM533ulicxeSHnlx0Jt7MyNsErJLnjYQNrmytPNMvSqdXI45jbBQ+8
        7XpX+909RrLC2fr6OUmMOsU9Jg==
X-Google-Smtp-Source: ABdhPJxh2ibuVi7SjpkQuIeZu+8VClJigP7sAZUgiz6tfGiUGShnMJKty2zcyq7qxIorFLjLb1r5BA==
X-Received: by 2002:aca:d406:: with SMTP id l6mr1209979oig.26.1609882533067;
        Tue, 05 Jan 2021 13:35:33 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e12sm105626otp.25.2021.01.05.13.35.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2021 13:35:32 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:35:20 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Qian Cai <qcai@redhat.com>
cc:     Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
In-Reply-To: <49be27f2652d4658f80c95bea171142c35513761.camel@redhat.com>
Message-ID: <alpine.LSU.2.11.2101051326410.6519@eggly.anvils>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com> <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com>
 <49be27f2652d4658f80c95bea171142c35513761.camel@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021, Qian Cai wrote:
> On Tue, 2021-01-05 at 11:42 -0800, Shakeel Butt wrote:
> > On Tue, Jan 5, 2021 at 11:30 AM Qian Cai <qcai@redhat.com> wrote:
> > > On Thu, 2020-11-05 at 16:55 +0800, Alex Shi wrote:
> > > > This version rebase on next/master 20201104, with much of Johannes's
> > > > Acks and some changes according to Johannes comments. And add a new patch
> > > > v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> > > > v21-0007.
> > > > 
> > > > This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> > > > added to -mm tree yesterday.
> > > > 
> > > > Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> > > > Johannes Weiner.
> > > 
> > > Given the troublesome history of this patchset, and had been put into linux-
> > > next
> > > recently, as well as it touched both THP and mlock. Is it a good idea to
> > > suspect
> > > this patchset introducing some races and a spontaneous crash with some mlock
> > > memory presume?
> > 
> > This has already been merged into the linus tree. Were you able to get
> > a similar crash on the latest upstream kernel as well?
> 
> No, I seldom test the mainline those days. Before the vacations, I have tested
> linux-next up to something like 12/10 which did not include this patchset IIRC
> and never saw any crash like this. I am still trying to figure out how to
> reproduce it fast, so I can try a revert to confirm.

This patchset went into mmotm 2020-11-16-16-23, so probably linux-next
on 2020-11-17: you'll have had three trouble-free weeks testing with it
in, so it's not a likely suspect.  I haven't looked yet at your report,
to think of a more likely suspect: will do.

Hugh
