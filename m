Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361FF2C421B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgKYOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgKYOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606314024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0PKokaRjxl3g7l8kSplbVrpgcKfDdttOM5D9FUH08w=;
        b=K/k+N7NJjMlgYMjs6LmxFr8LitlHTJwq5UkQwNb80YYxsXmcD9EGPKgeu0TsdmGY4kvrTl
        7Ag/YJm6Ijs0zrD1aJ9xDrzqh/0Baf6J2YpekI5hsmwu2xOuIuxqkx1Oxc+kpT5SAQWQUz
        i3BDGzIVuacj0EEMX4ev52yf1rqG6GQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-6SsgcZ6TNDKZ0K_RoEfAwg-1; Wed, 25 Nov 2020 09:20:20 -0500
X-MC-Unique: 6SsgcZ6TNDKZ0K_RoEfAwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FED8100B736;
        Wed, 25 Nov 2020 14:20:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C0B69CA0;
        Wed, 25 Nov 2020 14:20:14 +0000 (UTC)
Date:   Wed, 25 Nov 2020 15:20:14 +0100
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 22/25] perf buildid-cache: Add support to add build ids
 from perf data
Message-ID: <20201125142014.GF2164284@krava>
References: <20201123230512.2097312-1-jolsa@kernel.org>
 <20201123230512.2097312-23-jolsa@kernel.org>
 <CAM9d7ciNd7FuscyB1x884uQKVXyRexQD60fTei3AUP3RLN_BaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciNd7FuscyB1x884uQKVXyRexQD60fTei3AUP3RLN_BaA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:29:11PM +0900, Namhyung Kim wrote:

SNIP

> > +#ifdef HAVE_DEBUGINFOD_SUPPORT
> > +static int call_debuginfod(const char *sbuild_id, char **path, bool debuginfo)
> > +{
> > +       debuginfod_client *c;
> > +       int fd;
> > +
> > +       c = debuginfod_begin();
> > +       if (c == NULL)
> > +               return -1;
> > +
> > +       pr_debug("trying debuginfod for executable <%s> ... ", sbuild_id);
> > +
> > +       if (debuginfo) {
> > +               fd = debuginfod_find_debuginfo(c, (const unsigned char *) sbuild_id,
> > +                                              0, path);
> > +       } else {
> > +               fd = debuginfod_find_executable(c, (const unsigned char *) sbuild_id,
> > +                                               0, path);
> > +       }
> > +       if (fd >= 0)
> > +               close(fd); /* retaining reference by realname */
> > +
> > +       debuginfod_end(c);
> > +       pr_debug("%s%s\n", *path ? "OK " : "FAILED", *path ? *path : "");
> > +       return *path ? 0 : -1;
> > +}
> > +#else
> > +static int call_debuginfod(const char *sbuild_id __maybe_unused,
> > +                          char **path __maybe_unused,
> > +                          bool debuginfo __maybe_unused)
> > +{
> > +       return -1;
> > +}
> > +#endif
> > +
> > +struct dso_store_data {
> > +       bool     hits;
> > +       bool     force_download;
> 
> Where is it set?

it's not, I wanted to add it, but then never needed it,
so it stayed without an option.. I'll remove it

thanks,
jirka

