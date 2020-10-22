Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4379296145
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368327AbgJVO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368318AbgJVO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E22C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c16so2624372wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Cx7XGX9nMoWXAs2kXG6zDVAKiXDNvSG1xe4HtFWw++s=;
        b=yJDLbQ6pbJk8VkT/jpMBwSJ4Ra+IOijDC0ripwsMSBbUf4TRphgWmlou+Ylw68M4oS
         lJhl3lVb+wnGpQPXVvIL5EwvJsct/7A9uAMzFr8AtMfdlpvJyAhfhYF4T6AR+60m0Nki
         H4DOCD/TbaZA77DXw5wufpfRi/YQDzkAwhFvSwoU388l/FOjVVubT7skPU6IPzOwnixo
         Si4X6yWAmz2dFcFI+69hp7nrzN6RqggCletd4hJBe2ZeW/nQ+LhIouFd3JR6G6lusqV6
         pgbYLKsiwHOFxtVUgbXa8cnb4L5Q6CBpfZrQ3lFiabSkMvFOfDrXLVC7xNVKiq+pG/w2
         Qozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cx7XGX9nMoWXAs2kXG6zDVAKiXDNvSG1xe4HtFWw++s=;
        b=sJ56uf7T35vgk+bwaGhLTUg7yvEkDSdkczLtmGzV6TZxzGMqajeFRWZLXg2ZW+jGVk
         zvhCWoGNVcc5nhOppNngdDpUertXBX0Lb/QzeFI5CZXC5avsznIGm66oiYYqV+lWrvaL
         7p8vt5Yja7DnmO0rJ9TazgJF/THVip9HT6Sjdxf2QSXWNKPPohDLVM+2DspDoVnNWbmM
         LBhD/ekkUF4FTHzyUQNwgc7vJGxVm1oEw9v2XVA8Znrg9RfgUxSBqG0/ORU8mHorudqy
         M2sWSmhjziI4Wl94xVl3yuKRNlKFFz+7ru7OjJsf1K8U2+sIrtyL3uTEDR6GgirAtY+Z
         EXRQ==
X-Gm-Message-State: AOAM533w0K85Dx160M6JU1HMmN+X2138UoouR/qmUxnHddERHO7Ys8u7
        +wFbbi49sjd7kZsA4FwK2hsUhQ==
X-Google-Smtp-Source: ABdhPJzLQW0m3qPPWdpowXXYqnWnluUmH1A3uddX+Sx3PWPhpmQxo+nYmV/itEJroSottWhKtyFMGQ==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr2902447wmr.179.1603378709939;
        Thu, 22 Oct 2020 07:58:29 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:29 -0700 (PDT)
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
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 00/20] perf arm-spe: Refactor decoding & dumping flow
Date:   Thu, 22 Oct 2020 15:57:56 +0100
Message-Id: <20201022145816.14069-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v3 for refactoring Arm SPE trace decoding and dumping.
In this version, it mainly addressed the comments and suggestions from
mailing list (mainly from Andre Przywara, thanks!).

This patch set is to refactor the Arm SPE decoding with:

- Patches 01, 02 are minor cleans up for header, typos;
- Patches 03, 04 and 05 are used to fix and polish the packet and
  payload length calculation;
- Patch 06 is to add a helper to wrap up printing strings, this can
  avoid bunch of duplicate code lines;
- Patches 07 ~ 18 are used to refactor decoding for different types
  packet one by one (address packet, context packet, counter packet,
  event packet, operation packet); it also introduces separate functions
  for parsing specific packet, this can allow the code more readable and
  easier to manage and extend code;
- Patch 19 comes from Andre to dump memory tagging;
- Patch 20 comes from Wei Li to add decoding for ARMv8.3 SVE extension.

This patch set is cleanly applied on the top of perf/core branch
with commit 7cf726a59435 ("Merge tag 'linux-kselftest-kunit-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest"),
And I tested this patch set on Hisilicon D06 platform with commands
"perf script" and "perf script -D".

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

Leo Yan (18):
  perf arm-spe: Include bitops.h for BIT() macro
  perf arm-spe: Fix a typo in comment
  perf arm-spe: Refactor payload size calculation
  perf arm-spe: Refactor arm_spe_get_events()
  perf arm-spe: Fix packet length handling
  perf arm-spe: Refactor printing string to buffer
  perf arm-spe: Refactor packet header parsing
  perf arm-spe: Add new function arm_spe_pkt_desc_addr()
  perf arm-spe: Refactor address packet handling
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

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  43 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 658 +++++++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 132 +++-
 4 files changed, 536 insertions(+), 314 deletions(-)

-- 
2.17.1

