Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79F2272B05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgIUQI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgIUQI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:08:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E2DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:08:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d6so9652629pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Hfx4RTpZhFAY4Z2pUhJV8nNIOCBdY90YIEZPHB5rL1s=;
        b=P1kXJJSdlE+mZb3JoUzmJ4E529qwlmWdoyRTRe/D5BTl0hDaPNOof2IEfqXCa3ZQ8A
         2sUR16R2bPcCKvDvfHnxr00hPAS51U59Zkk945RSwcMfFaJgjPfjLV5Fs667Hp9mHXcD
         ob5dYDHo0PPTjYmPSLFPzf/MEsx9Ck9YaNvallspu6bhElXtMpYn4xmEy90wOZZrc2JC
         fbGtTIiadZ9sTt0hl0RIFRiXJ0RnBs462tt8yp8IhJBS02Bvu/qgkfiV69OvhZ/5E/cs
         eEhnr50k+xYabbSsfuxAwGISEjjN+u53Y2Z/6YkzXTuMwqVDkkq5c0ZlBYILQ+MVyaGb
         580Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hfx4RTpZhFAY4Z2pUhJV8nNIOCBdY90YIEZPHB5rL1s=;
        b=Ri0mOqXqFqMcEGP7JIPJx1I1+oHsap2QKOLxB1cJKzw16e4GkQ7qwX7HfvJR2ECZea
         P1kbuotG1r3fEIP6d1pfS62D/HDzKpaFHduB5mwQ+WAXMbdEOBV2S+tmK80E7nYpGODr
         q3Vw/jwi9LSnFPDsx2zRtcHur1ZhO+bnHj5X14OvY+CjDofiGCY46uQwJON8VUzsvk18
         Fb62q99zyrlMih71KKhG6HQFF5KREf/eLDECiUOue0fu3NCH/jyPhP6Y3Q3TGolzGZug
         atUkS79/UXjwWkDMAGtVUB3xh2DX2KdRMR0VbCfwIefbWUwzLj5o4ruHDi6ntyKCBZuw
         mV9w==
X-Gm-Message-State: AOAM531+ktrCTUMdOCJ7j8dLvzcPap27/cmpvOvga0UnjA2kulg/dqtD
        3BXOZsvYhJGJdzRHWbiQWYkP
X-Google-Smtp-Source: ABdhPJy49Zt+/HsF0E4gG2X763eYsUgLBjZgKiymr27NsU3OgSXg9tsma0xM97yQiYo1dLcE5SKybw==
X-Received: by 2002:a63:d251:: with SMTP id t17mr293420pgi.280.1600704508436;
        Mon, 21 Sep 2020 09:08:28 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:08:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/18] MHI changes for v5.10
Date:   Mon, 21 Sep 2020 21:37:56 +0530
Message-Id: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
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
* Fix the warning reported by Kbuild bot by using append (+=) Kbuild rule
  to the mhi/core Makefile.
* Removed the requirement to have a dedicated IRQ for each event ring.
  The MHI controllers can now use a single IRQ for all event rings.

Please consider merging!

Thanks,
Mani

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

Loic Poulain (2):
  bus: mhi: core: Allow shared IRQ for event rings
  bus: mhi: Remove unused nr_irqs_req variable

Manivannan Sadhasivam (1):
  bus: mhi: core: Fix the building of MHI module

Randy Dunlap (1):
  bus: mhi: fix doubled words and struct image_info kernel-doc

 Documentation/ABI/stable/sysfs-bus-mhi |  21 ++
 MAINTAINERS                            |   1 +
 drivers/bus/mhi/Kconfig                |  20 +-
 drivers/bus/mhi/core/Makefile          |   3 +-
 drivers/bus/mhi/core/boot.c            |  17 +-
 drivers/bus/mhi/core/debugfs.c         | 410 +++++++++++++++++++++++++
 drivers/bus/mhi/core/init.c            | 103 ++++++-
 drivers/bus/mhi/core/internal.h        |  37 ++-
 drivers/bus/mhi/core/main.c            |  27 +-
 drivers/bus/mhi/core/pm.c              |  28 +-
 include/linux/mhi.h                    |  51 ++-
 11 files changed, 654 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
 create mode 100644 drivers/bus/mhi/core/debugfs.c

-- 
2.17.1

