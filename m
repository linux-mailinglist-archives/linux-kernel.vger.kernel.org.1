Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53E32C566D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbgKZNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:47:35 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61604 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390354AbgKZNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606398454; x=1637934454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=fyAnVHSM7DUGAUg/UQTCA37wZ5eyuf7HfQz0TTccKaA=;
  b=nFc2aNQOhGa8p77FBo0X3QwCL2C+7jixou3Ag1n7OdQmebRr2CvNjCNY
   I5BruyZHh6rnAYmjNBviXiXGrvOs+Di2uyl7iemJLm7YsnsKNKK5/DO1/
   ttX+IYOlnQ4WEGnQpRe6xQPQXIa/vhItJupLrwEjD12+ynr21sVzt1M0I
   s=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="91197811"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 26 Nov 2020 13:46:15 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 8C108A1F84;
        Thu, 26 Nov 2020 13:46:12 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 13:45:55 +0000
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
Subject: Re: [PATCH v22 10/18] mm/damon: Implement a debugfs-based user space interface
Date:   Thu, 26 Nov 2020 14:45:39 +0100
Message-ID: <20201126134539.5974-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6md-OQD6ZKYtPjOgC5TvhDb0X0fBewA9dZAwhmwQw4=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D42UWA001.ant.amazon.com (10.43.160.153) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:30:36 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:06 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is designed to be used by kernel space code such as the memory
> > management subsystems, and therefore it provides only kernel space API.
> > That said, letting the user space control DAMON could provide some
> > benefits to them.  For example, it will allow user space to analyze
> > their specific workloads and make their own special optimizations.
> >
> > For such cases, this commit implements a simple DAMON application kernel
> > module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> > exports those to the user space via the debugfs.
> >
> > 'damon-dbgfs' exports three files, ``attrs``, ``target_ids``, and
> > ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
> >>
[...]
> > +/**
> > + * damon_nr_running_ctxs() - Return number of currently running contexts.
> > + */
> > +int damon_nr_running_ctxs(void)
> > +{
> > +       int nr_ctxs;
> > +
> > +       mutex_lock(&damon_lock);
> > +       nr_ctxs = nr_running_ctxs;
> > +       mutex_unlock(&damon_lock);
> > +
> 
> READ_ONCE() instead of mutex?

Right, it would be ok and even make the code slightly faster.  But, if you're
ok, I'd like to keep this as is because this helps reader easily find what
variables are protected by the mutex and this is not performance critical.

> 
> > +       return nr_ctxs;
> > +}
> > +
[...]
> > +
> > +static ssize_t dbgfs_target_ids_write(struct file *file,
> > +               const char __user *buf, size_t count, loff_t *ppos)
> > +{
> > +       struct damon_ctx *ctx = file->private_data;
> > +       char *kbuf, *nrs;
> > +       bool received_pidfds = false;
> > +       unsigned long *targets;
> > +       ssize_t nr_targets;
> > +       ssize_t ret = count;
> > +       int i;
> > +       int err;
> > +
> > +       kbuf = user_input_str(buf, count, ppos);
> > +       if (IS_ERR(kbuf))
> > +               return PTR_ERR(kbuf);
> > +
> > +       nrs = kbuf;
> > +
> > +       if (!strncmp(kbuf, "pidfd ", 6)) {
> > +               received_pidfds = true;
> 
> I am inclining towards having simple pids instead of pidfds. Basically
> what cgroup/resctrl does.

Ok, I will drop the pidfd support for simplicity.  Restoring it back when real
requirement comes out would not be too late.

> 
> 
> > +               nrs = &kbuf[6];
> > +       }
> > +
> > +       targets = str_to_target_ids(nrs, ret, &nr_targets);
> > +       if (!targets) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       if (received_pidfds) {
> > +               for (i = 0; i < nr_targets; i++)
> > +                       targets[i] = (unsigned long)damon_get_pidfd_pid(
> > +                                       (unsigned int)targets[i]);
> > +       } else if (targetid_is_pid(ctx)) {
> > +               for (i = 0; i < nr_targets; i++)
> > +                       targets[i] = (unsigned long)find_get_pid(
> > +                                       (int)targets[i]);
> > +       }
> > +
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       if (ctx->kdamond) {
> > +               ret = -EINVAL;
> > +               goto unlock_out;
> > +       }
> > +
> > +       err = damon_set_targets(ctx, targets, nr_targets);
> 
> Hmm this is leaking the references to the previous targets.

'damon_set_targets()' frees the previous targets itself, so we don't leak.

> 
> > +       if (err)
> > +               ret = err;
> > +unlock_out:
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +       kfree(targets);
> > +out:
> > +       kfree(kbuf);
> > +       return ret;
> > +}
> > +
> 
> Still looking.

Looking forward your comments!


Thanks,
SeongJae Park
