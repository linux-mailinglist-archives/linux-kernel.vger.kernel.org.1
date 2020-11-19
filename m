Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8202B9619
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgKSPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgKSPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:24:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:24:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g7so4820367pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=phox4FUJenMVNqYANcB4eQ+O/EAizHfhsdqaJKB0e9g=;
        b=zboYoyhBR3WHytt1G4PF95Phfn8z5mlArN5Mz2rs0wabRMzvghqvFBUiOUiWo6uUrt
         iQ7H0P+MUDHqSFeIN7yYi0qAEMQv47bBpPFWuaxPg1dcpzhstWuFKl/A93kbGlDpyqcK
         W/H+fBUTChZ76IEQVcuXQeDIczcmAkr+2wpalDqrL7Y0Mf1kP70Z4C6WYjnG+Bc13uJM
         dHxzyMW5Le9v9aJbbfXBJOh53omVCZ26TO6iK4CeBVfS4aWE+obxFniMwvAi/2GZwdfD
         J0UuZIB/ATPHHm3O0oYF1IgOmXh/suN5tSC9AVQJZJQywfd0ykAVDnM4/qIutbHB7DtN
         +iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=phox4FUJenMVNqYANcB4eQ+O/EAizHfhsdqaJKB0e9g=;
        b=HTv8nzZkhq6rSd6Wn1TCvXurDjZelVKVqQ/KycNwAxfQJlBTeOQcUgJ2LhRNR4y6cA
         UGs7OqDT9NtyzzClTP/U8SVngcp/ViyebWFnBX7Sv8Ke17jKSx/ryaaNz7AbL16qCASp
         oSEG9AabaylUW2cXlNrIcfhoM+eTeJ5AXFPk9GBJ8t3cKDp6vZGI6eYy+BieTKVzL1nw
         Qn0TD24EXwcaDIgQPgmFeE7qpcD31DloPfh0qM02UUudGWUnA1k2F6lfGKCoWMKsq+rM
         8nUYS5hJghYjxuvUzDt03QafvE4Niwn/pNHzrnwbtwuwUTqQGLKr4KEN9rBiald1QvJg
         faUw==
X-Gm-Message-State: AOAM532wQ9Pj/tjvprtU6kam+8PbtjTzC1CbvnUC+uZGNTGNrQ6dikNH
        VDFhZaUUz54+k0NZP+v62aD5Sg==
X-Google-Smtp-Source: ABdhPJyl9yYHIr31s6MXUpcoVUshsuHXcCW3p7W0AXiIhomjq/GMHw+jQ0Ejas2GW+HLsR/kT/RLWQ==
X-Received: by 2002:a63:348:: with SMTP id 69mr13162978pgd.336.1605799493197;
        Thu, 19 Nov 2020 07:24:53 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id e22sm101440pfd.153.2020.11.19.07.24.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:24:52 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 00/16] perf arm-spe: Refactor decoding & dumping flow
Date:   Thu, 19 Nov 2020 23:24:25 +0800
Message-Id: <20201119152441.6972-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v9 for refactoring Arm SPE trace decoding and dumping.

According to comments and suggestions from patch set v8, it squashs the
two patches into single one: "perf arm-spe: Refactor printing string to
buffer" and "perf arm-spe: Consolidate arm_spe_pkt_desc()'s return
value".

In the patch 01/16, it renames the function arm_spe_pkt_snprintf() to
arm_spe_pkt_out_string(), since the function is not the same semantics
with snprintf(), the renaming can avoid confusion.

This patch set is cleanly applied on the top of perf/core branch
with commit 29396cd573da ("perf expr: Force encapsulation on
expr_id_data").

This patch set has been tested on Hisilicon D06 platform with commands
"perf report -D" and "perf script", compared the decoding results
between with this patch set and without this patch set, "diff" tool
shows the result as expected.

I also manually built the patches for arm/arm64/x86_64 and verfied
every single patch can build successfully.


Changes from v8:
- Squashed the two patches "perf arm-spe: Refactor printing string to
  buffer" and "perf arm-spe: Consolidate arm_spe_pkt_desc()'s return
  value" (Dave);
- Fixed the condition for vsnprintf()'s overrun to
  "if ((size_t)ret >= *blen)" (Dave);
- Renamed function arm_spe_pkt_snprintf() to arm_spe_pkt_out_string()
  (Dave/Arnaldo);
- Rebased on the latest perf/core branch.

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


Andre Przywara (1):
  perf arm_spe: Decode memory tagging properties

Leo Yan (14):
  perf arm-spe: Refactor printing string to buffer
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

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  54 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 542 ++++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
 tools/perf/util/arm-spe.c                     |   2 +-
 5 files changed, 455 insertions(+), 282 deletions(-)

-- 
2.17.1

