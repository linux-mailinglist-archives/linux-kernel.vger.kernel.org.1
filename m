Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C624D652
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgHUNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgHUNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:43:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA6C061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so1987497wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+vjYqSHFg1tfjSbgPG3HmU9COCn5db17kka4sVp9jtI=;
        b=r5H9FPuS4+KJMtL6vCM02NemupM6X8/id24UmchnvQaMzo+iB4LKw1JqImawPrzPdM
         AkjPhrgb89Hl3Qc41Xnv6pxM2pz9euR2vYxJN4pDpRZcXlATag2QXn22SNI+MTt2n0Wm
         8aK2pNos64P9l4lx2jAJR1CWYCRSST1IhPprli8NQaMrC3lrJle2MbcSp6cod4GgR+ea
         tCLqg5EXmbStOEJSAdw2IQMSqNG5vjHJJc8RmGbsBaYCxisr1ofyC918TR8LdED5Utmn
         4CSzBcNARWxnYmoISF1cCqmNF3eYGq6ecz1tRaG7WL9cyFifJA91IG27R8BdZjE3vMeD
         uzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+vjYqSHFg1tfjSbgPG3HmU9COCn5db17kka4sVp9jtI=;
        b=LiiK+b8c+hzlOzJtO91MM/Gz3io3g9dn1TrrHzV0Dm/Dv4SjaK65ZUBogVEEdypMO6
         HdT5IuI6IeVwbKo/USoLKOTAThknwd2BXzhA/VG2klHfpXlFvFemSrkrtglwDKkYDNk+
         9A2MDebVyHKpnx5oD1GELvOI77jTlFqLsHL8/9B+9I8OQmCoeWtS6sz1XnZazdtVD8BN
         WxVdQhyVEiJB3BQfLXbvUMwmkQcguKEjX4kP/Thhhrj2yvPG+8xNmE0mJ0ibJhXuDorO
         G/KZgjnHdX2QLwbgOo2Zq+vstnYhyimpXbUAprzbjThiJwaFCwB0o8kD+YETlUo938Iu
         SGyw==
X-Gm-Message-State: AOAM532+M/KMmsbVCGC9Wu8P3DGQFPgoATtt+E7vT23LF/Rd6VldiRY2
        Aj0ZGcq/+R0H7pKBoW1ItgnphA==
X-Google-Smtp-Source: ABdhPJzeKBaxIk9BaY0Gonz83Ek7r3J2nU17s0txZd1++KJpDE4CzRy80PH91+LvSo0SE4kBV4uTag==
X-Received: by 2002:a5d:48c3:: with SMTP id p3mr1795435wrs.69.1598017423272;
        Fri, 21 Aug 2020 06:43:43 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 00/18] crypto: allwinner: add xRNG and hashes
Date:   Fri, 21 Aug 2020 13:43:17 +0000
Message-Id: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
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
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 411 ++++++++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 161 +++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 124 +++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 135 +++++-
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 205 +++++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 442 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 170 +++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  89 +++-
 13 files changed, 2220 insertions(+), 68 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c

-- 
2.26.2

