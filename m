Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ECC271711
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgITSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgITShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:37:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE1C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:37:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so10510247wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=j8r9eEl8b7+QpEqzy5gmnEbcHSyuwwOv6avMlgJ9/Pc=;
        b=UueFFA/89e6NVRES7AU3cSYTUDSZZ+3RpMQPDgj9UUtObN6e+V2mRI3SUm9XGPfhyO
         +PnfC7qHBd4YtETur0QBRQXabuLaqWO3yZ+rEHTjdoTZSWTTsBR2h/3xAaP9lSkeNzvo
         yswIdwoRVVmsvWYppFNeoW9icBxA0oYx+dkznNpG6B0/gKF4/VLPym1XIDqEVv/t517G
         wIq3323NNV/Qv3qWiuLa3/4XnruhOAVK1JNbTNXI//fnP0Y/mkmSsnWE2io+5Jiclgxl
         yi/IOLU4hz4yfJjq2+UKYaoOwqQ0KSNTgoxlbAksOSWY/1E8YXGlqVQSd+rgeUCt0xOJ
         FTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j8r9eEl8b7+QpEqzy5gmnEbcHSyuwwOv6avMlgJ9/Pc=;
        b=WEagB7sW4fLXvu+Oc8pEAYPxpvMtomJ8/hYJvBEYAoAaofh8xzVqJ//S/HJ0DtEwar
         PwjAwl7TeLveuDMg9LWo/0hJOHDeHhKhLvJX/UEUWlqw/C8h4nzi7HWvNdkC67p+Fyq8
         Ap3B0dZyGTDTkTR75Aj9ijRHO/ZmF+NYPgVxbBe9M5iON6wcw6tnbDI6OdDdCQgRBwRM
         tzkAGv7uPOP3atiDRHVItbDPW4E7G89MLOi1Zi4LtFFhRo9iQMyvOYEheE3qvFeSCPhJ
         4jbvlBYGwbg6gNIO6DPzd8HdIHsmkAkVL3+KkRXwRI6knNQNb1NmOWCSZiy3Un/vfuXt
         MxFg==
X-Gm-Message-State: AOAM531golYt1hzP/0RFgMoxWJBzuaVZRerOcjI71Qmjq/n3uIhpNBvN
        gt9G+pjXwi4PZ2Ye8MVR381CMA==
X-Google-Smtp-Source: ABdhPJwOnrMjEvc/9cxVRZ9axQzvCMFOdtPwe7N+OxLcHz643vix8ovK7cKjIC9bvXuk16+sFhKXjw==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr50135924wrv.185.1600627044136;
        Sun, 20 Sep 2020 11:37:24 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e18sm16419841wrx.50.2020.09.20.11.37.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Sep 2020 11:37:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/7] crypto: sun4i-ss: prevent always fallback for ciphers
Date:   Sun, 20 Sep 2020 18:37:11 +0000
Message-Id: <1600627038-40000-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
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

Changes since v1:
- patch #4 is sufficient to fix BE problem (removed todo)

Corentin Labbe (7):
  crypto: sun4i-ss: linearize buffers content must be kept
  crypto: sun4i-ss: checking sg length is not sufficient
  crypto: sun4i-ss: IV register does not work on A10 and A13
  crypto: sun4i-ss: handle BigEndian for cipher
  crypto: sun4i-ss: initialize need_fallback
  crypto: sun4i-ss: enabled stats via debugfs
  crypto: sun4i-ss: add SPDX header and remove blank lines

 drivers/crypto/allwinner/Kconfig              |  9 ++
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 82 ++++++++++++++-----
 .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 54 ++++++++++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-hash.c |  8 ++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-prng.c |  6 ++
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  | 11 +++
 6 files changed, 148 insertions(+), 22 deletions(-)

-- 
2.26.2

