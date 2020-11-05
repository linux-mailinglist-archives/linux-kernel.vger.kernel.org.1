Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595FD2A79AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgKEIyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKEIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:54:53 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB984C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:54:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so758963wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DHpmdT6XWTyxBCx6QGRcwoEMVDpPPePkLjV0ySKwsHI=;
        b=daoS9fpqZXYiO3Dhbgu9BWYoa41Pk5I23GxWeEqlzGVrZZ3jxsH01Bufc1ANDK50rq
         wCRbIjiiBgA/xA3RoYKoPc0yfKipXIMgsrZgEXgonKohzla6+buO2MT49Um72hhWPZFO
         vJFweEGXFyOPiEvIo2dvQBheKENpvqrL0GEXE87e0lEqgXD8fqv0RjULeoqVqDWJyemN
         Y2Z/CaYsoPBE53F8zR0+wlFmXzxlPGx+KoMzZRhluARy7TiOc5hEqxVvCjs4pkz8uBBI
         dWuGhMYk3HVIBBWkaX+3/BeWfQAhQYgGcVwP91jeb+j86XMBy3rEHr+l4ptghkJl7cA9
         lvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DHpmdT6XWTyxBCx6QGRcwoEMVDpPPePkLjV0ySKwsHI=;
        b=q8/gwlmKrF6QhFzZx4XmtIRSk2JiiwHnL/Hzm+p9zR08ir6vT6L6YXo3xsqLOI4RoO
         wCQI2mgyCu6cMCQX08lbN8O3Y/X+NrDF/j3PzJnmaS2jH5LPg0VRIb2drI9Iy1wKX0cj
         upgMkERmCdg96k23X/dKtFKzh4CbuzWdeFKCQ7neDbo3T0Qwq59lZYlEJf0rtnQNH2Gr
         /lTNS5mJcgiu/zeX1jmH1rYY4+zdcf5jQvsGHMqq+IL4eI22dRn2wLax9axQbt+Ix8J6
         u176rps5NkpQe9ZxuceE1cbTUxo0ubdQ5SnpsY+PKzajZfp7iT1eBBoF56nFDgN1iZfQ
         alqw==
X-Gm-Message-State: AOAM532VVDJShNipOJFeTA3x3n4rkqmQSYkszJcIJ9kKPHTO6OnCzDOd
        x3U0njewYZYBoW0zzRSBFz46Ow==
X-Google-Smtp-Source: ABdhPJzySUbdyBiMqmsWFYSIfQMhGDRle1bYAwQJUvPs5Klko56DSPtzZz2OjwSZewM21nPumfUibg==
X-Received: by 2002:a1c:55c1:: with SMTP id j184mr1545560wmb.180.1604566491469;
        Thu, 05 Nov 2020 00:54:51 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f23sm1516359wmb.43.2020.11.05.00.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:54:50 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:54:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/36] tty: tty_ldisc: Fix some kernel-doc related
 misdemeanours
Message-ID: <20201105085449.GB4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-9-lee.jones@linaro.org>
 <8f07fa1e-d81f-fd43-9dfa-bfb9f9171619@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f07fa1e-d81f-fd43-9dfa-bfb9f9171619@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 04. 11. 20, 20:35, Lee Jones wrote:
> >   - Functions must follow directly on from their headers
> >   - Demote non-conforming kernel-doc header
> >   - Ensure notes have unique section names
> >   - Provide missing description for 'reinit'
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/tty/tty_ldisc.c:158: warning: cannot understand function prototype: 'int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD); '
> >   drivers/tty/tty_ldisc.c:199: warning: Function parameter or member 'ld' not described in 'tty_ldisc_put'
> >   drivers/tty/tty_ldisc.c:260: warning: duplicate section name 'Note'
> >   drivers/tty/tty_ldisc.c:717: warning: Function parameter or member 'reinit' not described in 'tty_ldisc_hangup'
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/tty/tty_ldisc.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> > index fe37ec331289b..aced2bf6173be 100644
> > --- a/drivers/tty/tty_ldisc.c
> > +++ b/drivers/tty/tty_ldisc.c
> > @@ -190,7 +189,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
> >   	return ld;
> >   }
> > -/**
> > +/*
> >    *	tty_ldisc_put		-	release the ldisc
> 
> Having tty_ldisc_get in kernel-doc, while tty_ldisc_put not doesn't make
> much sense. What's missing to tty_ldisc_put to conform to kernel-doc?

Where are they in kernel-doc?  I don't see any references.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
