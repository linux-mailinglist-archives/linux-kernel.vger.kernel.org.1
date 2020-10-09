Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778B72882ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgJIGqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIGqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:46:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F5BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:46:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a23so7721854ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lmm8Mvi7GzJTrg4u3PucBYSDr2MfUiIacXtIFkPKG30=;
        b=k/8L3F+yzEPMBGI+i7o6ClamzlIznfZD3avEgWSxszNFZEYRtjH1GgLtlYaDXRRnCa
         TV1DjQZVOMim8NP8+jVEGGPYGaFla4E2HOSFs1GAQ3534bJbm2asY/Dvsl0JIshWuwfI
         MLGufU41s1DuJAdqZrsGRQEQa3mjE9O3OFKbPMXFldDD/H4rKlvmtfHKWpsk5LQjJyL8
         cd2+l5Jv+Os+8YVHVM7PPPGhGhbJmkm0bCgaZGsY3R+Du7WQbGWopjX+lg5yrTtYRtim
         fnzMmBzZdu7ZmAdBkszT/V0K/LZ0Pze5sHeE1oiHWNyyp3SosRuMDiB28FnH1ujgZbe3
         TMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lmm8Mvi7GzJTrg4u3PucBYSDr2MfUiIacXtIFkPKG30=;
        b=Aedax3DbflBksya78UD4etYIdTTNB4b7DgF31fo3L+JCLc05fUVQgHLgPCkeYiAajq
         D1aHjt0PScRHxMLt1WCKLTyXswplz/h+fREDm+noFcqssBfm3wGayYn3NOCVB/pFvWkh
         tpiOVwCMYV4lsuXYUnK9SvP090oDfpzU88q5k5ZOG1sUPJc4+zOKnUXE0oPMf54VWqLH
         rotQeSPLw3WGK1DQzd+cyX1IY9CUhlfIwP33a8RDirhs6JmQUr3HvC/9Kg3yfTz46saw
         xU1j69qXn0vyMyohsQILv+QNAT62nMgVrN7oEKnk2Fcc0biS0YVq3Et6NI9HsbURaTR2
         AyTA==
X-Gm-Message-State: AOAM531aj0dgAeHOlSC944pdoaTqb2sfoXs9C5J0FmoQLV60zmGsQVYj
        FmOyha8bCUoY/Dpr8rzhvnxVxw==
X-Google-Smtp-Source: ABdhPJxy8pKGr0/o7HKnmC636Ij70ZV/MDIjtW2WR8hYsa6WuPSfrEzWwFPXn/xuoSzIh+r+N2SnJw==
X-Received: by 2002:a2e:9b96:: with SMTP id z22mr5008967lji.181.1602225962491;
        Thu, 08 Oct 2020 23:46:02 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id b66sm1271374lfg.153.2020.10.08.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 23:46:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.9-rc9 (final)
Date:   Fri,  9 Oct 2020 08:46:00 +0200
Message-Id: <20201009064600.335065-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.9-rc9 (final). Details about the
highlights are as usual found in the signed tag.

Note that, this fix didn't get the time to cook in linux next. Although, the
patch is trivial and also well tested by the people being involved.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit afd7f30886b0b445a4240a99020458a9772f2b89:

  mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models (2020-09-28 12:16:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-4

for you to fetch changes up to 4243219141b67d7c2fdb2d8073c17c539b9263eb:

  mmc: core: don't set limits.discard_granularity as 0 (2020-10-09 08:26:09 +0200)

----------------------------------------------------------------
MMC host:
 - Assign a proper discard granularity rather than incorrectly set it to 0

----------------------------------------------------------------
Coly Li (1):
      mmc: core: don't set limits.discard_granularity as 0

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
