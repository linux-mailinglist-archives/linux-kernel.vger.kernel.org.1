Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB742C53BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbgKZMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:13:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:18678 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389007AbgKZMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606392800; x=1637928800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=wuAaV6r6w2/rFPIrtuYzgXuA5dvTc38BY0LFs0T2lz4=;
  b=fOC0/2hgNZWu+U8ZSpi+SwfeIyO/e968pDhijpYQ0+9YQQ8iuW+XdhFL
   yQoz+ERfRpQDN9PuwzyOajxExkv6E68IJI1lATjwuTzW0R9Np6qJR/n63
   H8zN9P6ant90wdFHU/MW1xvWR4UbwelIwHlyWxbI+H9tzZ6BWN6oA85/1
   I=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="65938514"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 26 Nov 2020 12:13:09 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 33FB7A1BD9;
        Thu, 26 Nov 2020 12:12:56 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.50) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 12:12:40 +0000
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
Subject: Re: [PATCH v22 03/18] mm/damon: Adaptively adjust regions
Date:   Thu, 26 Nov 2020 13:12:26 +0100
Message-ID: <20201126121226.18883-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6nhJyOh943+EqttG+33ugrkNYxpLM3Gq7U7TFw70dOAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D15UWB003.ant.amazon.com (10.43.161.138) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:29:41 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:01 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Even somehow the initial monitoring target regions are well constructed
> > to fulfill the assumption (pages in same region have similar access
> > frequencies), the data access pattern can be dynamically changed.  This
> > will result in low monitoring quality.  To keep the assumption as much
> > as possible, DAMON adaptively merges and splits each region based on
> > their access frequency.
> >
> > For each ``aggregation interval``, it compares the access frequencies of
> > adjacent regions and merges those if the frequency difference is small.
> > Then, after it reports and clears the aggregated access frequency of
> > each region, it splits each region into two or three regions if the
> > total number of regions will not exceed the user-specified maximum
> > number of regions after the split.
> >
> > In this way, DAMON provides its best-effort quality and minimal overhead
> > while keeping the upper-bound overhead that users set.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> 
> The high level comment I have is that kdamond_[merge|split]_regions
> should be part of the abstraction of the target instead of the damon
> context.

Agreed in a high level.  Please refer to my answer to your second suggestion at
https://lore.kernel.org/linux-mm/20201126115157.6888-1-sjpark@amazon.com/


Thanks,
SeongJae Park
