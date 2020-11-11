Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5E2AEDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgKKJfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKKJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:35:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001D6C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:35:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id gi3so450180pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmA+jLoNrTCA2+Mt4Q5LbDfOt6s2dRJWxbjFrCs/Ci8=;
        b=QLVIoBk/QSBtn4VAMXQrR7hbsG73rbW5vsg4oZUfQYgF8WYlkhZh4p99J65QEoVpRM
         toarObrHKgOx39tSEQkO6AMetfVfGcKHGA3C1BG6A7+4xuXSMnz0NrjriacAHwSGbalu
         hqk0GHgP1E7sN4E8vawpAzTodtSyYTzfShIEwQJIAQx8UuhTfB7pB32htUG+Who08anm
         t02xIU3jKF0hzrx9+S8b4x1t2doNpslf8tHm4jpZOyUOEeuMxYT3Prkh6tIk/JQmFAPK
         YhxjN9tY/8c1317TBKXlK17TE8BgGxFt4eG8Gcqh0N1ovjaTrjCOv4dqqCPQP+LDdvvQ
         u5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmA+jLoNrTCA2+Mt4Q5LbDfOt6s2dRJWxbjFrCs/Ci8=;
        b=n+FqRE4LB27vSF93WXLzj9XiPP65UCSyDKmC4HxzbGibNT96LlKcbrBjcHlqQkbS0K
         WHlUnE9vL+cpbYlt8gXDvMXhpu8R34QAxfD4+BLM/D0QiGwLoacBDzujtbsxzgv3UoKn
         tJznHghx9A2hjvbv+5zws9z1XLtOnRX+Gc5zlfBV+pYefKDeywhBAq4mO0nIKqUZ842v
         hs2ruDN2nHiZVL6L0LBVuQRhJEQ6nbFDoCgRCOSW5pRvvSZckhDUBF3oWlF4La1vLbeg
         ryCVxJ2Hst1/agfqS/ODCfbJcpc/59dcSu9L4bvWgR85/xQ6lyyZ0FyAjmWkt57/yEjj
         Kp6A==
X-Gm-Message-State: AOAM531aZbI7Ch39AbsMruyqMNklSAnoR/CWwDOennaJjPMsZkoFS4FE
        keuurGzV+l1ZWH0FD/MQcJSsSa2b5mJOgw==
X-Google-Smtp-Source: ABdhPJxC70iXZ53+Zu2FOrGuQQx34cC84+q4xcOoLMcPe0csIhqPxj/fM/F6TDzKykpV8fkPWsfbTQ==
X-Received: by 2002:a17:90a:d182:: with SMTP id fu2mr3078446pjb.145.1605087319519;
        Wed, 11 Nov 2020 01:35:19 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id m6sm1862424pfa.61.2020.11.11.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:35:19 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/3] clk: add driver for the SiFive FU740
Date:   Wed, 11 Nov 2020 17:35:11 +0800
Message-Id: <20201111093514.103155-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the SiFive FU740 PRCI IP block, which handles more
clocks than FU540. These patches also refactor the original
implementation by spliting the dependent-code of fu540 and fu740
respectively.

Changed in v3:
 - Fix the worng bit field shift.

Changed in v2:
 - Remove the macro definition for __prci_clock_array.
 - Indicate the functional changes in commit message.
 - Using option -M and -C to create patches.
 - Rebase code to kernel v5.10-rc3.

Zong Li (3):
  clk: sifive: Extract prci core to common base
  clk: sifive: Use common name for prci configuration
  clk: sifive: Add a driver for the SiFive FU740 PRCI IP block

 arch/riscv/Kconfig.socs                       |   2 +-
 drivers/clk/sifive/Kconfig                    |   8 +-
 drivers/clk/sifive/Makefile                   |   5 +-
 drivers/clk/sifive/fu540-prci.c               | 586 +-----------------
 drivers/clk/sifive/fu540-prci.h               |  21 +
 drivers/clk/sifive/fu740-prci.c               | 122 ++++
 drivers/clk/sifive/fu740-prci.h               |  21 +
 .../sifive/{fu540-prci.c => sifive-prci.c}    | 499 ++++++---------
 drivers/clk/sifive/sifive-prci.h              | 289 +++++++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
 10 files changed, 703 insertions(+), 873 deletions(-)
 create mode 100644 drivers/clk/sifive/fu540-prci.h
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 copy drivers/clk/sifive/{fu540-prci.c => sifive-prci.c} (45%)
 create mode 100644 drivers/clk/sifive/sifive-prci.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

-- 
2.29.2

