Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85E2AA901
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 04:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgKHDgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 22:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgKHDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 22:36:52 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67EBC0613CF;
        Sat,  7 Nov 2020 19:36:52 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id g19so5302755otp.13;
        Sat, 07 Nov 2020 19:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nLXzgOfO7NwishsE41YtVTb8qe2kc+Jpqp7NgInv2kE=;
        b=TjmYwpm+tV3BgPgJ9S0soYAEgKebFCQsVmWVYQGaGkhG23i94GOs+WUfb19bDABk7Y
         FX1eZG5U2CCo4mxYWJt3zMNunbcCLmqAumF2FBGbA3zfdhyCegNzAl2mrpVZw8GNA5Rc
         db2djVI9zBukceMsmpFEbyVXyr07zHpTvFOjuzWYPlEeCNWqA2g7BcjStDFGkAasKZMP
         8WbfgwHK8wsiRBswQM0u4QPlpqhmS8qnOZIhoHNXf0rCt1C/tVC+lwquQAiOQiaur4YW
         tdlYeggOZY47zTawQ4c+8VH4ytaOTUcLNSFMfBNHCnGrn8Va8pJqkjwRZD+mp2kNv/lB
         eDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nLXzgOfO7NwishsE41YtVTb8qe2kc+Jpqp7NgInv2kE=;
        b=JB+XIhFkDG2HpX2PhBrP0YYkTBwb6uGjMe3bss+YAAFBV9HrHNYetdNup7TMjepeW0
         t4NkuThdAk2rUnlnENQ9fIxCmcTfcLdhhfXoo6V+TDOJ2IYdaIEbsNMFnzpxKwcJ1dDK
         1O1zMC1kjKHMRK0YidrW/ktGBIjg0PWdqtWs3LJtCbHCIxy542TwQAyjYXaddameFfoy
         06fpgX86NZiQebFWxCd6A1dW1JJJ0N/AsdNlj34D1CjjsnrblBz5GHpkx+4zbhVUU73n
         SdO+xsSnEAsZm1X8AVXQpXnXTSdMMvtW7RuEiG9MRwfRwESvaGLR0rtZUOc4aItWp3Ls
         a94w==
X-Gm-Message-State: AOAM532RBkaEViXTsl9XNF4jU0nIo4MhZnnYfNDiAXf7nY0YLXIjTt/z
        PBbux5L/rdGdyy5r42r4hS4=
X-Google-Smtp-Source: ABdhPJxObq/F3pY+So1BQQ0vkYc/Am1xYS3CEMJ/WtVP5QpkkVdm8ko5vqdsRAwsDF6+l4mrwres1g==
X-Received: by 2002:a9d:62c5:: with SMTP id z5mr5695339otk.351.1604806612060;
        Sat, 07 Nov 2020 19:36:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 72sm1527982otd.11.2020.11.07.19.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Nov 2020 19:36:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 7 Nov 2020 19:36:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: corsair-psu: fix unintentional sign
 extension issue
Message-ID: <20201108033650.GA133578@roeck-us.net>
References: <20201105115019.41735-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105115019.41735-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 11:50:19AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The shifting of the u8 integer data[3] by 24 bits to the left will
> be promoted to a 32 bit signed int and then sign-extended to a
> long. In the event that the top bit of data[3] is set then all
> then all the upper 32 bits of a 64 bit long end up as also being
> set because of the sign-extension. Fix this by casting data[3] to
> a long before the shift.
> 
> Addresses-Coverity: ("Unintended sign extension")
> Fixes: ce15cd2cee8b ("hwmon: add Corsair PSU HID controller driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I wasn't sure if I am going to get another version of this patch.
Either case, I applied this now.

Guenter

> ---
>  drivers/hwmon/corsair-psu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index e92d0376e7ac..5d19a888231a 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -241,7 +241,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest psu
>  	 * supported (HX1200i)
>  	 */
> -	tmp = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
> +	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
>  	switch (cmd) {
>  	case PSU_CMD_IN_VOLTS:
>  	case PSU_CMD_IN_AMPS:
