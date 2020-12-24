Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08B82E24FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 08:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgLXHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 02:03:23 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:62237 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLXHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608793402; x=1640329402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=oUJoo3u6FSyIrW2Sz/3hj3BeSsKUKhSGefxN2L8Gdj8=;
  b=jJ+B84TKiZ2KVae4p0b3nPgU6Y0yIXcDQ79kJVp41jcZprXGLV23YWPm
   AcYLJP0yM1PVQUkmkxwga8LQJwtH3fBmStmIic0nXHEuRvZ005gfQO+6B
   8W7tajx4Z1OWumnIrqPdzt8IQeYcvYTpC80Y2ZfI2BuOr7V9VZIG9Lpgf
   Y=;
X-IronPort-AV: E=Sophos;i="5.78,444,1599523200"; 
   d="scan'208";a="98775651"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 24 Dec 2020 07:02:35 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id A6CDCA1E7D;
        Thu, 24 Dec 2020 07:02:32 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.193) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Dec 2020 07:02:16 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <Jonathan.Cameron@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>, <acme@kernel.org>,
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
Subject: Re: [PATCH v23 01/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Thu, 24 Dec 2020 08:02:01 +0100
Message-ID: <20201224070201.9607-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6HjfHg-LGM82mnj5keCL8gXykmvR_aatfi2B=F0hqgbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D43UWC004.ant.amazon.com (10.43.162.42) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 14:49:57 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Wed, Dec 23, 2020 at 8:34 AM SeongJae Park <sjpark@amazon.com> wrote:
> [snip]
> > > Overall the patch looks good to me. Two concerns I have are if we
> > > should damon_callback here or with the real user and the regions part
> > > of primitive abstraction. For the first one, I don't have any strong
> > > opinion but for the second one I do.
> >
> > I'd like to keep 'damon_callback' part here, to let API users know how the
> > monitoring result will be available to them.
> >
> > For the 'regions' part, I will rename relevant things as below in the next
> > version, to reduce any confusion.
> >
> > init_target_regions() -> init()
> > update_target_regions() -> update()
> > regions_update_interval -> update_interval
> > last_regions_update -> last_update
> >
> > >
> > > More specifically the question is if sampling and adaptive region
> > > adjustment are general enough to be part of core monitoring context?
> > > Can you give an example of a different primitive/use-case where these
> > > would be beneficial.
> >
> > I think all adress spaces having some spatial locality and monitoring requests
> > that need to have upper-bound overhead and best-effort accuracy could get
> > benefit from it.  The primitives targetting 'virtual address spaces' and the
> > 'physical address space' clearly showed the benefit.
> 
> I am still not much convinced on the 'physical address space' use-case
> or the way you are presenting it.

I understand the concern.  I also once thought the mechanism might not work
well for the physical address space because we cannot expect much spatial
locality in the space.  However, it turned out that there is some (temporal)
spatial locality that enough to make DAMON work reasonably well.  The word,
'reasonably well' might be controversial.  With the mechanism, DAMON provides
only 'best-effort' accuracy, rather than 100% accuracy.  Our goal is to make
the information accurate enough only for DRAM-centric optimizations.  I'd like
to also note that there are knobs that you can use to make minimum quality
higher (nr_min_regions) while setting the upperbound of the monitoring overhead
(nr_max_regions).   What I can say for now is that we ran DAMON for physical
address space of our production systems (shared detail in the 'Real-workd User
Story' section of coverletter[1]) and the result was reasonable enough to
convince the owner of the systems.

[1] https://lore.kernel.org/linux-mm/20201215115448.25633-1-sjpark@amazon.com/

> Anyways I think we start with what you have and if in future there is a
> use-case where regions adjustment does not make sense, we can change it then.

100% agreed, and thank you for understanding my argument.


Thanks,
SeongJae Park
