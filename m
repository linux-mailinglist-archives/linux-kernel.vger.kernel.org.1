Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1CD2D2942
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgLHKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLHKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:52:22 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84207C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 02:51:36 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j1so6794224pld.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UlHl24p6fxuDH25Kk5N+Q2ViFc59+5OvDmyHBv2e2/g=;
        b=S4L7bRhELufh7rFjZSQ9Ykm05G8DuuUWBbHEwVQx78mI6D3YycV9jiASCfnUL5dJUA
         Mvjg7+eq3MBZfAX7DB8fPZKSBpquu31fuBrvhtH4rNiIc+xuYcZY/uU40O8gnvLSWvLn
         9N6dQDjEvsyzEptoCewN/jB+U+ybi8nIBMrYEtw7Wv5ZSOb6K4UpQkPczCmIKLuLHljE
         WtRXyBnDWhAUfH9P7pCC192GA1Pit6e89oX253CQGK5f8fR7MoQ7zVLWHVA/dpB9evy1
         lw5kfndmUbkPYJitcwQOU192rr+dPFEcCt3ABtRkvGnSzLv7R3AyN5zjFuQEmB57+nZ9
         1nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlHl24p6fxuDH25Kk5N+Q2ViFc59+5OvDmyHBv2e2/g=;
        b=TY6XCbI7wAIN3Okq5bhHCcyHSUdR2cyk0VxGz/opgEI3qvj6PyO/me5s+S0RjAdQXM
         WaXC7KW5Pc1X2CXl4lxh/p356R7fJWyf9zl2zY/Cx3CQliH5PncPgAGxIUYj3jDcAQbL
         osiXDp1bKiftwOM/cgFXIs7CtmIAS0CUV09pivdil1dnK4RVuL3+5Ag5jm3O1rUdNLC5
         wgVzFAGkXVrA5i8LGaSaVekksek+lV0Db+h6AB8YV8y/YY3Y4NcW/QMYgrvN41s6m0Sk
         MWJiLp2MI+kk/wX2H8NdbuuDtzsP6+xGo5u44wdJy7Sx+Mdgtftokbi0wyvVENVVdD1t
         DQgw==
X-Gm-Message-State: AOAM532a2E1afsxYzK3qQfdK3XpbW2iAn1+ghPIbkgGX+FY79dFHP71x
        mzNPErqSAPcb0YF7L86yl8l2
X-Google-Smtp-Source: ABdhPJwWnOEFpxM8yNXKrdGZb6OIYwABnP3bfJiKeY6qltwyXuz6q1V9KKMw6/PY3wkahT/AWyHBEA==
X-Received: by 2002:a17:902:44e:b029:da:b944:b798 with SMTP id 72-20020a170902044eb02900dab944b798mr20871276ple.6.1607424695981;
        Tue, 08 Dec 2020 02:51:35 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id b17sm17205192pfi.61.2020.12.08.02.51.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Dec 2020 02:51:35 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:21:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 0/3] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <20201208105128.GA9925@work>
References: <20201122170822.21715-1-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122170822.21715-1-mani@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 10:38:19PM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Hello,
> 
> This series adds support for MaxLinear/Exar USB to serial converters.
> This driver only supports XR21V141X series but it can easily be extended
> to other series in future.
> 
> This driver is inspired from the initial one submitted by Patong Yang:
> https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop
> 
> While the initial driver was a custom tty USB driver exposing whole
> new serial interface ttyXRUSBn, this version is completely based on USB
> serial core thus exposing the interfaces as ttyUSBn. This will avoid
> the overhead of exposing a new USB serial interface which the userspace
> tools are unaware of.
> 
> This series has been tested with Hikey970 board hosting XR21V141X chip.
> 
> NOTE: I've removed all reviews and tested-by tags as the code has gone
> through substantial rework. Greg, Linus, Mauro please consider reviewing
> again.
> 

Any chance to get this series into v5.11?

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v5:
> 
> * Incorporated review comments from Johan. Noticeable ones are:
>   - Made serial and gpiolib support exclusive and used mutex to avoid
>     race. The gpio requests from gpiolib will be rejected when serial
>     port is in use.
>   - The driver only binds to data interface but claims both control and
>     data interface.
>   - Handled B0 request
>   - Removed all reviews as the code has gone through substantial rework.
> 
> Changes in v4:
> 
> * Multiple improvements based on Johan's review. Noticeable ones are:
>   - Now the driver claims both control and data interfaces but only registers
>     tty device for data interface.
>   - GPIO pin status is now shared between the console and gpiolib
>     implementations. This is done to avoid changing the lines spuriously.
>   - A separate port_open flag is added to reject GPIO requests while the tty
>     port is open.
>   - Removed padding PID to gpio device.
> * Added Greg and Mauro's review and tested tags.
> * Included a patch from Mauro to avoid the CDC-ACM driver to claim this device
>   when this driver is built.
> 
> Changes in v3:
> 
> * Dropped the check for PID and also the reg_width property.
> 
> Changes in v2:
> 
> * Dropped the code related to handling variable register size. It's all u8 now.
> * Dropped the header file and moved the contents to driver itself.
> * Added Linus's reviewed-by tag for gpiochip patch.
> * Added PID to gpiochip label
> * Dropped gpiochip for interface 0
> 
> Manivannan Sadhasivam (2):
>   usb: serial: Add MaxLinear/Exar USB to Serial driver
>   usb: serial: xr_serial: Add gpiochip support
> 
> Mauro Carvalho Chehab (1):
>   usb: cdc-acm: Ignore Exar XR21V141X when serial driver is built
> 
>  drivers/usb/class/cdc-acm.c    |   6 +
>  drivers/usb/serial/Kconfig     |   9 +
>  drivers/usb/serial/Makefile    |   1 +
>  drivers/usb/serial/xr_serial.c | 854 +++++++++++++++++++++++++++++++++
>  4 files changed, 870 insertions(+)
>  create mode 100644 drivers/usb/serial/xr_serial.c
> 
> -- 
> 2.25.1
> 
