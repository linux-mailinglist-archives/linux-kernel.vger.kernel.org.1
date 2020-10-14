Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2650928DBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgJNIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgJNIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:44:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3186C04584B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n15so2172790wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W6T0jppUpRS5f8Ffh23Z+KWSdGOH/gu/luscJ6UxZuo=;
        b=n43I1cNYzvDiig7PTfNY37nSXZLoK8sKrLhdiz0QfB4hO/OSDpiqwSE/0m2u7rZUdg
         VnaAB6T81ZmHT3Ps+bWjf0X9ZrviP+QIaKIiWPstouu9hRTFhzWtN5jJvIV+MrVCeGb6
         JTEaCrSmgXMg5RClECMblaryj5EBeBKTqY6e+/0J8yIiF5q19DyAVSEcUGruzAIKsP9w
         kbDTCYv1fo9TRF1t3uESAP0t7MX2h8j2bMVYUY0x6xBddzJoDwVyiaRihT95iNVP27gu
         l4RFPm/uN5TFQHJiGFeqp6q31JuGl0T4O+xOBsT941TB2kiptXyd+b8JMXtTBt2+PgcE
         bKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W6T0jppUpRS5f8Ffh23Z+KWSdGOH/gu/luscJ6UxZuo=;
        b=Sod7ujN+V4BqeU+9xetz4kz+9uOZn9ahu8+m6NcuG0i2JyTxytAEd2kqXrZMR1k/qv
         GsXb5jxxxChmBsp8cm9s3rrxxHkNrsJ4LofdGuyDQQ+KtGbtjZk639YsMv1fNyWdt8z+
         nP2HtvhTXIVoFkgXRSSFh0t9TWr93Uy5ujm/QIjF68X650kxgf0sIkeotGKUZlmFr8VF
         iyHkkf4aIRIcFQw0V7lmJfIVJYCPv8oVqtNaJgQEjRyn9LSFTeKUl4kyBdPslRS9imgR
         GBG8LxJrjlG8RdRIdTo34NDxADEJWyXvzu/pXs9M/Qu34Vo2tcyh3QqTx4iBD2t9e8ko
         qlsg==
X-Gm-Message-State: AOAM531oCozXOC/u11zVrSUnWqsaVbOQ8LjZqv8/wGr/v9HekP5RuJIq
        TBbObbNMRRT5obsK/Qg2YoI/5w==
X-Google-Smtp-Source: ABdhPJyzyDXDbB2dToG8X469ZuTxHkyTdPJ9JE8R9VM5fGpej6VTnkCoUu22VcnZPffgGh2MVGFNPg==
X-Received: by 2002:a5d:4141:: with SMTP id c1mr3139197wrq.113.1602652171675;
        Tue, 13 Oct 2020 22:09:31 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/8] perf c2c: Refine the organization of metrics
Date:   Wed, 14 Oct 2020 06:09:13 +0100
Message-Id: <20201014050921.5591-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to refine metrics output organization.

If we reivew the current memory metrics in Perf c2c tool, it doesn't
orgnize the metrics with directive approach; thus user needs to take
time to dig into every statistics item.  On the other hand, if use the
"summary and breakdown" approach, the output result will be easier for
reviewing by users, e.g. the output result can firstly give out the
summary values, and then the later items will breakdown into more
detailed statistics.

For this reason, this patch is to reorgnize the metrics and it only
changes for the "Shared Data Cache Line Table": it firstly displays the
summary values for total records, total loads, total stores; then it
breaks these summary values into small values, with the order from the
most near memory node ("CPU Load Hit") to more far nodes
("LLC Load Hit", "RMT Load Hit", "Load Dram").

  "LLC Load Hit" = "LclHit" + "LclHitm"

  "RMT Load Hit" = "RmtHit" + "RmtHitm" \
                                         ->  LLC Load Miss
  "Load Dram"    = "Lcl" + "Rmt"        /

Another main reason for this patch set is wanting to extend "perf c2c"
to support Arm SPE memory event, but Arm SPE doesn't contain 'HTIM' tag
in its default trace data, for this case if want to analyze cache false
sharing issue, we need to rely on LLC metrics + multi-threading info.
So this patch set can be friendly to show LLC related metrics in the
"Shared Data Cache Line Table"; for sorting cache lines with LLC metrics
which will be sent out with another separate patch set.

Before:

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----  ---- Store Reference ----  --- Load Dram ----      LLC    Total  ----- Core Load Hit -----  -- LLC Load Hit --
# Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt    Total    L1Hit   L1Miss       Lcl       Rmt  Ld Miss    Loads       FB       L1       L2       Llc       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  .......  ........  ........
#
      0      0x55acdcc92100     0    8197    40716   52.18%     3170     3170        0    24466    24437       29         0         0        0    16250     3349     5909        0      3822         0
      1      0x55acdcc920c0     0       1     4621   31.01%     1884     1884        0        0        0        0         0         0        0     4621      739        0        0      1998         0
      2      0x55acdcc92080     0       1     4475   16.69%     1014     1014        0        0        0        0         0         0        0     4475     2405        0        0      1056         0


After:

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
#
      0      0x55acdcc92100     0    8197   52.18%     3170     3170        0    40716    16250    24466    24437       29     3349     5909        0      3822     3170         0        0         0         0
      1      0x55acdcc920c0     0       1   31.01%     1884     1884        0     4621     4621        0        0        0      739        0        0      1998     1884         0        0         0         0
      2      0x55acdcc92080     0       1   16.69%     1014     1014        0     4475     4475        0        0        0     2405        0        0      1056     1014         0        0         0         0


Leo Yan (8):
  perf c2c: Display the total numbers continuously
  perf c2c: Display "Total Stores" as a standalone metrics
  perf c2c: Organize metrics based on memory hierarchy
  perf c2c: Change header from "LLC Load Hitm" to "Load Hitm"
  perf c2c: Use more explicit headers for HITM
  perf c2c: Change header for LLC local hit
  perf c2c: Correct LLC load hit metrics
  perf c2c: Add metrics "RMT Load Hit"

 tools/perf/builtin-c2c.c | 83 +++++++++-------------------------------
 1 file changed, 18 insertions(+), 65 deletions(-)

-- 
2.17.1

