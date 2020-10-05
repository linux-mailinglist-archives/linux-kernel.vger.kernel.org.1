Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1E283434
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJEKuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:50:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702F9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 03:50:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so352976wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2zjVVLnmwFQgT7Kn7CpiF/4Y0RRRZlogY57D59OL1Q=;
        b=azTf+aCmxMcqsH4Q4OfDxJ0dGV/q88u03C/J+CGqrLXxLnSr1TDFyK7CNHb19lKJBQ
         zdh/JJy7p5benO94gyyJT53xEev17bUpps4y4pLsUM0aIMQXsK6FQJLPFv5W7TzYRvHu
         OFW8pRS5yIuyHvkfEY3Pnzy+Fq6iHIGUuZxZRj8D+eKJ9PaDqkhlZxc2oyoEmf/ZvXKY
         E5lvDFa1vXAlioPuUeqqcLraDukoJYrnCW5ogg44vvIoeY+0vd2hcLBRtxdhkc7ikxky
         AQA5dBAT7nSQxMVmoVhbGiBeVkjV6s3Xstr3TfpbY5u8dAAP736uCK/nE+PX+wRAYmqA
         mqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2zjVVLnmwFQgT7Kn7CpiF/4Y0RRRZlogY57D59OL1Q=;
        b=ofPc3WvvD6Gv5scq/w9KFticrEH92tOyBIaD2xF3pR1k3hShKcpu8c8rw5UypC08XV
         CZS6XSK4NbnFBKyJ3SeKxqAntRYFri7ftjgtAlUo4isztTubFaIW6ict0kaQmy0eScba
         tj9yUlSZhuycPqYVtUIsCtbgWFvxNFuy/MBkeKtkdIHK4px9Hpx/MwOUTbv+ezcU61p3
         foEI67/W4WXKzBdi7P+XCLI9T9v7MXqoQbcSrZzsm1CM4AP//82TdC/wQH6dWMdrxkO0
         6JzC/MLq6tJ5qtvPrUN1NzRf/XR/7VhL5smdPRhWcBW1MYmmVRvULui8KmeCTRTloYAJ
         kp3w==
X-Gm-Message-State: AOAM531GRC4WR2177G0uAu6r9MNSLCtAiu4ntaKTIdEFlT9fzSbmv8FT
        aP/SazpYedPc6uih0Ae5VeNTyw==
X-Google-Smtp-Source: ABdhPJyEPRxZd10VmSgHtfqoF+IWeXOoAoyzPP9zyjZ+55dwWBSUiJ1xTTKQhGeCWZvHzXjTlfeNWg==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr2426402wrv.388.1601895044152;
        Mon, 05 Oct 2020 03:50:44 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m13sm12871557wrr.74.2020.10.05.03.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 03:50:43 -0700 (PDT)
Date:   Mon, 5 Oct 2020 12:50:41 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] media: zoran: fix spelling mistake and make error
 message more meaningful
Message-ID: <20201005105041.GB29306@Red>
References: <20201002101620.86156-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002101620.86156-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 11:16:20AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pci_err error message. Fix this and
> make the error message a little more meaningful.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/zoran/zoran_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
> index 808196ea5b81..d9f8b21edf6a 100644
> --- a/drivers/staging/media/zoran/zoran_driver.c
> +++ b/drivers/staging/media/zoran/zoran_driver.c
> @@ -666,7 +666,7 @@ static int zoran_g_selection(struct file *file, void *__fh, struct v4l2_selectio
>  
>  	if (sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
>  	    sel->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
> -		pci_err(zr->pci_dev, "%s invalid combinaison\n", __func__);
> +		pci_err(zr->pci_dev, "%s invalid selection type combination\n", __func__);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.27.0
> 

Hello

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
