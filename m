Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3602A3F78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKCI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:57:33 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667BC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:57:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w14so17555448wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oZmqks2SMn8Tn8FXhrLnAuY1niX2ucfr4oVkuZRXIg8=;
        b=uI4mZhZskOAeUr3YMa5AjDRjadWqtawqynXbSIH5RZRJfqxjmG9cN6H6/SDLh2xLcG
         fiaDtwhPNTHRvQfbOpa1mIdOvZmWlHN30qmhsdOtYISYY3dXcv6Z8IWYzTAFDygyWEJJ
         VJXfeudV5LqHtQ5aXgJH0R7IZ27q0g0dkgg63VaizfdTXbrIW16v2pz/yaMwlPkr5HS1
         s9I+83COLj0whmVRqajVOcCyd/TVCiZAn44mpZPDCW2WCuziUe7C94iak0nNK44TmRmC
         45myfaN0cOXliMjk6GY89IF6rjTAejWVlFJCwm8JVjeZH3Vmyzf7hafZndhk0Mmj4JqU
         SZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oZmqks2SMn8Tn8FXhrLnAuY1niX2ucfr4oVkuZRXIg8=;
        b=T3Bx8GhyQhI17is/gLWtw3EC9bqG0nzzR1ckBzs6DpSOLE8x/D+1PjQ7M0o8SNbfTD
         esiIzjAdqgjrRYvzaE46rdW5pPVW883WSEM59y2OYJ2jrO2jTlwt9Wf0KsKvIsbT5p//
         Xm1sPM3zEtaf3LsdWm8x0aAzgwkBLp1f4c8eKeN2FJrJJYRcr2ad/dvsQj+el6HlTkek
         ZgntTSCW43vQ1GFT8A1em4O9x9kMWlr/D8w68O3S8wvdj3tLkvsWTUcxwcaMSyZwtyQL
         ztgxMq694X+747JpEhOtD+RZnU4d0U8zKKshZaMMgdNIN3zF2tjD6Sxtw2fgnRWOdFcM
         v/dQ==
X-Gm-Message-State: AOAM530nW2gEIHjTD1cmb6KwGtrr/7nzPqUSatwaCxdx8bo6Pj3L5MGE
        X7DaFSgiPF4GhJGgcdSXxaO/JQ==
X-Google-Smtp-Source: ABdhPJyZirTwO50YfRXPjwlcNDBvcIBv/e2yCA4c+UXQMNNUpqtQUhtTJqNe03GeFwnzfToyHD3dXw==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr26778170wrc.105.1604393852157;
        Tue, 03 Nov 2020 00:57:32 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id c10sm2112032wmb.20.2020.11.03.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 00:57:31 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:57:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] misc: c2port: core: Make copying name from userspace
 more secure
Message-ID: <20201103085726.GN4488@dell>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
 <20201102114903.GN4127@dell>
 <20201102121150.GA663356@kroah.com>
 <20201102124301.GC4488@dell>
 <20201102125910.GA1008111@kroah.com>
 <20201102134729.GD4488@dell>
 <9f10500a-cfd7-bcbe-7b8e-edd49ab4d43c@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f10500a-cfd7-bcbe-7b8e-edd49ab4d43c@enneenne.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Rodolfo Giometti wrote:

> On 02/11/2020 14:47, Lee Jones wrote:
> > On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
> > 
> >> On Mon, Nov 02, 2020 at 12:43:01PM +0000, Lee Jones wrote:
> >>> On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
> >>>
> >>>> On Mon, Nov 02, 2020 at 11:49:03AM +0000, Lee Jones wrote:
> >>>>> On Mon, 02 Nov 2020, David Laight wrote:
> >>>>>
> >>>>>> From: Lee Jones
> >>>>>>> Sent: 02 November 2020 11:12
> >>>>>>>
> >>>>>>> strncpy() may not provide a NUL terminator, which means that a 1-byte
> >>>>>>> leak would be possible *if* this was ever copied to userspace.  Ensure
> >>>>>>> the buffer will always be NUL terminated by using the kernel's
> >>>>>>> strscpy() which a) uses the destination (instead of the source) size
> >>>>>>> as the bytes to copy and b) is *always* NUL terminated.
> >>>>>>>
> >>>>>>> Cc: Rodolfo Giometti <giometti@enneenne.com>
> >>>>>>> Cc: "Eurotech S.p.A" <info@eurotech.it>
> >>>>>>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>>>>>> ---
> >>>>>>>  drivers/misc/c2port/core.c | 2 +-
> >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> >>>>>>> index 80d87e8a0bea9..b96444ec94c7e 100644
> >>>>>>> --- a/drivers/misc/c2port/core.c
> >>>>>>> +++ b/drivers/misc/c2port/core.c
> >>>>>>> @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> >>>>>>>  	}
> >>>>>>>  	dev_set_drvdata(c2dev->dev, c2dev);
> >>>>>>>
> >>>>>>> -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> >>>>>>> +	strscpy(c2dev->name, name, sizeof(c2dev->name));
> >>>>>>
> >>>>>> strscpy() doesn't zero fill so if the memory isn't zeroed
> >>>>>> and a 'blind' copy to user of the structure is done
> >>>>>> then more data is leaked.
> >>>>>>
> >>>>>> strscpy() may be better, but rational isn't right.
> >>>>>
> >>>>> The original patch zeroed the data too, but I was asked to remove that
> >>>>> part [0].  In your opinion, should it be reinstated?
> >>>>>
> >>>>> [0] https://lore.kernel.org/patchwork/patch/1272290/
> >>>>
> >>>> Just keep the kzalloc() part of the patch, this portion makes no sense
> >>>> to me.
> >>>
> >>> Can do.
> >>>
> >>>> But if you REALLY want to get it correct, call dev_set_name()
> >>>> instead please, as that is what it is there for.
> >>>
> >>> The line above isn't setting the 'struct device' name.  It looks as
> >>> though 'struct c2port' has it's own member, also called 'name'.  As to
> >>> how they differ, I'm not currently aware.  Nor do I wish to mess
> >>> around with the semantics all that much.
> >>>
> >>> Going with suggestion #1.
> >>
> >> As the "device" already has a name, I suggest just getting rid of this
> >> name field anyway, no need for duplicates.
> > 
> > That definitely goes against the point I made above:
> > 
> >  "Nor do I wish to mess around with the semantics all that much."
> > 
> > It looks as though the device name 'c2port%d' varies greatly to the
> > requested name 'uc'.  I don't have enough knowledge of how user-
> > space expects to use the provided sysfs entries to be able to
> > competently merge/decide which of these should be kept and which to
> > discard.
> > 
> > Hopefully one of the authors/maintainers are reading this and can come
> > up with an acceptable solution.
> 
> User-space usage can change its behavior so, please, consider the best solution
> from the kernel space point-of-view. :)

If you're sure, I can add it to my TODO.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
