Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DED2A8E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgKFEaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:30:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37623 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFEaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:30:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id c16so125269wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 20:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiukiNr3QCs99RPAdUbmw/QFoxifAuJ5Umemtlu9dEo=;
        b=Ux8oxpIztjWjjkA5PaOP3IwHsdqGXJCv2G17sd5Nz+3KOZth5FfTpHm87x5jaUcBs0
         +zCfYtzXEgwifEpJb8os2w8laVL1dGwWllW0Taz71Xv4sZBoc2pZEhRQGtya1uWxDSaR
         O+BLqM7Op8M19Ba9TrrbA7KQ8UIqhNRJ9jlpElsjXIVHsTXXPAOIOoVe5PLeDLpNNDBD
         3wQGnYHw6zKyCp9NS9qBrsBRkZcRwK5KTePbO7VVSpjhVvsJSQIN+H2cUZXCpIFFIKNF
         /hrnKOYku6a88SQ216z2z/sbyxFox1WmdeZcPQKKOv3+W4++WC15r18n8CGeghLGwURp
         s6EA==
X-Gm-Message-State: AOAM533/eA2Mpp8OjcoCpo2a1ZbkSir9Fdc7WQ0xodJg7L3gj0pr6nDc
        BzLjvIo5rD3jYbedYkxFsnNbnFu7zjHjV5QM3iM=
X-Google-Smtp-Source: ABdhPJzL21Rs+7E+G9onIpc8mWxQnuJn7/uCrQ0QUbgmjysUrCf8sbcdEsyOIOYU/RGOafy8UKlcYH3s0aMnyX177mI=
X-Received: by 2002:a1c:9ad3:: with SMTP id c202mr252096wme.43.1604637007113;
 Thu, 05 Nov 2020 20:30:07 -0800 (PST)
MIME-Version: 1.0
References: <1604633576-32450-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1604633576-32450-1-git-send-email-kaixuxia@tencent.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Nov 2020 13:29:55 +0900
Message-ID: <CAM9d7chPANNgv-TBrvyLorSPJxNeGpqp9q5sht35uzJ8jW5JnA@mail.gmail.com>
Subject: Re: [PATCH] perf script: Remove unnecessary conversion to bool
To:     xiakaixu1987@gmail.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 6, 2020 at 12:33 PM <xiakaixu1987@gmail.com> wrote:
>
> From: Kaixu Xia <kaixuxia@tencent.com>
>
> Here we could use the '!=' expression to fix the following coccicheck
> warning:
>
> ./tools/perf/builtin-script.c:3209:48-53: WARNING: conversion to bool not needed here
> ./tools/perf/builtin-script.c:2761:36-41: WARNING: conversion to bool not needed here
>
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-script.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 48588ccf902e..b5a6fd63ca5f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2758,7 +2758,7 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>                                 break;
>                 }
>                 if (i == imax && strcmp(tok, "flags") == 0) {
> -                       print_flags = change == REMOVE ? false : true;
> +                       print_flags = change != REMOVE;
>                         continue;
>                 }
>                 if (i == imax) {
> @@ -3206,7 +3206,7 @@ static char *get_script_path(const char *script_root, const char *suffix)
>
>  static bool is_top_script(const char *script_path)
>  {
> -       return ends_with(script_path, "top") == NULL ? false : true;
> +       return ends_with(script_path, "top") != NULL;
>  }
>
>  static int has_required_arg(char *script_path)
> --
> 2.20.0
>
