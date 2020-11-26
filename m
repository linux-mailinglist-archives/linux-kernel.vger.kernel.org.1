Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D982C55DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbgKZNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:38:06 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:6228 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389878AbgKZNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606397885; x=1637933885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=G/pChsn4fN3Vyl1crrOE4ndzcerWTWr/tVT2Qyr7i24=;
  b=a0N4KrUDQki8GNjEhJ+VOiXpMARJjCuSucNavaBxCp6F1JdyUoB2Rsxu
   caV/jIcwDnWrA1NFpP2JffUtnDYyEQuxGL5RYSa7SR8NOXzBarNVrfsXD
   Xgj6nExgt8+lDWDXRO/mkgxlQlXyMKaH9LHzTE6LlLJEfYm3ENmkAHxQq
   k=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="66219790"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Nov 2020 13:37:58 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id A071FA21E3;
        Thu, 26 Nov 2020 13:37:46 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.229) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 13:37:30 +0000
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
Subject: Re: [PATCH v22 07/18] mm/page_idle: Avoid interferences from concurrent users
Date:   Thu, 26 Nov 2020 14:37:15 +0100
Message-ID: <20201126133715.4468-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7xhyp6yY_v6nyWp-yqHQUCtCBcxFXz=fSKOjS62HrG-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.229]
X-ClientProxiedBy: EX13D11UWC003.ant.amazon.com (10.43.162.162) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:30:27 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:06 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Concurrent Idle Page Tracking users can interfere each other because the
> > interface doesn't provide a central rule for synchronization between the
> > users.  Users could implement their own synchronization rule, but even
> > in that case, applications developed by different users would not know
> > how to synchronize with others.  To help this situation, this commit
> > introduces a centralized synchronization infrastructure of Idle Page
> > Tracking.
> >
> > In detail, this commit introduces a mutex lock for Idle Page Tracking,
> > called 'page_idle_lock'.  It is exposed to user space via a new bool
> > sysfs file, '/sys/kernel/mm/page_idle/lock'.  By writing to and reading
> > from the file, users can hold/release and read status of the mutex.
> > Writes to the Idle Page Tracking 'bitmap' file fails if the lock is not
> > held, while reads of the file can be done regardless of the lock status.
> >
> > Note that users could still interfere each other if they abuse this
> > locking rule.  Nevertheless, this change will let them notice the rule.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> I don't think this is allowed. I mean returning to user space with
> held mutex and other processes can unlock it. I don't think mutex is
> what you need. Or more importantly is this really an issue?
> 

In a separate call, I and Shakeel agreed on that this is trying to fix an issue
that aren't proved real.  So I will drop this patch in next version of the
patchset.  We can restore this patch or find better fix later if the problem
comes out in real.


Thanks,
SeongJae Park
