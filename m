Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C446125D714
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgIDLVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgIDLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1DC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:10:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t10so6373617wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ttSGaNWww4nvkMqgyedyrDpMFb/w80auwjdeLWq3O/c=;
        b=QkRmNCptT1MhVHtuNTgDbEyS5KPuEPkAR82TgVREIRG0eHWS/PwW+tbt3LIKrlOPkq
         d8wSBamdzeDbikMzGR+VMv+gpzjWarlnA7kfX3JG0N41rnrn3/eaKBK3DsrbuNmBY5lH
         w2OIYRC+60WSxTAr2E7ZZMP4zEdULO+j4500sKJbacBrhPZsuSXblcgWheNXnpAbmkHj
         1SMBOMgkHBeHLwWpkce3gS89ams/urhRihXyl2Dd0YaE+pPnuRSrPIFJ1DvCK4SbP8NK
         k9UKHSI5RHXDu0FWbACw+LLjO3odrhhoRPRnSPsowQvZvGDNFDY+eW6hvhbh2brvS+Hp
         nC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ttSGaNWww4nvkMqgyedyrDpMFb/w80auwjdeLWq3O/c=;
        b=Gt9iN5DOqwWBgzKt7mHFFf5OR7YXdXcAK67dA5R5oVx/b9PMhSRzDjWBQOwQlLWKFr
         Px9oPQwA7qy/BDPTRoBYkfKH+0feH8oBauo8Rpxp+gYsdbcUENr7TEOgrVgFDyCW8NQd
         2DQVM34/2DBfXlIsRu3X26zI6IMugvvOVqXu0IhnxjBiWB052aHGJPpz4d1S31GEACcq
         908GDJidN1AH9CpYBWqnTDLqoV1b2i7sMSbvNLwLwvjAfYnD72zqRad3QCQId5o5DngT
         +Xpd8BaOHN372CA+Ai8mxAcuB/SCxG9i5hv43sorqqalA7qQikDc2E0FKh6haybsaHih
         EBHg==
X-Gm-Message-State: AOAM530k6Xhn/rjs9U+gyYum+kALgmr5smkgb7Mo1RayGrJmmoLpNbSA
        1IDv7NV6kQvXQ/PmqbXJ+fxezQ==
X-Google-Smtp-Source: ABdhPJzxhA4ttKluvV9oDekJ4WV/HBT95FpaaYNGG+kM1y1tY48GTJdQZH+O6SHavh0KZa0C684P5Q==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr7584476wrt.247.1599217810710;
        Fri, 04 Sep 2020 04:10:10 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:10 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 00/18] crypto: allwinner: add xRNG and hashes
Date:   Fri,  4 Sep 2020 11:09:45 +0000
Message-Id: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The main goal of this serie is to add support for TRNG, PRNG and hashes
to the sun8i-ss/sun8i-ce driver.
The whole serie is tested with CRYPTO_EXTRA_TESTS enabled and loading
tcrypt.
The PRNG and TRNG are tested with rngtest.
Both LE and BE kernel are tested.

This serie was tested on:
- sun50i-a64-pine64
- sun8i-a83t-bananapi-m3
- sun8i-r40-bananapi-m2-ultra
- sun50i-h5-libretech-all-h3-cc
- sun8i-h3-orangepi-pc

Regards

Change since v1:
- removed _crypto_rng_cast patch

Change since v2:
- cleaned unused variables from sun8i-ce-prng
- added some missing memzero_explicit

Change since v3:
- rebased on latest next
- removed useless cpu_to_le32() in sun8i-ss
- added 2 last patches
- add handle endianness of t_common_ctl patch

Change since v4:
- added a style issue patch

Changes since v5:
- handle failure pattern of pm_runtime_get_sync
- Add missing linux/dma-mapping.h

Corentin Labbe (18):
  crypto: sun8i-ss: Add SS_START define
  crypto: sun8i-ss: Add support for the PRNG
  crypto: sun8i-ss: support hash algorithms
  crypto: sun8i-ss: fix a trivial typo
  crypto: sun8i-ss: Add more comment on some structures
  crypto: sun8i-ss: better debug printing
  crypto: sun8i-ce: handle endianness of t_common_ctl
  crypto: sun8i-ce: move iv data to request context
  crypto: sun8i-ce: split into prepare/run/unprepare
  crypto: sun8i-ce: handle different error registers
  crypto: sun8i-ce: rename has_t_dlen_in_bytes to cipher_t_dlen_in_bytes
  crypto: sun8i-ce: support hash algorithms
  crypto: sun8i-ce: Add stat_bytes debugfs
  crypto: sun8i-ce: Add support for the PRNG
  crypto: sun8i-ce: Add support for the TRNG
  crypto: sun8i-ce: fix comparison of integer expressions of different
    signedness
  crypto: sun8i-ss: fix comparison of integer expressions of different
    signedness
  crypto: sun8i-ce: fix some style issue

 drivers/crypto/allwinner/Kconfig              |  43 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   3 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 117 +++--
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 386 ++++++++++++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 413 ++++++++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 164 +++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 127 +++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 135 +++++-
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 205 +++++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 444 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 173 +++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  89 +++-
 13 files changed, 2233 insertions(+), 68 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c

-- 
2.26.2

