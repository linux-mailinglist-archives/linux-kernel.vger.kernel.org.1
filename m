Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C627F905
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJAFZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:25:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46DFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:25:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so4115831wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jpd2RJeN3d71IAidBHSzwzFJ1Qeh1n4bsmrYv1z5vsQ=;
        b=CoDGrl0BWpn9DUGkm7cYagxRmOc/Y8IgRDkTncdyHjJ+sElpnQTh7YjAAcRXavbGTd
         U7OE+Pu1Gc93ul02IniXFTM95Xz02rpV7XypJH57of5Id9iCBQ6GR2Bq7e8Xu7gQDF0b
         G6lrUjPc1NFW4zZCnFB5x6MuuW4nJPCgfxLu5UAFjAXtROdBjMVU87KjRgrWsW9sNFSV
         dfulNhHYnsu5AgDtiPpC3OEVu4TSjTZHBSuLSFvA+N0GRru9DNm8EA7z79opUDknLERb
         nizIW6QG2V9tnNtIH0xJvKk3Q67Eenw0P0cUJsPrE+jJF0qzwnggrxuHH6j2v2vefwQi
         oPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jpd2RJeN3d71IAidBHSzwzFJ1Qeh1n4bsmrYv1z5vsQ=;
        b=boMCxGUHCjggvsRHQBLnHn58N6b7+s3Mu/kskoeUk2sZfBY2DwIMGpAc2e19aYxDWN
         ACSAJkCcozXeMfeoZSbqCTgeGvU9+2BlhEQyF871Sihjq5MTHVyLXB0q+uhkl6O5nYHu
         JezjNyLj/Lo2GHTCbEGk3FWyQVLNFmeWISlzBLWk8CLnJ6/56aiprE709hm6f5P0UzQK
         iDkIgTdI+RDwcIo9ln7MyMGdqvpOlb0WFrU+z2tuWDFwhEngFBk85F0sfM1REhqROYdv
         UO5O3RdtseSh0g6tIexgB5MZ3KmtWQDMoXDmSv/bOXbyGrA4QZCeQYg9os56Fk5JEFbS
         HXIg==
X-Gm-Message-State: AOAM530ZsuzORRbhiV7jrkrOlEu7KsY45XSnClkQ7loepPXplyXMxSsi
        rzPtnF7ZwpfZF/BNumDTGlMnfLrP16D48ESftFY0zWYz6xS4Qg==
X-Google-Smtp-Source: ABdhPJykuhIGkvxrJGLnuXIMQQnQ7D09iAsfO+FGL0aCTEh6X98PiUozQG3WO3ZI3clz8fW8GzrBl+h5s3LqyNGDGZ8=
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr7127914wrp.271.1601529927292;
 Wed, 30 Sep 2020 22:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-7-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-7-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:25:16 -0700
Message-ID: <CAP-5=fWu_iK+VB9h3-gH-dvgRftxLDK_eOmFzf0fLpiiVgWTDQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf tools: Pass build_id object to dso__set_build_id
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
> Passing build_id object to dso__set_build_id, so it's easier
> to initialize dos's build id object.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/dso.c            | 4 ++--
>  tools/perf/util/dso.h            | 2 +-
>  tools/perf/util/header.c         | 4 +++-
>  tools/perf/util/symbol-minimal.c | 2 +-
>  tools/perf/util/symbol.c         | 2 +-
>  5 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2f7f01ead9a1..4415ce83150b 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1326,9 +1326,9 @@ void dso__put(struct dso *dso)
>                 dso__delete(dso);
>  }
>
> -void dso__set_build_id(struct dso *dso, void *build_id)
> +void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  {
> -       memcpy(dso->bid.data, build_id, sizeof(dso->bid.data));
> +       dso->bid = *bid;
>         dso->has_build_id = 1;
>  }
>
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index eac004210b47..5a5678dbdaa5 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -260,7 +260,7 @@ bool dso__sorted_by_name(const struct dso *dso);
>  void dso__set_sorted_by_name(struct dso *dso);
>  void dso__sort_by_name(struct dso *dso);
>
> -void dso__set_build_id(struct dso *dso, void *build_id);
> +void dso__set_build_id(struct dso *dso, struct build_id *bid);
>  bool dso__build_id_equal(const struct dso *dso, u8 *build_id);
>  void dso__read_running_kernel_build_id(struct dso *dso,
>                                        struct machine *machine);
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index fe220f01fc94..21243adbb9fd 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2082,8 +2082,10 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>         dso = machine__findnew_dso(machine, filename);
>         if (dso != NULL) {
>                 char sbuild_id[SBUILD_ID_SIZE];
> +               struct build_id bid;
>
> -               dso__set_build_id(dso, &bev->build_id);
> +               build_id__init(&bid, bev->build_id, BUILD_ID_SIZE);
> +               dso__set_build_id(dso, &bid);
>
>                 if (dso_space != DSO_SPACE__USER) {
>                         struct kmod_path m = { .name = NULL, };
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index dba6b9e5d64e..f9eb0bee7f15 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -349,7 +349,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
>                 dso->is_64_bit = ret;
>
>         if (filename__read_build_id(ss->name, &bid) > 0)
> -               dso__set_build_id(dso, bid.data);
> +               dso__set_build_id(dso, &bid);
>         return 0;
>  }
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 369cbad09f0d..976632d0baa0 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1818,7 +1818,7 @@ int dso__load(struct dso *dso, struct map *map)
>             is_regular_file(dso->long_name)) {
>             __symbol__join_symfs(name, PATH_MAX, dso->long_name);
>                 if (filename__read_build_id(name, &bid) > 0)
> -                       dso__set_build_id(dso, bid.data);
> +                       dso__set_build_id(dso, &bid);
>         }
>
>         /*
> --
> 2.26.2
>
