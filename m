Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBDA2A79F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgKEJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKEJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:00:44 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:00:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so434479wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oFTMhNMHoq25rYA3w5+1LIk/RTDCRofksXq60Nb/QDY=;
        b=hRQat/Fqb7VGO2V3HW5WJLshXLK1C1Q9IksyN1vPm65ogPzj6eKTzD3igWHZYbp4Vr
         Axjgm/6Wa2YzQ6lpKRVWwtSyfUUnUPRlDVvk7NjCAI3sJb+/29P/hvQUitpeGWPfhXH3
         PsuMuKPCksIM95pikUlrThbiNqjzXpwu3ZF0E14Z54B7/HGdoFhy1Z92D8SPdwIe/Sur
         oUux9aR7Ut673oZXUJL4tfze/51gOyVPKCPRcoA9zXBL91bogx/MCNTdu+Hg1OOCpU2Z
         2UVeY5oyTAo38EGayCyZOZV/EQGdieJAVjSbch9sPyqDud1rYPuYcN/XvtKGwoymsHk4
         40og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oFTMhNMHoq25rYA3w5+1LIk/RTDCRofksXq60Nb/QDY=;
        b=LZnasvsZexTInFwdFk2Uhxq8Pyv0z2rs4H6N+8ydUoQ0fo5+doq6Yb75jcWwZqR28e
         3g1hC5PSzs5bPLIqLAUs5WMr6IKl3peLx8fsOXC8jIGD2jpeaXVVBhcKBXpus3lufMCe
         JH1vHgszB30ZxGD8mvJpeuT5WeD3N4uHSLVSZALJ7He4GmFv7Y/bXwEhN7msBC24gQnv
         f5IjpSq1IFoZml0Yg43cAFpm0lcArM8D+Z0qsmgpkUp6C627rY5Sxm5Is34DCLyyyEd7
         pADwpdqmFr+U5HYtxXWCrE28MiR1KeiKWkYUC6CiYeOEH7uueuYwT+fMlS+12R21dkw9
         pEdg==
X-Gm-Message-State: AOAM531myh/dtzx134/fWQE0krzcVTQkgJ6jSfHKl+Ly3/MFUp0MRuvr
        jCXFoLoIDgs1QSRfESFyME/X23BUJ95mcbaM
X-Google-Smtp-Source: ABdhPJwX6rah1IjawH28Bp69Z6yUrWuswtBB/jmAsqsY3zzx6rCFNdZ877z9bA0QbMlCAebIJV2uZA==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr1536026wml.50.1604566841900;
        Thu, 05 Nov 2020 01:00:41 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id q16sm1509422wrn.13.2020.11.05.01.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:00:41 -0800 (PST)
Date:   Thu, 5 Nov 2020 09:00:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        paulkf@microgate.com
Subject: Re: [PATCH 35/36] tty: synclink: Mark disposable variables as
 __always_unused
Message-ID: <20201105090039.GF4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-36-lee.jones@linaro.org>
 <8c45684e-057a-20f9-9a78-b0f6e9bcddaa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c45684e-057a-20f9-9a78-b0f6e9bcddaa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 04. 11. 20, 20:35, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/tty/synclink.c: In function ‘usc_reset’:
> >   drivers/tty/synclink.c:5571:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]
> >   drivers/tty/synclink.c: In function ‘mgsl_load_pci_memory’:
> >   drivers/tty/synclink.c:7267:16: warning: variable ‘Dummy’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: paulkf@microgate.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/tty/synclink.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
> > index c8324d58ef564..8ed64b1e7c378 100644
> > --- a/drivers/tty/synclink.c
> > +++ b/drivers/tty/synclink.c
> > @@ -5568,7 +5568,7 @@ static void usc_load_txfifo( struct mgsl_struct *info )
> >   static void usc_reset( struct mgsl_struct *info )
> >   {
> >   	int i;
> > -	u32 readval;
> > +	u32 __always_unused readval;
> 
> The same as in synclinkmp.
> 
> >   	/* Set BIT30 of Misc Control Register */
> >   	/* (Local Control Register 0x50) to force reset of USC. */
> > @@ -7264,7 +7264,7 @@ static void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr,
> >   	unsigned short Intervalcount = count / PCI_LOAD_INTERVAL;
> >   	unsigned short Index;
> > -	unsigned long Dummy;
> > +	unsigned long __always_unused Dummy;
> 
> You can kill it completely.

Great.  Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
