Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076292A8CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgKFC1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:27:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2845EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:27:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j5so1717396plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlTyAlrxIMDICab8SBs5ImKcAlk12DPFmiqA27LNvcI=;
        b=G/7F9DDD4zwDCbEnAcd7IiemO/UEovgnv7K8BrYIWIR3Fa9bHc62bBt8/5RzyiXnbX
         RrYv5IZ17RXw335SDt2IOAIY7zIaCY3HHCYilGHqgsk/LkvpGxLu1mszMAcStErkzYFP
         B4/smJyVRD1t7H9b4dqKdrv9M7Ng6D9nTB9dVpGUUvWPw3YKsubq1gOM3KxRRTFW1MV9
         eFvxHruG58QBeO9p4Jml900DyyuCcAtBIZ98d9pMS+OGU/WNpf1ExHu/pI6KWBKtJvhy
         saksek4pIGQuxqyQMKlgQbatm5Yova4j7PJYmFV3FG3H3C7LEsQMxoEbMJaDwDIS4wKl
         o6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlTyAlrxIMDICab8SBs5ImKcAlk12DPFmiqA27LNvcI=;
        b=s9AQlH1UjmbG7bXpPMl7c33TTxwMrKFYuQjGqZqIymW2YWHJufh/7ju30MloZNJz4L
         kEo0pRYzNor9GWruqXN7D+Bth2fmQrhKXLS2JhdzM90kPREh+I4lBkkgMzSGadYpocg4
         dP5TqoH7yM7sX3qt0dwrXLDflZG/UoE8v7GGIUiYWOgi9ai/VlA9nvsKR9zSXJWk2aAa
         XS9DLdjX9DayXFeeN7Zk1Rz8yD8VXGj40G4UaXE9UX70lGBntf/5I9HBi70EffHxB7oB
         RqmjCSUo+qp23KN8hKTYsJG9Lg2+ZIjuin0axx6IkwHkL79BAITtllhJ83R37CColWNR
         Prgg==
X-Gm-Message-State: AOAM530x4yIibxMoM8GWfVyIg4E765+fdPVkBXkD2aKXvT7Ub+FhAEOx
        qIux8mE/Vcq+3+1RzZ9poZSlhA==
X-Google-Smtp-Source: ABdhPJxvl9nvzYf+cjScp7P847ymRdmJpnZGLPTsdSdpXDM+JsBK+jWM0D9dToHm2cF/a65Cj2PmAQ==
X-Received: by 2002:a17:902:ba90:b029:d5:cbb1:1733 with SMTP id k16-20020a170902ba90b02900d5cbb11733mr5268749pls.6.1604629665126;
        Thu, 05 Nov 2020 18:27:45 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:27:44 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
Date:   Fri,  6 Nov 2020 11:26:59 +0900
Message-Id: <20201106022726.19831-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an interim snapshot of our next version, v4, for enabling
UHS-II on MMC/SD.

It is focused on 'sdhci' side to address Adrian's comments regarding
"modularising" sdhci-uhs2.c.
The whole aim of this version is to get early feedback from Adrian (and
others) on this issue. Without any consensus about the code structure,
it would make little sense to go further ahead on sdhci side.
(Actually, Adrian has made no comments other than "modularising" so far.)

I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
set to meet what I believe Adrian expects; no UHS-II related code in
Legacy (UHS-I) code or sdhci.c.

Nevertheless, almost of all changes I made are trivial and straightforward
in this direction, and I believe that there is no logic changed since v3
except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-II
command sequences in addition to UHS-II errors. So I added extra handlings.

I admit that there is plenty of room for improvements (for example,
handling host->flags), but again the focal point here is how sdhci-uhs2.c
should be built as a module.

Please review this series (particularly Patch#8-#26 and #27) from this
viewpoint in the first place.
(Ben is working on 'host' side but there is no change on 'host' side
in this submission except a minor tweak.)

Thanks,
-Takahiro Akashi

------ original cover letter from v3 ------
Summary
=======
These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.

About UHS-II, roughly deal with the following three parts:
1) A UHS-II detection and initialization:
- Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
  [2]).
- Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
- In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
  3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
  Setup Sequence.

2) Send Legacy SD command through SD-TRAN
- Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
  compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
  Types and Format Overview[3]).
- Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
  CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).

3) UHS-II Interrupt
- Except for UHS-II error interrupts, most interrupts share the original
  interrupt registers.

Patch structure
===============
patch#1-#7: for core
patch#8-#17: for sdhci
patch#18-#21: for GL9755

Tests
=====
Ran 'dd' command to evaluate the performance:
(SanDisk UHS-II card on GL9755 controller)
                             Read    Write
UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
UHS-II enabled         :  206MB/s   80MB/s

TODO
====
- replace some define with BIT macro

Reference
=========
[1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
[2] SD Host Controller Simplified Specification 4.20
[3] UHS-II Simplified Addendum 1.02

Changes in v3 (Jul. 10, 2020)
* rebased to v5.8-rc4
* add copyright notice
* reorganize the patch set and split some commits into smaller ones
* separate uhs-2 headers from others
* correct wrong spellings
* fix most of checkpatch warnings/errors
* remove all k[cz]alloc() from the code
* guard sdhci-uhs2 specific code with
      'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
* make sdhci-uhs2.c as a module
* trivial changes, including
  - rename back sdhci-core.c to sdhci.c
  - allow vendor code to disable uhs2 if v4_mode == 0
      in __sdhci_add_host()
  - merge uhs2_power_up() into mmc_power_up()
  - remove flag_uhs2 from mmc_attach_sd()
  - add function descriptions to EXPORT'ed functions
  - other minor code optimization

Changes in v2 (Jan. 9, 2020)
* rebased to v5.5-rc5

AKASHI Takahiro (23):
  mmc: core: UHS-II support, modify power-up sequence
  mmc: core: UHS-II support, skip set_chip_select()
  mmc: core: UHS-II support, skip TMODE setup in some cases
  mmc: core: UHS-II support, generate UHS-II SD command packet
  mmc: core: UHS-II support, set APP_CMD bit if necessary
  mmc: sdhci: add a kernel configuration for enabling UHS-II support
  mmc: sdhci: add UHS-II related definitions in headers
  mmc: sdhci: add UHS-II module
  mmc: sdhci-uhs2: dump UHS-II registers
  mmc: sdhci-uhs2: add reset function
  mmc: sdhci-uhs2: add set_power() to support vdd2
  mmc: sdhci-uhs2: skip signal_voltage_switch()
  mmc: sdhci-uhs2: add set_timeout()
  mmc: sdhci-uhs2: add set_ios()
  mmc: sdhci-uhs2: add detect_init() to detect the interface
  mmc: sdhci-uhs2: add clock operations
  mmc: sdhci-uhs2: add set_reg() to initialise the interface
  mmc: sdhci-uhs2: add request() and others
  mmc: sdhci-uhs2: add irq() and others
  mmc: sdhci-uhs2: add add_host() and others to set up the driver
  mmc: core: add post-mmc_attach_sd hook
  mmc: sdhci-pci: add UHS-II support framework
  mmc: sdhci-pci-gli: enable UHS-II mode for GL9755

Ben Chuang (4):
  mmc: add UHS-II related definitions in public headers
  mmc: core: UHS-II support, try to select UHS-II interface
  mmc: sdhci-uhs2: add pre-detect_init hook
  mmc: sdhci-uhs2: add post-mmc_attach_sd hook

 drivers/mmc/core/Makefile         |    2 +-
 drivers/mmc/core/block.c          |    7 +-
 drivers/mmc/core/bus.c            |    5 +-
 drivers/mmc/core/core.c           |  118 +-
 drivers/mmc/core/regulator.c      |   14 +
 drivers/mmc/core/sd.c             |   32 +
 drivers/mmc/core/sd_ops.c         |   12 +
 drivers/mmc/core/uhs2.c           |  883 +++++++++++++++
 drivers/mmc/core/uhs2.h           |   21 +
 drivers/mmc/host/Kconfig          |   10 +
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/sdhci-pci-core.c |   16 +-
 drivers/mmc/host/sdhci-pci-gli.c  |  318 +++++-
 drivers/mmc/host/sdhci-pci.h      |    3 +
 drivers/mmc/host/sdhci-uhs2.c     | 1697 +++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h     |  224 ++++
 drivers/mmc/host/sdhci.c          |  333 +++---
 drivers/mmc/host/sdhci.h          |  117 +-
 include/linux/mmc/card.h          |    1 +
 include/linux/mmc/core.h          |    6 +
 include/linux/mmc/host.h          |   31 +
 include/linux/mmc/uhs2.h          |  268 +++++
 22 files changed, 3961 insertions(+), 158 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h

-- 
2.28.0

