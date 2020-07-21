Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D82288B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgGUTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGUTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F062C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c80so3880539wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dYhUQ9vHkWsbrmbKEgTQGFbtygPIs+HK3zAzny3z75o=;
        b=gdgxfoFoZP7vr2M08P0otd22fU6FC9cvK4ClYvb4oM69Pl0jrf52sHTnKRHNXtXYzi
         oKMPdOAuQUsdUSnbOUt5XBgIvP22xoNsu/Y+TNcKX0IqflZr1qwboMYMzU90TRPDtuu4
         yB49rACZgg0SJrDUBtKO16keUOxXAL84J/Ygnfxt4t1QF/SB7XUpO4a7UNLADSOGq8Fo
         wGAROFSAjT5wW2vGLNS63+YXG5jJlxcWcVQjVNb71YHVa128BGLGOl2jVFsASvwNfdSm
         gW80Ul8cxlxvObO0QjyUwaMxmGl49MxARvSaamiPJwDuBZV23SCO60LJaB47EoalMbtr
         V/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dYhUQ9vHkWsbrmbKEgTQGFbtygPIs+HK3zAzny3z75o=;
        b=JqGvYjKJcWB/OjLS8av2Cg7o9HIbyiEumlX612Oo8+Y0k+Y7TpfV/2dwadgMYvcMCl
         LWCfBmadnKdlk/te4MtzbXXaIOCxbgOl3kXSJb3eKjnwswnCKQt60pWDRh8/YKwIKUYP
         VCCimTHi/L0rNlZBZ8RsmRo5oT6pBW0wjXVChijdNJw1GhDVsSAIZpyrFJdAyoW+Co1y
         F2/cvDrlgX6m6QFY62F6e3pgbJWNx4H+8cYltvhwLQxhNhhFjkatR9M64scHo4Y6iz+0
         lIJY6Wf+TEw1UYkRevdX1WiirijNbfCIjq/wc3EhDnTDDi0dFP1Sf2voJIqpP9hodqdx
         E6Xg==
X-Gm-Message-State: AOAM530csUqPF+B73MbzbTNjWRFRxTaSJtxTtE7IjOELl/nSGmgERXhb
        KCt7eqGP9TZOz/mSSz65I+2wlQ==
X-Google-Smtp-Source: ABdhPJwxhpouUNzzV8sNh45ZyyHcHwFGG1JGKLKsdlHScEHY3fjv54pYiUsfXydXJ22EOPDqnGVnbA==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr5185258wmb.158.1595358402083;
        Tue, 21 Jul 2020 12:06:42 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 00/17] crypto: allwinner: add xRNG and hashes
Date:   Tue, 21 Jul 2020 19:06:14 +0000
Message-Id: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
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
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      |  99 +++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 381 ++++++++++++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 411 ++++++++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 161 +++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 124 +++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 135 +++++-
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 205 +++++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 442 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 170 +++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  89 +++-
 13 files changed, 2216 insertions(+), 49 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c

-- 
2.26.2

