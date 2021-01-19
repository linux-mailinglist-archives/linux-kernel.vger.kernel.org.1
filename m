Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772212FC271
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbhASVgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:36:00 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11020 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbhASSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611081753; x=1642617753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=ZbYUR5dcTR5Pg5QurOsZdrIiwJ14CgBmEcmfusCljVc=;
  b=N5bvqEDLDrhA72rfMROcY6fblf1E61h/Ufk+fDitxQEnoydm1VSOIJlV
   z1rX4nlwIeqhw6sPkig4NBT03TW6T4B8BDzx8/pI12z5Ru57HO+UBBq7/
   Yu9SCW93jJH4fd8jp4MYtuDGtCQbQadIvByc6zRKAZ3wq1HybpkUP5lER
   U=;
X-IronPort-AV: E=Sophos;i="5.79,359,1602547200"; 
   d="scan'208";a="104947850"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 19 Jan 2021 18:41:40 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id ECC5CC0616;
        Tue, 19 Jan 2021 18:41:37 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.125) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 Jan 2021 18:41:21 +0000
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
Subject: Re: [RFC v10 01/13] damon/dbgfs: Allow users to set initial monitoring target regions
Date:   Tue, 19 Jan 2021 19:41:07 +0100
Message-ID: <20210119184107.1865-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216094221.11898-2-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.125]
X-ClientProxiedBy: EX13D22UWC003.ant.amazon.com (10.43.162.250) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 10:42:09 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Some 'damon-dbgfs' users would want to monitor only a part of the entire
> virtual memory address space.  The framework users in the kernel space
> could use '->init_target_regions' callback or even set the regions
> inside the context struct as they want, but 'damon-dbgfs' users cannot.
> 
> For the reason, this commit introduces a new debugfs file,
> 'init_region'.  'damon-dbgfs' users can specify which initial monitoring
> target address regions they want by writing special input to the file.
> The input should describe each region in each line in below form:
> 
>     <pid> <start address> <end address>
> 
> Note that the regions will be updated to cover entire memory mapped
> regions after 'regions update interval'.  If you want the regions to not
> be updated after the initial setting, you could set the interval as a
> very long time, say, a few decades.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/damon/dbgfs.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 06295c986dc3..2f1ec6ebd9f0 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
[...]
> +
> +static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
> +		size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = file->private_data;
> +	char *kbuf;
> +	ssize_t len;
> +
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (ctx->kdamond) {
> +		mutex_unlock(&ctx->kdamond_lock);
> +		return -EBUSY;

Coverity Static Analysis Security Testing (SAST) by Synopsys, Inc. found that
above return is missing deallocation of 'kbuf'.  I will fix this in the next
version.

> +	}
> +
> +	len = sprint_init_regions(ctx, kbuf, count);
> +	mutex_unlock(&ctx->kdamond_lock);
> +	if (len < 0)
> +		goto out;
> +	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
> +
> +out:
> +	kfree(kbuf);
> +	return len;
> +}


Thanks,
SeongJae Park
[...]
