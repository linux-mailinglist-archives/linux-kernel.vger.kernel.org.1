Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663AC2962D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901902AbgJVQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897479AbgJVQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:38:14 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083DC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:38:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k68so2034911otk.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsYWuy5NoBRPy7jUEIZ5+gkdCoUV88ijObMsU0llGGI=;
        b=PR/b4oSBq3kFmWmr7dgtGtkGb+4OA7VaKXGRiOS0zRbSuBLmJu7Nhqfw9sZuth/RvE
         1RCEJU7L7b/dCh0B9pGW26di7g4+Lpka8XPmB6kxmrcp1TbpxK19reC4C2CIuNkuPRX/
         78gq2HNKDvLerYp5tjVwZfQ4DC85soX1V7adT9yUHO95aZOUWrNLR7PweWZijdkBsyTu
         DO2GWbJfuJ5ayrvX8wz0FhPfvbEEbYPSqg25xe56jATECjJ0rbrLx4urpmQNxEVND8uu
         Nvc+JN9CiQF+LKhJLEsw2JkWg6lYl8yn5/ds+e0MnYCHYsTsJ2YKLw+DL4OzFfhKh2CZ
         aydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsYWuy5NoBRPy7jUEIZ5+gkdCoUV88ijObMsU0llGGI=;
        b=FqF1nJpVqWVwHIqCiQpSGp4RHHUBHL5GFSo/HFXRBiVye7tlj+MXtDbqNpgPZsRyIL
         +S+xMHuFmNuTW2oB28vOIb8C2Lnq/O++fnfDV0KW6hDGpEqsrVcSUZ/mIMzaPtULc4JM
         2nvPtfDUravln66BCneTkNPzBoeaOh53ufOP4Ikaa6QSYfYgl4lIpCe0wcq11N90sAUF
         roMARbJCoiUCkHBg/65QPpTgd7HKk2OoLf+OaduOO7xYnM5E6NV6eTq7NpHBSwfY13bT
         xpqlvduWKD1JSO7zHECzInY4VMvyeWgXTsrMnU++X/9LtoS5Q3bwpCdohVWFuT17kUZd
         ZvxA==
X-Gm-Message-State: AOAM5310RmX0AIobpyL3XWr2G973KNxl84Yw0dl6UtnmQqEhglSuvjvp
        wtce4FCDIdbvBa56W2uBv2Y/8w==
X-Google-Smtp-Source: ABdhPJxo2SY5J5AKn+mkVnRSgOhcDBXKSLMC3YxFer9m/oYTrIXEoeRPbqh+NcW27+mG5+4f0BJiGg==
X-Received: by 2002:a9d:518e:: with SMTP id y14mr2302569otg.138.1603384692827;
        Thu, 22 Oct 2020 09:38:12 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t27sm521387otc.14.2020.10.22.09.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:38:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [GIT PULL] remoteproc updates for v5.10
Date:   Thu, 22 Oct 2020 11:32:46 -0500
Message-Id: <20201022163246.21438-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.10

for you to fetch changes up to 141bc97c1bfe31397b2a12e5676d0c2692c8e07e:

  remoteproc/mediatek: Remove non-standard dsb() (2020-10-15 22:14:42 -0500)

----------------------------------------------------------------
remoteproc updates for v5.10

This introduces support for the Mediatek MT9182 SCP and controlling the
Cortex R5F processors found in TI K3 platforms. It clones the
longstanding debugfs interface for controlling crash handling to sysfs.
Lastly it solves a bug where after a warm reset of Qualcomm platforms
the modem would crash upon first boot.

----------------------------------------------------------------
Alexandre Courbot (1):
      remoteproc: scp: add COMPILE_TEST dependency

Bjorn Andersson (1):
      remoteproc/mediatek: Remove non-standard dsb()

Colin Ian King (1):
      remoteproc/mediatek: fix null pointer dereference on null scp pointer

Mathieu Poirier (1):
      remoteproc: stm32: Fix pointer assignement

Pi-Hsun Shih (1):
      remoteproc/mediatek: Add support for mt8192 SCP

Rishabh Bhatnagar (3):
      remoteproc: Change default dump configuration to "disabled"
      remoteproc: Add coredump as part of sysfs interface
      remoteproc: Add recovery configuration to the sysfs interface

Sibi Sankar (2):
      remoteproc: qcom_q6v5: Assign mpss region to Q6 before MBA boot
      remoteproc: Fixup coredump debugfs disable request

Suman Anna (4):
      dt-bindings: remoteproc: Add bindings for R5F subsystem on TI K3 SoCs
      remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem
      remoteproc: k3-r5: Initialize TCM memories for ECC
      remoteproc: k3-r5: Add loading support for on-chip SRAM regions

 Documentation/ABI/testing/sysfs-class-remoteproc   |   44 +
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml       |  281 ++++
 drivers/remoteproc/Kconfig                         |   15 +-
 drivers/remoteproc/Makefile                        |    1 +
 drivers/remoteproc/mtk_common.h                    |   32 +
 drivers/remoteproc/mtk_scp.c                       |  199 ++-
 drivers/remoteproc/mtk_scp_ipi.c                   |    9 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |   16 +-
 drivers/remoteproc/remoteproc_coredump.c           |    6 +-
 drivers/remoteproc/remoteproc_debugfs.c            |   23 +-
 drivers/remoteproc/remoteproc_sysfs.c              |  119 ++
 drivers/remoteproc/stm32_rproc.c                   |    2 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           | 1395 ++++++++++++++++++++
 include/linux/remoteproc.h                         |    8 +-
 14 files changed, 2087 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_r5_remoteproc.c
