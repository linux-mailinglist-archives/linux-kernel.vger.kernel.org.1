Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0342B908B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKSLAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgKSLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:00:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:00:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p8so5973644wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+FzrNTcpFE9hDbVxONey2uDdLqJnkfcKNBqwstAfUjA=;
        b=oc9IXkSAKZdgGh0nCj2FWENZoZQAVnZAFzUO91wu7J4rIJqXVbDeYRbmhnV9wbi3TX
         a0xsXwr5ILwgOAiSWUR5QNWCJ355QgTFq8gkwm9YVhNPEnHq1/A/zuDsT/AjJnxXr2Vw
         GSyJ64+rR74/6bZXfwcSVREK9oMg16POSwrPlkGGp8FGuY2i2Fm+IXv2Tsa7x9YWg69j
         /V1X3y8oFr4tWnPioN7aCSfO+RKCcUj1AmTCSTecmYVb6RmCPAWHIBjOQ+YOLbgy+dmw
         XLC+R1Xcc+JvoQZBSwxKT/SibR2zipn3EwUQ1YlvncOshQAmKyA91HFxG1aTd42T7hlb
         0gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+FzrNTcpFE9hDbVxONey2uDdLqJnkfcKNBqwstAfUjA=;
        b=BHf2L3TKwVBvE4jBsMa4rP+TCRjm/fpaFc8/inoeM8sUwRTkSKAec98MUc/UJasyBb
         ePX6lHHiIwUlndnSgJW9SOUtaxj9doQunP3618eMa4QUkegM/oHqYwKHa4thep1ys0b1
         M5L6dimlY9UXuXYFsbvgVBncUwm5wvnkA/cpmHYteMx2FMv4vqshzjRL2mKDGFgLxyGv
         KSHu4jBcV+nha5On4PUUyYmZj6l9ET1cngrfzZV/7SJ/mT+ucsk8ZniqSLUg+qOBL5Sb
         tWX0TR3S5SJRxxSdMx/v0chHkVsLfehEhsOkoG/ckbEpen7t4PV81sANbeHoPhvGsOHf
         lVCA==
X-Gm-Message-State: AOAM533m4zp4qH7N4lWSNB6rH9c2iYpB3xtjxwksNEE+wZLCOg3sRPaq
        SqMb8iZcysiFWF85lsvCjOuKng==
X-Google-Smtp-Source: ABdhPJyA/UJ/ti4GuYRSAsZTj6mTwwzCy2CX/kou5bCokcWDSY3BNtaV+I7WuIlcwYTqGk5Ojq/lBg==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr10027320wrr.351.1605783634533;
        Thu, 19 Nov 2020 03:00:34 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:5150:1004:6c70:8db9? ([2a01:e34:ed2f:f020:5150:1004:6c70:8db9])
        by smtp.googlemail.com with ESMTPSA id u5sm33690784wro.56.2020.11.19.03.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 03:00:33 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.10-rc5
Message-ID: <e1bcd711-a3bf-58aa-7efd-053fa0fe5514@linaro.org>
Date:   Thu, 19 Nov 2020 12:00:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.10-rc5

for you to fetch changes up to b98467fe96d2415836d154ecfe1cd389bf4147b5:

  thermal: ti-soc-thermal: Disable the CPU PM notifier for OMAP4430
(2020-11-12 12:30:29 +0100)

----------------------------------------------------------------
- Disable the CPU PM notifier for OMAP4430 for suspend in order to
  prevent wrong temperature leading to a critical shutdown (Peter
  Ujfalusi)

----------------------------------------------------------------
Peter Ujfalusi (1):
      thermal: ti-soc-thermal: Disable the CPU PM notifier for OMAP4430

 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
