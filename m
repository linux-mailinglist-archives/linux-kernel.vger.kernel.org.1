Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714A721B8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGJOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 10:30:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34028 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgGJOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:30:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id g10so8592549wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdnUnHtfirlekhrwzQjF1FZ328y4VuucsToB4ssq670=;
        b=kemD2Anqae6DdE1oBkwiALzvnLyufMoRvtwCRFju5x9GmzSh9vFyDbZ6iFwGkuvJMS
         GYH2pfa4wLBxtOe2pUtX/+DqYidxBPKu6KPuCi0THFACZPEMjw+Ty14DaVR18jFlYo8y
         Ae9McW8m8Nlu3+o6M2m8uL6PPI7B0CIYaYlXYjJyTNj7Mq7GeGeainn6U2VTgPS0Q36x
         Fg0XVdZB/J3m4KWt8N1IZu7vuGrMq/JlSbD/jrmfEUoBovGkhWYLV+GeDGvVEfNlEmxU
         SqOECn1wZW0fjgaGRvo/MZy6bNbkIM6hm3x/FRciergwNzWLunKoh+z+UXUr+eLH1up8
         yEhg==
X-Gm-Message-State: AOAM530W1Zrxe1wF6wbG2TI8Ri2FaxNohtf9HO+buTCUZkKRn/aeg4Kx
        ENO6jUjjkXv+ImYPZ4vxz4sdBiHUKpXtnEBJ4/Y=
X-Google-Smtp-Source: ABdhPJx7o/4fuIKxLBJlGbWRT2svGYEOYlxVPewgmFKC6C2Men9crlVhgitabn+mmHPK7fWCDJlDfexoTOq9ZIMW9Bg=
X-Received: by 2002:a1c:6308:: with SMTP id x8mr5708081wmb.92.1594391400604;
 Fri, 10 Jul 2020 07:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200710134322.15400-1-changbin.du@gmail.com> <20200710134322.15400-9-changbin.du@gmail.com>
In-Reply-To: <20200710134322.15400-9-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Jul 2020 23:29:49 +0900
Message-ID: <CAM9d7ciuzqbBb+POeuiFh-KOFKKzi7LOC6r2vu=WiQ_5tMe7Zw@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] perf: util: add general function to parse
 sublevel options
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:44 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This factors out a general function perf_parse_sublevel_options() to parse
> sublevel options. The 'sublevel' options is something like the '--debug'
> options which allow more sublevel options.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> ---
> v2: add util/parse-sublevel-options.c
> ---
[snip]
> diff --git a/tools/perf/util/parse-sublevel-options.c b/tools/perf/util/parse-sublevel-options.c
> new file mode 100644
> index 000000000000..39798568547c
> --- /dev/null
> +++ b/tools/perf/util/parse-sublevel-options.c
> @@ -0,0 +1,63 @@
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <stdio.h>
> +
> +#include "util/debug.h"
> +#include "util/parse-sublevel-options.h"
> +
> +static int parse_one_sublevel_option(const char *str,
> +                                    struct sublevel_option *opts)
> +{
> +       struct sublevel_option *opt = &opts[0];
> +       char *vstr, *s = strdup(str);
> +       int v = 1;

I know you just copied the code, but let's add a check for
the return value of strdup().

Also I think you can just use the opts pointer..


> +
> +       vstr = strchr(s, '=');
> +       if (vstr)
> +               *vstr++ = 0;
> +
> +       while (opt->name) {
> +               if (!strcmp(s, opt->name))
> +                       break;
> +               opt++;
> +       }
> +
> +       if (!opt->name) {
> +               pr_err("Unknown option name '%s'\n", s);
> +               free(s);
> +               return -1;
> +       }
> +
> +       if (vstr)
> +               v = atoi(vstr);
> +
> +       *opt->value_ptr = v;
> +       free(s);
> +       return 0;
> +}
> +
> +/* parse options like --foo a=<n>,b,c... */
> +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts)
> +{
> +       char *s = strdup(str);
> +       char *p = NULL;
> +       int ret;
> +
> +       if (!s)
> +               return -1;
> +
> +       p = strtok(s, ",");
> +       while (p) {
> +               ret = parse_one_sublevel_option(p, opts);
> +               if (ret) {
> +                       free(s);
> +                       return ret;
> +               }
> +
> +               p = strtok(NULL, ",");
> +       }
> +
> +       free(s);
> +       return 0;
> +}
> diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
> new file mode 100644
> index 000000000000..9b9efcc2aaad
> --- /dev/null
> +++ b/tools/perf/util/parse-sublevel-options.h
> @@ -0,0 +1,11 @@
> +#ifndef _PERF_PARSE_SUBLEVEL_OPTIONS_H
> +#define _PERF_PARSE_SUBLEVEL_OPTIONS_H
> +
> +struct sublevel_option {
> +       const char *name;
> +       int *value_ptr;
> +};
> +
> +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
> +
> +#endif
> \ No newline at end of file

Please add a newline at the end.

Thanks
Namhyung


> --
> 2.25.1
>
