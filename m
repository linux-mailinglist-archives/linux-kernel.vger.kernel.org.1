Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE562725A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgIUNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:34:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726830AbgIUNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600695244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0HOfDTf0Hc7be4wHcgGqRMOsK0L7kOAKRk7B9r832E=;
        b=LE4vpubGB1v1RUNFHz9wKPYQc46vDy4E7Jr1Pjf4dHpaq88Wm/0YaMOrjEhFcQXaO3bg1g
        IOeYPaG/k2lOoqX8YJD7i7DEiQpAy9cpmAW5SQCJPdhiT83/5bvmtdH0j6OMcpUzkW1p2H
        VE1T6oky9T3uMxWqKr4AVzsjxRvstXA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-JbTs4QMxNcS5U54aQm8iug-1; Mon, 21 Sep 2020 09:34:02 -0400
X-MC-Unique: JbTs4QMxNcS5U54aQm8iug-1
Received: by mail-ej1-f70.google.com with SMTP id li24so4864962ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0HOfDTf0Hc7be4wHcgGqRMOsK0L7kOAKRk7B9r832E=;
        b=nIt9J3XrTfWlCkoETSLOL5XTCVkP7dV5BEfjiyhlxDY760pj1WhisIPAlYh4ETu/63
         U1fu/6hKWEdFkk25O80TWyMwIoyLEBR1wu2r6Yby73QG4YUCIIcfd+sCbZPdJBm7y/Dz
         BlVzM6CHUSiBmzcFBVMSClANcuwtxyePGWunTdFWoVfKlHzOPxGozLewAKuk1RAbtsG3
         thoSPvGRbFeWnHuwaTZ8/Lgp/YMiLKm3kuG//b1jxhVt9kaqLcM6ARfjcPPI2q6iTyqk
         1GDSr+Z1w8xC6VJvrnc3ttIUXXnk6un1lAerlgkiKOgrz0TywttZy6E0CJkhGTto+XFd
         zbvw==
X-Gm-Message-State: AOAM532Ooy9seHAv/Suih263pz/76Tv5l/9bgxTk6ZkYQnWl85NJ2pRS
        4KHO4u+8i1ZlMdVxbsLwMAjWPVGR22IAY7nRFkFjzknikksAEznsoEbDSwDVSvPiCVNkMi3/Bd8
        sX0gY8BWHzINJM/ol2SqhdzVs
X-Received: by 2002:a17:906:a00c:: with SMTP id p12mr48474684ejy.10.1600695240831;
        Mon, 21 Sep 2020 06:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEbNkjEWDevemWKnY1PzrnQJTYPE6HudCcKEVIsFSbAf7fZ49PyMwEaYKYfz+t43uEViO4DA==
X-Received: by 2002:a17:906:a00c:: with SMTP id p12mr48474673ejy.10.1600695240620;
        Mon, 21 Sep 2020 06:34:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r9sm8661365ejc.102.2020.09.21.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 06:34:00 -0700 (PDT)
Subject: Re: [PATCH -next] virt: vbox: simplify the return expression of
 vbg_input_open()
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200921131113.93459-1-miaoqinglang@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7cced541-88ab-bb21-6fc4-e6c06d2d2260@redhat.com>
Date:   Mon, 21 Sep 2020 15:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921131113.93459-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 3:11 PM, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Thank you, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/virt/vboxguest/vboxguest_linux.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 6215a688e..73eb34849 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -202,13 +202,8 @@ static int vbg_input_open(struct input_dev *input)
>   {
>   	struct vbg_dev *gdev = input_get_drvdata(input);
>   	u32 feat = VMMDEV_MOUSE_GUEST_CAN_ABSOLUTE | VMMDEV_MOUSE_NEW_PROTOCOL;
> -	int ret;
>   
> -	ret = vbg_core_set_mouse_status(gdev, feat);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return vbg_core_set_mouse_status(gdev, feat);
>   }
>   
>   /**
> 

