Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33822DE343
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLRN0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:26:05 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37666 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgLRN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:26:04 -0500
Received: by mail-lf1-f47.google.com with SMTP id o17so5424881lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lld6uYD/Bp1JtYtuuWXlgoUFiB/kKOYiMIe93vwctoQ=;
        b=CQK0CbTPie1cM58tNAb2I/PwiawiaaqJ9dppao7jz82mUuXyCrg8TWIZnouR4PC9LO
         ID2OW3k2ofbj5e6TvO+5W1VaDa4LTt2CXbKJ5dkv5h4KsbccK1VqedR3GsBiilv3muCs
         6+cSrTjd7t57vcGJGSFstk06m6R4undSW/rkQI7cTFVSwqOqA2ino7Bsc8QyNdb+nMFx
         7Ktq6MDZ+zqqYscRuzYi8tIEfj+3xOdDV4LYTL2SuOroht9Ng9oIch3/0OnOBZQOHP3x
         9aP6YPCW+rUWcN+BXq1+5hnBT0uc4T5tIbhTpJWLERch8yECE85/MqSGF7Z7sJuyKpXL
         J9Jg==
X-Gm-Message-State: AOAM531BxZtkKhXWI3IVq16k3AKRCSylzt0tGcS4uP5o5IN2o3Cz4ln5
        wAomMlSJZA4Cnm1DDk6fAly6oQ95cAUQRKSwdA4=
X-Google-Smtp-Source: ABdhPJw8LsPYaqtdCS2tigNpubsQrfe+xceW03LzuADh3FVkvI+6esSSsGHmSkW984lehwwXABH43TomJEVAEa2sxcM=
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr1749326ljp.26.1608297917479;
 Fri, 18 Dec 2020 05:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20201212104358.412065-1-jolsa@kernel.org> <20201212104358.412065-5-jolsa@kernel.org>
 <1e467abe-4613-765f-5138-6215b711f9fb@huawei.com> <20201215194354.GH698181@krava>
In-Reply-To: <20201215194354.GH698181@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Dec 2020 22:25:06 +0900
Message-ID: <CAM9d7ciuss-iD68etX9mo=gjO7_Wh+Ve81=35BDx6hL=oWK_4Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf daemon: Add daemon command
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Dec 16, 2020 at 4:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Dec 15, 2020 at 06:40:26PM +0300, Alexei Budankov wrote:
> > Hi,
> >
> > On 12.12.2020 13:43, Jiri Olsa wrote:
> > > Adding daemon command that allows to run record sessions
> > > on background. Each session represents one perf record
> > > process and is configured in config file.
> > >
> > > Example:
> > >
> > >   # cat config.daemon
> > >   [daemon]
> > >   base=/opt/perfdata
> >
> > It could probably make sense to consider using locations at /var/
> > directory, similar to other already existing daemon processes in
> > system so admin and user experience would be easily reusabe for
> > performance monitoring daemon (service).
>
> hm, you can specify any /var path in there if you like,
> do you suggest to hardcode it?
>
> >
> > >
> > >   [session-1]
> > >   run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
> > >
> > >   [session-2]
> > >   run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
> > >
> > > Default perf config has the same daemon base:
> > >
> > >   # cat ~/.perfconfig
> > >   [daemon]
> > >   base=/opt/perfdata
> > >
> > > Starting the daemon:
> > >
> > >   # perf daemon --config config.daemon
> >
> > It could make sense to name daemon config file similar to .perfconfig
> > e.g. like .perfconfig.daemon. perf daemon command would then assume, by
> > default, usage of .perfconfig.daemon config or the one specified on the
> > command line via --config option. It also would be helpfull have loaded
> > config file path printed into console:
> > # perf daemon
> > Daemon process <pid> started with config /path/to/.perfconfig.daemon
>
> so the current way is, that following creates daemon:
>
>   # perf daemon --config <CONFIG>
>
> and any other 'non --config' option' is used to 'query/control' daemon:
>
>   # perf daemon
>   # perf daemon --signal
>   # perf daemon --stop
>   ...

My opinion is that it'd be better having sub-commands for essential
operations like start, stop.  Also daemons tend to have 'status' or
'reload' operations too.

  # perf daemon start --config ...
  # perf daemon stop

As a system daemon, I agree it should follow the standard location
for the default base directory and config file.

Thanks,
Namhyung
