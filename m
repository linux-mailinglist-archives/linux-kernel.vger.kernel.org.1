Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578742E252B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLXHOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 02:14:43 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:8102 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLXHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608794083; x=1640330083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=q+sa1v+hVCGnBVxALuspkwv5vmZDVRmkFGn50a6BvZM=;
  b=TRzDArcRbiEC+ka3TPWvAZt4cExRCZe8CeWJYa2x11sIO5biN6UiIV8M
   cM9wRTDYb55dZFWJu/gqJQCp8Ib97wcuO06PRsHYhRrzv6ZWpkUYWZFoN
   4s11qLwJzLbA9gNm1wLumiEVXVAVm8KT1trK1Ld4O0iQNoakrdoKs3UnM
   o=;
X-IronPort-AV: E=Sophos;i="5.78,444,1599523200"; 
   d="scan'208";a="98777496"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 24 Dec 2020 07:14:02 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 3A4BAA18D7;
        Thu, 24 Dec 2020 07:13:59 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.48) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Dec 2020 07:13:42 +0000
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
Subject: Re: [PATCH v23 11/15] tools: Introduce a minimal user-space tool for DAMON
Date:   Thu, 24 Dec 2020 08:13:28 +0100
Message-ID: <20201224071328.11811-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod5dxOJMNP3HhwYc0ePN+0V8YXruXDtQQRuy+eKsJTYhcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D24UWB004.ant.amazon.com (10.43.161.4) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 14:56:10 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Wed, Dec 23, 2020 at 10:38 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> [snip]
> >
> > I will drop this patch from the next version of this patchset, because this is
> > not the essential part but could only make the code review time consuming.  I
> > will post another DAMON RFC patchset for convenient user space usages including
> > this and the perf integration.
> 
> You can just add the link to your github repo with commit/tag
> containing the usage examples in the cover letter.

Thank you for the nice suggestion!  I will keep this patch on my development
tree at Github and provide a link to it.


Thanks,
SeongJae Park
