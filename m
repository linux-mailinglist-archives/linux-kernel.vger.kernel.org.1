Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E02CA8D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgLAQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbgLAQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:54:56 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D854C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:54:10 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id y26so792213uan.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvxLNP0+Dun/ZIW79vOWfWns3V91bn/ACv08wEuiwsY=;
        b=OB5agNrIBxaBFXkG2EvBefdM6/P/440YEoaCeCWFPu45dmabzIVmd3UbykBbKrtcYM
         DcmEcN4xljLcKH4klVHTkl+5bkn4CfgChxkaTmOqNvrYVzSWlLXilCMW92YR3l54jHWd
         EChgbS79pIEEZuLjkcgHIlKCSPxemjxVnbXUUf8DXLAWEZOowSJMaAZIhrhC5JO7YUjT
         ocxOUEggpX0GsAw7N3wOORwzTYosM8cTc+a+vqaZ+sVVjDWc4x+6Z1igO7CRcFYLng2i
         oSA1TIgQJyvcHhhxlqmtmHwW0G9PGWu82jo1J8tg/JCRzWFw2DUVL8gjlk/fItDl1k/a
         TCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvxLNP0+Dun/ZIW79vOWfWns3V91bn/ACv08wEuiwsY=;
        b=YxZPSo60S3ozz0Crup3zbhijLR+lKo5eKZe0oWNX2lRioIsLNG3GdWOCT55Tbc52kr
         iqAGmmU/jwZlgJ44YzYW6Bp+/hxViqrif8KRxrj3VDU56tjQ7hfxBOWbgoB+1eSlqXL+
         cVMrCGvZoaTUNAhUHMjXtxJ8J+o3klv6BuluJgtXqTlfx+lVQNAQ21KDFqM8ws8UYhUn
         koaw7wYJ2QclwPUhoRYQehOU7MgoJfyHfK0Fn5o8NtaKnn4lgEObKDck1xl3RcfGHo6j
         2THTOK7e+juHY3QBOQi4PTtQfPGiJxGFJ3ZVty2X+u1abeAVw9xcnYYBeJ5lLNVqqd2Q
         5O6g==
X-Gm-Message-State: AOAM530ZFyQeE8eS2E+5xWfHM+7UrGYj/tfRwnsBjTatAO/RwbnsiE4d
        KWx66FlHjCSj3tB3bejjQmz+sTxRYAnK+LoyXgTF2MYJ
X-Google-Smtp-Source: ABdhPJyIMFDaPkyo1PUaGJziEs/R/EfNzoMVDbmllTRruL7yfjU2rUgeLZjY54b7sLyVueTlw+Vbz65TMwhmiKygTrs=
X-Received: by 2002:ab0:1d83:: with SMTP id l3mr3937580uak.41.1606841649476;
 Tue, 01 Dec 2020 08:54:09 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com>
In-Reply-To: <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 11:53:58 -0500
Message-ID: <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

On Tue, Dec 1, 2020 at 11:43 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> You are right. It is active low.
>

In that case, we have a very simple solution, just remove the spi-cs-high,
and things will work.

In case of SPI CS gpios, the current kernel ignores all
GPIO_ACTIVE_HIGH/LOW
flags, and uses the presence/absence of spi-cs-high instead, to
determine active high / active low.
