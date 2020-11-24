Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972382C2341
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbgKXKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgKXKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:48:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE00C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:48:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so2389203wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKUHQucYeb31HOoREAkeI7Xr3ONZ6GpyN2wdl6mhvTE=;
        b=o+OCt6pPEtBp5sG9QBlJlxOlGwBf9AHPWZYEk4c7X6VYcrTixfHQQJ4Wu9kfNihKoD
         6q/QauNDpLX48kzcTChcZJ9dQt/QMcRuoWv3xKg/Pkto2sbkNiAOUuA7ImAncN6Z1r/Z
         Q0qGW2sLi8rYUnpPrXaLc8uV2UnpsRg3qhU6oushflRiEuJQX/+D4g8bpNEjxb7ViBQK
         imQoXnExp88Bid1lhoSl5EQfYPnlkGp+nXSKCKH5roJ7eq2rwjyFZMA/8ApqCFhSJXok
         V5I4qMlVt65Mnv89o1ATv1H6JF97Lv3/QZ82AUYYdZjVqgyvpbVVazFS4CfP/MSmw27t
         BCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKUHQucYeb31HOoREAkeI7Xr3ONZ6GpyN2wdl6mhvTE=;
        b=Ne32j/P10Y7CUmLeILc2NQpCOx5yZCMhgDBocAhMXIRycLOU1RLq8UGk7HRRnbJbIM
         2ZGYLZ1f7lmc4sNBu/MSrt+GllVGUJi5rLNCeJr/f+GszZJEFNIRTRHsuoSl4nHZkYvp
         7NW107bC7E8XksKFChT+u5q5hp0cg6uSmPTEAtsGaYf4MMQD2sBc9C69mSGDB1iYzncf
         1RvKQHNsoauvdptnVWwGlZo3hrUQ33cjDLH+X4j5lkvNWVjfh+LYhzRvi6vdy7Kr5PVm
         Ds/qnhg2lJ+n4XGQc3sI+iAxQhsdl10rxds7itTViT2/CAvvwX3850BaCuAUCE2/T672
         p+5w==
X-Gm-Message-State: AOAM533kor82SmPGwgLh7wI3lWbAqn92LQ84nDi+DQBMZlZ55XUNXKBr
        qq7FSXSKp48uhoC9d0GfMmKykELMBX7vrAmV
X-Google-Smtp-Source: ABdhPJxW9BitmnI8OPwhFe6AWn0n6S/KopfpYJQ+7H/0nejHyup9DFlc3ZwLIY+7GWtngQ1AqVs7lw==
X-Received: by 2002:a05:600c:2886:: with SMTP id g6mr3790149wmd.110.1606214885516;
        Tue, 24 Nov 2020 02:48:05 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e6sm4810310wme.27.2020.11.24.02.48.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:48:04 -0800 (PST)
Subject: Re: [PATCH 126/141] slimbus: messaging: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <794916c9-30fb-1202-ec26-9abf750886dc@linaro.org>
Date:   Tue, 24 Nov 2020 10:48:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2020 18:39, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---


Applied thanks,

srini

>   drivers/slimbus/messaging.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
> index d5879142dbef..f2b5d347d227 100644
> --- a/drivers/slimbus/messaging.c
> +++ b/drivers/slimbus/messaging.c
> @@ -258,6 +258,7 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
>   	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
>   	case SLIM_MSG_MC_CLEAR_INFORMATION:
>   		txn->rl += msg->num_bytes;
> +		break;
>   	default:
>   		break;
>   	}
> 
