Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B72032F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFVJJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgFVJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:09:40 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7BEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:09:39 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id n22so3768069vkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uYBnx5Pd0JEWUtF4tP/douqUFR/4LJiyBToJ6+M5Mos=;
        b=GpTZOwoVdoA0Fs44vwiD3BYhO9YuW1O3FbXT1GMfb8wTUnFd7FVAS1SZz3LGQoT8ZO
         yJCpgosFc7y2NOrQRFpg4Tf8h++sqQEyJIEPfEG0jwW8iVPYAIlmJkphqwiO0qnZHVKT
         eRHlAx8Om97ur5uePbF0Nlz4PPBULF7tkW5sa/bGpOdxS+A8Muzvxu7WtyWLWOU5s+D6
         3EwoGwjn0iJQjb5ChIr1ZFbiJeFvHZgkg8YIsZfhd1Vtyk/n42AsOudf84zmFbkvCYgJ
         nvm/OYPhIjngfFUBrY1trqT+YA2tD/5Z6Mu4tcq+Wj4/+CVItQiHqEghPi3QAfrLIZQs
         xsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uYBnx5Pd0JEWUtF4tP/douqUFR/4LJiyBToJ6+M5Mos=;
        b=lkfEb9xbUewkqfRJhUaUCdXTOPhsu15QBKLsiqi+e9rOe3t8mz7OeYgM0A4VFVnei4
         Kd+KL8OhjQ1qLBrxwtB9ogyXPX0GZ24UHYiLaHQpU5h3qmfbwcOrHofihhSebb6Zs9WK
         bbcNSgr4ut9IJCVcRB8ZdBPG908LMwtdFxugkFTokAGY8tD++hLhAO+dc6jN+nSJt6/9
         2Dp0kWhCk5Pa9vAtqoQ86BXQ+kGguR41F1S6lxFIvtDzFJ4tCuCuWq4YOA+dfgTpI0GL
         jZ6dKV7C/uOyCvl+Oy3vcSDe/jZHECR0WCs38aS3b7Tiemn1em9Cox1qiCiHcgJhKH5U
         syKA==
X-Gm-Message-State: AOAM530k6mwY3i3XDlC4XtYy08df4XVPAGjcO2FEJ1rrsAZDnOkwRQ/o
        PZKzoxbddif6vt0ykl1hRgk8h5PAyDAOAz7+2OXfrZ+bzMU=
X-Google-Smtp-Source: ABdhPJzyEl0K8Zg96C9/TQ1W8WVyN4oGe6xAHuMn/jXuSvEuLSJReDhfhNIvb+Mi69mgxbOL2iXXWO4/MWZWj/n4jkw=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13mr15055997vks.9.1592816978544;
 Mon, 22 Jun 2020 02:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200608091739.2368-1-narmstrong@baylibre.com> <20200618081957.GD2608702@dell>
In-Reply-To: <20200618081957.GD2608702@dell>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 22 Jun 2020 14:39:27 +0530
Message-ID: <CAHLCerOqnySYDKnNBMSE=+ZtB2GMgonP_=DxTMcquqDujsMjjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] mfd: Add support for Khadas Microcontroller
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 1:49 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 08 Jun 2020, Neil Armstrong wrote:
>
> > The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontr=
oller
> > connected via I2C.
> >
> > This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> > boards.
> >
> > It has multiple boot control features like password check, power-on
> > options, power-off control and system FAN control on recent boards.
> >
> > Thie serie adds :
> > - the bindings
> > - the MFD driver
> > - the Thermal Cooling cell driver
> > - updates MAINTAINERS
> > - add support into the Khadas VIM3/VIM3L DT
> >
> > Changes since v2 at [3]:
> > - Removed NVMEM driver for separate submission
> > - fixed MFD driver, header and Kconfig
> > - fixed Thermal Kconfig
> > - fixed MAINTAINERS files and path
> >
> > Changes since RFC v1 at [2]:
> > - moved hwmon driver to thermal-only
> > - moved the SM1 thermal nodes in a separate serie
> > - added the bindings review tag from rob
> >
> > [1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre=
.com
> > [2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre=
.com
> > [3] http://lore.kernel.org/r/20200512132613.31507-1-narmstrong@baylibre=
.com
> >
> > Neil Armstrong (5):
> >   dt-bindings: mfd: add Khadas Microcontroller bindings
> >   mfd: add support for the Khadas System control Microcontroller
> >   thermal: add support for the MCU controlled FAN on Khadas boards
> >   MAINTAINERS: add myself as maintainer for Khadas MCU drivers
> >   arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
>
> I'm a bit concerned by the missing patches from my inbox.
>
> Looks like you omitted to send me patch 3 and 5.
>
> Hopefully the Thermal patch doesn't depend on the MFD one!

Neil did mention that it depends on include/linux/mfd/khadas-mcu.h. So
I think we should just merge this through the MFD tree.

>
> >  .../devicetree/bindings/mfd/khadas,mcu.yaml   |  44 +++++
> >  MAINTAINERS                                   |   9 +
> >  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
> >  drivers/mfd/Kconfig                           |  21 +++
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/khadas-mcu.c                      | 142 ++++++++++++++
> >  drivers/thermal/Kconfig                       |  11 ++
> >  drivers/thermal/Makefile                      |   1 +
> >  drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
> >  include/linux/mfd/khadas-mcu.h                |  91 +++++++++
> >  10 files changed, 517 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.ya=
ml
> >  create mode 100644 drivers/mfd/khadas-mcu.c
> >  create mode 100644 drivers/thermal/khadas_mcu_fan.c
> >  create mode 100644 include/linux/mfd/khadas-mcu.h
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
