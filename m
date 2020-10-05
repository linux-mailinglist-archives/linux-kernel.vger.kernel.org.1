Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9546C28392F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgJEPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgJEPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:11:05 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C2C0613CE;
        Mon,  5 Oct 2020 08:11:04 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c13so9018594oiy.6;
        Mon, 05 Oct 2020 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RwW+3cgQRN9esWDY48Mrwamv0LGOoedzUjjGGELb9gw=;
        b=rmMncILe7hEypTqUh7SZl4WTgcv0Rnfl62dFWpviSzScI5eQnjCq5qWK8aASjpMCH/
         pIvyyrU1/Y3t+9S/+uhPNlRkn1HmeL4k5TuQ0t28t1ZDuBPuZcklIUA1OdyPUpv+Of5b
         vAdAPdbk4G0EBui6CPf/jjYqj+ZVRQlVI5+4gov9bj0a04cVdaTgw2TnOc2M8HfGU3jW
         ktBxfQAuwUg5u/57y740MJvL6LqardNYv/z3CJf4T60Dq/t8Ia6Hmhzn3HzDUm3Vtw3e
         c4+FVoJgs0BvCjzhkPbqGr6d84k7K563NtL+hmbrNorUFsdvvZo/Fmp39reqmvV7u4bd
         BCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwW+3cgQRN9esWDY48Mrwamv0LGOoedzUjjGGELb9gw=;
        b=rOsZWmFCJmRu/r1IBJ58gNj5fgXgG2+gW2RLerOlnQlq2t5SnEWxT1/IhgQCQyA+yX
         riKxjT4MgeZ82S2H5i4/X/KmM6S3dS5TPx3LGAbh3Xg0cPmKbpAf7nV0LLb6vbUTpYTE
         b0I+4aKEIpkhdDNsH0JUG3Smrs5jO5TfgDDtTjtNqyCB+suPuWcrtTeYE6QnMAEbuZBu
         8bPjtZz21Yqugh3p0onW8hwb+BFCviNFSctY4owYxzlYtmGM43vsPYfM+K1B1vGaUc9j
         +1vx38X06pJ+opL/QFuKy9ig439POuu7W3e59xw243k41l6Hp0voGSRnFgW267iyYHOs
         M23A==
X-Gm-Message-State: AOAM5321xRZDXVEkjPc2+nMGkOhip8vUwh0il7zipYNVROBfaouWBuW7
        Rujuwg8LmBPlbwoGh8Mqpes=
X-Google-Smtp-Source: ABdhPJzxsNc/BZAute7amLsLZyrqTZQK32QsK0Ua7GECgwCRR2zZLNx+9d84Aal7Q80u83gdYAT+4A==
X-Received: by 2002:aca:c485:: with SMTP id u127mr49637oif.92.1601910664371;
        Mon, 05 Oct 2020 08:11:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s32sm2933260otb.68.2020.10.05.08.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Oct 2020 08:11:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Oct 2020 08:11:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net
Subject: Re: [PATCH] docs: hwmon: (ltc2945): update datasheet link
Message-ID: <20201005151102.GA44294@roeck-us.net>
References: <20201005131226.1774081-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005131226.1774081-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 04:12:26PM +0300, Alexandru Ardelean wrote:
> Old one isn't working anymore. Update to the latest datasheet link.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/ltc2945.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/ltc2945.rst b/Documentation/hwmon/ltc2945.rst
> index 20c884985367..8d65c141ce2b 100644
> --- a/Documentation/hwmon/ltc2945.rst
> +++ b/Documentation/hwmon/ltc2945.rst
> @@ -11,7 +11,7 @@ Supported chips:
>  
>      Datasheet:
>  
> -	http://cds.linear.com/docs/en/datasheet/2945fa.pdf
> +	https://www.analog.com/media/en/technical-documentation/data-sheets/2945fb.pdf
>  
>  Author: Guenter Roeck <linux@roeck-us.net>
>  
