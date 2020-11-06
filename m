Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB90F2A8D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgKFDAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKFDAa (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:00:30 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E2C0613CF
        for <Linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:00:30 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id e7so2977850pfn.12
        for <Linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kd7/d/fLq7+duhQ6Vj0zDnk8znkbViqWSFrCJVGr8aA=;
        b=WOAlTLkmA0v/XZ06SidQBJxZb5Ye3jP1hWQ8+478O9qMVa02Xg69P6h8lKgW7RT8vr
         18vlMFvOCQWIrZtH6uXXXKig80lFZt0AgqNq4zYxph7zcNvvsHKeWsuhOGqmNVCCAXK0
         X18HOGXE/EEfbl/e8pOtXJtjFOMdGOPzV9uSTY/tvgyRhtoQ27v2dzOuvKpYZDogAMzO
         juVeVpBicQOdkkVhWPUVBTl0uLH0MKmPKsOSudP5BqiNkWobUCbi+rRIfsshQUu+kH54
         kWIPlt/R4Iz1ynvKNIsACvU/isycWoORD0pCucdiVdFP1UBG4uKvcoy1b4RFQSISEo5H
         Zp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Kd7/d/fLq7+duhQ6Vj0zDnk8znkbViqWSFrCJVGr8aA=;
        b=lFV68E5aYCOe2dx4/b21BqHlXS1w/cswOHigm4OtVDkdSGPqkHfI1dMO1V/fJxPlgu
         T21rvFUsnxWvF65/GFA4tKqLDF5q9bOR5vwSBf3in5TcTW4A+nPY8Lx1lp2TCZcVT2lO
         OIOg3m+Ti00rKXiyjBT1Pkev35JxCT3TjVOGDPZ6cdivB/4hEWQKrNA4w519rL/UJX9j
         OS+1U5x1pZzWcZu3M287AF4m6K18ODXybX8mmTX5qswcP6LEVYfUolVSrPqB+bAKrJN8
         gQdg85THfMfEpLuAmZDVaFMpZXCHXslbCZ70ysBtu9sD5AvJ3XxYN48u4zOPWdn4onAl
         vzWA==
X-Gm-Message-State: AOAM531e9XPYrMaLqYm++qsgL/BJgx8CMugxsRDuef+2/WPSRBI9IoEl
        +VA5Kwc4OCQtaFQL9M731Kc=
X-Google-Smtp-Source: ABdhPJx28lWFnB+PaLR33HqimcaVARf4QRs45NCu2us2irOJrXH0QMqEEQhnwU3d1emshifcKLu9vw==
X-Received: by 2002:a17:90b:180a:: with SMTP id lw10mr52890pjb.106.1604631630254;
        Thu, 05 Nov 2020 19:00:30 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id j15sm3792807pfn.43.2020.11.05.19.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:00:29 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 6 Nov 2020 12:00:18 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
Message-ID: <20201106030018.GA359712@google.com>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104015102.30363-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 04, 2020 at 09:51:02AM +0800, Jin Yao wrote:
> - Update Skylake events to v50.
> - Update Skylake JSON metrics from TMAM 4.0.
> - Fix the issue in DRAM_Parallel_Reads
> - Fix the perf test warning
> 
> Before:
> 
> root@kbl-ppc:~# perf stat -M DRAM_Parallel_Reads -- sleep 1
> event syntax error: '{arb/event=0x80,umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
>                      \___ unknown term 'thresh' for pmu 'uncore_arb'
> 
> valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,percore
> 
> Initial error:
> event syntax error: '..umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
>                                   \___ Cannot find PMU `arb'. Missing kernel support?
> 
> root@kbl-ppc:~# perf test metrics
> 10: PMU events                                 :
> 10.3: Parsing of PMU event table metrics               : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
> 67: Parse and process metrics                  : Ok
> 
> After:
> 
> root@kbl-ppc:~# perf stat -M MEM_Parallel_Reads -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>          4,951,646      arb/event=0x80,umask=0x2/ #    26.30 MEM_Parallel_Reads       (50.04%)
>            188,251      arb/event=0x80,umask=0x2,cmask=1/                                     (49.96%)
> 
>        1.000867010 seconds time elapsed
> 
> root@kbl-ppc:~# perf test metrics
> 10: PMU events                                 :
> 10.3: Parsing of PMU event table metrics               : Ok
> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
> 67: Parse and process metrics                  : Ok
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

It seems not applied to acme/perf/core cleanly.

Thanks,
Namhyung
