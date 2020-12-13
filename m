Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0247B2D8D51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406880AbgLMNjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406861AbgLMNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:39:41 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4BC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:01 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id q75so12825233wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8JknY1t9s/mW5J4DNfsNBSXJKLxDabzennsKCBHT5J4=;
        b=EOr0ilAJ+VQwZaVKNsqsjbZi4JR419cOHi6suki89tycOyVzjHnueBha7DbpmnobZI
         K3vHAC9sMH0Ot9GrtFkvso4BILEGnAcpUQI7QikLHZ1HzMzgRrgBrF747E3qENhkCFQt
         ejNCWc8mxhEM7AaNNzGodD1vc7G/WeXJwTk7YaD62ovSO7NWTTHkgeP8zvC4V+t/N0Gw
         lxIdOU3sf/rH15HDE5OvD57QLi9uMgb79dVVXtGvYEbprtaOTdl8QLte+jCq28btTFmp
         ig7ACV3/vvAYFe2fF/OaX7RAp02p3HmmN0RkTyv2x4GHwEfmAGdqi7OfckzVyt5CwN/3
         5YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8JknY1t9s/mW5J4DNfsNBSXJKLxDabzennsKCBHT5J4=;
        b=TWzx2Ih0XWTzLHj2Mu9/6lb3qU3XswYga179Aq285qXsywg5VRyT2W+EGPgGo5wIDS
         plWJdYA2yyTgaSYsX+GlSNWBH3U4huQNkszCR70WJLklnkuAv88gEVBL2i7KxkUxNmrp
         4CfIzNc/bgKhgX4qoyiGnM1hGKinT3jk9n4uvAW779I0w6uBSOYVv5VdKyyNkSj4v2fA
         gN9V38/5TadDx1IarU/CQCIbeHZix6GMqXZSiE3wdvdYg6AMaJ3trxtXXdXRW1mdmrud
         Pvdt35fjL0qqgqMnVI1FZdC9ku4MKp1uWTwrMiZpGWgiCuqC2sXZCqpxxqJ+W2HDteoF
         SRHQ==
X-Gm-Message-State: AOAM530sHK6wb4hvcsqSWyttM2f/lH+MwsntVVgE7rr4843vk/de+/wm
        OfcKBFbyJM1TTxUgzc0sXljpOg==
X-Google-Smtp-Source: ABdhPJxtPJt4g1MuD8Wuxun8CODVn5q6R21i9WlejNVAegci35666bZa4/AAGBJGdUmX3RtxNTY2kw==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr23206002wmc.130.1607866739811;
        Sun, 13 Dec 2020 05:38:59 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:38:58 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 00/11] perf c2c: Sort cacheline with all loads
Date:   Sun, 13 Dec 2020 13:38:39 +0000
Message-Id: <20201213133850.10070-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to sort cache line for all load operations which hit
any cache levels.  For single cache line view, it shows the load
references for loads with cache hits and with cache misses respectively.

This series is a following for the old patch set "perf c2c: Sort
cacheline with LLC load" [1], in the old patch set it tries to sort
cache line with the load operations in last level cache (LLC), after
testing we found the trace data doesn't contain LLC events if the
platform isn't a NUMA system.  For this reason, this series refines the
implementation to sort on all cache levels hits of load operations; it's
reasonable for us to review the load and store opreations, if detects
any cache line is accessed by multi-threads, this hints that the cache
line is possible for false sharing.

This patch set is clearly applied on perf/core branch with the latest
commit db0ea13cc741 ("perf evlist: Use the right prefix for 'struct
evlist' record methods").  And the changes has been tested on x86 and
Arm64, the testing result is shown as below.

The testing result on x86:

  # perf c2c record -- false_sharing.exe 2
  # perf c2c report -d all --coalesce tid,pid,iaddr,dso --stdio

  [...]

  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #        ----------- Cacheline ----------  Load Hit  Load Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt       Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  ........  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x556f25dff100     0    1895    75.73%      4591     7840     4591     3249     2633      616      849     2734       67        58      883         0        0         0         0
        1      0x556f25dff080     0       1    13.10%       794      794      794        0        0        0      164      486       28        20       96         0        0         0         0
        2      0x556f25dff0c0     0       1    10.01%       607      607      607        0        0        0      107        5        5       488        2         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        --  Load Refs --  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
  #   Num      Hit     Miss   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
  # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
  #
    -------------------------------------------------------------
        0     4591        0     2633      616      0x556f25dff100
    -------------------------------------------------------------
            20.52%    0.00%    0.00%    0.00%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc1d         0      2200      1276      942         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
            19.82%    0.00%   38.06%    0.00%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc16         0      2190      1130     1912         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
            18.25%    0.00%   56.63%    0.00%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc16         0      2173      1074     2329         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
            18.23%    0.00%    0.00%    0.00%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc1d         0      2013      1220      837         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%    3.11%   59.90%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc28         0         0         0      451         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%    2.20%   40.10%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc28         0         0         0      305         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
            12.00%    0.00%    0.00%    0.00%                0x20     0       1    28079    28083:reader_thd      0x556f25bfdc73         0       159       107      551         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
            11.17%    0.00%    0.00%    0.00%                0x20     0       1    28079    28084:reader_thd      0x556f25bfdc73         0       148       108      513         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0

  [...]


The testing result on Arm64 (Hisilicon D06); please note, the Arm SPE
data source patch set has not been merged into the mainline kernel and
a potential issue for store operations is working in progress, so the
final outputting result might have minor differences.

  # perf c2c record -- false_sharing.exe 2
  # perf c2c report -d all --coalesce tid,pid,iaddr,dso --stdio

  [...]

  =================================================
             Shared Data Cache Line Table          
  =================================================
  #
  #        ----------- Cacheline ----------  Load Hit  Load Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt       Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  ........  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0xaaaab4e8b100   N/A       0    35.04%    100447   104933   100447     4486     4486        0        0    11269        0     89178        0         0        0         0         0
        1      0xaaaab4e8af80   N/A       0    17.29%     49571    49571    49571        0        0        0        0    49571        0         0        0         0        0         0         0
        2      0xaaaab4e8afc0   N/A       0    16.72%     47922    47922    47922        0        0        0        0    47922        0         0        0         0        0         0         0
        3      0xaaaab4e8b080   N/A       0     8.94%     25641    67718    25641    42077    42077        0        0     4397        0     21244        0         0        0         0         0
        4      0xaaaab4e7a480   N/A       0     4.42%     12680    12680    12680        0        0        0        0    12680        0         0        0         0        0         0         0
        5      0xffffa2ffc980   N/A       0     2.62%      7511     7511     7511        0        0        0        0     7511        0         0        0         0        0         0         0
        6      0xffffa3ffe980   N/A       0     2.57%      7374     7374     7374        0        0        0        0     7374        0         0        0         0        0         0         0
        7      0xaaaab4e8b000   N/A       0     2.41%      6907     6907     6907        0        0        0        0     6907        0         0        0         0        0         0         0
        8      0xaaaab4e8b0c0   N/A       0     2.30%      6592     6592     6592        0        0        0        0     2822        0      3770        0         0        0         0         0
        9      0xffffa37fd980   N/A       0     2.24%      6408     6408     6408        0        0        0        0     6408        0         0        0         0        0         0         0
       10      0xffffb8d80980   N/A       0     2.18%      6254     6254     6254        0        0        0        0     6254        0         0        0         0        0         0         0
       11      0xffffb9d82980   N/A       0     1.31%      3763     9706     3763     5943     5943        0        0     3763        0         0        0         0        0         0         0
       12      0xffffb9581980   N/A       0     1.22%      3507    11484     3507     7977     7977        0        0     3507        0         0        0         0        0         0         0
       13      0xffffbad84980   N/A       0     0.33%       932     7766      932     6834     6834        0        0      932        0         0        0         0        0         0         0
       14      0xffffba583980   N/A       0     0.24%       700     6503      700     5803     5803        0        0      700        0         0        0         0        0         0         0
  
  =================================================
        Shared Cache Line Distribution Pareto      
  =================================================
  #
  #        --  Load Refs --  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared                                   
  #   Num      Hit     Miss   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
  # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
  #
    -------------------------------------------------------------
        0   100447        0     4486        0      0xaaaab4e8b100
    -------------------------------------------------------------
            15.44%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15049:lock_th         0xaaaab4e79dd0         0         0         0    15508         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   1
            14.43%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15048:lock_th         0xaaaab4e79dd0         0         0         0    14499         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
            11.57%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15048:lock_th         0xaaaab4e79db8         0         0         0    11622         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
            11.38%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15050:lock_th         0xaaaab4e79dd0         0         0         0    11429         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   2
            10.57%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15051:lock_th         0xaaaab4e79dd0         0         0         0    10614         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   3
             9.69%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15049:lock_th         0xaaaab4e79db8         0         0         0     9731         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   1
             5.74%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15050:lock_th         0xaaaab4e79db8         0         0         0     5763         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   2
             4.84%    0.00%    0.00%    0.00%                 0x0   N/A       0    15046    15051:lock_th         0xaaaab4e79db8         0         0         0     4866         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   3
             0.00%    0.00%   14.02%    0.00%                 0x0   N/A       0    15046    15048:lock_th         0xaaaab4e79dbc         0         0         0      629         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
             0.00%    0.00%    6.44%    0.00%                 0x0   N/A       0    15046    15048:lock_th         0xaaaab4e79de0         0         0         0      289         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%   12.37%    0.00%                 0x0   N/A       0    15046    15049:lock_th         0xaaaab4e79dbc         0         0         0      555         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   1
             0.00%    0.00%    6.46%    0.00%                 0x0   N/A       0    15046    15049:lock_th         0xaaaab4e79de0         0         0         0      290         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   1
             0.00%    0.00%   21.38%    0.00%                 0x0   N/A       0    15046    15050:lock_th         0xaaaab4e79dbc         0         0         0      959         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   2
             0.00%    0.00%    9.61%    0.00%                 0x0   N/A       0    15046    15050:lock_th         0xaaaab4e79de0         0         0         0      431         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   2
             0.00%    0.00%   22.14%    0.00%                 0x0   N/A       0    15046    15051:lock_th         0xaaaab4e79dbc         0         0         0      993         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   3
             0.00%    0.00%    7.58%    0.00%                 0x0   N/A       0    15046    15051:lock_th         0xaaaab4e79de0         0         0         0      340         2  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   3
             6.66%    0.00%    0.00%    0.00%                0x20   N/A       0    15046    15054:reader_thd      0xaaaab4e79e54         0         0         0     6687         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   2
             3.76%    0.00%    0.00%    0.00%                0x28   N/A       0    15046    15052:reader_thd      0xaaaab4e79e80         0         0         0     3774         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:159   0
             3.54%    0.00%    0.00%    0.00%                0x28   N/A       0    15046    15055:reader_thd      0xaaaab4e79e80         0         0         0     3551         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:159   3
             2.39%    0.00%    0.00%    0.00%                0x30   N/A       0    15046    15053:reader_thd      0xaaaab4e79eac         0         0         0     2403         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:163   1


  [...]

Changes from v1:
* Changed from sorting on LLC to sorting on all loads with cache hits;
* Added patches 06/11, 07/11 for refactoring macros;
* Added patch 08/11 for refactoring node header, so can display "%loads"
  rather than "%hitms" in the header;
* Added patch 09/11 to add local pointers for pointing to output metrics
  string and sort string (Juri);
* Added warning in percent_hitm() for the display "all", which should
  never happen (Juri).

[1] https://lore.kernel.org/patchwork/cover/1321514/


Leo Yan (11):
  perf c2c: Add dimensions for total load hit
  perf c2c: Add dimensions for load hit
  perf c2c: Add dimensions for load miss
  perf c2c: Rename for shared cache line stats
  perf c2c: Refactor hist entry validation
  perf c2c: Refactor display filter macro
  perf c2c: Refactor node display macro
  perf c2c: Refactor node header
  perf c2c: Add local variables for output metrics
  perf c2c: Sort on all cache hit for load operations
  perf c2c: Update documentation for display option 'all'

 tools/perf/Documentation/perf-c2c.txt |  21 +-
 tools/perf/builtin-c2c.c              | 548 ++++++++++++++++++++++----
 2 files changed, 487 insertions(+), 82 deletions(-)

-- 
2.17.1

