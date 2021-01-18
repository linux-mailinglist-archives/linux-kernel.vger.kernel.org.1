Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2882FA8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405470AbhARSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407540AbhARSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610994058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XLTOZpDzxwy3KhTnwZh01zwffGrl40DvZH48TFWH/A=;
        b=PRAqNPV851HIu8s4WSGWaS+Hib3PXR0osVrCOZZyVKVzN8US+nsykGpaPfbEJT4/lTz+L+
        Q1z+oEdwetswvDOouXP6weGcek1jzsTYOAnwcIxDeGRAbSTOTx2MN7L9m/p1H+NzZae7KC
        O07zsfCPZ25tKw1BtgCxkiuBsEESqn4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-DtGdwxi_N2OvrnOzF0MOtg-1; Mon, 18 Jan 2021 13:20:57 -0500
X-MC-Unique: DtGdwxi_N2OvrnOzF0MOtg-1
Received: by mail-ed1-f70.google.com with SMTP id g6so8179710edw.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XLTOZpDzxwy3KhTnwZh01zwffGrl40DvZH48TFWH/A=;
        b=pfBYmnIPNOtLJBZQAdiFYLr6Mz1zWRrza4vhJXwWdmvXHY+zeJXerBq75vIzi9Mg29
         bEcCgeKljeZinavdleDPy8Lmn5fL/3cRpOg9HGzERNzzsbkSJvNCifZox7MxJUkqXjFb
         BnSSoYbQvbRkoEqW9XuaLUPx2bB3CaUBnrccr17pZ8AAT1tfxs4Vud7W0aM6T+3TWg7j
         fD7zmzxSE653XDyCK8bHBEwVzHzRoT72LaRGbteGWCDF1FXRfrkESg0PPLS48gcFE2FM
         YrWOONSBO798RittmkZav12TbTvRYXf2N4dLiO4PCBDzP17d+NfnRQ4roTK9RAgORDWR
         jmTQ==
X-Gm-Message-State: AOAM533eIN1dr9xTpldLYz1ZvJKBJDMh0OdxJR/hsK7vzxBRKdTPzaSw
        00XlRMJjaFVpCZql17sIGEw7a5FxUIZCkVV86g5KqqwPK5ThfHna8pJYTy64emYhqL5GY2qju2n
        fQ9N0tRGiK9Hc/IW5VnXQ5Ge8
X-Received: by 2002:a17:906:944a:: with SMTP id z10mr620053ejx.96.1610994055930;
        Mon, 18 Jan 2021 10:20:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfhE9TJAExzYFs1vk0RoI31mts7Pw/Piku3pc7gvUuxX1645JFBmAzXTbo8hAg4hmFy7LLeg==
X-Received: by 2002:a17:906:944a:: with SMTP id z10mr620046ejx.96.1610994055741;
        Mon, 18 Jan 2021 10:20:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id dm6sm6305649ejc.32.2021.01.18.10.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:20:55 -0800 (PST)
Subject: Re: [PATCH v6 16/16] platform/surface: aggregator: fix a kernel-doc
 markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
 <4a6bf33cfbd06654d78294127f2b6d354d073089.1610610937.git.mchehab+huawei@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <151f5b83-fdac-72e6-604f-ed16444e685a@redhat.com>
Date:   Mon, 18 Jan 2021 19:20:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4a6bf33cfbd06654d78294127f2b6d354d073089.1610610937.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/14/21 9:04 AM, Mauro Carvalho Chehab wrote:
> A function has a different name between their prototype
> and its kernel-doc markup:
> 
> 	../drivers/platform/surface/aggregator/ssh_request_layer.c:1065: warning: expecting prototype for ssh_rtl_tx_start(). Prototype was for ssh_rtl_start() instead
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/surface/aggregator/ssh_request_layer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
> index bb1c862411a2..25db4d638cfa 100644
> --- a/drivers/platform/surface/aggregator/ssh_request_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
> @@ -1056,7 +1056,7 @@ void ssh_rtl_destroy(struct ssh_rtl *rtl)
>  }
>  
>  /**
> - * ssh_rtl_tx_start() - Start request transmitter and receiver.
> + * ssh_rtl_start() - Start request transmitter and receiver.
>   * @rtl: The request transport layer.
>   *
>   * Return: Returns zero on success, a negative error code on failure.
> 

