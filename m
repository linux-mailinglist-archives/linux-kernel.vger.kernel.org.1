Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB21C27D4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgI2Rwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2Rwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AADC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q4so3060058pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=91eXhqUt0yiGyGgALgBbmgxoGvRB8sCp7SDkRpPL9aU=;
        b=SBp6hDG2YSO5tbHHpZYyJJePoe/eVw5P/yxJ+P2wdVrlFiD97JKthXVKYIT6hn99NS
         2k3yI6Jq5d2gzUCH86+o52+TtnoM8z59XfUfT8TMqx/hlAIbikLMTvglztS27D22JDxj
         pBTCpTUZZuRLVw+xW4/x7PqWi1bdlAW8SJPy6FgUR2zP1jkRWGIfDJDDdY93yUNt3xu6
         pBebbh8r3V524oGGOs/hF6FgqWseHmFnzR/2Ai+EC9PTWXJCXbGMyQ1ilridZNYM+PhF
         rzOLvyvkBCE02/JY8vRSvUElDSQqbWXiEJ7H9iczjG9dBVZpTH9xHvHzKesEIIhkYI3b
         4bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=91eXhqUt0yiGyGgALgBbmgxoGvRB8sCp7SDkRpPL9aU=;
        b=BLtbl46iI7fkE1eadfgk3x6BwAcJWN9a82TY41V1AJ0fxH03my5GnMp7lwlOfRvjcT
         asgjduW/Ksd868ArTs30cgR39N+591NpNbBUpHh80l5Mdc6wMFDBZ4fm5n/NpTORcAqK
         HNmz4mV+1UmiPMjHX2ZTgKKCzaf1anbyl/ODnjN15lIt9bXtfWBNmc6ffkXZhW54A9fk
         H/j2UodUkX1E7yifQhIiG/3Q2satCVTSPrWFFULA1cq++AMwpN3TCdw1oZiATcUkJYnM
         zopMzXAL9Av9IcjbHBI8VjYFs8cyHHmKK8YaNgD/FKfKZh81nlZ4QO0mUFbaRbYcFS+6
         n5Ug==
X-Gm-Message-State: AOAM533/cIV93xpsldgcB7jfMcsvqr52bpFe/PypMMLXwc0P1PZVHThU
        JNgi+mzRqrxJxuFGKCKb9Nr8
X-Google-Smtp-Source: ABdhPJzH4TBnUi3YfBh2i6+cN+ol2OuAAkaXtshVujbwnQxMEhYOciUfaXFqfhgNaZlcCEfKpOVP4A==
X-Received: by 2002:a17:90a:4a12:: with SMTP id e18mr4199895pjh.200.1601401951117;
        Tue, 29 Sep 2020 10:52:31 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/19] MHI changes for v5.10
Date:   Tue, 29 Sep 2020 23:21:59 +0530
Message-Id: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is the MHI series for v5.10 cycle. Most of the patches are cleanups
in the MHI stack. Notable changes are below:

* Saving the client device hardware information obtained through the BHI
  protocol. This information will be exposed through sysfs to make use in
  the userland applications.
* Introduce sysfs entries to read the serial number and OEM PK hash values
  of the client device obtained from BHI protocol. Relevant API documentation
  is also added.
* Introduce debugfs entries to show MHI states, events, channels, register
  state etc... to aid debug.
* Remove the channel name from MHI device name as the device is not specific
  to channels. Used generic names instead!
* Fix the warning reported by Kbuild bot by using append (+=) Kbuild rule
  to the mhi/core Makefile.
* Introduce APIs to allocate and free MHI controllers. This is done to make
  sure that the allocated structs are initialized to NULL before passing to
  the MHI core.
* Remove the requirement to have a dedicated IRQ for each event ring.
  The MHI controllers can now use a single IRQ for all event rings.

Please consider merging!

Thanks,
Mani

Changes in v2:

* Clubbed both series (take one and two) onto a single one
* Used dev_groups to manage sysfs attributes
* Merged the debugfs fix patch with the debugfs patch
* Dropped MAX_MTU patch for now

Changes in v3:

* Dropped below patches:
    bus: mhi: Remove auto-start option
    net: qrtr: Start MHI channels during init

Bhaumik Bhatt (12):
  bus: mhi: core: Remove double occurrence for mhi_ctrl_ev_task()
    declaration
  bus: mhi: core: Abort suspends due to outgoing pending packets
  bus: mhi: core: Use helper API to trigger a non-blocking host resume
  bus: mhi: core: Trigger host resume if suspended during
    mhi_device_get()
  bus: mhi: core: Use generic name field for an MHI device
  bus: mhi: core: Introduce helper function to check device state
  bus: mhi: core: Introduce counters to track MHI device state
    transitions
  bus: mhi: core: Read and save device hardware information from BHI
  bus: mhi: core: Introduce APIs to allocate and free the MHI controller
  bus: mhi: Fix entries based on Kconfig coding style
  bus: mhi: core: Introduce debugfs entries for MHI
  bus: mhi: core: Introduce sysfs entries for MHI

Clark Williams (1):
  bus: mhi: Remove include of rwlock_types.h

Hemant Kumar (1):
  bus: mhi: core: Add const qualifier to MHI config information

Loic Poulain (3):
  bus: mhi: core: Allow shared IRQ for event rings
  bus: mhi: Remove unused nr_irqs_req variable
  bus: mhi: debugfs: Print channel context read-pointer

Manivannan Sadhasivam (1):
  bus: mhi: core: Fix the building of MHI module

Randy Dunlap (1):
  bus: mhi: fix doubled words and struct image_info kernel-doc

 Documentation/ABI/stable/sysfs-bus-mhi |  21 ++
 MAINTAINERS                            |   1 +
 drivers/bus/mhi/Kconfig                |  20 +-
 drivers/bus/mhi/core/Makefile          |   3 +-
 drivers/bus/mhi/core/boot.c            |  17 +-
 drivers/bus/mhi/core/debugfs.c         | 411 +++++++++++++++++++++++++
 drivers/bus/mhi/core/init.c            |  87 +++++-
 drivers/bus/mhi/core/internal.h        |  37 ++-
 drivers/bus/mhi/core/main.c            |  27 +-
 drivers/bus/mhi/core/pm.c              |  28 +-
 include/linux/mhi.h                    |  51 ++-
 11 files changed, 639 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
 create mode 100644 drivers/bus/mhi/core/debugfs.c

-- 
2.17.1

