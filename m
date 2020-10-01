Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9944027F903
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgJAFYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:24:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41541C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:24:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so4120518wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgX/oQRkJAifInjx93d7DSqlSfY6F/tyhbm1N2lZpXs=;
        b=BV4xLoOxQ6189yHXh394dlBiWCKQ7ZToou9cMYAa0pSKvMGcE77GObW6vpqcmlrLzf
         o9jvSfKe1NfILqejpXusDjUpJywG8CGBzVqG1PwDQVW2YO05yBQW4qIqQLkz+lvteDDU
         L3R6/kaLyUeD9QfkzgxyXc/WBJAIZUom76vVBaY6BsLzYKOSa+N4i1hFqekKOu9BOqD4
         VvW3+U5WPrO3fmnSM9fTYSsufY6dV/nbssve8uMH3R2+yqLPJyE+KZyKRU11LPsPlgRc
         Z1dkm+yFSUe1BEelrXpv6A0G/SZbqa1Xn28GUnkLKLY2w5lTtzKOYnZL+W6FRummitc7
         r+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgX/oQRkJAifInjx93d7DSqlSfY6F/tyhbm1N2lZpXs=;
        b=rEG5Nb9zTJraxaVOxF/y65wuOehQDoAMBvR9rj+lb2kFhTVU7M2dp1tknoQEOpACK1
         tdG/LihpIQr7KAXLMlh1GmT/KJVo+QoBQDXX5nHe0HRGb2C1cI+31S4ymKab+fSpcw8R
         sHbyQIQogOTt8bnQUjQ+ooYhKLC6lDYwVt0t88Z4nhApq7Cze9AAr+L+CGJbBsJ2GQ02
         V6s0XdF59vqVB7gYTYugrsw8OhKYTFsg468I5XmOQUovY2cRl1v8eWCkZRYzV4e0ublx
         JE+aDs9Bs5uJKQkqVpP7fDhqojjc4nrkAoA4faVmmiD7YsNzHmLmTZAU6G7Y5cdgDBW/
         clUQ==
X-Gm-Message-State: AOAM5317jnObt/BqMibWCxr1RIVKmqNjThud5rWwtkqrwIsdkoGTUKHT
        vEcDGfd0gSeZpkrWN04qw8/z97cqFalk+5MYfv4MmQ==
X-Google-Smtp-Source: ABdhPJxw82ZKeQlAkdWUTL4Ql1fFK9TqAqfvofGaQZe7WJc6qBdvkaVNMmsDJDs8rQCG+y/J7OBlAmFqea7xOYtSM0w=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr6472716wrq.282.1601529878507;
 Wed, 30 Sep 2020 22:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-6-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-6-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:24:26 -0700
Message-ID: <CAP-5=fXedkfq6RWJN9fvS_m41CqbznrF4LOSfTYcF9gYGTp=Gw@mail.gmail.com>
Subject: Re: [PATCH 5/9] perf tools: Pass build_id object to build_id__sprintf
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
> Passing build_id object to build_id__sprintf function,
> so it can operate with the proper size of build id.
>
> This will create proper md5 build id readable names,
> like following:
>   a50e350e97c43b4708d09bcd85ebfff7
>
> instead of:
>   a50e350e97c43b4708d09bcd85ebfff700000000
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-buildid-cache.c            |  6 ++--
>  tools/perf/tests/sdt.c                        |  2 +-
>  tools/perf/util/annotate.c                    |  3 +-
>  tools/perf/util/build-id.c                    | 30 ++++++++++++-------
>  tools/perf/util/build-id.h                    |  3 +-
>  tools/perf/util/dso.c                         |  6 ++--
>  tools/perf/util/header.c                      |  3 +-
>  tools/perf/util/map.c                         |  4 +--
>  tools/perf/util/probe-event.c                 |  9 ++++--
>  tools/perf/util/probe-finder.c                |  8 +++--
>  .../scripting-engines/trace-event-python.c    |  2 +-
>  tools/perf/util/symbol.c                      |  2 +-
>  12 files changed, 43 insertions(+), 35 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index c3cb168d546d..a25411926e48 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -186,7 +186,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>                 return -1;
>         }
>
> -       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
> +       build_id__sprintf(&bid, sbuild_id);
>         err = build_id_cache__add_s(sbuild_id, filename, nsi,
>                                     false, false);
>         pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
> @@ -210,7 +210,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
>                 return -1;
>         }
>
> -       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
> +       build_id__sprintf(&bid, sbuild_id);
>         err = build_id_cache__remove_s(sbuild_id);
>         pr_debug("Removing %s %s: %s\n", sbuild_id, filename,
>                  err ? "FAIL" : "Ok");
> @@ -314,7 +314,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
>         }
>         err = 0;
>
> -       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
> +       build_id__sprintf(&bid, sbuild_id);
>         if (build_id_cache__cached(sbuild_id))
>                 err = build_id_cache__remove_s(sbuild_id);
>
> diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
> index 3ef37f739203..ed76c693f65e 100644
> --- a/tools/perf/tests/sdt.c
> +++ b/tools/perf/tests/sdt.c
> @@ -37,7 +37,7 @@ static int build_id_cache__add_file(const char *filename)
>                 return err;
>         }
>
> -       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
> +       build_id__sprintf(&bid, sbuild_id);
>         err = build_id_cache__add_s(sbuild_id, filename, NULL, false, false);
>         if (err < 0)
>                 pr_debug("Failed to add build id cache of %s\n", filename);
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a016e1bd7b8d..6c8575e182ed 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1578,8 +1578,7 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
>                 char *build_id_msg = NULL;
>
>                 if (dso->has_build_id) {
> -                       build_id__sprintf(dso->bid.data,
> -                                         sizeof(dso->bid.data), bf + 15);
> +                       build_id__sprintf(&dso->bid, bf + 15);
>                         build_id_msg = bf;
>                 }
>                 scnprintf(buf, buflen,
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 1c332e78bbc3..b5648735f01f 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -37,6 +37,7 @@
>
>  #include <linux/ctype.h>
>  #include <linux/zalloc.h>
> +#include <asm/bug.h>
>
>  static bool no_buildid_cache;
>
> @@ -95,13 +96,13 @@ struct perf_tool build_id__mark_dso_hit_ops = {
>         .ordered_events  = true,
>  };
>
> -int build_id__sprintf(const u8 *build_id, int len, char *bf)
> +int build_id__sprintf(const struct build_id *build_id, char *bf)
>  {
>         char *bid = bf;
> -       const u8 *raw = build_id;
> -       int i;
> +       const u8 *raw = build_id->data;
> +       size_t i;
>
> -       for (i = 0; i < len; ++i) {
> +       for (i = 0; i < build_id->size; ++i) {
>                 sprintf(bid, "%02x", *raw);
>                 ++raw;
>                 bid += 2;
> @@ -125,7 +126,7 @@ int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
>         if (ret < 0)
>                 return ret;
>
> -       return build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
> +       return build_id__sprintf(&bid, sbuild_id);
>  }
>
>  int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
> @@ -137,7 +138,7 @@ int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
>         if (ret < 0)
>                 return ret;
>
> -       return build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
> +       return build_id__sprintf(&bid, sbuild_id);
>  }
>
>  /* asnprintf consolidates asprintf and snprintf */
> @@ -270,7 +271,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>         if (!dso->has_build_id)
>                 return NULL;
>
> -       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
> +       build_id__sprintf(&dso->bid, sbuild_id);
>         linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
>         if (!linkname)
>                 return NULL;
> @@ -767,13 +768,13 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
>         return err;
>  }
>
> -static int build_id_cache__add_b(const u8 *build_id, size_t build_id_size,
> +static int build_id_cache__add_b(const struct build_id *bid,
>                                  const char *name, struct nsinfo *nsi,
>                                  bool is_kallsyms, bool is_vdso)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
>
> -       build_id__sprintf(build_id, build_id_size, sbuild_id);
> +       build_id__sprintf(bid, sbuild_id);
>
>         return build_id_cache__add_s(sbuild_id, name, nsi, is_kallsyms,
>                                      is_vdso);
> @@ -839,8 +840,8 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
>                 is_kallsyms = true;
>                 name = machine->mmap_name;
>         }
> -       return build_id_cache__add_b(dso->bid.data, sizeof(dso->bid.data), name,
> -                                    dso->nsinfo, is_kallsyms, is_vdso);
> +       return build_id_cache__add_b(&dso->bid, name, dso->nsinfo,
> +                                    is_kallsyms, is_vdso);
>  }
>
>  static int __dsos__cache_build_ids(struct list_head *head,
> @@ -900,3 +901,10 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
>
>         return ret;
>  }
> +
> +void build_id__init(struct build_id *bid, const u8 *data, size_t size)
> +{
> +       WARN_ON(size > BUILD_ID_SIZE);
> +       memcpy(bid->data, data, size);
> +       bid->size = size;
> +}
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index cc7fc62303ee..5e08e991defc 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -19,7 +19,8 @@ extern struct perf_tool build_id__mark_dso_hit_ops;
>  struct dso;
>  struct feat_fd;
>
> -int build_id__sprintf(const u8 *build_id, int len, char *bf);
> +void build_id__init(struct build_id *bid, const u8 *data, size_t size);
> +int build_id__sprintf(const struct build_id *build_id, char *bf);

Nit: perhaps bf should be on the left for consistency with regular sprintf.

>  int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
>  int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
>  char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e87fa9a71d9f..2f7f01ead9a1 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -172,9 +172,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
>                         break;
>                 }
>
> -               build_id__sprintf(dso->bid.data,
> -                                 sizeof(dso->bid.data),
> -                                 build_id_hex);
> +               build_id__sprintf(&dso->bid, build_id_hex);
>                 len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
>                 snprintf(filename + len, size - len, "%.2s/%s.debug",
>                          build_id_hex, build_id_hex + 2);
> @@ -1374,7 +1372,7 @@ size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
>
> -       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
> +       build_id__sprintf(&dso->bid, sbuild_id);
>         return fprintf(fp, "%s", sbuild_id);
>  }
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index cde8f6eba479..fe220f01fc94 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2095,8 +2095,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>                         free(m.name);
>                 }
>
> -               build_id__sprintf(dso->bid.data, sizeof(dso->bid.data),
> -                                 sbuild_id);
> +               build_id__sprintf(&dso->bid, sbuild_id);
>                 pr_debug("build id event received for %s: %s\n",
>                          dso->long_name, sbuild_id);
>                 dso__put(dso);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index d08540193822..596cc8e2c167 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -346,9 +346,7 @@ int map__load(struct map *map)
>                 if (map->dso->has_build_id) {
>                         char sbuild_id[SBUILD_ID_SIZE];
>
> -                       build_id__sprintf(map->dso->bid.data,
> -                                         sizeof(map->dso->bid.data),
> -                                         sbuild_id);
> +                       build_id__sprintf(&map->dso->bid, sbuild_id);
>                         pr_debug("%s with build id %s not found", name, sbuild_id);
>                 } else
>                         pr_debug("Failed to open %s", name);
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 2041ad849851..8eae2afff71a 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -473,7 +473,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
>         if (!c)
>                 return NULL;
>
> -       build_id__sprintf(dso->bid.data, BUILD_ID_SIZE, sbuild_id);
> +       build_id__sprintf(&dso->bid, sbuild_id);
>         fd = debuginfod_find_debuginfo(c, (const unsigned char *)sbuild_id,
>                                         0, &path);
>         if (fd >= 0)
> @@ -1005,6 +1005,7 @@ static int _show_one_line(FILE *fp, int l, bool skip, bool show_num)
>  static int __show_line_range(struct line_range *lr, const char *module,
>                              bool user)
>  {
> +       struct build_id bid;
>         int l = 1;
>         struct int_node *ln;
>         struct debuginfo *dinfo;
> @@ -1025,8 +1026,10 @@ static int __show_line_range(struct line_range *lr, const char *module,
>                 if (!ret)
>                         ret = debuginfo__find_line_range(dinfo, lr);
>         }
> -       if (dinfo->build_id)
> -               build_id__sprintf(dinfo->build_id, BUILD_ID_SIZE, sbuild_id);
> +       if (dinfo->build_id) {
> +               build_id__init(&bid, dinfo->build_id, BUILD_ID_SIZE);
> +               build_id__sprintf(&bid, sbuild_id);
> +       }
>         debuginfo__delete(dinfo);
>         if (ret == 0 || ret == -ENOENT) {
>                 pr_warning("Specified source line is not found.\n");
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 6eddf7be8293..2c4061035f77 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -949,6 +949,7 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
>  /* Find probe points from lazy pattern  */
>  static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
>  {
> +       struct build_id bid;
>         char sbuild_id[SBUILD_ID_SIZE] = "";
>         int ret = 0;
>         char *fpath;
> @@ -957,9 +958,10 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
>                 const char *comp_dir;
>
>                 comp_dir = cu_get_comp_dir(&pf->cu_die);
> -               if (pf->dbg->build_id)
> -                       build_id__sprintf(pf->dbg->build_id,
> -                                       BUILD_ID_SIZE, sbuild_id);
> +               if (pf->dbg->build_id) {
> +                       build_id__init(&bid, pf->dbg->build_id, BUILD_ID_SIZE);
> +                       build_id__sprintf(&bid, sbuild_id);
> +               }
>                 ret = find_source_path(pf->fname, sbuild_id, comp_dir, &fpath);
>                 if (ret < 0) {
>                         pr_warning("Failed to find source file path.\n");
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index db3b1c275d8f..7cbd024e3e63 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1064,7 +1064,7 @@ static int python_export_dso(struct db_export *dbe, struct dso *dso,
>         char sbuild_id[SBUILD_ID_SIZE];
>         PyObject *t;
>
> -       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
> +       build_id__sprintf(&dso->bid, sbuild_id);
>
>         t = tuple_new(5);
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dd1cf91c62fb..369cbad09f0d 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2152,7 +2152,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
>                         goto proc_kallsyms;
>         }
>
> -       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
> +       build_id__sprintf(&dso->bid, sbuild_id);
>
>         /* Find kallsyms in build-id cache with kcore */
>         scnprintf(path, sizeof(path), "%s/%s/%s",
> --
> 2.26.2
>
