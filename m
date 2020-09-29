Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743BD27CF82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgI2Nkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgI2Nkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q9so4684573wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9+3/B34RTMEeHRAYHlsHPnPOfdHIDgIB7r6Y+U81LYU=;
        b=NWaoYKiBDaTXsXRtivDZOplPVd5wRKWBJRJmVjwCcRNQKT06Pas9TGdGoTxxlg4SOq
         YB/3wj6Ffq1LEFOpyBaL84Yq3UtT/QSPSVV2CijmggOy0MStC3vOiMA3GbDJs8oXonlT
         pTwaKrF7xvPr9dEbwOBBgWer7UB3cVqiKcRHWs7EYSOkjH9u45D5UoseiX5fd84GdWpj
         nsL05AMEnOWCW/Lj6tSdSyb+ZZ7+m37B11e6Xzfgr2vACpxZeyzpAtoVueG/Eso2ddzv
         FqTEV/at2RsCWppETAyB2Ih11sbtDpp5CwYWCOZL2ZXw9jg8Dn7ZfhmJ6RP9PFyKohFn
         DEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9+3/B34RTMEeHRAYHlsHPnPOfdHIDgIB7r6Y+U81LYU=;
        b=HN7VM8e+Qhb7CFioQPlxqCQkALQJhiP69S+/Kd/u7Xn9WYR5iRBLInADE0EOwaDUxY
         zsP83DIVQA1pXPRFyszx5+Qb/YKcd+SyggBhNHc5TdhzjjpkOLsu9OozKMjDZpPaAzDB
         /vlsuHH9pA9vjtnxD3zW+rlEd+/9GvS6EkBZidAQmaRqh/dvnO6YQM6UUZsyeqKd/Xkp
         BMT4WWKzSwYzEz7iEbavyqGelSdPtk/lKh9Mm7Rpv6m9Yqdm9BHIvSL1j/ES4n3lqYUG
         TAvX+hNX80Cj/IKNLtkbdyx+u7/jVuZXiOiSJdyttqx+y+/KjvdELA+1Xw38nlcgxxsG
         8Cvw==
X-Gm-Message-State: AOAM533xEj/sQoU/cGMClAKeasJHWrEqhZ8fPwLCujdlWD0s65VymHPh
        QMBmPx2sLcNwa2zoo0Cjyt2gGQ==
X-Google-Smtp-Source: ABdhPJxYVMKyVNaan4XZWFZyoSCQeaIZsW1CGnLWzcaOkpf6lO//TyrZyKfTtfc8UX75zOMV/4JZZQ==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr4383146wmj.63.1601386847196;
        Tue, 29 Sep 2020 06:40:47 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:46 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 00/14] perf arm-spe: Refactor decoding & dumping flow
Date:   Tue, 29 Sep 2020 14:39:03 +0100
Message-Id: <20200929133917.9224-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prominent issue for the SPE trace decoding and dumping is the packet
header and payload values are hard coded with numbers and it's not
readable and difficult to maintain; and has other minor issues, e.g. the
packet length (header + payload) calculation is not correct for some
packet types, and the dumping flow misses to support specific sub
classes for operation packet, etc.

So this patch set is to refactor the Arm SPE decoding SPE with:
- Patches 01, 02 are minor cleans up;
- Patches 03, 04 are used to fix and polish the packet and payload
  length calculation;
- Patch 05 is to add a helper to wrap up printing strings, this can
  avoid bunch of duplicate code lines;
- Patches 06 ~ 12 are used to refactor decoding for different types
  packet one by one (address packet, context packet, counter packet,
  event packet, operation packet);
- Patch 13 is coming from Andre to dump memory tagging;
- Patch 14 is coming from Wei Li to add decoding for ARMv8.3
  extension, in this version it has been improved to use defined
  macros, also is improved for failure handling and commit log.

This patch set is cleanly applied on the top of perf/core branch
with commit a55b7bb1c146 ("perf test: Fix msan uninitialized use."),
and the patches have been verified on Hisilicon D06 platform and I
manually inspected the dumping result.

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

Leo Yan (12):
  perf arm-spe: Include bitops.h for BIT() macro
  perf arm-spe: Fix a typo in comment
  perf arm-spe: Refactor payload length calculation
  perf arm-spe: Fix packet length handling
  perf arm-spe: Refactor printing string to buffer
  perf arm-spe: Refactor packet header parsing
  perf arm-spe: Refactor address packet handling
  perf arm-spe: Refactor context packet handling
  perf arm-spe: Refactor counter packet handling
  perf arm-spe: Refactor event type handling
  perf arm-spe: Refactor operation packet handling
  perf arm-spe: Add more sub classes for operation packet

Wei Li (1):
  perf arm-spe: Add support for ARMv8.3-SPE

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  54 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 567 +++++++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 124 +++-
 4 files changed, 478 insertions(+), 284 deletions(-)

-- 
2.20.1

