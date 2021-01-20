Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB12FD39C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390870AbhATPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390952AbhATPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611155027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLkTnoEhhqT5XnK+V0Ri+zXEP8mtFMltsuZRc1io4Mo=;
        b=C9Msq6DDbsdV64K16bJvg511xxqMo6cHXVeRzmGGBspEKlpi9eUbh8VjwUVS+0iz9kbFXU
        AIXZIZeIkfsYOD29bNYAHwl1+/bk4DV8c5uu7RpJphWIAl+KLexE+qX2gQcwcNkYO8N6LO
        BMYSiPh2NvAGTjoLiPEaPeST7Ad2p/8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-Weohq2IHOnuC9yT6b7e1AA-1; Wed, 20 Jan 2021 10:03:45 -0500
X-MC-Unique: Weohq2IHOnuC9yT6b7e1AA-1
Received: by mail-qt1-f200.google.com with SMTP id e9so12758953qtq.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DLkTnoEhhqT5XnK+V0Ri+zXEP8mtFMltsuZRc1io4Mo=;
        b=GItZRVsshQqMUeLNu03e3NC8hD3oUswCLdEH8SFxVIHHjpsU1uuJV1A9LyclChhsAf
         qa2ZF9ipw9/YRq//CRfmhwz077d4rfXmtGmLFbCBRYAjLZSY+ENeZvQoZZgCRXI4Z6nY
         SB3CkLUw8tLM7pC/2WytJBOE0VX2ulfIO64oGdPHYtOiUtXZtsy6UjcRlZy9LRaIZJ5G
         J/+aOWMYvNDN0aVcmKe83ZC6XN1wi3byUmCr37Aa7o1U8yElM/wbjszXyc7C5wXJ276V
         C9ZpG82K2+JVAe34aRczbQD0WIlU3TzdAToFzklhZfzdSOFapyfpv1EIh+1kmSTQKalg
         wjIA==
X-Gm-Message-State: AOAM533N3YxM22jpwPGEWHZ0ZoSvkWjYcp7DLKnFgxfuGFkPveF+ina2
        4P4om+RvFNPsrkg+Ytwviz4A+t/V1yGHV+S1o6buWvpHNbb0xs0fKQfRAgs/mlExq8jSpyfDmtR
        GnnRW4ydrpGMhu8Yx4xDKQSBODn8Q1xpJM7txdsj4EUpMN9a9o4p+GPLhxdM4MKDzztEVMbk=
X-Received: by 2002:a37:9f14:: with SMTP id i20mr9933244qke.321.1611155024881;
        Wed, 20 Jan 2021 07:03:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1NgZWfa0FoCcv72Jr91hrje7OB2eR1AjLOB6y9Mz3IUwCYNr1bPZ94I/AV1xVad9LFx/jWA==
X-Received: by 2002:a37:9f14:: with SMTP id i20mr9933207qke.321.1611155024575;
        Wed, 20 Jan 2021 07:03:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b78sm1477745qkg.29.2021.01.20.07.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:03:43 -0800 (PST)
Subject: Re: [PATCH] spi: altera: Fix memory leak on error path
To:     Pan Bian <bianpan2016@163.com>, Mark Brown <broonie@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210120082635.49304-1-bianpan2016@163.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <29bc2be2-911e-e892-4d1c-cc5c8ce10571@redhat.com>
Date:   Wed, 20 Jan 2021 07:03:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120082635.49304-1-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/21 12:26 AM, Pan Bian wrote:
> Release master that have been previously allocated if the number of
> chipselect is invalid.
>
> Fixes: 8e04187c1bc7 ("spi: altera: add SPI core parameters support via platform data.")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/spi/spi-altera.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
> index cbc4c28c1541..62ea0c9e321b 100644
> --- a/drivers/spi/spi-altera.c
> +++ b/drivers/spi/spi-altera.c
> @@ -254,7 +254,8 @@ static int altera_spi_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"Invalid number of chipselect: %hu\n",
>  				pdata->num_chipselect);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto exit;
>  		}
>  
>  		master->num_chipselect = pdata->num_chipselect;
Reviewed-by: Tom Rix <trix@redhat.com>

