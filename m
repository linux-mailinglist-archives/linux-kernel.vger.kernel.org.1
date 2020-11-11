Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04BA2AF6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKKQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:42:04 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:12314 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgKKQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605112923; x=1636648923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=twEFaM6H/18ZRD5aG4A3ebeJ7U/rCfvoC5YljalWKk4=;
  b=RTe8IGKRCjk9IAa1o1wi5w9IjuLCrFeCVfbhxzffg2vlTzE3msGq3GiD
   rL2O/kcgBcXP/xEnwgfah9sIaKlcv/V4CdngoMOvgcAYZqLjbwr9htozu
   D+vVV7VzysSGHBOHIXOhEIYy27qvhhoin5Lgd5Ci9NFRUo4tT8E/FX+df
   A=;
X-IronPort-AV: E=Sophos;i="5.77,470,1596499200"; 
   d="scan'208";a="65959363"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 11 Nov 2020 16:41:56 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 63583A24BE;
        Wed, 11 Nov 2020 16:41:44 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Nov 2020 16:41:27 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v22 00/18] Introduce Data Access MONitor (DAMON)
Date:   Wed, 11 Nov 2020 17:41:13 +0100
Message-ID: <20201111164113.23245-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020085940.13875-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D38UWB004.ant.amazon.com (10.43.161.30) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'd like to remind you that I'm still waiting more reviews.  Any comments
are welcome.


Thanks,
SeongJae Park

On Tue, 20 Oct 2020 10:59:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Changes from Previous Version (v21)
> ===================================
> 
> This version contains below minor changes.
> 
> - Fix build warnings and errors (kernel test robot)
> - Fix a memory leak (kmemleak)
> - Respect KUNIT_ALL_TESTS
> - Rebase on v5.9
> - Update the evaluation results
> 
> Introduction
> ============
> 
> DAMON is a data access monitoring framework for the Linux kernel.  The core
> mechanisms of DAMON called 'region based sampling' and 'adaptive regions
> adjustment' (refer to 'mechanisms.rst' in the 11th patch of this patchset for
> the detail) make it
> 
>  - accurate (The monitored information is useful for DRAM level memory
>    management. It might not appropriate for Cache-level accuracy, though.),
>  - light-weight (The monitoring overhead is low enough to be applied online
>    while making no impact on the performance of the target workloads.), and
>  - scalable (the upper-bound of the instrumentation overhead is controllable
>    regardless of the size of target workloads.).
> 
> Using this framework, therefore, several memory management mechanisms such as
> reclamation and THP can be optimized to aware real data access patterns.
> Experimental access pattern aware memory management optimization works that
> incurring high instrumentation overhead will be able to have another try.
> 
> Though DAMON is for kernel subsystems, it can be easily exposed to the user
> space by writing a DAMON-wrapper kernel subsystem.  Then, user space users who
> have some special workloads will be able to write personalized tools or
> applications for deeper understanding and specialized optimizations of their
> systems.
> 
> Evaluations
> ===========
> 
> We evaluated DAMON's overhead, monitoring quality and usefulness using 24
> realistic workloads on my QEMU/KVM based virtual machine running a kernel that
> v22 DAMON patchset is applied.
> 
> DAMON is lightweight.  It increases system memory usage by 0.25% and slows
> target workloads down by 0.89%.
> 
> DAMON is accurate and useful for memory management optimizations.  An
> experimental DAMON-based operation scheme for THP, 'ethp', removes 81.73% of
> THP memory overheads while preserving 95.29% of THP speedup.  Another
> experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
> reduces 91.30% of residential sets and 23.45% of system memory footprint while
> incurring only 2.08% runtime overhead in the best case (parsec3/freqmine).
> 
> NOTE that the experimentail THP optimization and proactive reclamation are not
> for production but only for proof of concepts.
> 
> Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
> a document for DAMON" patch in this patchset for detailed evaluation setup and
> results.
> 
> [1] https://damonitor.github.io/doc/html/latest-damon/admin-guide/mm/damon/eval.html
> 
