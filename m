Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2804F2A2C09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgKBNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:51:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54698 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKBNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:50:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id d142so840834wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9N/dQmigmw0YmGu5JpNc/YgQSMyfgxOZJwDLt4jePw=;
        b=ie4yzYbCvwUmY9NoZnf1/ksj3yw1svIyVxlVaQXv2NwYTT6W5NYW2XeQSIRZZ2vtMW
         LZD++TKIjwFH1THrp1KiuRf0Jrwu4fJMzQMaFyMUcJM7bsCHcmSS6caLI9fNGopFIfhV
         aZ+AzJJvJx7at2i4jG6/I59ItoZcklRHwb2Bix5uDCc1T5gHHZgIAZQoz8fwIq8TbTjW
         XY9U7XSyZadXrJP3QrTyq30krgqei1gk7vaT0IJmQpNw8oRd/pg2Rr3hD6Vf8jKABueO
         L+y+ISp4TVYAyZvzIYyRlnDFklVZUO58EypRcAiiez8uCf5frlak6CiY4ZQvQU5vjIy+
         Kamw==
X-Gm-Message-State: AOAM532VgDaYQ/ukQV9wokFZJ5NSS6LGX70xXjEztqUHxii10wHUc5EU
        Ua/gS4hOjO15d3eLPuUo4X3Fxs7f3PyFOEmtKVc=
X-Google-Smtp-Source: ABdhPJzoMg8sB+PERq7wvamrUX7RKaV7SuluNBgc//HhKm34vh5i4mG/pLEcxDdThcVZu74beSae57MPJWQsNR2Q5/g=
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr11971993wmc.181.1604325051717;
 Mon, 02 Nov 2020 05:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20201101233103.3537427-1-jolsa@kernel.org> <20201101233103.3537427-2-jolsa@kernel.org>
In-Reply-To: <20201101233103.3537427-2-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Nov 2020 22:50:40 +0900
Message-ID: <CAM9d7cgXHnk6kGkqpPGRvvjGzdMq-EmaqG4XipsL6ag+EFe+0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: Add missing swap for ino_generation
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

On Mon, Nov 2, 2020 at 8:31 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We are missing swap for ino_generation field.
>
> Fixes: 5c5e854bc760 ("perf tools: Add attr->mmap2 support")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/util/session.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7a5f03764702..d20b16ee7377 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -595,6 +595,7 @@ static void perf_event__mmap2_swap(union perf_event *event,
>         event->mmap2.maj   = bswap_32(event->mmap2.maj);
>         event->mmap2.min   = bswap_32(event->mmap2.min);
>         event->mmap2.ino   = bswap_64(event->mmap2.ino);
> +       event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
>
>         if (sample_id_all) {
>                 void *data = &event->mmap2.filename;
> --
> 2.26.2
>
