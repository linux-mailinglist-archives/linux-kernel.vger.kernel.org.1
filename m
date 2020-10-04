Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A9282C08
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJDRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgJDRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 13:46:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D6DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 10:46:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so4461086wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZb9ZPx925o3OtV1iHv7jgcfUYkClsADhGTqG4VVBZQ=;
        b=a1lT+kITTxZoMYdlrn0a8YZ3eYwhdfwvsNwzaM5mcrFlgcCQLKHacFtLl/AO7nxwo6
         ZUhHhyOFJc0byw3/WZvqOtnfHy08gpGybBDq2bdzhiPsyL2sYugYTPqcTdfaZYeMA2/Y
         I2NuCbM5zP1rUMOr0c5CiPBIk8Q58rv8gbuW8CUGCAozutPVsRMHvY8rAsAtlPF35zsW
         89uRb2tPzTanOqpoBOiNHSFHtbY2z9DfibF9RVKHW2OYVi0dfdCWT7E22UVxNaOK1Trv
         X9NJxwdHQGPfE117H+M0EV5MzLlA+GhDstlV+cuVaGVfl7A/DZjDgl7RFG4l5DaWIwmT
         P/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZb9ZPx925o3OtV1iHv7jgcfUYkClsADhGTqG4VVBZQ=;
        b=nU5bCdNViuyLG4d0k/vU0WRCSCQPMJW8dL5r64+hDFrd8fMiCTfRErGoBUFBVprup0
         IeCXpaoPr5W1YISy2kubctNeKkh5zK8be2FM4S16E1+3cqEFZwIr2hA7rqsB+EXkO1Rq
         w0Pg9JLVOTCtLLTwtBIRMZJcEayMJC6IsAvOlqIQDzzaNszFikMcDiL1xtJ+UPQUmcUA
         q4cMqcAONayCq93zAVYPPd9TcguvYxlJhKAIAAKTmmPLmGMhNC0xWsmh2cnfqTgOP9YN
         PQVFT6HlstvDwAzsGcdOJLOdqb0Sdc12uQclowjunILNW+Dm5ta2xo5rcywVOLKH1uSa
         iTDw==
X-Gm-Message-State: AOAM532DomSTVelYG9Tns1GLHZvQJxK8RuMCRGbVrrABmNN/7QRHZeWF
        ZA+17BL3y1UlxjsZTwobUUxa0Q==
X-Google-Smtp-Source: ABdhPJybmll9TQHS7y1+8M8alBfioU4eEPKn3U3aBe/VWg01Vh0UPrN1YKNOb9nvmW4dZhhLG9O4fA==
X-Received: by 2002:a1c:6004:: with SMTP id u4mr5348656wmb.44.1601833614456;
        Sun, 04 Oct 2020 10:46:54 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id y23sm6259129wra.55.2020.10.04.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 10:46:53 -0700 (PDT)
Date:   Sun, 4 Oct 2020 19:46:51 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mjpeg-users@lists.sourceforge.net
Subject: Re: [PATCH 1/4] media: zoran: move documentation file to the right
 place
Message-ID: <20201004174651.GA28143@Red>
References: <6b90346919d42ffc7c3ad283bfca2825b238147a.1601714147.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b90346919d42ffc7c3ad283bfca2825b238147a.1601714147.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 10:41:54AM +0200, Mauro Carvalho Chehab wrote:
> The zoran revert patch misplaced the Zoran doc file. Move it to
> the right place.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/driver-api/media/drivers/index.rst                 | 1 +
>  .../{media => driver-api/media/drivers}/v4l-drivers/zoran.rst    | 0
>  2 files changed, 1 insertion(+)
>  rename Documentation/{media => driver-api/media/drivers}/v4l-drivers/zoran.rst (100%)
> 
> diff --git a/Documentation/driver-api/media/drivers/index.rst b/Documentation/driver-api/media/drivers/index.rst
> index 5f340cfdb4cc..eb7011782863 100644
> --- a/Documentation/driver-api/media/drivers/index.rst
> +++ b/Documentation/driver-api/media/drivers/index.rst
> @@ -25,6 +25,7 @@ Video4Linux (V4L) drivers
>  	sh_mobile_ceu_camera
>  	tuners
>  	vimc-devel
> +	zoran
>  
>  
>  Digital TV drivers
> diff --git a/Documentation/media/v4l-drivers/zoran.rst b/Documentation/driver-api/media/drivers/v4l-drivers/zoran.rst
> similarity index 100%
> rename from Documentation/media/v4l-drivers/zoran.rst
> rename to Documentation/driver-api/media/drivers/v4l-drivers/zoran.rst
> -- 
> 2.26.2
> 

Hello

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
