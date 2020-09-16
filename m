Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8201026CD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIPU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbgIPQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L+TNH3xQjUTmzDd20XHvgOV5iRw7fxpPAv4mwBAvE/w=;
        b=Vey0iO5V5M+dSKFHnuaeEI7PkAqYPLVBFJ67Nw3blZC+zl/9fDO2SfkyznvKP4BygFG6Ff
        t94GfOigpfH/cV6qW+R/eksNGTWvLD7oIUo5jbVbYrtw86cVxeSG2GehhdhLAxb6gS4t7s
        gMx7wbIcKrAu3z/oxeXjNSSm5i2auDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-DUiY4zD9OliHxp7z-SwUHg-1; Wed, 16 Sep 2020 10:38:24 -0400
X-MC-Unique: DUiY4zD9OliHxp7z-SwUHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ADA464085;
        Wed, 16 Sep 2020 14:38:22 +0000 (UTC)
Received: from krava (ovpn-114-172.ams2.redhat.com [10.36.114.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id CFEA019D6C;
        Wed, 16 Sep 2020 14:38:20 +0000 (UTC)
Date:   Wed, 16 Sep 2020 16:38:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     peterz@infradead.org
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCHv2] perf: Fix race in perf_mmap_close function
Message-ID: <20200916143819.GF2301783@krava>
References: <20200910104153.1672460-1-jolsa@kernel.org>
 <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava>
 <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
 <20200911074931.GA1714160@krava>
 <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com>
 <20200914205936.GD1714160@krava>
 <alpine.LRH.2.20.2009151734230.12057@Diego>
 <20200916115311.GE2301783@krava>
 <20200916135402.GZ1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916135402.GZ1362448@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 03:54:02PM +0200, peterz@infradead.org wrote:
> On Wed, Sep 16, 2020 at 01:53:11PM +0200, Jiri Olsa wrote:
> > There's a possible race in perf_mmap_close when checking ring buffer's
> > mmap_count refcount value. The problem is that the mmap_count check is
> > not atomic because we call atomic_dec and atomic_read separately.
> > 
> >   perf_mmap_close:
> >   ...
> >    atomic_dec(&rb->mmap_count);
> >    ...
> >    if (atomic_read(&rb->mmap_count))
> >       goto out_put;
> > 
> >    <ring buffer detach>
> >    free_uid
> > 
> > out_put:
> >   ring_buffer_put(rb); /* could be last */
> > 
> > The race can happen when we have two (or more) events sharing same ring
> > buffer and they go through atomic_dec and then they both see 0 as refcount
> > value later in atomic_read. Then both will go on and execute code which
> > is meant to be run just once.
> > 
> > The code that detaches ring buffer is probably fine to be executed more
> > than once, but the problem is in calling free_uid, which will later on
> > demonstrate in related crashes and refcount warnings, like:
> > 
> >   refcount_t: addition on 0; use-after-free.
> >   ...
> >   RIP: 0010:refcount_warn_saturate+0x6d/0xf
> >   ...
> >   Call Trace:
> >   prepare_creds+0x190/0x1e0
> >   copy_creds+0x35/0x172
> >   copy_process+0x471/0x1a80
> >   _do_fork+0x83/0x3a0
> >   __do_sys_wait4+0x83/0x90
> >   __do_sys_clone+0x85/0xa0
> >   do_syscall_64+0x5b/0x1e0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Using atomic decrease and check instead of separated calls.
> > This fixes CVE-2020-14351.
> 
> I'm tempted to remove that line; I can never seem to find anything
> useful in a CVE.

I was asked by security guys to add this, Wade?

> 
> Fixes: ?

right, sry..

Fixes: 9bb5d40cd93c ("perf: Fix mmap() accounting hole");

thanks,
jirka

> 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Tested-by: Michael Petlan <mpetlan@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 

