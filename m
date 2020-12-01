Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CDC2CA5C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgLAOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgLAOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:35:43 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA10C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:35:03 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id x4so623471uac.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FZpw88N+3+VUth7C3D6FxUOqSb7Nurjv2hndO5p48c=;
        b=olX1SD7ykRDeNr4wL6JrMMCIMTIUi86eCsxE2/O8HSgkUJgc+kwMkHtPaUwNZ/gM01
         2DWk/y6Io/4MzWqEuk4GJJTfdMU9JqhwcHn8+/WdKQ2yrhEk1FVSFLcd1lNZtwKiblUC
         Nd9Fd+DylXsPYAzvpyf5KBETOrhOZxQIK/p0XwsID5UJX2gTKm192HlUUWN+S7nNlvKw
         Kqk+XqaZpV6SQLYIQJ3O/7RvdfZ1SOEs2McMGKrPKP4lNL5NNSPKisZRBLk/fbvwOfCx
         VpEB1AbbALHUauy0diYgE9pTrfD9HxpbwhsoS9akr4t3qPmDaYHQ34qCyNle727x5Wqz
         xMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FZpw88N+3+VUth7C3D6FxUOqSb7Nurjv2hndO5p48c=;
        b=BHYzKbUfv/tSB9F+mEMjOUZJjHfGk0NIdP9ndorHnT79NWasHEKoGold3H0uUABbBD
         /TgL3kY/L0pJZn0LiVz8bG4N2iMTdqsyufSQlWvs471Fxd1a5yD9UQQnaapdXS2E/AO9
         rWCbTJgQSLWxOfvNj6FCUm+kcccyuiPgZnme8+1LTJTd7dtquNhCMS7K1cyjyOKt8gMf
         8nFde//PnYdS0xP/Dl8HsU7DB0nHf6PIgkZxL9eNu2jeZ5yv5ykrpYLdEHzBi5z5Gl0C
         sHy3cOjgKGdCpS5LVW1M5jkKdAHYBW6NqOvj8Nd43yfHXLP96I25A0DtpqwD7o9KIN3x
         QoUA==
X-Gm-Message-State: AOAM532fS1b+rn5UqdA/h1hMSptQ2LqPzA7cYNwPj9MkOzW9KQ58BrN9
        a0Ml8OcU0uiT3+S7qffmAVSu3aLIKJlanQSw2FY=
X-Google-Smtp-Source: ABdhPJwdXbjBXMXvRGElVIB/6ovEWkG7osHaHDmciy78dP25LkhJSAb5xgZittMC3a+rcdhpFy8R8pfkflj2bA9i4Hw=
X-Received: by 2002:ab0:45c6:: with SMTP id u64mr240494uau.58.1606833302592;
 Tue, 01 Dec 2020 06:35:02 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
In-Reply-To: <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 09:34:51 -0500
Message-ID: <CAGngYiWWKOGvMUUXYqkvGVntCjhkG+BJ_JCTSWzrer4P9woSTA@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Dec 1, 2020 at 9:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> I don't know if much can be done about it other than
> having better programmers than me at the task. Or
> less tired when they write the patch. etc.

I don't think that we have many programmers that are
better than you :)

IMHO the fundamental dilemma is between features,
security and agility on the one hand, and stability on
the other. Too much emphasis on stability, and one
ends up with a system which is hard to change, i.e.
improve or keep secure. A system like that runs the
real risk of being rapidly overtaken by a more nimble
alternative.

More testing is good and will make breakages rarer,
but I guess we need to be realistic here and realize
that even with a huge community effort, we might
never get 100% or even 80% test coverage.

But to be honest these sound like questions for the
Greg KHs and Torvaldses of this world, not for me.
