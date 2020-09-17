Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06C26E3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgIQSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgIQSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:36:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02388C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so2900782wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=80WQwBM9RNFOS8VBDzJIrM518QYIY+w3sh3jO4LWS+I=;
        b=JriYO/BKOtG/wSNu/J1GWXpv1DmYEETwaU6Q7mH+B7UsbP9CxCKI0HS2JAeZoFIWRu
         7RrWElcuTKneup0MksLrE5k/ofNmMNJvNrM5ZwriM9VN6c75qzwpeAimnruRNguM+10M
         5KjDRPcIblpjnb/SA/RSEDTvqQTuT9OCFRzBn1KVLUJmOpEtSlJwdW4uTKd9LLVmf8DU
         7gc1TYTeI8pH7ifnjFdJVyxdxpXkqcMWJXc9KLdhiQstc9ZcU8+s4Cy+eGo9oX2IrLeG
         28zYUkeFwoQ8oA3iU4XlIyhJBdF2RKxJKNrCfTXYsn7NILoiFSthi6x7yxL5D/trldqk
         0hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80WQwBM9RNFOS8VBDzJIrM518QYIY+w3sh3jO4LWS+I=;
        b=sZ2mVBrSkjnmIXPHeWTBWnCDWcjvQqrl1ifuix2gDmRZj/Sij/khMXDWs6a0+oW3MU
         06r70/GMddXm1h7u8+1CKpF4s/yBhYcLXhxUxuCtlKh1alOySQGJPiNB82OUI6D5HuTS
         XQNrwMlSy3eVY3hMWl/kdzZGo0X9Kn9Dc4+pgjhlauvCrwiylJ2kTUOqoVeSFsgfJfBd
         30YeaSKdYlHiAeAc7p0h95LlhsmUkXiuz09lQI/lI7E2N1pRimZdeuK9iG6AYbZ5cT5+
         uRXloV6r5XOsp9ElUi+hRBv62Py/Qp1aDYsSWYERSi2LAKRNQw87zSkITNZRuYfIMwnz
         EOFw==
X-Gm-Message-State: AOAM531d3q7UijF1z7uT8Y2k0HraYrO3sA9AqbnFF8NHMgfctajS05B5
        uF0+XqItfK9mX2C3LeXe8XomDQ==
X-Google-Smtp-Source: ABdhPJzxrotugbf7NPHeEx+arqAgMueZlejapNGIXOt6cJFceK/hx7FR+qLmXzyNx1WE+NPWv0xONg==
X-Received: by 2002:a1c:7716:: with SMTP id t22mr10914640wmi.64.1600367767618;
        Thu, 17 Sep 2020 11:36:07 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x16sm571901wrq.62.2020.09.17.11.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:36:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/7] crypto: sun4i-ss: prevent always fallback for ciphers
Date:   Thu, 17 Sep 2020 18:35:51 +0000
Message-Id: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
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

Corentin Labbe (7):
  crypto: sun4i-ss: linearize buffers content must be kept
  crypto: sun4i-ss: checking sg length is not sufficient
  crypto: sun4i-ss: IV register does not work on A10 and A13
  crypto: sun4i-ss: handle BigEndian for cipher
  crypto: sun4i-ss: initialize need_fallback
  crypto: sun4i-ss: enabled stats via debugfs
  crypto: sun4i-ss: add SPDX header and remove blank lines

 drivers/crypto/allwinner/Kconfig              |  9 ++
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 87 ++++++++++++++-----
 .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 54 ++++++++++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-hash.c |  8 ++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-prng.c |  6 ++
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  | 11 +++
 6 files changed, 153 insertions(+), 22 deletions(-)

-- 
2.26.2

