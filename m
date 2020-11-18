Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1492B7A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKRJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKRJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605690693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IenbdPhxUN8brxJqNOuUgnVQ/injsj1TCtnNbMXKNLU=;
        b=Tq1Kp3mnEJoe6yIMtzJZdh+rEHlD8fLWnGtdI5esCmqin6Ac+uPyAJtfCbw/lhRgMDgxw5
        lAqwQVQ++SCiYRnVOMroFSIvQrh3LQ7toP1x7Wm16bx3v1hvQxQ0OCMo3ZE5GHG1WPVboN
        H7iTBFpdhzBS6v73kb6LCnryboUQuq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-MBEwqdxHOB-E55Prs2kafA-1; Wed, 18 Nov 2020 04:11:31 -0500
X-MC-Unique: MBEwqdxHOB-E55Prs2kafA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374E1D8EC1;
        Wed, 18 Nov 2020 09:11:29 +0000 (UTC)
Received: from krava (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with SMTP id E0DB2196FD;
        Wed, 18 Nov 2020 09:11:25 +0000 (UTC)
Date:   Wed, 18 Nov 2020 10:11:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 09/24] perf tools: Add check for existing link in buildid
 dir
Message-ID: <20201118091124.GA1414446@krava>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-10-jolsa@kernel.org>
 <CAP-5=fVc9i2EXPEqzOEHt5xrxqXiR_58KettKqrR9GJdic4sOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVc9i2EXPEqzOEHt5xrxqXiR_58KettKqrR9GJdic4sOQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 01:23:09PM -0800, Ian Rogers wrote:
> On Tue, Nov 17, 2020 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > When adding new build id link we fail if the link is already
> > there. Adding check for existing link and output debug message
> > that the build id is already linked.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/build-id.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 7d9ecc37849c..ef9a31b54ba2 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -754,8 +754,21 @@ int build_id_cache__add_s(const char *sbuild_id,
> > const char *name,
> >         tmp = dir_name + strlen(buildid_dir) - 5;
> >         memcpy(tmp, "../..", 5);
> >
> > -       if (symlink(tmp, linkname) == 0)
> > +       if (symlink(tmp, linkname) == 0) {
> >                 err = 0;
> > +       } else if (errno == EEXIST) {
> > +               char path[PATH_MAX];
> > +
> > +               if (readlink(linkname, path, sizeof(path)) == -1) {
> > +                       pr_err("Cant read link: %s\n", linkname);
> > +                       goto out_free;
> > +               }
> >
> 
> readlink needs null termination, such as:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/build-id.c?h=perf/core#n212

will fix, thanks

jirka

> 
> Thanks,
> Ian
> 
> +               if (strcmp(tmp, path)) {
> > +                       pr_debug("build <%s> already linked to %s\n",
> > +                                sbuild_id, linkname);
> > +               }
> > +               err = 0;
> > +       }
> >
> >         /* Update SDT cache : error is just warned */
> >         if (realname &&
> > --
> > 2.26.2
> >
> >

