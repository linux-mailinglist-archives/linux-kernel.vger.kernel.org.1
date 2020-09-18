Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4426F6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRHX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgIRHX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k18so4461514wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RQ7gnUfY4nhZ+gVPdKyTHLwffxTEzNolrhRA7Trzg3U=;
        b=GMVZHzfpn7FPNp+uRofQNKSf5c2EI+ZbBCrEYYg2O/vhCQkmhgzkkjAPNNJkK+iMRc
         644bzNMav/TC9cbtP9Q/BO0UTW+quJvp9O34tixO2KM/zxl7VhEkaJpGxpHxmM5hSHmg
         fMliEBE9W7C1XwsUR4L+xTIGbfMvEvhYq0aBhzSW1SYxleozUUOJAyaXg1CRcqxQu3Rk
         Oit3SfVVhbyGTDxuWVZICH7nHBZEkX7SDclQqzC3BKXeNQuqYbDZDBoKhk1VUfjkwRIf
         l6j+m2MoB42FHSxM23fYXYB5BBNLc2GWq0BLc8RTDVpYTnxVY4QhP/lIMTXFQ9IZMPT4
         l8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQ7gnUfY4nhZ+gVPdKyTHLwffxTEzNolrhRA7Trzg3U=;
        b=UywLyDWZd1hxaqoVARZqwwu/5pMDDkH6E1M9qCeTKgES16EyQQ9wxne+5KzqOxKaB+
         SPiUkEu3Q0Oj3TbzxXyOJoW0pWY7l5jll2s0jwWlvfNG3zlXsj6sQIjiLY9SANtszJ//
         BsZ5Xb8C4pQzYjtP6t7jGMhN2j80Ke3djqowuNItRkc1KMS8iFexewTBbYn9TYXX+OEh
         ndYWwqQ8iwQrbIRP1Mbc39tucnP1eD1NEOK7OoBmgqoWZZG0HU2y+F3OClC/OqU9kJRM
         pZ24YRs2nFk81jAr+twOKsnyLidF4tq5ntshtivvfDziKONYvy8DGZEuQLhSd2T6tih5
         YSGw==
X-Gm-Message-State: AOAM532wqhx5hUerNzi/rU+LA9msj9RPuZjnv57QmI9SBsF/Aj2jVJ8V
        oDweYKWd+TcRnHBubo6ggJvujA==
X-Google-Smtp-Source: ABdhPJxiv+H66NLT1UIcB9KXcKY70fuZprDSp7iz4U0uXUTkU7jt9814Cn/SkzPf3bNntf6LFFV3kw==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr14972472wmh.133.1600413805385;
        Fri, 18 Sep 2020 00:23:25 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 00/17] crypto: allwinner: add xRNG and hashes
Date:   Fri, 18 Sep 2020 07:22:58 +0000
Message-Id: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
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

Changes since v6:
- fix sparse error in sun8i-ce-cipher.c

Corentin Labbe (17):
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

 drivers/crypto/allwinner/Kconfig              |  43 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   3 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 116 +++--
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 381 ++++++++++++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 413 ++++++++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 164 +++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 127 +++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 139 +++++-
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 205 +++++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 444 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 173 +++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  89 +++-
 13 files changed, 2240 insertions(+), 59 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c

-- 
2.26.2

