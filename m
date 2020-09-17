Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189C126D45B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgIQHNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:13:08 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17809 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQHNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600326785; x=1631862785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=bT02fndMmz9E4+y+xqKPl+BUNHOX1Ddkk2I4qA/LheA=;
  b=iOqYzDKKbENVnSLY71h77Jgxr0XDNuRBnrSAjgkUPmg8LX98NYcJlgAw
   8LHjG21k28HBwh1Bo2oOxTDiIluI8taAqLvTHMepmHAr0G/tiF4de1uxF
   E+3v6yTsnjC4mpADQKl9tae5p9Rw/kOjsamZWueDK0i4Ru+R1yH/ZSkNr
   c=;
X-IronPort-AV: E=Sophos;i="5.76,436,1592870400"; 
   d="scan'208";a="54591284"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Sep 2020 07:13:01 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 7EAABA18C7;
        Thu, 17 Sep 2020 07:12:57 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.71) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 17 Sep 2020 07:12:39 +0000
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
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <rppt@kernel.org>,
        <sblbir@amazon.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] mm/damon/debugfs: Support multiple contexts
Date:   Thu, 17 Sep 2020 09:12:23 +0200
Message-ID: <20200917071224.3939-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod5fO4PzRKO84TZMZ_wqjPTXnEcecbKUaV_TVkmoF70gpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D40UWC001.ant.amazon.com (10.43.162.149) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 09:11:18 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Sep 15, 2020 at 11:03 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON allows the programming interface users to run monitoring with
> > multiple contexts.  This could be useful in some cases.  For example, if
> > someone want to do highly accurate monitoring and lots of CPUs are
> > available, splitting the monitoring target regions into multiple small
> > regions and allocating context (monitoring thread) to each small region
> > could be helpful.  Or, someone could need to monitor different types of
> > address spaces simultaneously.
> >
> > However, it's impossible from the user space because the DAMON debugfs
> > interface supports only single context.  This commit makes it available
> > by implementing 'nr_contexts' debugfs file.
> >
> > Users can pass the number (N) of contexts they want to use to the file.
> 
> Why not just mkdir which will create a new context?

Because I referenced the naming rule of zram and because I just wanted to make
this as simple as possible.  I find no special functional difference between
current way and you suggested way.

That said, I also think you suggested way is much more flexible.  I will try to
make this in that way.

> 
> > Then, N folders having name of 'ctx<1-(N-1)>' are created in the DAMON
> > debugfs dir.  Each of the directory is associated with the contexts and
> > contains the the files for context setting (attrs, init_regions, record,
> > schemes, and target_ids).
> 
> Also instead of naming the kthread with context number why not give
> the kthread pids through attrs (or new interface) and the admin can
> move those kthreads to the cgroup they want to charge against?

Again, I just wanted to make this as simple as possible, and I also referenced
blkback thread naming.  And I find no special functional difference here,
either.

And yes, I think you suggested way is much more flexible and easy to be used.
I will make this in that way.

---

Just a note (not for only Shakeel, but anyone who interested in DAMON).  The
DAMON debugfs interface is not highly coupled with DAMON.  Rather than that, it
is implemented as an application using DAMON as a framework via the DAMON's
kernel space interface.  This means that anyone who want different user space
interface can implement their own on top of the framework.  I will try to make
the changes as soon as possible, but if you cannot wait until then, you could
implement your own.

Similarly, DAMON lacks many functionality such as support of special address
spaces.  I already have a TODO list.  And I will implement those one by one.
So, please give me the requests.  However, I believe the kernel space interface
is already almost complete.  Thus, almost every such future features could be
implemented on top of current DAMON interface.  Therefore, if you cannot wait
until I finish the work, you can implement your own on DAMON's kernel space
interface.

Of course, if you send the patches for your own implementations, that will make
not only I, but the community happier.

And this is the reason why the patchset containing only the framework part and
minimal applications / addons is titled as official 'PATCH', while the
patchsets for the future features are titled 'RFC'.  So, I am asking you to
consider giving more attention to the framework part (the first 4 patches of
the patchset[1]), as all future features will depend on it.

[1] https://lore.kernel.org/linux-mm/20200817105137.19296-1-sjpark@amazon.com/


Thanks,
SeongJae Park
