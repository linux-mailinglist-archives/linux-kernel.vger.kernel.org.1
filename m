Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02E52F595D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbhAND1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbhAND1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:27:38 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:26:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so6008689lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2OgcsRYFGCP0sLOBPm9ztVURBhxjrLmD3yKK1Hi/g8=;
        b=sBtARCVqjVDbxt5jkJwZ8wtCLyETuPW7AHM3FTEh3e5x3O+Y+GFthm36+bb2jFkoS6
         kslfolFDzOPkZAEVhYVXeF5Sd+qI4D/i/piwHYcttrxIhjXvjegz+tK/qzy+/4nPsbc0
         CtOdmC/psCu0D+qY7cUtpP2cbi3kBklyqlsaQIoxCpeDocWa8zTpfgrlVbNZvV9VbiEV
         sRlmprEZJ5op3QpNoyWkLAN2K6hPWBbn9Ubyr0dIiXv5zr3YyuAu0+dsDaOIlGb34RJU
         XEkDGjJ6cPGCloFJeySSAhEVr/NPnPLq1u7YGCa8i/HaK/+TUZgirDlZ8lbdp7dpI2y2
         FqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2OgcsRYFGCP0sLOBPm9ztVURBhxjrLmD3yKK1Hi/g8=;
        b=RMzz/nTC50TiMglgx9icuiY2+iULW5J3l5npyCpxMSrIVwDWEU3EI1CTCwCkixBH8h
         nO2EsIXza7/llJ1s10hS7QVOzIsb/N5Pom137kqGvZW+rPwxyk9nZvVtuEVLVTv5WxXf
         ZNmXA8RVwMzgjjzSwrfS0vOapd//6zH8f1wlf4rX9ak/7aGOpc3jBXijiJQS/OGvWGW2
         FgewPdgztC+bFsXQY1broqsbMOoGjivMVL1XQcKjsqUHR/0MBNwZ60amQdNoZC4HoaiC
         qWu1jN2DI5lVx5Eliq9hgCxlK6qrQuwbB8T0vscz2nT+ywuM1UCKLAGE9ZxfICccOFoo
         2gow==
X-Gm-Message-State: AOAM5332YduNdhUtaDU0vpoSz/e1jRgoAG3OQuUqeYP/S1lQ0rBbhGP7
        a8cKC9eW68k/rE+z6mNZyZKgbZaRjzfUiHr4wTA=
X-Google-Smtp-Source: ABdhPJzZHw1wxOPZaAXQPAnq2GPdIhDj66GYfVkoo4hc2v0FWkyZiIcUqWt66D1lgIpWKVMoHAv0vYGO7n8iiUN3Sp0=
X-Received: by 2002:a19:acd:: with SMTP id 196mr2357240lfk.539.1610594816213;
 Wed, 13 Jan 2021 19:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20210111213823.1249420-1-jolsa@kernel.org> <20210112024958.4utm7ijkpluu3g36@ast-mbp>
 <20210112091937.GA1252618@krava>
In-Reply-To: <20210112091937.GA1252618@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 13 Jan 2021 19:26:44 -0800
Message-ID: <CAADnVQKp-OzYqL48OJvBU-KNuxRUcZMPOToVHM5WN=jjPHJUog@mail.gmail.com>
Subject: Re: [PATCHv6 0/4] perf: Add mmap2 build id support
To:     Jiri Olsa <jolsa@redhat.com>
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:19 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jan 11, 2021 at 06:49:58PM -0800, Alexei Starovoitov wrote:
> > On Mon, Jan 11, 2021 at 10:38:19PM +0100, Jiri Olsa wrote:
> > > hi,
> > > adding the support to have buildid stored in mmap2 event,
> > > so we can bypass the final perf record hunt on build ids.
> > >
> > > This patchset allows perf to record build ID in mmap2 event,
> > > and adds perf tooling to store/download binaries to .debug
> > > cache based on these build IDs.
> > >
> > > Note that the build id retrieval code is stolen from bpf
> > > code, where it's been used (together with file offsets)
> > > to replace IPs in user space stack traces. It's now added
> > > under lib directory.
> > >
> > > v6 changes:
> > >   - last 4 patches rebased Arnaldo's perf/core
> >
> > There were no issues with v5 as far as I can remember.
> > This is just a resubmit to get it landed ?
>
> yes, exactly
>
> > Last time we couldn't quite figure out which tree to go through.
> > I think the recommend path was to go via bpf-next.
> > Is it still the case?
>
> bpf-next would be best for kernel changes,
>   perf: Add build id data in mmap2 event
>   bpf: Add size arg to build_id_parse function
>   bpf: Move stack_map_get_build_id into lib

Then please cc them to bpf@vger and add [PATCH bpf-next]
otherwise it's all very confusing.

> the 'perf buildid-cache' change needs to go through Arnaldo's tree,
> because it depends on changes he already pulled in

Also don't include the 4th patch in the series if it isn't meant for bpf-next.
