Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB685262D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIILDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgIILAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:00:23 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA96DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:00:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so2208434edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bEIjD3Fgz65WVghfdzsdddXtKdCJzNlZ7zhZxRvCWO4=;
        b=ta1IxR+zC2l+CxVuWK0IXfx8IDFUdg4W6uIlxwd8GOP2puX7bFjFjwD6en1DZtAq0M
         E9QcAicZeZCFIRO47qLqZaPBnImcS/uVSaIt+PORdG2WS4TKVhWACa3zi68sFwn4lCFU
         0HWv1EEVt3RBsMS87dlaz5A+F67SCDq4kyGnCRCoTJbW37n+ZZ6nyjUXqyEVUEEtj4jM
         vIJLQ39UPU4nggdLAeIanDPLTLDVgGsS93YnPLh0UYEjWfFkfsVtMtw6+67DFgm0KI5J
         0ltyTaLq71XvIPE6WlzrgVYS5GoDuJD5GCXrJjRWSxILcFAYMnc0QTReREa48S4fFn7g
         IYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bEIjD3Fgz65WVghfdzsdddXtKdCJzNlZ7zhZxRvCWO4=;
        b=O/YvgnZjOWnBCCZEARz7RI+FT/lcPwRbEG3cbdfDxntODQ0TRlgEvzvBrkIRuisA4I
         +EBp6t6C2zlpYP3Kea+/lMgalXinpBPZcs/GOpnFfwLefbU4CbSkhNVhl5lTQ9pnQu6c
         /qRQU1OJ8hoBT124x39rBfTQEwrKcQnpS3SKtSCA8njFRPYl/+K1tL/ObN90FWmo9/y5
         wnFeLtFIYQGXdz5YQ6yPAX97quDB3HgBYUHHlvZI8jfVcUd4mCyxOOhr//A/AK/upLqn
         CdW0g8hE1S1bIeea47YB6fOV36YMc19rdz5jauIWmARaoDi7lquJlSu9DrMR/ju6yMKy
         g3rg==
X-Gm-Message-State: AOAM530VrE630d3sri7Q5rodkB5nGFDz7f44tbU22g+SwBIT9WA1XIqB
        Nkcea81s60vhsWZWoX6hk/te3mPHzSZZSYZi6I2TuA==
X-Google-Smtp-Source: ABdhPJzbAc3q5qsLeFjf8EqMqhsMHUgeXBTX1AGqLAvUtMVU7zfDWVI09WmBKw/UB3JjpPnBU6/9Wi5vh0sx7g1LRPU=
X-Received: by 2002:a05:6402:78b:: with SMTP id d11mr3604631edy.341.1599649217273;
 Wed, 09 Sep 2020 04:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153135.3307-1-a.fatoum@pengutronix.de>
 <CAMpxmJWJo=wZmBdAxS2JWVMmg+g2dZG9Do7z+ROy0s37rWTw+w@mail.gmail.com> <20200909103053.bhzh3533km7ky3jh@pengutronix.de>
In-Reply-To: <20200909103053.bhzh3533km7ky3jh@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 13:00:06 +0200
Message-ID: <CAMpxmJXLnbhjt3ZL1j0vJk5Q6m3tqgT15wWDZSpZJ=sNm4_mKw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: siox: explicitly support only threaded irqs
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 12:30 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Sep 09, 2020 at 11:43:24AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 7, 2020 at 5:32 PM Ahmad Fatoum <a.fatoum@pengutronix.de> w=
rote:
> > >
> > > The gpio-siox driver uses handle_nested_irq() to implement its
> > > interrupt support. This is only capable of handling threaded irq
> > > actions. For a hardirq action it triggers a NULL pointer oops.
> > > (It calls action->thread_fn which is NULL then.)
> > >
> > > Prevent registration of a hardirq action by setting
> > > gpio_irq_chip::threaded to true.
> > >
> > > Cc: u.kleine-koenig@pengutronix.de
> > > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > ---
> >
> > Could you add a Fixes tag? This looks like stable material.
>
> Ah, we talked about this in the v1 thread---tglx and I agreed we want
> it. That's:
>
> Fixes: be8c8facc707 ("gpio: new driver to work with a 8x12 siox")
>

Thanks, now queued for fixes.

Bartosz
