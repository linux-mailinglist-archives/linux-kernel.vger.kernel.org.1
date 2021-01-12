Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E22F2667
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbhALCun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbhALCum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:50:42 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:50:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g15so451604pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYrwCYsagNf39CxLVWCCee16HkC5pk45kJBR8IYUxS8=;
        b=dIEuJh9pu9Icr+a0xL07U3txvhKDA5pUWOhB8jZAoJmVyYZfU7oQrLyvDA8YB8enNU
         ZXFr1MLsKXJOF5bUo18cgYmSCHbF5RuahePH125T0pdODoArFgTc8oecYefGUQgjiK+V
         iHajL3dmuG6Vwr2aFKt+1t0TvbF/ULYcOaVKLDjUQtpTureZnlCykl2kgMgPLC3MhiyG
         ayKFcjJHaOA4IzectJbJxa23tWssyoNBWy4tjQk/FhJyIFnIG4F+y3yt87ARJzuYsRFk
         UcNd2/q/U3yJ3X+ybEcF+pyrBcTV5jXWQx8jRGRMpstP/61Q5AJGNWKpC8Ysnsl5ybeA
         +sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYrwCYsagNf39CxLVWCCee16HkC5pk45kJBR8IYUxS8=;
        b=LtAr2qangHKPfAZx7AZgAP5TI8BjbvtzSz79WJDKnkNKo6uS9OJtBy8SyytKiLc1sA
         PuJCwNUOKznPNs2BqKaekX4LXK3bs8qW1ac8wn/0tBWGOtZ3DIcpZ0rPJTtRMSYW41Km
         KG0+fgP8Lhq7U+aSOpuYaeWqXOfjPVDT2IjIadKMj6advpujgUpsZyL1aFyVL1CIKRMA
         seFae5YZqdVciJh4vHENOt6IrkVc5380vwdUizcHzTRfM5/6Mw4BIGC/bdONEcbNrWG7
         eaSdeDjnDUw0OtoN1L/StsilIg+Lg7nqY+Q5XvmumvtDFY+pYKcaKMF4Tqlg8idSMHCz
         +lSA==
X-Gm-Message-State: AOAM5335aZ47AzSn6+VOWAkj0WCGV8LTPLXrmDjl2n2YWDvcJnV3gcwj
        iNrUmrB0U4w7U0h9Ig5+wBBqb6Y2SXzQkA==
X-Google-Smtp-Source: ABdhPJxAX1ODZKUoovFKrQW6rE20OQhp7bU3t37Iqv9IEoxkYczTf1H8GRCG5ezXzTqTAs2bdSwC+Q==
X-Received: by 2002:a63:ca51:: with SMTP id o17mr2475576pgi.314.1610419802078;
        Mon, 11 Jan 2021 18:50:02 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:3e79])
        by smtp.gmail.com with ESMTPSA id a136sm1059219pfd.149.2021.01.11.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 18:50:00 -0800 (PST)
Date:   Mon, 11 Jan 2021 18:49:58 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHv6 0/4] perf: Add mmap2 build id support
Message-ID: <20210112024958.4utm7ijkpluu3g36@ast-mbp>
References: <20210111213823.1249420-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111213823.1249420-1-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:38:19PM +0100, Jiri Olsa wrote:
> hi,
> adding the support to have buildid stored in mmap2 event,
> so we can bypass the final perf record hunt on build ids.
> 
> This patchset allows perf to record build ID in mmap2 event,
> and adds perf tooling to store/download binaries to .debug
> cache based on these build IDs.
> 
> Note that the build id retrieval code is stolen from bpf
> code, where it's been used (together with file offsets)
> to replace IPs in user space stack traces. It's now added
> under lib directory.
> 
> v6 changes:
>   - last 4 patches rebased Arnaldo's perf/core

There were no issues with v5 as far as I can remember.
This is just a resubmit to get it landed ?
Last time we couldn't quite figure out which tree to go through.
I think the recommend path was to go via bpf-next.
Is it still the case?
