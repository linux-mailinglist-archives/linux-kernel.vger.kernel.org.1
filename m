Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885BC28E41D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgJNQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgJNQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602692067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2+tO8n9caog/FruyMrtLh2dw8tMRwQ5o/G97PclUnM=;
        b=TfHxtzoAVPKGsr6D6YVoJamEcD+Z6CJWzltWQ07gJDfQr36xtyQeY+0ZM7KGvQy2wlR7fb
        RSOevt5IQq013UUOC/RWAJt6l3sZo9c2RnMUTK3hpp/2vnx4jDSdnZRI/m12/uGsEnrOqD
        YAOI/hlHSb3kVVHPBSshyxGT7IprMPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-LABtxtKLNB-xnV_GPoTiug-1; Wed, 14 Oct 2020 12:14:23 -0400
X-MC-Unique: LABtxtKLNB-xnV_GPoTiug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1EF18C89C5;
        Wed, 14 Oct 2020 16:14:21 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC54760C15;
        Wed, 14 Oct 2020 16:14:18 +0000 (UTC)
Date:   Wed, 14 Oct 2020 18:14:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peng Fan <fanpeng@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf bench: Use condition variables in numa.
Message-ID: <20201014161418.GE1395746@krava>
References: <20201012161611.366482-1-irogers@google.com>
 <20201014114500.GB1375972@krava>
 <CAP-5=fWTvVU+M9P8wrsXXbhQ+uZNtgxpjnJt7YHfvPdw9==uuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWTvVU+M9P8wrsXXbhQ+uZNtgxpjnJt7YHfvPdw9==uuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:39:51AM -0700, Ian Rogers wrote:
> On Wed, Oct 14, 2020 at 4:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Oct 12, 2020 at 09:16:11AM -0700, Ian Rogers wrote:
> >
> > SNIP
> >
> > > @@ -483,6 +484,18 @@ static void init_global_mutex(pthread_mutex_t *mutex)
> > >       pthread_mutex_init(mutex, &attr);
> > >  }
> > >
> > > +/*
> > > + * Return a process-shared (global) condition variable:
> > > + */
> > > +static void init_global_cond(pthread_cond_t *cond)
> > > +{
> > > +     pthread_condattr_t attr;
> > > +
> > > +     pthread_condattr_init(&attr);
> > > +     pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> > > +     pthread_cond_init(cond, &attr);
> > > +}
> > > +
> > >  static int parse_cpu_list(const char *arg)
> > >  {
> > >       p0.cpu_list_str = strdup(arg);
> > > @@ -1136,15 +1149,18 @@ static void *worker_thread(void *__tdata)
> > >       if (g->p.serialize_startup) {
> > >               pthread_mutex_lock(&g->startup_mutex);
> > >               g->nr_tasks_started++;
> > > +             /* The last thread wakes the main process. */
> > > +             if (g->nr_tasks_started == g->p.nr_tasks)
> > > +                     pthread_cond_signal(&g->startup_cond);
> >
> > should you remove the condition? it's not necessary
> > and making this racy, no?
> >
> > just single pthread_cond_signal should be enough,
> > because the wait code is checking the number of tasks
> 
> The pthread_mutex_lock avoids any race on g->nr_tasks_started and
> g->p.nr_tasks is set up in init() along with all the global state. I
> don't think there's any race on g->nr_tasks_started and doing a signal
> for every thread starting will just cause unnecessary wake-ups for the
> main thread. I think it is better to keep it. I added loops on all the
> pthread_cond_waits so the code is robust against spurious wake ups.

ah, I missed that mutex call

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

