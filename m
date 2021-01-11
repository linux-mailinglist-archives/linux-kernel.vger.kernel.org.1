Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E836D2F22CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390390AbhAKWcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbhAKWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:32:20 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D9C061786;
        Mon, 11 Jan 2021 14:31:40 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n4so179733iow.12;
        Mon, 11 Jan 2021 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJiGeL12qVsCRUCe1lSR40nZvYZ5aasMv5chEjqP8tY=;
        b=AwG8oJ/+8ySUoO9yyvHGbs69GskYMv3dGfA+4ZnFAQhXBE9wzvn2wpAHeHyH1oQn8v
         vXNwFq+/TBUjs4vyE27LYBVN2aCqEoNd8CWpLPK7vHY3mGuMxZQ6v/XvEBNZpc7U0FNJ
         wkuKHQ6wkFOY5FEp61a++Hh9b7j5Sq2W89dOJCPt4K40Z0e/vhyLJtMDJgphGuAawVNr
         Q/YLvGtMG84t7OAuO/hREyIVpN9+3aAszFGEKokcXrzFcid6Ac6aJPyMWcQzFhkLjkTy
         EJhJM5MtvZBClWydfaMTVrbMPU1cXCq8TqRE6jdwlaIyX926Oxr92w2XEs29DcU3eUEU
         QVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJiGeL12qVsCRUCe1lSR40nZvYZ5aasMv5chEjqP8tY=;
        b=fs+dkDF/iqWJZ1A07S7/KIcZ3kqRX6+jkuCjxjt61PRlAUxjnnYJ56onerMJTsSSgU
         5YmvqOu8K+mSrgicQ6F5Njf3yrPQtOvnu8hD3JtpNn3seqLA5nhdr2aS4gYCJDajkNkw
         y/5LRAMZ1QecNkPC4BxyqMrbx9izilqTuec8NPmfLuJOl0LrJhKU9RTNFFNfjCYRAb+z
         Ocz+z8YN3cRDT1lcRx6aDiXRyg6AWI+VCcF9vehqaPfHi5sCvjf4uDEXHUHFZ0WWYCL4
         6Zo9vcxhQedUpwDpzlHgVq/RT0uaTUI5RXdpRWjDfu1zLemvJhchDPWMhpMhXPz1DeqF
         vOyg==
X-Gm-Message-State: AOAM533RUJsTZssEvHryXC5uodlk34fk24R80c/FfzVARdemAXyfjcdc
        lR64peFYzdp28pH/0EL5044=
X-Google-Smtp-Source: ABdhPJwnVopiNGq+PGg0gw/3I7G0X13Ds1OY3TCzz1wQVVCj1tL+LHGTeBxNzFbeoR/rkFQHw0xcBA==
X-Received: by 2002:a02:c4d5:: with SMTP id h21mr1591867jaj.23.1610404299527;
        Mon, 11 Jan 2021 14:31:39 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id w9sm732807ilq.43.2021.01.11.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:31:38 -0800 (PST)
Date:   Mon, 11 Jan 2021 15:31:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     trix@redhat.com
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        ndesaulniers@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] USB: serial: mos7720: improve handling of a kmalloc
 failure in read_mos_reg()
Message-ID: <20210111223136.GA3631335@ubuntu-m3-large-x86>
References: <20210111220904.1035957-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111220904.1035957-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:09:04PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem
> 
> mos7720.c:352:2: warning: Undefined or garbage value returned to caller
>         return d;
>         ^~~~~~~~
> 
> In the parport_mos7715_read_data()'s call to read_mos_reg(), 'd' is
> only set after the alloc block.
> 
> 	buf = kmalloc(1, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
> 
> Although the problem is reported in parport_most7715_read_data(),
> none of the callee's of read_mos_reg() check the return status.
> 
> So move the clearing of data to before the malloc.
> 
> Fixes: 0d130367abf5 ("USB: serial: mos7720: fix control-message error handling")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/usb/serial/mos7720.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 41ee2984a0df..23e8162c768b 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -214,6 +214,7 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
>  	u8 *buf;
>  	int status;
>  
> +	*data = 0;
>  	buf = kmalloc(1, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
> @@ -227,7 +228,6 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
>  			"mos7720: usb_control_msg() failed: %d\n", status);
>  		if (status >= 0)
>  			status = -EIO;
> -		*data = 0;
>  	}
>  
>  	kfree(buf);
> -- 
> 2.27.0
> 
