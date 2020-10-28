Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55B029D65F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgJ1WO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbgJ1WOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:14:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w27so1126925ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pg1Awte/AcCE0VTpWWjF/X+y57TY14JHAwwH73vbeZk=;
        b=N+BWrrYZvcw1eAZEn4Rkvla5ZhdaCVyBOuc8pxi/ev9ojf4qiOCEoNyr4LednIWYHi
         MlXTPk/ebU2w9VwNP9NDCEXpqBs9v3FJgjkxG5NkxgbF4ypLsbxhhNuRAamoeBEYIvDZ
         4WwqwTLFO8/Lg/hMFBrzaUDOLEPyp9MUoNlhitc45ZZUizXRNqtkXgZ86NHnq9Ox7wUs
         dkNnJgm9/GOpasXFOpdXPHuXt6fXcFMpOXN8xuP9tq7xeZg+bMd15zN4cJV9n+e/3v4Z
         3vN4N0knYEjOqDqfAjOkS4tpkW+PpRu1mF7YEtuGLqGpOxgwXsifpbnuGEGmswuatJBI
         LW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pg1Awte/AcCE0VTpWWjF/X+y57TY14JHAwwH73vbeZk=;
        b=nxXGVoCIejLulduFZMcJdjyd0xRBjTovESLwOKpHb/31R6SfKP5XRnzSfJU62e9Lmb
         MY3r6mT28W1L1SaKqb3W3S7/yLsJsaYS2o55ySZCWVKjT9PcEhU/LCRg4o8coOmrf8+N
         JfX62iQ6QYPvYaoBmkVrr5WQZxz5et6BwNXOMSDWnccKQJC5NRBPGY64jKALwCiGFRB3
         ykFN4x2L6BrA0ChjamWU3DS4digstPRkAS+eov5zj4Xs19IC5iSHevM/w4NU+UNf06Qx
         3WPfIh3NWWYT3edgF50oHgQSt1ovbH8uDmfF5c7bNTch7fI8/WwHrNKUdtH/AhxDN3+C
         4EOg==
X-Gm-Message-State: AOAM533j+8oKhYf/ILlZoIg07WEfiuj7ctdOWF+Kr0oLvDikeLC4wsV3
        ckmK7TQbZK2OxDDsISnMTVhO+hs1Jr1BAnYxTczQNdeDYDo=
X-Google-Smtp-Source: ABdhPJx66MvROMytz8Io7gwu5YHeqpdaA/k/cNh1NDS0LzJp5+8ZB4Dy8g7ogYGcrYnupMYog5+IQGiY3y/cw5WxoM0=
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr7958530eje.363.1603903015706;
 Wed, 28 Oct 2020 09:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085748.17388-1-vincent.whitchurch@axis.com>
In-Reply-To: <20201028085748.17388-1-vincent.whitchurch@axis.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 28 Oct 2020 17:36:44 +0100
Message-ID: <CAMpxmJV5sorE8xPAynmc8mtw8aNP_3wm8DNSgx-Wc_fV61jCaQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: mockup: Allow probing from device tree
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@axis.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 9:57 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Allow the mockup driver to be probed via the device tree without any
> module parameters, allowing it to be used to configure and test higher
> level drivers like the leds-gpio driver and corresponding userspace
> before actual hardware is available.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>

Applied, thanks!

Bartosz
