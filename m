Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709AA1EC3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 22:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFBUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:30:58 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B744CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:30:58 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id j8so7688427ybj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dG2W30ikv7IrUlDO3uoRpNzwGtub0ifXIazr40I7HqQ=;
        b=sDdwGkN1aw+rFG87Zy/vBPI61YaYEMyJpvOrSu4Wod1Q79GO3E5FqvelR+/3Ud8IyU
         y2QEE9JQ8Pacn4MKRA7VRnmAAurkthXh5tLyRsqFIQSCfuVK0VWJZJb0MSF4v5XaA//8
         gpIvEuyGePst/EVnG9jXgQluwhXZ8Ik/Vz7s7sKXR3Qc/IZHFyzkT9j77InsukBy5eC8
         hsUsUjRG2hUBl4btt8uFZr+gCB2PO2Ilf5UUjNobN4xFu46HmtEfXzzNMDX+CSHFY6oR
         b1vh/Iacn4Xnb/BwSlFDZokXltbO9xRhG9j371UfY0/bVcshkR+q6oOLfbp+07UGqHGt
         J7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dG2W30ikv7IrUlDO3uoRpNzwGtub0ifXIazr40I7HqQ=;
        b=acd6j/0Axp0lw3q8xva/Sgb2MFF0dUxeQAzIWuTO+3aaeRQb4giWZD70thO1k/t8KC
         TWb3WrwV70INtjaVs38u3Ek0iOcsU6WzYHByQYnTI8XAakRQzKz4MOef37DopPEr5+Lf
         GlVsD2PugnrHnu595rJn+9iw4HoOalBUHcuVKI8vU9YttlKpLMILRqGCCTOhMEhTiXQu
         tiNu8tsdue2Uwc2iCjxg3YmcoUsYn+i5M/uP4PAFN6s8GgalgqjOev6pdHuYhfdPRqMz
         xLuhaOILhVeDU6FXFmAjgG6/Pq4LXTUr1rq8YGgatGC6grED7utbWOOqTdaQmudopL2W
         Q2IA==
X-Gm-Message-State: AOAM533ryjPeuiAIkAZ68QE0ZzMXiOyS1LXXpnDDO4qi8m/OxpPf6YAd
        k9NlXmdkaqUhsjIBb9Ws6now0adUXT6Sa7s8+2doeA==
X-Google-Smtp-Source: ABdhPJz5r8XzDs6ct4fU0Wz5IOgXddNtGgB0aDw/R1jZjBJfR6vXAvlDsvp3+ZMXX+BDew2vwrIsnpnjI4WekMFGKi4=
X-Received: by 2002:a25:be81:: with SMTP id i1mr44795639ybk.184.1591129857654;
 Tue, 02 Jun 2020 13:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200602115055.1168446-1-jolsa@kernel.org> <20200602115055.1168446-5-jolsa@kernel.org>
 <CAP-5=fXjQ0ZgtrsizH6F7y2VRZ6dnsu54BXRxszyM+mMAvP-cQ@mail.gmail.com> <20200602190815.GH1169993@krava>
In-Reply-To: <20200602190815.GH1169993@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 Jun 2020 13:30:46 -0700
Message-ID: <CAP-5=fUPaS97FSYP6bzRedqFS5CV7VYq8D2qcny_mmp+pkOUJg@mail.gmail.com>
Subject: Re: [PATCH 04/13] perf tests: Add another metric parsing test
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

On Tue, Jun 2, 2020 at 12:08 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jun 02, 2020 at 10:58:32AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > > +static int check_parse_fake(const char *id)
> > > +{
> > > +       struct parse_events_error error;
> >
> > nit: this reads funny as it isn't clear, without looking at
> > check_parse_id, that error is zero initialized.
>
> right, how about something like below?

Thanks, looks good!
Ian

> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index d3343827eb4d..c745b6e13cbe 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -403,7 +403,6 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
>         evlist = evlist__new();
>         if (!evlist)
>                 return -ENOMEM;
> -       memset(error, 0, sizeof(*error));
>         ret = parse_events(evlist, id, error, fake_pmu);
>         evlist__delete(evlist);
>         return ret;
> @@ -411,7 +410,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
>
>  static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
>  {
> -       struct parse_events_error error;
> +       struct parse_events_error error = { 0 };
>
>         int ret = check_parse_id(id, &error, false);
>         if (ret && same_cpu) {
> @@ -433,7 +432,7 @@ static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
>
>  static int check_parse_fake(const char *id)
>  {
> -       struct parse_events_error error;
> +       struct parse_events_error error = { 0 };
>         int ret = check_parse_id(id, &error, true);
>
>         free(error.str);
>
