Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051312B1BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKMNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgKMNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:22:56 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AADC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:22:55 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so13739949lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3DLbt5bV6U63zLtfHDXFZOW3hWZEC1wwHFcy2bqaxN8=;
        b=rXNQRg47wp+JjPJnDjipB+Hg420EikP1ABzdSD2VBl8I85C6VoJU8Gr6xrCNWP++l9
         188Gh5zQ4kFn/hSMJLjGtMMxZFznsHyaD2pPkbFeFoMBYmz6Be2Xhv7LmRFyXeIv0sll
         YUSvGhkMp6d4HeNW8zzIMlRcnLtNUcMyv9cMyPPLv1mrPQZGlEttECW2LNd0nsxuygMz
         GZ6ZodRh177D3CIXY+dOmoQoGtpbhYcJorwJjWW7TVV5ZazhirqN9iDQ5nfoTwIS0vX0
         bHnAAf/EpU/yi2A16hY36C6BF+aj2tA4yeCW8/oR2SW8pnmNJPcHYIdah6nByJT+4w6R
         FlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3DLbt5bV6U63zLtfHDXFZOW3hWZEC1wwHFcy2bqaxN8=;
        b=Uvh1ed1W13gdGUK1iYNuV1l0tpRqktuno72sAiTMWghs4BqnXEVAXIVJ+1+JFTd9rH
         8QgjFwSx5rLUXxPeiMzwyDj7SIyZzZCM4Sc0x2dd6e0AZi31waILSLkKXbu3f4c1nVgN
         asfkjsQElRFh9M+aefnK+4kUe3IfYjurBGPc5dJf1ZrvoaFQnEOHuQHFmcSOf7CEwFDJ
         Blpk8gg9t5EU/2aUfAnFsCj4YQZUwCsRUeWjW173F/24Ir5uLKqcK68CZZtt9AWiFU+P
         CH7jIZdHPWLL6utu9c0FCc/H12v9PeS1G5cpqZfwqJFJKM21jgEUzOhu5Fb7l0WFKKKW
         0GpA==
X-Gm-Message-State: AOAM5318xgvKd51groIRNW8fTtOVMnIGwSRaf/KrILf5gpBCdhPHr4gy
        69m/alUYj0WoiDmqjxEPN4nZvd8yhmCb0S7566UE2g==
X-Google-Smtp-Source: ABdhPJwsFVlMFtci48Zk37WHFRxMO4kKt+n6BkZVRDHuhKJOjSN/GxjuMKZBPsAoqU8KoMNZ1NjyftkBrPa6EW38ZgE=
X-Received: by 2002:a19:e08:: with SMTP id 8mr827046lfo.441.1605273774375;
 Fri, 13 Nov 2020 05:22:54 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Nov 2020 14:22:43 +0100
Message-ID: <CACRpkdYta9FG-aYN1KbpFrsvO_ZGNTX=CJqiL8uL3e7QQQR4Gg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for the v5.10 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coiby Xu <coiby.xu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a bunch of pin control fixes for the v5.10 kernel
series.

Nothing in particular to say about it, because they are all
driver fixes.

I'm happy that some AMD driver fixes are appearing, it's
been an undermaintained driver, and laptops have suffered.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.10-2

for you to fetch changes up to dadfab0fbf0173da6e24c8322b69083fef03033d:

  Merge tag 'intel-pinctrl-v5.10-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes
(2020-11-10 15:35:41 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.10 series:

- Two fixes to the Intel pin controller drivers: fixing
  pull resistance bias.

- Fix some invalid SSI pins on the Ingenic pin controller.

- Make sure the clock is enabled when requesting interrupts
  from the Rockchip GPIO controller.

- Make sure IRQs are mapped when looking up the IRQ for
  a GPIO line on the Rockchip GPIO Write.

- Two regmap initialization fixes for the MCP23s08.

- Fix a GPI-only prefix function problem on the Aspeed pin
  controller.

- Disable the debounce filter correctly on the AMD
  pin controller.

- Correct the timer clock setting for the AMD debounce
  timer.

- Make the Qualcomm pin controller more cautious around the
  handling of PDC-related GPIO interrupts.

- Fix the interrupt map in the Qualcomm SM8250 pin controller.

----------------------------------------------------------------
Andy Shevchenko (4):
      pinctrl: intel: Fix 2 kOhm bias which is 833 Ohm
      pinctrl: intel: Set default bias in case no particular value given
      pinctrl: mcp23s08: Use full chunk of memory for regmap configuration
      pinctrl: mcp23s08: Print error message when regmap init fails

Billy Tsai (1):
      pinctrl: aspeed: Fix GPI only function problem.

Bjorn Andersson (1):
      pinctrl: qcom: sm8250: Specify PDC map

Coiby Xu (2):
      pinctrl: amd: fix incorrect way to disable debounce filter
      pinctrl: amd: use higher precision for 512 RtcClk

Jianqun Xu (2):
      pinctrl: rockchip: enable gpio pclk for rockchip_gpio_to_irq
      pinctrl: rockchip: create irq mapping in gpio_to_irq

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.10-2' of
git://git.kernel.org/.../pinctrl/intel into fixes

Maulik Shah (1):
      pinctrl: qcom: Move clearing pending IRQ to
.irq_request_resources callback

Paul Cercueil (1):
      pinctrl: ingenic: Fix invalid SSI pins

 drivers/pinctrl/aspeed/pinctrl-aspeed.c |  7 ++--
 drivers/pinctrl/intel/pinctrl-intel.c   | 40 +++++++++++++-----
 drivers/pinctrl/pinctrl-amd.c           |  6 +--
 drivers/pinctrl/pinctrl-ingenic.c       | 72 ++++++++++++++++-----------------
 drivers/pinctrl/pinctrl-mcp23s08_spi.c  |  4 +-
 drivers/pinctrl/pinctrl-rockchip.c      | 30 +++++++-------
 drivers/pinctrl/qcom/pinctrl-msm.c      | 32 +++++++++------
 drivers/pinctrl/qcom/pinctrl-sm8250.c   | 18 +++++++++
 8 files changed, 127 insertions(+), 82 deletions(-)
