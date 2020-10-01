Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE47427F907
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgJAF0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAF0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:26:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4585C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:26:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so1582582wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmHXTE4F4jHgiV3b6mUSLNF1ue58qvwcw3gNuO6qY4I=;
        b=BwZawTwssCSHJIY8ZKQ6Lg66wC0Ejy+zgkgNYQxLt6KTAzXZPnNrCsR625R+QwrZMs
         xbGjtEmW5jSNklim03smW9OxDEuuC+q+9XEShCgD+PCTqRflokfivpMRCpRcqXrQF+l1
         FAc9TIQL1ypuiOrhBBdndVzrQM/AkkxBTTXc4kJkwPw5nVOGxZhhwZEaYS0kx0eXTv8b
         bn570RO4o2xQRpj2ZRhXi2wIRwQkeQDjaX8xBjc8YHq5jyZi5ZbrNkzfrluKQB88Az5S
         RuNNy28rQ+YGKfm2lB/x/f6CuEi5r1+fFE/uJaF5cF1vd5GtAg7WFK44r7adtouj9/vI
         jvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmHXTE4F4jHgiV3b6mUSLNF1ue58qvwcw3gNuO6qY4I=;
        b=DhXgCmeuXdvYdfUgL43m/Z0PR1YqRAiEH17Wek8rfxP49O38vdTwSWNOa8/4+cYK4V
         hpTJXt/XmE6zVN+6N7MqLAV/udMdUhUCvgHwbvrgNTex3x1I2SjFZym2SpVYKap3wcRL
         P5hB3Cp+jMiGZvhEr6qbSJD5I+hdJHzGHHKAWevRzH8Z7dqfCgHBdROrL4j2j0kF1Q8P
         ZT2lube7hxvI3RUJPeo7ZRz/eY+4wpAdyHg3YO1qcAK98DH7cs0Nl/KDvPxUjXAI6ClG
         bppRqlnLijFpdiOg+YA1wgnQ6SHI/6kFa5FaRRLcssNOzqHy+sKoMQgxWC2/7G51AgGl
         WWug==
X-Gm-Message-State: AOAM531YCYnddZikrGl7v/qxjD4Iu/ZxhmQfmY9fAgML9I1oWxA5oVra
        G6QtNKeOLILh8yFaXunOS5Z6of/m/ujsagWxWzWL3Q==
X-Google-Smtp-Source: ABdhPJyb42+Wu0aSWknv7IDpH5TfGfCzkXWQYUfXuL9BSTx60VGW3TbHec1zPwR8CgrhuJRrXwYV2H7NcSHmTCVB0Ys=
X-Received: by 2002:a05:600c:220f:: with SMTP id z15mr6231303wml.87.1601529960166;
 Wed, 30 Sep 2020 22:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-8-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-8-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:25:48 -0700
Message-ID: <CAP-5=fWOmLDdHwHhTY0cL3hnML0VuEbfzFvsNF7kZV0mtYGW5g@mail.gmail.com>
Subject: Re: [PATCH 7/9] perf tools: Pass build_id object to dso__build_id_equal
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
> Passing build_id object to dso__build_id_equal, so we can
> properly check build id with different size than sha1.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/dso.c        | 5 +++--
>  tools/perf/util/dso.h        | 2 +-
>  tools/perf/util/symbol-elf.c | 8 ++++++--
>  tools/perf/util/symbol.c     | 2 +-
>  4 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 4415ce83150b..ca965845b35e 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1332,9 +1332,10 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
>         dso->has_build_id = 1;
>  }
>
> -bool dso__build_id_equal(const struct dso *dso, u8 *build_id)
> +bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
>  {
> -       return memcmp(dso->bid.data, build_id, sizeof(dso->bid.data)) == 0;
> +       return dso->bid.size == bid->size &&
> +              memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
>  }
>
>  void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 5a5678dbdaa5..f926c96bf230 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -261,7 +261,7 @@ void dso__set_sorted_by_name(struct dso *dso);
>  void dso__sort_by_name(struct dso *dso);
>
>  void dso__set_build_id(struct dso *dso, struct build_id *bid);
> -bool dso__build_id_equal(const struct dso *dso, u8 *build_id);
> +bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
>  void dso__read_running_kernel_build_id(struct dso *dso,
>                                        struct machine *machine);
>  int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 97a55f162ea5..44dd86a4f25f 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -834,13 +834,17 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>         /* Always reject images with a mismatched build-id: */
>         if (dso->has_build_id && !symbol_conf.ignore_vmlinux_buildid) {
>                 u8 build_id[BUILD_ID_SIZE];
> +               struct build_id bid;
> +               int size;
>
> -               if (elf_read_build_id(elf, build_id, BUILD_ID_SIZE) < 0) {
> +               size = elf_read_build_id(elf, build_id, BUILD_ID_SIZE);
> +               if (size <= 0) {
>                         dso->load_errno = DSO_LOAD_ERRNO__CANNOT_READ_BUILDID;
>                         goto out_elf_end;
>                 }
>
> -               if (!dso__build_id_equal(dso, build_id)) {
> +               build_id__init(&bid, build_id, size);
> +               if (!dso__build_id_equal(dso, &bid)) {
>                         pr_debug("%s: build id mismatch for %s.\n", __func__, name);
>                         dso->load_errno = DSO_LOAD_ERRNO__MISMATCHING_BUILDID;
>                         goto out_elf_end;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 976632d0baa0..6138866665df 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2136,7 +2136,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
>         }
>
>         if (sysfs__read_build_id("/sys/kernel/notes", &bid) == 0)
> -               is_host = dso__build_id_equal(dso, bid.data);
> +               is_host = dso__build_id_equal(dso, &bid);
>
>         /* Try a fast path for /proc/kallsyms if possible */
>         if (is_host) {
> --
> 2.26.2
>
