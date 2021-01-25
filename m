Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4C30306B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbhAYXp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbhAYVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:30:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0FBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:29:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ke15so20092310ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wlbod8JHGZ21A4x47Cvv07nirv4Z4f0HRDNM2760h18=;
        b=P/foCwvKNfI3fFrDQJaSqzb0cm4uroP0oS06O/Kpw9tPfPfBO7j/NrlDVPA1yNc4jK
         2dyxRhwgzmYdudFhIgR4q1G1x71yBDYiDbJTann3M4ebNjDgZzjqlvo51RZbGb0DCRb+
         qEh2pekFi27lNkagDnIaW91q71jQcaKcVC4/xlLa4gWzo9s5k3qF5qhAIQ5m0w8LGTh6
         dfFwwGDojRgByhyfzvOSSMAUaScl/1IuWwZW+6LDn8/OWyDo6VPvwiljOzAQJjVULSfe
         cBxk5VUcLN+nmfdkqmXOc4UWLeOaupBKvYMl7AxM0eNuslBpenJeNHdS/JLLiE5MP6Yx
         2wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wlbod8JHGZ21A4x47Cvv07nirv4Z4f0HRDNM2760h18=;
        b=uHYff2T1LY0deXhO6+j1VXNpzspt9zHur48b7aP2ah4ni+OP4RXddgfwmwthRzvhbj
         A8+Uhr5qJTCCi/x8WcVAiqwyDXleahPYCGk47WYWCpPZ5nRvY1xAmVsYZspV8g+zFVeQ
         vkm9xZ3XgdsKTNBu2/E0rrBuErkpmIGM0kgZHL1HNLvatZQ09KDmRqGO8i9NcVvfjYr+
         fiQ1JbFTtEu07Q7ZmmCDXR8ROG8AvIlz84drAm1VAfTiEnRufNrzVMKV4Wy5pJgBUmrx
         fMKBb6JbQD/wTeUErQTAsbDTiqysBMd90FPAPMW40GPTXnC5zya8ri0bkWQxyHf1x3yn
         z80Q==
X-Gm-Message-State: AOAM5335mmtwWlwKB+Y2qZaEcLjYqcVoO9wnYmfvppQPZtUbRmTzwGdr
        qMNH1CRip5oeU4RhhZ7HPXY=
X-Google-Smtp-Source: ABdhPJxdKE/fF3AXYaF6LwrFBwRIt/ZMycdvlPfowqbMBv6RSyplon+Q93MUTcggcjckr997lzrGgQ==
X-Received: by 2002:a17:906:154d:: with SMTP id c13mr1571463ejd.471.1611610169570;
        Mon, 25 Jan 2021 13:29:29 -0800 (PST)
Received: from localhost (ipv6-99dd8b8f16e7f879.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:99dd:8b8f:16e7:f879])
        by smtp.gmail.com with ESMTPSA id g25sm8803257ejf.15.2021.01.25.13.29.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:29:28 -0800 (PST)
Date:   Mon, 25 Jan 2021 22:29:17 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210125212917.GA4177@portage>
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley>
 <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley>
 <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley>
 <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
 <20210116124856.GA3406@portage>
 <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/21, Fabio Estevam wrote:
> On Sat, Jan 16, 2021 at 9:49 AM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > > power-supply = <&reg_touch_3v3> is not correct, as the reg_touch_3v3
> > > does not power the LCD.
> >
> > yes, but how is the LCD correctly powered then?
> 
> J4 is powered by VCC_5V and VCC_3V#.
> 
> > [    7.795980] pwm-backlight backlight: supply power not found, using dummy regulator
> > [    7.804436] OF: /backlight: #pwm-cells = 3 found -1
> > [    7.806563] of_pwm_get(): can't parse "pwms" property
> > [    7.812026] pwm-backlight backlight: unable to request PWM
> > [    7.822929] pwm-backlight: probe of backlight failed with error -22
> 
> You need to fix this.
> 
> > [    7.876831] imx-sdma 20ec000.sdma: Direct firmware load for imx/sdma/sdma-imx6q.bin failed with error -2
> > [    7.884231] imx-sdma 20ec000.sdma: Falling back to sysfs fallback for: imx/sdma/sdma-imx6q.bin
> > [    7.916013] printk: console [ttymxc0] enabled
> > [    7.916013] printk: console [ttymxc0] enabled
> > [    7.922351] printk: bootconsole [ec_imx6q0] disabled
> > [    7.922351] printk: bootconsole [ec_imx6q0] disabled
> > [    7.952397] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 68, base_baud = 5000000) is a IMX
> > [    7.970794] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 69, base_baud = 5000000) is a IMX
> > [    8.033015] ------------[ cut here ]------------
> > [    8.037826] WARNING: CPU: 0 PID: 1 at ../drivers/gpu/drm/panel/panel-simple.c:577 panel_simple_probe+0x5dc/0x6b8
> 
> And this too
> 
> > [    8.846104] imx6ul-pinctrl 20e0000.pinctrl: pin MX6UL_PAD_NAND_CE0_B already requested by regulator-gpio; cannot claim for 1806000.nand-controller
> > [    8.859641] imx6ul-pinctrl 20e0000.pinctrl: pin-107 (1806000.nand-controller) status -22
> > [    8.867851] imx6ul-pinctrl 20e0000.pinctrl: could not request pin 107 (MX6UL_PAD_NAND_CE0_B) from group gpminandgrp  on device 20e0000.pinctrl
> > [    8.880930] gpmi-nand 1806000.nand-controller: Error applying setting, reverse things back
> > [    8.889726] gpmi-nand: probe of 1806000.nand-controller failed with error -22
> 
> And this pin conflict too.

Ok I fixed the pin conflict with regulator-gpio and added a 5V
regulator node in my dts file. Now the display is working fine!

I'll post the dts files soon and check if there is something to
improve for this patch.

Many thanks for your help,

Oliver
