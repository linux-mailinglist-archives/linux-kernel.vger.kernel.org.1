Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8829FBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgJ3C5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3C5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:57:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:57:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b3so4051038pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bKdxcIw/CUXwWBKjVCu3/sT70BxmXWA6DZG7imein8w=;
        b=QKXqObBAIMbY7NLdonpHB7f1CTU/7QHrMNk9suDcqVmzPS8sHGSjoLqrUpec2aqVUp
         P5BikiHZEBhshaWpTd2hvjBTi81SXHtaEAoT7y1zeZhkdGUmJp+DSU28D7lP5+8gIctF
         e84MaY9WiacA/BeUXgsoZ4Rnxu3y/1UPvBGQh2YgT6UyGHmku9hPV1IwM9L4lpdROBLa
         oFtIvtV/g0FNec9E0VoVvff84qjmswZz6qjnhhV8yfg9O8FT06Gtl3JldEE6pWAQ7HlO
         NiIy+Qdy/31FRugeb5ew+Qvo4gxHYIxUWFFYfH9n2TpYHxs851qoYZPaIyhLfvyB4DhS
         zekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bKdxcIw/CUXwWBKjVCu3/sT70BxmXWA6DZG7imein8w=;
        b=tYBFs+tFmSeKtjICga7FlWS6l9PIlSKt6fojBZcF0IxQuK8HRm3mEcP9mw4UUAZOiF
         QqsG9OBMEfAHmSHzVSVy33dlH1k/7KHcvwFKiJV8fbtS+AcDAsof5m0NUltIBr82JXKI
         74s3cT0q6dwGvOmi6e7TDpypG+Soaer0WXC8kLbtSlNbfXm9bIl+zkNEA7x/H0yKcj4G
         n+Ic+aeeuX5XYTTwHjvn976GqiJ4Fu8mEjsiXB61qO85hoE/IadUNHeY6CIDXxz+fIMT
         NY61+SC8bkB4B58dPqk6j775g6umFsvChicxiw8+PXBL9BkXxAwTETLcrLpyyZPmK0B0
         FraA==
X-Gm-Message-State: AOAM532nWKVWoSwNq8y3la2H9i+UFPQ5GKFSYpa/HDp/P5WxzjuHHZKK
        cbCg73Fr+dP0e42RThw45uJweQ==
X-Google-Smtp-Source: ABdhPJzj8dFnOq6+x5qOdL+QFxXDFFYtnyCc+oNa7smoL15S8G26iI+KeljwRBqwohfDi2LGlVj0EA==
X-Received: by 2002:a63:cb08:: with SMTP id p8mr331387pgg.76.1604026663031;
        Thu, 29 Oct 2020 19:57:43 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n7sm3973441pgk.70.2020.10.29.19.57.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:57:42 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 00/21] perf arm-spe: Refactor decoding & dumping flow
Date:   Fri, 30 Oct 2020 10:57:03 +0800
Message-Id: <20201030025724.19157-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch set v6 for refactoring Arm SPE trace decoding and dumping.
It follows Andre's comment to directly bail out arm_spe_pkt_snprintf()
if any error occurred.

This patch set is cleanly applied on the top of perf/core branch
with commit 7cf726a59435 ("Merge tag 'linux-kselftest-kunit-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest").

Have tested this patch set on Hisilicon D06 platform with commands
"perf report -D" and "perf script", compared the decoding results
between with this patch set and without this patch set, didn't find
issue with "diff" tool.

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
  (Andre);


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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 568 ++++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
 4 files changed, 445 insertions(+), 321 deletions(-)

-- 
2.17.1

