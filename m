Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F528D147
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbgJMP3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389297AbgJMP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:29:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD5C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:29:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a1so51545pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FG88oa3x5TYfwWYCrCc+t+GQM6/ODlomwJAj7hagTvQ=;
        b=UqLtfGzBQlNYr1kWpvmak1LVXevT+P1jVHLgOJ7BILIW6/KOb18ZiRJvD1Y28tyEyF
         OsDM0kdAsXJG8UH+YqgOC8HwNWOKbDek2dF9+IchF6PVOCkNnSQMVQ5CdBQVdLo9451z
         njGnSjO+AAA7JZD23GDk+m0mHEzaZ99Y7PMcrMw4V2iJYxLci5Wn+/UkhvnfXbtZoAwp
         gncKm9YP66uQrbgiRFkpbFv0jQORwELQPz7L98IlGp1EuxQtMrrtCdfcAE0EwFQ4V3WZ
         4hDmDBwcTMOOeNiV2GOV9AnyWhm9BSjUrHMKFkYu5Wa8DS2uFaUE4JS383cQWRRtkubF
         b83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FG88oa3x5TYfwWYCrCc+t+GQM6/ODlomwJAj7hagTvQ=;
        b=MLOB+k572CO+rfcDzGiJlAfWYHKIKdxOIWCfqhXsNV2gSSc+gEYL8sYNV5gjmDdbSU
         pGedZYGWJ9MESvph5XfbfkRM3ICjFkUiRqwJnggtMqhNASrjVR9lBXwcc6k4+3MWBFwF
         3UxNWEOXDYNBjbtFxXw4Ji526A0z54EfScFUiszIch12wTBlToUoZBMFhrTxEBn4jcWW
         TNQ+tj9rbqjYOguvTC4NTlutoVyYEILRivAom8zi3rKb6rpIBwfajVSXRY6g7gZqTh3B
         NOk59UEP/EBE8OztvN3mnCkTJU0HKhWO4akMVwRE6WlA8EPEEetIXETDOvyjRdgErsAK
         okQw==
X-Gm-Message-State: AOAM531covd3VYT1aVlHKjuhIwmHrDEd0MWv8vCWYU56mrnGiZaxky2h
        4WcjmAL0K7ydLcgk3BdrwzVL0rMcrGY9G82E
X-Google-Smtp-Source: ABdhPJwySP8onT5WGxSooihlXKuBi62FlZLlohArp37VTq63D9W8v+E1MeqIF9i4GFowvj1GwXOWJg==
X-Received: by 2002:a17:90a:b285:: with SMTP id c5mr306814pjr.44.1602602980246;
        Tue, 13 Oct 2020 08:29:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id v21sm23080700pgl.39.2020.10.13.08.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Oct 2020 08:29:39 -0700 (PDT)
Date:   Tue, 13 Oct 2020 23:29:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4] perf kvm: add kvm-stat for arm64
Message-ID: <20201013152934.GC24974@leoy-ThinkPad-X240s>
References: <20200917100225.208794-1-sergey.senozhatsky@gmail.com>
 <20200929033450.GB529@jagdpanzerIV.localdomain>
 <20201013143709.GD1063281@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013143709.GD1063281@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:37:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 29, 2020 at 12:34:50PM +0900, Sergey Senozhatsky escreveu:
> > On (20/09/17 19:02), Sergey Senozhatsky wrote:
> > > Add support for perf kvm stat on arm64 platform.
> 
> > > Example:
> > >  # perf kvm stat report
> 
> > > Analyze events for all VMs, all VCPUs:
> 
> > >     VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time
> > > 
> > >    DABT_LOW     661867    98.91%    40.45%      2.19us   3364.65us      6.24us ( +-   0.34% )
> > >         IRQ       4598     0.69%    57.44%      2.89us   3397.59us   1276.27us ( +-   1.61% )
> > >         WFx       1475     0.22%     1.71%      2.22us   3388.63us    118.31us ( +-   8.69% )
> > >    IABT_LOW       1018     0.15%     0.38%      2.22us   2742.07us     38.29us ( +-  12.55% )
> > >       SYS64        180     0.03%     0.01%      2.07us    112.91us      6.57us ( +-  14.95% )
> > >       HVC64         17     0.00%     0.01%      2.19us    322.35us     42.95us ( +-  58.98% )
> 
> > > Total Samples:669155, Total events handled time:10216387.86us.
> 
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> > Arnaldo, any opinion on this?
> 
> I'm not finding the actual patch, just this reply from you, lets try
> with b4 using this message Message-Id... Magic! But it isn't applying,
> can you please refresh the patch to what is in my perf/core branch?

I did a quick trying, the merge confliction is caused by the file
tools/perf/arch/arm64/util/Build (for the new added tsc.c).

@Sergey, please help to rebase on the latest perf/core branch [1].

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git branch: perf/core
