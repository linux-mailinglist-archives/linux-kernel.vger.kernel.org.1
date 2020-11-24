Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557E92C21D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgKXJj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:39:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731559AbgKXJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606210760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZ7CehUUaEq2hmE1v+VaSFpw/raxtP/pGzbiD0suVXQ=;
        b=IjLPdSaeTP+fu24dGv9AviLrWCCzf5bsTJYZcQYjXQFLbZgjbOousTBMmccNGzkyT9fK2B
        uiOGfCA8xlKQr1BYs5HlClWX5S0KRE3pIzfzhN2Hr2iQ3r9Dyq1gGor7VmC/vKwyLnc7uU
        bCyVoTjo1Vv0/rUNlZ4Cc2qlZSqUYME=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-7l10wu_iNeWpmqQa5tvLCA-1; Tue, 24 Nov 2020 04:39:18 -0500
X-MC-Unique: 7l10wu_iNeWpmqQa5tvLCA-1
Received: by mail-ej1-f70.google.com with SMTP id a13so6288376ejv.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ7CehUUaEq2hmE1v+VaSFpw/raxtP/pGzbiD0suVXQ=;
        b=oP6f7Kw/zmAx4UOo3UTm2pM+/iZ0SmUnTPLIOjBOLMy6n4d5hvpehCvQsBkkAFjCh/
         WPPgoQZ3vGQm+HjzLrrxjis1IyUpglV+lPV3bd+cCKAmp5Ve1T0yQh7pGWIscJsZT+Kc
         5+lutJ43yqvYO1Hz+zxlvccndPuuJpLRl2c9isJHcDE1qq5but/IRXuP2finl6czUILF
         bIhcJzs3EIp4vgrmNb2Wt/GITjnZ+HF/YwCknLXUFV1VFl/gk4+sWW4ufVPlRdJhUdjV
         AlPrd7hdjLu2MvdQ9LmFsquhsU9XhBMo19kot98dZhjdwCoegIgikVvzkn7uut0N2XVc
         ZffA==
X-Gm-Message-State: AOAM530vHRtSun6bKfX7M3jnAZb4tIc7Sv4khpkj0wDk4UPzetd3vr3I
        xsjNX9l0hu5VOvAcw3P4A8VSHCO9gM8xJpKul0isp7UbWQ8FThx1wnU8AItgAXFtDWtVK5v7xTd
        +x7Pv1+t1bJTs7VZ+qWd6YWeD
X-Received: by 2002:a17:906:490:: with SMTP id f16mr3571787eja.12.1606210757169;
        Tue, 24 Nov 2020 01:39:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbraEzTC/kvaLqVRH/B6BYCc6j8uc619geaDI8q7jzgkfCLJ33OwqhtWowfW9z4T0+41Z56g==
X-Received: by 2002:a17:906:490:: with SMTP id f16mr3571777eja.12.1606210757001;
        Tue, 24 Nov 2020 01:39:17 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id v27sm6644321edl.82.2020.11.24.01.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:39:16 -0800 (PST)
Subject: Re: [PATCH] input: soc_button_array: fix IRQ-related build errors
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
References: <20201124001802.10094-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cf1d080a-6eb0-6660-6e8d-46491f7991d3@redhat.com>
Date:   Tue, 24 Nov 2020 10:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124001802.10094-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 11/24/20 1:18 AM, Randy Dunlap wrote:
> Fix these new build errors by adding <linux/irq.h>:
> 
> ../drivers/input/misc/soc_button_array.c: In function ‘soc_button_device_create’:
> ../drivers/input/misc/soc_button_array.c:156:4: error: implicit declaration of function ‘irq_set_irq_type’; did you mean ‘acpi_dev_get_irq_type’? [-Werror=implicit-function-declaration]
>     irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
>   CC [M]  drivers/rtc/rtc-ds1343.o
> ../drivers/input/misc/soc_button_array.c:156:26: error: ‘IRQ_TYPE_LEVEL_LOW’ undeclared (first use in this function)
>     irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
> 
> Fixes: 78a5b53e9fb4 ("Input: soc_button_array - work around DSDTs which modify the irqflags")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org

Thank you for your fix, but Dmitry already send out the same fix
yesterday, so your fix is a duplicate.

Regards,

Hans



> ---
>  drivers/input/misc/soc_button_array.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20201123.orig/drivers/input/misc/soc_button_array.c
> +++ linux-next-20201123/drivers/input/misc/soc_button_array.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/input.h>
>  #include <linux/init.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> 

