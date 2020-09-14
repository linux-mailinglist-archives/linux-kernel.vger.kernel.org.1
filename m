Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2E268431
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgINFoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:44:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINFob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:44:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id q9so9378449wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hgU/R8+VvYKhiziAXNkm+RebhEcoZxMjMnaq6UlnaU=;
        b=mmQd3Nfi1PlYUbfkXvM5yCQUj0tz3XJNQ6YnZef9iT3qeztqxovJysEB4iu7eCYAKM
         GpeUqlwGLL5ms0RfXf1LviE7bZ9JGlTDDJgdb7Is3lESWcQoHfIgJe67/LCi0FPWXsre
         55HMcZM6ACFaUCO7zGYv1shjTETBXfGC8SS790Qq6OVgYYDaAXhE+NUrUk9h5zUVIynY
         FOpDoqMZsKA71jI9WhqL/mJfveffb0igRoJgfx6KW/cnXJjrt/B4uebR3EwhI3dO4z+T
         6qD/ZbnD/6Sp4qeIl6Frozwi7lzTN2GBm5P/qCZrLdzKYV9y4bV0vqGkWoif1eckzL5t
         gCnw==
X-Gm-Message-State: AOAM5336mTXy3BcEYuHkfTZy6Wc4mBbA42xpc2zBlxrN++hocy36Y2SA
        fwsMaZoOhTRNX45WJjSkpEjZG4NsA9gTrHZZuaM=
X-Google-Smtp-Source: ABdhPJxlSmd7xkLF39HRVHlf/AuX2GA2RjHzmlZs4rmRkmtqv+zsBzKl8C18k/cJjPncMg/01UL6jZwPg/SJh4WKL3A=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr13188184wmi.168.1600062286532;
 Sun, 13 Sep 2020 22:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-6-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-6-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 14:44:35 +0900
Message-ID: <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
Subject: Re: [PATCH 05/26] perf tools: Add build_id__is_defined function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding build_id__is_defined helper to check build id
> is defined and is != zero build id.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 11 +++++++++++
>  tools/perf/util/build-id.h |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 31207b6e2066..bdee4e08e60d 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -902,3 +902,14 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
>
>         return ret;
>  }
> +
> +bool build_id__is_defined(const u8 *build_id)
> +{
> +       static u8 zero[BUILD_ID_SIZE];
> +       int err = 0;
> +
> +       if (build_id)
> +               err = memcmp(build_id, &zero, BUILD_ID_SIZE);
> +
> +       return err ? true : false;
> +}

I think this is a bit confusing.. How about this?

  bool ret = false;
  if (build_id)
      ret = memcmp(...);
  return ret;

Or, it can be a oneliner..

Thanks
Namhyung


> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index aad419bb165c..1ceede45c231 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -14,6 +14,7 @@ extern struct perf_tool build_id__mark_dso_hit_ops;
>  struct dso;
>  struct feat_fd;
>
> +bool build_id__is_defined(const u8 *build_id);
>  int build_id__sprintf(const u8 *build_id, int len, char *bf);
>  int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
>  int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
> --
> 2.26.2
>
