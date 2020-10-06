Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7526628489A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJFI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:29:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC73C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 01:29:52 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y11so14082241lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Lcxb0EFYpbHarifnpZEA6/8JjIvDW4tuIPYo61CuUDY=;
        b=iZcupjpC8iH5jZgi9UocDaBFiNL1CaCljh62YOeGDu3fXLsho78IXyrxLHktau0fkk
         /eIaTL6CL8zs2X4SES0ZCj5C6cGrPftP0ewuU/4aO1VMu8XMFHWKf/kOyr7daSp17syV
         zoGwhh0ng8mGTAm/5dp0PLZx1GTE8DaVIEdWmbZ8FKTgihZtrZOOKneX1yeQ8DG8svCv
         ueTZH6Zri0umyyPIlwQ6wTyjLoGe5JUKGA/BmqidlgMyY4p3r0k8gverdAn7QqfopoYo
         sOGJWr2UdDv8Zm1wqjFhVjpg5ImpStWrDGmIb0V84fKp9ztSdz62MVjOWJBGR5wlq5AR
         XnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Lcxb0EFYpbHarifnpZEA6/8JjIvDW4tuIPYo61CuUDY=;
        b=bAAdBNu67extmEpLVSCWr9M3X2hMA12bga23Bey07/lnUz7ZpBh0pYuNFrxqrxV+js
         wGMWJuSnA1aPPeAN1mDnqJqEqNt8JYwC1znUWUquXGAq2tBMK4F/V4br71AVDBEZB4RR
         QPUv9GHrOXP0xlOz+rOqREDFoexzp7Roo145iDxT0lakWo2mYjqMA2HZE3NAzAOjn9tK
         sES9GH48ALkNi18tA/C5vzR1mckXYHZREgeW3kvcL/jlzqGbgrtHaqIelR+6hn2a6l6M
         7CPSJkRFd/ozRCVtetFWkXGSinUl5nEksW5epxRRY3mdwRbHuomA8ahdbDJCTvXReWer
         HamQ==
X-Gm-Message-State: AOAM530og+5nwcBLY05y7ISiIVGAlspOWD1oY9Fom1M8KigbakO5/Fg+
        01hvkbaH45/pVV5H/jgPZuJKs9Qwy7PLq2khrBXbyARvdRxeJQ==
X-Google-Smtp-Source: ABdhPJxG0J5FSD9ai75qYxPFoVQs4r2wyF7+PUY0lS8U92Df4lIu9Bce/ZH34NoM0bZbE30i2LmEcwjFhrT+ZHjkQJw=
X-Received: by 2002:a19:e55:: with SMTP id 82mr92759lfo.571.1601972990797;
 Tue, 06 Oct 2020 01:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200830195748.30221-1-avolmat@me.com> <CACRpkdaMK8xkvGiSXx=kVjncB=BNy_jcvKsQNTCxRwSKGKJ8Lg@mail.gmail.com>
 <20201006050427.GA2996@gnbcxl0029.gnb.st.com>
In-Reply-To: <20201006050427.GA2996@gnbcxl0029.gnb.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Oct 2020 10:29:40 +0200
Message-ID: <CACRpkdavVxOKxoqo8RaAJO7iS-B2957u+Pi-TP8aisFVzj=iGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
To:     Russell King <linux@armlinux.org.uk>,
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
        Patrice CHOTARD <patrice.chotard@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 7:04 AM Alain Volmat <avolmat@me.com> wrote:

> Hi Russell,
>
> Could you have a look a those two patches for the STi platform ?

I don't think there is much to say about those patches they are
straight-forward.

I would just put them into Russell's patch tracker. I think the
SoC tree also takes patches of this type for a specific SoC
at times.

Yours,
Linus Walleij
