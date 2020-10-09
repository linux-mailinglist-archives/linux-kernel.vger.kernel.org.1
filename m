Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0439288EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbgJIQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:24:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E289CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:24:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so7549353pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Jur5Bq54qriS0f641DZfn/1aFXoa3qoJ8oSWG2dKR9E=;
        b=KnTl2YiXqu6kxvV/SiXf71ElLRsPogVU0Nuxn4Iw9xjXknnLTXVMrXCiB4Icr4tKGS
         JxfB6gZAlefX7i66UCihpRBYz8xN0MjCD0AitIgSpibXrwzwVh1cqhRv3wIEdJ0mPMiC
         636xzIVwXFe/ViO0wd0KQayuzDGmYK9d6oSkva474NyQXRI1drMIMYGPc+IycmiNxKPN
         /d69sbKv/H6LJQH/igU/8ptOlIzHapHD3B3WtaVW31rKW/r2J8dXI91eM5UfSzc9+29S
         KSxPDaQ0YEc3t8Vlo5Gz8NFrF2aanuoOHwl/3Fu56nfcu6oL4iSifVIKJzhQknJj4K4G
         5rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Jur5Bq54qriS0f641DZfn/1aFXoa3qoJ8oSWG2dKR9E=;
        b=JmbVd71cCSzFaoMD9HkhUaLT45lgZi4ig1L0if9A3QSnGOTPwg4BAIPhReAsdiRYTo
         HZXEhsZ/rd9O8N4rM6Wma9w/NcjkXPX+IidpCd4zr/VZQWvynztQ9T+CzZSc3VZm13xR
         InvYizQwQAodCkz0+jOfhRKKWD+UURY5QFIzEBtQDUg8bQw9YqdCbZoIJGeVfeacwzhV
         YOxSfHow4b24g1Djl1C3N5kelzORz7fGVxCjLN0hS4KsqDgGrIpOGDyyjdPRCXcldGfi
         Ub7sOnWlCuGQWtY9KH1E3vO2OniQ33VUCvFvaJeGPv073Pf95+1b8FF+Cvr7KrQmBRO9
         NFtA==
X-Gm-Message-State: AOAM530tPgn1iuHtr7stW2NECEyruM5fZscL8z5kkDTW8ARe+0iyyiSg
        Kvrc5ugc+WTdBRVR/v2Ia5qd1jKSNhzltpHD30c=
X-Google-Smtp-Source: ABdhPJwX59dsYqV7LKdMHJ+iopNl3ggAeS1pu/x2L71uhzAnMQYFAiF2RMg5h9sMWuU5mLbFJF4Pvg==
X-Received: by 2002:a17:90a:1861:: with SMTP id r88mr5359154pja.222.1602260692871;
        Fri, 09 Oct 2020 09:24:52 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.205.113])
        by smtp.gmail.com with ESMTPSA id o134sm11231313pfg.134.2020.10.09.09.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 09:24:52 -0700 (PDT)
Subject: Re: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb
 endpoints found
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20201009161646.286286-1-anant.thazhemadam@gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <21e614cc-abf7-9332-81be-c969b0fd29b6@gmail.com>
Date:   Fri, 9 Oct 2020 21:54:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009161646.286286-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/10/20 9:46 pm, Anant Thazhemadam wrote:
> While finding usb endpoints in vmk80xx_find_usb_endpoints(), check if 
> wMaxPacketSize = 0 for the endpoints found.
>
> Some devices have isochronous endpoints that have wMaxPacketSize = 0
> (as required by the USB-2 spec).
> However, since this doesn't apply here, wMaxPacketSize = 0 can be
> considered to be invalid.
>
> Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
> Tested-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> The error (as detected by syzbot) is generated in 
> vmk80xx_write_packet() (which is called in vmk80xx_reset_device()) when
> it tries to assign devpriv->usb_tx_buf[0] = cmd.
>
> This NULL pointer dereference issue arises because
> size = usb_endpoint_maxp(devpriv->ep_tx) = 0.
>
> This can be traced back to vmk80xx_find_usb_endpoints(), where the usb 
> endpoints are found, and assigned accordingly.
> (For some more insight, in vmk80xx_find_usb_endpoints(), 
> if one of intf->cur_altsetting->iface_desc->endpoints' desc value = 0, 
> and consequently this endpoint is assigned to devpriv->ep_tx,
> this issue gets triggered.)
>
> Checking if the wMaxPacketSize of an endpoint is invalid and returning
> an error value accordingly, seems to fix the error.
>
> We could also alternatively perform this checking (if the size is 0 or not) 
> in vmk80xx_reset_device() itself, but it only seemed like covering up the issue
> at that place, rather than fixing it, so I wasn't sure that was any better.
>
> However, if I'm not wrong, this might end up causing the probe to fail, and I'm 
> not sure if that's the right thing to do in cases like this, and if it isn't I'd
> like some input on what exactly is the required course of action in cases like this.
>
>  drivers/staging/comedi/drivers/vmk80xx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
> index 65dc6c51037e..cb0a965d3c37 100644
> --- a/drivers/staging/comedi/drivers/vmk80xx.c
> +++ b/drivers/staging/comedi/drivers/vmk80xx.c
> @@ -667,6 +667,9 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
>  	if (!devpriv->ep_rx || !devpriv->ep_tx)
>  		return -ENODEV;
>  
> +	if(!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  

The patch in this mail has a coding style issue (that I thought I had fixed), and was sent out by
mistake.
Please ignore this mail. Apologies.

Thanks,
Anant
