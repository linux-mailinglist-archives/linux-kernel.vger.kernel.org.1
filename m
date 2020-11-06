Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524DB2A97DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgKFOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:47:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AEBC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 06:47:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id s13so1576683wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RRI6O/KTs26atgke/v2YFwDIWNXDef5AwD2lI3W39cA=;
        b=DV34WTKSwLTxt5vyFBrk4yHE7joKw3Wvi0HFKU0z/DZqAKDffa3CnKj+NtXHrVicNJ
         YHsOOl/Awk85NQnt7yXDo3Gcv+Sx/3LubQ07kUGQDIhXGMmfuob5PMQImBRW5InqA31t
         piLeNKkp0ZUZSH4UKlk9vIuP+5woPb/0p/zcebGRDJQ1ywVg9u9ALS4wzaZk6/8HBRDJ
         P/XalWkjlHmRp5OpTHdQBeLbkmJ+zwxi54yPIwXj6Fr1O9UuNlY9KyEa1dXJTyFUq0xw
         jHpRFYf5wX/OS5971YFF6dbGOEULGbdZC4xgUp5CqjtHS+Wg2EAg7bMrG7AIJUoAE46p
         hoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RRI6O/KTs26atgke/v2YFwDIWNXDef5AwD2lI3W39cA=;
        b=IlG6rUVVZ6lkQXKVXMOaZYo4IZodHRt7mN+3feHiHwv9yS4oovy/krCqmUe7+HsC1l
         qfeVRR0vwNmAzDfvAoiTjuFiEo1/whm6uo6HuJ/kPiOnWZWWQuvJnXWwGKFlqY1guptc
         NNNUH4EsVDaY9CSCnqyXk3RK8/FbRrHgouyI/Lm5+djPfz+8tdMBE6JMyPbdL4YmGGLf
         AuracX4HT1KUBwHm2WTQ5qxKvLONv5c0+ARGgvdW5RKW8OsCEOaTpTnUyXMBicZUIITF
         vqSjkSCAW86WrGbP3b7u8XKoGMlo5mrGub2SEg4dYPpRMqUuFQvsjK5XFn1YOMGLOLnv
         dYMQ==
X-Gm-Message-State: AOAM531yvcL0t93JcaZBxpsK4pJs+qtZ/+NpPAwYfxkC1emKGqwzDKSr
        E4qEm1mmrJjcDcoEczP3P5YNug==
X-Google-Smtp-Source: ABdhPJzuBupST5DguMV389RVSZG4O2V2zavdSGtT41CSN7YMmXASeUw3W2XSt1FHiI16OoPSJ5xziA==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr2770572wmf.108.1604674037968;
        Fri, 06 Nov 2020 06:47:17 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y63sm2426409wmg.28.2020.11.06.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 06:47:17 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:47:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mike Hudson <Exoray@isys.ca>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106144715.GM2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
 <20201106101646.GB2063125@dell>
 <20201106103955.GA2784089@kroah.com>
 <20201106104810.GE2063125@dell>
 <20201106105552.GA2810950@kroah.com>
 <20201106111251.GF2063125@dell>
 <aa8356e2-a9b9-f8b9-1d10-62d75399e7d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8356e2-a9b9-f8b9-1d10-62d75399e7d9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Jiri Slaby wrote:

> On 06. 11. 20, 12:12, Lee Jones wrote:
> > I cannot recreate the issue or work out why:
> > 
> > # THE OUTPUT
> > #   *_port.o and *_early.o were both built

> You have to _link_ to see linker errors ;).
> 
> Like make vmlinux

The default make that I am using does link:

  make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86
  
But I do see what's happening now (thanks for the nudge).

The issue is being masked because I'm specifying a specific directory
to build.  I would have hoped that it would at least link into a
subsystem type object file, but it looks as though it's only being
*-ar'ed into an archive.

It appears linking is only done once at the very end of the compile,
which is kind of frustrating for my use-case.

This confused me because I know that I'd received linking errors
before.  However this must have been for files compiled as modules
(these are linked on-the-fly) rather than built-ins, which are only
linked once everything else has finished.

Not sure how I'm going to fix this yet, since compiling everything is
very time consuming, but I'll work something out.

Thanks again.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
