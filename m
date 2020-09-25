Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260A6278AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgIYO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgIYO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:26:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601043989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPiMcScZ5bPLI1dO+pFhF7pjVz9qlxXsZQT6qKA47Yw=;
        b=RtFNCCGQf8/YrvV1/Jt6bfhw/s7uYZeK2AsPByZqUHfofqAQRol6DbC5Uu0iqwlRyi/zkI
        zr56B2KP55b1nBfcd6nlDf2i2BYFBWVeolzsxvdrLG9nhe2PruH/W9+zp2ziCmy3ujWtm6
        hRdNHQwQEb7MlNy6QnBqMhCPv1GRGkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-IYq3JDeWMvWR2s4LUprfIQ-1; Fri, 25 Sep 2020 10:26:24 -0400
X-MC-Unique: IYq3JDeWMvWR2s4LUprfIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 722AD10A7AEA;
        Fri, 25 Sep 2020 14:26:22 +0000 (UTC)
Received: from krava (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3060B5C1BB;
        Fri, 25 Sep 2020 14:26:20 +0000 (UTC)
Date:   Fri, 25 Sep 2020 16:26:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 4/7] perf inject: Do not load map/dso when injecting
 build-id
Message-ID: <20200925142619.GD3273770@krava>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-5-namhyung@kernel.org>
 <20200924130909.GB3150401@krava>
 <CAM9d7ciWQa8rC91nOiak1ephg-+SfFXVkFLtU4H4Snaw2i_pWA@mail.gmail.com>
 <20200924134444.GE3150401@krava>
 <20200924144632.GA357981@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924144632.GA357981@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:46:32PM +0900, Namhyung Kim wrote:
> On Thu, Sep 24, 2020 at 03:44:44PM +0200, Jiri Olsa wrote:
> > On Thu, Sep 24, 2020 at 10:20:51PM +0900, Namhyung Kim wrote:
> > > On Thu, Sep 24, 2020 at 10:09 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 23, 2020 at 05:05:34PM +0900, Namhyung Kim wrote:
> > > >
> > > > SNIP
> > > >
> > > > > -static inline int is_no_dso_memory(const char *filename)
> > > > > -{
> > > > > -     return !strncmp(filename, "[stack", 6) ||
> > > > > -            !strncmp(filename, "/SYSV",5)   ||
> > > > > -            !strcmp(filename, "[heap]");
> > > > > -}
> > > > > -
> > > > >  static inline int is_android_lib(const char *filename)
> > > > >  {
> > > > >       return strstarts(filename, "/data/app-lib/") ||
> > > > > @@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > > > >               int anon, no_dso, vdso, android;
> > > > >
> > > > >               android = is_android_lib(filename);
> > > > > -             anon = is_anon_memory(filename, flags);
> > > > > +             anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
> > > >
> > > > what's the reason to take 'flags & MAP_HUGETLB' out of is_anon_memory?
> > > 
> > > The MAP_HUGETLB is defined in uapi/linux/mman.h and I had trouble
> > > when including the header in the map.h file.
> > 
> > could you share the error? it might be corner case, but it
> > could bite us in future
> 
> Sure.
> 
>   CC       util/session.o
> In file included from /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman-common-tools.h:5,
>                  from /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman.h:5,
>                  from /home/namhyung/project/linux/tools/arch/x86/include/uapi/asm/mman.h:5,
>                  from /home/namhyung/project/linux/tools/include/uapi/linux/mman.h:5,
>                  from util/map.h:13,
>                  from util/session.c:21:
> /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman-common.h:26: error: "MAP_POPULATE" redefined [-Werror]
>    26 | #define MAP_POPULATE  0x008000 /* populate (prefault) pagetables */
>       | 
> In file included from /usr/include/x86_64-linux-gnu/bits/mman.h:31,
>                  from /usr/include/x86_64-linux-gnu/sys/mman.h:41,
>                  from util/session.c:12:
> /usr/include/x86_64-linux-gnu/bits/mman-map-flags-generic.h:34: note: this is the location of the previous definition
>    34 | # define MAP_POPULATE 0x08000  /* Populate (prefault) pagetables.  */
>       | 
> 
> This is repeated for each macro definitions..

hm, some black magic happened in the past and it looks like now we
can't have <sys/mman.h> and <linux/mman.h> includes together

it looks related to this commit:
  be709d48329a tools headers uapi: Sync asm-generic/mman-common.h and linux/mman.h

I'm not sure I understand the purpose of asm-generic/mman-common-tools.h file

Arnaldo,
any chance you might have some quick solution before I dive in?
you can reproduce the issue with change below

thanks,
jirka


---
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index b1c0686db1b7..a0b0281d8eab 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include <sys/mman.h>

