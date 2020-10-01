Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7427F90D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJAFcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:32:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14157C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:32:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so1411021wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXLNt1HM/rpSQJlqYVshAKj+ovYp4BRi6qSvoua5+XU=;
        b=CQz2x6FdUV3I2nS3AU1vSN4zyF/eEjw2A6KvOYIidHB3dKZJ/9DN/oglyI0aL8TkS+
         fSsYh0SgJD9kK2xlEzIMW7CTbVnxEsan54EWAXU7v52j2go9ikr7xuDEjHrK+188VIUZ
         sX2KF5W7iiCs7JGrtFE8lJsNDbMGvweF6mrHlD2nI+DNSqY6ZEjMp413vGcsTLGY2Ho0
         Med7Rer7awVE8tLpmChm4yFD+pW8F86tl5lN9+yjDWulwOSOmqLC2ZLrXKDlo01cliIl
         hmTe9N+lAloqDOnfCzEen4EKQS0jc3l6rqLGiFkaH9ZlPba6O+Wv52h0+m8Yshj6MR8g
         8yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXLNt1HM/rpSQJlqYVshAKj+ovYp4BRi6qSvoua5+XU=;
        b=f35YS90OobFqLtD8JcjhuBeYcktzHUH6iZ6Tyfdqf8wpcxWkQ2Ac1m06qLaUSjmJRy
         fh4/i9Q78GZqaswEMV2B0lxRPs/qiUCjAExPeL73VPVjX4LcqSGkqwsYWzYJGplVrktx
         T9KoUZ38hjTQAwdTdPOwv9DzKA83iggUOew2Hkr3XB3mRWfa8HRvV1VygLRWBoGjrV19
         yYZjmdh1komzyq2/ZmAqmUvVmD3Rqu9/LRPuHa6FLFVsBMLo7aBHVUpKLUQqwuvXt+AC
         i3rnxHGcoq4n9nFPVrVomf6Md/ZNG9SFVHWhF5ugclt/U15lAswfDWh9rVav62jnYD5k
         cGFQ==
X-Gm-Message-State: AOAM531HresSzwjuV6PpiCk8vr9D6+yiAin7XEAkZaTkcWCfcyguGkvk
        cJMKGHVjK5OuVJdqIXTmnBHV8xTnke8ueqEeDumtjQ==
X-Google-Smtp-Source: ABdhPJz+54sywrWA6JpnPPhYnZmqjOvWpP1fufZassx2CvFe9sPlwXXB1I6BNRIh3ojYOez/I6jaWWWCofxGmJV1Wqw=
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr6385669wmj.124.1601530318496;
 Wed, 30 Sep 2020 22:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-9-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-9-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 22:31:47 -0700
Message-ID: <CAP-5=fV77-=o4GkX4eGo83TMKjAWQskvLukfgksyjRyey3d9ag@mail.gmail.com>
Subject: Re: [PATCH 8/9] perf tools: Add size to struct perf_record_header_build_id
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
> We do not store size with build ids in perf data,
> but there's enough space to do it. Adding misc bit
> PERF_RECORD_MISC_BUILD_ID_SIZE to mark build id event
> with size.
>
> With this fix the dso with md5 build id will have correct
> build id data and will be usable for debuginfod processing
> if needed (coming in following patches).
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/include/perf/event.h | 12 +++++++++++-
>  tools/perf/util/build-id.c          |  8 +++++---
>  tools/perf/util/header.c            | 10 +++++++---
>  3 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index a6dbba6b9073..988c539bedb6 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -201,10 +201,20 @@ struct perf_record_header_tracing_data {
>         __u32                    size;
>  };
>
> +#define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
> +
>  struct perf_record_header_build_id {
>         struct perf_event_header header;
>         pid_t                    pid;
> -       __u8                     build_id[24];
> +       union {
> +               __u8             build_id[24];
> +               struct {
> +                       __u8     data[20];
> +                       __u8     size;
> +                       __u8     reserved1__;
> +                       __u16    reserved2__;
> +               };
> +       };
>         char                     filename[];
>  };
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index b5648735f01f..8763772f1095 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -296,7 +296,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>                         continue;               \
>                 else
>
> -static int write_buildid(const char *name, size_t name_len, u8 *build_id,
> +static int write_buildid(const char *name, size_t name_len, struct build_id *bid,
>                          pid_t pid, u16 misc, struct feat_fd *fd)
>  {
>         int err;
> @@ -307,7 +307,9 @@ static int write_buildid(const char *name, size_t name_len, u8 *build_id,
>         len = PERF_ALIGN(len, NAME_ALIGN);
>
>         memset(&b, 0, sizeof(b));
> -       memcpy(&b.build_id, build_id, BUILD_ID_SIZE);
> +       memcpy(&b.data, bid->data, bid->size);
> +       b.size = (u8) bid->size;
> +       misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
>         b.pid = pid;
>         b.header.misc = misc;
>         b.header.size = sizeof(b) + len;
> @@ -354,7 +356,7 @@ static int machine__write_buildid_table(struct machine *machine,
>                 in_kernel = pos->kernel ||
>                                 is_kernel_module(name,
>                                         PERF_RECORD_MISC_CPUMODE_UNKNOWN);
> -               err = write_buildid(name, name_len, pos->bid.data, machine->pid,
> +               err = write_buildid(name, name_len, &pos->bid, machine->pid,
>                                     in_kernel ? kmisc : umisc, fd);
>                 if (err)
>                         break;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 21243adbb9fd..8da3886f10a8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2083,8 +2083,12 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>         if (dso != NULL) {
>                 char sbuild_id[SBUILD_ID_SIZE];
>                 struct build_id bid;
> +               size_t size = BUILD_ID_SIZE;
>
> -               build_id__init(&bid, bev->build_id, BUILD_ID_SIZE);
> +               if (bev->header.misc & PERF_RECORD_MISC_BUILD_ID_SIZE)
> +                       size = bev->size;
> +
> +               build_id__init(&bid, bev->data, size);
>                 dso__set_build_id(dso, &bid);
>
>                 if (dso_space != DSO_SPACE__USER) {
> @@ -2098,8 +2102,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>                 }
>
>                 build_id__sprintf(&dso->bid, sbuild_id);
> -               pr_debug("build id event received for %s: %s\n",
> -                        dso->long_name, sbuild_id);
> +               pr_debug("build id event received for %s: %s [%lu]\n",
> +                        dso->long_name, sbuild_id, size);
>                 dso__put(dso);
>         }
>
> --
> 2.26.2
>
