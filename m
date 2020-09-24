Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4427713E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgIXMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:42:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:42:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so3443775wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hOdMr4z55y7m7sInvhahv883Nzw4CA2e6+vBER7Lkgk=;
        b=X1LVvTRsoWnLc/tlMzEdUlaLLa/Mc+PPd1dPAzm1ooceZGCXUh7/IEZugJcWOmepRZ
         GeSYBaziRvTrY+eH+k9YC22kK6mkyF6XwsLyaW8feBMHQ21tSTdnKtClsBuulZ3DAyp+
         vTFnF6cvWo+XQdCDLTcPzkyywh7meFZj4xkhnpHYzytJqv1c+HD4cjCvg6hgMmCqyEux
         Ri96TXQSykfD0N1ymbWQCikxogDPZ1CPirstYnw8zEWn6oAX4k8zA6KYS1qX+2OM4FSq
         WWhUKEKbbGaUWW+yd+kDYZX5bVagsYfnZcYf7nLuVhSnXUVN6oSI2SMQx4w8P5BLFh8X
         P40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hOdMr4z55y7m7sInvhahv883Nzw4CA2e6+vBER7Lkgk=;
        b=Y5IMI14LE1+wI77nCy9MkEOqG961ExAd9Agbk0sYkg1/yaFqOD9ouFRxiMz8z+ii51
         CvD2cB9rdXK6KbgyoVT2206ldFCip1ugwuy64nACFuk0q8FJp58wkHCGrvrnOGgXrpSv
         IE7zZpVaOq+mAokYvY+t1tWU1pUU46x8hQ7xZ+uWtyfQRXWul2qSfSygOnygBoIM7tOJ
         dU1kAKFwvGxciHa6e/B/sr+tLetnc2FmxKnH1tyUe3ZTMimf9UTNR9RJK1KvTqZJEv04
         PD2Z3/TjJi+D1IJnyk+W6DKGBivpKQgglyC5YthofLq3iMsoIauQ24ylPw8VFVranIH5
         hwJw==
X-Gm-Message-State: AOAM533Vugw5HLVECz+hOsnXaShLWR8BIeYnZxE0EuIjWLQCniw5IY5Z
        bYgiKUqaq2yPhuWPKfkue5zUag==
X-Google-Smtp-Source: ABdhPJy6WEyI2TEYojR2YX/nEcp2VQQw6hJS/44FfWdWWIxB1UV7hUg1HHH4twHysn3pBlq8qVl2mw==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr4429708wmz.29.1600951333815;
        Thu, 24 Sep 2020 05:42:13 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id t6sm3473010wre.30.2020.09.24.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:42:13 -0700 (PDT)
Date:   Thu, 24 Sep 2020 13:42:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     matthias.bgg@gmail.com, gene_chen@richtek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: mt6360: Remove unused including
 <linux/version.h>
Message-ID: <20200924124211.GL4678@dell>
References: <20200914142518.39228-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200914142518.39228-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020, YueHaibing wrote:

> Remove including <linux/version.h> that don't need it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mfd/mt6360-core.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
