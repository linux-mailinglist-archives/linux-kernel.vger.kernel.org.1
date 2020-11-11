Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3157A2AE96C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKKHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:20 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:20 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id g19so224392pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8u0DVNvzSka5b+NLmeV/T0ByUaduRjsHxLBf5XbcyO8=;
        b=rxP9MPXd8CnDqecDyAgcGz3FIOYHvpx2QP/ETpuyu5xE+OJ6mzTRc822uK6f3PikAO
         Z0M5YSWMccuIiL7CpKuKVmhRr4981q1bm9iB06OcKQnydIyMnuh8frrPXsw0/V3koKDa
         i6zJqwoNbE8Y/I5z72IeGK2Q8sszAhXn/0tTFdGqbAfpK54hcCU6putFluEUet7eycyv
         H2o0Lta78Buhur0Md7ZrQORK5HlD/6gnGlYsAiCWWFDVuB5uQ5MTN04OT5SvD4BQwt5S
         4qgeJJ6dTwx2rHulU8xnfDZ4wIMjRJtHRd8jhI2RTrvzZAum/IyzOg/OCyDGPYxcZjaw
         JUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8u0DVNvzSka5b+NLmeV/T0ByUaduRjsHxLBf5XbcyO8=;
        b=j7aKUKeU24TREBxw/29BKSFgevFZdhkAMMTp8uxcU+Qn/xeawEMYXyN+xLKUCFioV6
         HrMf0kzBfotMJzgCFtC/fmojRWbNLEUntoBec2ZnDv3tg6PiON5V3iJeMm6a7JgodvGa
         RfFf4odESZzjUJgWTsG6PjVshUGuRTUharjS6iiANiv3FmGzymGH/SJ2S6Iz/5Er2vFU
         D2BghgPd+gV/yXNSoRNovHgj6wZH6Itoo/AlJkAOOCkzOYapb2RqJ/uhatAY/njmVqOO
         z0fH0yx1ytNUgPZgUTtLh+1YUeOPOxHrzI2d/ivVdfoX33Qu1gZOeTvlF7tNDsDPLuay
         CzTw==
X-Gm-Message-State: AOAM5311ERV8LW85x8Y43uUiF9xIQZYz0lD2Y1n/znqJti/CU4vuTUJ4
        bLlodZ0w9qB2mHQGo9BTdzKbjA==
X-Google-Smtp-Source: ABdhPJwe98gWMMo5Sui78lf9Mk/3MrRde5aMrvsJCcfXv7DnfFdbXLftXGn2u0e3wok07E8ce4jcig==
X-Received: by 2002:a17:90a:5508:: with SMTP id b8mr2541832pji.85.1605078739654;
        Tue, 10 Nov 2020 23:12:19 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id y129sm1184752pgy.84.2020.11.10.23.12.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:18 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 00/22] perf arm-spe: Refactor decoding & dumping flow
Date:   Wed, 11 Nov 2020 15:11:27 +0800
Message-Id: <20201111071149.815-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v8 for refactoring Arm SPE trace decoding and dumping.

This version addresses Andre's comment to pass parameter '&buf_len' at
the last call arm_spe_pkt_snprintf() in the function arm_spe_pkt_desc().

This patch set is cleanly applied on the top of perf/core branch
with commit 644bf4b0f7ac ("perf jevents: Add test for arch std events").

I retested this patch set on Hisilicon D06 platform with commands
"perf report -D" and "perf script", compared the decoding results
between with this patch set and without this patch set, "diff" tool
shows the result as expected.

Changes from v7:
- Changed to pass '&buf_len' for the last call arm_spe_pkt_snprintf() in
  the patch 07/22 (Andre).

Changes from v6:
- Removed the redundant comma from the string in the patch 21/22 "perf
  arm_spe: Decode memory tagging properties" (Dave);
- Refined the return value for arm_spe_pkt_desc(): returns 0 for
  success, otherwise returns non zero for failures; handle error code at
  the end of function arm_spe_pkt_desc(); this is accomplished in the
  new patch 07/22 "perf arm-spe: Consolidate arm_spe_pkt_desc()'s
  return value" (Dave).

Changes from v5:
- Directly bail out arm_spe_pkt_snprintf() if any error occurred
  (Andre).

Changes from v4:
- Implemented a cumulative error for arm_spe_pkt_snprintf() and changed
  to condense code for printing strings (Dave);
- Changed to check payload bits [55:52] for parse kernel address
  (Andre).

Changes from v3:
- Refined arm_spe_payload_len() and removed macro SPE_HEADER_SZ()
  (Andre);
- Refined packet header index macros (Andre);
- Added patch "perf arm_spe: Fixup top byte for data virtual address" to
  fixup the data virtual address for 64KB pages and refined comments for
  the fixup (Andre);
- Added Andre's review tag (using "b4 am" command);
- Changed the macros to SPE_PKT_IS_XXX() format to check operation types
  (Andre).


Andre Przywara (1):
  perf arm_spe: Decode memory tagging properties

Leo Yan (20):
  perf arm-spe: Include bitops.h for BIT() macro
  perf arm-spe: Fix a typo in comment
  perf arm-spe: Refactor payload size calculation
  perf arm-spe: Refactor arm_spe_get_events()
  perf arm-spe: Fix packet length handling
  perf arm-spe: Refactor printing string to buffer
  perf arm-spe: Consolidate arm_spe_pkt_desc()'s return value
  perf arm-spe: Refactor packet header parsing
  perf arm-spe: Add new function arm_spe_pkt_desc_addr()
  perf arm-spe: Refactor address packet handling
  perf arm_spe: Fixup top byte for data virtual address
  perf arm-spe: Refactor context packet handling
  perf arm-spe: Add new function arm_spe_pkt_desc_counter()
  perf arm-spe: Refactor counter packet handling
  perf arm-spe: Add new function arm_spe_pkt_desc_event()
  perf arm-spe: Refactor event type handling
  perf arm-spe: Remove size condition checking for events
  perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
  perf arm-spe: Refactor operation packet handling
  perf arm-spe: Add more sub classes for operation packet

Wei Li (1):
  perf arm-spe: Add support for ARMv8.3-SPE

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  59 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 601 ++++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
 tools/perf/util/arm-spe.c                     |   2 +-
 5 files changed, 479 insertions(+), 322 deletions(-)

-- 
2.17.1

