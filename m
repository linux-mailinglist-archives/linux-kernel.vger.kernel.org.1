Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EA25D77B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgIDLfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbgIDLX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:23:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DFC0611E2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:11:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so5720111wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LjQtNgStW1hALd3XhSoX7pAgphzsITUHS7smGh0YpFE=;
        b=FwqQTXfmpEk27k1Cnptou5LcLzVWIuD5BRbwqgxCEKk7zQDKMJzVOS9c6XW2avSVj3
         JobmwDln7gtg+zV2cU2JWkCTXW2fOc0+YfAjiTiKBpcj1gH6e83pVLLcAL6JJZ07Wxkr
         KL5sqM2H0TcqYKWLCAmOJ4OWE5Mrb2V7bj4TtV3e+6VanvzflsZoN/w7JfswCyu0vOlR
         PJ0F5qYYLpRng19WdutxOv7mA1M40H03mG0MtiWBPC2PqXMgCyo3EvspfAEf8R5tiqDS
         pQNtFxfkyNWGjghuoxaRLeX1F2MRo8uix+8psNsS/qg5SLfUXRvGQXm1mYy2LKsiodw7
         53AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LjQtNgStW1hALd3XhSoX7pAgphzsITUHS7smGh0YpFE=;
        b=esxPA/TkYB4HcYfuF9PHHwjYcIl0sfiT04EGCs7bM+PVTo2z1GKv7PtCf6FlaCW36F
         ADjmJiegPePDD+ARKdTbUBpFdOSLAEvbCGflWBXxe/jTcjk4RAiyGC4veLzrG+AHqLt1
         Ux764Eu8RP5Bx7GbxgYc1eiROUx664JkNnyxERzpKTUNuG0w/SPqH5aXvgQYR0i0eVPn
         nBuew6wLZAx2nYZOy2+6aOR3V2W9KE0fHRw20gX2nOkjpy0Gp1biVheoTGK7fjC+lh5e
         jbQlKjyF5N1T1QDZp1fhBe0KzMKgOKt4Iz/sGHKJ3Y11RV5mUtwdW9tyGUXPYRje48l9
         3mSw==
X-Gm-Message-State: AOAM530d0VqoCP/Zz0lU9sOaaAbJGkJaH3Jld+V/WHbVmoBkBfPXUonL
        +vraRy3DvwDetwaeaWPsiYZms/dVgE97dg==
X-Google-Smtp-Source: ABdhPJw/uDWOWC7lIwiu1IibpgDgLlCsBUZt3k6+E6Be+gUioTKNidQkMX5TgZ3IVlV4h5HiFChblQ==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr7420970wmb.95.1599217902811;
        Fri, 04 Sep 2020 04:11:42 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:35e2:113b:59f2:81a? ([2a01:e34:ed2f:f020:35e2:113b:59f2:81a])
        by smtp.googlemail.com with ESMTPSA id s124sm10742438wme.29.2020.09.04.04.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:11:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL RESEND] thermal fixes for v5.9-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Veera Vegivada <vvegivad@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <6b8dbaef-b288-4d44-1916-a10892e665bc@linaro.org>
Date:   Fri, 4 Sep 2020 13:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ with lkml@ cc'ed ]

Hi Linus,

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.9-rc4

for you to fetch changes up to a5f785ce608cafc444cdf047d1791d5ad97943ba:

  thermal: core: Fix use-after-free in thermal_zone_device_unregister()
(2020-09-04 11:52:54 +0200)

----------------------------------------------------------------
- Fix bogus thermal shutdowns for omap4430 where bogus values
  resulting from an incorrect ADC conversion are too high and fire an
  emergency shutdown (Tony Lindgren)

- Don't suppress negative temp for qcom spmi as they are valid and
  userspace needs them (Veera Vegivada)

- Fix use-after-free in thermal_zone_device_unregister reported by
  Kasan (Dmitry Osipenko)

----------------------------------------------------------------
Dmitry Osipenko (1):
      thermal: core: Fix use-after-free in thermal_zone_device_unregister()

Tony Lindgren (1):
      thermal: ti-soc-thermal: Fix bogus thermal shutdowns for omap4430

Veera Vegivada (1):
      thermal: qcom-spmi-temp-alarm: Don't suppress negative temp

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  4 ++--
 drivers/thermal/thermal_core.c                     |  5 +++--
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    | 23
+++++++++++-----------
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  | 10 +++++++---
 4 files changed, 24 insertions(+), 18 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
