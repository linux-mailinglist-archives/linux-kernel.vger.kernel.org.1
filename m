Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0F2AD074
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKJH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:28:07 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:28:07 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f18so4918574pgi.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXAqxmjmagUUMTqazflkMp+W3D5vynn+tv76fX8fmb0=;
        b=L0Xpq8HYY8zZ8T81fBm8MJOhlIw56+amwiMYIoU0QsQ0hyRcZ/x/6Fkk4MbUemAb/e
         8m/RAK0/gfNPcm1Dw5CCr4yGqrphaT2zoP5cYOBguGAr1R0U0t+fjAuQJOeAT1yBycRC
         D+XNbBehzjDoQBztNYuwZMJorJQ/wEDP2EJRE4EdD5p25kipvgtA+tRVMfRMz5ED8rOl
         XOmUoHtftlV7RwBP/55v5Qi1c61dtNrWPYAMYIwmZFYOK03Tf90ZpeHL9FVwJv4UTOTv
         7ls4e7RQ5+Qn1Plakgsj1jt6aTFlAaCRHZ7sTUrMyhxz/8lFt5OaZ3X3zPDKbbOo7v8X
         LRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXAqxmjmagUUMTqazflkMp+W3D5vynn+tv76fX8fmb0=;
        b=RVaoAPaUDeFKQXT1l5MdyNBJ0ZE1XP6DrHdaAglrFQ10cwkKNtmuLnwguoCRlHY1CA
         PGxjTwyZG2CINApuijt0et7fWWG3ifp9R/FFNZ1zfzAl5sjKFa+dYdaEDNw8E9h1vvay
         gBIZsRV5uKdreSiWGa3uexTtoAVSv8xAFYtHYXxUEMbX1NVEBVHs9IjYXzxZ/OL2IAVZ
         SiJQN87nayZqg88AQuqGxRs3dEd8rwqaR/YnLBSRVjEdUvGWMLrRkOM09YQbJwIy71S6
         T6z+PAGTzSWlbYYxGnJfmfxEXr2CP3ajqSdIuYd3DSL9fvmiceTfjEYxr2Jc7QJHTBAe
         MswA==
X-Gm-Message-State: AOAM532RW+qCP4ISzvaOJJQIEyURcpdm+DvhjL6gPivde3nSUR25p65G
        ZS5PwkrEgnf68kBcaJZhS1gMhg==
X-Google-Smtp-Source: ABdhPJx/a67vEgBae+jayH60wcCsinq6WQh7Qtmzg/cjuEH/Goex8BLhj9hLWtvQQSvgCnaqIcd40w==
X-Received: by 2002:a17:90b:2152:: with SMTP id kt18mr3594134pjb.10.1604993286710;
        Mon, 09 Nov 2020 23:28:06 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w22sm12233191pge.25.2020.11.09.23.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 23:28:06 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, yash.shah@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/3] clk: add driver for the SiFive FU740
Date:   Tue, 10 Nov 2020 15:27:45 +0800
Message-Id: <20201110072748.46705-1-zong.li@sifive.com>
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

Changed in v2:
 - Remove the macro definition for __prci_clock_array.
 - Indicate the functional changes in commit message.
 - Using option -M and -C to create patches.
 - Rebase code to kernel v5.10-rc3

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

