Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271BC2F81FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbhAORSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhAORSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:18:24 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F7C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:17:44 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so6543462qtn.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DHaZOpAOYW+CVAQpgGqLKRGRisryfn2+7uDhop5wiY=;
        b=nWG6nkLP2W832dXmwscLjoKUdOBGPYCgnSpWhfC8a3bWNfA3MO+kMOxC9x46VDUdHT
         +nYmt4sigwb0D1GXaDdtv5qWHeP+3Zxp9uhS5/+h2U7wkJKnWwbij7Cr8oysLba9DWDc
         UOcARMtGLoPIJlC4Se89RRNeP3lshYhbPNE983NFiOk7WtB817qJHroXPorYOZYR59Jt
         eV3WIM0xQkTXtushzJfbDQorIfZr3F3u7NU213oZa8qtYoWpizVyDiKGBJSpGj4UAtjo
         eE0B17ufL0T2FIVTRNXtJsQyjjT5Yf6x46HcWsJHO04glW3MhS5RhJSQHS5cjey4yg8v
         2hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DHaZOpAOYW+CVAQpgGqLKRGRisryfn2+7uDhop5wiY=;
        b=cszz2Qat9LQx++/ONAFz40+yLQAcdXblc4kaNiTX1Y9eeG2JJF1PXkRLexqVKwLrHT
         p0/weHQSNMi/lDHQmZwtMXulsPRTobiLWLX5zf9ae0AnhLXdVTyUAhh9h0M9BrA0w8dU
         l9/KrdcH/m+kHx4/HZIJJHTcGEGbcJOVoiSMtPVJaT/jdaWW3kF+rzlb5rMUzVHfC7hg
         0f8Cb/vaYir4Jo8xN/K56vJeEOZoebgM8m7c+THSeuZ6agdvwKLZqrlcbEnvvkJxwU/B
         ZG1Hd077Fp0i8CsF4L7DLhsntHnfMh+kVikS4iGjmjTuyhqZVpS9xKJqcWfEVwclGC1f
         cvkg==
X-Gm-Message-State: AOAM531Wmhl6OlbjpS61vA8QLoPoFdyi9ZWIvknhrfq+p8HKGqr29kic
        B83n7nictN9JIV9IuZxoQ1a+rYLOEGeRzlA/49dkfQ==
X-Google-Smtp-Source: ABdhPJwrhbcCaDD/baTLOprNNrD/xSRJFUJeBmlRgVauzzrolfvDAlDbLX+jx+zbI9U2zXUvVlreppV8EWfQnIdOpN8=
X-Received: by 2002:ac8:7512:: with SMTP id u18mr12796120qtq.300.1610731062778;
 Fri, 15 Jan 2021 09:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <20210115130336.2520663-3-glider@google.com>
 <YAGdqgjLd2XHAjjm@kroah.com>
In-Reply-To: <YAGdqgjLd2XHAjjm@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 18:17:30 +0100
Message-ID: <CAG_fn=WwMzCNyDMd7zARr+3fNp-eKReo1f7R4KvpQXkPpD2_7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Minor comments, if in the future, you really do want to mess around in sysfs:
>
Thanks! Guess most of these comments apply even if I choose another FS
to mess around with.

> No copyright notice for the file?  While acceptable, odds are your
> corporate lawyers will not be happy with that :(

You are right, will fix.

> > +/*
> > + * Userspace notification interface for debugging tools.
> > + *
> > + * Provide two sysfs files:
> > + *  - /sys/kernel/error_report/last_report
> > + *  - /sys/kernel/error_report/report_count
> > + * that contain the last debugging tool report (taken from dmesg, delimited by
> > + * the error_report_start/error_report_end tracing events) and the total report
> > + * count.
> > + */
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/fs.h>
> > +#include <linux/kobject.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/tracepoint.h>
> > +#include <linux/workqueue.h>
> > +#include <trace/events/error_report.h>
> > +#include <trace/events/printk.h>
> > +
> > +static struct kobject *error_report_kobj;
> > +
> > +/* sysfs files are capped at PAGE_SIZE. */
> > +#define BUF_SIZE PAGE_SIZE
> > +/* Two buffers to store the finished report and the report being recorded. */
> > +static char report_buffer[2][BUF_SIZE];
> > +/*
> > + * Total report count. Also serves as a latch for report_buffer:
> > + * report_buffer[num_reports % 2] is the currently available report,
> > + * report_buffer[(num_reports + 1) % 2] is the report being recorded.
> > + */
> > +static atomic_t num_reports;
> > +
> > +/*
> > + * PID of the task currently recording the report, as returned by
> > + * get_encoded_pid(), or -1. Used as a writer lock for report_buffer.
> > + * A regular spinlock couldn't be used here, as probe_console() can be called
> > + * from any thread, and it needs to know whether that thread is holding the
> > + * lock.
> > + */
> > +static atomic_t current_pid = ATOMIC_INIT(-1);
>
> how do you handle pid namespaces?

Doesn't current->pid hold the global PID of the task?
See the description of task_pid_nr() here:
https://elixir.bootlin.com/linux/latest/source/include/linux/sched.h#L1386,
which is supposed to return a global task ID.

> > +     if (atomic_cmpxchg_acquire(&current_pid, -1, get_encoded_pid()) != -1)
> > +             return;
>
> pid namespaces?
See above.

>
> pid namespaces?
>
Same.

> > +     int idx;
> > +
> > +     if (pid != get_encoded_pid())
> > +             return;
> > +
> > +     idx = (atomic_read(&num_reports) + 1) % 2;
>
> You read, but it could change before:

Not sure I follow. num_reports can be only incremented by the same
task that started the report, this cannot happen concurrently.


>
> > +     if (current_pos == BUF_SIZE)
> > +             report_buffer[idx][current_pos - 1] = 0;
> > +     else
> > +             report_buffer[idx][current_pos] = 0;
> > +
> > +     /* Pairs with acquire in last_report_show(). */
> > +     atomic_inc_return_release(&num_reports);
>
> Not good?

> > +static ssize_t last_report_show(struct kobject *kobj,
> > +                             struct kobj_attribute *attr, char *buf)
> > +{
> > +     ssize_t ret;
> > +     int index;
> > +
> > +     do {
> > +             /* Pairs with release in probe_report_end(). */
> > +             index = atomic_read_acquire(&num_reports);
> > +             /*
> > +              * If index and old_index mismatch, we might be accessing
> > +              * report_buffer concurrently with a writer thread. In that
> > +              * case the read data will be discarded.
> > +              */
> > +             ret = data_race(strscpy(buf, report_buffer[index % 2], BUF_SIZE));
> > +             /*
> > +              * Prevent reordering between the memcpy above and the atomic
> > +              * read below.
> > +              * See the comments in include/linux/seqlock.h for more
> > +              * details.
> > +              */
> > +             smp_rmb();
> > +     } while (index != atomic_read(&num_reports));
>
> endless loops, what could go wrong...
Fair enough, this needs to be fixed.

>
> Why are you rolling your own hacky locks in here?

We've also considered using a seqlock here, but thought that required
too much boilerplate code (the current implementation reuses the
report counter as a seqlock latch, whereas otherwise we'd need to
introduce an extra seqcount_latch_t plus call the seqlock API
functions). I think this can be reconsidered.

> And again, sysfs is "one value" not "one buffer".
>
> > +     return ret;
> > +}
> > +
> > +/*
> > + * read() handler for /sys/kernel/error_report/report_count.
> > + */
> > +static ssize_t report_count_show(struct kobject *kobj,
> > +                              struct kobj_attribute *attr, char *buf)
> > +{
> > +     return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&num_reports));
>
> sysfs_emit()?

Good, haven't seen that one. I think I just took
Documentation/filesystems/sysfs.txt as an example.

> And you just read it, but what keeps it from changing?
Nothing; we can't really guarantee nobody reported another error while
we were processing the previous one.
Similarly, we cannot be sure that any other vfs file still has the
same contents once we read it ;)


> > +static const struct attribute_group error_report_sysfs_attr_group = {
> > +     .attrs = error_report_sysfs_attrs,
> > +};
>
> ATTRIBUTE_GROUPS()?

Ack.

> > +late_initcall(error_report_notify_setup);
>
> You never clean up the kobject or files?
Will fix, thanks!

> Anyway, please move this to tracefs, that's where it belongs.
Will do in v3.
