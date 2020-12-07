Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBC2D0AF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLGHNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:13:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB9C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:13:01 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id hk16so6904128pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L9PwYZvqLiGNYdXkGMEuQ3s8+SUAaqoFC/6B9W0U+88=;
        b=Wylzwk2CKFjIDz3zGdDX4duOBzExSiV3Dxg2t/mMS8Jxm4Xv0e/zHY2kloviF+JjO0
         TvHXgM//BGUwESKpUg8JLdziESmEA/9ne/aV8lLzA4ZiL2ya29sofiKJw7F5L5W1mcf4
         GMr1U/SEvq3anM4hgHAWLyUihagFxZKQ1ZN8EB1Pi2pJl4yIILQotbe8parJgQYQuW+z
         7EXk6oTqOEb98E0UdZHbxVGRYwUkXjmKqhgHMPSxsyh0TqHHA+AjbZUAin73Mo/lJP92
         ik77AIHfDKRBo6PDnHDIy0ncI16UoHZrlVowJyEb8BTYFtkVJYtZm7UTPo7C27HaGmmk
         AOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L9PwYZvqLiGNYdXkGMEuQ3s8+SUAaqoFC/6B9W0U+88=;
        b=HSorPimvpUWJFfnWMdOB4MJz2g9rc1y26dC3ESGBrNzegLAP014LJPvnRoOV6p6YL9
         jirnlIb22bBKqU5wo/fE3obNm/Mm+GHXifaWba+wmzhEJRzwz7V/GF7sYsNeNSZCwi10
         8DUz5yfcTJrymywMj1/s7ZZq2GMeOQX9iIvfuqMjopcI3WJvVVEQyn5PGVg7i5v+HuQj
         GX2NHg/h6KdMDeyRJAsBRORi6fFidnJLatSgS1KH7DHjQ/aAsjB8VvOtEDXbEyltQDMB
         e4XQ2Te91nNHFyIqEHarcl6Vp9VmQA1MVlBkKzXMCCxJyoJzIbn4/cUpjXhdCSlDn5i5
         ZWIg==
X-Gm-Message-State: AOAM532tvIz45rq60sgU6UrnKHRtXWZP6S7zREUWzr4lYNKdJ6ZZiJBp
        CbnNK5mY6SF+HIjRSK/hNJs=
X-Google-Smtp-Source: ABdhPJwMWJy01xons9QiIwTLpste/e0PgfoUlz9uKMNLci6bkn3kH44bcdizYodqC8v0hiVWHRvlbw==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr15153215pjb.111.1607325181061;
        Sun, 06 Dec 2020 23:13:01 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id g16sm11002537pfh.187.2020.12.06.23.12.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 23:13:00 -0800 (PST)
Date:   Mon, 7 Dec 2020 16:12:50 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
Message-ID: <20201207071238.GA10731@js1304-desktop>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201204035953.GA17056@js1304-desktop>
 <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
 <20201204161005.GD5487@ziepe.ca>
 <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:50:56PM -0500, Pavel Tatashin wrote:
> > > Yes, this indeed could be a problem for some configurations. I will
> > > add your comment to the commit log of one of the patches.
> >
> > It sounds like there is some inherent tension here, breaking THP's
> > when doing pin_user_pages() is a really nasty thing to do. DMA
> > benefits greatly from THP.
> >
> > I know nothing about ZONE_MOVABLE, is this auto-setup or an admin
> > option? If the result of this patch is standard systems can no longer
> > pin > 80% of their memory I have some regression concerns..
> 
> ZONE_MOVABLE can be configured via kernel parameter, or when memory
> nodes are onlined after hot-add; so this is something that admins
> configure. ZONE_MOVABLE is designed to gurantee memory hot-plug

Just note, the origin of ZONE_MOVABLE is to provide availability of
huge page, especially, hugetlb page. AFAIK, not guarantee memory
hot-plug. See following commit that introduces the ZONE_MOVABLE.

2a1e274 Create the ZONE_MOVABLE zone

> functionality, and not availability of THP, however, I did not know
> about the use case where some admins might configure ZONE_MOVABLE to

The usecase is lightly mentioned in previous discussion.

http://lkml.kernel.org/r/alpine.DEB.2.23.453.2011221300100.2830030@chino.kir.corp.google.com

Anyway, I agree with your other arguments and this patchset.

Thanks.
