Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D242AEE69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKKKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgKKKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:06:13 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF04C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:06:13 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so1343986pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wjio2OQJw8REk5ObwaBDzXaM2/PC6+LMmDg5VRFzBug=;
        b=UhLRLR898+JF+5m37PQQQ9fie0SvWmdUWsF4dqAxZxgxxLPrm/BGEMC2TfOF+FDcrK
         5ke3OTdnw0s7J3rz6KhfZbo1S82osWZU34YS8fV6S8A0QZvsquXkROWBJ9hHztAOm9eO
         W1cRt7oknvnYB8DjzLTUDsFv12TvMn/ZTPei+M9yd+ytY5tbtXLY7Kqka1objq0qLgt4
         2zG0xamj+1g0ltdRRjq0cORNOHDIv5F9X3h6sgQSgDkSOtZul2gdPjclCA0lYI/jv2C5
         TYzRHZMNmncgoUGvx4PU/yBjdAMWxnJFqInPtbItAJzzF0tdcy0qOTVPIW5PTgIfaans
         BzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wjio2OQJw8REk5ObwaBDzXaM2/PC6+LMmDg5VRFzBug=;
        b=A2jddNyOEdGV6hUvSnnty4KkdmIUBHbik2RujmXJaq5OUCm1Npn+j9cYAstLm+8CZp
         vE1L/v2fMXEcVo2ye5P92XspgZYDKRvcLzGUvE3XO1Q2waK+GgqupLlkPWr+r0jTxHSx
         MfOOxSx7mKD5eQDoV6duFfrZzG52dLRncAnj1UdaX3GyGDYVkHsbuTFqX4aOHeyxQtW3
         ceqts3eYSayJYktBREojUW98LnDt3nTm5JK7oED2ikYqXIjMV5bgQ6loGvh10QmzgsAc
         lUgTYAo9HYOV2J78gSge56u5yV/h8/j2qWH6Vbke/Rr/WhrQrYXlR4Bfdg1Yine5pgBi
         0K/Q==
X-Gm-Message-State: AOAM533GPHjRB2LQppF4wPhqrGq8hG3Ibsk/Ch0MC2kLtcPIeVSnj0aW
        AZjQ/XGHprN9UuAqd4qsBzntGN+phhNg0Q==
X-Google-Smtp-Source: ABdhPJwvn5g6/MaTvNdSVjL9J92/DK1CBp3bqzQoaUCBlm9kqxW2nEWmVgzahQkg+2XDm7OSY917bw==
X-Received: by 2002:a62:1991:0:b029:155:f476:2462 with SMTP id 139-20020a6219910000b0290155f4762462mr22921555pfz.43.1605089173193;
        Wed, 11 Nov 2020 02:06:13 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id u22sm1872801pgf.24.2020.11.11.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:06:12 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/4] clk: add driver for the SiFive FU740
Date:   Wed, 11 Nov 2020 18:06:04 +0800
Message-Id: <20201111100608.108842-1-zong.li@sifive.com>
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

Changed in v4:
 - Fix the wrong enable bit field shift for FU540 and FU740.

Changed in v3:
 - Fix the wrong enable bit field shift for FU740.

Changed in v2:
 - Remove the macro definition for __prci_clock_array.
 - Indicate the functional changes in commit message.
 - Using option -M and -C to create patches.
 - Rebase code to kernel v5.10-rc3.

Zong Li (4):
  clk: sifive: Extract prci core to common base
  clk: sifive: Use common name for prci configuration
  clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
  clk: sifive: Fix the wrong bit field shift

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

