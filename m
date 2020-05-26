Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7069319DEC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDCTuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 15:50:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40529 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:50:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so8986020wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=nFx9+E3/I3cB6us//mWp1dQ/lgfKdqFwPaZtN2Fz8F8=;
        b=a9N6X3yRHB1eUo8fHlrRPYDRWb0Dmp/Y+K6uUEA2mCZqFhCsFmFkm3uh5cyg2F7cUg
         mWw6jU1pl15z9+9j1LzeK3X/cm8T5TgS+/Uy0uKEhB9SVKJaTk2/8nztX2utpd/MHSbH
         xq9oqXMO0zeUcFmQKD13FKOVaDL3gS1R2FnFky5Ip4MdaPw0KCjFQ2+j2JjfbCjn8OJs
         awphxpsaIxsMAIhmFWIGknHVD4vFHqDDYXnp6WpQ18tLnXE4L/UYNGPvr6MoIdOyk+wx
         EzF3//SnimpL96RLJ1VN+rSh77GLM7SUzBD+xTRKAp2D4M4PRFeOCKmGCfKz4Plzfq+M
         Vt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nFx9+E3/I3cB6us//mWp1dQ/lgfKdqFwPaZtN2Fz8F8=;
        b=r2QX6gbIBEATd+pl2z2HZIsGyLO2ihnq47v+MGQ+GcjornDyMXjufZj8XEcaLnRxMl
         ALvF4jBoQTbsC/uamuoKIAqkQ3BazA2uY5hSkBB1TbFawDInIH7W3KOR9tRH+gsKb5B3
         gkwM4P3xSa97zJWMgHPZjoOZS4f2VA9m+GkBebHDqb95RjLAnaHQNL2ngHRHSShvCnPF
         ljUGspyPeA0XpVjtleYTbxFtjqPpKo+QLfnflA9bH9kLcbp9BF7PEcAI2U9Wd0BloVig
         eu1JtP+49M0CPXWKb9zTSQ6ZACUV+Lp4e6deSRETy0qE6JjKQ4HlxSkvpdJE7DzDk8yU
         XahQ==
X-Gm-Message-State: AGi0PuYSxcVeAfKbxXhHVrPx4IiTEJBsP90IWLLNiXj7hTt3rkUCEoBT
        PrQgTnWzTu3V1emW+TVNtGmP1g==
X-Google-Smtp-Source: APiQypIF0ut2srpAxEZKs7x+LNw+xXPDmIM+QWqFYlREFjQlIbCeKGLvmqhiFyfO/WD4LC6sVSkxig==
X-Received: by 2002:a1c:2056:: with SMTP id g83mr10219642wmg.179.1585943447063;
        Fri, 03 Apr 2020 12:50:47 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c17sm8102448wrp.28.2020.04.03.12.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 12:50:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/7] crypto: sun8i-ss: support PRNG and hashes
Date:   Fri,  3 Apr 2020 19:50:31 +0000
Message-Id: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The main goal of this serie is to add support for PRNG and hashes to the
sun8i-ss.
The whole serie is tested with CRYPTO_EXTRA_TESTS enabled and loading
tcrypt.
The PRNG is tested with rngtest.

Regards

Corentin Labbe (7):
  crypto: rng - add missing __crypto_rng_cast to the rng header
  crypto: sun8i-ss: Add SS_START define
  crypto: sun8i-ss: Add support for the PRNG
  crypto: sun8i-ss: support hash algorithms
  crypto: sun8i-ss: fix a trivial typo
  crypto: sun8i-ss: Add more comment on some structures
  crypto: sun8i-ss: better debug printing

 drivers/crypto/allwinner/Kconfig              |  17 +
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 198 +++++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 446 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 169 +++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  93 +++-
 include/crypto/rng.h                          |   5 +
 7 files changed, 927 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c

-- 
2.24.1

