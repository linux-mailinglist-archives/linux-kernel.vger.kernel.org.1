Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261BB27F901
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJAFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:20:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:20:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1611995wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqZcaCqA0t/uN/EJBhAzye1QaTnwtgmMTYWVdPqkaQM=;
        b=pynoYcdTvK7iO1cU7nNU2+SBkhLSLmHzZstiMx+SYXP8iIbDsinRUlOrNOEtOIfAMB
         vAiH8OIy6mG4zNGsogv/gcpcQj0sZoOiUX92UP9w3PINEvoyOTtLJwamBRwUA6hzK9am
         HuXhaEtmtJGjl77xGXUYLN7j/G87hukgJxwrTvKD8wk1IvXbxNqpH6TD1nSJXeD8bBys
         cO25gsx/mAlnk131Rd4+aiqPyTtlFJJAzWbjpAge5w2/KDoGXwNn54H6LIiDFYqvP/Yy
         a4mfSYjx45zm3TJGk0Ebrhe5u1taQ+b2Wj+UNGTuh4ceexpyYXFe7Dp6RwMXys9/RmlV
         ARaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqZcaCqA0t/uN/EJBhAzye1QaTnwtgmMTYWVdPqkaQM=;
        b=UrrmVKEViEm9qyr1jgHs7l6h8c6PjUaOTZZdo1UMm6IKM5bM5AeE9KqVEsuPtmXEu3
         iVOkCjJmmM6ovkoQ6EhhR83bykknpZY8Dekg+0actLBF95xM7evsMfqRVkxC4CwECR8v
         6/qWFY1uEKubC4649vsUr3WvITd7BakuwuMm4WPzqHJmA4fnTS2fMYuijqhyRGWffT/9
         VvwOFpiGA/x4daE3qA+/nV3wNgkevi18eDS38TQYrkxRGHegFPh6jqboNF6iSzJ2Q5QY
         I+xrhXlUmgA43r0Y6Y4SpR2Lxuv0uRygh0s3dT0Dexzc3RBmWrcQ2NgNMHks3ZErgDxd
         Ao8Q==
X-Gm-Message-State: AOAM530N8Zs7y0MsAzSTpxC/FzQnM1m8k8YFGnxihtqXoWbrxUWhgyof
        9gE6PYFBh9NZr3lbMFfvbXWyaGx5f5+/bVbgzmqRBQ==
X-Google-Smtp-Source: ABdhPJyvyvAPc4pZu0ebWwcpLIpN3+93PUOwZ0ZbKXixZ8x+BuCdYRvtrKyrT38qF2HNrrOKkHHGpD4Ia79eSTuBs/Y=
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr6309048wmg.58.1601529635233;
 Wed, 30 Sep 2020 22:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-5-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-5-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:20:24 -0700
Message-ID: <CAP-5=fW=pCkg_qDj3beOCtyonk0bWsUR1WwgGiksRh5aQpRpxQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Pass build id object to sysfs__read_build_id
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
> Passing build id object to sysfs__read_build_id function,
> so it can populate the size of the build_id object.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/build-id.c       |  6 +++---
>  tools/perf/util/dso.c            |  6 ++----
>  tools/perf/util/symbol-elf.c     | 11 +++++------
>  tools/perf/util/symbol-minimal.c |  7 ++-----
>  tools/perf/util/symbol.c         |  7 +++----
>  tools/perf/util/symbol.h         |  2 +-
>  6 files changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 62b258aaa128..1c332e78bbc3 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -113,7 +113,7 @@ int build_id__sprintf(const u8 *build_id, int len, char *bf)
>  int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
>  {
>         char notes[PATH_MAX];
> -       u8 build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         int ret;
>
>         if (!root_dir)
> @@ -121,11 +121,11 @@ int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
>
>         scnprintf(notes, sizeof(notes), "%s/sys/kernel/notes", root_dir);
>
> -       ret = sysfs__read_build_id(notes, build_id, sizeof(build_id));
> +       ret = sysfs__read_build_id(notes, &bid);
>         if (ret < 0)
>                 return ret;
>
> -       return build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
> +       return build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
>  }
>
>  int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index d2c1ed08c879..e87fa9a71d9f 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1346,8 +1346,7 @@ void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
>         if (machine__is_default_guest(machine))
>                 return;
>         sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
> -       if (sysfs__read_build_id(path, dso->bid.data,
> -                                sizeof(dso->bid.data)) == 0)
> +       if (sysfs__read_build_id(path, &dso->bid) == 0)
>                 dso->has_build_id = true;
>  }
>
> @@ -1365,8 +1364,7 @@ int dso__kernel_module_get_build_id(struct dso *dso,
>                  "%s/sys/module/%.*s/notes/.note.gnu.build-id",
>                  root_dir, (int)strlen(name) - 1, name);
>
> -       if (sysfs__read_build_id(filename, dso->bid.data,
> -                                sizeof(dso->bid.data)) == 0)
> +       if (sysfs__read_build_id(filename, &dso->bid) == 0)
>                 dso->has_build_id = true;
>
>         return 0;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 61d7c444e6f5..97a55f162ea5 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -595,13 +595,11 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>
>  #endif // HAVE_LIBBFD_BUILDID_SUPPORT
>
> -int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
> +int sysfs__read_build_id(const char *filename, struct build_id *bid)
>  {
> +       size_t size = sizeof(bid->data);
>         int fd, err = -1;
>
> -       if (size < BUILD_ID_SIZE)
> -               goto out;
> -
>         fd = open(filename, O_RDONLY);
>         if (fd < 0)
>                 goto out;
> @@ -622,8 +620,9 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
>                                 break;
>                         if (memcmp(bf, "GNU", sizeof("GNU")) == 0) {
>                                 size_t sz = min(descsz, size);
> -                               if (read(fd, build_id, sz) == (ssize_t)sz) {
> -                                       memset(build_id + sz, 0, size - sz);
> +                               if (read(fd, bid->data, sz) == (ssize_t)sz) {
> +                                       memset(bid->data + sz, 0, size - sz);
> +                                       bid->size = sz;
>                                         err = 0;
>                                         break;
>                                 }
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index 5173331ee6e4..dba6b9e5d64e 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -222,9 +222,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>         return ret;
>  }
>
> -int sysfs__read_build_id(const char *filename, void *build_id, size_t size __maybe_unused)
> +int sysfs__read_build_id(const char *filename, struct build_id *bid)
>  {
> -       struct build_id bid;
>         int fd;
>         int ret = -1;
>         struct stat stbuf;
> @@ -246,9 +245,7 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size __may
>         if (read(fd, buf, buf_size) != (ssize_t) buf_size)
>                 goto out_free;
>
> -       ret = read_build_id(buf, buf_size, &bid, false);
> -       if (ret > 0)
> -               memcpy(build_id, bid.data, bid.size);
> +       ret = read_build_id(buf, buf_size, bid, false);
>  out_free:
>         free(buf);
>  out:
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4c43bb959fee..dd1cf91c62fb 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2122,7 +2122,7 @@ static bool filename__readable(const char *file)
>
>  static char *dso__find_kallsyms(struct dso *dso, struct map *map)
>  {
> -       u8 host_build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         char sbuild_id[SBUILD_ID_SIZE];
>         bool is_host = false;
>         char path[PATH_MAX];
> @@ -2135,9 +2135,8 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
>                 goto proc_kallsyms;
>         }
>
> -       if (sysfs__read_build_id("/sys/kernel/notes", host_build_id,
> -                                sizeof(host_build_id)) == 0)
> -               is_host = dso__build_id_equal(dso, host_build_id);
> +       if (sysfs__read_build_id("/sys/kernel/notes", &bid) == 0)
> +               is_host = dso__build_id_equal(dso, bid.data);
>
>         /* Try a fast path for /proc/kallsyms if possible */
>         if (is_host) {
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 98908fa3f796..70b3874e7dd8 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -144,7 +144,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
>  enum dso_type dso__type_fd(int fd);
>
>  int filename__read_build_id(const char *filename, struct build_id *id);
> -int sysfs__read_build_id(const char *filename, void *bf, size_t size);
> +int sysfs__read_build_id(const char *filename, struct build_id *bid);
>  int modules__parse(const char *filename, void *arg,
>                    int (*process_module)(void *arg, const char *name,
>                                          u64 start, u64 size));
> --
> 2.26.2
>
