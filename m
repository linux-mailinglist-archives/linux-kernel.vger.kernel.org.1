Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C322C42ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgKYPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbgKYPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:31:09 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F37C061A51
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:50 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so3709284lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y6Qteui0U72GjYb0hcFpaKt3E3Pqq0pI63D/2ARNoU=;
        b=iD2KJNqW6rBlkyxz/a4qfRgMBqYkDbYojLMRg8ZUbG9uMipKMNnAyG4TOBJFpELGqF
         eAxW8U4l5jkoHRx0YRQH1mFDPO3GVedHz8tRw6U6h21p/C7on6lplUDi3vzKmobnFsE6
         nMcbyNyn90bk6QLUaWy2FansljF+e+SvI3m12/V58XHtr48BvcMHLV6V4qWVFQcyoQ7l
         Rb109ThEBjgQzQr8ODnRCCMvjGlOk3sMJ7f42P1qekq7aK/14PFiWJbQZthJTEQidrjD
         JtDQPeyAJPmlgWvTe18aOG7fasVO5lf6fuJKR7Vj6r2VDoQda3kleXyMFunAa5dL3DZ5
         8c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y6Qteui0U72GjYb0hcFpaKt3E3Pqq0pI63D/2ARNoU=;
        b=blsrrnR92StIAeJRVQZZPzGFYokf+NRI5onDNRzQkwkHskP8bhfm8SufrbIlMa+SR6
         pja+Ntt3AWbC/CzR6QzdKAqtAsNwHx6uZpARTYxa6Z00gHLg6uAMOZRr3v6+lv44TN0z
         H86r9LjBZHuHP7e2DTFyhSC8gN63fa8mUP4OHV7KhnU7nz1dHLo78Qiy/efAAuQo5miQ
         oTwl7deS4Z/wBeVBYEf3nywdPiFmerF25ebJf47ZKM5rRlvw87JZLZKCGVelUyI133as
         JVeixFSvnQrK2NZYAiguJT/dA2+Dl38nichkWvSIa9awlGjVl1mEAk42rXT26z5rfa1o
         zpvQ==
X-Gm-Message-State: AOAM533Lj8oiktbf45VQDXs4cwNGOKJgX1pCg8q2z48h1d3S7lNJYVOi
        tc7VYfnjdu3R8KOF14BRg+cwOrDeawlFFaxm+rnXbg==
X-Google-Smtp-Source: ABdhPJxKMDSfUq4mA5Zhp9+bspwRx1sJB7dxVtiVouvYyiHhVQKtzRygXeR1SPiri8AE/PlULIk/gfm5xr7EtRPuIyE=
X-Received: by 2002:ac2:5a4d:: with SMTP id r13mr1495513lfn.449.1606318248233;
 Wed, 25 Nov 2020 07:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20201020085940.13875-1-sjpark@amazon.com> <20201020085940.13875-11-sjpark@amazon.com>
In-Reply-To: <20201020085940.13875-11-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Nov 2020 07:30:36 -0800
Message-ID: <CALvZod6md-OQD6ZKYtPjOgC5TvhDb0X0fBewA9dZAwhmwQw4=w@mail.gmail.com>
Subject: Re: [PATCH v22 10/18] mm/damon: Implement a debugfs-based user space interface
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:06 AM SeongJae Park <sjpark@amazon.com> wrote:
>
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
>
> 'damon-dbgfs' exports three files, ``attrs``, ``target_ids``, and
> ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
>
> Attributes
> ----------
>
> Users can read and write the ``sampling interval``, ``aggregation
> interval``, ``regions update interval``, and min/max number of
> monitoring target regions by reading from and writing to the ``attrs``
> file.  For example, below commands set those values to 5 ms, 100 ms,
> 1,000 ms, 10, 1000 and check it again::
>
>     # cd <debugfs>/damon
>     # echo 5000 100000 1000000 10 1000 > attrs
>     # cat attrs
>     5000 100000 1000000 10 1000
>
> Target IDs
> ----------
>
> Some types of address spaces supports multiple monitoring target.  For
> example, the virtual memory address spaces monitoring can have multiple
> processes as the monitoring targets.  Users can set the targets by
> writing relevant id values of the targets to, and get the ids of the
> current targets by reading from the ``target_ids`` file.  In case of the
> virtual address spaces monitoring, the values should be pids of the
> monitoring target processes.  For example, below commands set processes
> having pids 42 and 4242 as the monitoring targets and check it again::
>
>     # cd <debugfs>/damon
>     # echo 42 4242 > target_ids
>     # cat target_ids
>     42 4242
>
> Note that setting the target ids doesn't start the monitoring.
>
> Turning On/Off
> --------------
>
> Setting the files as described above doesn't incur effect unless you
> explicitly start the monitoring.  You can start, stop, and check the
> current status of the monitoring by writing to and reading from the
> ``monitor_on`` file.  Writing ``on`` to the file starts the monitoring
> of the targets with the attributes.  Writing ``off`` to the file stops
> those.  DAMON also stops if every targets are invalidated (in case of
> the virtual memory monitoring, target processes are invalidated when
> terminated).  Below example commands turn on, off, and check the status
> of DAMON::
>
>     # cd <debugfs>/damon
>     # echo on > monitor_on
>     # echo off > monitor_on
>     # cat monitor_on
>     off
>
> Please note that you cannot write to the above-mentioned debugfs files
> while the monitoring is turned on.  If you write to the files while
> DAMON is running, an error code such as ``-EBUSY`` will be returned.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |   2 +
>  mm/damon/Kconfig      |   9 +
>  mm/damon/Makefile     |   1 +
>  mm/damon/core.c       |  48 +++++
>  mm/damon/dbgfs.c      | 428 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 488 insertions(+)
>  create mode 100644 mm/damon/dbgfs.c
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 70cc4b54212e..d675ea908a02 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -226,6 +226,8 @@ void damon_free_target(struct damon_target *t);
>  void damon_destroy_target(struct damon_target *t);
>  unsigned int damon_nr_regions(struct damon_target *t);
>
> +struct damon_ctx *damon_new_ctx(void);
> +void damon_destroy_ctx(struct damon_ctx *ctx);
>  int damon_set_targets(struct damon_ctx *ctx,
>                 unsigned long *ids, ssize_t nr_ids);
>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 63b9c905b548..e38f95d28f74 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -22,4 +22,13 @@ config DAMON_PRIMITIVES
>           The primitives support only virtual address spaces.  If this cannot
>           cover your use case, you can implement and use your own primitives.
>
> +config DAMON_DBGFS
> +       bool "DAMON debugfs interface"
> +       depends on DAMON_PRIMITIVES && DEBUG_FS
> +       help
> +         This builds the debugfs interface for DAMON.  The user space admins
> +         can use the interface for arbitrary data access monitoring.
> +
> +         If unsure, say N.
> +
>  endmenu
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index 2f3235a52e5e..2295deb2fe0e 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -2,3 +2,4 @@
>
>  obj-$(CONFIG_DAMON)            := core.o
>  obj-$(CONFIG_DAMON_PRIMITIVES) += primitives.o
> +obj-$(CONFIG_DAMON_DBGFS)      += dbgfs.o
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d7957d8ff530..47baf859d7d9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -135,6 +135,40 @@ unsigned int damon_nr_regions(struct damon_target *t)
>         return nr_regions;
>  }
>
> +struct damon_ctx *damon_new_ctx(void)
> +{
> +       struct damon_ctx *ctx;
> +
> +       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return NULL;
> +
> +       ctx->sample_interval = 5 * 1000;
> +       ctx->aggr_interval = 100 * 1000;
> +       ctx->regions_update_interval = 1000 * 1000;
> +       ctx->min_nr_regions = 10;
> +       ctx->max_nr_regions = 1000;
> +
> +       ktime_get_coarse_ts64(&ctx->last_aggregation);
> +       ctx->last_regions_update = ctx->last_aggregation;
> +
> +       mutex_init(&ctx->kdamond_lock);
> +
> +       INIT_LIST_HEAD(&ctx->targets_list);
> +
> +       return ctx;
> +}
> +
> +void damon_destroy_ctx(struct damon_ctx *ctx)
> +{
> +       struct damon_target *t, *next_t;
> +
> +       damon_for_each_target_safe(t, next_t, ctx)
> +               damon_destroy_target(t);
> +
> +       kfree(ctx);
> +}
> +
>  /**
>   * damon_set_targets() - Set monitoring targets.
>   * @ctx:       monitoring context
> @@ -204,6 +238,20 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>         return 0;
>  }
>
> +/**
> + * damon_nr_running_ctxs() - Return number of currently running contexts.
> + */
> +int damon_nr_running_ctxs(void)
> +{
> +       int nr_ctxs;
> +
> +       mutex_lock(&damon_lock);
> +       nr_ctxs = nr_running_ctxs;
> +       mutex_unlock(&damon_lock);
> +

READ_ONCE() instead of mutex?

> +       return nr_ctxs;
> +}
> +
>  /* Returns the size upper limit for each monitoring region */
>  static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  {
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> new file mode 100644
> index 000000000000..6316d4cae2a4
> --- /dev/null
> +++ b/mm/damon/dbgfs.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DAMON Debugfs Interface
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#define pr_fmt(fmt) "damon-dbgfs: " fmt
> +
> +#include <linux/damon.h>
> +#include <linux/debugfs.h>
> +#include <linux/file.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/page_idle.h>
> +#include <linux/slab.h>
> +
> +static struct damon_ctx **dbgfs_ctxs;
> +static int dbgfs_nr_ctxs = 1;
> +static int dbgfs_nr_terminated_ctxs;
> +static struct dentry **dbgfs_dirs;
> +static DEFINE_MUTEX(damon_dbgfs_lock);
> +
> +/*
> + * Returns non-empty string on success, negarive error code otherwise.
> + */
> +static char *user_input_str(const char __user *buf, size_t count, loff_t *ppos)
> +{
> +       char *kbuf;
> +       ssize_t ret;
> +
> +       /* We do not accept continuous write */
> +       if (*ppos)
> +               return ERR_PTR(-EINVAL);
> +
> +       kbuf = kmalloc(count + 1, GFP_KERNEL);
> +       if (!kbuf)
> +               return ERR_PTR(-ENOMEM);
> +
> +       ret = simple_write_to_buffer(kbuf, count + 1, ppos, buf, count);
> +       if (ret != count) {
> +               kfree(kbuf);
> +               return ERR_PTR(-EIO);
> +       }
> +       kbuf[ret] = '\0';
> +
> +       return kbuf;
> +}
> +
> +static ssize_t dbgfs_attrs_read(struct file *file,
> +               char __user *buf, size_t count, loff_t *ppos)
> +{
> +       struct damon_ctx *ctx = file->private_data;
> +       char kbuf[128];
> +       int ret;
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       ret = scnprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
> +                       ctx->sample_interval, ctx->aggr_interval,
> +                       ctx->regions_update_interval, ctx->min_nr_regions,
> +                       ctx->max_nr_regions);
> +       mutex_unlock(&ctx->kdamond_lock);
> +
> +       return simple_read_from_buffer(buf, count, ppos, kbuf, ret);
> +}
> +
> +static ssize_t dbgfs_attrs_write(struct file *file,
> +               const char __user *buf, size_t count, loff_t *ppos)
> +{
> +       struct damon_ctx *ctx = file->private_data;
> +       unsigned long s, a, r, minr, maxr;
> +       char *kbuf;
> +       ssize_t ret = count;
> +       int err;
> +
> +       kbuf = user_input_str(buf, count, ppos);
> +       if (IS_ERR(kbuf))
> +               return PTR_ERR(kbuf);
> +
> +       if (sscanf(kbuf, "%lu %lu %lu %lu %lu",
> +                               &s, &a, &r, &minr, &maxr) != 5) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       if (ctx->kdamond) {
> +               ret = -EBUSY;
> +               goto unlock_out;
> +       }
> +
> +       err = damon_set_attrs(ctx, s, a, r, minr, maxr);
> +       if (err)
> +               ret = err;
> +unlock_out:
> +       mutex_unlock(&ctx->kdamond_lock);
> +out:
> +       kfree(kbuf);
> +       return ret;
> +}
> +
> +#define targetid_is_pid(ctx)   \
> +       (ctx->primitive.target_valid == damon_va_target_valid)
> +
> +static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
> +{
> +       struct damon_target *t;
> +       unsigned long id;
> +       int written = 0;
> +       int rc;
> +
> +       damon_for_each_target(t, ctx) {
> +               id = t->id;
> +               if (targetid_is_pid(ctx))
> +                       /* Show pid numbers to debugfs users */
> +                       id = (unsigned long)pid_vnr((struct pid *)id);
> +
> +               rc = scnprintf(&buf[written], len - written, "%lu ", id);
> +               if (!rc)
> +                       return -ENOMEM;
> +               written += rc;
> +       }
> +       if (written)
> +               written -= 1;
> +       written += scnprintf(&buf[written], len - written, "\n");
> +       return written;
> +}
> +
> +static ssize_t dbgfs_target_ids_read(struct file *file,
> +               char __user *buf, size_t count, loff_t *ppos)
> +{
> +       struct damon_ctx *ctx = file->private_data;
> +       ssize_t len;
> +       char ids_buf[320];
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       len = sprint_target_ids(ctx, ids_buf, 320);
> +       mutex_unlock(&ctx->kdamond_lock);
> +       if (len < 0)
> +               return len;
> +
> +       return simple_read_from_buffer(buf, count, ppos, ids_buf, len);
> +}
> +
> +/*
> + * Converts a string into an array of unsigned long integers
> + *
> + * Returns an array of unsigned long integers if the conversion success, or
> + * NULL otherwise.
> + */
> +static unsigned long *str_to_target_ids(const char *str, ssize_t len,
> +                                       ssize_t *nr_ids)
> +{
> +       unsigned long *ids;
> +       const int max_nr_ids = 32;
> +       unsigned long id;
> +       int pos = 0, parsed, ret;
> +
> +       *nr_ids = 0;
> +       ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
> +       if (!ids)
> +               return NULL;
> +       while (*nr_ids < max_nr_ids && pos < len) {
> +               ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
> +               pos += parsed;
> +               if (ret != 1)
> +                       break;
> +               ids[*nr_ids] = id;
> +               *nr_ids += 1;
> +       }
> +
> +       return ids;
> +}
> +
> +/* Returns pid for the given pidfd if it's valid, or NULL otherwise. */
> +static struct pid *damon_get_pidfd_pid(unsigned int pidfd)
> +{
> +       struct fd f;
> +       struct pid *pid;
> +
> +       f = fdget(pidfd);
> +       if (!f.file)
> +               return NULL;
> +
> +       pid = pidfd_pid(f.file);
> +       if (!IS_ERR(pid))
> +               get_pid(pid);
> +       else
> +               pid = NULL;
> +
> +       fdput(f);
> +       return pid;
> +}
> +
> +static ssize_t dbgfs_target_ids_write(struct file *file,
> +               const char __user *buf, size_t count, loff_t *ppos)
> +{
> +       struct damon_ctx *ctx = file->private_data;
> +       char *kbuf, *nrs;
> +       bool received_pidfds = false;
> +       unsigned long *targets;
> +       ssize_t nr_targets;
> +       ssize_t ret = count;
> +       int i;
> +       int err;
> +
> +       kbuf = user_input_str(buf, count, ppos);
> +       if (IS_ERR(kbuf))
> +               return PTR_ERR(kbuf);
> +
> +       nrs = kbuf;
> +
> +       if (!strncmp(kbuf, "pidfd ", 6)) {
> +               received_pidfds = true;

I am inclining towards having simple pids instead of pidfds. Basically
what cgroup/resctrl does.


> +               nrs = &kbuf[6];
> +       }
> +
> +       targets = str_to_target_ids(nrs, ret, &nr_targets);
> +       if (!targets) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       if (received_pidfds) {
> +               for (i = 0; i < nr_targets; i++)
> +                       targets[i] = (unsigned long)damon_get_pidfd_pid(
> +                                       (unsigned int)targets[i]);
> +       } else if (targetid_is_pid(ctx)) {
> +               for (i = 0; i < nr_targets; i++)
> +                       targets[i] = (unsigned long)find_get_pid(
> +                                       (int)targets[i]);
> +       }
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       if (ctx->kdamond) {
> +               ret = -EINVAL;
> +               goto unlock_out;
> +       }
> +
> +       err = damon_set_targets(ctx, targets, nr_targets);

Hmm this is leaking the references to the previous targets.

> +       if (err)
> +               ret = err;
> +unlock_out:
> +       mutex_unlock(&ctx->kdamond_lock);
> +       kfree(targets);
> +out:
> +       kfree(kbuf);
> +       return ret;
> +}
> +

Still looking.
