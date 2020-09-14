Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5521826973E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgINU7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:59:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57076 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgINU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600117186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RZxO9Godwl44d6wJihHpSIBg4OppaEy3+dFcmyNT/E=;
        b=Qd4zgB8Yg4yGq0toow6aSebnhqEnEIyu/h9P1JjmgVW5SyXHEWrXSD+rhnoe0VChUXPilP
        xIw11DGMKnl5GlMgva8dc9kaoI7xOcZ3u63QL6/57cbB2yh096UrBvTIoRAruDgd8uXuCg
        Tyxsmj9ZnZZ6XQmtVjFGEuFAhqvvjtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-g4njyc2UMpqR8fw3gIrB6w-1; Mon, 14 Sep 2020 16:59:45 -0400
X-MC-Unique: g4njyc2UMpqR8fw3gIrB6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99714800479;
        Mon, 14 Sep 2020 20:59:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91A8A75142;
        Mon, 14 Sep 2020 20:59:37 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:59:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCH] perf: Fix race in perf_mmap_close function
Message-ID: <20200914205936.GD1714160@krava>
References: <20200910104153.1672460-1-jolsa@kernel.org>
 <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava>
 <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
 <20200911074931.GA1714160@krava>
 <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:48:43PM +0900, Namhyung Kim wrote:
> On Fri, Sep 11, 2020 at 4:49 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > ugh, that's right.. how about change below
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

thanks, I'll send full patch after we're done testing this

jirka

> 
> Thanks
> Namhyung
> 
> 
> >
> > jirka
> >
> >
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 7ed5248f0445..8ab2400aef55 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5868,11 +5868,11 @@ static void perf_pmu_output_stop(struct perf_event *event);
> >  static void perf_mmap_close(struct vm_area_struct *vma)
> >  {
> >         struct perf_event *event = vma->vm_file->private_data;
> > -
> >         struct perf_buffer *rb = ring_buffer_get(event);
> >         struct user_struct *mmap_user = rb->mmap_user;
> >         int mmap_locked = rb->mmap_locked;
> >         unsigned long size = perf_data_size(rb);
> > +       bool detach_rest = false;
> >
> >         if (event->pmu->event_unmapped)
> >                 event->pmu->event_unmapped(event, vma->vm_mm);
> > @@ -5903,7 +5903,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> >                 mutex_unlock(&event->mmap_mutex);
> >         }
> >
> > -       atomic_dec(&rb->mmap_count);
> > +       if (atomic_dec_and_test(&rb->mmap_count))
> > +               detach_rest = true;
> >
> >         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> >                 goto out_put;
> > @@ -5912,7 +5913,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> >         mutex_unlock(&event->mmap_mutex);
> >
> >         /* If there's still other mmap()s of this buffer, we're done. */
> > -       if (atomic_read(&rb->mmap_count))
> > +       if (!detach_rest)
> >                 goto out_put;
> >
> >         /*
> >
> 

