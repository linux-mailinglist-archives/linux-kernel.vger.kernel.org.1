Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00702901AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406044AbgJPJSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405515AbgJPJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:18:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F420C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:18:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n9so1062501pgf.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VJmUi2hckCsijxBcYyhh03sDZwAMNbDuXEf/NPFrU4=;
        b=b8sPn/iNZ1hbUzVpPTulPn8fj7ufJEu2637RgBM8VxE9XMymWItCB/8oAIZlAU6V3/
         ulvQ0s3Md9tj7JuyvdmisQNwH1gF3Ai6rSu+/T85Tp0TE6mWavWcwznhxS+gOz/Nu6GA
         HbN28t9OrYj6QNZCpoOOzUPhs7YxQoXaG6WBxjMdcRHQYlvPof0W93p5qV8iFhlbSnlv
         4+Ggxl1o0nHi0nLrWdK6gSMnRvMkLEzHnkLJ/Vec/eL1MpzR5R6B8Rm2iadxTedPXf4W
         lvmgM5Mpe4S8y+at1XI++plh5fAmrOPNeDMCtEbjN3lOlGshcG7/gBv6jxKdXLE8OvFB
         MGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VJmUi2hckCsijxBcYyhh03sDZwAMNbDuXEf/NPFrU4=;
        b=XEAtLQjInP0tqevD8S9T5KwM+P/Nn4LkJFQw0qsIQwoE95d24XTtEu+tI5s86CUWdY
         hh/br5XX0Lp/b3DZSqT7fO5PuivfPOKNOCwUrT479eeiBV1CLhhQCAx/kPxE3ehKXVvF
         flV9oQGjrmybY5nI/PTt9LmgIkVefKdbzlyMZJDEP4EtjRSZr5IwpsmdhT+4amOxb8x4
         iDyIKvvFxojZ3iJGencmMDJ77CjGc8wxJv+px4OFio902YmgugJ0MDl1KOluQ8Vqcjv5
         sSV2/DB5ZSj0QlTCViPQq94fGFs5Uoxc9d4obXJdy2k0epwqsfDWSuy8QDrWy0fIEtdv
         JEpg==
X-Gm-Message-State: AOAM533A3qZZp8tFID2DSvKOAHkpt2CW29nhJrBFH5O66Xd852sC2s6N
        TJ5JbckIcOIWUeeAyi8h3SA0tA==
X-Google-Smtp-Source: ABdhPJxZY7syDdW76ZozIFq6p/RBmSoveEp5Ylw9O1uyIBddkks60ZtOQigzuvNjRHEcvFRBPIL0pw==
X-Received: by 2002:a63:6f46:: with SMTP id k67mr2230777pgc.296.1602839911585;
        Fri, 16 Oct 2020 02:18:31 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id h5sm2093263pfh.9.2020.10.16.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 02:18:31 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/4] clk: add driver for the SiFive FU740
Date:   Fri, 16 Oct 2020 17:18:22 +0800
Message-Id: <cover.1602838910.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the SiFive FU740 PRCI IP block, which handles more
clocks than FU540. These patches also refactor the original
implementation by spliting the dependent-code of fu540 and fu740
respectively.

Zong Li (4):
  clk: sifive: Extract prci core to common base
  clk: sifive: Use common name for prci configuration
  clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
  clk: sifive: Refactor __prci_clock array by using macro

 arch/riscv/Kconfig.socs                       |   2 +-
 drivers/clk/sifive/Kconfig                    |   8 +-
 drivers/clk/sifive/Makefile                   |   5 +-
 drivers/clk/sifive/fu540-prci.c               | 618 +-----------------
 drivers/clk/sifive/fu540-prci.h               |  21 +
 drivers/clk/sifive/fu740-prci.c               | 102 +++
 drivers/clk/sifive/fu740-prci.h               |  21 +
 drivers/clk/sifive/sifive-prci.c              | 529 +++++++++++++++
 drivers/clk/sifive/sifive-prci.h              | 297 +++++++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
 10 files changed, 1032 insertions(+), 594 deletions(-)
 create mode 100644 drivers/clk/sifive/fu540-prci.h
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 create mode 100644 drivers/clk/sifive/sifive-prci.c
 create mode 100644 drivers/clk/sifive/sifive-prci.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

-- 
2.28.0

