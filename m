Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F521EA7C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFAQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:24:09 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C979C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:24:08 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y13so3350301ybj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQ2GMhzo7cmDr2bvHk1Eg4SDQqgv+z7peej1Sf2vsYE=;
        b=uPm7+NhhxHzDUqaSkN14igTBR9BwE4dUvjGjDaGJl+MO6HCxa+3Mm3VFkyyCJ/K7qy
         IPfnwiJ3Ityam2G+W0VuM6GWso8s8Pyfj24xgpSFmWC0bCb8+EHT0aG2inCv3fJ2VJCJ
         IuF0sKlLInulOSd1HXvy0rUaZxXLkDqWtwXoyHbK146pSD/Jud3GTBOot0SvZgeaGnyC
         7meWhECX1loiiMzZMg6wBxEkzjMr40tLD0XwGdS9a01QG2msavsR+B3mLyx6QPWHfMGp
         jmeQvyiOE9Ka/IH9bHw4brTFOvuD2nMncL/Cktk6ogC6aB+0TjyKzrzjogpFA/3+XnDt
         7rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQ2GMhzo7cmDr2bvHk1Eg4SDQqgv+z7peej1Sf2vsYE=;
        b=Q6Lm/7BXujMu6Pu37kJqPNwDlFFTV6lPWoKLzy4fxIBPzz4DboeiuVnia1IbrHDq1o
         rqB6rR9yHQtscOfa98qF+pb0I22XjenMrlGl5SthMVHyD/FTQsM1bDjwTmmVhlmeQsf/
         cb28qF/1PjjGpZIYNbOwXyHraiFqaIucdhj8oH30rWhKJDvg92LXV4hClN80p+5S4D8T
         xnIbx7i5DxBFwaePuJlMgwbQeZ/r0cIYoKEu5soUgGhnMdZBaUZVIQ0FpQo7kpDxWyzj
         foyK0rdn07unXyppyxodJwH2oVXDOUUxjVn3Dk2I4/yBAk/IV50BklFTLk1VucamGaqs
         hK7g==
X-Gm-Message-State: AOAM532ubXhcIELXAPIE2Ax0HEB5WrIAWnxQyOkrI/p7aK3w36NGhvss
        XZpuAS9zxdABEvIxQLdAJYht+ZGjLKTN4rcIQhvSxHwF
X-Google-Smtp-Source: ABdhPJyBN4Lc79P2ibomNOdQBcMt1WD1LcxCDheiYEG7aXgYbSVyZEN2UiyE2prTWlGUy9qPGescjrS7bWTF67Qzw+g=
X-Received: by 2002:a25:5387:: with SMTP id h129mr32591599ybb.47.1591028647233;
 Mon, 01 Jun 2020 09:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224219.234847-1-jolsa@kernel.org> <20200524224219.234847-7-jolsa@kernel.org>
 <CAP-5=fV5tKwyMCpwt2VFkSFwCCk6qJ3S2_ajNy2P6ZWVxvbC-w@mail.gmail.com> <20200601132147.GB1031432@krava>
In-Reply-To: <20200601132147.GB1031432@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 09:23:56 -0700
Message-ID: <CAP-5=fXyqCZUHxn_0OpjDCb+JqoCyEFfJnPNXwYd+jvGshwOrw@mail.gmail.com>
Subject: Re: [PATCH 06/14] perf tests: Add another pmu-events tests
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 6:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jun 01, 2020 at 12:44:15AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > > +       memset(&error, 0, sizeof(error));
> > > +       ret = parse_events_fake(evlist, id, &error);
> > > +       if (ret) {
> > > +               pr_debug("str        : %s\n", error.str);
> > > +               pr_debug("help       : %s\n", error.help);
> > > +               pr_debug("first_str  : %s\n", error.first_str);
> > > +               pr_debug("first_help : %s\n", error.first_help);
> > > +       }
> > > +
> > > +       evlist__delete(evlist);
> > > +       free(error.str);
> > > +       free(error.help);
> > > +       free(error.first_str);
> > > +       free(error.first_help);
> > > +       return ret;
> > > +}
> >
> > This is quite similar to check_parse_id, fold them together?
>
> there is the 'same_cpu' logic in check_parse_id,
> so I did not want to mess with that

Agreed. We could handle ret and same_cpu in the caller.

> >
> > > +
> > > +static int metric_parse_fake(const char *str)
> > > +{
> > > +       struct expr_parse_ctx ctx;
> > > +       struct hashmap_entry *cur;
> > > +       double result;
> > > +       int ret = -1;
> > > +       size_t bkt;
> > > +       int i;
> > > +
> > > +       pr_debug("parsing '%s'\n", str);
> > > +
> > > +       expr__ctx_init(&ctx);
> > > +       if (expr__find_other(str, NULL, &ctx, 0) < 0) {
> > > +               pr_err("expr__find_other failed\n");
> > > +               return -1;
> > > +       }
> > > +
> > > +       i = 1;
> > > +       hashmap__for_each_entry((&ctx.ids), cur, bkt)
> > > +               expr__add_id(&ctx, strdup(cur->key), i++);
> >
> > It might make sense to share the code here with that in test_parsing.
> > This initialization of ids is commented there and it is a bit special.
>
> hum, not sure it's worth to add this complexity to test, I'd like
> to keep it simple, it's already not straightforward ;-) I added the
> comment you mentioned

Ok, sounds good to me. More testing is the priority :-)

Thanks,
Ian

> jirka
>
