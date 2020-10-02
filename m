Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC92D280E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgJBHzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:55:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CDC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 00:55:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so433491lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdWy51JUAJLNrewH/4Ct0ieYg+BQ1cOIElTbSQvUR0g=;
        b=HWGOV3fzMv5hq0ajSUX6MufczLspk6B0S1qY6UPQRO38qwpPu70HCwWy8/qSz51u/v
         Obcn842ENpChlgM8mUnJS6NOwsCHOIMOCUMJ1ZlydIDEa1C+yQ05kRp8bbQs2dh+QDI7
         /KwwJzlFiUUrQCInSlm7gLhjq2caGg6baDRl9wG5VpYgE/FzDbz60Wx/0mtzkdpH2DIi
         b8Y3b31yM87htO1Fhzm7G9pB/VuJmc0LIvCD4+adCjLKLweAK1to29AxmbZidHitQcP8
         z3Ztj+nM/iD8GFTJjByh2mugOFWW8hmp61JolBFeR8nwqOWJslp4w7BhUf1Qib3TS6is
         z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdWy51JUAJLNrewH/4Ct0ieYg+BQ1cOIElTbSQvUR0g=;
        b=b7MK3zPWFj4l4GvwgED36eSsHrdRSW5w26AOxgF0BdwxRLj2+oJ2UomAhh38vJ1f5r
         5T0gBapZYCrQ6/5II4IuqfEGjOnoWsvs92xrJ/3CfEr+CIXuLZeJ7khScAus0fI4Bs7n
         DuD0qYrCcJCZS3oCaXd+njJ0UAR7KiYB4uqJIhH5FejxiNs58vYLpn/Q5mBJE82nRUM6
         Twuf0kSqSgtyWe3FtnE5aeu3nr//L1HEsyE7C4xctmYR0s0gJeYWTnZMZt8i2xA0LPXx
         Y2d+HHZ4LEgTPNLgawGjbPJ4E/P3rf73qPlUZpCe6w1UrCfH2k7GyL6OS2qH4WHKFikm
         6VKg==
X-Gm-Message-State: AOAM5324dNbaWXbzFEg3hXlJyEKbevn9uQ73ZNe/r/hnQMvjIVq+5gGb
        +71QcY8shgCFvTddQR1K0w75HQ==
X-Google-Smtp-Source: ABdhPJw7zZP5KFEI9ROLR7SsICqR8YmYUY2Q43lah1ObGtbmhfNWChCCfHzfSPs1jB5+OPiOCa/ySA==
X-Received: by 2002:a2e:98cf:: with SMTP id s15mr387045ljj.446.1601625305093;
        Fri, 02 Oct 2020 00:55:05 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id y80sm147200lff.254.2020.10.02.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 00:55:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v5.9-rc8
Date:   Fri,  2 Oct 2020 09:55:02 +0200
Message-Id: <20201002075502.130199-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC and a MEMSTICK fix, intended for v5.9-rc7. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 14801c624066a55139c2c57963eb1b859d0a316a:

  mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA (2020-09-14 11:46:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-3

for you to fetch changes up to afd7f30886b0b445a4240a99020458a9772f2b89:

  mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models (2020-09-28 12:16:47 +0200)

----------------------------------------------------------------
MEMSTICK core:
 - Fix deadlock when removing the host

MMC host:
 - sdhci-pci: Workaround broken CMDQ on Intel GLK based IRBIS models

----------------------------------------------------------------
Hans de Goede (1):
      mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models

Kai-Heng Feng (1):
      memstick: Skip allocating card when removing host

 drivers/memstick/core/memstick.c  | 4 ++++
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 include/linux/memstick.h          | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)
