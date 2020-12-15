Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66602DB348
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgLOSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgLOSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:08:13 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:07:33 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id o5so1238054oop.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JC3h4GC0ylyQGULSj65L3q460/4+ILcMsFpnBZD1OnM=;
        b=P4jenG9MAtrYQSES9uXdQvpqV3jj6l5VyvRtE33kUpyuzWZhm7pjXZdoAjFKMUpFtn
         tZE7ODYYm84v+oPyJsyroP9ewDwxEnf9pr8+I9eID/mL9wsi6hqvGAFnuU0uLaTuj5Z2
         VH6xKXe85GnqAi749x1kkiv/qDxwmf/mxjbymLi39kmpsHAF8mzGnaohAOAyR5mN3SI3
         JbcbhUCgI35nLszBsFp1G9I1qrY1/IEgZ9KamN2Agiswp+/yIXZrdkeOIq0ak2V5ahat
         xDG3pF6SIAVkaLEoVSyqVVr4YcqZsEFs948vMCTPxFHYpmd1Jc4sL6BCAexyw8tKCE02
         Dt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JC3h4GC0ylyQGULSj65L3q460/4+ILcMsFpnBZD1OnM=;
        b=phljlrMbNQDWdN/loaTouXzqM1MibSW790m4KqOgc2ASxu32jGAORPBtnES2ascQk4
         Mg4dAjFwbz5vQv2dD7g0NCQDBtWvdDJAMfCkkMzBmpsRD+nY+2CfB7Jr+DfPeTvczpDy
         6mLuB/S6dZruYiZOQUKDnq8HgwCPqFjr80hdzMEfQk61m8isZIa5amEA1nYHA48ywSIG
         AQn+ATNaQw2zz2oj4vrCloiIDVgnR/66/Dm5WYw++G6MRQ8YtVV5UHaV1H9yBZe8WonE
         KQ17tG5w9FRyRyURcQV3QEN1LyTmUmlUpjK34mMdjkXQsx4X5czkVa194Jamv2TLd39u
         Jc+g==
X-Gm-Message-State: AOAM530/TKHwi9R8GavmgZaek2b7LZkuE56LWQTyUEOCgOZhk8YCPPfy
        +q25lEzpZ8YmZ76T9NxEqSEnJA==
X-Google-Smtp-Source: ABdhPJwCnJmU8UJVImpRlFm9PDiSnUX4Hr0n3RVvzXiofwC1c3POOc/JF5fVxu6n1OqgspMw2ZTBBA==
X-Received: by 2002:a4a:8c73:: with SMTP id v48mr8296537ooj.53.1608055652382;
        Tue, 15 Dec 2020 10:07:32 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s9sm200781oie.53.2020.12.15.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:07:31 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sibi Sankar <sibis@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [GIT PULL] remoteproc updates for v5.11
Date:   Tue, 15 Dec 2020 12:07:30 -0600
Message-Id: <20201215180730.1528483-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.11

for you to fetch changes up to 3efa0ea743b77d1611501f7d8b4f320d032d73ae:

  remoteproc/mediatek: read IPI buffer offset from FW (2020-12-10 13:32:10 -0600)

----------------------------------------------------------------
remoteproc updates for v5.11

This introduces support for controlling the TI PRU, adds hooks for
remoteproc drivers to override the default ELF based coredump format,
introduces a library function for coredumps using named sections (aka
the Qualcomm "minidump" format). It fixes a problem with inconsistent
notifications sent by the Qualcomm sysmon driver to the remote
processors and it migrates the Qualcomm MSS driver to use power-domains
for resources that aren't actually regulators.  Lastly it contains a
number of fixes for minor bugs and build warnings throughout the
drivers.

----------------------------------------------------------------
Alexandre Courbot (1):
      remoteproc/mtk_scp: surround DT device IDs with CONFIG_OF

Arnaud Pouliquen (3):
      dt-bindings: arm: stm32: Add compatible for syscon tamp node
      dt-bindings: remoteproc: stm32_rproc: update for firmware synchronization
      dt-bindings: remoteproc: stm32_rproc: update syscon descriptions

Arnd Bergmann (2):
      remoteproc: ti_k3: fix -Wcast-function-type warning
      remoteproc: sysmon: fix shutdown_acked state

Bjorn Andersson (4):
      remoteproc: sysmon: Ensure remote notification ordering
      remoteproc: sysmon: Expose the shutdown result
      remoteproc: qcom: q6v5: Query sysmon before graceful shutdown
      remoteproc: sysmon: Improve error messages

Colin Ian King (1):
      remoteproc: fix spelling mistake "Peripherial" -> "Peripherial" in Kconfig

Grzegorz Jaszczyk (1):
      remoteproc: pru: Add support for PRU specific interrupt configuration

Rikard Falkeborn (3):
      remoteproc: ingenic: Constify ingenic_rproc_ops
      remoteproc: stm32: Constify st_rproc_ops
      remoteproc: qcom_sysmon: Constify qmi_indication_handler

Sibi Sankar (2):
      remoteproc: qcom_q6v5_mss: Replace ioremap with memremap
      remoteproc: qcom_q6v5_mss: map/unmap MBA region before/after use

Siddharth Gupta (4):
      remoteproc: core: Add ops to enable custom coredump functionality
      remoteproc: coredump: Add minidump functionality
      remoteproc: qcom: Add capability to collect minidumps
      remoteproc: qcom: Add minidump id for sm8150 modem

Souptick Joarder (1):
      remoteproc/mediatek: Fix kernel test robot warning

Stephan Gerhold (4):
      dt-bindings: remoteproc: qcom: Deprecate regulators for Q6V5 PDs
      remoteproc: qcom_q6v5_mss: Allow replacing regulators with power domains
      dt-bindings: remoteproc: qcom,wcnss: Deprecate regulators for PDs
      remoteproc: qcom_wcnss: Allow replacing regulators with power domains

Suman Anna (9):
      remoteproc: Add a rproc_set_firmware() API
      dt-bindings: remoteproc: k3-r5f: Update bindings for J7200 SoCs
      remoteproc: k3-r5: Extend support to R5F clusters on J7200 SoCs
      remoteproc: k3-r5: Adjust TCM sizes in Split-mode on J7200 SoCs
      dt-bindings: remoteproc: Add binding doc for PRU cores in the PRU-ICSS
      remoteproc: pru: Add a PRU remoteproc driver
      remoteproc: pru: Add pru-specific debugfs support
      remoteproc: pru: Add support for various PRU cores on K3 AM65x SoCs
      remoteproc: pru: Add support for various PRU cores on K3 J721E SoCs

Tzung-Bi Shih (7):
      remoteproc/mediatek: fix sparse errors on sram power on and off
      remoteproc/mediatek: fix sparse errors on dma_alloc and dma_free
      remoteproc/mediatek: fix boundary check
      remoteproc/mediatek: skip if filesz is 0
      remoteproc/mediatek: change MT8192 CFG register base
      remoteproc/mediatek: unprepare clk if scp_before_load fails
      remoteproc/mediatek: read IPI buffer offset from FW

YueHaibing (1):
      remoteproc: k3-dsp: Fix return value check in k3_dsp_rproc_of_get_memories()

Zhang Changzhong (1):
      remoteproc: qcom: Fix potential NULL dereference in adsp_init_mmio()

Zhang Qilong (3):
      remoteproc: q6v5-mss: fix error handling in q6v5_pds_enable
      remoteproc: qcom: fix reference leak in adsp_start
      remoteproc: qcom: pas: fix error handling in adsp_pds_enable

 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   1 +
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  12 +-
 .../bindings/remoteproc/qcom,wcnss-pil.txt         |  20 +-
 .../bindings/remoteproc/st,stm32-rproc.yaml        |  21 +-
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml       |   2 +
 .../bindings/remoteproc/ti,pru-rproc.yaml          | 214 +++++
 drivers/remoteproc/Kconfig                         |  14 +-
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/ingenic_rproc.c                 |   2 +-
 drivers/remoteproc/mtk_common.h                    |  30 +-
 drivers/remoteproc/mtk_scp.c                       | 116 ++-
 drivers/remoteproc/pru_rproc.c                     | 875 +++++++++++++++++++++
 drivers/remoteproc/pru_rproc.h                     |  46 ++
 drivers/remoteproc/qcom_common.c                   | 146 ++++
 drivers/remoteproc/qcom_common.h                   |   8 +
 drivers/remoteproc/qcom_q6v5.c                     |   8 +-
 drivers/remoteproc/qcom_q6v5.h                     |   3 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |  15 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 | 124 ++-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  35 +-
 drivers/remoteproc/qcom_q6v5_wcss.c                |   2 +-
 drivers/remoteproc/qcom_sysmon.c                   | 118 ++-
 drivers/remoteproc/qcom_wcnss.c                    | 109 ++-
 drivers/remoteproc/remoteproc_core.c               |  69 +-
 drivers/remoteproc/remoteproc_coredump.c           | 140 ++++
 drivers/remoteproc/remoteproc_elf_helpers.h        |  26 +
 drivers/remoteproc/remoteproc_sysfs.c              |  33 +-
 drivers/remoteproc/stm32_rproc.c                   |   2 +-
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          |   4 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           | 113 ++-
 include/linux/remoteproc.h                         |   4 +
 31 files changed, 2101 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
 create mode 100644 drivers/remoteproc/pru_rproc.c
 create mode 100644 drivers/remoteproc/pru_rproc.h
