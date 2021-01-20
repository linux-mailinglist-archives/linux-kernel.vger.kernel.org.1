Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C8B2FCCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbhATIea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbhATIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:32:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E3C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:31:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so16971899wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4qevJvQqm/0ecYCkcXVa31c2tPSxqHqv7osuAjZ8w9w=;
        b=cwO3gbm3VamltSpf1OODDZ7nGqqrYYKRiEcgaM87Vc+0ysxqwU9md3qL+ojxjIaSVu
         feuabSNQyaNJZaTAYANGFMQVHvn1Jnilja8P2kMYxMDMYwUJmdzCQzbHfo6u1rzGDEIx
         nGSvH2Ux3WX1suiJ4U0zCuXwzcgbljUv4IXizUhNQFAwGNS5XLNG7rmwvguQe5aase4b
         OwOSswW8JzB+Y15zBueLCxmyUUx3nSyTlXnC+UtQ+Xs3JmX/zLEdUgzDjXCrBhbRArmt
         ZST1hSqF07xIXPjzXeF2Vqraxyb2tkY/wuOAhw6xlFSyyFkhQIeVaDvPkYnDMyyUZJSg
         u/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4qevJvQqm/0ecYCkcXVa31c2tPSxqHqv7osuAjZ8w9w=;
        b=MI57DzaTNjVgBSO0vZ65igq6ZfMltet1MHvrqejoN1MSPTAsIIXN8++TTxaeIQkS0+
         NwPlXtdmqCaT3/t25gpvLyBdWmYlmIC+dpBUdxqa2f9B1kV1cPsImal3gseQmCS1WvtL
         nf1Q6vjRCXuyLWt7RiQjWxWkoHHrsFF84nSISxe25eVeM4YG3wI8zSiVLOrV7CyuFlKw
         aPTYq/DFeKAViHsy5fiTZa3XFXSGy8eHOYupxINR3D3Tjc03t+0HyEUcVuy2YC0s2dF2
         RAm4VqlPwIcvfZ5Y58YoblS/mBltzWM1PiOxDQ0Cl46niwxGfxAOu36GZdiUkrYkJdzD
         AhOg==
X-Gm-Message-State: AOAM5307BaVv1MX87SH+5S51HsZiKUevkC2DzcnPUC1vfmeQQpXPDO0p
        ycLTjTIm00qsX160VV5YMFPwF1zEEC8N5A==
X-Google-Smtp-Source: ABdhPJxqyMiUk1RzyX80RN+ciBuTvICdkESaXFku/mrhDzDu/mWf1AzAcaqU7LETYq0SdMc2+hG2+g==
X-Received: by 2002:adf:b1db:: with SMTP id r27mr8192641wra.125.1611131480854;
        Wed, 20 Jan 2021 00:31:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c8a3:239a:c6eb:c10b? ([2a01:e34:ed2f:f020:c8a3:239a:c6eb:c10b])
        by smtp.googlemail.com with ESMTPSA id r25sm936174wrr.64.2021.01.20.00.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 00:31:20 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, trix@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers fixes for v5.11-rc5
Message-ID: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org>
Date:   Wed, 20 Jan 2021 09:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider the following three fixes for the timer drivers.

Thanks

  -- Daniel

The following changes since commit e3fab2f3de081e98c50b7b4ace1b040161d95310:

  ntp: Fix RTC synchronization on 32-bit platforms (2021-01-12 21:13:01
+0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.11-rc5

for you to fetch changes up to 7da390694afbaed8e0f05717a541dfaf1077ba51:

  clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is
defined (2021-01-18 22:28:59 +0100)

----------------------------------------------------------------
- Fix harmless warning with the ixp4xx when the TIMER_OF option is not
selected (Arnd Bergmann)

- Make sure channel clock supply is enabled on sh_cmt (Geert Uytterhoeven)

- Fix compilation error when DEBUG is defined with the mxs_timer (Tom Rix)

----------------------------------------------------------------
Arnd Bergmann (1):
      clocksource/drivers/ixp4xx: Select TIMER_OF when needed

Geert Uytterhoeven (1):
      clocksource/drivers/sh_cmt: Make sure channel clock supply is enabled

Tom Rix (1):
      clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is
defined

 arch/arm/mach-ixp4xx/Kconfig    |  1 -
 drivers/clocksource/Kconfig     |  1 +
 drivers/clocksource/mxs_timer.c |  5 +----
 drivers/clocksource/sh_cmt.c    | 16 +++++++++++++---
 4 files changed, 15 insertions(+), 8 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
