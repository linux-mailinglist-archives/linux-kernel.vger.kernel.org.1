Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E14276CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgIXJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:04:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119FAC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:04:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v12so2768293wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2ud3C0txFvYTWVHt/hYxT8SjNqyx8BInSAq+pPaYkvE=;
        b=IwY++CYKlPy2SuCGsZSW+S+RE/kVBdWCtbfpNPh0gmUQ8S5bOivET0Rphlw4NE4nOc
         Ptxz73P469XxL9x2URs2bdPn+3HDb7pabYcPf5Bdp1HES08uX2ymzDyFs9RswPbbg/fX
         ur70XOztHRUsCSm84aH28pm+/ekCfQAtFxhh9vZMffsBn4A92pefRcgFVvPd+u3gfJNq
         v2XDVZFjlJUw4ed2IaRWvjjZgDZq25KA49RVZgiPCMZuqCYZgbCBf/4e4FKPBuMAu5uN
         xImYwsnSl0+giZbd6RM2kVhwEo9YhGEazz3DQHEve41Y/VAhWkuinAzGLliYAnr/V9i6
         XR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2ud3C0txFvYTWVHt/hYxT8SjNqyx8BInSAq+pPaYkvE=;
        b=bZLr/2BSa0mby06I57/tzZKshuZKI0A0zRfM26LTHsjrw0tvIl6//+DEFjnrybKgGL
         nDKNiEglTQVfAjwpfQiqyCvv0Y6HfkCLJWpQKlcytT1PrzQzVbXxAU5MP7RC0XvV0Paz
         GjT8sxNoeY5KXRQVc4l8JRAmMT+WWcrIvB3zAlDLh4DxWhTu51WMveWrVeRFX75phNBm
         Y1Xm3fKTc2158SKbM9DflAZ1xxiV6WiJLI6YtA9QKQp8jxSnB+tiF9+AETvQ36zEl+73
         ZQEiE9dZBGQgdbGb3sTVSVwuWHJlhO2keny9wRZOzYx5p9nCFDt3vZpfeitL751S67OY
         SYXw==
X-Gm-Message-State: AOAM533VxcuU2ydLS0XDF5KRdAwb4ynFLdcnyOeSDZazs8GfMEc2BIzI
        lIR2zBofPFhs68qm2tC38MHU0g==
X-Google-Smtp-Source: ABdhPJwNBjMR7tGVMBCNHGpQkvbpsTovMAoLtW1kIXlHKuwPVbP3MdacSVVWw0L0djSIkutWPWa2IA==
X-Received: by 2002:a1c:67d4:: with SMTP id b203mr3606362wmc.120.1600938253622;
        Thu, 24 Sep 2020 02:04:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:11e1:db8b:493b:54f4? ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.googlemail.com with ESMTPSA id m3sm2678625wrs.83.2020.09.24.02.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 02:04:13 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.10
Message-ID: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
Date:   Thu, 24 Sep 2020 11:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ec02821c1d35f93b821bc9fdfa83a5f3e9d7275d:

  alarmtimer: Convert comma to semicolon (2020-08-25 12:45:53 +0200)

are available in the Git repository at:

  https://git@git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.10

for you to fetch changes up to 549437a43f45ce70cf5012317633c635c43ba4f4:

  clocksource/drivers/sp804: Enable Hisilicon sp804 timer 64bit mode
(2020-09-24 10:51:04 +0200)

----------------------------------------------------------------
- Add DT binding documentation to support the r8a7742 and r8a774e1
  platforms (Lad Prabhakar)

- Add sp804 variant support for the Hisilicon platforms (Kefeng Wang)

----------------------------------------------------------------
Kefeng Wang (1):
      clocksource/drivers/sp804: Cleanup clk_get_sys()

Lad Prabhakar (2):
      dt-bindings: timer: renesas,cmt: Document r8a7742 CMT support
      dt-bindings: timer: renesas,cmt: Document r8a774e1 CMT support

Zhen Lei (7):
      clocksource/drivers/sp804: Remove unused sp804_timer_disable() and
timer-sp804.h
      clocksource/drivers/sp804: Delete the leading "__" of some functions
      clocksource/drivers/sp804: Remove a mismatched comment
      clocksource/drivers/sp804: Prepare for support non-standard
register offset
      clocksource/drivers/sp804: Support non-standard register offset
      clocksource/drivers/sp804: Add support for Hisilicon sp804 timer
      clocksource/drivers/sp804: Enable Hisilicon sp804 timer 64bit mode

 .../devicetree/bindings/timer/renesas,cmt.yaml     |   4 +
 drivers/clocksource/timer-sp.h                     |  32 ++++
 drivers/clocksource/timer-sp804.c                  | 210
++++++++++++++-------
 include/clocksource/timer-sp804.h                  |  29 ---
 4 files changed, 183 insertions(+), 92 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
