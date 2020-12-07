Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B062D11B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgLGNVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:21:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45669 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:21:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so14852049ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4QiS8f2BvnfmrQSd7I2HcK6s7v/ucpHKO3Bl6Msd9k=;
        b=lnNDT7R7cpKWRRp2TIx9qKl6q3pnh7UMRRQbpw2Y4c4lF8O9rhxLI5Y98s5xNMK9RI
         c5Lo0pcsU4l1MqVdm+CnZyZDaLLhS/jn4efmhcVd+UKYBVWRd3Gf3pr2HPgVHegWqNS6
         xYTGLTJa2Bx9U1QOmoYXLAReLP12VcTODCIVmgKNm7VOAr9ivaOztobcPaMYlX+VUsSO
         NuYYKx1Khs8C5fJsup2Lg2i45qEtFojTQUc4VhMjy+x3DeWhkkRBITvnso6ZFHs8wQ1y
         L0P1WXN0UUXFDDkSL2R/JCONuJMIRS3xFXikl4r//3XhHEfAsHI+Qbk+tPheHlMvm7LC
         DwWQ==
X-Gm-Message-State: AOAM5329AiskLPeYBtsgQsdB1zZA1eSYngMdioHh5swmR0JqWpWMnPGS
        4lSzpmHvG0MYR9mGdOooQ3NA/t1IZ6vw8yV+hbQ=
X-Google-Smtp-Source: ABdhPJwrxT6CtkxfXqVfe4vU6/3HE2wJ2sFez/0GjTh4iSdAQ8xxRfMp9gUVybkuDuFgCpgr0YBFUMDQonY/RybQI8M=
X-Received: by 2002:a2e:9ad2:: with SMTP id p18mr8737106ljj.415.1607347236344;
 Mon, 07 Dec 2020 05:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20201202073953.3811709-1-irogers@google.com> <20201202073953.3811709-2-irogers@google.com>
In-Reply-To: <20201202073953.3811709-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Dec 2020 22:20:25 +0900
Message-ID: <CAM9d7chQQK2DP_gEFdi-OG5X6wCoouH75Jsg-V=UEFpuB-5bFA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] perf metric: Restructure struct expr_parse_ctx.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Dec 2, 2020 at 4:40 PM Ian Rogers <irogers@google.com> wrote:
>
> A later change to parsing the ids out (in expr__find_other) will
> potentially drop hashmaps and so it is more convenient to move
> expr_parse_ctx to have a hashmap pointer rather than a struct value. As
> this pointer must be freed, rather than just going out of scope,
> add expr__ctx_new and expr__ctx_free to manage expr_parse_ctx memory.
> Adjust use of struct expr_parse_ctx accordingly.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> -void expr__ctx_init(struct expr_parse_ctx *ctx)
> +struct expr_parse_ctx *expr__ctx_new(void)
>  {
> -       hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
> +       struct expr_parse_ctx *ctx;
> +
> +       ctx = malloc(sizeof(struct expr_parse_ctx));
> +       if (!ctx)
> +               return NULL;
> +
> +       ctx->ids = hashmap__new(key_hash, key_equal, NULL);
> +       ctx->parent = NULL;
> +       return ctx;
>  }
>
>  void expr__ctx_clear(struct expr_parse_ctx *ctx)
> @@ -221,11 +229,23 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx)
>         struct hashmap_entry *cur;
>         size_t bkt;
>
> -       hashmap__for_each_entry((&ctx->ids), cur, bkt) {
> +       hashmap__for_each_entry(ctx->ids, cur, bkt) {
> +               free((char *)cur->key);
> +               free(cur->value);
> +       }
> +       hashmap__clear(ctx->ids);
> +}
> +
> +void expr__ctx_free(struct expr_parse_ctx *ctx)
> +{
> +       struct hashmap_entry *cur;
> +       size_t bkt;
> +
> +       hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 free((char *)cur->key);
>                 free(cur->value);
>         }
> -       hashmap__clear(&ctx->ids);
> +       hashmap__free(ctx->ids);
>  }

I think this function should free the ctx itself.

Thanks,
Namhyung
