Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC0277443
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgIXOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIXOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:46:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79145C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:46:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so2045849pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngNYMfezr0dWUzkw58Hh3Wb5jo5nLokmWQKPqodIyrU=;
        b=XHqTFZgiCk29xr8xwegNKhHxCVmADiUEzEDgPL2bXRIzQjxD8inoCxpnNs1BMx3VVR
         Jyp2t/KCc4XFYldQV+hJUfHSrqdF2GBSHP0X3CvQg5cwu2YxFPR61WqwOGJr0cFT4P8P
         QHEmaQWiHBOeyDGO4Czl5Dvd1jqk+bAQ5+gR5d/QvxeTm6xFxnkmtlc+6ut6D5UY62f8
         lg/trXDGrv3FVmXe08JRyZP4S0lZNaSQKoMz+Rhy9a0yZeYqmgg49KTSoOP61PTrkfXa
         xhxUVoVWdBwfUp0w7Pgmi+TRelyKrtasUL7rojrHC3sQzbQOFiJyHeUb4u/fIlExz9cR
         xeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ngNYMfezr0dWUzkw58Hh3Wb5jo5nLokmWQKPqodIyrU=;
        b=Om1q0BFjsV+M2y5OSCPbYbVD23gdz/3V1r1N1JyWyHl4wacjQgrdS16J3kGyTPGDx7
         jrorTbKVqoduwrYFUAgjFo1RjJ6sgmFsszNK18vmZuxh3K6xu9tt1je+apgmklQNF7lD
         kkwRtYrzBUWTLFAYCIE8YmyUUGbVEFHNeb2V2IsYvteGlHFzQd5gVBTz1X0O6vr4QZu2
         InSFQetDvmlenwMl/j/SM4d2EGG5zCDMcxQ+QSyrkUDEbCl2oP5TKV0iZiLaGtQ4cNR3
         41+JKzcRpgK9WSISkDaQT4+cXUmVNl+gQEUeIgH6kBZFQXyhhdAc7IBIPwJu+iXxxfQn
         oY6g==
X-Gm-Message-State: AOAM532k+g2VwnF56hYrlPZRmmqIUPzfb/BdxUleeNY8nEASkdmicZxi
        nbzKEDZJLv3L1YTFHDaqH48=
X-Google-Smtp-Source: ABdhPJz92OnjYH0+E1BO0+DQejxlZgiaUp5sZAuDQC0esaMCiXlNmv+PkK2ECwK18owxmsZ/WydqOA==
X-Received: by 2002:a62:1d51:0:b029:13e:d13d:a0fc with SMTP id d78-20020a621d510000b029013ed13da0fcmr5137625pfd.24.1600958798980;
        Thu, 24 Sep 2020 07:46:38 -0700 (PDT)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id w206sm3300661pfc.1.2020.09.24.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:46:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 24 Sep 2020 23:46:32 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20200924144632.GA357981@google.com>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-5-namhyung@kernel.org>
 <20200924130909.GB3150401@krava>
 <CAM9d7ciWQa8rC91nOiak1ephg-+SfFXVkFLtU4H4Snaw2i_pWA@mail.gmail.com>
 <20200924134444.GE3150401@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924134444.GE3150401@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:44:44PM +0200, Jiri Olsa wrote:
> On Thu, Sep 24, 2020 at 10:20:51PM +0900, Namhyung Kim wrote:
> > On Thu, Sep 24, 2020 at 10:09 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Sep 23, 2020 at 05:05:34PM +0900, Namhyung Kim wrote:
> > >
> > > SNIP
> > >
> > > > -static inline int is_no_dso_memory(const char *filename)
> > > > -{
> > > > -     return !strncmp(filename, "[stack", 6) ||
> > > > -            !strncmp(filename, "/SYSV",5)   ||
> > > > -            !strcmp(filename, "[heap]");
> > > > -}
> > > > -
> > > >  static inline int is_android_lib(const char *filename)
> > > >  {
> > > >       return strstarts(filename, "/data/app-lib/") ||
> > > > @@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > > >               int anon, no_dso, vdso, android;
> > > >
> > > >               android = is_android_lib(filename);
> > > > -             anon = is_anon_memory(filename, flags);
> > > > +             anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
> > >
> > > what's the reason to take 'flags & MAP_HUGETLB' out of is_anon_memory?
> > 
> > The MAP_HUGETLB is defined in uapi/linux/mman.h and I had trouble
> > when including the header in the map.h file.
> 
> could you share the error? it might be corner case, but it
> could bite us in future

Sure.

  CC       util/session.o
In file included from /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman-common-tools.h:5,
                 from /home/namhyung/project/linux/tools/include/uapi/asm-generic/mman.h:5,
                 from /home/namhyung/project/linux/tools/arch/x86/include/uapi/asm/mman.h:5,
                 from /home/namhyung/project/linux/tools/include/uapi/linux/mman.h:5,
                 from util/map.h:13,
                 from util/session.c:21:
/home/namhyung/project/linux/tools/include/uapi/asm-generic/mman-common.h:26: error: "MAP_POPULATE" redefined [-Werror]
   26 | #define MAP_POPULATE  0x008000 /* populate (prefault) pagetables */
      | 
In file included from /usr/include/x86_64-linux-gnu/bits/mman.h:31,
                 from /usr/include/x86_64-linux-gnu/sys/mman.h:41,
                 from util/session.c:12:
/usr/include/x86_64-linux-gnu/bits/mman-map-flags-generic.h:34: note: this is the location of the previous definition
   34 | # define MAP_POPULATE 0x08000  /* Populate (prefault) pagetables.  */
      | 

This is repeated for each macro definitions..


> 
> also flags are stored just in map not dso so you'd need to
> add that as arg to dso__inject_build_id

Will do.

Thanks
Namhyung
