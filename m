Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454952FE6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbhAUJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbhAUJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:54:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:53:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m4so1071238wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eci1FQfpoEAtnK1o4pF6wH1+jl8xOMIXcTakllSDiEQ=;
        b=smG4LuuwEoPMqICbcrS8fi0j07dt5hcTLTip5ddqlcoA02+u6s78O29wC4I4ejSxvE
         jijkD6tjS0lw7G7sI67GjR6oJmdnkXDqlCFSt8V/Rnr+0ZKa3nLQ+wzRmILbu/eA/Z6o
         M55jTtvDstnN/ZVUpuAkcDbU1R5rOs5Q0SUisYQh7k5RF4wWfVj0t1pRmPHeDNOQuzVA
         nBH6EdJgcqUiM7+Qk+OJblUE+eETxCTmKpq48TIdwSPeLlNMWxFrIOygZOtZkkxn1vwh
         liOjbdMK7taXxaHniwBuZCoo/UqtKA4lNDqiz74cXyg4IY1vLaU++VApRjA3bNzJV23X
         frmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eci1FQfpoEAtnK1o4pF6wH1+jl8xOMIXcTakllSDiEQ=;
        b=SykgNeGdzN8D+/xUWr1Bl2i0W5vIb7SxZwRr+7Igwx3zR8p6hfGH7+6MEaQTwNBsjk
         eZ8gY+RAr+Be9mfh9veHPCHfl12x08QyDB+HgJCQ+4CCpVOtDVhBpBRcvPyuA585o3Wu
         Tm/JllNuhcVWObGNBJuHA78OcCIxdBXCvseGCIG4IB+d51ZM681aQSin2GpYsP+PD3tY
         fZthWbd86KnYtrddJoUnc5j+AkQ6lF89dwhNAh+BfgLvocUefONjohU4AQ9S4+R50Uk0
         9t0Qy7ePDMUSbLq+k16KoOr5qrRmjlLc78AUIJ+CKf80juS04ZWGcTcV2WF2UZpWPtIM
         ItNQ==
X-Gm-Message-State: AOAM532HXKveSd2X1eI27J1g5BnE50nzvc5V2KXOnfguywGfPNF4ky/+
        YMSFNY5Cw59mpa8kdrz7pgFufg==
X-Google-Smtp-Source: ABdhPJz+R/JFXZpAgY/1GjXdfbXgiysWELihaAFCING/1dQeVKSw2wAxEo+AcVvBhRMX85LDh/s1ow==
X-Received: by 2002:adf:e512:: with SMTP id j18mr13286432wrm.52.1611222819046;
        Thu, 21 Jan 2021 01:53:39 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u5sm8369816wmg.9.2021.01.21.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:53:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.11-rc5
Date:   Thu, 21 Jan 2021 10:52:46 +0100
Message-Id: <20210121095246.11061-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is my first pull-request sent directly to you. It contains a couple GPIO
fixes for this release cycle - nothing too urgent. Details are in the signed
tag.

Please pull,
Bartosz Golaszewski

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.11-rc5

for you to fetch changes up to 298d75c9b18875d2d582dcd5145a45cac8d2bae2:

  gpio: tegra: Add missing dependencies (2021-01-19 13:37:10 +0100)

----------------------------------------------------------------
gpio fixes for v5.11-rc5

- rework the character device code to avoid a frame size warning
- fix printk format issues in gpio-tools
- warn on redefinition of the to_irq callback in core gpiolib code
- fix PWM period calculation in gpio-mvebu
- make gpio-sifive Kconfig entry consistent with other drivers
- fix a build issue in gpio-tegra

----------------------------------------------------------------
Baruch Siach (1):
      gpio: mvebu: fix pwm .get_state period calculation

Kent Gibson (3):
      gpiolib: cdev: fix frame size warning in gpio_ioctl()
      tools: gpio: fix %llu warning in gpio-event-mon.c
      tools: gpio: fix %llu warning in gpio-watch.c

Nikita Shubin (1):
      gpiolib: add a warning on gpiochip->to_irq defined

Randy Dunlap (1):
      gpio: sifive: select IRQ_DOMAIN_HIERARCHY rather than depend on it

Thierry Reding (1):
      gpio: tegra: Add missing dependencies

 drivers/gpio/Kconfig        |   5 +-
 drivers/gpio/gpio-mvebu.c   |  19 +++---
 drivers/gpio/gpiolib-cdev.c | 145 ++++++++++++++++++++++----------------------
 drivers/gpio/gpiolib.c      |   3 +
 tools/gpio/gpio-event-mon.c |   4 +-
 tools/gpio/gpio-watch.c     |   5 +-
 6 files changed, 93 insertions(+), 88 deletions(-)
