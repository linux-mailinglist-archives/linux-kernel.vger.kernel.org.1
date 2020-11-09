Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6392ABDCC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgKINuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKINuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604929806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLsp/KuWTDbrVBv5ybtaH5oT3koUPcBqYT/mOxOLceQ=;
        b=AfD32ZcTAV7vsq0RkMi7YRaz+YNyxtU2BtuKTh8FlyK01szEIQS7pSt3HK+TOkowK5JMfB
        +6pxFNAk8SIMIpQphSiTmdzAjvwLiszYgjJlkX08Ahi6FVaLqwskB2xFqE2Q+Rd6SPGAL/
        HRQJ5T14vRTOTCD+v0a8FoEbsrs5H4s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-QfWorUanPPGxBfQQIghU2Q-1; Mon, 09 Nov 2020 08:50:04 -0500
X-MC-Unique: QfWorUanPPGxBfQQIghU2Q-1
Received: by mail-ed1-f70.google.com with SMTP id c2so2724927edw.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 05:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLsp/KuWTDbrVBv5ybtaH5oT3koUPcBqYT/mOxOLceQ=;
        b=aHydnMg+N0XDwJ+/loCCQkGIH6oqOKrr28e/zVLsGH67+qA9BjAn8bkxzCy8cEK7l6
         r81im/b7O4VU+jixDt55a4x6U82dmT9ltWD3ki81k2gUsHG4TOZTgL9iNJAwm76eTeqM
         f+75krbfh+oldJ0ay1NsTX3Z6OIj3zIRoVnjW3ifqtnI/TbmPu/LFP7Msgec47FPQGO7
         7bAZDN3KCqAEoGAOkUbQPFaO/FIhdG1D+1PaamXPib2sW/UxaNtDFPwAeyPUS1NRIn+i
         mRGeV7pylFOlseKwrlJS7y9Fd2gh9k+x1V/TWJOf79wIHGRSXu8l+EZJeIjINlqsyqd7
         JTBQ==
X-Gm-Message-State: AOAM532I0aif4UquSXj0DeaYXclYcxAUPABRnxy2HqOAcqTBNpgFgOQv
        qWEc8axt05BYEB9n0X4gg76bXj1gkw9yb49uMJR5ZIF7+7q81xaRmJh21RXaJojI2MUmNtLfbtb
        GgkIcBbnE+GjKqK+x5GC+oD3I
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr15753283ejb.75.1604929802355;
        Mon, 09 Nov 2020 05:50:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG5clFDtGgr1oPP2mVomKl27liMRXknZE3eR/J1H9KeINk4KWFWJqQ2n3Bapo3TKqzD5Axdw==
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr15753268ejb.75.1604929802203;
        Mon, 09 Nov 2020 05:50:02 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id k23sm8760275ejs.100.2020.11.09.05.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 05:50:01 -0800 (PST)
Subject: Re: [PATCH v3 1/4] pinctrl: amd: fix incorrect way to disable
 debounce filter
To:     Coiby Xu <coiby.xu@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20201105231912.69527-1-coiby.xu@gmail.com>
 <20201105231912.69527-2-coiby.xu@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce36bc69-56ae-1c22-68b6-44f788275dab@redhat.com>
Date:   Mon, 9 Nov 2020 14:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105231912.69527-2-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/6/20 12:19 AM, Coiby Xu wrote:
> The correct way to disable debounce filter is to clear bit 5 and 6
> of the register.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/linux-gpio/df2c008b-e7b5-4fdd-42ea-4d1c62b52139@redhat.com/
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/pinctrl/pinctrl-amd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 9a760f5cd7ed..d6b2b4bd337c 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -166,14 +166,14 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
>  			pin_reg |= BIT(DB_TMR_OUT_UNIT_OFF);
>  			pin_reg |= BIT(DB_TMR_LARGE_OFF);
>  		} else {
> -			pin_reg &= ~DB_CNTRl_MASK;
> +			pin_reg &= ~(DB_CNTRl_MASK << DB_CNTRL_OFF);
>  			ret = -EINVAL;
>  		}
>  	} else {
>  		pin_reg &= ~BIT(DB_TMR_OUT_UNIT_OFF);
>  		pin_reg &= ~BIT(DB_TMR_LARGE_OFF);
>  		pin_reg &= ~DB_TMR_OUT_MASK;
> -		pin_reg &= ~DB_CNTRl_MASK;
> +		pin_reg &= ~(DB_CNTRl_MASK << DB_CNTRL_OFF);
>  	}
>  	writel(pin_reg, gpio_dev->base + offset * 4);
>  	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> 

