Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F562A7993
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgKEInr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:43:47 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:43:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so606624wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VKTj8wGInlWJoDrvSOPhIbqFpD58K2dCbM3B7QsK2YE=;
        b=Xa77L08jg2S4Y1Al8Q75KSPCqaw66bV9TP1ftqsXCZQ6a3JZAHbqZM5ELlMiYUvWqY
         kwrqQ2FD7qRtGmrrQKjMs88M8mD/f4p8bBBGuTCBKLR7Aeh25r8zpCfTapZ2M1IDP88/
         MX4dFHeVdxfewCchVpWIBpXwBPCWbYkiD64DtmKsSQTg1Ex3SUG5jkao43QdIKWWLP0W
         84SsTPrdMIdBlBm5Xvug9Vm3H1Ydl10tkPZ5jrc/MC0WV6xRC3fVLWllV4/LzVEF2+vn
         Qvrc300bZ/7A8yJaaY6BF0VBERJO2FxP5xOYZsXu/jBmriAgemQZL7IEBBmT4/RLqeNS
         Io/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VKTj8wGInlWJoDrvSOPhIbqFpD58K2dCbM3B7QsK2YE=;
        b=RolHvIoxEK4/osM5mzzLowvRpNGtV5K0xb70crFQMUHoCSDvrrbC10EM8j80FEE5De
         jCwUgtnDWEuv/+j1iDZZ+4y2hJwQ339j9HkZkhoKdkuWp/HlBrL8gdMvg8B/DhmYq4pe
         eTfqyu8nSDqQO6Tejo9ts26tGd3bJ8L2A4506AqEUQFC7KIWqsEds8Ggur+mBiK5UKco
         4u7zHSTs9baORHa9EIewLGvrh+YYmM6Q5sK8Kk/Xkf+tqxrY+VimEx/PTPTg4xlOfyr2
         icFxrYEi7WrFugVnd5uCzFueMItcS7MTsmDwOIc6/m03iLpL8BXvMvOPMLf4joJXzl5n
         ctYg==
X-Gm-Message-State: AOAM533xT+qneM9hdtEzePE2sYxmQr19UkCrLhmEQM5npVS32ZTJcPCm
        BuQqqhZqsy+lERdn30zeOv7VNm8Ke8gugGeN
X-Google-Smtp-Source: ABdhPJy9ElxbO8Ey7oJxKKX4PLTNxxCge0yWoKQ/U07PDpFCrR/mwZ/jW1albDIqrH5HYkpUCYdd1g==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr1441009wmd.29.1604565825812;
        Thu, 05 Nov 2020 00:43:45 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id e7sm1401050wrm.6.2020.11.05.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:43:45 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:43:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        paulkf@microgate.com
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Message-ID: <20201105084341.GZ4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 04. 11. 20, 20:35, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/tty/synclinkmp.c: In function ‘init_adapter’:
> >   drivers/tty/synclinkmp.c:5167:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: paulkf@microgate.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/tty/synclinkmp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
> > index 0ca738f61a35b..75f494bfdcbed 100644
> > --- a/drivers/tty/synclinkmp.c
> > +++ b/drivers/tty/synclinkmp.c
> > @@ -5165,7 +5165,7 @@ static bool init_adapter(SLMP_INFO *info)
> >   	/* Set BIT30 of Local Control Reg 0x50 to reset SCA */
> >   	volatile u32 *MiscCtrl = (u32 *)(info->lcr_base + 0x50);
> > -	u32 readval;
> > +	u32 __always_unused readval;
> 
> Why not just remove readval completely as in other cases?

Because I don't know what the result would be.

Will the read still happen, or will the compiler optimise it away?

My changes should not affect any of the instructions i.e. the register
read must still take place

> And the loop can be turned into ndelay:
> 
>         /*
>          * Force at least 170ns delay before clearing
>          * reset bit. Each read from LCR takes at least
>          * 30ns so 10 times for 300ns to be safe.
>          */
>         for(i=0;i<10;i++)
>                 readval = *MiscCtrl;

Again, since I can't test this, I do not want this patch to contain
any functional changes.  AFAIC, the 10 register reads must still
happen after this patch is applied.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
