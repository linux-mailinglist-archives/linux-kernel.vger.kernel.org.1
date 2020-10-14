Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3428E40F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgJNQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgJNQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:10:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FBC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:10:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so4576160wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=agCsJvwMoNGydR7AUgDVMIj4Rm0ViwQoV1No1skaAaI=;
        b=Yd55lDt+0pOU6QmSqpttdErmYepevN9AzERVNpeFDcErd4QSrKiVP89qC5D5ypLyVz
         WIX5l/xc31aWcSl1x0oBi7eSsSas3eJqU0/aL9uF5eoPvrqqXNqmB7DitSVjtRZCZaIn
         C0vrs9HJsx2k0J1zkKV4M1NfE1dW0i4zNXA2/RUo4gd5hULG3DfS/bYgMFO/Ww8YFzqL
         cSDdd+Ls54d8xzr8Gwc6Xr/J2nJi9O3rPyCt0/ALFnfmPoJasnGwryftJ/Wv1QGj4bCd
         qNgbjTLCAvC8ToulNvB9toHY/o6AyDUKwxyvzEyOgSPMrioELupfdN/8TfewWk3xizm6
         v3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=agCsJvwMoNGydR7AUgDVMIj4Rm0ViwQoV1No1skaAaI=;
        b=T6k+Ab/tM4Nw8C8CgSBxBP7sXfk6WENkBmCsqD0vavnRgnW2Abx29f3jimNsmhjm8r
         4uR9n50LCdx+9RhO1hucOsQ9+ia0AM7/NiTJ/g98cPwHcvqJh0RAlcrePdvd+/k5qsr2
         zro5hJe1kJbeQssDHwTk4VLOeBZnt158J/LE9H5V5v8M+A/cSYT8AcQ+tMKamjozcs5I
         lYuHJ1fHp68PUhEbWtDK1xlC8q5rIsHSok/W6CQRyjR32mT3ZddrLq9zGiESsM/C/jhr
         +Rtle5tivfVzFt0nP7OesUA5nHjvA6loz/aQnrBG6XakZa7F1kMFs23O7xk8t2sV0XxQ
         VR7A==
X-Gm-Message-State: AOAM531+e1WusqVGivwIrfW+fysPrFZKVJdBi6KDxm1fW8H1OoEqlEzW
        uF+wz0iFCnsSqXmQm8lRfeT9EyawuX3TQ01j
X-Google-Smtp-Source: ABdhPJyIOYFWqRfDKv0OOMdW9oXRExfFowcUSOg/jUx19+DA8iRUyJYQz28II5p4sdA3ENsVy5RN9A==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr6636861wru.148.1602691844298;
        Wed, 14 Oct 2020 09:10:44 -0700 (PDT)
Received: from dell ([91.110.221.166])
        by smtp.gmail.com with ESMTPSA id v189sm177146wmg.14.2020.10.14.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:10:43 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:10:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.10
Message-ID: <20201014161040.GB4545@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.10

for you to fetch changes up to 97ecfda1a8ffc5ffc9681d0dfa65fd5b39839dfe:

  backlight: tosa_bl: Include the right header (2020-09-08 12:31:19 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for KTD253

 - Fix-ups
   - Add Device Tree documentation; common, kinetic,ktd253
   - Use correct header(s); tosa_lcd, tosa_bl

 - Bug Fixes
   - Fix refcount imbalance; sky81452-backlight

----------------------------------------------------------------
Linus Walleij (5):
      dt-bindings: backlight: Add some common backlight properties
      dt-bindings: backlight: Add Kinetic KTD253 bindings
      backlight: Add Kinetic KTD253 backlight driver
      backlight: tosa_lcd: Include the right header
      backlight: tosa_bl: Include the right header

dinghao.liu@zju.edu.cn (1):
      backlight: sky81452-backlight: Fix refcount imbalance on error

 .../devicetree/bindings/leds/backlight/common.yaml |  34 ++++
 .../bindings/leds/backlight/kinetic,ktd253.yaml    |  46 +++++
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd253-backlight.c         | 198 +++++++++++++++++++++
 drivers/video/backlight/sky81452-backlight.c       |   1 +
 drivers/video/backlight/tosa_bl.c                  |   2 +-
 drivers/video/backlight/tosa_lcd.c                 |   2 +-
 9 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/common.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 create mode 100644 drivers/video/backlight/ktd253-backlight.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
