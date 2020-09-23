Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCACE2752FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIWIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:12:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C50C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:12:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v14so2768063pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/y+uABu4va+n9lHIrjSOWbQaLnHg2GRR6lgfP4MtBaY=;
        b=S/XtOKyVw6C4sxBtXfhBSz9R64XFtjp0NrdHcG2qGxJofQ6X69cL/rwi/9kLrQ1Dil
         NDREvv+GQ8AwmivJztxvwy3LafCRaG+o2XS3zLyFEcVRBhLExvd55mF5aV5B3ULux5Yp
         qBnoA+kcH+L4OWnjJVH2NhVgph3gtLhNb01RVY6LblH1oeI0JVevYaiBOq3RHZ7pTmkL
         Bv/9YH5j3F/lMZFpn1PIgVN85UxYaCINIaHYf3QGwesKXFxWEu7Bi1hWLqpRgQvUQ4CU
         MA+xdMn3pk0dRKJzeoSbprbdkDkvl/f/EqLnyxANfnptS4WOiYV6luNNXpIDUBcwtX6b
         T+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/y+uABu4va+n9lHIrjSOWbQaLnHg2GRR6lgfP4MtBaY=;
        b=a7vSZiZ2VGCh9gyOcnUBe/E9mrkCOJkSGyFlCcTtHTX0X9jtiQ2p4/kAIny3eX42K9
         2r6J/hU3cOrjw7wm1aVIwg9jZOlLoi4UOblmVw2zsVB2O22K95vz3L2tOfrwvRadzAlD
         RY4tLq3zEKLApWKTzgMDWuGD5A/4PeeiXDf7j9rmJr8YLfJ9CX4WFScy3lJTY4QTpQy1
         eSv8HPT82y+WRmHTLSAwzGeD/6T2EvG9DwI7MmvOEbXkxs0/9VWwJjfmmj+bPvIqLtYB
         NH496dHZTHTtRuMVlTH2lTb7Y2kzEPpJ3Tku1vHjQ6xaIaV1iKMuo73qugSQ+2SmTx8r
         muHQ==
X-Gm-Message-State: AOAM530LsQf+RSy4C6ZeqGofoby5iN6osAby6Ta5uuckvSFfAan92wWQ
        Wfy4hui8KF+AOZjorhike/Qmaw==
X-Google-Smtp-Source: ABdhPJw1H7f92cb/4AQgjeapRkgFrSe/ckdIsULnLrd3oy06MrYCKHt9snl3d9Dh1Hvyii3UYD8iYg==
X-Received: by 2002:a17:902:8f8f:b029:d2:439c:3b7d with SMTP id z15-20020a1709028f8fb02900d2439c3b7dmr5530752plo.39.1600848763198;
        Wed, 23 Sep 2020 01:12:43 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 22sm17374350pfw.17.2020.09.23.01.12.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Sep 2020 01:12:42 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:12:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Perf tool: Support TSC for Arm64
Message-ID: <20200923081232.GA13232@leoy-ThinkPad-X240s>
References: <20200914115311.2201-1-leo.yan@linaro.org>
 <20200922120732.GB15124@leoy-ThinkPad-X240s>
 <20200922164906.GA2248446@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922164906.GA2248446@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:49:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 22, 2020 at 08:07:32PM +0800, Leo Yan escreveu:
> > Hi Arnaldo,
> > 
> > On Mon, Sep 14, 2020 at 07:53:05PM +0800, Leo Yan wrote:
> > > This patch set is to refactor TSC implementation and move TSC code from
> > > x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
> > > alse move the TSC testing from x86 folder to tests so can work as a
> > > common testing.
> > > 
> > > So far, for x86 it needs to support cap_user_time_zero and for Arm64
> > > it needs to support cap_user_time_short.  For architecture specific
> > > code, every arch only needs to implement its own rdtsc() to read out
> > > timer's counter.
> > > 
> > > This patch set has been rebased on the perf/core branch with latest
> > > commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
> > > metric events") and tested on Arm64 DB410c.
> > 
> > Could you pick up this patch set?  Thanks!
> 
> Yeah, I picked it up now, its a pity nobody provided Acks :-\

Thanks, Arnaldo!

> Or have a missed them somehow?

No, you didn't miss anything.  I should actively chase Ack tags (e.g.
Peter or Will's acknowledge) before ask merging.  Will note for this
later.

Thanks,
Leo
