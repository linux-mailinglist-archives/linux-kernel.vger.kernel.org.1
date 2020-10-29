Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC429E432
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgJ2Hfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgJ2HY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1EC08EA7F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e7so1574859pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2tHRut4wb0vzsLC/I8fG8hkAw3z2CFBL3HsC3tKTNyU=;
        b=xQRKAlib9ilDzI2K+cYP6HoIiYFLU+AmdJ6CsHuX+gbkrxxBjJWNiKbxQhMXP7oK+T
         XGw3EWLmA05RpDjVGWL7ShvjYQXuiiVQibkwxqu8H9wxHNtFXtGy01OEGv6oewR+dzC8
         y7puOo5RNEema31SMgAPeFPzX8G7hj3pUt5fZpfQyyACHMtF7ea2e0c926xVWMufOal8
         JAIVhH07XZkCFqIjSY5pDEw72LoVUamd4YjxZKpydIeFChulOGkwvAoM93rGyIqczAjI
         W+gXNs618ThOzfOtMovUFER1pPoWsNnssdsSSZnB/3lb5A1E3Nh6VJRaqN4TtBadByhS
         F0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2tHRut4wb0vzsLC/I8fG8hkAw3z2CFBL3HsC3tKTNyU=;
        b=S0glHtDfsxIEMrzlVJQXbDICO1iYpn8FMTLWP81Fp9JbywiJCUlWaa6b04ugMXv9k9
         Zq5vnN5c3qsxh8hpib/7qFcL8xCHJdq8kVfP4nP7j0QUF/DPIOoJll98M9ACO5STFieJ
         N8YCdB5D7rTw7AvMW4Ao0oOfFPcH2F14WfOUjjB+RUq0hQHleVes16leXX9Ut6jIP/Ux
         J0uay1bUxwM/pSjngQpizyNhQ4L4ePXCI/gYO378RoYmxN/AkCXQbtMJ4kPW6jWB5nHr
         CSQqbS0gvsI0FonwSPML+a2MuuRHu9GyP9YuHs9S/FkILbP403AcbpnypNT8o4cWVGF7
         BL8A==
X-Gm-Message-State: AOAM5312SGVEq2PZPbemKMWFs512Ij+Ae4noT94ReikT1qSd8eixLKoO
        5Sl3A877VdrXsXnce40iuhBbsQ==
X-Google-Smtp-Source: ABdhPJy0FnLqjQbmgoPc0SrhagYbv/r2OftCGSt3ub5EuNDGvzcJWDEHvYXCQFvXM53HhHLqTOKOsQ==
X-Received: by 2002:aa7:8281:0:b029:164:cc0f:2b3a with SMTP id s1-20020aa782810000b0290164cc0f2b3amr378364pfm.30.1603955979695;
        Thu, 29 Oct 2020 00:19:39 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n6sm1476404pjj.34.2020.10.29.00.19.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:19:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 00/21] perf arm-spe: Refactor decoding & dumping flow
Date:   Thu, 29 Oct 2020 15:19:06 +0800
Message-Id: <20201029071927.9308-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v5 for refactoring Arm SPE trace decoding and dumping.
It follows Dave's suggestions to implement a cumulative error for
function arm_spe_pkt_snprintf(); and fixed the patch 10 "perf arm_spe:
Fixup top byte for data virtual address" for detecting kernel address
with bits [55:52].

This patch set is cleanly applied on the top of perf/core branch
with commit 7cf726a59435 ("Merge tag 'linux-kselftest-kunit-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest"),
And I retested this patch set on Hisilicon D06 platform with commands
"perf script" and "perf script -D".

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

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  59 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 564 ++++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
 4 files changed, 441 insertions(+), 321 deletions(-)

-- 
2.17.1

