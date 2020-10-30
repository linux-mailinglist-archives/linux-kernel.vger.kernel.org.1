Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2291529FAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgJ3Btf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3Bte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:49:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EAC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:49:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 133so3897780pfx.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7hL4sw2f+Ivb3IounfMGG3eIBIiM36uU9xeGb4tykPg=;
        b=THGZF/2+WvMOVeVXUUAgjrNJJh7aY0Jzs+xE+IoeMpId+D14ma7KaA2ONflJXuTGUb
         mHBvKH7pYppLrCpWp+t14e5yOKI3lvJZp66TcuRzJ+FdemCI19HPMVPwXQxDPlXjhhxw
         7FeoxxzHlo0C5tRhuYeXqE/b7oPSHeF5WOzceO2qgyfksuH1vy4ThVRyJrUAU3kg8oRN
         2s+d2cCRaIpo2E9z1cNn89JP4csGbs+TocXL1wGIwm/BazEnvudTqq1hUkS31f+NNhhF
         Od9XRQRXEiDwHv+DUskL1SWR9PS/jHorzFUgFtJFyEQ7N1pcRdZlTml4n1p2EYuGzcMV
         vjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7hL4sw2f+Ivb3IounfMGG3eIBIiM36uU9xeGb4tykPg=;
        b=Nj0wQdDFGtnD4zwECRVVcGlw210JMXvrKeopHwOckcn468JHPV43lGAdTfYi+9BHnu
         /rOB5+S4YAtFqq+tgWLVAjsojn+nYF+zik0Cj3bKEF352Sk9GmrVNr8PMsoQjK1ZVwGx
         4RlEfJ3/Unh3FFFoZo8qMxg/jPKKKXK7/KT3Soj4b9d+sofcUGqQWgNFzaUm2697pcaE
         xAXlyB400KS5FR9p7zRnbapNoJx2d6NyNuz2vGpJ6usDJOE/0iilOCA1+3SZyLmmUjwW
         XARTpDCQ55bHZPPd2+F7zXxdDYP1KuI3jTAKQjVXsxcrkIQQeYx8OIER/zR3VpLj4REz
         sJJA==
X-Gm-Message-State: AOAM531OxtqSd9CwD0ZwxST1SB0dWxDy6ry3lIqfSvyKwDRu+ATkELXY
        k7ZhhBhczp4Sbu9Yos+WXXfX7A==
X-Google-Smtp-Source: ABdhPJzRxca4tIWAeMP1wIIPAXLWARs3P9tjhDoamuXeTUxVmlzcDkDjwpb3wsN/h1zzFrY19nCeOA==
X-Received: by 2002:a05:6a00:8ca:b029:15d:7af3:8360 with SMTP id s10-20020a056a0008cab029015d7af38360mr7079165pfu.12.1604022573470;
        Thu, 29 Oct 2020 18:49:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id x22sm4316365pfp.181.2020.10.29.18.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 18:49:32 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:49:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 9/9] perf mem: Document event type 'ldst'
Message-ID: <20201030014923.GK16862@leoy-ThinkPad-X240s>
References: <20201028063813.8562-1-leo.yan@linaro.org>
 <20201028063813.8562-10-leo.yan@linaro.org>
 <CAP-5=fUi47JWsAbzPtKjpgopzDOt4FGkXW2sitnbM+sBgcodPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUi47JWsAbzPtKjpgopzDOt4FGkXW2sitnbM+sBgcodPg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Oct 29, 2020 at 06:10:40PM -0700, Ian Rogers wrote:
> On Tue, Oct 27, 2020 at 11:39 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The event type 'ldst' is added for recording both load and store memory
> > operations, this patch documents for the new event type.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/Documentation/perf-mem.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> > index 199ea0f0a6c0..c50ef37dba72 100644
> > --- a/tools/perf/Documentation/perf-mem.txt
> > +++ b/tools/perf/Documentation/perf-mem.txt
> > @@ -38,7 +38,11 @@ OPTIONS
> >
> >  -t::
> >  --type=<type>::
> > -       Select the memory operation type: load or store (default: load,store)
> > +       Select the memory operation type: load, store, ldst (default: load,store).
> > +       The type 'ldst' means the single event can record both for load and store
> > +       operations; Intel and PowerPC support the types 'load' and 'store' but
> > +       'ldst' cannot be used; on Arm64, it uses Arm SPE as memory events and
> > +       user needs to specify one of these three types.
> 
> Naive question, could the type remain load,store for mem record and
> the tool internally change it to ldst for ARM SPE?

Good point.  I understand you are suggesting to avoid complex options
for usage, looked again at the code, my conclusion is it's feabile to
convert 'load,store' to Arm SPE's ldst type.

If find any block issue when I experiment this idea, will come back to
update it; otherwise, I will apply the suggestion in next spin.

Thanks for suggestion,
Leo
