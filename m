Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3322FB216
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbhASGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:53:10 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:34464 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbhASFdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:33:09 -0500
Received: by mail-lf1-f42.google.com with SMTP id o19so27376598lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 21:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=of2CFzmdhltKV5PUh+hY23KC62xc9LrbOAc/9i7ZltQ=;
        b=R/g4B8BCSEYiUKyomRvpdakPsaATNMyvHl+y+tIvZbMD2C/LVIcuoPkHhswQw5uCK1
         KkVCW8PYHmOiRML+g/q/qM0hAdz7poTqA6zDLJV94KI00dyYe9pxFV2c9U1obmWIKZTm
         T8kZwoBVG8+wI4HqFtuWEho6pBsxpzWh2iuFbjDmoZ9bLxhIOYCKpCkZfA7MTvzeS2R2
         NCXpTuVtSXAfWbDHKoUVFWzfjT7geI8wStPJ7ePvydpQ8S02Eq1LY10fxtP8B8u5c735
         Exh7kuDbxUnBdkJpc+GtZ20uL2bQDITTf+aWaDKyifn0RL2lDCjdNT2kbQ7rb/x4efPh
         3l8w==
X-Gm-Message-State: AOAM5313YwG3fCPFNBoSiFaOL5FdeVgjpQ3aGQaLTyltSeLTI3OKMTFK
        bNeKJaMKoRelTjYT6ru8/bVoU2lxPlZbpuhT8EA=
X-Google-Smtp-Source: ABdhPJwXLr110+mxsYB8DtyMRwzqmIPQyi19ft5U6HAGDoakiyxmNRKGaq/siN/rczXtEPO1X6GV5Q9fxGZQvTTuckw=
X-Received: by 2002:a19:23cf:: with SMTP id j198mr1154777lfj.509.1611034327181;
 Mon, 18 Jan 2021 21:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-9-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-9-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Jan 2021 14:31:55 +0900
Message-ID: <CAM9d7cgSx7WFo5fwxSoU9h2vD19LJxaM7p5i5+W+HLM6kpkwpw@mail.gmail.com>
Subject: Re: [PATCH 08/22] perf daemon: Add config file change check
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to detect daemon's config file changes
> and re-read the configuration when that happens.

Hmm.. maybe some of the code in the previous commit can be moved here.

Thanks,
Namhyung

>
> Using inotify file descriptor pluged into the main
> fdarray object for polling.
>
> Example:
>
>   # cat ~/.perfconfig
>   [daemon]
>   base=/opt/perfdata
>
>   [session-cycles]
>   run = -m 10M -e cycles --overwrite --switch-output -a
>
> Starting the daemon:
>
>   # perf daemon start
>
> Check sessions:
>
>   # perf daemon
>   [772262:daemon] base: /opt/perfdata
>   [772263:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
>
> Change '-m 10M' to '-m 20M', and check daemon log:
>
>   # tail -f /opt/perfdata/output
>   [2021-01-02 20:31:41.234045] daemon started (pid 772262)
>   [2021-01-02 20:31:41.235072] reconfig: ruining session [cycles:772263]: -m 10M -e cycles --overwrite --switch-output -a
>   [2021-01-02 20:32:08.310137] reconfig: session 'cycles' killed
>   [2021-01-02 20:32:08.310847] reconfig: ruining session [cycles:772338]: -m 20M -e cycles --overwrite --switch-output -a
>
> And the session list:
>
>   # perf daemon
>   [772262:daemon] base: /opt/perfdata
>   [772338:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a
>
> Note the changed '-m 20M' option is in place.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
