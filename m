Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E06281DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJBVpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:45:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0027C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:45:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so3629608lff.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4Iwk1spLlQzJLSFU0+CFB+SWnSpdaAD1kxSUV+hB2RM=;
        b=wNTaW4YGEvOnQENoYrnzXECxajAysR9g+ZMxkqyZuSbDPs6yOUOjkLltIwicvNWA6w
         njTjwQI3leBE+DvZXMypV+EUaJDFhsuAevjsUmETuZ6N7rIZ/2fCadB/EcD3usQkaoTS
         VLumJ5YBAx0VVnp7WAFsuAdZ9Bj+6vSzJjQ1AQpVQpJ4fESWKiquH+zHeAl92SBetJ7Y
         LD9tuXN8p9BoeBewM2O6UvT9gkdtVmi0EEtNvLZNGMloWSmsL+NAnpDyKg+1MdszVoSj
         VqGSy5SIaf2LEMrE7EfkC0FX+hk120azo+kMfNBSIUrBgG5hgLVG3eXHmg0O9pCx1ZA6
         QETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4Iwk1spLlQzJLSFU0+CFB+SWnSpdaAD1kxSUV+hB2RM=;
        b=Y/sWJOTXupMu9JAdDbMokai/sXIinq2VhHpEdIQgICoqAVKPLeXkrihH3kJyvWq4xC
         Nt3Ca8HFgluxeSeJCnh0IU9809kSdRVa+vMfUvmgbQQ+ZeGaLIV7SDMRUPLZVDbG9z5/
         8z6lAILrBezDiT/A5TOSAZyxNLfYfNPeftPlsiYTGauucbdyaGLJBzZ+P70715S/+Ek2
         YuwjkgU/FEQK+G/cAtiXNddSiOJmGzgQidjm2RjLcPF7kuCX51wAaWobFUUWiWfwUeNd
         R/YVkMbR1s4AZXskQG5p9ILab4sLVGjEYJtSk/BdMjHE9uRH5+0G/ghoFJtULSrCMCM+
         /ARw==
X-Gm-Message-State: AOAM531wOdvTaMTxNTVbXja/W5AVOEFEaCTVedPQnoU+el8If8hre9yb
        kH7dUZOXCcIxCv/Zn9HczRrflq28bhwvZ9ct+zH9Jxhx+2q6oJzm
X-Google-Smtp-Source: ABdhPJxzaTAPZTEN1haGk8yGz4U6RsvZystmZRR5iIBi2e33+5ztO8f4uWENKmn9dvanWcJplCEeLgx/PobNv/n/jxU=
X-Received: by 2002:ac2:4c11:: with SMTP id t17mr1660588lfq.260.1601675150213;
 Fri, 02 Oct 2020 14:45:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Oct 2020 23:45:39 +0200
Message-ID: <CACRpkdZ=EC589q1WpdkzCcswfLRUcVe25Uuht-vqywEn16R7Tg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some pin control fixes here, some four of them since -rc2.

All of them are driver fixes, the Intel Cherryview being the
most interesting one.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.9-2

for you to fetch changes up to 39c4dbe4cc363accd676162c24b264f44c581490:

  pinctrl: mediatek: check mtk_is_virt_gpio input parameter
(2020-10-01 09:51:36 +0200)

----------------------------------------------------------------
Pin control fixes for the v5.9 kernel:

- Fix a mux problem for I2C in the MVEBU driver.

- Fix a really hairy inversion problem in the Intel Cherryview
  driver.

- Fix the register for the sdc2_clk in the Qualcomm SM8250
  driver.

- Check the virtual GPIO boot failur in the Mediatek driver.

----------------------------------------------------------------
Chris Packham (1):
      pinctrl: mvebu: Fix i2c sda definition for 98DX3236

Dmitry Baryshkov (1):
      pinctrl: qcom: sm8250: correct sdc2_clk

Hanks Chen (1):
      pinctrl: mediatek: check mtk_is_virt_gpio input parameter

Hans de Goede (1):
      pinctrl: cherryview: Preserve CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs

 drivers/pinctrl/intel/pinctrl-cherryview.c       | 14 +++++++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  4 ++++
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c        |  2 +-
 drivers/pinctrl/qcom/pinctrl-sm8250.c            |  2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)
