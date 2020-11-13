Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5072B1A19
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgKMLal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgKML3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:29:05 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4CC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:29:05 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so10233196ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDegh8tRLZdZUaOxApIDHKwtV2S/hfTSpd/mCcBDwW4=;
        b=t1yUwGoLWVYLzwXirBRjAFli99u0/JjI5HW88vpBo44ajQgw8rGXBa3Rym6FUrLWEs
         Gad2D6WOvtoCyC8L6bzfwXJ+9PR+aqk20wiJu6+YFOmURknmSHMY2aC/QwmMw1Tz93eX
         Sk+BYNMjddf5nD7NJgIUmS0vsd/CORMj2xYqV6/1YCGC5inZKYKpQwzXsbam0HlYCw/a
         d4Z9evWyY0aCXHwrKuh+kBJah4Kj0FYBvww3GvorpzKW+jjAj62VbD/5h4vet4DM9grj
         GPWFzS+JecEG+vfWCTacdPYojPhMOkSQltXLS8Ww8XU7z6sPbREMvQ/kPWtATvzgt38N
         urgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDegh8tRLZdZUaOxApIDHKwtV2S/hfTSpd/mCcBDwW4=;
        b=jBRCSZqm/8S3W5WbcQLANh9elEvtMw6ZSekWvmxs0LfA2clVxJS+zSNUrUd18NFLAb
         7PAmonE/LkgH9xWrYkB4nX4lWqkN4bncN7yL97XNl50XJx75/6mia4i2sATfmLtQyrRB
         Jd56q6pXLwaTxZw56jyAAUdUZuJB8dhdN2Td0ASSRcc9H++LYTxT3xPCeGNbWsdhZjTb
         Tqt2tKrASqru8oW8VFLdkzWmWAC5HX5pRknofBl1LznMCBbQMhFLDVoxYheMjxM4EhJc
         KZC11VpcUexJ4dixeqOBZ9XA7hmLrSzVHLv644DeBur/EzBXVd7vG1FHiNWFE/sJLbk7
         Jw9A==
X-Gm-Message-State: AOAM530nwtrpXubMcwpF23R656BxtSbzzSwKo4cOsIuARMRrGPS10+f4
        sXlW1YdBwSFp0k91zG0esfNr/rdP/y40nmBn
X-Google-Smtp-Source: ABdhPJz8u1vcpX+I/3oC0Ia+nllHrxbYvLOw7/xfaciFUsCmH/A+YktO/CLU3soY3+P+HZ3W+Vyiqw==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr850242ljo.36.1605266943945;
        Fri, 13 Nov 2020 03:29:03 -0800 (PST)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id q4sm1609517ljh.38.2020.11.13.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 03:29:02 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc4
Date:   Fri, 13 Nov 2020 12:29:01 +0100
Message-Id: <20201113112901.292826-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc3

for you to fetch changes up to 03d80e042a8e3248163a38f74b43809f8079d652:

  Revert "mmc: renesas_sdhi: workaround a regression when reinserting SD cards" (2020-11-10 13:58:01 +0100)

----------------------------------------------------------------
MMC host:
 - tmio: Fixup support for reset
 - sdhci-of-esdhc: Extend erratum for pulse width to more broken HWs
 - renesas_sdhi: Fix re-binding of drivers

----------------------------------------------------------------
Wolfram Sang (3):
      mmc: tmio: when resetting, reset DMA controller, too
      mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF
      Revert "mmc: renesas_sdhi: workaround a regression when reinserting SD cards"

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: Handle pulse width detection erratum for more SoCs

Yoshihiro Shimoda (1):
      mmc: renesas_sdhi_core: Add missing tmio_mmc_host_free() at remove

 drivers/mmc/host/renesas_sdhi_core.c | 14 +-------------
 drivers/mmc/host/sdhci-of-esdhc.c    |  2 ++
 drivers/mmc/host/tmio_mmc_core.c     |  7 +++++--
 3 files changed, 8 insertions(+), 15 deletions(-)
