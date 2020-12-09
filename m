Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485762D3F20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgLIJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgLIJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:50:03 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A39C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:49:23 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j1so654822pld.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AL3YkBOv5b8sByiXoR73Ol/0eY4rxeAavz/QsSxvMII=;
        b=EGHlGAIsmIclMzfOdAuhmFO/HFM6CkrW380E7NpmzwdrfRTpqgfCk0sjga5uyenLiN
         H2yIZxwsTQhOjmP7BVMHBTGvafQ8705ZoFLGKdL6YHxSWhSjyMjQi1+QZf8rcJuP5VIS
         ICWVUY1m0ip33W7qSJt5qTpDMVWCpPKq5oBpi6l9DzE9dJXa+7APZ5WNAN9tD/z6blVv
         lsYFa2871HHWbbgAr2O/8v9VYXUnJOuGqa5myZ4DrrUhIM5fXl/fXvpy5RppEz0B00Eo
         cLuUoKbvc0u2TLsCXXL313Xa6jyN8ocVM35xgBp2FSr28doO1Uer60LwTmBUeiDgcGwI
         iUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AL3YkBOv5b8sByiXoR73Ol/0eY4rxeAavz/QsSxvMII=;
        b=cRViOMZV32m1UWTtHlx07jrrQTcYkXkaKQauoueKe+l5bjXSZuyIY/elwDatyBGPn0
         uvLgZzXAsaHn2bK9Fazp+5q83Wp8QAJCkGp8pzrg/Csn4D91heDPaSLDv3Y9q6mTkWCc
         NmdSeqdsz/I9SVsaDpdc1nG5OVailqpe60d0jeQnn9dtJInVKG7Osf3Ts7wbV8Nhg/NP
         jWlBQu5tCui91VdSuHucrQZkUxdo9jZD0R+y/WR3/ruRa7dPq12wzDndeKINgPELjqmg
         UPYPSS1AVcOJ6MYaUv8izkx5AYNEbcqbdCVTN1KXDN9yBRZ1rKmW0ivqTRBDfmREOwZr
         C9EQ==
X-Gm-Message-State: AOAM531+aCWK22hMUXpdSN7prrGQd1SexObZoM58p5U9iWmYnjcPmvJF
        LgLkK8FHk99eoKekCjnOjojj4w==
X-Google-Smtp-Source: ABdhPJw9bu6mcnqWxY0e+Od/1TRJARGDeLGom/lEpeDI6x4EAsCCzqcchepslIO1y79reQL1kfkGZA==
X-Received: by 2002:a17:902:ed11:b029:da:3137:2695 with SMTP id b17-20020a170902ed11b02900da31372695mr1289502pld.1.1607507363144;
        Wed, 09 Dec 2020 01:49:23 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 129sm1890354pfw.86.2020.12.09.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:49:22 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v7 0/5] clk: add driver for the SiFive FU740
Date:   Wed,  9 Dec 2020 17:49:11 +0800
Message-Id: <20201209094916.17383-1-zong.li@sifive.com>
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

We also add a separate patch for DT binding documentation of FU740 PRCI:
https://patchwork.kernel.org/project/linux-riscv/patch/20201126030043.67390-1-zong.li@sifive.com/

Changed in v7:
 - Pick changes in v5 back up into this patch series.

Changed in v6:
 - Modify the patch "Add clock enable and disable ops"
   by Pragnesh. The changes as follows:
   - Remove spin lock in enable and disable functions
   - Call enable_bypass() before PLL output disable
 - Rebase code to Linux v5.10-rc7

Changed in v5:
 - Fix copyright format
 - Add a link of documentation in commit message
 - Modify build dependency for sifive-prci.c
 - Add enable and disable functions by Pragnesh Patel

Changed in v4:
 - Fix the wrong enable bit field shift for FU540 and FU740.

Changed in v3:
 - Fix the wrong enable bit field shift for FU740.

Changed in v2:
 - Remove the macro definition for __prci_clock_array.
 - Indicate the functional changes in commit message.
 - Using option -M and -C to create patches.
 - Rebase code to kernel v5.10-rc3.

Pragnesh Patel (1):
  clk: sifive: Add clock enable and disable ops

Zong Li (4):
  clk: sifive: Extract prci core to common base
  clk: sifive: Use common name for prci configuration
  clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
  clk: sifive: Fix the wrong bit field shift

 arch/riscv/Kconfig.socs                       |   2 +-
 drivers/clk/sifive/Kconfig                    |   8 +-
 drivers/clk/sifive/Makefile                   |   2 +-
 drivers/clk/sifive/fu540-prci.c               | 598 +-----------------
 drivers/clk/sifive/fu540-prci.h               |  21 +
 drivers/clk/sifive/fu740-prci.c               | 120 ++++
 drivers/clk/sifive/fu740-prci.h               |  21 +
 drivers/clk/sifive/sifive-prci.c              | 574 +++++++++++++++++
 drivers/clk/sifive/sifive-prci.h              | 299 +++++++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
 10 files changed, 1091 insertions(+), 577 deletions(-)
 create mode 100644 drivers/clk/sifive/fu540-prci.h
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 create mode 100644 drivers/clk/sifive/sifive-prci.c
 create mode 100644 drivers/clk/sifive/sifive-prci.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

-- 
2.29.2

