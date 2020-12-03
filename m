Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31102CDEC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgLCTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgLCTYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:24:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0DC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:23:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s8so3027509wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IMGHiljhJdWK0ICC3j0XLkn1KRnwi613NvPHnzcXxdw=;
        b=wWgdhuMPniP/dSdSE6ty60TiXDxjvEbxseBEx5ORcfQnt5ewPTlaccscMnit79EtUa
         /2VoZz0yYtttg5Kce+usWp1I0t28qLPwATKew5SkuFRhub5LvbscFsJZGJRvCcw3E3a2
         xrVR28XY4BE0ppe3/DYAd4Rf+GOyxghEE1858TaGT8JPo4t1n7B5lC+qBfthJmYbHdup
         IlHTivu0jxIZeqx2+tHVG4oCOJcpqIR+i4pd1H85RzKensDrTuOT52tyAb4c1Nzrwf7Y
         lI9CnS7xJ2WLMc6NbQ4e5tyiYxF4EgIBH7SXEBR6+9OkEknnDRkyqvGu//MzYJHuaw0j
         uQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IMGHiljhJdWK0ICC3j0XLkn1KRnwi613NvPHnzcXxdw=;
        b=caYEVBWIvaGB1JLZTDJgBEIrr2RnuGIxzk0nXToF+uibodoiL0f+qSNmfuB2GoKCpp
         iXRMKT775rDxdqb3W/64x18kGltOG3MwDaQ582+TZm42wrUMZzpGh5BSh65IAFHzOhHA
         eS1U5j81RRYA85w90SbqmbaTPvMb4WDLBZbb+Hz/pWrQZIA09qbI0dYAgeavIMbKEbPM
         nAguYog1mv45Kxstycgmm0oCANCwWkKMRlFI9LYhNvqmAOQnvne1QU1b4ChyKFGbPa7l
         F+oqmHlyb/OZLwT318ZKjOgt1cVzTTGMMANMwO2Wv24ShTXIM3n27ppL7Wn9T5CL8Boc
         goGA==
X-Gm-Message-State: AOAM533hstkyTcUKDy3O8A/Smi/0SeGJj/KjTNWA204eCLo0RSOVMNO5
        wdEjvwCiD3dRrr77dHwqw8moqaAOQZhl4A==
X-Google-Smtp-Source: ABdhPJwa40qaFduig+ioQMCkyBLikQv7X35lxUnFtarqXDGQ1mkEJmn2C2oZG6aOBqq8rA5uYdVa0A==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr829455wrs.100.1607023433988;
        Thu, 03 Dec 2020 11:23:53 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9cff:9584:adb2:6288? ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.googlemail.com with ESMTPSA id m8sm362229wmc.27.2020.12.03.11.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 11:23:53 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.11
Message-ID: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
Date:   Thu, 3 Dec 2020 20:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b996544916429946bf4934c1c01a306d1690972c:

  tick: Get rid of tick_period (2020-11-19 10:48:29 +0100)

are available in the Git repository at:

  ssh://git@git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.11

for you to fetch changes up to ab3105446f1ec4e98fadfc998ee24feec271c16c:

  clocksource/drivers/riscv: Make RISCV_TIMER depends on RISCV_SBI
(2020-12-03 19:16:26 +0100)

----------------------------------------------------------------
- Add static annotation for the sp804 init functions (Zhen Lei)

- Code cleanups and error code path at init time fixes on the sp804
  (Kefen Wang)

- Add new OST timer driver device tree bindings (Zhou Yanjie)

- Remove EZChip NPS clocksource driver corresponding to the NPS
  platform which was removed from the ARC architecture (Vineet Gupta)

- Add missing clk_disable_unprepare() on error path for Orion (Yang
  Yingliang)

- Add device tree bindings documentation for Renesas r8a774e1
  (Marian-Cristian Rotariu)

- Convert Renesas TMU to json-schema (Geert Uytterhoeven)

- Fix memory leak on the error path at init time on the cadence_ttc
  driver (Yu Kuai)

- Fix section mismatch for Ingenic timer driver (Daniel Lezcano)

- Make RISCV_TIMER depends on RISCV_SBI (Kefeng Wang)

----------------------------------------------------------------
Daniel Lezcano (1):
      clocksource/drivers/ingenic: Fix section mismatch

Geert Uytterhoeven (1):
      dt-bindings: timer: renesas: tmu: Convert to json-schema

Kefeng Wang (5):
      clocksource/drivers/sp804: Make some symbol static
      clocksource/drivers/sp804: Use clk_prepare_enable and
clk_disable_unprepare
      clocksource/drivers/sp804: Correct clk_get_rate handle
      clocksource/drivers/sp804: Use pr_fmt
      clocksource/drivers/riscv: Make RISCV_TIMER depends on RISCV_SBI

Marian-Cristian Rotariu (1):
      dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings

Vineet Gupta (1):
      clocksource/drivers/nps: Remove EZChip NPS clocksource driver

Yang Yingliang (1):
      clocksource/drivers/orion: Add missing clk_disable_unprepare() on
error path

Yu Kuai (1):
      clocksource/drivers/cadence_ttc: Fix memory leak in
ttc_setup_clockevent()

Zhen Lei (1):
      clocksource/drivers/sp804: Add static for functions such as
sp804_clockevents_init()

周琰杰 (Zhou Yanjie) (1):
      dt-bindings: timer: Add new OST support for the upcoming new driver.

 Documentation/devicetree/bindings/timer/renesas,tmu.txt  |  49
--------------------------
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml |  99
+++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig                              |  12 +------
 drivers/clocksource/Makefile                             |   1 -
 drivers/clocksource/ingenic-timer.c                      |   2 +-
 drivers/clocksource/timer-cadence-ttc.c                  |  18 +++++-----
 drivers/clocksource/timer-nps.c                          | 284
--------------------------------------------------------------------------------------------------------------------------------------------------
 drivers/clocksource/timer-orion.c                        |  11 ++++--
 drivers/clocksource/timer-sp804.c                        |  49
+++++++++-----------------
 include/dt-bindings/clock/ingenic,sysost.h               |  10 ++++--
 10 files changed, 142 insertions(+), 393 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.yaml
 delete mode 100644 drivers/clocksource/timer-nps.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
