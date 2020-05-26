Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C81D3D86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgENTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgENTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:31:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7033C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:31:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so2131888lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TrvMGjL/nIict/6w5oVI+9sWLqNPjzAT918UG4yoQA=;
        b=oE+erCfB0gVNNvhR9t4gwySrld/o75HjFM6hpk8lOO7oHy7YsdZOrWzT2vRVWNDUOu
         JQVVj5ko9BKmwvQqSeAjXSmGnXziVmfpKmb/A50PUsZAp0u5stMMlmSW79jWis53ih74
         HhW9ShKBjZvT2VPKYmSt3hCNP754KAqXPCuSTV2emYOA30Qz4WbMHykau+LZU7dmB2QW
         JhUNej/rezc+RhgGlh49abfNZSb/B16PyglFaEXCpQHzfexo3k9QwuWrseUjTzL8aCNF
         1E9Gn44ExDoWxBo8T2WCx8l2ClcwATlTpzEI6nFuaUpuSoLckrYFKB228IuzRq3dud/L
         /8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TrvMGjL/nIict/6w5oVI+9sWLqNPjzAT918UG4yoQA=;
        b=LQW+bOtc7hBCyuJNJak2jRHrCoXnW2kK12u5Hl0t7m+ox6fEJWmWDPMgcAFbEgCtMf
         PvcoC9+em13q4gDmP1mbvhxzzJsmGydQf+UXajLtmFrR98602Qhz5uQCj/X43H320nxf
         N4JiGA7E+opz3AD8f4AGt4myupgaBpJYoO0kJLOSvyOCXF5LebKKXIJlG7sHcHcp06QV
         tlLEDlrlIlpJ84f04pDJXQXCIAnbtnmVMaXsEIcFdAVVPwPLlsaJ5CmzmCvrNr95/tch
         +/DUf1aJe+VGJpgsON3Y+f68Z7lNoyyMB32hcLFFk/bmAkvNNb9WRRjsD8l2DkrnjG1D
         AuTA==
X-Gm-Message-State: AOAM530s+Cb8rlKGpV+7twdeHh2Cwey/m64suiACX3P7t0g9Iq3qhf6I
        BdEm6NjiMoSC7v80ad+nbE30p6g0ow4=
X-Google-Smtp-Source: ABdhPJx1ZkrWbi3K6iUfVZTihSVhU7QhCqZ9X8dQVgauINuu5OosIIDfoslhqcJORR/aHR2Q5z+Jdw==
X-Received: by 2002:ac2:5106:: with SMTP id q6mr189628lfb.59.1589484698170;
        Thu, 14 May 2020 12:31:38 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id w9sm2014185ljw.39.2020.05.14.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:31:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.7-rc6
Date:   Thu, 14 May 2020 21:31:36 +0200
Message-Id: <20200514193136.23283-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.7-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc4

for you to fetch changes up to 45a3fe3bf93b7cfeddc28ef7386555e05dc57f06:

  mmc: sdhci-acpi: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA for AMDI0040 (2020-05-11 10:51:30 +0200)

----------------------------------------------------------------
MMC core:
 - Fix a couple of quite severe issues for the CQE request path

MMC host:
 - alcor: Fix a resource leak in the error path for ->probe()
 - sdhci-acpi: Fix the DMA support for the AMD eMMC v5.0 variant
 - sdhci-pci-gli: Fix system resume support for GL975x
 - sdhci-pci-gli: Fix reboot error for GL9750

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix request completion in the CQE timeout path

Ben Chuang (2):
      mmc: sdhci-pci-gli: Fix no irq handler from suspend
      mmc: sdhci-pci-gli: Fix can not access GL9750 after reboot from Windows 10

Christophe JAILLET (1):
      mmc: alcor: Fix a resource leak in the error path for ->probe()

Raul E Rangel (1):
      mmc: sdhci-acpi: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA for AMDI0040

Sarthak Garg (1):
      mmc: core: Fix recursive locking issue in CQE recovery path

Veerabhadrarao Badiganti (1):
      mmc: core: Check request type before completing the request

 drivers/mmc/core/block.c         |  3 ++-
 drivers/mmc/core/queue.c         | 16 +++++-----------
 drivers/mmc/host/alcor.c         |  6 +++++-
 drivers/mmc/host/sdhci-acpi.c    | 10 ++++++----
 drivers/mmc/host/sdhci-pci-gli.c | 23 +++++++++++++++++++++++
 5 files changed, 41 insertions(+), 17 deletions(-)
