Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F22C01A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgKWIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 03:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728121AbgKWIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606121207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EgyJjhX29A+wOUcHgkoovIGjjiENqeDg1JmKe2gpgE=;
        b=WPP6pIEWffg3k33N2ZP7d8dcF36Ijgq8A3V+ijQWMLO+Bj+VpVFYHvavBXgVx5Rgwtij+z
        SKKvRvy3hCFVilztagYpf+ADX01qh5UfrPGWalNaI86LznhvJE1dOxBYb9EsJYMLTPGgdf
        kot7te6IG2YcDnjgJZheeqOnB/EVeTs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-fbqioZYXOD-lvoF7duujsw-1; Mon, 23 Nov 2020 03:46:44 -0500
X-MC-Unique: fbqioZYXOD-lvoF7duujsw-1
Received: by mail-ej1-f71.google.com with SMTP id y23so5375935ejp.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 00:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EgyJjhX29A+wOUcHgkoovIGjjiENqeDg1JmKe2gpgE=;
        b=kPr3xFi2EAIakOimoX2cechHXwx5Z4uhTXSrBPCz/b8M9GWoxLZnx2AhYDXPZqZFjo
         Fqa0OansnvadVkcmyi/4qCJHtpDbZuOdaWm4Tz3GVAfxk+LF1VJM1p+DodXja+5FegEF
         lKYfE2Sdg4yI7XTiSWnp/W4focuGYga/vu51X3pUAW+d/vfPw/7Fa+0mE8o5Z7bqjDrS
         XvCyL/Bno3VuAip3KORJKoMKnJwYvuzewK74x0KbcLSZ8uA9+avkC7y3j3sEM2Zt4A0Y
         HTry71/pvPqO2yFWnyJnO+bJ5Qp9DnnxIx95K3B40FhlkhJAHe+B6jz/A8/jn1O9xGia
         9y2A==
X-Gm-Message-State: AOAM530N9UsShGRkMKjhyeIbVBUyduVDDcCiSpMdZKmH4u5ENnkKmT+q
        hrvlC1GuUfDb8RRSTkNVpIfOJC+177NVm+fvYeXO1DPfuifdjnnUOnXN2VFHYCDdIunaWUJvBqO
        7YeCrxnMmacd3wBeht+Orfl0Eej66KgZOzdTBW6IpYLxYOBdzfMftAPluCpmlcm/1hYi8pfCbx+
        B2
X-Received: by 2002:a05:6402:3076:: with SMTP id bs22mr11962049edb.267.1606121203108;
        Mon, 23 Nov 2020 00:46:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxArviIzq7Y2VUTP/v0eMdhI8XczZlTvXdk7SSJlx1EK9GwksDj+tt0vm8gqre0iudxZE2tfQ==
X-Received: by 2002:a05:6402:3076:: with SMTP id bs22mr11962038edb.267.1606121202934;
        Mon, 23 Nov 2020 00:46:42 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id b15sm4545719ejz.114.2020.11.23.00.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 00:46:42 -0800 (PST)
Subject: Re: [PATCH] Input: soc_button_array - add missing include
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20201123061508.GA1009828@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <017e8b75-4913-ca62-db1d-6c137edf650a@redhat.com>
Date:   Mon, 23 Nov 2020 09:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201123061508.GA1009828@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/23/20 7:15 AM, Dmitry Torokhov wrote:
> This fixes the following build errors:
> 
>   CC [M]  drivers/input/misc/soc_button_array.o
> drivers/input/misc/soc_button_array.c:156:4: error: implicit declaration of function 'irq_set_irq_type' [-Werror,-Wimplicit-function-declaration]
>                         irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
>                         ^
> drivers/input/misc/soc_button_array.c:156:26: error: use of undeclared identifier 'IRQ_TYPE_LEVEL_LOW'
>                         irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
>                                               ^
> 2 errors generated.
> 
> Fixes: 78a5b53e9fb4 ("Input: soc_button_array - work around DSDTs which modify the irqflags")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/input/misc/soc_button_array.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index cae1a3fae83a..d14a65683c5e 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/input.h>
>  #include <linux/init.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> 

