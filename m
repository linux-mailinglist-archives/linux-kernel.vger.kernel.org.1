Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762EA2D7366
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394186AbgLKKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405747AbgLKKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:06:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398CC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:06:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t16so8400764wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GBw8bVxK9pgXcH2/ptByZ6/QFCKdwKuJjSPF54lXwoc=;
        b=FbI+3OdIOLQJyzDMXiLhDgovuLPEyhUwDcAzAGp4KJf7kO7G81pcktvwxO5y2UXP+A
         74nfbf7sOPz3GNWBMrLaWhsZdhntKSnjib8oji5f9UuM0Pij4y/e15hAPQl88xf99scw
         xvvbPw6kJrTWMOQpq/palUkaHihTv27Kpz+UL8k1Bs67W1+QUYBT5Yz8h4FlVc/hzqwp
         FKyE5pOaSvNzzQ9oQWus7I1ChVMoAjLNzMlY/NJnl7f2e9oiMGf3aPRJAv7iwXHqn+ee
         EeAonpe4i3yI1EFqCyI4MztEFf40YXWTwIBLWtRzsOb+lwBYGAvoZVtI8msXabyAzjGC
         cioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GBw8bVxK9pgXcH2/ptByZ6/QFCKdwKuJjSPF54lXwoc=;
        b=o2QzNRxcOkpBqBHdXWlj3H+v6eU2b6cTNdTqCcLLzGiuDgq+RgantqdjjHobz26UDn
         VQAtfZIN4qp53tcgdttplGN8yn9xea4y0yKqrxFdBqZZ1J3lvyOiL6ECg+kslfCvM7RJ
         M1NFgC7VTuZtIbFTJ58VB/PVwaCq8/qCKrulSrCK+epu3BJCYavlBxKWgUarIBSJy9IQ
         tc9d6o5F0AO3dU9TM9rGCzAdR2GQnoe4AxN3juZ+zfWyHbX76DGa+iCLwuxa82TYubiy
         mj9fRJqzsUJolGp28gDlrC7vgj1Aoyf7Hc4Pi2QzwP6nF0f8nL3/SVqi/Ray2sfrQSsd
         wVwQ==
X-Gm-Message-State: AOAM530oErL++lBJmlvwHZpdIkf2xb+v1d7sc1TTmEj0D4ylmwbLHQOk
        SyZAHQ09fjbQxDzONOrT4PuPIp6VzHwivN1N
X-Google-Smtp-Source: ABdhPJzTF8w2S5Ge60UZYKJvWLJI75OekmYFz3FwicwSJZ0MvSFCUYH2+7oKG/zTejFzYmCWpcLClw==
X-Received: by 2002:adf:df08:: with SMTP id y8mr12794223wrl.278.1607681160777;
        Fri, 11 Dec 2020 02:06:00 -0800 (PST)
Received: from dell ([91.110.221.240])
        by smtp.gmail.com with ESMTPSA id j15sm14036779wrr.85.2020.12.11.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 02:06:00 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:05:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Message-ID: <20201211100558.GD5029@dell>
References: <20201211084404.2151-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201211084404.2151-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020, Zheng Yongjun wrote:

> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mfd/rave-sp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 545196c85b5c..abb9cbdabaa9 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -358,7 +358,7 @@ int rave_sp_exec(struct rave_sp *sp,
>  
>  	ackid       = atomic_inc_return(&sp->ackid);
>  	reply.ackid = ackid;
> -	reply.code  = rave_sp_reply_code((u8)command),
> +	reply.code  = rave_sp_reply_code((u8)command);

How did the original code not create a build error?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
