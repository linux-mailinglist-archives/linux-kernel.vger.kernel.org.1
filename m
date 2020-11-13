Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38A82B1BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgKMNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKMNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:11:28 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3CC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:11:28 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so10631687ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YlQeaH5/KcevoKEl51vDAlqU6fywoh7neaxZiZXvzYM=;
        b=Ba/CkSxyepWxIeclWEnqYQ1AbWeF8sMwCXhKtZQNwmRJa6tNC+IryeKrUAtPa4MToy
         QcA+BrdasMjnGNhEBrhsEMTogz0Xrr/dY3auqpFom1mwSt8dK54gcyt8o5+2KOCS4bs6
         xn4jz36FaH4OnAqBxcefaFKl/9Sgtim3s0QclHfoLceoihTsVbT6we6Sykqtocifd3X3
         zhAsRT/BNpWvynkpBthNzh0Q1jc5jOr8IBtY9b+XECe2zt1JmX9F5KcsHPI8HVoOB/gk
         KbKUcd9BieEcVzHknqzrQ91xaUSAqYb45YvOJdPfDIWLFRMEmS+QLd8SOF0vQQlO7t2P
         I0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YlQeaH5/KcevoKEl51vDAlqU6fywoh7neaxZiZXvzYM=;
        b=r88s6Trt11NEdke3SGkwD+VRIAxL6e1yn33aHBQoYP2eWAH+Dmif+0MxEwZA3uRPxV
         nbpHjOvaMLNLaIcHu8tbA7PKE3YRYseq/MU6Cn0iGLdeWKHtbkjy+BQ+ykJonb2A8gX1
         NaZDb78HDQzSxOkvjTPEghJJB0WFhNbUfnENP3v37y5yEmjjqyjqDWoRVPYiRa9ZP0KX
         5EVjoTqythbntL8DndzTSHk9gN6vB1sqoFi8zgxpdZaQeCi/YONYaKes5Q6eXYOHbc08
         eCozCDys1bhlw3wAFtnm5Vx01ZG1PuVTzROYcha13FLWiwstUX1RrZD6/VQiVhLn3AIQ
         ItlA==
X-Gm-Message-State: AOAM532MhcQ9D8tv3XST6UdvPkXjE4bzhAr26hjt3jBWp0IjAKLykTu/
        8ODAmA+oSlwnvNQnpVIgfrcuqi3IFDcV9mbBKH+0Ng==
X-Google-Smtp-Source: ABdhPJwpS3LA0Wy7sKqk8ysxk0a+ukPmDWlwckuHShWHBjsztS9qHAGQ4HLGGUuUw3YYY+xaxE4GjIDaOvJElLjK1bg=
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr986613lji.104.1605273086649;
 Fri, 13 Nov 2020 05:11:26 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Nov 2020 14:11:15 +0100
Message-ID: <CACRpkdZMomW2zVepq6y6P-EjHjN9xMJvVFm0n3WAsPKS3-QgYw@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.10 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some GPIO fixes I've collected with the help
of Bartosz.

Nothing special about them: all are driver and kbuild
fixes + some documentation fixes.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.10-2

for you to fetch changes up to b72de3ff19fdc4bbe4d4bb3f4483c7e46e00bac3:

  gpio: sifive: Fix SiFive gpio probe (2020-11-11 09:53:09 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.10 series:

- Tidy up a missed function call in the designware driver
  when converting to gpiolib irqchip.

- Fix some bitmasks in the Aspeed driver.

- Fix some kerneldoc warnings and minor bugs in the improved
  userspace API documentation.

- Revert the revert of the OMAP fix for lost edge wakeup
  interrupts: the fix needs to stay in.

- Fix a compile error when deselecting the character
  device.

- A bunch of IRQ fixes on the idio GPIO drivers.

- Fix an off-by-one error in the SiFive GPIO driver.

----------------------------------------------------------------
Arnaud de Turckheim (3):
      gpio: pcie-idio-24: Fix irq mask when masking
      gpio: pcie-idio-24: Fix IRQ Enable Register value
      gpio: pcie-idio-24: Enable PEX8311 interrupts

Billy Tsai (1):
      gpio: aspeed: fix ast2600 bank properties

Damien Le Moal (1):
      gpio: sifive: Fix SiFive gpio probe

Jia He (1):
      gpio: dwapb: Fix missing conversion to GPIO-lib-based IRQ-chip

Kent Gibson (6):
      gpio: uapi: fix kernel-doc warnings
      gpio: uapi: comment consistency
      gpio: uapi: kernel-doc formatting improvements
      gpio: uapi: remove whitespace
      gpio: uapi: clarify the meaning of 'empty' char arrays
      gpiolib: fix sysfs when cdev is not selected

Linus Walleij (1):
      Merge tag 'gpio-fixes-for-v5.10-rc3' of
git://git.kernel.org/.../brgl/linux into fixes

Tony Lindgren (1):
      Revert "Revert "gpio: omap: Fix lost edge wake-up interrupts""

 drivers/gpio/gpio-aspeed.c       |   1 +
 drivers/gpio/gpio-dwapb.c        |   4 +-
 drivers/gpio/gpio-omap.c         |  12 ++++-
 drivers/gpio/gpio-pcie-idio-24.c |  62 ++++++++++++++++++++---
 drivers/gpio/gpio-sifive.c       |   2 +-
 drivers/gpio/gpiolib-cdev.h      |  15 ------
 drivers/gpio/gpiolib.c           |  18 +++++--
 include/uapi/linux/gpio.h        | 106 ++++++++++++++++++++-------------------
 8 files changed, 140 insertions(+), 80 deletions(-)
