Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD902A79C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgKEI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbgKEI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:56:33 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22794C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:56:33 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so1039346iow.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPgLW1SZzQ9kSf4B4ZPTqu2ZkqCZpDpbWT4A4r46WNk=;
        b=EeS4BjveArSP9SnROzZo8z2sB+17XKrDsG8UA40uYBiOMbKV4DAjsaL55zUB4F7ruv
         LP6HNi+6WKKAOdw+V/uWFUaOr9uMaBOul8FOy4oAm5ToQ8CnUW6zAAFz++URQgd8mVOh
         LBMDv9cbFLg8scEtvH48WE8iURa0XGgE8WF1PBR2bsF+/R7WflyTdm0IIXYgPnv80ItU
         zG5XJWI0BYLXF3PUEdndcuziYChPHr7CEc5yUr+AINrVkblW8H9gdT0gFnATq3sDjs+S
         idrMQNs5lQbG9pxj3UnrK+pOZmjRCdIp1lZOmStWgRtaOVX+uLHncOVMtS0pd1ilvEf9
         Iuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPgLW1SZzQ9kSf4B4ZPTqu2ZkqCZpDpbWT4A4r46WNk=;
        b=tWA8o/an/h0gyYnlwWOIzfJUX1pTpLinNx9yP4hI2Ptwg1JwgaCLKO4oSwLa2C/e3f
         HNQA6qToqiI0+jVwhq9lyWzFkwotjeJR6hYlWq/qTN34rqwLs6LIM4LWkmh8w7POsbHP
         QTNsI6b5K4So8Vwh2sj045BoMJR50Fti0MJlKwY3T/qLpKDalBX24gYzHe5nkYttbH5A
         NMoRZ1oToxpdZ7FeUgiLNlKx6R+Y/cEbatzFQRiQx084/m4N+PKtXw76YnK5+McLvaC1
         LXF5nOG6qEjbB+59nM3bNjF5vzqpWkaaxyjmme53Ch0eKfXNUe79sQcu9B5/Wrb581bm
         D5Tg==
X-Gm-Message-State: AOAM530dYMQLvCINln861IAkV5TZgxftaYlhtbwnz1GHKPwZSqrCnw7P
        WXd30KH3c0cy3U9QhowI4aYlqFeHnGv5hu4dR3fNpg==
X-Google-Smtp-Source: ABdhPJziiq6+VhTFDcItvVspvJFYgEuuTh7S5SSPwUJ2B5yHMojOtUwOBbB7t6HnYqrVnkvtD461PAn4RQGxxOO9F7Y=
X-Received: by 2002:a05:6638:3f1:: with SMTP id s17mr1194399jaq.102.1604566592561;
 Thu, 05 Nov 2020 00:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20201104193051.32236-1-brgl@bgdev.pl> <20201104193051.32236-8-brgl@bgdev.pl>
 <CAHp75Vfd4nsXvDOtbq-2TTcKWzWdwDs28Qm4Kuqa-j7YOR-YbQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfd4nsXvDOtbq-2TTcKWzWdwDs28Qm4Kuqa-j7YOR-YbQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Nov 2020 09:56:21 +0100
Message-ID: <CAMRc=MdR=tADdLmo3grXQq3FjxX7JnWjLBDXSv-j41hv6no-Wg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 7/8] gpio: exar: switch to using regmap
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 9:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:34 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> ...
>
> > +static const struct regmap_config exar_regmap_config = {
> > +       .name           = "exar-gpio",
> > +       .reg_bits       = 8,
> > +       .val_bits       = 8,
> > +};
>
> Looking at gpio-pca953xx regmap conversion I'm wondering shouldn't you
> provide a callback to define volatile registers (such as GPIO input
> bits)?
>
> --
> With Best Regards,
> Andy Shevchenko

I think this was done in pca953x due to weird calculations of banks
and registers. For a rather simple driver like this one I don't think
this is needed.

Bartosz
