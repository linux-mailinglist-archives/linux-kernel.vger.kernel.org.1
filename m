Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42F2C7FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgK3IYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgK3IYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:24:23 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:23:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so6078452plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/CSafwFA0FXbIVsTa7ADySx19FcNz+0PmGY57JmVt0=;
        b=lMIEdjFCJ/yuRWk/OEQDiBBJsY8hqZVTK0xSnSsRu3LW9tOLtrhSo+n/bSL3HhY240
         juMks9fwlINT27VglqJ54uLBgUmMsz832g39GQN2i89txD5s9e6njynxfhX4tsmwHaVw
         9sQ6z78+pjJstNCF9QcotylG9226qdJU/uPf5AhnU7ZxxpdminTwTvkVYM6sujjfiLTv
         TDqTJecqUpSfWqA6meaGmqkEdBH3YmyQn45RTs3Z42Z56rV7QNwZt6ByrtTuitthmaxj
         eL/uXNw8dqx0AxrV+cgiIHEiniZ+OZwbM8VR2/C6BIdBzMqwfldHu/29ymP3lAJvB5qy
         Hbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/CSafwFA0FXbIVsTa7ADySx19FcNz+0PmGY57JmVt0=;
        b=lJ9MHn2nb/A+jqlgeBF0R0PvSKepHAS7t+A1h+HlMJ/zw3aAbCMiPaTo4f0PDCSOHE
         4v9GnPQtNXH6mmkk+A/XcYD28lG8h/SHqh9oTBObcCI+ATiHYEs4X1eyQT69Tusni+Yq
         hw1YYZdm6nsxcD2RUoCkbTVrzoVB4R+2V/YmyjcCcJpuQdUzfgmgZMsfCu//EZs7XqZ/
         20WRpjN0t2nc4PbLbgninOmGMGKqQNo/8OmNdIOg70h4OhYktMyMe2mKPGFo6iU6Er/Y
         PliR/G/1Dhm39qiKgwWOowRWbr/G3Lx141ygtCKAZ1nMOaaYIPW3bieCdA7aL85of9Bb
         MU2Q==
X-Gm-Message-State: AOAM533SqkpHnx3/W1sZ10nza2phDIZwJ2WnDnkroAb/40X8mdcNsNj9
        ZVe07MUGyaak9LA12Mi7ShewMQ==
X-Google-Smtp-Source: ABdhPJyu3ueyDOQsKAR72BU6j8iQ01RyXP5syiq90vuC1IgTm3apKg66Jc/W8bjbBfIYzTdz7Go/kg==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr11269154pjb.48.1606724616340;
        Mon, 30 Nov 2020 00:23:36 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id u1sm21265338pjn.40.2020.11.30.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:23:34 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 0/5] clk: add driver for the SiFive FU740
Date:   Mon, 30 Nov 2020 16:23:25 +0800
Message-Id: <20201130082330.77268-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the SiFive FU740 PRCI IP block, which handles more
clocks than FU540. These patches also refactor the original
implementation by spliting the dependent-code of fu540 and fu740
respectively. In v3 and v4 patch set, it fix the wrong clk enable bit
field which reported by Pragnesh.

We also add a separate patch for DT binding documentation of FU740 PRCI:
https://patchwork.kernel.org/project/linux-riscv/patch/20201126030043.67390-1-zong.li@sifive.com/

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
 drivers/clk/sifive/fu540-prci.c               | 585 +----------------
 drivers/clk/sifive/fu540-prci.h               |  21 +
 drivers/clk/sifive/fu740-prci.c               | 120 ++++
 drivers/clk/sifive/fu740-prci.h               |  21 +
 drivers/clk/sifive/sifive-prci.c              | 588 ++++++++++++++++++
 drivers/clk/sifive/sifive-prci.h              | 301 +++++++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
 10 files changed, 1105 insertions(+), 566 deletions(-)
 create mode 100644 drivers/clk/sifive/fu540-prci.h
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 create mode 100644 drivers/clk/sifive/sifive-prci.c
 create mode 100644 drivers/clk/sifive/sifive-prci.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

-- 
2.29.2

