Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDAD2F8A08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbhAPAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbhAPAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:46:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1371C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:45:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x20so794528pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ONzqgbvnq85aoi2OVqYRVJ7otAaf4by13zC7hy9md1w=;
        b=fhtnfGSZ/RNIDaIAJ6IMMicZlsiC2udgnWUCMr4myqPH6jTP2WNlZqKoF6NIGn0gqs
         of2zv4B1R+w7TEW6XvEM93ajyrI9KLDbaWM+cL+RA8uSlsPjcGPRExKr35FeMIL1INQV
         wRIqr0myQ9HM08hpBNWScmQFtanYLJ2PtvviM9NhnHe1HViCzW4EcizMQhSGnx2SQmuw
         J3cddY+T5MhY80ijbyZRvTFp7QEJ0Z1vV628wjwiZYaRpe12A9o8ihIMfnCeLwtk71dv
         CS8dCW+Q/Jd3GnFYs1YPgAvDMJy6LF7ppEhRZhawIrIijQyV57J44aVmnL76QOlfgx9V
         eclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ONzqgbvnq85aoi2OVqYRVJ7otAaf4by13zC7hy9md1w=;
        b=sSnCO3CgxgjS9bO2l2Qw3EqFBu0fyD353tAkQ0BjU14PoKxtHVSkAuFHMwox4aIeaP
         BJpcinipx4gWryVOxDu58QOGJGS4EVKoDZKyU4IhPQK+PKYEN30MJjxHFkeVZuI0b9u3
         BkPPA1v54LxZYRYDrS8Aw1rCrugMtDfOryP5q6QsvPbS27ByOTYpcR3mqNOpvQ09RlId
         7mQLo/XXFH4vC037iwlw6ohkAU5rm30/1SZ2IxEAH00N2kHjEfgOM+6ip7XdfQGyr/ys
         ChihsuV+JJnp5ovv6234MdI4wT8U7dZLUHYwG1V4UaVXVUGOH5C9lhazK7HorFyWPCGV
         1x+A==
X-Gm-Message-State: AOAM531bv9OolO3bFyFQIWDzgRKv2kPrIWX03qZnd+eLdrJjlwX90Kbv
        Mo3dtD69B2dsKeXgR7Kee1n3Vw==
X-Google-Smtp-Source: ABdhPJy53/G3NMkW1V+j9XTWl2+stVRKFGAy7PPfXnToKJyeIUSFuWLDt+UcGYOT3H2xuThYqRVa8g==
X-Received: by 2002:a17:90a:8e84:: with SMTP id f4mr13494240pjo.129.1610757922887;
        Fri, 15 Jan 2021 16:45:22 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id c184sm9294033pfb.11.2021.01.15.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 16:45:22 -0800 (PST)
Date:   Sat, 16 Jan 2021 08:45:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] perf c2c: Sort cacheline with all loads
Message-ID: <20210116004511.GA5418@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20210103225219.GA850408@krava>
 <20210104020930.GA4897@leoy-ThinkPad-X240s>
 <20210104093540.GA872376@krava>
 <20210115151701.GA412118@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115151701.GA412118@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:17:01PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > Thanks for the review, Jiri.
> > > 
> > > Note, after testing with Arm SPE, we found the store operations don't
> > > contain the information for L1 cache hit or miss, this leads to there
> > > have no statistics for "st_l1hit" and "st_l1miss"; finally the single
> > > cache line view only can show the load samples and fails to show store
> > > opreations due to the empty statistics for "st_l1hit" and "st_l1miss".
> > > 
> > > This is related the hardware issue, after some discussion internally,
> > > so far cannot find a easy way to set memory flag for L1 cache hit or
> > > miss for store operations (more specific, set flags PERF_MEM_LVL_HIT or
> > > PERF_MEM_LVL_MISS for store's L1 cache accessing).
> > > 
> > > Given it is uncertain for this issue, please hold on for this patch
> > > series and I will resend if have any conclusion.
> > > 
> > > And really sorry I notify this too late.
> > 
> > no problem, I think we can take some of the refactoring patches anyway
> 
> Agreed, in fact I already processed this series in my local branch and
> I'm test building everything now.

Thanks a lot, Arnalod.

Just remind in case you miss the latest series due to the flood emails,
I have extracted and refined the refactoring patches, and have sent out
patch series v4 [1] for picking up (and have received ACK tags from
Namhyung and Jiri).

Leo
