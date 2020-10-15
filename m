Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F628F57C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgJOPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388686AbgJOPFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:05:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A70C2222E;
        Thu, 15 Oct 2020 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602774309;
        bh=Fow4LQyPPinMQcRWB9US4eWEibw3Y8ad9iHgyhJNVyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15TN5IQnye1dLAq8ayehrB4d+Z4UqxkdhcoJCor8IUO4h0jP1hR089gi6tzx3tYlQ
         X0XHHsgK9Q30lziEwNzpWofPff6DFIMWtWPJb6w0F1qmIt7v09TyDSMb+J7oXtXHv2
         pRrbaZpQ9CVOJoyDziqRi+3jY+49WvkFwF+asfUo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A5B54047F; Thu, 15 Oct 2020 12:05:06 -0300 (-03)
Date:   Thu, 15 Oct 2020 12:05:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] perf c2c: Sort cacheline with LLC load
Message-ID: <20201015150506.GB2959014@kernel.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 15, 2020 at 03:50:33PM +0100, Leo Yan escreveu:
> If the memory event doesn't contain HITM tag (like Arm SPE), it cannot
> rely on HITM display to report cache false sharing.  Alternatively, we
> can use the LLC access and multi-threads info to locate the potential
> false sharing's data address, and if we connect with source code and
> analyze the multi-threads' execution timing, if can conclude load and
> store the same cache line at the meantime, thus this can be helpful for
> resolve the cache false sharing issue.
> 
> This patch set is to enable the display with sorting on LLC load
> accesses; it adds dimensions for total LLC hit and LLC load accesses,
> and these dimensions are used for shared cache line table and pareto.
> 
> This patch set is dependend on the patch set "perf c2c: Refine the
> organization of metrics" [1].
> 
> [1] https://lore.kernel.org/patchwork/cover/1321499/

Ok, that one is applied and will appear publicly as soon as it goes thru
my usual set of build tests.

- Arnaldo
 
> With this patch set, we can get display 'llc' as follows:
> 
>   # perf c2c report -d llc --coalesce tid,pid,iaddr,dso --stdio
> 
>   [...]
> 
>   =================================================
>              Shared Data Cache Line Table
>   =================================================
>   #
>   #        ----------- Cacheline ----------  LLC Hit   LLC Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt      Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0x563b01e83100     0    1401   65.32%       648     7011     3738     3273     2582      691      515     2516       59       143      505         0        0         0         0
>         1      0x563b01e830c0     0       1   26.51%       263      400      400        0        0        0      130        3        4       262        1         0        0         0         0
>         2      0x563b01e83080     0       1    7.76%        77      650      650        0        0        0      180      348       45        14       63         0        0         0         0
>         3  0xffff88c3d74e82c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0
>         4  0xffffa587c11e38c0   N/A       0    0.10%         1        2        1        1        1        0        0        0        0         1        0         0        0         0         0
>         5  0xffffffffbd5e6fc0     0       1    0.10%         1        1        1        0        0        0        0        0        0         0        1         0        0         0         0
>         6      0x7f90a4d6c2c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto
>   =================================================
>   #
>   #        ---- LLC LD ----  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
>   #   Num   LclHit  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
>   # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
>   #
>     -------------------------------------------------------------
>         0      143      505     2582      691      0x563b01e83100
>     -------------------------------------------------------------
>             96.50%    7.72%   46.79%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c16         0      1949      1331     1876         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
>              0.00%   35.05%    0.00%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c1d         0      2651       975      748         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>              0.00%   30.89%    0.00%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c1d         0      1425      1003      762         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>              2.10%    7.52%   49.19%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c16         0      1585      1053     2037         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
>              0.00%    0.00%    2.52%   44.86%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c28         0         0         0      375         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>              0.00%    0.00%    1.51%   55.14%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c28         0         0         0      420         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>              1.40%   12.87%    0.00%    0.00%                0x20     0       1    14100    14104:reader_thd      0x563b01c81c73         0       166        99      417         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
>              0.00%    5.94%    0.00%    0.00%                0x20     0       1    14100    14105:reader_thd      0x563b01c81c73         0       144        85      376         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
> 
>   [...]
> 
> 
> Leo Yan (8):
>   perf mem: Add structure field c2c_stats::tot_llchit
>   perf c2c: Add dimensions for total LLC hit
>   perf c2c: Add dimensions for LLC load hit
>   perf c2c: Change to general naming for macros
>   perf c2c: Rename for shared cache line stats
>   perf c2c: Refactor hist entry validation
>   perf c2c: Add option '-d llc' for sorting with LLC load
>   perf c2c: Update documentation for display option 'llc'
> 
>  tools/perf/Documentation/perf-c2c.txt |  18 +-
>  tools/perf/builtin-c2c.c              | 333 +++++++++++++++++++++-----
>  tools/perf/util/mem-events.c          |   3 +
>  tools/perf/util/mem-events.h          |   1 +
>  4 files changed, 286 insertions(+), 69 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
