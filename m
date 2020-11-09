Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3D2ABDD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgKINua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbgKINu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604929828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/EtuAL0DW0yQ0sKWLRmexkWbHk+ugtdmP7wkgc1RY/E=;
        b=gw9SVaJOZrkB5mvcVjKVB3yuwJqrXCAYA8SiSvwMRWieh7+TYzs79O0nS27WvLSiceql8J
        HeKj3fSuRW9UruKBrOzmwhBPpxCrOclSNABrhdcVbAp5dSC8eGr8FwWc3vJedJIczZpsAt
        PKA50fOaU/5nO7EdBKlTkZXeHAGqpJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-3pzhzyVgPzSlZdzyyYFb_Q-1; Mon, 09 Nov 2020 08:50:26 -0500
X-MC-Unique: 3pzhzyVgPzSlZdzyyYFb_Q-1
Received: by mail-ej1-f72.google.com with SMTP id dx19so3421468ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 05:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/EtuAL0DW0yQ0sKWLRmexkWbHk+ugtdmP7wkgc1RY/E=;
        b=mciMjIn4lkh4AAElCxhenBa+5kTLmc2xggxM3vmVfp1OF0yJV0OJwslwcEIb/25SpL
         l2BrLSdJDRJA4GZH+fAQwRLoN1TrJg5271rQiHp5oaqL26LZnJ24y+QRHixAs7akivfd
         DYyuUT9TMc9DOPvlkcN8cwErJFun8v4Bx2SizXtgY7Bw/0bYMM4ripjsT1QvruxEszwG
         vCSq8YFREThmcq2RVST8ovzpWTjXGEmoC1785ftpnXRXBF3pZ2BeRT/7IKm59pQMlEAT
         /gPuD4EooitFraVdRxiQ3MU2dt3XXPiifObCWbEGL29fyef6F6j+yuCxHQ2arpMZ4SS5
         z8aQ==
X-Gm-Message-State: AOAM533OzcqVLv6huXE4rtAn3DF56TURBeFk85VwXuBbxqpxWnfup/ZZ
        qqZbngddKr0r60W+1+qi+643rPgQONALrYNS4MaZHCk8CYN8WhquSARB4eGoDVt6nlK24N2CoRD
        039BOxN4f41Tm0hn9P177pk97
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr14908273ejb.124.1604929825319;
        Mon, 09 Nov 2020 05:50:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqFYTcFE9l0Y5GmFK/bTLolkfqk+dJxdn41F8jx4XCj6EWeIPqttTwNBTaCkg8ILP2xBOySw==
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr14908254ejb.124.1604929825051;
        Mon, 09 Nov 2020 05:50:25 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id qx6sm5586775ejb.10.2020.11.09.05.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 05:50:24 -0800 (PST)
Subject: Re: [PATCH v3 2/4] pinctrl: amd: use higher precision for 512 RtcClk
To:     Coiby Xu <coiby.xu@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20201105231912.69527-1-coiby.xu@gmail.com>
 <20201105231912.69527-3-coiby.xu@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0268d6cb-6516-251a-9b26-47c5e94eedc9@redhat.com>
Date:   Mon, 9 Nov 2020 14:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105231912.69527-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/6/20 12:19 AM, Coiby Xu wrote:
> RTC is 32.768kHz thus 512 RtcClk equals 15625 usec. The documentation
> likely has dropped precision and that's why the driver mistakenly took
> the slightly deviated value.
> 
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link: https://lore.kernel.org/linux-gpio/2f4706a1-502f-75f0-9596-cc25b4933b6c@redhat.com/
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/pinctrl/pinctrl-amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index d6b2b4bd337c..4aea3e05e8c6 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -156,7 +156,7 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
>  			pin_reg |= BIT(DB_TMR_OUT_UNIT_OFF);
>  			pin_reg &= ~BIT(DB_TMR_LARGE_OFF);
>  		} else if (debounce < 250000) {
> -			time = debounce / 15600;
> +			time = debounce / 15625;
>  			pin_reg |= time & DB_TMR_OUT_MASK;
>  			pin_reg &= ~BIT(DB_TMR_OUT_UNIT_OFF);
>  			pin_reg |= BIT(DB_TMR_LARGE_OFF);
> 

