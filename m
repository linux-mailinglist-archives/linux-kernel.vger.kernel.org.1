Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE826E6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIQUXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgIQUXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:23:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD49C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:25:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3241965wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fnNtIiw2rIjrsGeETGQ4HVhLgof6IApfDCKNZB0rtx4=;
        b=FnbmoKzn7ml3hNVC5JMySDeca53lTjtdCXoL4cxAwzsEJrHzyEDKiOIljY35+rHymp
         jt5GwmgM0shyZllOsgSZwY1CN+167LFzIGjPBmfNcdzVLaAOviH2qCxmpdLIINnBYKdr
         Nenh/eU1pcNo7H7CYh7JbOgBzXixsAvVANZjgbmMpOdpEOqoSWQOaJdn0OEkqXMoKEDM
         Q0SNuv4Q5KZUIK5oUfQtO9Gcy3oo5OvaZ3rbJ7eOSHvaN8c1rIBr1TUyzLh0jx/opgMg
         Syx8dKN4xhP81GhQDlmyDEUOhNv4IH6zDXnd2mrLTjbJp/76i8olBPS0b7cja4sPq5o/
         fzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fnNtIiw2rIjrsGeETGQ4HVhLgof6IApfDCKNZB0rtx4=;
        b=PGaw1i9jvSqKvT645L7tf4SAKfxH/IeVdzpp6NTEzDJXIvnJTIOie37LmUJER7MCNx
         Ftk5KG2ef834JhhU9yGLAbVlV+Z7H3aMzybKmtuFbEFKMQY95KsXawE1rI8wDtJJG+Q0
         vwuJDoUsTmwtPTxJgnh+PRLnSt5HHtrU2r3ka17Bj7aAL9ZB8HLm3y/GZTLcrPXsU5DA
         MTa7zipCo62bkGlRFYK5VFt4MMF3xwEsNfqrXNzJOvA2BwXfqNGbEjNYIGLn+GU0MU0T
         F9fMheN+L/KxsdfDCPFYSPaW4D21k8RolGhc1llcTzENhSeuBQbRFbojhAr/CcYLnBpD
         jgxA==
X-Gm-Message-State: AOAM5307I5j09QLvxVNe5bl2evELV2YusnLLCkF3qXZJt8aARViw/TCa
        8Hf4knD/ZgPNhrE5r5cvhzI7YQ==
X-Google-Smtp-Source: ABdhPJwHQNEGKQiK5VaKpdrHxxRlNDliXhK+3vSwtgJ/Fr7no0AtL6d27HAF4oliOiP95GvT8d67qQ==
X-Received: by 2002:a05:6000:100c:: with SMTP id a12mr36101704wrx.115.1600370717856;
        Thu, 17 Sep 2020 12:25:17 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id i6sm970270wra.1.2020.09.17.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 12:25:16 -0700 (PDT)
Date:   Thu, 17 Sep 2020 20:25:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] Immutable branch between MFD, HWMON, GPIO, IRQChip, PWM
 and Watchdog due for the v5.10 merge window
Message-ID: <20200917192514.GF4678@dell>
References: <20200914214341.14268-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200914214341.14268-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-hwmon-irqchip-pwm-watchdog-v5.10

for you to fetch changes up to 3f697027bcb0959d7c24d59550ab1da07c2dd609:

  hwmon: Add support for the sl28cpld hardware monitoring controller (2020-09-17 16:02:42 +0100)

----------------------------------------------------------------
Immutable branch between MFD, HWMON, GPIO, IRQChip, PWM and Watchdog due for the v5.10 merge window

----------------------------------------------------------------
Michael Walle (8):
      mfd: Add simple regmap based I2C driver
      dt-bindings: mfd: Add bindings for sl28cpld
      mfd: simple-mfd-i2c: Add sl28cpld support
      irqchip: Add sl28cpld interrupt controller support
      watchdog: add support for sl28cpld watchdog
      pwm: Add support for sl28cpld PWM controller
      gpio: Add support for the sl28cpld GPIO controller
      hwmon: Add support for the sl28cpld hardware monitoring controller

 .../bindings/gpio/kontron,sl28cpld-gpio.yaml       |  54 +++++
 .../bindings/hwmon/kontron,sl28cpld-hwmon.yaml     |  27 +++
 .../kontron,sl28cpld-intc.yaml                     |  54 +++++
 .../devicetree/bindings/mfd/kontron,sl28cpld.yaml  | 153 ++++++++++++
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml         |  35 +++
 .../bindings/watchdog/kontron,sl28cpld-wdt.yaml    |  35 +++
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/sl28cpld.rst                   |  36 +++
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sl28cpld.c                       | 161 ++++++++++++
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/sl28cpld-hwmon.c                     | 142 +++++++++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sl28cpld.c                     |  96 ++++++++
 drivers/mfd/Kconfig                                |  22 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/simple-mfd-i2c.c                       |  57 +++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sl28cpld.c                         | 270 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sl28cpld_wdt.c                    | 229 +++++++++++++++++
 26 files changed, 1429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
 create mode 100644 Documentation/hwmon/sl28cpld.rst
 create mode 100644 drivers/gpio/gpio-sl28cpld.c
 create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
 create mode 100644 drivers/irqchip/irq-sl28cpld.c
 create mode 100644 drivers/mfd/simple-mfd-i2c.c
 create mode 100644 drivers/pwm/pwm-sl28cpld.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
