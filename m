Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB829CAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832087AbgJ0VJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:09:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35761 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411855AbgJ0VJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:09:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id w191so2797456oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IyeUUlifhfZxzl2tT4e9734IrQJyyl3i93GsvUKGcEw=;
        b=GiBT7+ON30FfoAOLKQ53SgUHxMqtECM6jHWF5pFGimGhlxjx3XCHV3Y2yVx2GW/+q9
         q2dBl9oBF4Na/wAkamYeYMAVeIctFqnbCmibXbdeEZEF/TUXmyNxtvdIzdALICpDDVta
         teMmZaP/O+Uzc+GYrCjCEXMKlHPz+paOMdtsBtWa9uQDcFhSXLCEdF+3xgKoKr7Bd8pv
         R3yHorYr5TZnacKiYd0f5K82Ea/N6H9CEigO4em0MjcldsOxrjC9m2DgJMoD/rwlX02T
         0nGeOhvA6x/MK2dES467jSGPjVxyx2KEAWpN93LCFcYxQ75hcA2sc4ub6VO1goVRSfwl
         tKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=IyeUUlifhfZxzl2tT4e9734IrQJyyl3i93GsvUKGcEw=;
        b=rbg18bupqWZXPxHc4TtNEsjX2WgJnlKUnLwanI+zHSpP1XKZI7RbhUAnh5qp9yxNQh
         zkRpCweiVyVz3X6pCpqI5kXfhe3Lbl77p+/QKLGKich1ySntvFaaB1e7aK4AUGvNIBpz
         NV2J+fBEYcHDcMxHjBhsttlzd+eeg3uPZSHg4/c+jdEAZV5H+eNMBezDg3mDELETUHWT
         UiXU0XJlds+nJxEVDcoPnwbnLPIM2YPmZmvHYcmC7eNaRhoc4GCI8AEncKFMYzMTk708
         GKnd37vLwHq+aA0tz6iJCRvur0VOIfYA8YgX7QlaFR839dIeetuwfc91MqDqUCHwpmVi
         5dVg==
X-Gm-Message-State: AOAM533p+ASB7gw5lBQWic0PvRHyQUN4EtDaTi4xJipem1bcCUWhkeXn
        pEB9y6Gyu69aqvRrZqHHa+gLMv9DPykl
X-Google-Smtp-Source: ABdhPJyMkVlmKLcg/Xv0n4DztP+V7NTTeLWFOeh8RcBXAiSm6PPMkNn+hEa+Q4YUyTFwT4XqJDVxyQ==
X-Received: by 2002:aca:e186:: with SMTP id y128mr2796940oig.25.1603832945949;
        Tue, 27 Oct 2020 14:09:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id f124sm1938131oia.27.2020.10.27.14.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 14:09:05 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:64b8:c481:9aa8:415f])
        by serve.minyard.net (Postfix) with ESMTPSA id 1E1BD180057;
        Tue, 27 Oct 2020 21:09:04 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:09:02 -0500
From:   Corey Minyard <minyard@acm.org>
To:     trix@redhat.com
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ipmi: remove unneeded break
Message-ID: <20201027210902.GN4296@minyard.net>
Reply-To: minyard@acm.org
References: <20201019194805.14996-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019194805.14996-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:48:05PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return

Ok, it's in my next tree.

Thanks,

-corey

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/char/ipmi/ipmi_devintf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
> index f7b1c004a12b..3dd1d5abb298 100644
> --- a/drivers/char/ipmi/ipmi_devintf.c
> +++ b/drivers/char/ipmi/ipmi_devintf.c
> @@ -490,7 +490,6 @@ static long ipmi_ioctl(struct file   *file,
>  		}
>  
>  		return ipmi_set_my_address(priv->user, val.channel, val.value);
> -		break;
>  	}
>  
>  	case IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD:
> -- 
> 2.18.1
> 
