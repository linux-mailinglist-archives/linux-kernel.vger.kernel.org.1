Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059EE2F0DED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbhAKIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbhAKIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:23:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09705C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:22:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l23so10100980pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGSjyvNZmqhOlmXDnGGSqxkJTaO9+E2vQNmEa2yDfls=;
        b=szrn3rhVDv8ewv13SPQCwvaFTJz1H887xLdoq90hP4Tx+2pcurk8lg3gNdcqB1LDSf
         LVuxJ6calLwUKUrT9+3NUw91J787CkzKN+9yyM21KZmEvxSxPTuwxuzajGVpOHg5WUNO
         NcJBo6Iu1WHA2bJWo4F5jsA9XpTDG3X515PcU1PU2lHT5oeBU7P7mIrSDocR13nUOzJv
         LqT49gMj6rCvKLwxLvHcTW3nMQX2FmWx8Ld9Y1uaj+YAZDN+gpTPsoyS2SrW9jQLGSxu
         j7LZbZSxos8GIx4V+D7O9dLHyKAsYwBVcQ9wqFwmloWf6xtVBhzoy+eaFMM1OGw6FWdP
         nqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGSjyvNZmqhOlmXDnGGSqxkJTaO9+E2vQNmEa2yDfls=;
        b=BpXad7EwP4iLqgpAhDQL1PFmT526CHt4vjh7cY/dJPry+CxwzzVb4nulqfWJLFj3MM
         thgIXiE8KdtB3U68SCiq6Z/ORTOO7YdrX/P8aw7smnzCUzLEza2xGh9rjGeLfRPKb6eT
         e5sTKN4AIXfrWNoclQ70O9HMwgBCAiCu/U1Eo0fFJYWHBC1VIFF1EjQpxcEUxo8+0F5o
         bh9srvzC0dzjZRBCB/kVvDBGrdXn2/BRLnn9w56ooST5r3ShoQI8SLr2UCIYwKRXkatP
         C2EhCyBkO8kSMpzITtmdFbKX34xpz4j6GCpwgTYmb2S7Bv4u8eVq3EFXyXfSgkgu/vTT
         e7MA==
X-Gm-Message-State: AOAM532fhMmDWQN7GestJVQtyJNVrPJjlw5AKm8T1soZe4ibfW8vE0D2
        mcQksiJR6VcKFu1iokhjJFIeLw==
X-Google-Smtp-Source: ABdhPJydxHJC0RTghhoLcGpgAYVAgWiJTts1m/IxDl/kR/7fo0kbEwBD5B3eppe+fMOzPMekFkHvWw==
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id f12-20020a170902e98cb02900dacb88f11dmr15417702plb.17.1610353372541;
        Mon, 11 Jan 2021 00:22:52 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id mz1sm14207684pjb.33.2021.01.11.00.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:22:51 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:22:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] perf c2c: Add dimensions for load hit
Message-ID: <20210111082247.GD3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-3-leo.yan@linaro.org>
 <CAM9d7ch+N++TDvq57+f6VwCx66YBtU4dNc-MdbsVEkTmoM0_0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch+N++TDvq57+f6VwCx66YBtU4dNc-MdbsVEkTmoM0_0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:38:19PM +0900, Namhyung Kim wrote:
> On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Add dimensions for load hit and its percentage calculation, which is to
> > be displayed in the single cache line output.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 71 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 3d5a2dc8b4fd..00014e3d81fa 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -1052,6 +1052,58 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> >         return per_left - per_right;
> >  }
> >
> > +static double percent_ld_hit(struct c2c_hist_entry *c2c_he)
> > +{
> > +       struct c2c_hists *hists;
> > +       int tot, st;
> > +
> > +       hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
> > +
> > +       st  = TOT_LD_HIT(&c2c_he->stats);
> > +       tot = TOT_LD_HIT(&hists->stats);
> > +
> > +       return percent(st, tot);
> 
> It's not clear to me what's different than percent_tot_ld_hit().

Yes, though these two functions are used for different view (
percent_tot_ld_hit() is for the brief one-line summary view,
percent_ld_hit() is used for the Pareto table), but I think you are
suggesting to consolidate the two functions to single function.

Will refine this in next version.

Thanks,
Leo
