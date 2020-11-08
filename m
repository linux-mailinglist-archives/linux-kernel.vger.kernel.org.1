Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D32AAAA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 12:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgKHLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgKHLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 06:19:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A0C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 03:19:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so5361326pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ypFqyizBtI+bG9+f2gee6r9YBqN51Gv1uLtChfql90=;
        b=eAi7BeycYrQsdFpDuCS8MgBXcaQfRzpLQ3B+R03IC/8zq8gHlsRqIwAeJYRBghZqHG
         lTvLL+YRLj4ktbvJ6LjEZUdHSigvJpGe1LiM8tWEB0Tcc0XdRWwm6uKoju8WcqRVpIiA
         o7zQAuLjVvaCWetAk58lho+mbivsHEzodjHE8fKddi57lodBY4Wc3hbRYB3QteKEiuuz
         mS7RDy7V/asDkjNCJmy3u/rN7zzeGQOv1AsqdH9ZJq10O16E2sS2+RDiY/W64hfN+GYP
         jY/aB2Heob82kX/7vO4hQMlLwFRS8wwS/WpGMtZLluTmsh5clyVW9bcblH664+JMtvOj
         PGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ypFqyizBtI+bG9+f2gee6r9YBqN51Gv1uLtChfql90=;
        b=SZS/k1cDiyOsZ7+u/bEv0W+XPtokqQkRO3Ak65yB+nPxXHnIqc+4JDFZm6Etsu6HkB
         4uWghGhp90xzvYvQ1fwn8fHBAceT+UhHLX9ZrWcSx55bQ1t/rkayfc7puvXiRmzF6Pdj
         QZ9zr1GcFQRZJU6MZANOClLiY8XAyZgA5FqmMtZBJV6ALQ6NtCMYbKVVrcS3pPpSZPEY
         wd/TUqwnVqMx3aS/V3BgeeIrgqSDpydpKBuf0r3X96m2ADEjqiWgIOEechvVyBWgbPR4
         BAj1ONQXz3YXvmo0ej3YxPHVuAC5JcLN80j+Jj4fV5iT3rmKq1xOK1txEjFMCxRfMdsg
         xtbA==
X-Gm-Message-State: AOAM532xtBwgMM3S5cynU/Qe3qPN/ggjzScRnUFBo6nErQLkIoOCP6VP
        oe4Rv9kyAhEjzvmCIxG7k6Tij3gRzTufRkTP
X-Google-Smtp-Source: ABdhPJwOYydXZpBfJT1LjKbjX7KMWb98jpiO0iRJS7UUuINPRXEOFa+g0Ur/ZmpUUKJ+I1s+MUWE9g==
X-Received: by 2002:aa7:942a:0:b029:164:a853:f0fc with SMTP id y10-20020aa7942a0000b0290164a853f0fcmr9250990pfo.40.1604834392880;
        Sun, 08 Nov 2020 03:19:52 -0800 (PST)
Received: from atulu-nitro ([122.164.210.133])
        by smtp.gmail.com with ESMTPSA id i17sm8069407pfa.183.2020.11.08.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 03:19:52 -0800 (PST)
Date:   Sun, 8 Nov 2020 16:49:46 +0530
From:   Atul Gopinathan <leoatul12@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix coding style problems
Message-ID: <20201108111946.GB10284@atulu-nitro>
References: <20201108083515.5256-1-leoatul12@gmail.com>
 <20201108091136.GA44749@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108091136.GA44749@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:11:36AM +0100, Greg KH wrote:
> On Sun, Nov 08, 2020 at 02:05:16PM +0530, Atul wrote:
> > From: Atul Gopinathan <leoatul12@gmail.com>
> > 
> > Hi,
> 
> No need for this to be in the changelog.
> 
> > 
> > This patch fixes some coding style warnings and errors that were
> > generated using scripts/checkpatch.pl.
> 
> You should be explicit about _what_ warnings and errors.  And probably
> break them out into individual patches, one per warning/error type.
> 

Got it, I'll keep the above points in mind.

> But more importantly, always run your patch through checkpatch.pl when
> you are done, as you just _ADDED_ warnings to the kernel with this
> change:
> 
> > @@ -895,9 +896,10 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
> >  	usb_reset_device(dev);
> >  
> >  	/* return -EAGAIN, so the creation of an audio interface for this
> > -	 * temporary device is aborted. The device will reconnect with a
> > -	 * new product ID */
> > -	return -EAGAIN;
> > +     * temporary device is aborted. The device will reconnect with a
> > +     * new product ID
> > +     */
> > +    return -EAGAIN;
> >  }
> >  
> >  static void mbox2_setup_48_24_magic(struct usb_device *dev)
> 
> You turned tabs into spaces, not allowed, sorry.

I truly apologize for this blunder. That was a really silly mistake from
my side inspite of having seen your FOSDEM talk on 'Submitting Your First
Kernel Patch' and using indentations as they were intended to be a
hundred times.

> 
> If you want to do basic checkpatch cleanups, try starting in the
> drivers/staging/ area of the kernel, which is much more forgiving and
> set up just for this type of thing, instead of trying to do this in the
> "core" kernel portions, where you have to deal with other real code
> changing happening at the same time.
> 

I guess I'll start with this instead of messing with the "core" code.
I'm still in my learning phase, so checkpatch cleanups are the only
contributions I can make for now. :D

> good luck!
> 
> greg k-h

Thanks a lot for your patience!

Atul
