Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4306E2FBF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbhASSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:44:26 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:51850 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbhASSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611081493; x=1642617493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=KZM1YrJFzekGYZS1Tr/APAkkwA1kXNN/k2pjtWwyQc8=;
  b=sDx1KMnWXAl7B0DGAbhFIwH5Ww8eaoMdVFGjzdF59GWxcFsZlzF/kIp6
   Qp0MwsX/l4uWxhLU895MzHkwY/FOwEFZWwXl/KA6XTXd26Isv+ctkSz+D
   UJwa8V/51K8UPkVkAz4KJCfOkCKtfA8oc2LSicb2vjPesc6xqeFqK9QYx
   g=;
X-IronPort-AV: E=Sophos;i="5.79,359,1602547200"; 
   d="scan'208";a="113266096"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 19 Jan 2021 18:37:11 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 3A176A248E;
        Tue, 19 Jan 2021 18:37:08 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.203) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 Jan 2021 18:36:51 +0000
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
Subject: Re: [PATCH v23 03/15] mm/damon: Adaptively adjust regions
Date:   Tue, 19 Jan 2021 19:36:36 +0100
Message-ID: <20210119183636.327-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215115448.25633-4-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D20UWA002.ant.amazon.com (10.43.160.176) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 12:54:36 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Even somehow the initial monitoring target regions are well constructed
> to fulfill the assumption (pages in same region have similar access
> frequencies), the data access pattern can be dynamically changed.  This
> will result in low monitoring quality.  To keep the assumption as much
> as possible, DAMON adaptively merges and splits each region based on
> their access frequency.
> 
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two or three regions if the
> total number of regions will not exceed the user-specified maximum
> number of regions after the split.
> 
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the upper-bound overhead that users set.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |  41 +++++---
>  mm/damon/core.c       | 220 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 240 insertions(+), 21 deletions(-)
> 
[...]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 167487e75737..0f9beb60d9dd 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> +
> +/*
> + * Split a region in two
> + *
> + * r		the region to be split
> + * sz_r		size of the first sub-region that will be made
> + */
> +static void damon_split_region_at(struct damon_ctx *ctx,
> +				  struct damon_region *r, unsigned long sz_r)
> +{
> +	struct damon_region *new;
> +
> +	new = damon_new_region(r->ar.start + sz_r, r->ar.end);

Coverity Static Analysis Security Testing (SAST) by Synopsys, Inc. found that
'damon_new_region()' could return NULL in case of memory allocation failure,
but NULL check for 'new' is missed here.  I will add the check in the next
version.

> +	r->ar.end = new->ar.start;
> +
> +	damon_insert_region(new, r, damon_next_region(r));
> +}
[...]


Thanks,
SeongJae Park
