Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA327F7A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgJACBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJACBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:01:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54698C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:01:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so3801498wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9we8JpyXBXF/Mr+MHEYTKP2fl2+RV6UE9t25npFpck=;
        b=UiHWm1rAZKUD1FwFuUvV4wbYfsrzYIZwu6QWdQYXVf6jv2BMUnXHUfhaU6tA6L5fvh
         /SFjvChAlmjkeanyP1ZhEMSXdUFWAi0Kqo5z9tk0Pr7szIzTnANIvgVpyhjn3o0anwmr
         uhN2zx4n+h8e/rCPt8JyO/hJtw0pR7nABgcV0+KJgxFPnJz/PhiUVMOxjrnLKkfKTwYr
         4m2OPY26wdHii9HFVx1drLDMj6Uc+AOMww3j7NWxZ8sad64x+DPn0DVRQplpv4YTteuS
         K8rg0DT+yvOhGTmlK4mOdO9SbgTkjzK1deFxajtQv0wX8cPetw3QabCR8pZFCFvHq1eb
         LfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9we8JpyXBXF/Mr+MHEYTKP2fl2+RV6UE9t25npFpck=;
        b=IbelcBXgn4KgICie6aCiIOf/TD2uumxlFuYhFA31KKJ/ll2v1o0WSwp+mfNd9VCqnU
         37OlMyow9+Jj6qiyztKfRi5yQ+J1Yt9k5mM+GMpbxRu/o+gpjmvt2c6vsO7HQRA2gMJj
         sj2my1K8NUOdo72E2XyR5FT4eyZh91wOpVxLt/dtOX6w3Di0gjvUp8CfhLopvw0g67bW
         QjCu/pacaETut/yVIh7JSGamdvqy7k1HfJeyb/fI5yxuj6uBuvkdLAuqXxFlwO6rW0+1
         MzYq8XBR46vYQy5Uk2IxZzBBCN6g9ckGhS4mQIediyLfVLCzr4IqR0i44vSBcByDMH/y
         aUPw==
X-Gm-Message-State: AOAM533OF3ijZMTWMLduZoXEpicP1kBQXULATwtfsl09sTYKkz+JycvV
        8ajgrp7ExnnzVbCIqgZy3Jz1iaNNz/7SnMYImNc7bWksJaQ=
X-Google-Smtp-Source: ABdhPJw2s1skDsaeWHO2UQwq1X5nIr4k0nWjK+VZaCvWlrKTXHDcg45G1DWpoq0AMJ4fYSm1OeOoHyck3HihyLLD8sQ=
X-Received: by 2002:a5d:5583:: with SMTP id i3mr5809423wrv.119.1601517693654;
 Wed, 30 Sep 2020 19:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-3-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-3-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 19:01:22 -0700
Message-ID: <CAP-5=fUi0KGyxFbPYUrs9tFwvkG1ZXBu6rfsDcY=ea3j_Vh86Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf tools: Use build_id object in dso
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
> Replace build_id byte array with struct build_id
> object and all the code that references it.
>
> The objective is to carry size together with build
> id array, so it's better to keep both together.
>
> This is preparatory change for following patches,
> and there's no functional change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

This reads a little funny but makes sense in the context of the rest
of the patch set.

Thanks,
Ian

> ---
>  tools/perf/builtin-buildid-cache.c             |  2 +-
>  tools/perf/builtin-inject.c                    |  4 ++--
>  tools/perf/util/annotate.c                     |  4 ++--
>  tools/perf/util/build-id.c                     |  6 +++---
>  tools/perf/util/build-id.h                     |  5 +++++
>  tools/perf/util/dso.c                          | 18 +++++++++---------
>  tools/perf/util/dso.h                          |  2 +-
>  tools/perf/util/dsos.c                         |  4 ++--
>  tools/perf/util/header.c                       |  2 +-
>  tools/perf/util/map.c                          |  4 ++--
>  tools/perf/util/probe-event.c                  |  2 +-
>  .../scripting-engines/trace-event-python.c     |  2 +-
>  tools/perf/util/symbol.c                       |  2 +-
>  tools/perf/util/synthetic-events.c             |  2 +-
>  14 files changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index 39efa51d7fb3..a523c629f321 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -284,7 +284,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>
>                 pr_warning("Problems with %s file, consider removing it from the cache\n",
>                            filename);
> -       } else if (memcmp(dso->build_id, build_id, sizeof(dso->build_id))) {
> +       } else if (memcmp(dso->bid.data, build_id, sizeof(dso->bid.data))) {
>                 pr_warning("Problems with %s file, consider removing it from the cache\n",
>                            filename);
>         }
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6d2f410d773a..5cf32d8e3aa6 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -408,8 +408,8 @@ static int dso__read_build_id(struct dso *dso)
>         if (dso->has_build_id)
>                 return 0;
>
> -       if (filename__read_build_id(dso->long_name, dso->build_id,
> -                                   sizeof(dso->build_id)) > 0) {
> +       if (filename__read_build_id(dso->long_name, dso->bid.data,
> +                                   sizeof(dso->bid.data)) > 0) {
>                 dso->has_build_id = true;
>                 return 0;
>         }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index fc17af7ba845..a016e1bd7b8d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1578,8 +1578,8 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
>                 char *build_id_msg = NULL;
>
>                 if (dso->has_build_id) {
> -                       build_id__sprintf(dso->build_id,
> -                                         sizeof(dso->build_id), bf + 15);
> +                       build_id__sprintf(dso->bid.data,
> +                                         sizeof(dso->bid.data), bf + 15);
>                         build_id_msg = bf;
>                 }
>                 scnprintf(buf, buflen,
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 31207b6e2066..7da13ddb0d50 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -272,7 +272,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>         if (!dso->has_build_id)
>                 return NULL;
>
> -       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> +       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
>         linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
>         if (!linkname)
>                 return NULL;
> @@ -355,7 +355,7 @@ static int machine__write_buildid_table(struct machine *machine,
>                 in_kernel = pos->kernel ||
>                                 is_kernel_module(name,
>                                         PERF_RECORD_MISC_CPUMODE_UNKNOWN);
> -               err = write_buildid(name, name_len, pos->build_id, machine->pid,
> +               err = write_buildid(name, name_len, pos->bid.data, machine->pid,
>                                     in_kernel ? kmisc : umisc, fd);
>                 if (err)
>                         break;
> @@ -841,7 +841,7 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
>                 is_kallsyms = true;
>                 name = machine->mmap_name;
>         }
> -       return build_id_cache__add_b(dso->build_id, sizeof(dso->build_id), name,
> +       return build_id_cache__add_b(dso->bid.data, sizeof(dso->bid.data), name,
>                                      dso->nsinfo, is_kallsyms, is_vdso);
>  }
>
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index aad419bb165c..cc7fc62303ee 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -8,6 +8,11 @@
>  #include "tool.h"
>  #include <linux/types.h>
>
> +struct build_id {
> +       u8      data[BUILD_ID_SIZE];
> +       size_t  size;
> +};
> +
>  struct nsinfo;
>
>  extern struct perf_tool build_id__mark_dso_hit_ops;
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5a3b4755f0b3..d2c1ed08c879 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -172,8 +172,8 @@ int dso__read_binary_type_filename(const struct dso *dso,
>                         break;
>                 }
>
> -               build_id__sprintf(dso->build_id,
> -                                 sizeof(dso->build_id),
> +               build_id__sprintf(dso->bid.data,
> +                                 sizeof(dso->bid.data),
>                                   build_id_hex);
>                 len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
>                 snprintf(filename + len, size - len, "%.2s/%s.debug",
> @@ -1330,13 +1330,13 @@ void dso__put(struct dso *dso)
>
>  void dso__set_build_id(struct dso *dso, void *build_id)
>  {
> -       memcpy(dso->build_id, build_id, sizeof(dso->build_id));
> +       memcpy(dso->bid.data, build_id, sizeof(dso->bid.data));
>         dso->has_build_id = 1;
>  }
>
>  bool dso__build_id_equal(const struct dso *dso, u8 *build_id)
>  {
> -       return memcmp(dso->build_id, build_id, sizeof(dso->build_id)) == 0;
> +       return memcmp(dso->bid.data, build_id, sizeof(dso->bid.data)) == 0;
>  }
>
>  void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
> @@ -1346,8 +1346,8 @@ void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
>         if (machine__is_default_guest(machine))
>                 return;
>         sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
> -       if (sysfs__read_build_id(path, dso->build_id,
> -                                sizeof(dso->build_id)) == 0)
> +       if (sysfs__read_build_id(path, dso->bid.data,
> +                                sizeof(dso->bid.data)) == 0)
>                 dso->has_build_id = true;
>  }
>
> @@ -1365,8 +1365,8 @@ int dso__kernel_module_get_build_id(struct dso *dso,
>                  "%s/sys/module/%.*s/notes/.note.gnu.build-id",
>                  root_dir, (int)strlen(name) - 1, name);
>
> -       if (sysfs__read_build_id(filename, dso->build_id,
> -                                sizeof(dso->build_id)) == 0)
> +       if (sysfs__read_build_id(filename, dso->bid.data,
> +                                sizeof(dso->bid.data)) == 0)
>                 dso->has_build_id = true;
>
>         return 0;
> @@ -1376,7 +1376,7 @@ size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
>
> -       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> +       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
>         return fprintf(fp, "%s", sbuild_id);
>  }
>
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 8ad17f395a19..eac004210b47 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -176,7 +176,7 @@ struct dso {
>         bool             sorted_by_name;
>         bool             loaded;
>         u8               rel;
> -       u8               build_id[BUILD_ID_SIZE];
> +       struct build_id  bid;
>         u64              text_offset;
>         const char       *short_name;
>         const char       *long_name;
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 939471731ea6..e3af46e818f1 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -73,8 +73,8 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
>                         continue;
>                 }
>                 nsinfo__mountns_enter(pos->nsinfo, &nsc);
> -               if (filename__read_build_id(pos->long_name, pos->build_id,
> -                                           sizeof(pos->build_id)) > 0) {
> +               if (filename__read_build_id(pos->long_name, pos->bid.data,
> +                                           sizeof(pos->bid.data)) > 0) {
>                         have_build_id     = true;
>                         pos->has_build_id = true;
>                 }
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9cf4efdcbbbd..cde8f6eba479 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2095,7 +2095,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>                         free(m.name);
>                 }
>
> -               build_id__sprintf(dso->build_id, sizeof(dso->build_id),
> +               build_id__sprintf(dso->bid.data, sizeof(dso->bid.data),
>                                   sbuild_id);
>                 pr_debug("build id event received for %s: %s\n",
>                          dso->long_name, sbuild_id);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index cc0faf8f1321..d08540193822 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -346,8 +346,8 @@ int map__load(struct map *map)
>                 if (map->dso->has_build_id) {
>                         char sbuild_id[SBUILD_ID_SIZE];
>
> -                       build_id__sprintf(map->dso->build_id,
> -                                         sizeof(map->dso->build_id),
> +                       build_id__sprintf(map->dso->bid.data,
> +                                         sizeof(map->dso->bid.data),
>                                           sbuild_id);
>                         pr_debug("%s with build id %s not found", name, sbuild_id);
>                 } else
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 3a1b58a92673..2041ad849851 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -473,7 +473,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
>         if (!c)
>                 return NULL;
>
> -       build_id__sprintf(dso->build_id, BUILD_ID_SIZE, sbuild_id);
> +       build_id__sprintf(dso->bid.data, BUILD_ID_SIZE, sbuild_id);
>         fd = debuginfod_find_debuginfo(c, (const unsigned char *)sbuild_id,
>                                         0, &path);
>         if (fd >= 0)
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 739516fdf6e3..db3b1c275d8f 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1064,7 +1064,7 @@ static int python_export_dso(struct db_export *dbe, struct dso *dso,
>         char sbuild_id[SBUILD_ID_SIZE];
>         PyObject *t;
>
> -       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> +       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
>
>         t = tuple_new(5);
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5ddf76fb691c..c772c8c70db5 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2153,7 +2153,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
>                         goto proc_kallsyms;
>         }
>
> -       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> +       build_id__sprintf(dso->bid.data, sizeof(dso->bid.data), sbuild_id);
>
>         /* Find kallsyms in build-id cache with kcore */
>         scnprintf(path, sizeof(path), "%s/%s/%s",
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 3ca5d9399680..8a23391558cf 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1961,7 +1961,7 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
>
>         len = pos->long_name_len + 1;
>         len = PERF_ALIGN(len, NAME_ALIGN);
> -       memcpy(&ev.build_id.build_id, pos->build_id, sizeof(pos->build_id));
> +       memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
>         ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
>         ev.build_id.header.misc = misc;
>         ev.build_id.pid = machine->pid;
> --
> 2.26.2
>
