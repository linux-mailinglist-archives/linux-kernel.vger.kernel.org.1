Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F9C2DA39B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441206AbgLNWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502434AbgLNWiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:38:54 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C26C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:37:50 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 6so10243666ejz.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wpovx0yRP9DSFSHvKp2FoFUcoLmrNOPDoYByta7OUGE=;
        b=rb6SMNGBZt9aiMAmP75pi71SxFp4U71SbiaOZXgZBGX2kFsS8n4QV4ukqtdFXI47eN
         hmMw4Z9x+u1picnso5mcnX1fBkkkl3htx667UksHrpZEP9oKfTUBrrw7/fi27ACaK8mY
         H+U4rrpXzzg0PP1CiJzQJuX3ss53pdFy45CpcN1gyalW+ERBfrrf9Xd55uJIy5Z6YpN3
         gVw7xF633vnpn2g/pwh+4slMQTOB9WcptcO3C1HQuTNE4fh1IZt7XFbtjX4uXjbwfYxC
         OuADP/+bc/ftgEvOGzMQ+4TAaTMQlP9xA5kwQCeU61FfY4qPot8qm0VYc06cJ6YJFLJZ
         5PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpovx0yRP9DSFSHvKp2FoFUcoLmrNOPDoYByta7OUGE=;
        b=sOyUoX0U/Sc+RBjyFbzZk0yZdd7E2Aapm4czPV3AbGKeaCbt+2ByN86xmlaAau2bA5
         R/Z1HNyaCkBzPJ4DoWD36If6o11kftdsmm9bNJclYdrBiDmDO/SGrx3X5hrJBPdsKTNR
         LWW6oDTuzFDbhaOskv4DHCJRlEDUrc2Y2rUD2m3L5fmrK4jJG2OTxj+0te9SRQXJiJbK
         V2KAMCGmZaD7IPIqgucPq5pCPTIQZBR7U7R/LPYTuoZPEwWs4VmfpeFiryBbKZhgVh9a
         2LJlS9SNGy3MFe/eL0D2c0J6CGnwZZplZtKNuGXdDsC0hz2KyhjbeJp+yTgPZo3iFJz1
         2NRg==
X-Gm-Message-State: AOAM533Ey053W5oIiiAQ5WEq697GMPKFe3m9RO2/1U5c5En3pg0ojL4s
        +887t/KvY0nsBK53H33LEiFekb8jyBbOsJFXitp4qA==
X-Google-Smtp-Source: ABdhPJzC7PpZxBF4DcMj8+Z3cC+llQOjyzGnQfaUrl0pxCufDJ+pt5cfQ26vem5rM+34GGbngoeX4hKpgYy9Of8p/0o=
X-Received: by 2002:a17:906:82ce:: with SMTP id a14mr24610695ejy.421.1607985469261;
 Mon, 14 Dec 2020 14:37:49 -0800 (PST)
MIME-Version: 1.0
References: <1607934255-52544-1-git-send-email-luojiaxing@huawei.com>
 <1607934255-52544-2-git-send-email-luojiaxing@huawei.com> <CACRpkdZSQSCO3dWcjUZtUMDK+Jjdnc9ORxpR9qiopgMk-o=Ryg@mail.gmail.com>
 <20201214165812.GL4077@smile.fi.intel.com>
In-Reply-To: <20201214165812.GL4077@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Dec 2020 23:37:38 +0100
Message-ID: <CACRpkdYvBrqHZt28fyHD6F6a4ecbzvfGknpfwr8HFdtYodaYgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: gpio-hisi: Add HiSilicon GPIO support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 5:57 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 14, 2020 at 10:11:23AM +0100, Linus Walleij wrote:
> > On Mon, Dec 14, 2020 at 9:24 AM Luo Jiaxing <luojiaxing@huawei.com> wrote:
> >
> > > This GPIO driver is for HiSilicon's ARM SoC.
> >
> > Patch applied, any further issues can certainly be fixed in-tree.
>
> I just sent two :-)

Thanks Andy!

Actually I kind like this in a way because then you also get some
credit for the heavy review work that you do on new drivers and
so often go uncredited.

I'm sometimes tempted to even add "Co-developed-by" for the
vast improvements you bring up. (Like on my YAS530 driver.)

Yours,
Linus Walleij
