Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D342A04FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgJ3MH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgJ3MH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:07:58 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FEC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:07:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so535948ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWl6kkg5Q6VUV9xC9388CJRuaSl1dYHpzCndnob9kB4=;
        b=By0SXtM4SXWxM2wU8asEz1qFRuwUiKgBv8vGy49bbCERVMAdtch2iRW6JJydatEryU
         VoiGk06sr1rzNJD+QePlUkQ0lTbwVzoJsL2jDBgjlT5555GSEKNsZ1wB0FjTFk8g8nZI
         1crvgs7RPEYf2mQuH61gDt1F76dUXCI6k4TbUn7JMRuKvZLvyJ1rGrKnXofltRLRGcK0
         nxehGVP2eHV4qmkBO/dUDZfLDo9yuOClcs/Mg0M15lCLb3XFHciCauqsub5dxyAJTirh
         wv2ViUXOzX5/h6RT+ckBGuoycOPpepWs9cQq9p3svkgo0R7XZMFcYCQroLICgjZB4gCM
         XwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWl6kkg5Q6VUV9xC9388CJRuaSl1dYHpzCndnob9kB4=;
        b=ETf5NLJZV6jTjJh4kz7L9leQ3ZYtQmnuuRBFXBXbA5qtVg2HDSVBsm219xEDKFOYF5
         ZrbhQ7by5MRAuQjr331Tn6XEVcuEtqRCfKv6LQOjMLcsmDBiB0y5lsKLbNp1JDOfMBQR
         QdKzfe/lpqh5SSr9rObrbOWnI2xF27kddMnyCn8ieZbayX4RfI7ZfhP3/j7D/9bEhtIJ
         fF9FNybQP4BFwSRaa6PWssst8JYcl4KRjhqqGV/ksM2LrkNlR1U3B8M6H2dSPvr+JfJI
         OW3z1UBKrW0edaHD3BTXryv0k+z+vuU30wijXPN7Kv5YQq+CvnkK1BOzt4IZ5hNSbLPV
         q5YQ==
X-Gm-Message-State: AOAM530LOamu7hfVIooHZkSuk1KV2NKMsIID/qpUgjt0vqlwZlPHoRqx
        Vn9l8dq9uKSdwJ02U1H/dGCR+Q==
X-Google-Smtp-Source: ABdhPJy9IPZM1kQFdevcRyM6Ic+gWdL1WQ8ywwuUqOhgZS3tV4XXAG7nvD55YzfI4I97HhCTEQOuig==
X-Received: by 2002:a2e:9dd1:: with SMTP id x17mr828972ljj.219.1604059676093;
        Fri, 30 Oct 2020 05:07:56 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id a6sm603780lfm.207.2020.10.30.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 05:07:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc2
Date:   Fri, 30 Oct 2020 13:07:52 +0100
Message-Id: <20201030120752.100388-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3e4fb4346c781068610d03c12b16c0cfb0fd24a3:

  Merge tag 'spdx-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx (2020-10-14 16:19:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-2

for you to fetch changes up to 011fde48394b7dc8dfd6660d1013b26a00157b80:

  mmc: sdhci-of-esdhc: make sure delay chain locked for HS400 (2020-10-28 11:07:01 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix performance regression with auto CMD auto select
 - sdhci-of-esdhc: Fix initialization for eMMC HS400 mode
 - sdhci-of-esdhc: Fix timeout bug for tuning commands

----------------------------------------------------------------
Jisheng Zhang (1):
      mmc: sdhci: Use Auto CMD Auto Select only when v4_mode is true

Michael Walle (1):
      mmc: sdhci-of-esdhc: set timeout to max before tuning

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: make sure delay chain locked for HS400

 drivers/mmc/host/sdhci-esdhc.h    |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 28 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  6 ++++--
 3 files changed, 34 insertions(+), 2 deletions(-)
