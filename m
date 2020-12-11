Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1DF2D7651
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436685AbgLKNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgLKNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:11:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:10:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so8537524wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xeTiuPx550PwoQj+sCkQOKNnsZoRFWBYiYPyRsXJUaA=;
        b=tWg69z3pf2wqfOc/O62Jbnr6FkcLs2g2sBJo1L3kxYXm4lzN9SlgfjCmobeFcwjZhb
         QOZNymy9tKdEoxNpTYI5SAzJgUQ01jCr/Ji5m6tvvz7aQ6K0tU/ZLUjLEyETJ8hXUzlL
         Imp+5GwFNyt+c9yWaUcX7mOl8hjsr6eTTgTqGc9imtfKAV7d3gMBnadirvsAL0DBWzKU
         amTaHGWIHWcygwnJ2WEap3x7vFZDH5W6ycnsuf8/dt8cF68Xt95UKlaVZPNLo+E/85Y+
         qUk7bcPH0mzZS2QIVBEjzh0TnsahZR81yo+gP0FXFb4clNvBpQZiN5D11OJCcWzWFivC
         IvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xeTiuPx550PwoQj+sCkQOKNnsZoRFWBYiYPyRsXJUaA=;
        b=fQavJnf9hPJjQgStdJEMAvL6XGNjmT4hRewjNztj78zSsYvvl6UD2ChP4Fq+TMCTdH
         tFJQtqglFVQ29A3tZF0fCN8EkgYFsliF0KJ7FfQU9lhKofm7/9oydMyHsP2DFoMhwvzi
         uSYWPfHLYWRb7s2wqld8x0O1mejMNyoj0WVHi145cobhB3U1o4aFg4Emo9do/r1S/Wcc
         fbKsoW5aAxkEfFvPhJxSBAipIaS5nbM0NLL091ui1wx12IXw7nx7dx5g4SkrE5vR/JqH
         nUHEzxPGlJPaRFBYDK571V6Bv+1T/V0J8hJZHW8L6FYKal2xu9J1OpLME7RBhQQaXLy9
         R89A==
X-Gm-Message-State: AOAM5335RhfQW33DWZlM/NryeKlQZ/8v+bqHvNOROnq//Sv0M6SiTUyA
        Zsy3ZiodhlBLj7rnpy6zVzywjg==
X-Google-Smtp-Source: ABdhPJz6oi1MefCpZy6J4vRDSbSJMRQIIoRZSJZM9pBdgZptwEJaM0mULDACoshDI8vHx+91/pWiig==
X-Received: by 2002:a1c:e042:: with SMTP id x63mr13661658wmg.68.1607692251591;
        Fri, 11 Dec 2020 05:10:51 -0800 (PST)
Received: from dell ([91.110.221.240])
        by smtp.gmail.com with ESMTPSA id s8sm13525535wrn.33.2020.12.11.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 05:10:50 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:10:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bikeshed: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Message-ID: <20201211131049.GE5029@dell>
References: <7416de308a9b41d3ac881210ab114159@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7416de308a9b41d3ac881210ab114159@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why does your mailer thread emails?

Your reply is not detached from the remainder of the thread.

On Fri, 11 Dec 2020, David Laight wrote:
> From: Lee Jones
> > Sent: 11 December 2020 10:06
> > 
> > On Fri, 11 Dec 2020, Zheng Yongjun wrote:
> > 
> > > Replace a comma between expression statements by a semicolon.
> > >
> > > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> > > ---
> > >  drivers/mfd/rave-sp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> > > index 545196c85b5c..abb9cbdabaa9 100644
> > > --- a/drivers/mfd/rave-sp.c
> > > +++ b/drivers/mfd/rave-sp.c
> > > @@ -358,7 +358,7 @@ int rave_sp_exec(struct rave_sp *sp,
> > >
> > >  	ackid       = atomic_inc_return(&sp->ackid);
> > >  	reply.ackid = ackid;
> > > -	reply.code  = rave_sp_reply_code((u8)command),
> > > +	reply.code  = rave_sp_reply_code((u8)command);
> > 
> > How did the original code not create a build error?
> 
> Nowt wrong with commas.

Well you learn something new every day!

> Why not go the other way.
> Convert almost all the ; to , and delete most of the { } in
> if and for statements (etc).

Sorry, I don't understand.  Please elaborate/provide an example.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
