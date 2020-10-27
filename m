Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6D29A2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438748AbgJ0DKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56317 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437204AbgJ0DKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:04 -0400
Received: by mail-pj1-f67.google.com with SMTP id c17so32842pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qsxLxI7Zj+8rzoe1AJgxef479sTAYlEWtKyPSl0veMo=;
        b=fckYQ0nqQ942Oj0KUsdWq4BjBhrGKL7CtDd+F8zu+du+gWJ0B338ZFVgLKQnWE2Jru
         vcejcyVPuK9afcQbw0Ghv7oRBxmsyaRimnNIOCbctj6bo0ut7mMeXiKpPYXSw3+ydQCL
         DyeXnjkCfFjA7jI/9PUZIZp0wPjE6868kC7t/3bexsK1JXI+OpjX4tpBqWOHSUTc67Ff
         DX7o4LLArRZcVc37bzDKItxKAImT2W1G09UuhiOuNuUM9wV9FYmbC4NQyfsssI0Cx+4W
         OAejDwYvC8eHfStY55xfVtOWb55RCTvF2htOWcKKxUuhDGhgqWEs2L4nBLFZs+fiJTIC
         rAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qsxLxI7Zj+8rzoe1AJgxef479sTAYlEWtKyPSl0veMo=;
        b=mkQUErNP4EuYhtX+8dZ71YbaZck7FeKKZWR90o+bnP9EpN2jo2RKnoJ87hXvAhTuZK
         3BQ5wAeXpyL9CMldn+n3UPOrelxgvt+DUlstRKIAAZcU/fcDZmgoP3oiP5D8ELkXrcTW
         tXomVGhqIDbcDheYbDBOSwxMsi5ehHNOIU7w7jeIpeKOvOu7apXtokFmK4NzCqUsNpIA
         HjStW8ziZvE9fwt9GESiaPSFdOXb1y3wLU0qxb4Gn+jGwA6Oa8v4ZfRiWfIjUFgfsYjw
         ihxSwm9vB0aboqqClcew7aLHUgksdfyt2el9xSymsMHV0SMLU416Hiqu04plwGUqtjme
         1sJw==
X-Gm-Message-State: AOAM533RYw4MgYgklmkeEicGorfJzKPP2qTEqgSYnB+CQ4VLFgK97ag7
        3488KgEafrIvAwWnuvwRZ/HCqw==
X-Google-Smtp-Source: ABdhPJzwoPtxtctfuVNAWEKn8J3fG01thJYZntBhNxLPRXB9tCJoMDM4B0O9xXeR4cklb46ttrcplQ==
X-Received: by 2002:a17:90a:4684:: with SMTP id z4mr62188pjf.97.1603768203485;
        Mon, 26 Oct 2020 20:10:03 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id v13sm25781pgl.6.2020.10.26.20.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:02 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 00/21] perf arm-spe: Refactor decoding & dumping flow
Date:   Tue, 27 Oct 2020 11:08:56 +0800
Message-Id: <20201027030917.15404-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v4 for refactoring Arm SPE trace decoding and dumping.
It follows Andre's suggestions for minor improvement comparing to patch
set v3.

This patch set is to refactor the Arm SPE decoding with:

- Patches 01, 02 are minor cleans up for header, typos;
- Patches 03, 04 and 05 are used to fix and polish the packet and
  payload length calculation;
- Patch 06 is to add a helper to wrap up printing strings, this can
  avoid bunch of duplicate code lines;
- Patches 07 ~ 19 are used to refactor decoding for different types
  packet one by one; in this patch set it introduces a new patch
  "perf arm_spe: Fixup top byte for data virtual address" to fixup
  the data virtual address for 64KB pages;
- Patch 20 comes from Andre to dump memory tagging;
- Patch 21 comes from Wei Li to add decoding for ARMv8.3 SVE extension.

This patch set is cleanly applied on the top of perf/core branch
with commit 7cf726a59435 ("Merge tag 'linux-kselftest-kunit-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest"),
And I tested this patch set on Hisilicon D06 platform with commands
"perf script" and "perf script -D".


Changes from v3:
- Refined arm_spe_payload_len() and removed macro SPE_HEADER_SZ()
  (Andre);
- Refined packet header index macros (Andre);
- Added patch "perf arm_spe: Fixup top byte for data virtual address" to
  fixup the data virtual address for 64KB pages and refined comments for
  the fixup (Andre);
- Added Andre's review tag (using "b4 am" command);
- Changed the macros to SPE_PKT_IS_XXX() format to check operation types
  (Andre);

Changes from v2:
- Tried best to address Andre's comments and refined patches;
- Added new patches 08, 11, 13, 16 for introducing new functions for
  packets parsing (Andre);
- Removed size condition checking for event packet (Andre);
- Used PKT_XXX_GET() form to replace PKT_XXX_MASK()/PKT_XXX_SHIFT()
  (Andre).

Changes from v1:
- Heavily rewrote the patch 05 for refactoring printing strings; this
  is fundamental change, so adjusted the sequence for patches and moved
  the printing string patch ahead from patch 10 (v1) to patch 05;
- Changed to use GENMASK_ULL() for bits mask;
- Added Andre's patch 13 for dumping memory tagging;
- Refined patch 12 for adding sub classes for Operation packet, merged
  some commit log from Andre's patch, which allows commit log and code
  to be more clear; Added "Co-developed-by: Andre Przywara" tag to
  reflect this.


Andre Przywara (1):
  perf arm_spe: Decode memory tagging properties

Leo Yan (19):
  perf arm-spe: Include bitops.h for BIT() macro
  perf arm-spe: Fix a typo in comment
  perf arm-spe: Refactor payload size calculation
  perf arm-spe: Refactor arm_spe_get_events()
  perf arm-spe: Fix packet length handling
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

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  63 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 654 +++++++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
 4 files changed, 541 insertions(+), 315 deletions(-)

-- 
2.17.1

