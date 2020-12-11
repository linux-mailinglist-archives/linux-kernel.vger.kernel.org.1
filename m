Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8E2D726B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437251AbgLKI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437204AbgLKI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:57:24 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:56:43 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a12so12311424lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gloM2T2ytwyUj9mw0BbcdmsyAq0N53F7iLnhz3YRDo=;
        b=xi7RNWckbmr6CRXwoyierGqRYmJyCzHui6XnK1w2uv8z79VBmCeaGOVcfnUDrnBskf
         zC8qwUx/abwLjFAJvi8XOjGWEcEeNCNNsIw9VkvJ60xtrx6T/tVcsseecm90B68hjnbJ
         Un9Xg5cVRZ1l6nWLRDMm3+dP01kkcTbTlHO54yAjWGgzm4YePrdCkwKqbfswtXh4DbKs
         jEgrhrc3jaDe2GIH54R6rnhp34h+okoYqZa9GOyAhJxvtZhitAWNVfNi6WSeiZYnw6og
         WPiuWG+me+DpDEUf7VUNioWVU7ZLxVCwXXghcBmL2HNAEEdzH9Q93RFR0rkt24tmidL+
         BmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gloM2T2ytwyUj9mw0BbcdmsyAq0N53F7iLnhz3YRDo=;
        b=Iv1WweaNyXwGwzxN9geQqidUDf4gEOMrvAKWf0/HtCWLqUv7Gp9BvefSP5ahT60oaf
         nOvQMP9nqvg7OJtJkzVxe3A7XZ4N8b1zxZ8E1EZeOpgL+nVAyyheSSmgowPDQubYeUTy
         mMC7uXqIaca9Uy71NC9kQqtYwM+c4fWpE08r5SJ9VOFqtNr1lLLDHd7Oux50fWvHYLRk
         A/xrBOORe98zXtX6/WOBU1Ut47qGzGa8gHn61Fbs+JdQdVEKI7kpIFBP7erYeWnQAd0R
         pzMn122Xxbd7JuD9K0gZ356p19FPEZf05fbt6Bgsp4zv9iIRVFIV+MB2A3vMkJH5Hr3d
         vYVQ==
X-Gm-Message-State: AOAM530uhPT0cCs5kbDmMp9+L4wiFZP0Um7cDb3hmAZdfiTqEOmEuuDd
        KyRTSHUXsQSWfmtuqWmgknq7BajaZdBAAFbi
X-Google-Smtp-Source: ABdhPJxenfhBS5LaX+OydQLlgTw/3JR3lCKOpzxn08h4EeaJjncY+IRLxBvsjjBkyJkV76PQT4hfFg==
X-Received: by 2002:a19:a06:: with SMTP id 6mr873535lfk.624.1607677002443;
        Fri, 11 Dec 2020 00:56:42 -0800 (PST)
Received: from localhost.localdomain (h-155-4-133-162.NA.cust.bahnhof.se. [155.4.133.162])
        by smtp.gmail.com with ESMTPSA id 186sm809087lfb.176.2020.12.11.00.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:56:41 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc8
Date:   Fri, 11 Dec 2020 09:56:40 +0100
Message-Id: <20201211085640.234657-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d06d60d52ec0b0eef702dd3e7b4699f0b589ad0f:

  mmc: sdhci-of-arasan: Issue DLL reset explicitly (2020-11-17 12:44:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4-2

for you to fetch changes up to c0d638a03bc5dfdb08fb95d0a79ecada25f40da8:

  mmc: mediatek: mark PM functions as __maybe_unused (2020-12-04 15:35:54 +0100)

----------------------------------------------------------------
MMC core:
 - Fixup condition for CMD13 polling for RPMB requests

MMC host:
 - mtk-sd: Fix system suspend/resume support for CQHCI
 - mtd-sd: Extend SDIO IRQ fix to more variants
 - sdhci-of-arasan: Fix clock registration error for Keem Bay SOC
 - tmio: Bring HW to a sane state after a power off

----------------------------------------------------------------
Arnd Bergmann (1):
      mmc: mediatek: mark PM functions as __maybe_unused

Bean Huo (1):
      mmc: block: Fixup condition for CMD13 polling for RPMB requests

Muhammad Husaini Zulkifli (1):
      mmc: sdhci-of-arasan: Fix clock registration error for Keem Bay SOC

Wenbin Mei (1):
      mmc: mediatek: Fix system suspend/resume support for CQHCI

Wolfram Sang (1):
      mmc: tmio: improve bringing HW to a sane state with MMC_POWER_OFF

yong mao (1):
      mmc: mediatek: Extend recheck_sdio_irq fix to more variants

 drivers/mmc/core/block.c           |  2 +-
 drivers/mmc/host/mtk-sd.c          | 39 +++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci-of-arasan.c |  3 +++
 drivers/mmc/host/tmio_mmc_core.c   |  6 +++---
 4 files changed, 35 insertions(+), 15 deletions(-)
