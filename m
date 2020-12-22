Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC172DA106
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502960AbgLNUEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502916AbgLNUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:03:30 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9DC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:02:50 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b5so5844541pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QT8NIpdXPvB5AxHdzPljCniOubRI5wdzJKZjH5NenqY=;
        b=DujLLjbNY2EqBfSfkapUKZhtAMbzp6keOCUoGrS6UzdoyiRrmkjKWP6Ufrc4ru/3K2
         axkWExX+zhOPGOUPZIXVJk/zH6AwlYuYYbyF/y+U1WXH4rCPIgfcBOUyrOgH6DOHKVRD
         aB83q/S1BUogVWX5nRzlndQxQ4f2F/9dySQGMpsfe2t9nb9hpsx9C2hfiM+Dl29uc+IV
         Hh/WhUTDAILLkg7PFCmkWyMdi8UU2MQ+N4lPYDze0VMhgsww8DWG4PjN3d4hI9ckMJ4Y
         bdbxgjiIyqtTSuBkqj1PxtCjofRXWjzP5lmgyQ1ghOumixPFbxYc9MhWVqyP5mdLcUWZ
         +h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QT8NIpdXPvB5AxHdzPljCniOubRI5wdzJKZjH5NenqY=;
        b=Iwz+xpQTTaMKJWLlS+0Xuq1uz62LaG5qI6tp7kMBWrAqyh4jCrnuzUd9EKZWeszguE
         MZKTUxqi2loyFnc0Zap2CAOE4Ww5JRxe49dJNVk6l5RitY4EN46G4qnTMAx4lfqDRMYS
         Gwesq6ChdXFy9zt0Ydt0/7Mmf1JKsI+IBTUb8g9tKCoSFzikPdONidXWMqDt08HDikGu
         MYjVVdmulmPk66Lb3SMk4DbLJIpmZ2qO9QVEzIAKSYqXAn9HyWu0r47TvtF/z6H40FS/
         PaJGT0iUYBq1t4vqaRDRGHOPov4HffyOermBafJ+dg2gQU0MOw+qX2rD15IY3ey/1RHA
         kzMg==
X-Gm-Message-State: AOAM533umLcbPn5zCWLlw0OGh8EywcVhLvBO4fFW/OB8S4IL2dJXvbqZ
        dixQS30BgOMZg2ZCEa6ES8A+2NOvrjFt1Q==
X-Google-Smtp-Source: ABdhPJwkjyrENefrYh5pxJoB8S3p7TTI+eXMZ6+uwRGFC7DK+3jkBzZ+qU5Jx7hVyfjt+T6PNIbfkA==
X-Received: by 2002:a17:90a:7e95:: with SMTP id j21mr26783571pjl.217.1607976169812;
        Mon, 14 Dec 2020 12:02:49 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id js9sm22434109pjb.2.2020.12.14.12.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:02:49 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 0/8] crypto: sun4i-ss: prevent always fallback for ciphers
Date:   Mon, 14 Dec 2020 20:02:24 +0000
Message-Id: <20201214200232.17357-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

For help testing on "crypto: sun4i-ss - Fix sparse endianness markers",
I have added "stats" support like other allwinner's crypto drivers.
Seeing stats showed a clear problem, the ciphers function were not used
at all.
This is due to the not-inialized need_fallback which is "init" as true
everytime.
So basicly, since the patch introduced it, this probem hidden some bugs.

This serie fixes all hidden problems, then fix the initialization of
"need_fallback" and then add the stats like other allwinner drivers.

Regards

changes since v3:
- patch #2: Rewrite test as suggested by David Laight
- patch #7: removed all ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
- added kmap patch

Changes since v2:
- patch #1: move buf/bufo out of function for reducing stack usage
- patch #4: use writesl()
- patch #6: use IS_ENABLED instead of #ifdef

Changes since v1:
- patch #4 is sufficient to fix BE problem (removed todo)

Corentin Labbe (8):
  crypto: sun4i-ss: linearize buffers content must be kept
  crypto: sun4i-ss: checking sg length is not sufficient
  crypto: sun4i-ss: IV register does not work on A10 and A13
  crypto: sun4i-ss: handle BigEndian for cipher
  crypto: sun4i-ss: initialize need_fallback
  crypto: sun4i-ss: fix kmap usage
  crypto: sun4i-ss: enabled stats via debugfs
  crypto: sun4i-ss: add SPDX header and remove blank lines

 drivers/crypto/allwinner/Kconfig              |   9 +
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 196 +++++++++++-------
 .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c |  52 +++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-hash.c |   6 +
 .../crypto/allwinner/sun4i-ss/sun4i-ss-prng.c |   6 +
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |   8 +
 6 files changed, 207 insertions(+), 70 deletions(-)

-- 
2.26.2

