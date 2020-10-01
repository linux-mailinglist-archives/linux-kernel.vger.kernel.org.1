Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7163427F8FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJAFRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:17:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73188C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:17:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t17so1586443wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFrAUmTYatLrpavp4EBxxKzt9hsLgWeFcSJ5beCm+mQ=;
        b=EmvhFDti8aIEIG3MemPFtNWKsSuUO+ZgRHg/rPNBaMwUwXM9hvn7Xb9MJwA0VXL2GO
         taZZfs7S6fkcZ/L4UR+Sxe6mMWqRhYalv4PhymzwWgK4RPHqcMkd+ap1CRujpTKOhUI5
         XGAU487DDbuHUwgrt2b1gotqAH4nXNzf1A29n8Ka+Gr51kQFSIc3g6pxz4HqUyQ73kh0
         E9ZFqBydYHeqqUt8krZKMRIb+3brCB6pOSO241ahHOkLGlNvGX5TBfxRQpOZ6E7mwE4J
         O0JdQh+FN368KF7Yv/pvVCT3/qQRW4L3PgH0noJe9YtdhMAbffq6bC+4ISI5QVZpw0IX
         5u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFrAUmTYatLrpavp4EBxxKzt9hsLgWeFcSJ5beCm+mQ=;
        b=tlja800sY3BdsQ0/5+sgGzSSIUn+iB+vww0X620Js/5tf/Pfx2xVeMDKDSJkQAkbqJ
         /4snvBoEoOh4gSrGUykq9d/OXXXo/tZi5pnG5AKqwpj4N989IJp2jMHiB5FieabuMp3I
         BAOz5arbSych10aJjlWky+8soEk9WKUEtX+BDYUfhrru3nyozztjF0L3BgMYTD+AN1dL
         ymxlJJoETjIttTHA2zy8swm6zpW4fdEEFtrinnNe3Z33cuUiGFhNmY5/of5MaB+E6J39
         gA1ZYxwV4oWi8Ux7z8HWpMTyZhMlUnvQ/MDrbL0zFtdrIaz3CZ4jb3R4o7ynBARbg4TH
         4Gvw==
X-Gm-Message-State: AOAM531JfNyKgeyuWadgaJPCy1Wjsk9axK7DwUkTXbQrNmcZrX51gGqH
        kLQA45nn8eBPKUMP7pjKzwZNShd1ItIGygkW2o5WfQ==
X-Google-Smtp-Source: ABdhPJxBcAs9CXOVqU3D1o3Jw2MvrR39zDGlkAcB6TGjGeMmtRSqb++dzhhzft2Kibu0hbZKL3i2Ab+FlZa2KOC9kAM=
X-Received: by 2002:a1c:7514:: with SMTP id o20mr6216687wmc.76.1601529458630;
 Wed, 30 Sep 2020 22:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-4-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-4-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:17:27 -0700
Message-ID: <CAP-5=fVcoNNnHAhA5XSS0iZWc_LufqZSyoePjR_wNOkuCtN_iA@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf tools: Pass build_id object to filename__read_build_id
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
> Passing build_id object to filename__read_build_id function,
> so it can populate the size of the build_id object.
>
> Changing filename__read_build_id code for both elf/non-elf
> code.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-buildid-cache.c | 25 +++++++++++-----------
>  tools/perf/builtin-inject.c        |  3 +--
>  tools/perf/tests/pe-file-parsing.c | 10 ++++-----
>  tools/perf/tests/sdt.c             |  6 +++---
>  tools/perf/util/build-id.c         |  8 +++----
>  tools/perf/util/dsos.c             |  3 +--
>  tools/perf/util/symbol-elf.c       | 16 ++++++++------
>  tools/perf/util/symbol-minimal.c   | 34 +++++++++++++++++-------------
>  tools/perf/util/symbol.c           |  6 +++---
>  tools/perf/util/symbol.h           |  3 ++-
>  10 files changed, 59 insertions(+), 55 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index a523c629f321..c3cb168d546d 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -174,19 +174,19 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
>  static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
> -       u8 build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         int err;
>         struct nscookie nsc;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       err = filename__read_build_id(filename, &build_id, sizeof(build_id));
> +       err = filename__read_build_id(filename, &bid);
>         nsinfo__mountns_exit(&nsc);
>         if (err < 0) {
>                 pr_debug("Couldn't read a build-id in %s\n", filename);
>                 return -1;
>         }
>
> -       build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
> +       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
>         err = build_id_cache__add_s(sbuild_id, filename, nsi,
>                                     false, false);
>         pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
> @@ -196,21 +196,21 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>
>  static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
>  {
> -       u8 build_id[BUILD_ID_SIZE];
>         char sbuild_id[SBUILD_ID_SIZE];
> +       struct build_id bid;
>         struct nscookie nsc;
>
>         int err;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       err = filename__read_build_id(filename, &build_id, sizeof(build_id));
> +       err = filename__read_build_id(filename, &bid);
>         nsinfo__mountns_exit(&nsc);
>         if (err < 0) {
>                 pr_debug("Couldn't read a build-id in %s\n", filename);
>                 return -1;
>         }
>
> -       build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
> +       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
>         err = build_id_cache__remove_s(sbuild_id);
>         pr_debug("Removing %s %s: %s\n", sbuild_id, filename,
>                  err ? "FAIL" : "Ok");
> @@ -274,17 +274,16 @@ static int build_id_cache__purge_all(void)
>  static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>  {
>         char filename[PATH_MAX];
> -       u8 build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>
>         if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
> -           filename__read_build_id(filename, build_id,
> -                                   sizeof(build_id)) != sizeof(build_id)) {
> +           filename__read_build_id(filename, &bid) == -1) {
>                 if (errno == ENOENT)
>                         return false;
>
>                 pr_warning("Problems with %s file, consider removing it from the cache\n",
>                            filename);
> -       } else if (memcmp(dso->bid.data, build_id, sizeof(dso->bid.data))) {
> +       } else if (memcmp(dso->bid.data, bid.data, bid.size)) {
>                 pr_warning("Problems with %s file, consider removing it from the cache\n",
>                            filename);
>         }
> @@ -300,14 +299,14 @@ static int build_id_cache__fprintf_missing(struct perf_session *session, FILE *f
>
>  static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
>  {
> -       u8 build_id[BUILD_ID_SIZE];
>         char sbuild_id[SBUILD_ID_SIZE];
> +       struct build_id bid;
>         struct nscookie nsc;
>
>         int err;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       err = filename__read_build_id(filename, &build_id, sizeof(build_id));
> +       err = filename__read_build_id(filename, &bid);
>         nsinfo__mountns_exit(&nsc);
>         if (err < 0) {
>                 pr_debug("Couldn't read a build-id in %s\n", filename);
> @@ -315,7 +314,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
>         }
>         err = 0;
>
> -       build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
> +       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
>         if (build_id_cache__cached(sbuild_id))
>                 err = build_id_cache__remove_s(sbuild_id);
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5cf32d8e3aa6..a7a5ac5ea9d5 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -408,8 +408,7 @@ static int dso__read_build_id(struct dso *dso)
>         if (dso->has_build_id)
>                 return 0;
>
> -       if (filename__read_build_id(dso->long_name, dso->bid.data,
> -                                   sizeof(dso->bid.data)) > 0) {
> +       if (filename__read_build_id(dso->long_name, &dso->bid) > 0) {
>                 dso->has_build_id = true;
>                 return 0;
>         }
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> index 19eae3e8e229..58b90c42eb38 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -24,7 +24,7 @@ static int run_dir(const char *d)
>  {
>         char filename[PATH_MAX];
>         char debugfile[PATH_MAX];
> -       char build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         char debuglink[PATH_MAX];
>         char expect_build_id[] = {
>                 0x5a, 0x0f, 0xd8, 0x82, 0xb5, 0x30, 0x84, 0x22,
> @@ -36,10 +36,10 @@ static int run_dir(const char *d)
>         int ret;
>
>         scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
> -       ret = filename__read_build_id(filename, build_id, BUILD_ID_SIZE);
> +       ret = filename__read_build_id(filename, &bid);
>         TEST_ASSERT_VAL("Failed to read build_id",
>                         ret == sizeof(expect_build_id));
> -       TEST_ASSERT_VAL("Wrong build_id", !memcmp(build_id, expect_build_id,
> +       TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
>                                                   sizeof(expect_build_id)));
>
>         ret = filename__read_debuglink(filename, debuglink, PATH_MAX);
> @@ -48,10 +48,10 @@ static int run_dir(const char *d)
>                         !strcmp(debuglink, expect_debuglink));
>
>         scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
> -       ret = filename__read_build_id(debugfile, build_id, BUILD_ID_SIZE);
> +       ret = filename__read_build_id(debugfile, &bid);
>         TEST_ASSERT_VAL("Failed to read debug file build_id",
>                         ret == sizeof(expect_build_id));
> -       TEST_ASSERT_VAL("Wrong build_id", !memcmp(build_id, expect_build_id,
> +       TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
>                                                   sizeof(expect_build_id)));
>
>         dso = dso__new(filename);
> diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
> index 60f0e9ee04fb..3ef37f739203 100644
> --- a/tools/perf/tests/sdt.c
> +++ b/tools/perf/tests/sdt.c
> @@ -28,16 +28,16 @@ static int target_function(void)
>  static int build_id_cache__add_file(const char *filename)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
> -       u8 build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         int err;
>
> -       err = filename__read_build_id(filename, &build_id, sizeof(build_id));
> +       err = filename__read_build_id(filename, &bid);
>         if (err < 0) {
>                 pr_debug("Failed to read build id of %s\n", filename);
>                 return err;
>         }
>
> -       build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
> +       build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
>         err = build_id_cache__add_s(sbuild_id, filename, NULL, false, false);
>         if (err < 0)
>                 pr_debug("Failed to add build id cache of %s\n", filename);
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 7da13ddb0d50..62b258aaa128 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -130,16 +130,14 @@ int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
>
>  int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
>  {
> -       u8 build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         int ret;
>
> -       ret = filename__read_build_id(pathname, build_id, sizeof(build_id));
> +       ret = filename__read_build_id(pathname, &bid);
>         if (ret < 0)
>                 return ret;
> -       else if (ret != sizeof(build_id))
> -               return -EINVAL;
>
> -       return build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
> +       return build_id__sprintf(bid.data, sizeof(bid.data), sbuild_id);
>  }
>
>  /* asnprintf consolidates asprintf and snprintf */
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index e3af46e818f1..87161e431830 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -73,8 +73,7 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
>                         continue;
>                 }
>                 nsinfo__mountns_enter(pos->nsinfo, &nsc);
> -               if (filename__read_build_id(pos->long_name, pos->bid.data,
> -                                           sizeof(pos->bid.data)) > 0) {
> +               if (filename__read_build_id(pos->long_name, &pos->bid) > 0) {
>                         have_build_id     = true;
>                         pos->has_build_id = true;
>                 }
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 94a156df22d5..61d7c444e6f5 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -534,8 +534,9 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>
>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>
> -int filename__read_build_id(const char *filename, void *bf, size_t size)
> +int filename__read_build_id(const char *filename, struct build_id *bid)
>  {
> +       size_t size = sizeof(bid->data);
>         int err = -1;
>         bfd *abfd;
>
> @@ -551,9 +552,9 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>         if (!abfd->build_id || abfd->build_id->size > size)
>                 goto out_close;
>
> -       memcpy(bf, abfd->build_id->data, abfd->build_id->size);
> -       memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
> -       err = abfd->build_id->size;
> +       memcpy(bid->data, abfd->build_id->data, abfd->build_id->size);
> +       memset(bid->data + abfd->build_id->size, 0, size - abfd->build_id->size);
> +       err = bid->size = abfd->build_id->size;
>
>  out_close:
>         bfd_close(abfd);
> @@ -562,8 +563,9 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>
>  #else // HAVE_LIBBFD_BUILDID_SUPPORT
>
> -int filename__read_build_id(const char *filename, void *bf, size_t size)
> +int filename__read_build_id(const char *filename, struct build_id *bid)
>  {
> +       size_t size = sizeof(bid->data);
>         int fd, err = -1;
>         Elf *elf;
>
> @@ -580,7 +582,9 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>                 goto out_close;
>         }
>
> -       err = elf_read_build_id(elf, bf, size);
> +       err = elf_read_build_id(elf, bid->data, size);
> +       if (err > 0)
> +               bid->size = err;
>
>         elf_end(elf);
>  out_close:
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index d6e99af263ec..5173331ee6e4 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -31,9 +31,10 @@ static bool check_need_swap(int file_endian)
>
>  #define NT_GNU_BUILD_ID        3
>
> -static int read_build_id(void *note_data, size_t note_len, void *bf,
> -                        size_t size, bool need_swap)
> +static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
> +                        bool need_swap)
>  {
> +       size_t size = sizeof(bid->data);
>         struct {
>                 u32 n_namesz;
>                 u32 n_descsz;
> @@ -63,8 +64,9 @@ static int read_build_id(void *note_data, size_t note_len, void *bf,
>                     nhdr->n_namesz == sizeof("GNU")) {
>                         if (memcmp(name, "GNU", sizeof("GNU")) == 0) {
>                                 size_t sz = min(size, descsz);
> -                               memcpy(bf, ptr, sz);
> -                               memset(bf + sz, 0, size - sz);
> +                               memcpy(bid->data, ptr, sz);
> +                               memset(bid->data + sz, 0, size - sz);
> +                               bid->size = sz;
>                                 return 0;
>                         }
>                 }
> @@ -84,7 +86,7 @@ int filename__read_debuglink(const char *filename __maybe_unused,
>  /*
>   * Just try PT_NOTE header otherwise fails
>   */
> -int filename__read_build_id(const char *filename, void *bf, size_t size)
> +int filename__read_build_id(const char *filename, struct build_id *bid)
>  {
>         FILE *fp;
>         int ret = -1;
> @@ -156,9 +158,9 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>                         if (fread(buf, buf_size, 1, fp) != 1)
>                                 goto out_free;
>
> -                       ret = read_build_id(buf, buf_size, bf, size, need_swap);
> +                       ret = read_build_id(buf, buf_size, bid, need_swap);
>                         if (ret == 0)
> -                               ret = size;
> +                               ret = bid->size;
>                         break;
>                 }
>         } else {
> @@ -207,9 +209,9 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>                         if (fread(buf, buf_size, 1, fp) != 1)
>                                 goto out_free;
>
> -                       ret = read_build_id(buf, buf_size, bf, size, need_swap);
> +                       ret = read_build_id(buf, buf_size, bid, need_swap);
>                         if (ret == 0)
> -                               ret = size;
> +                               ret = bid->size;
>                         break;
>                 }
>         }
> @@ -220,8 +222,9 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>         return ret;
>  }
>
> -int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
> +int sysfs__read_build_id(const char *filename, void *build_id, size_t size __maybe_unused)
>  {
> +       struct build_id bid;
>         int fd;
>         int ret = -1;
>         struct stat stbuf;
> @@ -243,7 +246,9 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
>         if (read(fd, buf, buf_size) != (ssize_t) buf_size)
>                 goto out_free;
>
> -       ret = read_build_id(buf, buf_size, build_id, size, false);
> +       ret = read_build_id(buf, buf_size, &bid, false);
> +       if (ret > 0)
> +               memcpy(build_id, bid.data, bid.size);
>  out_free:
>         free(buf);
>  out:
> @@ -339,16 +344,15 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
>                   struct symsrc *runtime_ss __maybe_unused,
>                   int kmodule __maybe_unused)
>  {
> -       unsigned char build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         int ret;
>
>         ret = fd__is_64_bit(ss->fd);
>         if (ret >= 0)
>                 dso->is_64_bit = ret;
>
> -       if (filename__read_build_id(ss->name, build_id, BUILD_ID_SIZE) > 0) {
> -               dso__set_build_id(dso, build_id);
> -       }
> +       if (filename__read_build_id(ss->name, &bid) > 0)
> +               dso__set_build_id(dso, bid.data);
>         return 0;
>  }
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index c772c8c70db5..4c43bb959fee 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1755,7 +1755,7 @@ int dso__load(struct dso *dso, struct map *map)
>         struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
>         bool kmod;
>         bool perfmap;
> -       unsigned char build_id[BUILD_ID_SIZE];
> +       struct build_id bid;
>         struct nscookie nsc;
>         char newmapname[PATH_MAX];
>         const char *map_path = dso->long_name;
> @@ -1817,8 +1817,8 @@ int dso__load(struct dso *dso, struct map *map)
>         if (!dso->has_build_id &&
>             is_regular_file(dso->long_name)) {
>             __symbol__join_symfs(name, PATH_MAX, dso->long_name);
> -           if (filename__read_build_id(name, build_id, BUILD_ID_SIZE) > 0)
> -               dso__set_build_id(dso, build_id);
> +               if (filename__read_build_id(name, &bid) > 0)
> +                       dso__set_build_id(dso, bid.data);
>         }
>
>         /*
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 11fe71f46d14..98908fa3f796 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -23,6 +23,7 @@ struct dso;
>  struct map;
>  struct maps;
>  struct option;
> +struct build_id;
>
>  /*
>   * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
> @@ -142,7 +143,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
>
>  enum dso_type dso__type_fd(int fd);
>
> -int filename__read_build_id(const char *filename, void *bf, size_t size);
> +int filename__read_build_id(const char *filename, struct build_id *id);
>  int sysfs__read_build_id(const char *filename, void *bf, size_t size);
>  int modules__parse(const char *filename, void *arg,
>                    int (*process_module)(void *arg, const char *name,
> --
> 2.26.2
>
