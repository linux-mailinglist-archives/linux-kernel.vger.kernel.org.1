Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E716D2772E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIXNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbgIXNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600955095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27446e+K+cr5KXjMi9KcED5GFZ6PYwOVQZ7fecG472Y=;
        b=Mr3R4FU/Xhi8FBOtTlQhU2swCJDQKFfFMA/BdkV8xVAGr1Ph5qJNruedKeUqyXL6dBMhkp
        uGMZc+SyCD5FwA7UJB8d1LUfpu/FINiXPV4I/30pM9evDbPhIzPjfiCqL2LOz0jXQ9aTLV
        8tA24ceXUfo4RJL+sUhwRk7U14K5p6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-IA0Vi_uZMz20aNXLA5nJeg-1; Thu, 24 Sep 2020 09:44:51 -0400
X-MC-Unique: IA0Vi_uZMz20aNXLA5nJeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0773164158;
        Thu, 24 Sep 2020 13:44:48 +0000 (UTC)
Received: from krava (ovpn-115-138.ams2.redhat.com [10.36.115.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1DEE60BF3;
        Thu, 24 Sep 2020 13:44:45 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:44:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 4/7] perf inject: Do not load map/dso when injecting
 build-id
Message-ID: <20200924134444.GE3150401@krava>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-5-namhyung@kernel.org>
 <20200924130909.GB3150401@krava>
 <CAM9d7ciWQa8rC91nOiak1ephg-+SfFXVkFLtU4H4Snaw2i_pWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciWQa8rC91nOiak1ephg-+SfFXVkFLtU4H4Snaw2i_pWA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:20:51PM +0900, Namhyung Kim wrote:
> On Thu, Sep 24, 2020 at 10:09 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 05:05:34PM +0900, Namhyung Kim wrote:
> >
> > SNIP
> >
> > > -static inline int is_no_dso_memory(const char *filename)
> > > -{
> > > -     return !strncmp(filename, "[stack", 6) ||
> > > -            !strncmp(filename, "/SYSV",5)   ||
> > > -            !strcmp(filename, "[heap]");
> > > -}
> > > -
> > >  static inline int is_android_lib(const char *filename)
> > >  {
> > >       return strstarts(filename, "/data/app-lib/") ||
> > > @@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > >               int anon, no_dso, vdso, android;
> > >
> > >               android = is_android_lib(filename);
> > > -             anon = is_anon_memory(filename, flags);
> > > +             anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
> >
> > what's the reason to take 'flags & MAP_HUGETLB' out of is_anon_memory?
> 
> The MAP_HUGETLB is defined in uapi/linux/mman.h and I had trouble
> when including the header in the map.h file.

could you share the error? it might be corner case, but it
could bite us in future

also flags are stored just in map not dso so you'd need to
add that as arg to dso__inject_build_id

thanks,
jirka

> 
> Thanks
> Namhyung
> 

