Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9922936A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbgJTISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgJTISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:18:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:18:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so586999pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11ixftAgRsLun4NrdFvggsqL7o1LHLtJARtIyXNE+T8=;
        b=AT3iNkstBS6yCiUuJK9B2C+wINqSRJWVrHvKO8O6D5JUqFsDCJSz4OhxLq+7I1ekvt
         gwt2hNMUwZ/HI2kgsUwBQQzSvhK7ctv/coIPF0ivCs2s0PHriA/gDRSiR5BLAxHlMhh1
         ug+R26j8Onu2R55R4zInTE3N2+Sm1VKM8ATAjL7RNE/rDF9O2bvmLJKLFdl0w6YrdVlz
         nT5yBdEatDc1DbmDX7hV5BF0e8fyeUgqdldSwXsR02W6K+WBkpKuKlck8lu1P5Zx+O47
         IYloP1962d+PG2jLIrPA4TLeJ7YhWC//ZfdVQX299i/Qgmk98+Jynvqoy23VGsNIBsqn
         FBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11ixftAgRsLun4NrdFvggsqL7o1LHLtJARtIyXNE+T8=;
        b=LlWnMoEln74NpR5HTHgGX0MX4C2mXbRZ6TWQolzraes/i+zTJ9YrlnrWkLjPcdC/tE
         CnFhxX9aF0IBTzuAMQBpxc+qxQX/qkIMZ6Zuksn1vNgIZyCeHxeJi/HEUVQRwVnWwB6w
         0xa/50sGYa94/epHY0IXl+NPm5SnZN0SKk/yPOjnm9yDlhHlxBLYbWYWmfKNSJCunL7k
         d2sDUyY9s7MN821RO7Jaw48OqSdY4Z4w28QBkEgRhY/u4KhDJ3sCH0kpe+XrvrhK0L8r
         cU8ZS/VWcA++yco+W1ybFQyrQBpZ1zeFCT91uWis7cValNo6y4ZpeX89YKdJ3XVp0GYy
         UPIQ==
X-Gm-Message-State: AOAM533afjHlpvJTXV3CmchTNmlNwtSvn8CTa8/rd6TIRPR/KE3SVtV6
        k+6NH7EHQXS3rwxQnUvmbslJ6Q==
X-Google-Smtp-Source: ABdhPJxcfBx09ujmCgppP2D2oUP5jYCcvYhnc+iwagSDBChXhieXBPWkrt5ppyHbwUPxszQmo+/QTQ==
X-Received: by 2002:a17:90a:ef81:: with SMTP id m1mr1843978pjy.212.1603181928989;
        Tue, 20 Oct 2020 01:18:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id bj17sm1092475pjb.15.2020.10.20.01.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 01:18:48 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:18:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/8] perf c2c: Sort cacheline with LLC load
Message-ID: <20201020081843.GF13630@leoy-ThinkPad-X240s>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <CAM9d7cjuvB_67zSmaLAJJ-zS3RL5F59k8p+oqsuzJEOkAUx=WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjuvB_67zSmaLAJJ-zS3RL5F59k8p+oqsuzJEOkAUx=WQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 05:13:01PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Oct 15, 2020 at 11:51 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > If the memory event doesn't contain HITM tag (like Arm SPE), it cannot
> > rely on HITM display to report cache false sharing.  Alternatively, we
> > can use the LLC access and multi-threads info to locate the potential
> > false sharing's data address, and if we connect with source code and
> > analyze the multi-threads' execution timing, if can conclude load and
> > store the same cache line at the meantime, thus this can be helpful for
> > resolve the cache false sharing issue.
> >
> > This patch set is to enable the display with sorting on LLC load
> > accesses; it adds dimensions for total LLC hit and LLC load accesses,
> > and these dimensions are used for shared cache line table and pareto.
> >
> > This patch set is dependend on the patch set "perf c2c: Refine the
> > organization of metrics" [1].
> >
> > [1] https://lore.kernel.org/patchwork/cover/1321499/
> >
> > With this patch set, we can get display 'llc' as follows:
> >
> >   # perf c2c report -d llc --coalesce tid,pid,iaddr,dso --stdio
> 
> I'm not sure if you ran the test on x86 or ARM.
> IIUC ARM should have 0 local hitm, right?

Yes, on Arm64 the local HITM and remote HITM both are zeros.  Below is
the testing result on x86.

Thanks,
Leo

> >   [...]
> >
> >   =================================================
> >              Shared Data Cache Line Table
> >   =================================================
> >   #
> >   #        ----------- Cacheline ----------  LLC Hit   LLC Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
> >   # Index             Address  Node  PA cnt      Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
> >   # .....  ..................  ....  ......  .......  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
> >   #
> >         0      0x563b01e83100     0    1401   65.32%       648     7011     3738     3273     2582      691      515     2516       59       143      505         0        0         0         0
> >         1      0x563b01e830c0     0       1   26.51%       263      400      400        0        0        0      130        3        4       262        1         0        0         0         0
> >         2      0x563b01e83080     0       1    7.76%        77      650      650        0        0        0      180      348       45        14       63         0        0         0         0
> >         3  0xffff88c3d74e82c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0
> >         4  0xffffa587c11e38c0   N/A       0    0.10%         1        2        1        1        1        0        0        0        0         1        0         0        0         0         0
> >         5  0xffffffffbd5e6fc0     0       1    0.10%         1        1        1        0        0        0        0        0        0         0        1         0        0         0         0
> >         6      0x7f90a4d6c2c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0
> >
> >   =================================================
> >         Shared Cache Line Distribution Pareto
> >   =================================================
> >   #
> >   #        ---- LLC LD ----  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
> >   #   Num   LclHit  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
> >   # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
> >   #
> >     -------------------------------------------------------------
> >         0      143      505     2582      691      0x563b01e83100
> >     -------------------------------------------------------------
> >             96.50%    7.72%   46.79%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c16         0      1949      1331     1876         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
> >              0.00%   35.05%    0.00%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c1d         0      2651       975      748         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
> >              0.00%   30.89%    0.00%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c1d         0      1425      1003      762         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
> >              2.10%    7.52%   49.19%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c16         0      1585      1053     2037         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
> >              0.00%    0.00%    2.52%   44.86%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c28         0         0         0      375         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
> >              0.00%    0.00%    1.51%   55.14%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c28         0         0         0      420         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
> >              1.40%   12.87%    0.00%    0.00%                0x20     0       1    14100    14104:reader_thd      0x563b01c81c73         0       166        99      417         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
> >              0.00%    5.94%    0.00%    0.00%                0x20     0       1    14100    14105:reader_thd      0x563b01c81c73         0       144        85      376         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
> >
> >   [...]
> >
> >
> > Leo Yan (8):
> >   perf mem: Add structure field c2c_stats::tot_llchit
> >   perf c2c: Add dimensions for total LLC hit
> >   perf c2c: Add dimensions for LLC load hit
> >   perf c2c: Change to general naming for macros
> >   perf c2c: Rename for shared cache line stats
> >   perf c2c: Refactor hist entry validation
> >   perf c2c: Add option '-d llc' for sorting with LLC load
> >   perf c2c: Update documentation for display option 'llc'
> >
> >  tools/perf/Documentation/perf-c2c.txt |  18 +-
> >  tools/perf/builtin-c2c.c              | 333 +++++++++++++++++++++-----
> >  tools/perf/util/mem-events.c          |   3 +
> >  tools/perf/util/mem-events.h          |   1 +
> >  4 files changed, 286 insertions(+), 69 deletions(-)
> >
> > --
> > 2.17.1
> >
