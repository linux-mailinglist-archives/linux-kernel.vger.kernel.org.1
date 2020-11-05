Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7A2A7982
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgKEIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:36:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB036C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:36:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n15so719706wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fVjcjfrrmXORahZp/hVfTr8m+lXVmFllNiKKjDMWxII=;
        b=n9Gsyc5zxdSKZ/TXEy7Q1nx0i1xElsOyId6HnuuHMzeVeqN9iSVzatw05vGO7/5K5m
         ecn+0SclYkXIFCNHBHmiQPvqp3o1KfVg+9wX7/Ap9yfDp/7ZiSu4G80c0x9MX7cINAcD
         Z4WBcZGVgXXuQSkfrmZZmcuFCkOtVHCVT4oleIgD22cVRVECpWH7ri2rjNeYagsqKZy5
         gS9edt1U92OFeICdQ4olSaflYMshl5zfYrietGxMgb3+kfGzsWNtpwZgFpUtnHBJB4sc
         pLwSML8QcLiVydeeQPpfwmAcQ6OPTm0W+PjsOYKGIrRfUxiXYeHdsvYTzismMOnLcRjN
         W7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fVjcjfrrmXORahZp/hVfTr8m+lXVmFllNiKKjDMWxII=;
        b=BNv1segmunDH2hOioztvBYuUputY6Sl+eMJQahdBpttEgv/s91CxYqHdBuQpHQ955j
         2N6reiM9AqzvNlZFmbBSyadAXyRweBfkgmHsfk7MzdrElqbxhElpZbcWfvzlc0ltFwpx
         7YF2f7G2NAUDcHaALSOrmrAMfRYhTaQv0WRX7sLbJC498E3/GK0PYeM6vzTPCkNlJOi5
         MWpbLFr/bY4y0NamqkZeF5ECcv1FjyFONfvj8lXjVZPnItupMjD1srcfjc6SWSVvYkNW
         ChhWykPv7u4/EG9XlaXqIeb6/qzyiItS0Xcg2w9H1aYVZ3RaJflhzGNGXJdiwDFofXaM
         TSWA==
X-Gm-Message-State: AOAM531tOZlj+HGkZ5NFFNYSQI08whuamLqjFGG8aVdB1+V7Jj4bFenV
        b5J9jTWUY1Rp9MvZWFlx7tDlbw==
X-Google-Smtp-Source: ABdhPJywWSiq38BqbSd7YukFXshDJiCN4Em7tr9zBcurHrSuOGtYsiYwTQM9YCvQ5PvPaKd8VwAPwA==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr1461048wrw.194.1604565389496;
        Thu, 05 Nov 2020 00:36:29 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u16sm1337124wrn.55.2020.11.05.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:36:28 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:36:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
Message-ID: <20201105083626.GW4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
 <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
 <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 05. 11. 20, 8:04, Christophe Leroy wrote:
> > 
> > 
> > Le 04/11/2020 à 20:35, Lee Jones a écrit :
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >   drivers/tty/serial/pmac_zilog.h:365:58: warning: variable
> > > ‘garbage’ set but not used [-Wunused-but-set-variable]
> > 
> > Explain how you are fixing this warning.
> > 
> > Setting  __always_unused is usually not the good solution for fixing
> > this warning, but here I guess this is likely the good solution. But it
> > should be explained why.

There are normally 3 ways to fix this warning;

 - Start using/checking the variable/result
 - Remove the variable
 - Mark it as __{always,maybe}_unused

The later just tells the compiler that not checking the resultant
value is intentional.  There are some functions (as Jiri mentions
below) which are marked as '__must_check' which *require* a dummy
(garbage) variable to be used.

> Or, why is the "garbage =" needed in the first place? read_zsdata is not
> defined with __warn_unused_result__.

I used '__always_used' here for fear of breaking something.

However, if it's safe to remove it, then all the better.

> And even if it was, would (void)!read_zsdata(port) fix it?

That's hideous. :D

*Much* better to just use '__always_used' in that use-case.

> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: linux-serial@vger.kernel.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/tty/serial/pmac_zilog.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/pmac_zilog.h
> > > b/drivers/tty/serial/pmac_zilog.h
> > > index bb874e76810e0..968aec7c1cf82 100644
> > > --- a/drivers/tty/serial/pmac_zilog.h
> > > +++ b/drivers/tty/serial/pmac_zilog.h
> > > @@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port
> > > *port)
> > >   /* Misc macros */
> > >   #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
> > > -#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
> > > +#define ZS_CLEARFIFO(port)   do { volatile unsigned char
> > > __always_unused garbage; \
> > >                        garbage = read_zsdata(port); \
> > >                        garbage = read_zsdata(port); \
> > >                        garbage = read_zsdata(port); \
> > > 
> 
> thanks,

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
