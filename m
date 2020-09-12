Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14F267963
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgILKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgILKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:14:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFE2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:14:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so8344824lfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBccPzPZ2YTyc6MlKlPsvIVV7guFEGuVrYceUR3+Rf4=;
        b=d+OPRFt9JXvkEKZ64+tj9IFUJ4907bRj/OmZIk9KnxUmCQmNHLxXhrNtUQqcqUFVAP
         yztLccas0tE0GkjUlhfPdr5i9CZYT+hBOUDYRzkQEMP66q8HGzlf7BdKrwExomTY5vCr
         6zJ+dyaiq9MsEfmDIj68uvKKp6L+l3PP3Ol3QCtooPVsJLdTtjWftAxhtW83kCtWjDwS
         nHGFur8ySqI80mna/HKhPLNqMPcXinDCIodiUYo3dor5sKzqQKCPhnVbKrsKCSDBnA+B
         7cIhGxW70E5pnxikJ5RlzciDVJLjl2c8+7CrDK0RuPRomEwPxjat3LiYNnk3YPwRhZGr
         xOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBccPzPZ2YTyc6MlKlPsvIVV7guFEGuVrYceUR3+Rf4=;
        b=AWsdYPslXxwEhWRZ/vqK7p7VUUe+D2gDFrK2Os6Kcp4y94+dV9i6gPidMfmEd1vsTq
         Zccvq0WFRgQxxWZOriGLdEf0kkYcp4nAucNi76N7ZOqfH+4CCrZWt1MxNI0mQKk51JVF
         Pg0ENK9QWtnKIEN4gv5mBcYM0y6wDRjgi9qRTgzub++BBt4E58//ciNx2FlBlOduR1xv
         1uMWWGrwxcdPvKegY8S2KT3Vg1pBUbMoAhy94KtLIG40nruHQZxeKGDt/q+ALjFZlDaF
         EuWY9xLx80oBeR2SJthEcSx/h9dch22HUHqinZsYtTGZTnzk3HsHvFbx+Ll1uUbARXZO
         jxxQ==
X-Gm-Message-State: AOAM533T9HHIXobqPl3S03faOjTJpYQFtLZoAVV+lwijkmT1JCx7N8DN
        0LlC5Dd1zaWI2Kmj3YvhkhiASb3Mv8wZ//yZN3G4LOa6VK6lZg==
X-Google-Smtp-Source: ABdhPJwt6ftsLinxhDZqIFzA22RlkzFr8tInipb89v2/wRu4ZSHPSsjsvjpLMCzSGQGWgQXndoWPq1WjS+atO/1E3oI=
X-Received: by 2002:a19:6419:: with SMTP id y25mr1528439lfb.333.1599905650598;
 Sat, 12 Sep 2020 03:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200830195748.30221-1-avolmat@me.com>
In-Reply-To: <20200830195748.30221-1-avolmat@me.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 12:13:59 +0200
Message-ID: <CACRpkdaMK8xkvGiSXx=kVjncB=BNy_jcvKsQNTCxRwSKGKJ8Lg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
To:     Alain Volmat <avolmat@me.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrice CHOTARD <patrice.chotard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 9:58 PM Alain Volmat <avolmat@me.com> wrote:

> This serie update the STi Platform LL_UART code to rely on
> DEBUG_UART_PHYS & DEBUG_UART_VIRT and add the STiH418 SoC support.
>
> Alain Volmat (2):
>   arm: use DEBUG_UART_PHYS and DEBUG_UART_VIRT for sti LL_UART
>   arm: sti LL_UART: add STiH418 SBC UART0 support

Both patches looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I made some patches to the debug UARTs that are pending in Russell's
patch tracker:
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9004/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9005/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9006/1

It doesn't look like these will conflict with your patches but please take
a look just to make sure.

Yours,
Linus Walleij
