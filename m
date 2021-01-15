Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB30C2F73B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbhAOHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:31:17 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44042 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbhAOHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:31:16 -0500
Received: by mail-qt1-f175.google.com with SMTP id r9so5420790qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IC6nYnjWq4nKpkNfzmQBFmOCWxCpv8qHmwxuE4KKiAQ=;
        b=nwOCjyw0zrqv+Abb4PRDiS5MaBv17+yyejzRpEjTk9lFxCAZCZqtsDFG8oj+HFogjl
         cquCmTpbBb7qViw85BSyLBGJwejF+J/LQ2ZPQyPeHe6VoyjMJ4841/TvSCwr1F0eZamu
         Kyz2ahZmHa+b5tfQsMswtYeb/Fljnmxpmp0CC3GhlYqwo6yGSCoCAJt8VKYthICxFU51
         ljZs/H4L7g7qhzBTSo8WKHLwF3XGpenw9eXL3aUVoer8nhfAvTUaZQGgQuWaBzex1/sw
         RHWqKxfiTDXP6757yvf7yNayN+igl2Pw6fZP0mZ+Igzb57hk4A+pYsk2j15RKR9yD8ms
         L7rA==
X-Gm-Message-State: AOAM533LQbSwhAFYGTCEn6crIb0T6i5UCFHrPN1mhhDGGknQyMrbZsP3
        zPcPnIP4YFlmKwJgy/VAS+8tVEW0sIPuTns2JcA=
X-Google-Smtp-Source: ABdhPJwomW6rTW7s4wID/Brjwniin9+SEXga2rV2ofQcEuXcTydW4AYrNoLcJll29YsWK0Y/dKiUzv9jueCoiOKsAqQ=
X-Received: by 2002:ac8:4711:: with SMTP id f17mr2263591qtp.256.1610695834700;
 Thu, 14 Jan 2021 23:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20210114154646.209024-1-leo.yan@linaro.org>
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 15 Jan 2021 16:30:23 +0900
Message-ID: <CAM9d7cgXcvysJXZEWuskgB3ucdRkVg3OzUxcWvEcc2mrDpasBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] perf c2c: Code refactoring
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 15, 2021 at 12:46 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch series is for several minor code refactoring, which is
> extracted from the patch series "perf c2c: Sort cacheline with all
> loads" [1].
>
> There has a known issue for Arm SPE store operations and Arm SPE is
> the only consumer for soring with all loads, this is the reason in this
> series drops the changes for dimensions and sorting, and only extracts
> the patches related with code refactoring.  So this series doesn't
> introduce any functionality change.
>
> The patches have been tested on x86_64 and compared the result before
> and after applying the patches, and confirmed no difference for the
> output result.
>
> Changes from v3:
> * Refined patch 03/06 to remove unnecessary parentheses and test and
>   return early in the function filter_display() (Joe Perches);
> * Added new patch 04/06 to make argument type as u32 for percent().
>
> Changes from v2:
> * Changed to use static functions to replace macros (Namhyung);
> * Added Jiri's Ack tags in the unchanged patches;
> * Minor improvement in the commit logs.
>
> [1] https://lore.kernel.org/patchwork/cover/1353064/
>
>
> Leo Yan (6):
>   perf c2c: Rename for shared cache line stats
>   perf c2c: Refactor hist entry validation
>   perf c2c: Refactor display filter
>   perf c2c: Fix argument type for percent()
>   perf c2c: Refactor node display
>   perf c2c: Add local variables for output metrics

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
