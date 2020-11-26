Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A02C53DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgKZMT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:19:57 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26898 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgKZMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606393196; x=1637929196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=p0/xkxLXkEdm/1gb/+u5+pqssnjdPH8RP/0kpost/VQ=;
  b=Hox05Ywxn3VX6XYH3WbGVHZ6rW7A6A8wuzcaBCaxcpCqP8r2q20OfnEH
   EZXgRNO7KRLfimylwUETVvMF27d5P9u8T4aqBgSWVVYHDYNrvaYpQske8
   RyqCLMSQJvKgd4PqMgmfai2WWhPTnLYVO0Ho0ukfvcoOAF7d3e5AMAWiC
   0=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="99441687"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Nov 2020 12:19:43 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 66F96A2252;
        Thu, 26 Nov 2020 12:19:31 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.229) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 12:19:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        <foersleo@amazon.de>, "Greg Thelen" <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, <sblbir@amazon.com>,
        Shuah Khan <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v22 04/18] mm/damon: Track dynamic monitoring target regions update
Date:   Thu, 26 Nov 2020 13:18:58 +0100
Message-ID: <20201126121858.19832-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6iLkNyePTMn9=DOgbD5Q7Yqc_WrQrNqOQ3e-2+FtJZsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.229]
X-ClientProxiedBy: EX13D35UWC003.ant.amazon.com (10.43.162.130) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:29:57 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:02 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > The monitoring target address range can be dynamically changed.  For
> > example, virtual memory could be dynamically mapped and unmapped.
> > Physical memory could be hot-plugged.
> >
> > As the changes could be quite frequent in some cases,
> 
> Which cases? Usually address space changes are very infrequent for
> performance reasons.

It depends on the application, but there are some cases for the mmap[1].
ebizzy, the popular benchmarks in mm community is also one such application.

[1] Section 4.3, https://dl.acm.org/doi/pdf/10.1145/3342195.3387527

> 
> > DAMON checks the
> > dynamic memory mapping changes and applies it to the abstracted target
> > area only for each of a user-specified time interval, ``regions update
> > interval``.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> [snip]
> >   * Check whether current monitoring should be stopped
> >   *
> > @@ -612,6 +625,11 @@ static int kdamond_fn(void *data)
> >                         kdamond_reset_aggregated(ctx);
> >                         kdamond_split_regions(ctx);
> >                 }
> > +
> > +               if (kdamond_need_update_regions(ctx)) {
> > +                       kdamond_call_prmt(ctx, update_target_regions);
> 
> The implementation of update_target_regions callback should be part of
> this patch.

Agreed, will make so in the next version.


Thanks,
SeongJae Park

> 
> 
> > +                       sz_limit = damon_region_sz_limit(ctx);
> > +               }
> >         }
> >         damon_for_each_target(t, ctx) {
> >                 damon_for_each_region_safe(r, next, t)
> > --
> > 2.17.1
> >
