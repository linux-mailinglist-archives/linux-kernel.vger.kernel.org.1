Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256922A452D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgKCMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgKCMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:31:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69EC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 04:31:10 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so7788015wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 04:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SRAmPKxls/K0himBvhIafEeFLCy40iv3c8xY8MMo+5w=;
        b=yjlArQ+/J50s8bIT0wWu8ypN/BiUQy/0+HvAGiCuMVkbaqvaSDd56btEbJhVTNue94
         i8bRRJPnnW5vW8eX3/xpmb/SGRR9BXDYVZlRDRDfW5e7PsDIS6z1O08UVwqkgpVdPHse
         7UoNPwi9PIENXvUZOgMg7UAtWR/uOugicg9LN9i+7BgyZnWdCe8mR+BdnRPQA2oB7Cdv
         egfkGDNHwfZpKPIqjejyKWcgsZXxQd+V78kjkdpUcUj3/glvtuR+/9VyVb0H0idJr6jp
         s9acSbE0kns1kq7v9JPZ+jid6bnXMp5ctt7NG6l1t4437v47zkT+deT2tzrc2VMBa0bv
         s5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SRAmPKxls/K0himBvhIafEeFLCy40iv3c8xY8MMo+5w=;
        b=Qt1pPo5HX9nFz/f+WoI4tJV3obVtSnBx0em1x6QDCiC8vhtymzG8VZd3cWRA7dHMIJ
         VDYJ2mKtpR/a2TbIKRG8rfSdCBoYR+ozADFcsmaituW3EZGeSIzu6ws5dLDHSEU249cY
         d7HSTeYYJeg/yBxIEhMalo8a4u4R2R8kAhoPpNW9lTokCPlERnuk4MxfQX05EjZgOVIO
         tPQNHEDeYr7FrDtfPeYHV6kBrUjonHwgM1Crn1BDSk8n6z+samuJZwRaYWddiw+rRQVf
         FWth0siC9787r7EB1Dh8qBuWhLi7adQmHQ+uokbu85xTd9CZKugZ4wAabuEJL1R7aog/
         FKHA==
X-Gm-Message-State: AOAM5330YnyEXHcctd/ZhfrB+DQ8zlY5KRfaOqc2JYWMkyay+B5Ngycn
        uv6H65uNL1ptzKtan4P5gQHhOtCEsQKsCYcm
X-Google-Smtp-Source: ABdhPJxmdWrGxJTWPWlxq/H1sagdyoraNtXp2WgDsGGI6NFdA8DHbZBmEeFowvqfv4vpnp14CFZODg==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3384462wmq.30.1604406668793;
        Tue, 03 Nov 2020 04:31:08 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id t4sm2769160wmb.20.2020.11.03.04.31.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 04:31:08 -0800 (PST)
Subject: Re: [PATCH] ASoC: wcd9335: remove unneeded semicolon
To:     trix@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201101172128.2305539-1-trix@redhat.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cfedaa82-d61c-0bc5-a960-991fbe5b7449@linaro.org>
Date:   Tue, 3 Nov 2020 12:31:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201101172128.2305539-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch,

On 01/11/2020 17:21, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/wcd-clsh-v2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
> index 817d8259758c..73258e292e7e 100644
> --- a/sound/soc/codecs/wcd-clsh-v2.c
> +++ b/sound/soc/codecs/wcd-clsh-v2.c
> @@ -507,7 +507,7 @@ static bool wcd_clsh_is_state_valid(int state)
>   		return true;
>   	default:
>   		return false;
> -	};
> +	}
>   }
>   
>   /*
> 
