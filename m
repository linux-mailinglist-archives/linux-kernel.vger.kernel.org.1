Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D842CFE6B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLETdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgLETdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607196732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofSC9lpwG6+UCSNudemJILG6AFj0fHelQy+fBqMM60g=;
        b=IJcaELS9QwBG8ZD54qcE/d8Fkuy3TkwSTJ90/DF+XybnRVscFrbvEhqzHARpQjyYbWxdV6
        bAC3CkbRXO/vVIhLry0XP9i9ZerVew7bMtQGKTCYR83FbwRunPa0WCS8KF44lR74KVaGpM
        O8Yb3IvaxKTrJVo1rnVd5WLgiJidVvs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-UiJa-HOaMhmK30gdQpixag-1; Sat, 05 Dec 2020 14:32:11 -0500
X-MC-Unique: UiJa-HOaMhmK30gdQpixag-1
Received: by mail-wm1-f72.google.com with SMTP id u123so2905151wmu.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 11:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ofSC9lpwG6+UCSNudemJILG6AFj0fHelQy+fBqMM60g=;
        b=EsgKZfUlHn/GjlfKY/yT+6Vh7v+tOL6nTSsE4UuhOZgUclN5aIUyM3sjw3Uf8dwubZ
         ipIWX5NbazeyX5AmS6m5I4X40boCmmEaXk5q9ZzZ/rYQNT6cnG3tkA1/yRu0ikhbR0tT
         /XJxwTv/mGWHGXdLl3nqdU6kNLf3lkqaZZSclGX1XYIdFBUPpjxgW/3AjkovncIp5yl8
         FER7tU8UQJYb7RAe/fqNap2YmNEXdQXYZxA9qaUqzh998eaV9Lj5FQ8m9QS1+eFUx9rD
         uEeggWfliczTcg6m0JMijd27Rri7P8VmpKj8BTznJWxET/wWP5babvFG3GkkBge/76Rf
         aPDw==
X-Gm-Message-State: AOAM530eGY5CxHpmmd6Klw4fv3KXS/fJMMLPjRNGJIJropbcrrLAZpdl
        A97Cbv+HIo206q0+560MBVOxFukGG8/1Hogr8x8Xy2W+VMJjgMebGYqlduknCRZK2hKACMiMEln
        t6QQ4nSHlveay2dLyVZaMp/zD
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr10659849wme.118.1607196729259;
        Sat, 05 Dec 2020 11:32:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTZFGnBU4zJ3vNUAlp7Lk23tATWWb8vX7NoCe2Rd1SBGhMQ9NKv0j2hhmXa23rEif7aIjTgQ==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr10659834wme.118.1607196729032;
        Sat, 05 Dec 2020 11:32:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id b14sm8512163wrq.47.2020.12.05.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:32:08 -0800 (PST)
Date:   Sat, 5 Dec 2020 14:32:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-riscv@lists.infradead.org, stefanha@redhat.com,
        msuchanek@suse.de
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201205142218-mutt-send-email-mst@kernel.org>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 08:59:55AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 04.12.20 04:35, Jason Wang wrote:
> 
> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -1615,6 +1615,15 @@ config GPIO_MOCKUP
> >>         tools/testing/selftests/gpio/gpio-mockup.sh. Reference the
> >> usage in
> >>         it.
> >>   +config GPIO_VIRTIO
> >> +    tristate "VirtIO GPIO support"
> >> +    depends on VIRTIO
> > 
> > 
> > Let's use select, since there's no prompt for VIRTIO and it doesn't have
> > any dependencies.
> 
> whoops, it's not that simple:
> 
> make: Entering directory '/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git'
> make[1]: Entering directory
> '/home/nekrad/src/dk/DistroKit/platform-x86_64/build-target/linux-5.8.9-build'
>   GEN     Makefile
> drivers/gpu/drm/Kconfig:74:error: recursive dependency detected!
> drivers/gpu/drm/Kconfig:74:	symbol DRM_KMS_HELPER is selected by
> DRM_VIRTIO_GPU
> drivers/gpu/drm/virtio/Kconfig:2:	symbol DRM_VIRTIO_GPU depends on VIRTIO
> drivers/virtio/Kconfig:2:	symbol VIRTIO is selected by GPIO_VIRTIO
> drivers/gpio/Kconfig:1618:	symbol GPIO_VIRTIO depends on GPIOLIB
> drivers/gpio/Kconfig:14:	symbol GPIOLIB is selected by I2C_MUX_LTC4306
> drivers/i2c/muxes/Kconfig:47:	symbol I2C_MUX_LTC4306 depends on I2C
> drivers/i2c/Kconfig:8:	symbol I2C is selected by FB_DDC
> drivers/video/fbdev/Kconfig:63:	symbol FB_DDC depends on FB
> drivers/video/fbdev/Kconfig:12:	symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:80:	symbol DRM_KMS_FB_HELPER depends on
> DRM_KMS_HELPER
> 
> Seems that we can only depend on or select some symbol - we run into
> huge trouble if thats mixed. Just changed DRM_VIRTIO_GPU to just select
> VIRIO instead of depending on it, and now it works.
> 
> I've posted another patch for fixing drivers/gpu/drm/virtio/Kconfig
> to use 'select' instead of 'depends on'.

It seems a bit of a mess, at this point I'm not entirely sure when
should drivers select VIRTIO and when depend on it.

The text near it says:

# SPDX-License-Identifier: GPL-2.0-only
config VIRTIO
        tristate
        help
          This option is selected by any driver which implements the virtio
          bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
          or CONFIG_S390_GUEST.

Which seems clear enough and would indicate drivers for devices *behind*
the bus should not select VIRTIO and thus presumably should "depend on" it.
This is violated in virtio console and virtio fs drivers.

For console it says:

commit 9f30eb29c514589e16f2999ea070598583d1f6ec
Author: Michal Suchanek <msuchanek@suse.de>
Date:   Mon Aug 31 18:58:50 2020 +0200

    char: virtio: Select VIRTIO from VIRTIO_CONSOLE.
    
    Make it possible to have virtio console built-in when
    other virtio drivers are modular.
    
    Signed-off-by: Michal Suchanek <msuchanek@suse.de>
    Reviewed-by: Amit Shah <amit@kernel.org>
    Link: https://lore.kernel.org/r/20200831165850.26163-1-msuchanek@suse.de
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

which seems kind of bogus - why do we care about allowing a builtin
virtio console driver if the pci virtio bus driver is a module?
There won't be any devices on the bus to attach to ...

And for virtio fs it was like this from the beginning.

I am inclined to fix console and virtio fs to depend on VIRTIO:
select is harder to use correctly ...

Jason?


> -- 
> ---
> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schlüssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287

