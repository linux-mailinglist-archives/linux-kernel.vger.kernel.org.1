Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA12D241D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgLHHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHHPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:15:19 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59825C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:14:39 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so11386371pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 23:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qOlsloJgxQkZEy55JDorTCm1I5tHRxkFTRlp6EieeA=;
        b=cDR/LIN65OUPo8a2wnb5yJ70LfqOZLtBPBOoVg4c6uOnZ2t0/tInUdpHMOmbTvVjaI
         Vjvd9yBJv+VlVQghaLfPk5OX2gv8gySfFeB9EfaPqgUB7Rv2tGhYBa8unI4U7D2D3sqe
         I8GfkolWWf32L6zlgAVfncXeW/k6B7001ZyTJi8GZBiEYkgDjBoq5DWL8mA3SeNvp7jG
         RxNRSEVgAOTt9x3iLI1gXL434cWQDvty0Hcumq61d4ke+kEzhhiuhrN5bBIH5DdufpFt
         2YALJWXOEYO2gp2KWc1fmYmw55De5H1kRYvJTbz0Pdh8uItsYzwacD3ahbGeUTZ+A8cy
         vrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qOlsloJgxQkZEy55JDorTCm1I5tHRxkFTRlp6EieeA=;
        b=Cd4GXT2RBU7vT0UFCorUSDIzKD4uLWep+CSpgoq4pFSoh2ZZeCzP83YfuB/cY6MkIK
         Kd95rFa04cFUbVDE22IZVYwzkrl3Y5SFgURs/djipOsNcvZN7ZpTMBoGIUY0lL8hUL16
         GFhFKa9hAlIGVQOQ9dZ6Lchdv+0aRPl58W8YSBOO+pv/lnR4izHENzzaiy7j2oCpkqL9
         kZVi+JEpFYcXn2XGcfHW1timaaJsqUsIv5IbPBtVrw3IEdH3E/2n6tEZS/L5K9YIew4K
         xjQzv54jQFqzRrAtmNdJCy3tJnuYPyleBrkTIVhRIwO4p/QLtIUlHdbSFf3dQp1I8V9/
         ylDA==
X-Gm-Message-State: AOAM532cGj7R6O8DtlL1kZGNItxgts0+OiZTUvy7XnFic0ju/jYn7vgb
        cliJHw+Wh4GqY6MXY4WGi/qJXA==
X-Google-Smtp-Source: ABdhPJxmZfF+CnAcve/pdIigoVV18lefAg/7CfvlDUYpdYDSaWxYPJidXa03T2kXUUGN1JSSBlGqDw==
X-Received: by 2002:a63:561f:: with SMTP id k31mr21413333pgb.227.1607411678623;
        Mon, 07 Dec 2020 23:14:38 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id gp17sm1801318pjb.0.2020.12.07.23.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 23:14:38 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 0/5] clk: add driver for the SiFive FU740
Date:   Tue,  8 Dec 2020 15:14:27 +0800
Message-Id: <20201208071432.55583-1-zong.li@sifive.com>
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

Changed in v6:
 - Modify the patch "Add clock enable and disable ops"
   by Pragnesh. The changes as follows:
   - Remove spin lock in enable and disable functions
   - Call enable_bypass() before PLL output disable

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
 drivers/clk/sifive/Makefile                   |   5 +-
 drivers/clk/sifive/fu540-prci.c               | 585 +-----------------
 drivers/clk/sifive/fu540-prci.h               |  21 +
 drivers/clk/sifive/fu740-prci.c               | 120 ++++
 drivers/clk/sifive/fu740-prci.h               |  21 +
 drivers/clk/sifive/sifive-prci.c              | 571 +++++++++++++++++
 drivers/clk/sifive/sifive-prci.h              | 299 +++++++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
 10 files changed, 1089 insertions(+), 566 deletions(-)
 create mode 100644 drivers/clk/sifive/fu540-prci.h
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 create mode 100644 drivers/clk/sifive/sifive-prci.c
 create mode 100644 drivers/clk/sifive/sifive-prci.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

-- 
2.29.2

