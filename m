Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1E27B1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1QfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1QfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:15 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B543C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so1537034pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrvttkunEoO9fIi9mHq/ppahufjhXG5TFJ21mEg/pKA=;
        b=YhwHAbX1pUfXUZHZ0f8PFeSsWmL+V3RYm/lHIDeXo6OaMYP+UAi5HVKP+rQbGSMnfA
         bWweHKLOKwJKDJDanxAd7AtVRlupUCNpDS2c4T+GiPL9ez8ND/IX0vVvQlq+Gi/kPkih
         RM9umXQ/Uxw9niCd5kbKknxS6P920pXANna+tg6Pdu9o+InyENkagHUXRYow0J18OOQ3
         +FhogWZo9vnE852nR2rwhX5zuEbOOeEWSEsqWbhI+eaLrHyKlgqxV/JiLXAxun8eHQYo
         hdGaD9xC3bWqxF6PoSj8wq68iCjZ269/agu6TfcKfFobp8kQ/ZOEccWROpNCNX5wFbb7
         byUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrvttkunEoO9fIi9mHq/ppahufjhXG5TFJ21mEg/pKA=;
        b=Yxqk2d6yQ9hMX2ekGbqzUfG3Dn6VzkS4fu9QMY9H/UL3PL7Wgw4VJ9yRVXRa97TkbL
         WMGGCJdZMFzSiXOQVyqrg6fIRqg8ePRhbk65zMPsl0iRQZou8GA/UZpOU5amF4p/FtaZ
         tcw1xmSrCfOdfAMrx1O7FE+hvxrdfckN20H9c8OBHw0o3efZ0ogzGAw1n1iiipRr5ERq
         PHQcOBKpDh8Uu3TkpzUgky1MuD3dNByxf8JP9TwB2G4CDjYe/+uCL5o1rub+YLn/X6VN
         bLAttCTQu/Y3aBwIaISX39Y6SzUb2g8KM71/uBTcE0FmBbNtj79qU4Gz3bpuAV9nI8Ug
         SGpg==
X-Gm-Message-State: AOAM5313GGrrZ9e8HUF81gHpaELSjBtWO7Erm48jZglX38ZhoFTIrsl7
        h+/nrn5WqM06VAI9WYsBHbgbKg==
X-Google-Smtp-Source: ABdhPJyLxnQ3bu81o+/qsJR7CxTUdldNai6Dt5V1e75ZNa79IuhkE5dizZmRNXGEukNmsrUHsXuJUg==
X-Received: by 2002:a65:47c4:: with SMTP id f4mr1755344pgs.329.1601310914605;
        Mon, 28 Sep 2020 09:35:14 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:14 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] coresight: Next v5.9-rc7
Date:   Mon, 28 Sep 2020 10:34:48 -0600
Message-Id: <20200928163513.70169-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

This is the second part we were hoping for, i.e CoreSight modularisation,
and a fix for a copy/paste error in the context save/restore process.
Please consider for the next merge window.

Applies on top of your "char-misc-next" branch.

Thanks,
Mathieu

Kim Phillips (8):
  coresight: Use IS_ENABLED for CONFIGs that may be modules
  coresight: etm3x: Allow etm3x to be built as a module
  coresight: etm4x: Allow etm4x to be built as a module
  coresight: etb: Allow etb to be built as a module
  coresight: tpiu: Allow tpiu to be built as a module
  coresight: tmc: Allow tmc to be built as a module
  coresight: funnel: Allow funnel driver to be built as module
  coresight: replicator: Allow replicator driver to be built as module

Mian Yousaf Kaukab (2):
  coresight: Export global symbols
  coresight: tmc-etr: Add function to register catu ops

Mike Leach (2):
  coresight: cti: Fix remove sysfs link error
  coresight: cti: Fix bug clearing sysfs links on callback

Sai Prakash Ranjan (1):
  coresight: etm4x: Fix save and restore of TRCVMIDCCTLR1 register

Tingwei Zhang (12):
  coresight: cpu_debug: Add module name in Kconfig
  coresight: cpu_debug: Define MODULE_DEVICE_TABLE
  coresight: Add coresight prefix to barrier_pkt
  coresight: Add try_get_module() in coresight_grab_device()
  coresight: stm: Allow to build coresight-stm as a module
  coresight: etm: perf: Fix warning caused by etm_setup_aux failure
  coresight: cti: Add function to register cti associate ops
  coresight: cti: Don't disable ect device if it's not enabled
  coresight: cti: Increase reference count when enabling cti
  coresight: cti: Allow cti to be built as a module
  coresight: catu: Allow catu drivers to be built as modules
  coresight: core: Allow the coresight core driver to be built as a
    module

 drivers/hwtracing/coresight/Kconfig           |  54 ++++--
 drivers/hwtracing/coresight/Makefile          |  26 +--
 drivers/hwtracing/coresight/coresight-catu.c  |  37 ++++-
 drivers/hwtracing/coresight/coresight-catu.h  |   2 -
 .../{coresight.c => coresight-core.c}         | 154 +++++++++++++++---
 .../hwtracing/coresight/coresight-cpu-debug.c |   2 +
 .../{coresight-cti.c => coresight-cti-core.c} |  67 ++++++--
 drivers/hwtracing/coresight/coresight-etb10.c |  28 +++-
 .../hwtracing/coresight/coresight-etm-perf.c  |  13 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |   5 +-
 ...resight-etm3x.c => coresight-etm3x-core.c} | 154 +++++++++++++-----
 ...resight-etm4x.c => coresight-etm4x-core.c} |  88 +++++++---
 .../hwtracing/coresight/coresight-funnel.c    |  65 +++++++-
 .../hwtracing/coresight/coresight-platform.c  |   1 +
 drivers/hwtracing/coresight/coresight-priv.h  |  23 ++-
 .../coresight/coresight-replicator.c          |  65 +++++++-
 drivers/hwtracing/coresight/coresight-stm.c   |  20 ++-
 drivers/hwtracing/coresight/coresight-sysfs.c |   2 +
 .../{coresight-tmc.c => coresight-tmc-core.c} |  25 ++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  21 ++-
 drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |  20 ++-
 include/linux/coresight.h                     |   3 +-
 24 files changed, 728 insertions(+), 152 deletions(-)
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (92%)
 rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (94%)
 rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (90%)
 rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (96%)
 rename drivers/hwtracing/coresight/{coresight-tmc.c => coresight-tmc-core.c} (95%)

-- 
2.25.1

