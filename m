Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25F19D006
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 08:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgDCGJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 02:09:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37456 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:09:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id o3so4239050vsd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3yS2lItqVOfGsXBFcK1Q03oHDR0TygtC5pNqATurHQ=;
        b=DtAiTGcqQSpV/avwmNRjvHO1qDLd3tZsNHf3k+C+AgpkKHnLK0/VqwekGEJ4JQQ0uq
         wXTt47KxFzE5AetYqr4lZNkUqqQvCxPwyDnzOdlwb2XRAY3sI63HyI8fCcfwegKRCIJx
         Wr/jdxxl1E+403E/ErpRJFCWlSoK8AeJ20XUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3yS2lItqVOfGsXBFcK1Q03oHDR0TygtC5pNqATurHQ=;
        b=jFjvDej4rTtAS7q5K88VDZDZu2Zo/MnEqYjCz/PGTWZF0cX/+L4Z6BPdUUX9pZeiTh
         CLW4PX9PNQDhirG0PRmM8Ko5K6gM7fl7SW6QiGIiUbhFIpuIINUCfXLQNVehv5kYWhoC
         kQQ/Q6AnlB233lssJ87kqJOPzqkPolOgitNFrtomYVT17r9tSL7Dxa+2aj7BLgCSmJRz
         us+R+/WLc+5tAOc/XFhOik8VsSXva3woxXx8yuGwMqioBSCOfhyARhdjYIIyzWvM9hRs
         hi4Sq2/NZ8KesUK65TSnh/NVdLhZa3JyQrPhTB5S8AUsdBigUbEmZmUnr/Z2SxJPk3L8
         b4Bw==
X-Gm-Message-State: AGi0PuaBggmum5mXRPwVuN43Q6CpqcXp0hWIaSMjBSxYcEazbOeydqmJ
        1C1XMgYT4Vf0tWhAE6SnnxzDZbFPtYk=
X-Google-Smtp-Source: APiQypK/J+FpOht59AA/Du+JG/v13nVXJYXl3zwl55P7mFzwTZUkkXkeJBvT3AEPbz6D75W3jHea/w==
X-Received: by 2002:a67:d491:: with SMTP id g17mr5232353vsj.114.1585894164000;
        Thu, 02 Apr 2020 23:09:24 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id v65sm2023130vkv.30.2020.04.02.23.09.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 23:09:23 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id r129so1710440vkr.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 23:09:23 -0700 (PDT)
X-Received: by 2002:a1f:1846:: with SMTP id 67mr5194780vky.32.1585894163062;
 Thu, 02 Apr 2020 23:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200403052900.258855-1-evanbenn@chromium.org>
In-Reply-To: <20200403052900.258855-1-evanbenn@chromium.org>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Fri, 3 Apr 2020 17:08:52 +1100
X-Gmail-Original-Message-ID: <CAKz_xw1w=uKEV_p94cT8uL-4WN9mRkQE47N=4QdE+_NOFQ-2kg@mail.gmail.com>
Message-ID: <CAKz_xw1w=uKEV_p94cT8uL-4WN9mRkQE47N=4QdE+_NOFQ-2kg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a watchdog driver that uses ARM Secure Monitor Calls.
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Julius Werner <jwerner@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies I forgot to add this note to my cover letter.

Xingyu do you mind seeing if you can modify your ATF firmware to match
this driver?
We can add a compatible or make other changes to suit you.

Thanks


On Fri, Apr 3, 2020 at 4:29 PM Evan Benn <evanbenn@chromium.org> wrote:
>
> This is currently supported in firmware deployed on oak, hana and elm mt8173
> chromebook devices. The kernel driver is written to be a generic SMC
> watchdog driver.
>
> Arm Trusted Firmware upstreaming review:
>     https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405
>
> Patch to add oak, hana, elm device tree:
>     https://lore.kernel.org/linux-arm-kernel/20200110073730.213789-1-hsinyi@chromium.org/
> I would like to add the device tree support after the above patch is
> accepted.
>
> Changes in v3:
> - Change name back to arm
> - Add optional get_timeleft op
> - change name to arm_smc_wdt
>
> Changes in v2:
> - Change name arm > mt8173
> - use watchdog_stop_on_reboot
> - use watchdog_stop_on_unregister
> - use devm_watchdog_register_device
> - remove smcwd_shutdown, smcwd_remove
> - change error codes
>
> Evan Benn (1):
>   dt-bindings: watchdog: Add ARM smc wdt for mt8173 watchdog
>
> Julius Werner (1):
>   watchdog: Add new arm_smd_wdt watchdog driver
>
>  .../bindings/watchdog/arm-smc-wdt.yaml        |  30 +++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/watchdog/Kconfig                      |  13 ++
>  drivers/watchdog/Makefile                     |   1 +
>  drivers/watchdog/arm_smc_wdt.c                | 181 ++++++++++++++++++
>  6 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
>  create mode 100644 drivers/watchdog/arm_smc_wdt.c
>
> --
> 2.26.0.292.g33ef6b2f38-goog
>
