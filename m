Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0142E2080
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgLWSiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:38:52 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:61521 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgLWSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608748732; x=1640284732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=PMQG4qz/czIhu/3Vb66DfarbU9VPAw72RQIGHA4B6zU=;
  b=fCYdRZh9d5cM3hF2hQNeZKPl/maSbdB3g3dOE2C9gClhmWUTAyKAITCM
   0OHhiwiuhA354Vtj7Jxp3/Pt2YJyRIF2RCc220aGW4gzj5cbqMZ27M3TO
   zOR6Vvtq7UOZzqTSfzJscDVBVkGmmOSzHqCHx+LqR097A4tVBneqtDmaW
   c=;
X-IronPort-AV: E=Sophos;i="5.78,442,1599523200"; 
   d="scan'208";a="73319603"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Dec 2020 18:38:04 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 81C9BA1F19;
        Wed, 23 Dec 2020 18:37:52 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.66) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Dec 2020 18:37:35 +0000
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
Subject: Re: [PATCH v23 11/15] tools: Introduce a minimal user-space tool for DAMON
Date:   Wed, 23 Dec 2020 19:37:21 +0100
Message-ID: <20201223183721.8898-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215115448.25633-12-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D35UWB003.ant.amazon.com (10.43.161.65) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 12:54:44 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> 'damon-dbgfs' provides simple user space interface for DAMON, but using
> the interface for complex usages could require annoying repetitive
> works.  Writing a user space data access monitoring applications on top
> of the debugfs interface and using the application would be better for
> such complex cases.
> 
> This commit introduces a reference implementation of such user space
> application built on top of the debugfs interface, namely 'DAMon
> Operator' (DAMO).  It contains a shallow wrapper python script of the
> debugfs interface and various visualization of the monitoring results
> convenient user interface.
> 
> Note that it is initially aimed to be used for minimal reference of the
> 'damon-dbgfs' interface and for debugging of the DAMON itself.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/damon/.gitignore    |   1 +
>  tools/damon/_damon.py     | 130 ++++++++++++++
>  tools/damon/_dist.py      |  35 ++++
>  tools/damon/_recfile.py   |  23 +++
>  tools/damon/bin2txt.py    |  67 +++++++
>  tools/damon/damo          |  37 ++++
>  tools/damon/heats.py      | 362 ++++++++++++++++++++++++++++++++++++++
>  tools/damon/nr_regions.py |  91 ++++++++++
>  tools/damon/record.py     | 135 ++++++++++++++
>  tools/damon/report.py     |  45 +++++
>  tools/damon/wss.py        | 100 +++++++++++
>  11 files changed, 1026 insertions(+)

I will drop this patch from the next version of this patchset, because this is
not the essential part but could only make the code review time consuming.  I
will post another DAMON RFC patchset for convenient user space usages including
this and the perf integration.
