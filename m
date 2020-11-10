Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587FD2AD1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKJJBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgKJJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604998875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4VY/yPsS/m/WZ9pEuQqK3Pk7b75F4LRKyeFxg81vzQ=;
        b=KA411pmKrtBO1RTrOSx2TMo5MmXvfPlTFk1ygOZI2cz3eBYQ3byPnUViHwG3EsM/d6rA3U
        6L3uO1baHT2FocYMclezCKbcgl3/2KCWW7kNt5QfRnonMuOY4KX0HY8bxbyo9s7wHVGWkD
        xR+Ul1XISHHYZs9jRZ6reBdFBjSfUgY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-Qinp_DnjMzukv4_3m7kI4w-1; Tue, 10 Nov 2020 04:01:13 -0500
X-MC-Unique: Qinp_DnjMzukv4_3m7kI4w-1
Received: by mail-ed1-f72.google.com with SMTP id n16so3935678edw.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W4VY/yPsS/m/WZ9pEuQqK3Pk7b75F4LRKyeFxg81vzQ=;
        b=qcsVqsKBEm73WIaDIPx8Znphkgqn+YavXQ7+AJfjTFc8ekrwhEdaL3iCRLJjEhiJ9b
         0wAz6e3GKXcbSDP+QrGiNOW4hLNBuFr2hJaBjWYfwDVId4j218s2jJVQlDo3qFb5P2Pk
         8kH7E/PTYg4Q0InDADwmS/R1XscZKzWMQg55os90V466e5XdFGYjaDdvoA0a4X9xgfDZ
         eV4Zc24b03N8RnmqLQ/e5jy733VnnJGQTL07ClP0RM6DHxvG5IE0C+wpK/A397OROxoS
         o32yFDr8RwnoY2+IYXaO/gfH0vSQSx8jNpc6xo82JsduK82jISepYe3Yu0gUx2K1Tmcf
         MAaw==
X-Gm-Message-State: AOAM533wo0AiXCxfAMvrjK0T0lWMkOd2NseXsyoUB5qL+pb7mrK/RbLr
        UUN1lHjVwuYTYVOG4gNG6CaxsKOJM3RKuGht1X1YMffzAdNCVjqK8axYQuS2CxKt60hV/SSZ+hY
        KnjigCBNyM9CE6VE7730oXpIyqI3/f+sLVwrwfSZ86xmBesibpcOpHubFtJDZRhpMOw3eAoTXmF
        pI
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr20062241edw.294.1604998871935;
        Tue, 10 Nov 2020 01:01:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXhICreT0TZ9M8hsz1LDME3U8E+EEx5OL0tlEE9oJncCENp46nIsg6LLXNUb+SAjFVKh/hsA==
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr20062196edw.294.1604998871623;
        Tue, 10 Nov 2020 01:01:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id e18sm9952662eja.124.2020.11.10.01.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 01:01:11 -0800 (PST)
Subject: Re: [PATCH v5 1/4] HID: i2c-hid: Reorganize so ACPI and OF are
 separate modules
To:     Douglas Anderson <dianders@chromium.org>, jkosina@suse.cz,
        benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kai.heng.feng@canonical.com, robh+dt@kernel.org,
        linux-input@vger.kernel.org, swboyd@chromium.org,
        andrea@borgia.bo.it, Jiri Kosina <jikos@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pavel Balan <admin@kryma.net>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20201109213636.1267536-1-dianders@chromium.org>
 <20201109133526.v5.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d51318d1-5d26-f840-2651-42a1134d407b@redhat.com>
Date:   Tue, 10 Nov 2020 10:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109133526.v5.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/20 10:36 PM, Douglas Anderson wrote:
> This patch rejiggers the i2c-hid code so that the OF (Open Firmware
> aka Device Tree) and ACPI support is separated out a bit.  The OF and
> ACPI drivers are now separate modules that wrap the core module.
> 
> Essentially, what we're doing here:
> * Make "power up" and "power down" a function that can be (optionally)
>   implemented by a given user of the i2c-hid core.
> * The OF and ACPI modules are drivers on their own, so they implement
>   probe / remove / suspend / resume / shutdown.  The core code
>   provides implementations that OF and ACPI can call into.
> 
> We'll organize this so that we now have 3 modules: the old i2c-hid
> module becomes the "core" module and two new modules will depend on
> it, handling probing the specific device.
> 
> As part of this work, we'll remove the i2c-hid "platform data"
> concept since it's not needed.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v5:
> - Add shutdown_tail op and use it in ACPI.
> - i2chid_subclass_data => i2chid_ops.
> - power_up_device => power_up (same with power_down).
> - subclass => ops.
> 

Thanks this looks good to now, 2 small remarks below (since you are
going to do a v6 anyways). Feel free to ignore these remarks if
you prefer to keep things as is.

And feel free to add my reviewed-by to v6 of this patch:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

<snip>

> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> new file mode 100644
> index 000000000000..5f09635d00ce
> --- /dev/null
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> @@ -0,0 +1,170 @@

<snip>

> +static const struct i2c_device_id i2c_hid_acpi_id_table[] = {
> +	{ "hid", 0 },
> +	{ "hid-over-i2c", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, i2c_hid_acpi_id_table);

Hmm, I do not think these old-style i2c-ids are necessarry at
all in this driver. I expect all use-cases to use either
of or acpi matches.

This was already present in the code before though, so
please ignore this remark. This is just something which
I noticed and thought was worth while pointing out as
a future cleanup.

<snip>

> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index aeff1ffb0c8b..9551ba96dc49 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -35,12 +35,8 @@
>  #include <linux/kernel.h>
>  #include <linux/hid.h>
>  #include <linux/mutex.h>
> -#include <linux/acpi.h>
> -#include <linux/of.h>
>  #include <linux/regulator/consumer.h>

I think you can drop this regulator include here now too ?


> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
> new file mode 100644
> index 000000000000..15d533be2b24
> --- /dev/null
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
<snip>

> +static const struct dev_pm_ops i2c_hid_of_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
> +};

This dev_pm_ops struct is identical to the one in i2c-hid-acpi.c
and the one which you introduce later in i2c-hid-of-goodix.c
is also identical, so that is 3 copies.

Maybe just put a shared dev_pm_ops struct in the i2c-core
(and don't export the suspend/resume handlers) ?

Regards,

Hans

