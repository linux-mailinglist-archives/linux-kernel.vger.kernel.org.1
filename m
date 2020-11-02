Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1612A2C15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgKBNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:51:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43755 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKBNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:50:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id g12so14660501wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVBtoPGtKzYaS9wEKCN8wBa6S2O6XSpyqUEVYMDvcfQ=;
        b=f+dunj4aAqhOO0cF254sBuolOBVYaBqL8Ov9e+y+1Hy5rIVpiwJIABJPDcJdECNwgx
         93xWTZWk/WTa/AKNt3fzFvYKjHfU2wx2W5Ouu44UlNiKvS33ifg7dqy7F9UrYyqyeXAm
         +ug4e+hQmv8sLJdGbGK5MR6hwDbDp6SHhdNvymV6/bSjKoWFyqB/GbgdhDMnMcgzVrFD
         LuGGViestGS+HnSoTVDOEP8o6RiMzPPklYml3I9iSX9MlODdAzHNwvgqQ/5KWFr/OgRx
         GlJER2bvVA9cJ+g3+ZSly4qvSt9j52duHXYWQdHQtebF+WUirk+ZwVkGQiLs1walRHLY
         xvtg==
X-Gm-Message-State: AOAM530dbDzxKEqBE/7GrbC6jN9eJMr1WfFPc0SyQ78Juzr+3Aj63wod
        UJy0Wxj/EH972GAI/mGIxz66IW9PyEE8wMT9LPF//qVg
X-Google-Smtp-Source: ABdhPJwws6MZuAbVRxSlKIXEa+bv85IvLfnFP5HWuDOQM5g8Vb2aSubYdWLmOeC0561ZQgOkExcV8JNLBSU/e5vtSUs=
X-Received: by 2002:adf:a553:: with SMTP id j19mr20264615wrb.349.1604325011683;
 Mon, 02 Nov 2020 05:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20201101233103.3537427-1-jolsa@kernel.org>
In-Reply-To: <20201101233103.3537427-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Nov 2020 22:50:00 +0900
Message-ID: <CAM9d7cj6mfLuZYsXzAP+JBTuRC9F74AxmGbCL2_wyxRWoau-tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Initialize output buffer in build_id__sprintf
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Nov 2, 2020 at 8:31 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We display garbage for undefined build_id objects,
> because we don't initialize the output buffer.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/util/build-id.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 8763772f1095..6b410c3d52dc 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -102,6 +102,8 @@ int build_id__sprintf(const struct build_id *build_id, char *bf)
>         const u8 *raw = build_id->data;
>         size_t i;
>
> +       bf[0] = 0x0;
> +
>         for (i = 0; i < build_id->size; ++i) {
>                 sprintf(bid, "%02x", *raw);
>                 ++raw;
> --
> 2.26.2
>
