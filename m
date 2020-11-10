Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14B2ADAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgKJPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgKJPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:53:49 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6AC0613CF;
        Tue, 10 Nov 2020 07:53:49 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so14849282lfq.10;
        Tue, 10 Nov 2020 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HutTL2yDfi5mMGTQ3OtCrJfdNRa/4rsuGjEucYDrf2E=;
        b=M5jMhYCM6CM7KngDoyEwK88DSngFpAXyFZV8+EOZc0ZVdqBKvL09cbOem7kRJR2Hcq
         WIu04WEkLCYhENggvwaGwPUH89Vm6L0nVwBlqn6ihPDAW4Dtd/HDnbhDMH2dj6UN+gzD
         fzFoMj5d/bsqW8Z6WFOA6TIFtJ4wJugEEyx7dL+/XbRcYO4nTsJPnHOAwUqYbvMNRUVi
         d2mlfcrCoodWL5NaGZtcrz25tUUueJ1fDNYmzcFmdfhhuDQIG0J59i/QgF/saJ4P9/y+
         3U+hdvS5Q4HrfMQRXdkkwWs3FG1KsAUHSUC6+9MzYJ8YujCuHD58vNR6zYx9foJouyaG
         r2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HutTL2yDfi5mMGTQ3OtCrJfdNRa/4rsuGjEucYDrf2E=;
        b=uZqEb34nWGo0scUwzbi7zE4KlyYdNZKMf8WwjEyEDq2HEBCNf+N9zpli9pe/zhTE0w
         GpzwvffSsL5AkzCh4rh5imcGJQV6cQRrpDCE7Ub6cHoZciqJxy7SeYm+Tx96W8Z4zyOs
         +nLic40NsW/egbNu4ueysdJu2JeF9GmN6YOWrTbasE3IfA5bpZMARkru+b5pkjXdiESR
         5U3n4Laxj1ZMW6ZHT+AaW/xFf+R3LD83UjRX9PKaH8rhSj7aUgvEND7HbLurBvdxVwYE
         nqRRILF8IKi1j5i1LCHMMBAz4Fub4q5cyN/Yo0AollO18O+HZKXPcgiWk7AeZb5ZPckV
         nBoQ==
X-Gm-Message-State: AOAM531al+IGXgXAu9mHBG9OZoP0ltjU8w4PMcGWAYK1hGTvOX2C2e9W
        qMxhtpRiHJ1lz81o4uRlpHEjdgKzIt4=
X-Google-Smtp-Source: ABdhPJzgkJRisNvY6REtk2YE4TnlpghR5ec37yzLGW/3V1WzMDMSHE/iYsSlbdoYHruyzp0lYrxiYg==
X-Received: by 2002:a19:8a84:: with SMTP id m126mr7234847lfd.377.1605023627545;
        Tue, 10 Nov 2020 07:53:47 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:698:6e6f:38ff:8cb2:392a:a9da? ([2a00:1fa0:698:6e6f:38ff:8cb2:392a:a9da])
        by smtp.gmail.com with ESMTPSA id u25sm2142290lfo.198.2020.11.10.07.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 07:53:47 -0800 (PST)
Subject: Re: [PATCH resend2] sh/intc: Restore devm_ioremap() alignment
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201110154939.3285928-1-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <370e55e9-afe7-1392-4816-3734d04351fb@gmail.com>
Date:   Tue, 10 Nov 2020 18:53:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110154939.3285928-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/10/20 6:49 PM, Geert Uytterhoeven wrote:

> Restore alignment of the continuation of the devm_ioremap() call in

   It's a plain ioremap() call below, isn't it, :-)

> register_intc_controller().
> 
> Fixes: 4bdc0d676a643140 ("remove ioremap_nocache and devm_ioremap_nocache")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/sh/intc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index f8e070d67fa3266d..a14684ffe4c1a8ef 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -214,7 +214,7 @@ int __init register_intc_controller(struct intc_desc *desc)
>  			d->window[k].phys = res->start;
>  			d->window[k].size = resource_size(res);
>  			d->window[k].virt = ioremap(res->start,
> -							 resource_size(res));
> +						    resource_size(res));
>  			if (!d->window[k].virt)
>  				goto err2;
>  		}

MBR, Sergei
