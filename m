Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E902696DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgINUnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:43:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbgINUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600116185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSo7z5EhrZIrn1Cf9pd30WNNDxr/GZahZc5xQPbEOOY=;
        b=Rq7UfjlSzSOGsBl0EOG4a2VfJsZozEDmziH5x5PAXxzxKt6yj9mSbYf/B9SrQr2LagJ5z+
        mfM4DjXn68qc2VIcqiN9kQGoUQSEAX0Cytx0UyP5S43pog91GP8w7GBK5P9ooKDpogbFAN
        7S8wOlzrFCYHYmzZ3UcqtZ3/G/OoxR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-4h2zvrPkPgS103df3V-SRA-1; Mon, 14 Sep 2020 16:43:02 -0400
X-MC-Unique: 4h2zvrPkPgS103df3V-SRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F05131005E67;
        Mon, 14 Sep 2020 20:42:59 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5DD341A914;
        Mon, 14 Sep 2020 20:42:56 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:42:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/26] perf tools: Add buildid-list --store option
Message-ID: <20200914204255.GX1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-25-jolsa@kernel.org>
 <CAM9d7ch5Od3Pz6GORmkW6RfUQL6ON0DVJ+dndA9mGCv6ppLsbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch5Od3Pz6GORmkW6RfUQL6ON0DVJ+dndA9mGCv6ppLsbA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:42:55PM +0900, Namhyung Kim wrote:
> On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding buildid-list --store option to populate
> > .debug data with build id files.
> 
> Hmm.. isn't it better to add it to the buildid-cache command?
> > +        *   - store binary to build id database
> > +        */
> > +       is_kallsyms = !strcmp(machine->mmap_name, dso->short_name);
> > +       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> > +
> > +       if (is_kallsyms) {
> > +               /*
> > +                * Find out if we are on the same kernel as perf.data
> > +                * and keel kallsyms in that case.
> > +                */
> > +               path = strdup(dso->long_name);
> > +               if (!path)
> > +                       goto out_err;
> > +
> > +               err = sysfs__read_build_id("/sys/kernel/notes", &bid, sizeof(bid));
> > +               if (err < 0)
> > +                       goto out_err;
> > +       } else {
> > +               struct stat st;
> > +
> > +               /*
> > +                * Does the file exists in the first place, if it does,
> > +                * resolve path and read the build id.
> > +                */
> > +               if (stat(dso->long_name, &st)) {
> > +                       zfree(&path);
> > +                       goto try_download;
> > +               }
> > +
> > +               path = nsinfo__realpath(dso->long_name, dso->nsinfo);
> > +               if (!path)
> > +                       goto out_err;
> > +
> > +               err = filename__read_build_id(path, &bid, sizeof(bid));
> 
> Is it ok to read the file out of the namespace?

right, I need to enclose the whole part into nsinfo__mountns_* 

thanks,
jirka

