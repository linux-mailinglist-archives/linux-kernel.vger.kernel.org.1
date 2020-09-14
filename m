Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C04268620
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgINHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:35:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20467 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbgINHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600068944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJI2uFsZnEF05hs89JJrdOjGHB7IMqEfWHkfD321xnQ=;
        b=fnpNib8iYmzTNFOCxxZ4LTfkGc+i00sV8vHl68KRHXQs3HwSkm7Uh9iSdqxTOhlvFkc9hA
        CV1hI8oxlW3UoPmotEcPe8fW+0ddz2OIN/mcQt9xalL0t7sPbT8yOs5l02O9Q9IEuqEtuc
        /19hdjdKJ4MykJfxqLoImxXdRSdABpA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-L0ShjI-LMpiGvtfguQMKjw-1; Mon, 14 Sep 2020 03:35:43 -0400
X-MC-Unique: L0ShjI-LMpiGvtfguQMKjw-1
Received: by mail-ej1-f70.google.com with SMTP id i14so7736700ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJI2uFsZnEF05hs89JJrdOjGHB7IMqEfWHkfD321xnQ=;
        b=UvT0QLvHxnyQ+q1eTmdiqlVm8/H7e/5/OsDL18AIPH9qah5ajqQ7HdHrV+uiNWLKqN
         DeN72Ux6SuCQTPvM+D88jkyjCanmrNNskmp3dK8emmgS0cQfnC7Dsfipu0m278wFHEKU
         ff1YjbP7hOakqJd0ukpuG7/TF5WFXZFaPPNSZpd3EGR3HT6SgdSVhUliufQOhzDSTGyq
         7Gbs8fcnrfh94hmwB9QpN5uwTbbHD6eoaW+sJiXByh13BMFMzY7c1annwFpTrBXSrHqK
         qFDcDmP8ZzHAQUdvx/BHB+pLSpkTjqn0DOAcyfyEkig6x123le21p8o29fd40hdJyWBy
         MdUg==
X-Gm-Message-State: AOAM530yuZ1X6awGLlpyeFTnEMi5ao6flNN+GbL80DPkT5096fDXy9cy
        CExnblSqGLM/YLsT/4VMHzIHcdwyJawB11SKHFRPjfOLQqf9sdu8hasgaG+tR0jhH6dqrfolBrm
        dAfb9tTMy7DGNlTKlTC324Rhj
X-Received: by 2002:a05:6402:1012:: with SMTP id c18mr15646647edu.77.1600068941656;
        Mon, 14 Sep 2020 00:35:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm4BFzVly8xy/VdoMv73ccB1dVYdZbAI+fyq4IuB0Dq7i2LeyO3/fyEaVcPmc3TqdpRbCFsA==
X-Received: by 2002:a05:6402:1012:: with SMTP id c18mr15646634edu.77.1600068941516;
        Mon, 14 Sep 2020 00:35:41 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id u23sm7082213ejc.108.2020.09.14.00.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 00:35:40 -0700 (PDT)
Subject: Re: [PATCH -next] extcon: axp288: use module_platform_driver to
 simplify the code
To:     Liu Shixin <liushixin2@huawei.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200914065400.3726302-1-liushixin2@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <085e3e4a-863c-39e4-6028-1d87fff70800@redhat.com>
Date:   Mon, 14 Sep 2020 09:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914065400.3726302-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/20 8:54 AM, Liu Shixin wrote:
> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thank you for the cleanup, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/extcon/extcon-axp288.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 525345367260..fdb31954cf2b 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -491,18 +491,7 @@ static struct platform_driver axp288_extcon_driver = {
>   		.pm = &axp288_extcon_pm_ops,
>   	},
>   };
> -
> -static int __init axp288_extcon_init(void)
> -{
> -	return platform_driver_register(&axp288_extcon_driver);
> -}
> -module_init(axp288_extcon_init);
> -
> -static void __exit axp288_extcon_exit(void)
> -{
> -	platform_driver_unregister(&axp288_extcon_driver);
> -}
> -module_exit(axp288_extcon_exit);
> +module_platform_driver(axp288_extcon_driver);
>   
>   MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
>   MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> 

