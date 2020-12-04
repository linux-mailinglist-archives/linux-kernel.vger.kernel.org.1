Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB05B2CEEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgLDNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgLDNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:25:26 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D086C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 05:24:40 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so5314064wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G2i/87OWKoOd5RyqrzLXRtNep0fvq8PXweoPtpWUKlU=;
        b=Iymadjrwejs2qqHd/20RZPYXsszWqeOAa5hGJ+fNvvymZEiwTBSpa/0UfaAmfKG5De
         FSnijVJ9dl+GS2tzE+3tt0YCodlCpcIqe7TS18NrSX1GfI6mGYgLxeVah6DClTDKUvpJ
         ko1iYX/WK9lvozK4BFFZB+T+i1PrcypCf84jd/2eUDRi0W/hcO7WFQ/k4GonSJYa+nsT
         V9cfPEFG4g2DFKQ6H1ie3JDuelEz6xl+t9oBzrQm6Vw+3LhTR8XDQZ7TaXjjiD29GLG3
         er3SJlq9RVUPtRukUqfp9/w66OnoR4dbhWt1qVNUxqbzWcb9BYZhKHqJ20vDyKFWcFUP
         qU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G2i/87OWKoOd5RyqrzLXRtNep0fvq8PXweoPtpWUKlU=;
        b=bOUpisBce3pSWPn9QjapjH0rNj0Dsej8gOXkpjYeNL31U9H56U0ELbNzriE4pY97Es
         O518ipN3D/I6IeMnM1gR7pC2n++mqQFjbljVufkQNOuWUdH3yYKdS0zljm4AyFV023gt
         K8KzpljRLJDzX9djSbrx6m26PDlUgvvDQ+mDxxc9QgA+J7BJYW6+HRWCOO0vs6CWoBKI
         eRBVnT6XcvKc2mQQ2c3ONfpvVaQKNV3oGhKNOJEge4gugC32X4lWYsrRUHtHRcq3aSpi
         Hb6zZOVfChZsco2u0/ud+7Pw6xrYQBS0OxDZEa2PwjLAKolZgGxucpz7GYiyVVS7HIF6
         a7OA==
X-Gm-Message-State: AOAM533gp5Ef+wdBdjH97K/RNGayxcUDBVcEX7Tz7L+J7487zWqJ1kwJ
        Qml7ymRbkh36Iphd956vlhFGZA==
X-Google-Smtp-Source: ABdhPJw/lImQ2qsKmyC6KbfVbRJXc9+9sN15nwpomRdqtYGu5fNOSSIByz0/KKdt7nWbiknysMRHDA==
X-Received: by 2002:adf:f9c5:: with SMTP id w5mr4828051wrr.69.1607088278856;
        Fri, 04 Dec 2020 05:24:38 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id b12sm2894213wmj.2.2020.12.04.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 05:24:37 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:24:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data
 in pwm callbacks
Message-ID: <20201204132436.GO4801@dell>
References: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
 <X8oubGP9CvoOQKtF@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X8oubGP9CvoOQKtF@ulmo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020, Thierry Reding wrote:

> On Thu, Dec 03, 2020 at 09:41:42AM +0100, Uwe Kleine-König wrote:
> > Currently .get_state() and .apply() use dev_get_drvdata() on the struct
> > device related to the pwm chip. This only works after .probe() called
> > platform_set_drvdata() which in this driver happens only after
> > pwmchip_add() and so comes possibly too late.
> > 
> > Instead of setting the driver data earlier use the traditional
> > container_of approach as this way the driver data is conceptually and
> > computational nearer.
> > 
> > Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
> > Tested-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello Linus,
> > 
> > Thierry (who usually sends PWM patches to you) didn't react to this
> > patch sent to the pwm Mailinglist last week
> > (https://lore.kernel.org/r/20201124212432.3117322-1-u.kleine-koenig@pengutronix.de)
> > yet.
> > 
> > Given v5.10 isn't far away any more and I don't know when Thierry will
> > take a look and act, I'm sending this directly to you. The affected
> > driver was new in 5.10-rc1 and at least once the unpatched driver
> > created an oops:
> > 
> > 	https://lavalab.kontron.com/scheduler/job/108#L950
> > 
> > Michael Walle who tested this patch is the original author of the
> > driver. IMHO it would be good to have this fixed before 5.10.
> > 
> > If you prefer a pull request, I can setup something (but I don't have
> > access to Thierry's tree, so it will be for a repository that's new to
> > you).
> > 
> > Best regards
> > Uwe
> > 
> >  drivers/pwm/pwm-sl28cpld.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> I thought I had seen you discuss this with Lee and gotten the impression
> that you were going to respin this to move the platform_set_drvdata() to
> an earlier point, which I think is the more correct approach.
> 
> container_of() isn't exactly wrong, but it's really just papering over
> the fact that platform_set_drvdata() is in the wrong place, so I'd
> prefer a patch that does that instead.
> 
> Now, I can no longer find a link to the discussion that I recall, so it
> was either on IRC (where I don't have any logs) or I'm loosing my mind.

Don't worry, you are (probably!) still quite sane.

The discussion happened over IRC.  I highlighted my concerns, but Uwe
didn't respond to them.  This patch was the next time I saw anything
on the subject.

> I'll prepare a patch that moves platform_set_drvdata() for Michael to
> test. If that works I'll send a PR with fixes to Linus early next week.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
