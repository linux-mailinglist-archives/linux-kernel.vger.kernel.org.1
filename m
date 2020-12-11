Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678272D7414
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392452AbgLKKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgLKKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:40:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A9C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:39:24 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t16so8503653wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vGAFmagdEKXa2z/yGjJBFLpeCKuOBUWGbFdU5kOT3gU=;
        b=vVbWDUKIYQVOMUepgFWGZmCgdwqVvs2i0ERJxeh8NRcxIlNkcGs5nNbdNcvUUnmjAL
         swSBi9/+VBBqjgOSgrDuczo1I8M4uWqDjrtNbDW20k73jDYENHOuNnzJ1hv3AvgAa/pG
         QHa5C2A0gxn3dwchBqU56E2dAif4+eVFO5KZx5p0/J01iZD56o6eFoo0mq1eWE95BE0O
         xyCXwuAFstTv9Rq37ByJ0cZIMpNHSTwzIf7uyfNcOpd05kzQ97a+WAMC35r4IvdnNAoX
         89IZ1AYrWWud2DZC+QFhCA4sXXwvc7OEkW7xWzk0EuKxqMfxZDlGRbU8iovOSXOV8sO1
         MOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vGAFmagdEKXa2z/yGjJBFLpeCKuOBUWGbFdU5kOT3gU=;
        b=AbfWNLauj1A8zNEJfXLKtt+qw8jVo1I6Z5Z4E8us5uSYya83q0w9fu4Nf+ihU8ycuz
         bMpxmoZQ0YJvOLOKnYJ7srNlNIuDp43cBHHHkCW0GuMyiIryjyo5+NXdi6eCK+KNDe6+
         fj+vnGV28Y+kOur0mQGfS9DMsDyTp3FoyE0HNYGsECxRr5N9IXQFh92ILzXIge3K0TwB
         DPbHyqewsWrcM7R3122mZCQmXIEAtA7jm4bRb2jMP7jQhWgM3N6I3Nhv2jgC1ruFb728
         y6ukVQq2eIWjQ6lXwCyy5xiYN0cuMmKR9yEm1zCtdiuNXJH8XUiJzQQZ7t7ZZ7mLEPtv
         0f0Q==
X-Gm-Message-State: AOAM533yJLdD3xLP8IngARBjEpUHAuZoyUM3JUFV3dSPgOdFynzJODDG
        7BaYXczKoS9MgarDwLKSRtQq5qMhwljgmA==
X-Google-Smtp-Source: ABdhPJz5X7OxK0eHJ5hNjjkaJ0HxC5XX1z0zakm8TyVTNfQxLGSpFRmE/a+H3bqRiqy3K9DVHNeaQg==
X-Received: by 2002:adf:e802:: with SMTP id o2mr13598303wrm.251.1607683162862;
        Fri, 11 Dec 2020 02:39:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fc92:290c:960a:52ef? ([2a01:e34:ed2f:f020:fc92:290c:960a:52ef])
        by smtp.googlemail.com with ESMTPSA id 89sm14645337wre.51.2020.12.11.02.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 02:39:22 -0800 (PST)
Subject: Re: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ba9c6f75-3964-3ee9-c849-17db5ae51501@linaro.org>
Date:   Fri, 11 Dec 2020 11:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208164145.19493-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

I believe I took into account all the comments, do you think it is
possible to merge this series ?



On 08/12/2020 17:41, Daniel Lezcano wrote:
> The density of components greatly increased the last decade bringing a
> numerous number of heating sources which are monitored by more than 20
> sensors on recent SoC. The skin temperature, which is the case
> temperature of the device, must stay below approximately 45°C in order
> to comply with the legal requirements.
> 
> The skin temperature is managed as a whole by an user space daemon,
> which is catching the current application profile, to allocate a power
> budget to the different components where the resulting heating effect
> will comply with the skin temperature constraint.
> 
> This technique is called the Dynamic Thermal Power Management.
> 
> The Linux kernel does not provide any unified interface to act on the
> power of the different devices. Currently, the thermal framework is
> changed to export artificially the performance states of different
> devices via the cooling device software component with opaque values.
> This change is done regardless of the in-kernel logic to mitigate the
> temperature. The user space daemon uses all the available knobs to act
> on the power limit and those differ from one platform to another.
> 
> This series provides a Dynamic Thermal Power Management framework to
> provide an unified way to act on the power of the devices.
> 
> Changelog:
>  V5:
>   - Fixed typos in documentation
>   - Added a dtpm NULL pointer check in the dtpm_register() function
>  V4:
>   - Changed fine grain spinlocks by global tree mutex lock
>     - Dropped tested by tag from Lukasz
>   - Fixed rollback routine in dtpm_cpu
>   - Checked freq_qos_request_active() when releasing the dtpm_cpu node
>  V3:
>   - Fixed power-limit computation in addition with the hotplugging
>   - Improved the encapsulation
>   - Added specific ops for the leaves of the tree
>   - Simplified API and self-encapsulation
>   - Fixed documentation and generated it to check the content
>  V2:
>   - Fixed indentation
>   - Fixed typos in comments
>   - Fixed missing kfree for dtpm_cpu
>   - Capitalize letters in the Kconfig description
>   - Reduced name description
>   - Stringified section name
>   - Added more debug traces in the code
>   - Removed duplicate initialization in the dtpm cpu
> 
> Daniel Lezcano (4):
>   units: Add Watt units
>   Documentation/powercap/dtpm: Add documentation for dtpm
>   powercap/drivers/dtpm: Add API for dynamic thermal power management
>   powercap/drivers/dtpm: Add CPU energy model based support
> 
>  Documentation/power/index.rst         |   1 +
>  Documentation/power/powercap/dtpm.rst | 212 ++++++++++++
>  drivers/powercap/Kconfig              |  13 +
>  drivers/powercap/Makefile             |   2 +
>  drivers/powercap/dtpm.c               | 473 ++++++++++++++++++++++++++
>  drivers/powercap/dtpm_cpu.c           | 257 ++++++++++++++
>  include/asm-generic/vmlinux.lds.h     |  11 +
>  include/linux/cpuhotplug.h            |   1 +
>  include/linux/dtpm.h                  |  77 +++++
>  include/linux/units.h                 |   4 +
>  10 files changed, 1051 insertions(+)
>  create mode 100644 Documentation/power/powercap/dtpm.rst
>  create mode 100644 drivers/powercap/dtpm.c
>  create mode 100644 drivers/powercap/dtpm_cpu.c
>  create mode 100644 include/linux/dtpm.h
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> 
> --
> 2.17.1
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
