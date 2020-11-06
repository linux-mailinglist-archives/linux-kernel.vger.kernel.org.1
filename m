Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D812A8C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgKFBmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbgKFBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:41:59 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:41:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so1792379pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sjQ2H9YOVTeVxNU5zD3a+u4W6ygBgt3MbjFKD0M5Cuc=;
        b=NuqI2DONgBZIwLep997PRYKcf7OgJf4SN4aju9G4Cr2TAtbNxfissF8NvoxOSzIfzl
         ONMU4J6V38R+MaFMpoPPn0ifxHfc/AubROc2SML0WrzmMvN/KRr+Sgdkd5+ggZXRZm5i
         oaePGHMmBXONzhtU7zgFMQyEDeVDdfJQ9y/OkPhm4At6QgToD5MFTbRIllqO0rGNdChe
         bnvX6kDSpSb+86mz8AQmNfcvDF5dqcRkJFAw5ULUA9P0U5fFNSHhANwYO0N+sm4GRhft
         CZhJhlPElcB7/zZpFmtGTPPFNb3luuNQ50/3ob7j6N8fHMjTwACceN6hz7HvVZGg2puC
         18Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sjQ2H9YOVTeVxNU5zD3a+u4W6ygBgt3MbjFKD0M5Cuc=;
        b=dy7S4sl6GUANQA2THW0O2BtAeR5WwlOV4gtVTrZk0wBPnZRk1FnJhsUBk8kFqpBAWI
         ZouwAIN9MmeAaKpQUILImgIInQ1Ol4JFd9ORdnM01PPk04p5NrXv/7ArAdkXh37FLym1
         mPt08bPn+6ksaUEUrY2knilAKIPG2EsH0l9x/2iDrCjBQ14DvhtSadaKnUTgybbK34t8
         uOImzbvss5WGzvVM3OoSj6ksY6kmIieKchIALTO203uesmiq8GfDVeTon+rZBeDF5X9c
         DL+vMzOa9Sru67ZArL412nNPHmgaoL4ZGu2H2Ii1Kk4CVANkepeLBlcm/oWYOophf0c7
         bZ4w==
X-Gm-Message-State: AOAM5326p9qbWv/1uUU9zjpY2BmpBMH4RB/bE5nj0UoWJP2eIyf7AqE8
        svibIeVZW/ZjrFL72qBJvrLS/w==
X-Google-Smtp-Source: ABdhPJxoBqUH68D7AmdirkLTH+ZsOW+vhUj1bLeJM37QlbHOPo7S4zyf8UxtumGfrxQixKOCzjzPlQ==
X-Received: by 2002:a63:4960:: with SMTP id y32mr4911405pgk.369.1604626917636;
        Thu, 05 Nov 2020 17:41:57 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id h5sm3476135pjs.41.2020.11.05.17.41.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:41:56 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 00/22] perf arm-spe: Refactor decoding & dumping flow
Date:   Fri,  6 Nov 2020 09:41:14 +0800
Message-Id: <20201106014136.14103-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v7 for refactoring Arm SPE trace decoding and dumping.
It follows Dave's comment to consolidate the return value for
arm_spe_pkt_desc().

This patch set is cleanly applied on the top of perf/core branch
with commit 7b3bcedf5ee5 ("perf scripting python: Avoid declaring
function pointers with a visibility attribute").

Have tested this patch set on Hisilicon D06 platform with commands
"perf report -D" and "perf script", compared the decoding results
between with this patch set and without this patch set, didn't find
issue with "diff" tool.

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

