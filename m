Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2B2B7AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKRJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgKRJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:49:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4045C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:49:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so2092023wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HFTcDZeHbwdubfzDRBdCD5cLqNYQsMR4r/D4QoM7A9E=;
        b=fIqNcNl6ja8EnvxJpWgdSivTffK0XWt93PUp7LrFxkzxJDeFRtNtztf6dYRXd0vQOQ
         OSIGMXRSpZvHHcDg13LTqH1NswQ4hh9turaglP9WSI/LTH78lomhvzgUrL0rRnAQc61F
         mPBQlGBw/96qg+ZUxMMjUwHwvQIneAaq+wvqQErE8AaGH2VcfTWoloS2RtS8xXTG4Puz
         0jtkLPw8xtzXxBfqhGpH+6BDbXx/+EYAxVD7xNamxzZOIjdXivuanjxvGDY91xX9xh9+
         0My2kDduJokNwvAW1ao5L4Ljb8t3b7+bcloT2j7kTtcVbECGqB4Do7HHQ+7LupQyja87
         WtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HFTcDZeHbwdubfzDRBdCD5cLqNYQsMR4r/D4QoM7A9E=;
        b=nutO45CZdzhz0oGjaACiPWfTTmP0gXLjEMQqBeYISm4LPCWjPJ7ijqQUhOcPbXRZl9
         R/ccyDraC3y0PDKvDEJtbZOX2R5dQOZazJoAwwZb/2KP3bfQH1/9KPhUmSRJWv8MIkxW
         qUFGJkKb92NGhsyUC6eLdrNblpJ6J7v3aHvrlRe83Hx9aQzf09V3cvI7pAi8yeHSOCH1
         swvYV4TLxKh1LKrnp9w1u37v7Ql3ORzKHZxsWM+5G4yfg4z2SPvGmydzdXyrwT8PMzIO
         JSWt9/hHkXVyytojne3+jyaY4AhpDYZMD9M2sqMlL0fXOadvJEt35W6lmmXBKDeDFeF7
         hKPw==
X-Gm-Message-State: AOAM530c/WR/x2lYblzwIRoZipAW9DIcepw5oSeIKdw1uwqU4HF6KbTZ
        wU5Uea7zn0zsMEXI209oMiShYGvoXwdTO52z
X-Google-Smtp-Source: ABdhPJyEcNTG6/Gz7Fa8vL0gPcb+JqRdX7fRKh1H/5GyTm2gynqxN0ZHezxGR+PfPl4uud2EMioCpg==
X-Received: by 2002:a1c:9c56:: with SMTP id f83mr3678999wme.49.1605692980555;
        Wed, 18 Nov 2020 01:49:40 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id v20sm2737501wmh.44.2020.11.18.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:49:39 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:49:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Soham Biswas <sohambiswas41@gmail.com>,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: core: Use octal permission
Message-ID: <20201118094938.GP1869941@dell>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
 <20201117181214.GK1869941@dell>
 <CAMmt7eO5te05AuVC+MR-zLB-z+r9FCuJwtON=1QXXY2YwQG0eg@mail.gmail.com>
 <20201118085113.GO1869941@dell>
 <20201118093506.srljfosnamxe5wwz@pengutronix.de>
 <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020, Joe Perches wrote:

> On Wed, 2020-11-18 at 10:35 +0100, Uwe Kleine-König wrote:
> 
> > Actually I'd prefer keeping the symbolic name because this is easier to
> > grep for. So to convince me a better reason than "checkpatch says so" is
> > needed.
> 
> https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
> -------------------------------------------------------------------
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 2 Aug 2016 16:58:29 -0400
> 
> The symbolic names are good for the *other* bits (ie sticky bit, and
> the inode mode _type_ numbers etc), but for the permission bits, the
> symbolic names are just insane crap. Nobody sane should ever use them.
> Not in the kernel, not in user space.
> 
>            Linus

I was waiting for this!

I see your "checkpatch" filter is working well Joe. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
