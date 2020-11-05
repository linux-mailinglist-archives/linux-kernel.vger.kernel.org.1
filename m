Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BE2A8111
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgKEOhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgKEOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:37:47 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:37:46 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id p93so1772312edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gx4esp1H+t/CRh0pOUP9iWgL9zCSVVT3Kg6Fjz064Mc=;
        b=Sza5uuRbnhrTeO3gZcJ2wSko7ScXGXe6WF+mW9RPfBtta0I5Pn7urHmD6fJSA9ByMA
         XwOOqdtt7gQFYbbBAEkv7Jr0wgE7Tw7+cMWvAqFfZfJae0mhMOAY+A34sfyIvUTBOrjV
         qQpPzrc3K2wRG1v7odAnsTQ6c8Nl6gMJLKclgI6j+2DwAMbACeb7x3qli21ekKOcUzSW
         +/L44Lm5zQngoLduVkdihL3/By/4iwo/mWkB78kLzAOLHyhgpgu3x3K8pMulfHlDb2B8
         V6a6s1E/lqcOPTPsXbBji1+Q/4Sz7ha3aehBRJ5nimjnlcn1g9Pb9uDfGyxDziuT81Yl
         UUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gx4esp1H+t/CRh0pOUP9iWgL9zCSVVT3Kg6Fjz064Mc=;
        b=cbNnPNmcP2cPj1ljyY5o2Lar1ruuRMvDcjoTmvGWgIgInbIrecgaTiLByBjv0ZaVNv
         v7HGkjE5A/DIjlW+1U3diFo1RUOBT6P/TUTFh4Yo2eat7z5CQeFbA436hdlUVRGIjv26
         xmQC2Zazis7DSffB7pAy9iqkzbn7kQHJWlk9CUmJIzT5A824bDgye4SNIjFIZay6Ta0W
         Re/BzA3AhWN0OWq6CK1XONTX3lBa9AaZx4Oreff8CEnbP1X1xl5hsqWC+Wm3f6QC2tnv
         NjkXIo/9IbMOOUTRjf4Rb5AelhrwXBBTfcVgS91HvGLM0PAA1RYBFIMv/n7G3NCP94eB
         TiBg==
X-Gm-Message-State: AOAM530VqWGEM3VjfdU+dPtBzSa5aPvXzaK94vJOdTRMjGLPhWjn0jjg
        apNxgDPN1T9VI6mqmu+QME/HiEizFxJQWX62xtcemg==
X-Google-Smtp-Source: ABdhPJwTgu8lGloY30zcE8UObChuYq/kswE4wTmWEggG5cOpkg2mqkw66qs/1O6wNJd3gsLrfMuyXtjBLxSyvIi0CRM=
X-Received: by 2002:a50:99c3:: with SMTP id n3mr2893903edb.213.1604587065503;
 Thu, 05 Nov 2020 06:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20201105104049.91077-1-warthog618@gmail.com>
In-Reply-To: <20201105104049.91077-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Nov 2020 15:37:34 +0100
Message-ID: <CAMpxmJXFsMYOVOHY8zp-C6gF9q6sfi=HuUYiSDmZBDYiJNDh3g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix sysfs when cdev is not selected
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:41 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> In gpiochip_setup_dev() the call to gpiolib_cdev_register() indirectly
> calls device_add().  This is still required for the sysfs even when
> CONFIG_GPIO_CDEV is not selected in the build.
>
> Replace the stubbed functions in gpiolib-cdev.h with macros in gpiolib.c
> that perform the required device_add() and device_del() when
> CONFIG_GPIO_CDEV is not selected.
>
> Fixes: d143493c01b7 (gpiolib: make cdev a build option)
> Reported-by: Nicolas Schichan <nschichan@freebox.fr>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Applied for fixes with Nicolas' tag.

Bartosz
