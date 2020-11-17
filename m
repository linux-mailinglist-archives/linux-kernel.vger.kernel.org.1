Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CFC2B5AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKQIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:06:23 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59754 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKQIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605600382; x=1637136382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=K8f6ETiEAQNHhAiPwTTzrZ8ML7xCbvOY3ECTsRFRiDw=;
  b=r7irN8HXOePiw8itlFDd5gb3hL3YeETeaXsJdAlDeBaUBYy5VDpSPiuf
   83yNJprTAvNCM69IGU+Df3ESvfYa49xuSXBGpHwULXNPhbsfQZLMlYwGA
   H7PapC9yjTN3OLBrhQoaq6cB6sSf4b+qmWh5T4wXCo3vvRoR4N3fverR+
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,484,1596499200"; 
   d="scan'208";a="64147388"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 17 Nov 2020 08:06:13 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id C43A8A1C14;
        Tue, 17 Nov 2020 08:06:09 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.144) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 08:05:53 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <david@redhat.com>, <dwmw@amazon.com>, <elver@google.com>,
        <fan.du@intel.com>, <foersleo@amazon.de>, <gthelen@google.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v22 00/18] Introduce Data Access MONitor (DAMON)
Date:   Tue, 17 Nov 2020 09:05:39 +0100
Message-ID: <20201117080539.31334-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111164113.23245-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.144]
X-ClientProxiedBy: EX13D46UWB001.ant.amazon.com (10.43.161.16) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another ping.  I'm waiting for _any_ comments.


Thanks,
SeongJae Park

On Wed, 11 Nov 2020 17:41:13 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> Hi, I'd like to remind you that I'm still waiting more reviews.  Any comments
> are welcome.
> 
> 
> Thanks,
> SeongJae Park
> 
> On Tue, 20 Oct 2020 10:59:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Changes from Previous Version (v21)
> > ===================================
> > 
> > This version contains below minor changes.
> > 
> > - Fix build warnings and errors (kernel test robot)
> > - Fix a memory leak (kmemleak)
> > - Respect KUNIT_ALL_TESTS
> > - Rebase on v5.9
> > - Update the evaluation results
> > 
> > Introduction
> > ============
> > 
> > DAMON is a data access monitoring framework for the Linux kernel.  The core
> > mechanisms of DAMON called 'region based sampling' and 'adaptive regions
> > adjustment' (refer to 'mechanisms.rst' in the 11th patch of this patchset for
> > the detail) make it
> > 
> >  - accurate (The monitored information is useful for DRAM level memory
> >    management. It might not appropriate for Cache-level accuracy, though.),
> >  - light-weight (The monitoring overhead is low enough to be applied online
> >    while making no impact on the performance of the target workloads.), and
> >  - scalable (the upper-bound of the instrumentation overhead is controllable
> >    regardless of the size of target workloads.).
> > 
> > Using this framework, therefore, several memory management mechanisms such as
> > reclamation and THP can be optimized to aware real data access patterns.
> > Experimental access pattern aware memory management optimization works that
> > incurring high instrumentation overhead will be able to have another try.
> > 
> > Though DAMON is for kernel subsystems, it can be easily exposed to the user
> > space by writing a DAMON-wrapper kernel subsystem.  Then, user space users who
> > have some special workloads will be able to write personalized tools or
> > applications for deeper understanding and specialized optimizations of their
> > systems.
> > 
> > Evaluations
> > ===========
> > 
> > We evaluated DAMON's overhead, monitoring quality and usefulness using 24
> > realistic workloads on my QEMU/KVM based virtual machine running a kernel that
> > v22 DAMON patchset is applied.
> > 
> > DAMON is lightweight.  It increases system memory usage by 0.25% and slows
> > target workloads down by 0.89%.
> > 
> > DAMON is accurate and useful for memory management optimizations.  An
> > experimental DAMON-based operation scheme for THP, 'ethp', removes 81.73% of
> > THP memory overheads while preserving 95.29% of THP speedup.  Another
> > experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
> > reduces 91.30% of residential sets and 23.45% of system memory footprint while
> > incurring only 2.08% runtime overhead in the best case (parsec3/freqmine).
> > 
> > NOTE that the experimentail THP optimization and proactive reclamation are not
> > for production but only for proof of concepts.
> > 
> > Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
> > a document for DAMON" patch in this patchset for detailed evaluation setup and
> > results.
> > 
> > [1] https://damonitor.github.io/doc/html/latest-damon/admin-guide/mm/damon/eval.html
> > 
