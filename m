Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D41262EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgIINK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 09:10:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40144 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgIINEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:04:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id j2so2866125wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1nwViaxxnU8tzKIIMfilWsNyvQ0ZY7Xb6S3jLLgyyM=;
        b=twF73j0Z4/dBbVOTGorPIsu8Xu3NNxMUPaB9toV1GRWcEDSxmPYl8PHS4M24j/gx92
         bYXEayqNra9R7bomkljeKMdv1/qtfzs/JQ/sM+zi5svqbw2YmmUT++KH5nx+XTBWiyGw
         Kbgngu4iIdL264sABLhFAUHrpqJtcTUrKPXKfrWvny5mgZmd92Rb0ynspknW6nFLz4xi
         SSIOBPTGJ7VWvBAtF91//dpAY4s2pJW/dSyv+3c67X/qGiM7rXwe2iRWjn1LDafpFpuE
         SIp9jAbpGeiDdMdrn7fbkZZWEg4RvcjXTjFQycGsqbVfi6bmZnGAx/RKCyzpu7n50yhP
         6raA==
X-Gm-Message-State: AOAM530XpM5o9J+bL0JOhE6MYT10tnQtnNATmDKs1bBmPOmMf3Up5Fhr
        Me5e4/uAaA+3zX7lRjfAaFyqhoeRvYlfx1XcNHk=
X-Google-Smtp-Source: ABdhPJx2DO+t2EkJLlewDS7BcdoICfMgIp0k3pf110z6asC0TugFNegz3BOhUFNsWJihlOguFXs2dkQvbA37VICsGQQ=
X-Received: by 2002:adf:82d5:: with SMTP id 79mr4326052wrc.60.1599656625238;
 Wed, 09 Sep 2020 06:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <1599645194-8438-1-git-send-email-tangzejiang@loongson.cn>
In-Reply-To: <1599645194-8438-1-git-send-email-tangzejiang@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Sep 2020 22:03:34 +0900
Message-ID: <CAM9d7cignBfmuNB9hkKFW4Zsm7LT86zX54VEyQPuDGdkdQv-tQ@mail.gmail.com>
Subject: Re: [PATCH v3] Improve perf option help information in perf.txt
To:     Zejiang Tang <tangzejiang@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 6:53 PM Zejiang Tang <tangzejiang@loongson.cn> wrote:
>
> Perf could use many options, such as:-vv, --exec-path,
> --html-path, -p, --paginate,--no-pager, --debugfs-dir,
> --buildid-dir, --list-cmds, --list-opts. Add these options
> in perf.txt.
>
> Signed-off-by: Zejiang Tang <tangzejiang@loongson.cn>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/Documentation/perf.txt | 69 ++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index 3f37ded..c130a3c 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -12,32 +12,57 @@ SYNOPSIS
>
>  OPTIONS
>  -------
> ---debug::
> -       Setup debug variable (see list below) in value
> -       range (0, 10). Use like:
> -         --debug verbose   # sets verbose = 1
> -         --debug verbose=2 # sets verbose = 2
> -
> -       List of debug variables allowed to set:
> -         verbose          - general debug messages
> -         ordered-events   - ordered events object debug messages
> -         data-convert     - data convert command debug messages
> -         stderr           - write debug output (option -v) to stderr
> -                            in browser mode
> -         perf-event-open  - Print perf_event_open() arguments and
> -                            return value
> -
> ---buildid-dir::
> -       Setup buildid cache directory. It has higher priority than
> -       buildid.dir config file option.
> +-h::
> +--help::
> +        Run perf help command.
>
>  -v::
>  --version::
> -  Display perf version.
> +        Display perf version.
>
> --h::
> ---help::
> -  Run perf help command.
> +-vv::
> +        Print the compiled-in status of libraries.
> +
> +--exec-path::
> +        Display or set exec path.
> +
> +--html-path::
> +        Display html documentation path.
> +
> +-p::
> +--paginate::
> +        Set up pager.
> +
> +--no-pager::
> +        Do not set pager.
> +
> +--buildid-dir::
> +        Setup buildid cache directory. It has higher priority
> +        than buildid.dir config file option.
> +
> +--list-cmds::
> +        List the most commonly used perf commands.
> +
> +--list-opts::
> +        List available perf options.
> +
> +--debugfs-dir::
> +        Set debugfs directory or set environment variable PERF_DEBUGFS_DIR.
> +
> +--debug::
> +        Setup debug variable (see list below) in value
> +        range (0, 10). Use like:
> +          --debug verbose   # sets verbose = 1
> +          --debug verbose=2 # sets verbose = 2
> +
> +        List of debug variables allowed to set:
> +          verbose          - general debug messages
> +          ordered-events   - ordered events object debug messages
> +          data-convert     - data convert command debug messages
> +          stderr           - write debug output (option -v) to stderr
> +                             in browser mode
> +          perf-event-open  - Print perf_event_open() arguments and
> +                             return value
>
>  DESCRIPTION
>  -----------
> --
> 2.1.0
>
