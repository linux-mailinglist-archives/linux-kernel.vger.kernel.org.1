Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72328DF69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgJNKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 06:52:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39839 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJNKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 06:52:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id d3so2080839wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 03:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bKkLKMhPh4D3H3nN/BuKx9lLGEUVBWYV/8tIbDA7r4=;
        b=G0l6ycPv3tVhVcMEZtmSXedRak/4giHRASCdtrfySaWHMBx7QtPjQAFHUcb0FuB/BI
         iNiWLmO3Q+i+KCcs18WPSfE6hbdK8MMsiLYAcqandlJXnKpjCUIO2BcS5yCuVX8uDXGQ
         Xdi11zEq0Y1xdK1NEJZq38XPw4IWiG2IPvGFEteYDYgENikSa+eDZdOlB2DaeEOLHoMi
         TtaZ8XXZOoYHo9zrLjh0YlrmTiH7aHdGM1U3nEqunULqd53jwPkSJ/dTBNVZMKcYwp9C
         qAoZ5lQOgMYHQlp1E4gFWQx+AB89gmI5GIZfqrf80ZVgEFA2fcNwZ/iAl4RSUZyIOBG7
         L21w==
X-Gm-Message-State: AOAM531zYtIjMosd6DXODoSdJ9T3GXviLx9PprYnAV75dkIZxHat8HqK
        HELwliSpdf2qCEPFaMFQRTvs2eCLYFIE37isujk=
X-Google-Smtp-Source: ABdhPJySqPfVQMDXjhMdStnBJio0lrsP1fE4mmpQ4UhT/1mO/XuQIy9dBe4RIr8MioJSmt6BsHihwuVbIyYwF4gzsgs=
X-Received: by 2002:a05:600c:2211:: with SMTP id z17mr2971926wml.92.1602672732991;
 Wed, 14 Oct 2020 03:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com> <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com>
In-Reply-To: <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 14 Oct 2020 19:52:01 +0900
Message-ID: <CAM9d7cgrXsiPWuAYjg1og0N=03-mfx075-n7KUrvYyAMLZ8_7A@mail.gmail.com>
Subject: Re: [PATCH v1 08/15] perf record: write trace data into mmap trace files
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 12, 2020 at 6:01 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Write trace data into per mmap trace files located
> at data directory. Streaming thread adjusts its affinity
> according to mask of the buffer being processed.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
[SNIP]
> @@ -1184,8 +1203,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>         /*
>          * Mark the round finished in case we wrote
>          * at least one event.
> +        *
> +        * No need for round events in directory mode,
> +        * because per-cpu maps and files have data
> +        * sorted by kernel.
>          */
> -       if (bytes_written != rec->bytes_written)
> +       if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
>                 rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));

This means it needs to keep all events in the ordered events queue
when perf report processes the data, right?

Thanks
Namhyung
