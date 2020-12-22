Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F62E0DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgLVRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgLVRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:12:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 09:11:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g25so2004241wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p90FBl2j96whg7rD4rhdiutq3kxVhonDmop9yW526g8=;
        b=byK36WMeGyjauDHsfV5Qlnjf4POVyhYTKciOoMt72lxaB1vALTCw0V5yFzHS7bnB/j
         f64MilKlbMrOhQPejoJ/9AmIwAiaBZAs9Xl+l/HS1VRVWJXowqkR0+oFIwEulfwhkAdl
         3xsY9laqxbKtZPzBjavTXEVSFBE1fLmn6jvSQOxct8n49vrZuFjCZdSCjjCcyIXo6pio
         C+YVa6KSvYC8TbkI0Sv2eaNiNWK6TzSXjWWAcJhwPeaRVFicXlQqGO55HZJSg2oBsOEK
         nGreGIfHE2Xt3NOrptppIV4M/T0s50hgpfxpHM5I2DQnXRFBjy5xPW1MAm4ryUx6erTb
         2m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p90FBl2j96whg7rD4rhdiutq3kxVhonDmop9yW526g8=;
        b=WG+li1a/LYJ8m2eY5sviGAuLu0UpdrQNOjzlwxyWkZrOkVt2V83KW6zb2tl+CohN0j
         ZUAZgeKSOfPgUyrdEvWDQ+SivqGSjO6JQ2qdAoFhijtEOv/7TQHBh54wq35wpy39vXOp
         iYWkA5qHlkyElkOcwvBzbB6lMcJwO/MvCmUSAr1tUSWKO5QM/vVMyS9wHzxIUrLYwHIm
         bImtMrwfvlVPk5sIvXgMIfz/X06mD0BWwqZHC80WNw+X2uMdW6BEb55Ou7dKE8IZFfeO
         rsJ0t/weONsVxdp8x4HebrUmvbCRHSSk2w2NkXISFPfaDBtGmkRMkux83feNBkR2PixS
         sGIg==
X-Gm-Message-State: AOAM5309BLGI1S5O8N0cq3W2TiiIZkxPWIlA3yK6lUYyQwTP9aav2Uhy
        u8bLwhuAXjr4s9MZf8LgE0RNWg==
X-Google-Smtp-Source: ABdhPJy5kQXFxdxKzoIJA+rjPAwNAIMQJ3pOLL2RpwHSSkfhfWHWrPiPRcLFqD7itQQ1C0RIT+IkFA==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr22262083wmt.127.1608657101273;
        Tue, 22 Dec 2020 09:11:41 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p9sm27641418wmm.17.2020.12.22.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 09:11:40 -0800 (PST)
Date:   Tue, 22 Dec 2020 17:11:39 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH -next] misc: use DIV_ROUND_UP macro to do calculation
Message-ID: <20201222171139.hosgkr22lqczzdit@holly.lan>
References: <20201222133344.19753-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222133344.19753-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 09:33:44PM +0800, Zheng Yongjun wrote:
> Don't open-code DIV_ROUND_UP() kernel macro.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/misc/kgdbts.c | 5 ++---

Arguably this patch should have kgdbts in the Subject line.


>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 945701bce553..cd086921a792 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -139,9 +139,8 @@ static int restart_from_top_after_write;
>  static int sstep_state;
>  
>  /* Storage for the registers, in GDB format. */
> -static unsigned long kgdbts_gdb_regs[(NUMREGBYTES +
> -					sizeof(unsigned long) - 1) /
> -					sizeof(unsigned long)];
> +static unsigned long kgdbts_gdb_regs[DIV_ROUND_UP(NUMREGBYTES,
> +				     sizeof(unsigned long)i)];

How was this patch tested? This code does not look like it is
compilable.


Daniel.
