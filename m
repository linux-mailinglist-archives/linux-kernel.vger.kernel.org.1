Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3D26B0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgIOQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727331AbgIOPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600184262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EmGrGH1ln4DKY4ewYIRXTs91iln6HTRv+ClUeKFLEss=;
        b=b2QyoeG941G7Eg8JiZC4HkN2SXgP0/AGpS6HniXwDIxyEhmplLk9howtB/Sj5Fy6h3IkVL
        e8xN39LKC3r1st87lASNj3+6nYOBjOB4B5Avy7OHPtLulrNWIMgVGMdCSIeqI30VXgdgbd
        46Br+UvJmnMI380Pca/OXu/f8BQfYIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-R4v6z8tHOkSyi745y3kBZg-1; Tue, 15 Sep 2020 11:35:26 -0400
X-MC-Unique: R4v6z8tHOkSyi745y3kBZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ECD31868410;
        Tue, 15 Sep 2020 15:35:25 +0000 (UTC)
Received: from Diego (unknown [10.40.208.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DA9F75138;
        Tue, 15 Sep 2020 15:35:22 +0000 (UTC)
Date:   Tue, 15 Sep 2020 17:35:20 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Jiri Olsa <jolsa@redhat.com>
cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCH] perf: Fix race in perf_mmap_close function
In-Reply-To: <20200914205936.GD1714160@krava>
Message-ID: <alpine.LRH.2.20.2009151734230.12057@Diego>
References: <20200910104153.1672460-1-jolsa@kernel.org> <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com> <20200910144744.GA1663813@krava> <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com> <20200911074931.GA1714160@krava>
 <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com> <20200914205936.GD1714160@krava>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020, Jiri Olsa wrote:
> On Mon, Sep 14, 2020 at 09:48:43PM +0900, Namhyung Kim wrote:
> > On Fri, Sep 11, 2020 at 4:49 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > ugh, that's right.. how about change below
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> thanks, I'll send full patch after we're done testing this
> 
> jirka

I've tested the change and seems OK to me.

Tested-by: Michael Petlan <mpetlan@redhat.com>

> 
> > 
> > Thanks
> > Namhyung
> > 
> > 
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 7ed5248f0445..8ab2400aef55 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -5868,11 +5868,11 @@ static void perf_pmu_output_stop(struct perf_event *event);
> > >  static void perf_mmap_close(struct vm_area_struct *vma)
> > >  {
> > >         struct perf_event *event = vma->vm_file->private_data;
> > > -
> > >         struct perf_buffer *rb = ring_buffer_get(event);
> > >         struct user_struct *mmap_user = rb->mmap_user;
> > >         int mmap_locked = rb->mmap_locked;
> > >         unsigned long size = perf_data_size(rb);
> > > +       bool detach_rest = false;
> > >
> > >         if (event->pmu->event_unmapped)
> > >                 event->pmu->event_unmapped(event, vma->vm_mm);
> > > @@ -5903,7 +5903,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> > >                 mutex_unlock(&event->mmap_mutex);
> > >         }
> > >
> > > -       atomic_dec(&rb->mmap_count);
> > > +       if (atomic_dec_and_test(&rb->mmap_count))
> > > +               detach_rest = true;
> > >
> > >         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > >                 goto out_put;
> > > @@ -5912,7 +5913,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> > >         mutex_unlock(&event->mmap_mutex);
> > >
> > >         /* If there's still other mmap()s of this buffer, we're done. */
> > > -       if (atomic_read(&rb->mmap_count))
> > > +       if (!detach_rest)
> > >                 goto out_put;
> > >
> > >         /*
> > >
> > 
> 

