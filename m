Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1D2F2C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404784AbhALKPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404514AbhALKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:15:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241A6C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:15:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a12so1847077wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WY0WW5EHKFupkTXG0tAM8IVZfwJ+Uxuf/TRpje8+pTA=;
        b=uI2ebsQMDG30pspMoXDv8UlypbDCL4LjY5BPJlr2UNXHq0psmlBpsKKpama2nheNWC
         sbl199nWsvpUhIIe17kDORY49WL216kYBxT4OIxza8SHaPpBwHF/OgfaU+qqtoaWYj1B
         TkpuIGpCK4NZGBIzzLewXvHeFVI1jd03yYR2MbzOtxzqBRkahc7dRNXToRRRsv8MmJvU
         WgkC07qsXKhyFhZhXMWGOHp6TQncHI/zDnFX/RajIa277O6ZNPjyS1zMNv6IJnTKYPYx
         RXql/q4II0Xa17gyWbGTPG4IR9fhNQ+yGi6HlPNs6LOXTOeyucPhUQlP/y8MO/9p5Qsk
         hGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WY0WW5EHKFupkTXG0tAM8IVZfwJ+Uxuf/TRpje8+pTA=;
        b=Y9lsohmLnQgz1OZiKOc1rBAf8gULXtG2JxGLtaHG5PS9p/11X0OoPGK9rhAMF0u2Bx
         0dzWVsZK4ghMi3NghXIHTUw2bZxEfeNNnsy/P7YrjvZAAzak5Qlx19i8c+6OwK8eTwIh
         vWLPtA2xhq6GBFOgSL020qOCu+JDv6bGklQbIgh15PwUlVG8mERlyxbHWcbVr8pQY9lP
         zOmKEzCnN01O0jAkaXK7fnSOeDCU3vyOdiGt2NIdn6ey60tYqH4jTmmqZIzuLouJlqfl
         1Ncthhvy2vjrrjA303OjNbTUGKg3mcDqjubYfUarqfGI4HIV/6pzjiZDoyCvNxzH6dwp
         IS2g==
X-Gm-Message-State: AOAM532sOxixji/HUZPXqNs9XYK6BD6ySdmPn8CYG3nZM+25tnDStEWW
        pqslv3X8mVxlkIT857iJbNo=
X-Google-Smtp-Source: ABdhPJxzYxlwW6GSgjCMLE0QzwIIjeODZyGvsTynrBph+9hvBHHMu5CXjHkA2+Z+uMYQBoAaCe1dNw==
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr3421302wrm.167.1610446499920;
        Tue, 12 Jan 2021 02:14:59 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id g5sm4426125wro.60.2021.01.12.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 02:14:59 -0800 (PST)
Date:   Tue, 12 Jan 2021 07:14:53 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 3/3] drm/vkms: Add information about module options
Message-ID: <20210112101453.3ofinorxbe4ylvob@smtp.gmail.com>
References: <cover.1610391685.git.sylphrenadin@gmail.com>
 <4fbc6459377c1dcbe8e6648718453d5693f6451c.1610391685.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbc6459377c1dcbe8e6648718453d5693f6451c.1610391685.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Sumera Priyadarsini wrote:
> Update vkms documentation to contain usage of `modinfo`
> command and steps to load vkms with module options enabled.
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  Documentation/gpu/vkms.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 9e030c74a82e..2c9b376da5ca 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -35,6 +35,18 @@ Now, to load the driver, use::
>  On running the lsmod command now, the VKMS driver will appear listed.
>  You can also observe the driver being loaded in the dmesg logs.
>  
> +The VKMS driver has optional features to simulate different kinds of hardware,
> +which are exposed as module options. You can use the `modinfo` command
> +to see the module options for vkms::
> +
> +  modinfo vkms
> +
> +Module options are helpful when testing, and enabling modules
> +can be done while loading vkms. For example, to load vkms with cursor enabled,
> +use::
> +
> +  sudo modprobe vkms enable_cursor=1
> +

Hi Sumera,

Thanks for documenting.

You forgot to bring Daniel's ack; however, as I also reviewed and lgtm,

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>

>  To disable the driver, use ::
>  
>    sudo modprobe -r vkms
> -- 
> 2.25.1
> 
