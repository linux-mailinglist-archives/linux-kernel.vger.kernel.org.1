Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517B32C8F95
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgK3VCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbgK3VCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:02:18 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5018C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:01:31 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t22so20256644ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfBG/54OyTRJiWtpsok7Jr2j/N7jeyEBXeoHXE64Qs8=;
        b=OR7LHevBUwdO4js3xbw27kSJjJK7b7r2zrYg/+GicXe4c6K5tfvaKlgdOB3ni0ax1O
         9FEUkoXJ/RCZgWPFClDOhgP+IIWJ9kRqYs6yML1ZC+oGdBNeHztsUbrWdOrq1zxYex/M
         e5831ufsaidd9Fc8KJOlIl5Dg8zYqrmHGsP5wYUhO+jmMMcjc2NTPRteTtbVrZn0y0yz
         b+F4qqgHCbo7HgT2620ZPLHu8YY2o3USpQlcbHb4Z8J2fRAjdEdMyuLh29wdugUs4aJ6
         riPKAGHXxgxwXjJ7NEm9LJP0nsooNhJwUFNK9CIIsS2OqAekoZNOeJNg2g6rxvVYPnjp
         gpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfBG/54OyTRJiWtpsok7Jr2j/N7jeyEBXeoHXE64Qs8=;
        b=oKUFO4ErA2N6KhVbGKgeBOVdnvWfOiVxXpjZM4HrS9QhOy2UptV8xs/KOTXA9mx4Q8
         0QhLCyxowLeCDjEjhLfnn2BcAMZm3YVByaO6EjpiLfI0D+gelf0cvgcOmVDqFN97B3Wt
         rhp11Gjq9UcBsEjkkfuKUvLBlrzOJ5Nbk+3kSxflHZFwFpn11YhidP1Cj/mMV6fOnMfL
         4v/ERfxoHyESps4VCVVEidQkHvBc5y/Y+WuU4ahzanmAegqX9+spKLA3kmwgUQDI74V8
         pxYZDxiQiOtL40XKMOiIfqgr8GpWGyxZIl5Fe0N0lQLei7jjqAe2K23xU4n38pK1HI0o
         v42w==
X-Gm-Message-State: AOAM531UpT4SoFxB8rEUvWQc7X5pJExl3U+J4oHW+dimFrjnlG5Ivuaz
        aLhTWHssRPLIsPoqDhV0BiqYA2zP9EN7ZhICzgticA==
X-Google-Smtp-Source: ABdhPJwguSnAkPvJuN9LIzqSs78aXwru+P87EQ1/nNrKddX45uAAwZrmzE1LHPJw/qoITVIhzXN8Ht/crexEzqwH4e0=
X-Received: by 2002:a2e:8745:: with SMTP id q5mr10752520ljj.347.1606770089903;
 Mon, 30 Nov 2020 13:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20201126005603.1293012-1-shakeelb@google.com> <20201130203425.GA1360286@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201130203425.GA1360286@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 30 Nov 2020 13:01:18 -0800
Message-ID: <CALvZod4qiFuiByjh0+fwRoVw_EYVzqADNsiThf42-zDiXyYvpg@mail.gmail.com>
Subject: Re: [PATCH 0/2] memcg: add pagetable comsumption to memory.stat
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:34 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Nov 25, 2020 at 04:56:01PM -0800, Shakeel Butt wrote:
> > Many workloads consumes significant amount of memory in pagetables. This
> > patch series exposes the pagetable comsumption for each memory cgroup.
>
> Hi Shakeel!
>
> The code looks good to me. However I'm not sure I understand what's the
> use case for the new statistics? Can you, please, elaborate a bit more here?
>
> From a very first glance, the size of pagetables should be _roughly_ equal
> to the size_of(pte)/PAGE_SIZE*(size of a cgroup) and should not exceed 1%
> of the cgroup size. So for all but very large cgroups the value will be
> in the noise of per-cpu counters. Perhaps I'm missing some important cases?
>

I think this is in general a good metric to have but one specific
use-case we have is the user space network driver which mmaps the
memory of the applications for zero copy data transfers. This driver
can consume a large amount of memory in page tables. So, this metric
becomes really useful here.

Shakeel
