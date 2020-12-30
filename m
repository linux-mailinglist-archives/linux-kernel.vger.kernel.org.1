Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181392E7B94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 18:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgL3Rc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 12:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL3Rc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:32:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BAC061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 09:31:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ce23so22716085ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 09:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hnodDRwV7KrX2F5f5m3U5rbzJKs9642aXUNNT4NV9xg=;
        b=fDBWUKGIMs8QU5mQQEUXZreYyS59CQSHAc1LFFxxdUd1uCod27H/Xrr3dCVrKMuo0C
         HmavTpybjJ91dgOD1W81NIn5WgOzU/c4yv+uB4p2TO4BIXUzP0V1vxNVYwWS7kXzlrh0
         YHI82lYeork6vNCkH0QjWfOBJ3dIsvM7tHT7KXYihQ1zC7kOvF7nTLEmLi9zHpvLKMUU
         OSuL0By3a7ZeVaCXsdE7UJNU4haz2e1x3rx9SM8v3Yi8TZrqVXGRxYdBA28k95//1Oqa
         KCymDNKe8E5KfiG3gjUrAn7mL4ifNsGndjuN/DwlXH1F+zxzUEoIHY5MvlvBQaJ0PhBd
         DZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hnodDRwV7KrX2F5f5m3U5rbzJKs9642aXUNNT4NV9xg=;
        b=Hk6mRNVxIIcYyogKdvVD49N/vvdf58TieiNhMe9/QZwEqe5w5KiKvoar3gDoss6tI1
         sUPw+qA1L9WK7EvJg+MBaXCcgKaL+OYosx7VFaDWtrqw8m0mubcTN4zvBvgeP1oY1mI1
         HhwTVBvd3K0zAOC27E0Q68tlKrlNjOYu0/DI8ttj1Ve33/e1PXuU/2j8qXNg0tt4IYnw
         Kz2dmVBFt5P7PQkp2PeU2ZPzeCwbytoaBFC1fdgjomWLz7RwEM/4G4wXRs3eM1it7Mwm
         c+Dp60lvk1Xz3O6z2OanJrhcTbSQ+VfeFUOkNcKKPqXNO1SihZoAViKJnl2+vd2OhtNb
         2Tzw==
X-Gm-Message-State: AOAM530H0UqHpIa5j+OowxeBY3yQBQFKbYY+I9FLOZ0xHra7e5hcdmCC
        fEa9BeNLDvxzRnVa0QiVkqk/l57dCBsSNg==
X-Google-Smtp-Source: ABdhPJxeocVzT2BF0zcq26jNflR5tn8yg80RBmY6qQ1/QKvsdv0JaMY2xmH7cslpKUbg8pZpPWAPWA==
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr51899918ejc.178.1609349504398;
        Wed, 30 Dec 2020 09:31:44 -0800 (PST)
Received: from CORE.localdomain (IGLD-83-130-29-80.inter.net.il. [83.130.29.80])
        by smtp.gmail.com with ESMTPSA id z1sm17188890edm.89.2020.12.30.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 09:31:43 -0800 (PST)
Date:   Wed, 30 Dec 2020 19:31:40 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.11-rc2
Message-ID: <20201230173140.GA11958@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This pull request contains a number of important fixes for 5.11-rc2.
Mainly fixes to support our new F/W with enhanced security features,
but also additional bugs.
See details in the tag message below.

Thanks,
Oded

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-12-30

for you to fetch changes up to b000700d6db50c933ce8b661154e26cf4ad06dba:

  habanalabs: Fix memleak in hl_device_reset (2020-12-29 23:23:12 +0200)

----------------------------------------------------------------
This tag contains the following fixes for 5.11-rc2:

- Fixes that are needed for supporting the new F/W with security features:
  - Correctly fetch PLL information in GOYA when security is enabled in F/W
  - Fix hard-reset support when F/W is in its preboot stage
  - Disable clock gating when initializing the H/W
  - Fix hard-reset procedure
  - Fix PCI controller initialization
- Remove setting of Engine-Barrier in collective wait operations. This
  barrier created a drop in performance
- Retry loading the TPC firmware in case of EINTR during loading
- Fix CS counters
- Register to PCI shutdown callback to fix handling of VM shutdown
- Fix order of status check
- Fix memory leak in reset procedure
- Fix and add comments and fix indentations

----------------------------------------------------------------
Alon Mizrahi (5):
      habanalabs: add comment for pll frequency ioctl opcode
      habanalabs: fetch PSOC PLL frequency from F/W in goya
      habanalabs: remove generic gaudi get_pll_freq function
      habanalabs/gaudi: do not set EB in collective slave queues
      habanalabs: add validation cs counter, fix misplaced counters

Dinghao Liu (1):
      habanalabs: Fix memleak in hl_device_reset

Oded Gabbay (7):
      habanalabs/gaudi: disable CGM at HW initialization
      habanalabs/gaudi: enhance reset message
      habanalabs: update comment in hl_boot_if.h
      habanalabs: adjust pci controller init to new firmware
      habanalabs/gaudi: retry loading TPC f/w on -EINTR
      habanalabs: register to pci shutdown callback
      habanalabs: fix order of status check

Ofir Bitton (2):
      habanalabs: preboot hard reset support
      habanalabs: full FW hard reset support

Tomer Tayar (2):
      habanalabs: Fix a missing-braces warning
      habanalabs: Revise comment to align with mirror list name

 .../misc/habanalabs/common/command_submission.c    |  77 +++++++--
 drivers/misc/habanalabs/common/device.c            |   8 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  60 +++++--
 drivers/misc/habanalabs/common/habanalabs.h        |   4 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   1 +
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   7 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   5 +-
 drivers/misc/habanalabs/common/pci.c               |  28 +--
 drivers/misc/habanalabs/gaudi/gaudi.c              | 191 +++++++++------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   7 -
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   3 +-
 drivers/misc/habanalabs/goya/goya.c                |  75 ++++----
 .../misc/habanalabs/include/common/hl_boot_if.h    |   9 +-
 include/uapi/misc/habanalabs.h                     |   5 +
 14 files changed, 281 insertions(+), 199 deletions(-)
