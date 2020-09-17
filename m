Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F2926E6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIQUUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgIQUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:20:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B02C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:20:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3340663wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkvR14NZCLb0qHgNFyoBJIXRqyvoLe3ARP2Mai9UTVI=;
        b=DLj0CKtbkDqtTgH+OFXbymQSaVILngeMwtRVaSwHqW7lL6ASAtmnizyEZ10As6Y4ig
         MpjgLVD++ZP9EaMR749amVeTOz1mtqvfkLrguK45oH8mUaWPDdboiXSnbyg057rBWanq
         cLR8NkyiswF4NEbNwBlHBJpsogTqJEpG5nV3KUgrtU4EOTaCsePowdhuiT9kLeEia2ow
         YcTlwltIs3bVOQQhZs0eCiVCy0gSDSHLZlwwM8wHG0CMb/Zur+etPLVdU4tJe3doF58W
         KHhXBypoO1naFpHdHN/A9BJYykqXVLg75ceJZ8LcyXh5i5qyvaZP6G1rasUFeWD9UZRE
         JNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkvR14NZCLb0qHgNFyoBJIXRqyvoLe3ARP2Mai9UTVI=;
        b=CIqgVxj17mNx0KFAg2qfS4COH4t+4kpuGrDOsx7uKOtff0iaVUWXrnKpO+Nv5yLNMV
         MedLxJ0fN9xck/Kr51WUhIn8XVk1dZxBEecmt13HmlmM8mlpQ/cYKy2DKQBM2KVxzo6D
         jfxnCkDa6CPJsuWva+JJ88mycPaKOdBBGOqnHLExoTcA09aeODt8Aw+6Tsoe/OC7R/ZU
         spzOhhIf/kwa6UpxaA7vNM9pV5wbmpf2tqdro1xooNR59ERjM7+ICe6XzH8Sn7HPMlEt
         deERj3NAvAD2Gzn4ciMipI2U3CaOTXRL1a3Fkj95a9JeUnfYH6U6oXujPt81RDo2BXj0
         Vptg==
X-Gm-Message-State: AOAM531mkAtkVbrkzFxytVSTqhjiwLku7dFTF7gklnm9/4x3Gzn+iKkQ
        NW9naCw3RJQQa40A/UsWmVd7Y5Mn8YyFZyy7OLpUxw==
X-Google-Smtp-Source: ABdhPJzBi9xRfybrnDqM5dqgEIqjgffkdVd/LU00GSXbxA1BoTxXoVSqruqpCVeeUjjCDG91mxEsJd5pwgXPF3cQzGc=
X-Received: by 2002:a1c:7514:: with SMTP id o20mr11527200wmc.76.1600374040742;
 Thu, 17 Sep 2020 13:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200910180231.786751-1-irogers@google.com> <CAM9d7cjLpE=cKfemsuokc57-5kzezRr3YzqOKZb9Pf4r4-X8+g@mail.gmail.com>
 <20200917190026.GB1426933@kernel.org>
In-Reply-To: <20200917190026.GB1426933@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Sep 2020 13:20:29 -0700
Message-ID: <CAP-5=fUi8JOrL2sXs==XYs8wRC3ZhbxXYTGFxM-XiPDvG1-GPw@mail.gmail.com>
Subject: Re: [PATCH v3] perf metricgroup: Fix uncore metric expressions
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should be ok. I cherry-picked the patch on to a local checkout of
perf/urgent and sent as an in-reply-to here:
https://lore.kernel.org/lkml/20200917190026.GB1426933@kernel.org/T/#m6c12d6a224540ed5f222e58fff9807f1cdc4238f

Thanks,
Ian

On Thu, Sep 17, 2020 at 12:00 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Sep 11, 2020 at 12:07:35PM +0900, Namhyung Kim escreveu:
> > On Fri, Sep 11, 2020 at 3:02 AM Ian Rogers <irogers@google.com> wrote:
> > > v3. cleans up searching for the same event within metric_events to use a
> > >     helper and avoids a redundant search. It uses a continue loop to
> > >     make the search for similarly named events shorter.
> > > v2. avoids iterating over the whole evlist as suggested by
> > >     namhyung@kernel.org. It also fixes the metric_leader computation
> > >     that was broken in the same commits.
> > >
> > > Erroneous duplication introduced in:
> > > commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
> > >
> > > Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> > > Reported-by: Jin Yao <yao.jin@linux.intel.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> On my perf/urgent branch (upstream should be the same):
>
> [acme@five perf]$ patch -p1 < /wb/1.patch
> patching file tools/perf/util/metricgroup.c
> Hunk #1 succeeded at 150 with fuzz 2 (offset 1 line).
> Hunk #2 succeeded at 192 (offset 1 line).
> Hunk #3 succeeded at 223 (offset 1 line).
> Hunk #4 succeeded at 252 (offset 1 line).
> Hunk #5 succeeded at 260 (offset 1 line).
> [acme@five perf]$
>
> I'm fixing it up, please check that doing this is safe on your side.
>
> - Arnaldo
