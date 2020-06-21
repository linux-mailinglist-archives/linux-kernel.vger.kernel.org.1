Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B905202C36
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgFUTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 15:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgFUTbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:31:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE12C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so14561954wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SSp6eYkhH7nIe6GZ0CH+PAT8S+lUDrmSmlrZ00QGZhI=;
        b=CrkoAMpQZyTvDrBQreA4J8deSuYc2MRoU8l2mRFV6Zo+/kEbB8QPiHQFPYmA0oxlvW
         3dWXgzAivYUsGmLt4dCrCO/MSusoWA7jnV3AYqbLidpf+0A7n1iQ7nRX9O+oMY02hALM
         GnXrA29QQ8uqqfv32+o/uvT7x08p9q7Wlinjd/EM+68i708sfgQWjffKxmz12qNcTze3
         DFUooSZgrcQcID0qZ2De+yuBdjVvnRyWjXnDOUxSm3/Q8zMYLJVi/nsJf1o4J7RcxFdP
         OpOXr/62cGP3D8EvS71ImvscSaMUNkdGAQhYfzA0rox4MZkqqFr2x+ciIBSml2UYERCI
         Ku7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SSp6eYkhH7nIe6GZ0CH+PAT8S+lUDrmSmlrZ00QGZhI=;
        b=fztDSpZjmNTx+zYMjwi1uhMul5ISwWzPcdoB8FqU7Iop0Nzkh6eHlRQrS3GH3L6hS1
         lbGJGuzsGree1TEXjlit2kt1p8I9xomAn9F/JN/t5WaUO6SAumnyur5LY8xNx68/f//3
         6KXEtXWbeime95mrxUkZ/IpnqOoZ+KW4eUI82jWYZRm66Xvg2Em4KOBpC4LxYJUW5zb9
         ixoiW/7xAaMsIVGQaoJtvQ4CQtn1THn0eAtsfGZ4aIx/cCzusaL5jxRVRi7hHOWeI+uI
         Z1jm6l2EmkbZsUyLsa61CxqpG1VpKuged2rRp1as6gphzaa1eXm2gVFtV075QHUw4l+I
         8udg==
X-Gm-Message-State: AOAM530i5Zjg2jXzpEseIXgMXLTygMQQyPdDNubvVrZmogWBCrw92Axu
        C7VGRUIBk9wwOek5xYBhcmjYHG1Q5Bw=
X-Google-Smtp-Source: ABdhPJySKt8KwHn2tuueN63yW6ek6RNTeV41xqUJUIoshj4GCl+EmBd9UWCACnRDUh05ZMK2W005XA==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr15249567wrs.100.1592767873502;
        Sun, 21 Jun 2020 12:31:13 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e3sm16086924wrj.17.2020.06.21.12.31.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:31:12 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 00/14] crypto: allwinner: add xRNG and hashes
Date:   Sun, 21 Jun 2020 19:30:53 +0000
Message-Id: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The main goal of this serie is to add support for TRNG, PRNG and hashes
to the sun8i-ss/sun8i-ce.
The whole serie is tested with CRYPTO_EXTRA_TESTS enabled and loading
tcrypt.
The PRNG and TRNG are tested with rngtest.

Regards

Change since v1:
- removed _crypto_rng_cast patch

Change since v2:
- cleaned unused variables from sun8i-ce-prng
- added some missing memzero_explicit

Corentin Labbe (14):
  crypto: sun8i-ss: Add SS_START define
  crypto: sun8i-ss: Add support for the PRNG
  crypto: sun8i-ss: support hash algorithms
  crypto: sun8i-ss: fix a trivial typo
  crypto: sun8i-ss: Add more comment on some structures
  crypto: sun8i-ss: better debug printing
  crypto: sun8i-ce: move iv data to request context
  crypto: sun8i-ce: split into prepare/run/unprepare
  crypto: sun8i-ce: handle different error registers
  crypto: sun8i-ce: rename has_t_dlen_in_bytes to cipher_t_dlen_in_bytes
  crypto: sun8i-ce: support hash algorithms
  crypto: sun8i-ce: Add stat_bytes debugfs
  crypto: sun8i-ce: Add support for the PRNG
  crypto: sun8i-ce: Add support for the TRNG

 drivers/crypto/allwinner/Kconfig              |  43 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   3 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      |  99 +++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 369 ++++++++++++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 415 ++++++++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 161 +++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 124 +++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 135 +++++-
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 198 +++++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 446 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 170 +++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  93 +++-
 13 files changed, 2216 insertions(+), 42 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c

-- 
2.26.2

