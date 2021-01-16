Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70F2F8DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbhAPRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbhAPRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B5C06179E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 05:44:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so17350633lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNhGar/ixldlY+SFdNHhUUClLY5raSV5R71u6rIvoU8=;
        b=PXKPyFOobv4j13l7WfEy2vHHf/PKw4Szyo2nYiJARHk8Trm3r2ZqJQgp+87baSfO87
         ghdr3mpwhTSOWOXLIVz+3nbXVCZITtEOsooplXXxWViKwpLIY+fOhtF1tolu4kLWP8Vq
         RqJIAG3o7rxS3bAfS/v3e0oRbObhZOw6F1EHaDidHSh1iijeSQ3/3JuXMlPEvhekXvVf
         L7LO3EvKMVn+nS3dC/OQPTdvKVv7+QJ3RMJewtN14KApSSWEmUxpiDkeU5y0SnqIHk1x
         Y/WbZ0s8J8vif53Aj8d7B68Wo00D4+Lu3jR+PcvUmn0A0Tl+k0fQDaWMFZhP6QJqLLdd
         XVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNhGar/ixldlY+SFdNHhUUClLY5raSV5R71u6rIvoU8=;
        b=osTjU3tMwLCxHE58envNgnwZpNP81QbxjTQZrFXU+CVXxeOKxhJ+pqOVzaGiZo2Crb
         hu3BYDWbE0PsQXc5cPGbZmttv5AO4j/mPGoNgbYzYpIeGpsNGKf/EqFnVF9prsySDYL9
         +Zc7uJR7r1oTU+VK8AeT9SSa9Y/33FtJhEwU3o4FoqCw5GnxtOzGDgwVAHxzNaeEIvma
         EuKpheJomctIE1eFgKBsgXXcVIhJBO+C2Jqse1DmrWJ+pqUQSncbeYD91MuXj2sShzSH
         8QpPi4MoLaLMbC7otlkg9sKcJr9fG5USl7zD25Ao9MHgFVpIqeU8V1JApGfmZmIFTYsY
         asLw==
X-Gm-Message-State: AOAM5315ugBiXbSeZBIrjS0DcAORkH84d1pcPhsZPnyMMzXDg5B0D970
        g6QqyzARN7Fm77G/+dkYFXQTNtNScqr0hoFgtcM=
X-Google-Smtp-Source: ABdhPJxwVQAWBK58o6BP6rAw+L4QzBWswyYulqUVfPlOYNjLDXq73+Wpl0MJKzRqkM61Qr0KIk0Oukzalw+hVXPrnvk=
X-Received: by 2002:a19:4856:: with SMTP id v83mr7412006lfa.583.1610804682059;
 Sat, 16 Jan 2021 05:44:42 -0800 (PST)
MIME-Version: 1.0
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley> <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley> <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley> <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
 <20210116124856.GA3406@portage>
In-Reply-To: <20210116124856.GA3406@portage>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 16 Jan 2021 10:44:30 -0300
Message-ID: <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 9:49 AM Oliver Graute <oliver.graute@gmail.com> wrote:

> > power-supply = <&reg_touch_3v3> is not correct, as the reg_touch_3v3
> > does not power the LCD.
>
> yes, but how is the LCD correctly powered then?

J4 is powered by VCC_5V and VCC_3V#.

> [    7.795980] pwm-backlight backlight: supply power not found, using dummy regulator
> [    7.804436] OF: /backlight: #pwm-cells = 3 found -1
> [    7.806563] of_pwm_get(): can't parse "pwms" property
> [    7.812026] pwm-backlight backlight: unable to request PWM
> [    7.822929] pwm-backlight: probe of backlight failed with error -22

You need to fix this.

> [    7.876831] imx-sdma 20ec000.sdma: Direct firmware load for imx/sdma/sdma-imx6q.bin failed with error -2
> [    7.884231] imx-sdma 20ec000.sdma: Falling back to sysfs fallback for: imx/sdma/sdma-imx6q.bin
> [    7.916013] printk: console [ttymxc0] enabled
> [    7.916013] printk: console [ttymxc0] enabled
> [    7.922351] printk: bootconsole [ec_imx6q0] disabled
> [    7.922351] printk: bootconsole [ec_imx6q0] disabled
> [    7.952397] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 68, base_baud = 5000000) is a IMX
> [    7.970794] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 69, base_baud = 5000000) is a IMX
> [    8.033015] ------------[ cut here ]------------
> [    8.037826] WARNING: CPU: 0 PID: 1 at ../drivers/gpu/drm/panel/panel-simple.c:577 panel_simple_probe+0x5dc/0x6b8

And this too

> [    8.846104] imx6ul-pinctrl 20e0000.pinctrl: pin MX6UL_PAD_NAND_CE0_B already requested by regulator-gpio; cannot claim for 1806000.nand-controller
> [    8.859641] imx6ul-pinctrl 20e0000.pinctrl: pin-107 (1806000.nand-controller) status -22
> [    8.867851] imx6ul-pinctrl 20e0000.pinctrl: could not request pin 107 (MX6UL_PAD_NAND_CE0_B) from group gpminandgrp  on device 20e0000.pinctrl
> [    8.880930] gpmi-nand 1806000.nand-controller: Error applying setting, reverse things back
> [    8.889726] gpmi-nand: probe of 1806000.nand-controller failed with error -22

And this pin conflict too.
