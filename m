Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA31228F5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389673AbgJOPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:23:16 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43359 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJOPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602775394; x=1634311394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=N7Pt2vWfkL2KgMmp7j77tD/M3NxUitM8f78mdFyOf0g=;
  b=vKYY6yzetILSNpU6M2+vdHqyuCT/YSYLhWFio9pBbxxXmvp08YDEKwmf
   yYz0toR4U9H70foJzpGg2++dsVdFQf0D1MxKRO15pOIgLHRScHFL10e+5
   JVJCy0VEVdn2b7hmDEvFKNb9I/eYYcrQRJD59rrs6lc9Wl0Kz4p8NO9rh
   g=;
X-IronPort-AV: E=Sophos;i="5.77,379,1596499200"; 
   d="scan'208";a="59534766"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 15 Oct 2020 15:23:12 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 4EA9CA250B;
        Thu, 15 Oct 2020 15:22:59 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.67) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 15 Oct 2020 15:22:41 +0000
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
Subject: Re: [PATCH v21 10/18] mm/damon: Implement a debugfs-based user space interface
Date:   Thu, 15 Oct 2020 17:22:26 +0200
Message-ID: <20201015152226.7106-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005105522.23841-11-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.67]
X-ClientProxiedBy: EX13P01UWB003.ant.amazon.com (10.43.161.209) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 12:55:14 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON is designed to be used by kernel space code such as the memory
> management subsystems, and therefore it provides only kernel space API.
> That said, letting the user space control DAMON could provide some
> benefits to them.  For example, it will allow user space to analyze
> their specific workloads and make their own special optimizations.
> 
> For such cases, this commit implements a simple DAMON application kernel
> module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> exports those to the user space via the debugfs.
[...]
> +
> +static ssize_t dbgfs_monitor_on_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	ssize_t ret = count;
> +	char *kbuf;
> +	int err;
> +
> +	kbuf = user_input_str(buf, count, ppos);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);
> +
> +	/* Remove white space */
> +	if (sscanf(kbuf, "%s", kbuf) != 1)
> +		return -EINVAL;
> +	if (!strncmp(kbuf, "on", count))
> +		err = dbgfs_start_ctxs(dbgfs_ctxs, dbgfs_nr_ctxs);
> +	else if (!strncmp(kbuf, "off", count))
> +		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
> +	else
> +		return -EINVAL;
> +
> +	if (err)
> +		ret = err;
> +	return ret;

'kbuf' should be freed before returning from this function.  I will fix it in
the next version.  To find more potential memory leaks, I ran 'kmemleak' after
a set of correctness tests[1], but it didn't find more leaks.

[1] https://github.com/awslabs/damon-tests/tree/master/corr


Thanks,
SeongJae Park
