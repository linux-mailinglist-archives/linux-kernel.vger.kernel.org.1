Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D404726CA13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgIPTp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgIPTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:18:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2F9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so4561375pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCyZPWORZi64i0ENfQsDO89XXsPa3Npo8JZgh8Kq1P4=;
        b=legqG5oh5Qbw9WFdfA0ESEdLE0cDOul85QhZWKCgTolOdg6FuQx+zytcWCeGY+HBhq
         DtiYvlm1P2r/cEkYRJiZkIdHOFj2vSKm+be/30Z5WzpbF6vm/b06ixpNUa0z99h+lW0x
         t2sLJurC1esCzSISSmmclKwTRdsc8vOu24TvSRm4pxU0NNJ8aYh0ZVaj62xJhH67Sxaw
         w35H/9bKHGfSHz37kDlhSiZl003ydY2pC9Uui/Nqdm4nLJXjFU84tXPjXxnZ2JYnG5J2
         lShFS8tX3b498Gq8woSWx5pXMjipY/Bae0ksupcpPFZbPU2FLhguANuxKQugZRxvBX/K
         UjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCyZPWORZi64i0ENfQsDO89XXsPa3Npo8JZgh8Kq1P4=;
        b=QDWHwX7Rlkh8uv4SGb3DzUQe4uuWCIXpAHPBRVooRnXmpWtFjOtOU0Yc9cvzEbDXGv
         hAX7GBtegkInydNdWnfPbvzYSwbtla0NlaM0/NpuamH9cRTfLJpuviydp78t9P0NUd9u
         vBg/imibg0CB9xcrNDUl1tFgqOHkLtpnn0raDEdYG4U6MzzMzB68S+JJyz7SPdmNhQbX
         wAH/cbxiryhDMWd9TC3tDotSsuD4x0mNQ9nfQqNITkzdWwK7bHFJQZrc/ZE8NijG3YJJ
         8m0mwZ8Er8iBFtyBPn56eQ2zBK96o3sMMGeMCRq+DXLwttaa72DpOxQCQG/R0sSbN5cU
         a5SQ==
X-Gm-Message-State: AOAM5312EaPTrZRV5xO7zYxm/oUzknTX7PzSbcE8978Ax3Pjcv9KNqfU
        L/Tkd2UfU+yGfpyo8QwBT5eIog==
X-Google-Smtp-Source: ABdhPJwJu/t1vjHycXLtWiiyKj/1fk2UjMwZPCnOjOPNHB+Y7FCoqjnATlKaE+q6wm15NHx7rx5ARg==
X-Received: by 2002:a63:1644:: with SMTP id 4mr19876866pgw.232.1600283859616;
        Wed, 16 Sep 2020 12:17:39 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] coresight: next v5.9-rc5 
Date:   Wed, 16 Sep 2020 13:17:21 -0600
Message-Id: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Greg,

Here are the CS patches I'd like to see included in the v5.10 merge window.
There might be a part two but I'm not sure yet.

Thanks,
Mathieu 

Jonathan Zhou (3):
  coresight: etm4x: Fix issues within reset interface of sysfs
  coresight: etm4x: Fix issues on trcseqevr access
  coresight: etm4x: Fix mis-usage of nr_resource in sysfs interface

Linu Cherian (2):
  coresight: etm: perf: Sink selection using sysfs is deprecated
  coresight: Make sysfs functional on topologies with per core sink

Mathieu Poirier (1):
  MAINTAINERS: Add CoreSight mailing list

Mian Yousaf Kaukab (1):
  coresight: fix offset by one error in counting ports

Mike Leach (2):
  coresight: etm4x: Ensure default perf settings filter user/kernel
  coresight: etm4x: Fix number of resources check for ETM 4.3 and above

Qi Liu (1):
  coresight: etm4x: Add Support for HiSilicon ETM device

Sai Prakash Ranjan (1):
  coresight: etm4x: Fix etm4_count race by moving cpuhp callbacks to
    init

Suzuki K Poulose (1):
  coresight: etm4x: Handle unreachable sink in perf mode

Tingwei Zhang (4):
  coresight: stm: Support marked packet
  coresight: cti: disclaim device only when it's claimed
  coresight: cti: remove pm_runtime_get_sync() from CPU hotplug
  coresight: cti: Write regsiters directly in cti_enable_hw()

 MAINTAINERS                                   |   1 +
 drivers/hwtracing/coresight/coresight-cti.c   |  30 ++---
 .../hwtracing/coresight/coresight-etm-perf.c  |  12 +-
 .../coresight/coresight-etm4x-sysfs.c         |  11 +-
 drivers/hwtracing/coresight/coresight-etm4x.c | 111 ++++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h |   6 +
 .../hwtracing/coresight/coresight-platform.c  |  10 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   3 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  11 +-
 drivers/hwtracing/coresight/coresight.c       |  62 +++++-----
 include/uapi/linux/coresight-stm.h            |   1 +
 11 files changed, 137 insertions(+), 121 deletions(-)

-- 
2.25.1

