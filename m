Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5382BA7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKTKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgKTKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:50:13 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605CC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:50:11 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 74so12810017lfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui6T7CKVZyX5zdmfFixy92Jf09nez5RkHLtV0WeJzY0=;
        b=dZCQEwHNsskYy5D8AIWz2qi45Wcs2Z4e3xfY3hTUk2tKBatAOnviRmerOylIfPKZEl
         /Sras5siDr0dT01k0si+JSuJfNxrBSOan/3ulR3lp6WVXjas4lKdolIUMWkEgr+t/sKH
         Bu5Wpar/LnDEmp3pRRoS1IPMrlnXYL0JrJxCjjwNjhU5MecV0Wocrf/oMq8w9w819L8F
         pJ4ICNTExU6+CoHAtxrWcemC2eS/5oFioel086QvUSOwl3lJIFTJwSL2FyqSGfKeCW7Y
         0GKUVaw+lhVvpByWp5qUkIpLZXw6w4k7RblCsT/ihZomp82v6bcW4DQQTxyEHaKcAYZC
         /WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui6T7CKVZyX5zdmfFixy92Jf09nez5RkHLtV0WeJzY0=;
        b=L1Yin4CsGNvlyF9dSjSD8N4RfuqMLjRrvnavdCj0GbZP1uAAu+tr9VIRaRcxKluW8h
         11eaAtZcknhZSNJl05K5pZdKsbqwbx5dWwj5C6GzbA0yUP6JOGUrlyviEH8SJjSWOupW
         wJrZuCgmjiiorQUMmhxicAn/LuA8DkN2t/gFi2JHBS21SwB9jaKyjeQYH/8/eYS25Z3r
         +8EIGV1uYDV6Jlseb4fbetLMIUgFM0eHnPbgf6N1CEnpVIpzMIbJu1Stex7NJwiRmvHv
         O1Zcofnyp9DYpt6n//p/eWQLYS818zk3F+YU2LwpNieUUH7Es6tI+jzHnc5UfNqKsFB6
         Yc8w==
X-Gm-Message-State: AOAM530USk5SwT9hFfP4pD4xP+IJGaSbAiRuxrruGiX0vDvH/aOncW1b
        Eg0LD+RxMmyCapMkVXUGKrz0+w==
X-Google-Smtp-Source: ABdhPJzq8ILTQ9yBLCQ/f9XRy5F3bqzu27ePwvgzTE82Is2/Rk36zeq42qf4V6XmwUJhiZ2fyx6zcA==
X-Received: by 2002:a19:5c7:: with SMTP id 190mr8263208lff.467.1605869409385;
        Fri, 20 Nov 2020 02:50:09 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-251.NA.cust.bahnhof.se. [98.128.180.251])
        by smtp.gmail.com with ESMTPSA id 13sm313017lfy.90.2020.11.20.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:50:08 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc5
Date:   Fri, 20 Nov 2020 11:50:07 +0100
Message-Id: <20201120105007.8184-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4

for you to fetch changes up to d06d60d52ec0b0eef702dd3e7b4699f0b589ad0f:

  mmc: sdhci-of-arasan: Issue DLL reset explicitly (2020-11-17 12:44:44 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-of-arasan: Stabilize communication by fixing tap value configs
 - sdhci-pci: Use SDR25 timing for HS mode for BYT-based Intel HWs

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode for BYT-based Intel controllers

Manish Narani (3):
      mmc: sdhci-of-arasan: Allow configuring zero tap values
      mmc: sdhci-of-arasan: Use Mask writes for Tap delays
      mmc: sdhci-of-arasan: Issue DLL reset explicitly

 drivers/mmc/host/sdhci-of-arasan.c | 51 ++++++++++++++------------------------
 drivers/mmc/host/sdhci-pci-core.c  | 13 ++++++++--
 2 files changed, 30 insertions(+), 34 deletions(-)
