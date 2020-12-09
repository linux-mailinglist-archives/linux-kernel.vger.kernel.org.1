Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAD2D44F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbgLIO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:59:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730281AbgLIO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607525872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyvmSp+tD6zrj4k830kMV7NEPRw1NJvTV+d5JmE7hP4=;
        b=XmTKLTTFZU2IjC2YRbwDSSTim39pZ/pI74OZ/X/t0JwmhhDD+N1NDnXUP8n1bNb5/wJ6Zp
        m2OqHaY1rp3VwoITvOTpBg4FuM1ObxV86FXL2hLyyAKeQK4pC3cC6TpsESStokLNTqhw6l
        GaXj6RkOBv07Qp4wTU/xhk9baFiE8P8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-WSA46DYnOqWB6JTkXymYXw-1; Wed, 09 Dec 2020 09:57:50 -0500
X-MC-Unique: WSA46DYnOqWB6JTkXymYXw-1
Received: by mail-ej1-f71.google.com with SMTP id n17so598623eja.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 06:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hyvmSp+tD6zrj4k830kMV7NEPRw1NJvTV+d5JmE7hP4=;
        b=YSxYltn4jlFYpetmlaX9AVFhhLAWpaWgMfrGZ/s3/kaWspdpbdp2Y+VmTl2e4ZPnls
         uMl7TZwP8xSRCbFuorlCiVjfZ5YisbQBoIEEwuzgAeXjGpsXSKHqRJqF6vrq2X0fOUuy
         8MUm3XniB3J8ONcWdttNoGVlf2CcE4QG96ulfdTxrEYF/FcO4PmOfzZtHEcxniUH51XM
         oNPhQtdpQXM8gXHTRjRLCMblw67LBAXkI2ZOth7xtW9VviyOKrnviiiI8fXsl2d5PwoQ
         sN38kLNw8ZqDuMuf4KZHOkLd7hf7UzvwGMZfMVe3RrDkXd3QDXL7/mq/KtuskehMHfr0
         kaeQ==
X-Gm-Message-State: AOAM533AXLySxbXO95VU1KL0vFEGrVE+hxIw7WEr/6va85FcQaQeYQYR
        coxDVthBDkp74thpmKxpmMczwS5QFNIoar5d1x3wE4NMtLpExikfb3x0LpSm/hMggLCEBEOCAnT
        689Qesa+lPXHW0XvPDuf9iSmD
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr2460558ejj.515.1607525869018;
        Wed, 09 Dec 2020 06:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzttPIEq+aOcToeLeA6nbckf6Na4GwXDTNW8LKuIolx74j0K+upRkpOyKN7VeMgp9c2rMYbqQ==
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr2460550ejj.515.1607525868859;
        Wed, 09 Dec 2020 06:57:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k2sm1742353ejp.6.2020.12.09.06.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 06:57:48 -0800 (PST)
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add the ECS EF20EA to
 the blacklist
To:     Chris Chiu <chiu@endlessos.org>, sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org
References: <20201209045057.9509-1-chiu@endlessos.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d58351aa-14a9-2ea7-ee8b-946ba28a782e@redhat.com>
Date:   Wed, 9 Dec 2020 15:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209045057.9509-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/9/20 5:50 AM, Chris Chiu wrote:
> The ECS EF20EA laptop ships an AXP288 but it is actually using a
> different, separate FG chip for AC and battery monitoring. On this
> laptop we need to keep using the regular ACPI driver and disable the
> AXP288 FG to avoid reporting two batteries to userspace.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>
> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index 148eb8105803..a15c322c79ea 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -739,6 +739,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
>  		}
>  	},
> +	{
> +		/* ECS EF20 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
> +		},
> +	},
>  	{}
>  };

The axp288_fuel_gauge_blacklist already has the following entry:

        {
                /* ECS EF20EA */
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
                },
        },

So is this real entry really necessary? The existing entry
matches the quirk for this in drivers/acpi/battery.c:

        {
                /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
                .callback = battery_do_not_check_pmic_quirk,
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
                },
        },

And the one in drivers/acpi/ac.c:

        {
                /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
                .callback = ac_do_not_check_pmic_quirk,
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
                },
        },

So I don't think that this patch is necessary...

Regards,

Hans


