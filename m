Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3777227F919
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgJAFfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAFfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:35:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0004C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:35:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so1604915wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQEcLnglV2nTwBheM5HtxkVuYhbwp8sHenM1j3wNKFU=;
        b=I9tN5epr/tYWktZWD/mMK3gecI69FwuNydgbMcLyK8byL2NjC8Esgr6WRAeXXktzDs
         saV5/l0WW+m7W6aGR4FjTMX/b2peJ3JfAWzv+KTT6vg4dfZykxLsaQdVSdkHCw6aS4ik
         jZB602gh3Up1zXgtvbp6rhAuVarw1Q7xNpNyxCEhxhn9kiH8NbVlIgW7rsdQKqPGxPKG
         4jTV/k4uH026hQSkr3us7FUCn/X/cNVUq6VyNy8zvclMELUzezpUhdAlbCEJOauKfqv+
         iSedOlZYrW2R6SnsatSnW4vkuJmrhG4HUPBQ3OpVwwqyieMbTj52Ce0eDT4cFfQdKxu2
         +xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQEcLnglV2nTwBheM5HtxkVuYhbwp8sHenM1j3wNKFU=;
        b=YfhX+I8ce3JrwXUy020gKSlTl5W+XTNXs8pJoDUEflSpX6KG3kptZtH2PKO6caTVql
         tjZ5WQe9vOkHKudH0G3fqRgIejvSCUqI6Uh2mgO83t7udXFb7PWnipT526AK03aKPMU1
         QQQOJlcz6gy616efCoPIK0hrXc761PjvzI4DZi5zpG2FUgeWBXh2NghR+FjLWv9QW3zB
         NdtWpKTjK5mM8lYZBwOIg+39EgT7jONExADD4hpnboj4PQ1QoJMIjO9t0/o+tDmyzXWg
         BW/Vhy4L4CIDiW1AZhEXljcBEmJnQEd1aLPZ/vNRdSV5TIBYo5RR/9MCS3BN9Qw+azQJ
         qo3A==
X-Gm-Message-State: AOAM5304++LfmVZQo+9eqYg2luMvSG0KImhjKJ+4BLsqDUsVDrT0Cs6T
        HpTcia+17jISFav6UeHnjhnhX0rDjZtQCbyEH7oDHQ==
X-Google-Smtp-Source: ABdhPJzQRQSagSOzeXc0C/R6OvKKnNg828QR4gSjfXfz6/pdTvhTsA7wrFM3DEeL8+ZAcBQ5opQvK6QbxCBTHnVKYTk=
X-Received: by 2002:a1c:7514:: with SMTP id o20mr6279695wmc.76.1601530513302;
 Wed, 30 Sep 2020 22:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-10-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-10-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:35:01 -0700
Message-ID: <CAP-5=fVPE2OT4ts3oFoBfjPMMA6bQ1QW4P_-Gy==EdywGfcsBQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] perf tools: Align buildid list output for short build ids
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:15 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> With shorter md5 build ids we need to align their
> paths properly with other build ids:
>
>   $ perf buildid-list
>   17f4e448cc746582ea1881528deb549f7fdb3fd5 [kernel.kallsyms]
>   a50e350e97c43b4708d09bcd85ebfff7         .../tools/perf/buildid-ex-md5
>   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/dso.c  | 2 +-
>  tools/perf/util/dso.h  | 1 -
>  tools/perf/util/dsos.c | 6 ++++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ca965845b35e..55c11e854fe4 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1369,7 +1369,7 @@ int dso__kernel_module_get_build_id(struct dso *dso,
>         return 0;
>  }
>
> -size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
> +static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
>
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index f926c96bf230..d8cb4f5680a4 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -362,7 +362,6 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
>
>  void dso__reset_find_symbol_cache(struct dso *dso);
>
> -size_t dso__fprintf_buildid(struct dso *dso, FILE *fp);
>  size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
>  size_t dso__fprintf(struct dso *dso, FILE *fp);
>
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 87161e431830..183a81d5b2f9 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -287,10 +287,12 @@ size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
>         size_t ret = 0;
>
>         list_for_each_entry(pos, head, node) {
> +               char sbuild_id[SBUILD_ID_SIZE];
> +
>                 if (skip && skip(pos, parm))
>                         continue;
> -               ret += dso__fprintf_buildid(pos, fp);
> -               ret += fprintf(fp, " %s\n", pos->long_name);
> +               build_id__sprintf(&pos->bid, sbuild_id);
> +               ret += fprintf(fp, "%-40s %s\n", sbuild_id, pos->long_name);
>         }
>         return ret;
>  }
> --
> 2.26.2
>
