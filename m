Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75AB2FFF92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbhAVJxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbhAVJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:45:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D5C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:44:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b10so5788838ljp.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTGiS+heLDwMPrDkZxlriD+q4LmeVPglFgOPJ0siNp0=;
        b=F256DV2QWsUrgpznESD2OlEkKF2ukvzZZQ4Aw7n2Favo/yBCwnRJAuhcbRhaKM5zdU
         bxHC9I1Rz1ZQT3F5m0/QPSr+vUXIg4pRS2eVwESG8rUj1AOrgeUjkg3Y9MGGkuJBKbtr
         OUcDgR/P9sQvA4ttAn0czDDG4KXivLXw3vIAHO2fhJpnBtRCOx1nsG4/WOPRopv03fp4
         204Wc5EyzoVgB0qC1gRPYmjIHXdHivlXO5qsAIl5FcOEXuBepUd1OHrzVg3HgO/x9UIJ
         ko3fCSZrNQoU1aj7Nm+w5YiXswlTi91ru8fi7fpV1RqUHRqtV7iIVUbgAbYav6z1TV37
         78bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTGiS+heLDwMPrDkZxlriD+q4LmeVPglFgOPJ0siNp0=;
        b=sbYhH0Tee3LTJANtCEKKlcTEqOotoWaSdyiFpNm7kSZT6eqdcuBK2605jD/XZTv5Md
         Vu/R+YjvEHVlCyLlFSugJmebbKDR4Muqkut/U3hy7nk4FOrj8DFkOxpfag6jVao+FZey
         om+gw9evS10L/cDxw0BSMeoQGdR4VF2Ro+8rNRlPyNH/hKjOO335Fs0O1dmILmAub1Z1
         qk7gfAVt+ddXkB8QmKKntNnbPPIQVx0YB63U5FbTNvPO6U02BOhcmPgGrVKbLF4pkF2O
         IIOkmp+tqNRMONRzrN/GNfJXS4vitGbfANGBkwmMEdrHjqBrIlYkM32yWvK3HpAgrQmT
         gR/Q==
X-Gm-Message-State: AOAM531imGcZqtk4ph937SswTVbakCwv/Wgey3z8ETVpkR4GfhM3LNPF
        1sjTOOTSsGnkfHAtAwKgHlyc+g==
X-Google-Smtp-Source: ABdhPJzqTqNqnW5z3kQ4JW34MX/y9yYZzWPkUDhZm5ktkPZgZQPJR/4+KJ/J1Q92gtO/sOA65aljdw==
X-Received: by 2002:a2e:90d3:: with SMTP id o19mr1444028ljg.382.1611308655122;
        Fri, 22 Jan 2021 01:44:15 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id n18sm820161lfh.37.2021.01.22.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 01:44:14 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.11-rc5
Date:   Fri, 22 Jan 2021 10:44:13 +0100
Message-Id: <20210122094413.69488-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.11-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc3

for you to fetch changes up to b503087445ce7e45fabdee87ca9e460d5b5b5168:

  mmc: core: don't initialize block size from ext_csd if not present (2021-01-15 12:09:15 +0100)

----------------------------------------------------------------
MMC core:
 - Fix initialization of block size when ext_csd isn't present

MMC host:
 - sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
 - sdhci-of-dwcmshc: Fix request accessing RPMB
 - sdhci-xenon: Fix 1.8v regulator stabilization

----------------------------------------------------------------
Al Cooper (1):
      mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend

Alex Leibovich (1):
      mmc: sdhci-xenon: fix 1.8v regulator stabilization

Jisheng Zhang (1):
      mmc: sdhci-of-dwcmshc: fix rpmb access

Peter Collingbourne (1):
      mmc: core: don't initialize block size from ext_csd if not present

 drivers/mmc/core/queue.c            |  4 +++-
 drivers/mmc/host/sdhci-brcmstb.c    |  6 +-----
 drivers/mmc/host/sdhci-of-dwcmshc.c | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.c      |  7 ++++++-
 4 files changed, 37 insertions(+), 7 deletions(-)
