Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFE28F536
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgJOOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgJOOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so3859287wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ln3e9nu8VJ84TIr7VxH2ace7jWgPYrLwv61ZLC63z08=;
        b=btiomBcyiTTet8+XP4D+27z6SfkqwGkw/xNvT53VQtTXymimjkla4oZfLvdj+wm4H0
         rsQ9EbUkLVwPDG4b67+fDulIlEUUq50O2OFIcuqLDMhImtGM7Agawvru3NsgLic5KdGX
         QefDoUQPCUndB0EvsJPYXuvZKaLa9MjbNwgePoVAosDQngi/kviIQZ6jT1659aNTde0s
         EIopIu184vxUSNA3baux4jnvSUOOkntwypJ2hhNKwFYzzzgG9a/RbMdxGPO0HxxJYHpk
         D3/lrKZJD1q4JzSteQYj+iYVnPKsjPGTX/fJRIMuE4VPoT50zZU/oCpaWMLX97ol5wIr
         GVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ln3e9nu8VJ84TIr7VxH2ace7jWgPYrLwv61ZLC63z08=;
        b=hh9tBuTtIDS7PKDNTwNtL21GMuO1Y9VSFWTWCh5m5mTSsgj1UZtu1NQRb8ZFmbknxB
         YO6Ty/eMna4SKh64hlYI4KSGhMDl0JTsYVDV6znUh3uKDNi/YwgxVfejdOsaZyEP84yf
         4M7T/thUD2KUpYu8HaC96O3e/uML5CfO/qXczqY/1fVTXPBUlZt8Xn1KRicaCfgB/1n1
         m57knJWXLnhPhCdY06ObV7Bn/4nS0bVdVMUSFAzJNpvV9Cf7TMBvrEPaYRxCLfiC0dLZ
         xN+96R2+ZvJ4x2KpBgl2IbIlsQ/XngdbMoapvtfnh6IeNFuVg97S6QlPnhvS93tfqgbd
         6ImQ==
X-Gm-Message-State: AOAM532oABZOwsQDAw6yRHFf06K7PwdMp4kkI2sSwDT7L5fN403Ozz0F
        IRtYY+ZVmXVBwP05xWHYwwf7wg==
X-Google-Smtp-Source: ABdhPJxIrgJXLSTJyeZKcXi/4EnDm3PAQx0PZUKP9Mg4RInoPZhxh4mGutGRdpgYtQoamlXW9yTiPQ==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr4947537wrw.18.1602773460468;
        Thu, 15 Oct 2020 07:51:00 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:50:59 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/8] perf c2c: Sort cacheline with LLC load
Date:   Thu, 15 Oct 2020 15:50:33 +0100
Message-Id: <20201015145041.10953-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory event doesn't contain HITM tag (like Arm SPE), it cannot
rely on HITM display to report cache false sharing.  Alternatively, we
can use the LLC access and multi-threads info to locate the potential
false sharing's data address, and if we connect with source code and
analyze the multi-threads' execution timing, if can conclude load and
store the same cache line at the meantime, thus this can be helpful for
resolve the cache false sharing issue.

This patch set is to enable the display with sorting on LLC load
accesses; it adds dimensions for total LLC hit and LLC load accesses,
and these dimensions are used for shared cache line table and pareto.

This patch set is dependend on the patch set "perf c2c: Refine the
organization of metrics" [1].

[1] https://lore.kernel.org/patchwork/cover/1321499/

With this patch set, we can get display 'llc' as follows:

  # perf c2c report -d llc --coalesce tid,pid,iaddr,dso --stdio

  [...]

  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #        ----------- Cacheline ----------  LLC Hit   LLC Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt      Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x563b01e83100     0    1401   65.32%       648     7011     3738     3273     2582      691      515     2516       59       143      505         0        0         0         0
        1      0x563b01e830c0     0       1   26.51%       263      400      400        0        0        0      130        3        4       262        1         0        0         0         0
        2      0x563b01e83080     0       1    7.76%        77      650      650        0        0        0      180      348       45        14       63         0        0         0         0
        3  0xffff88c3d74e82c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0
        4  0xffffa587c11e38c0   N/A       0    0.10%         1        2        1        1        1        0        0        0        0         1        0         0        0         0         0
        5  0xffffffffbd5e6fc0     0       1    0.10%         1        1        1        0        0        0        0        0        0         0        1         0        0         0         0
        6      0x7f90a4d6c2c0     0       1    0.10%         1        1        1        0        0        0        0        0        0         1        0         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        ---- LLC LD ----  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
  #   Num   LclHit  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
  # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
  #
    -------------------------------------------------------------
        0      143      505     2582      691      0x563b01e83100
    -------------------------------------------------------------
            96.50%    7.72%   46.79%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c16         0      1949      1331     1876         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
             0.00%   35.05%    0.00%    0.00%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c1d         0      2651       975      748         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%   30.89%    0.00%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c1d         0      1425      1003      762         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             2.10%    7.52%   49.19%    0.00%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c16         0      1585      1053     2037         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
             0.00%    0.00%    2.52%   44.86%                 0x0     0       1    14100    14102:lock_th         0x563b01c81c28         0         0         0      375         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             0.00%    0.00%    1.51%   55.14%                 0x0     0       1    14100    14103:lock_th         0x563b01c81c28         0         0         0      420         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
             1.40%   12.87%    0.00%    0.00%                0x20     0       1    14100    14104:reader_thd      0x563b01c81c73         0       166        99      417         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
             0.00%    5.94%    0.00%    0.00%                0x20     0       1    14100    14105:reader_thd      0x563b01c81c73         0       144        85      376         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0

  [...]


Leo Yan (8):
  perf mem: Add structure field c2c_stats::tot_llchit
  perf c2c: Add dimensions for total LLC hit
  perf c2c: Add dimensions for LLC load hit
  perf c2c: Change to general naming for macros
  perf c2c: Rename for shared cache line stats
  perf c2c: Refactor hist entry validation
  perf c2c: Add option '-d llc' for sorting with LLC load
  perf c2c: Update documentation for display option 'llc'

 tools/perf/Documentation/perf-c2c.txt |  18 +-
 tools/perf/builtin-c2c.c              | 333 +++++++++++++++++++++-----
 tools/perf/util/mem-events.c          |   3 +
 tools/perf/util/mem-events.h          |   1 +
 4 files changed, 286 insertions(+), 69 deletions(-)

-- 
2.17.1

