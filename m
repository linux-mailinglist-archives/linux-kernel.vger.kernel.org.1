Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7A2CA7DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbgLAQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgLAQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:11:41 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567CAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:11:01 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id h26so734993uan.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZdKwyZiumYGvQbLwgvXVvBks2dSrXavoorQLj9ViOo=;
        b=HbdJcTrT+Bm5snlT4I8yNuYKtWRopqXB48P4o3VVBeVAKEZL2VohViYi5I7dTIuu6p
         5zwVGXKQl/m16KeuJUWiQw6oE7pRxrRVuNZmMiUOWVQKYSDRVWBgOugNyNB0k+1cAd/j
         lGNwiuuUgxQMVVqUebDRL1GyK2PGnDmOeWg6OInjZ27Kg39hr0Kpt1HL5wTZESE3UD3R
         DnHIlKTYC86/oUVGyrZGOTd4DuGfvxHr4lRRuk9rIWdYRuvGDnML7bVuMl3jAauWNYwx
         jk1OPrdKd7DZ3mSdzI1B6o1RjaruFzkJy3Z2HGj9lcMjSyz1zRsAe0gpbeb/QokLF16Z
         aByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZdKwyZiumYGvQbLwgvXVvBks2dSrXavoorQLj9ViOo=;
        b=hY/l4KfN3jCy2TY9w74R/m0FZgTWD/kLoCkAVB4mzPzJ8yq6wJVQCSqvSV0r1ulfgd
         U4tOXw5ygomwsn+Cr5Cg86ke5OYdioin2Wu4KLfVwiCKfy+gegLvZ6dL/9L4wX+ltSnm
         Q3gn1yNCAQuuSpB7wGSYJbbRc8ONoq3vVlQw4Q4el+Q3/m/SFQLFCc2VjjH8gZJr9ay/
         9sG445PdSrg4vgiVh8DrY9hSl0UXjAUMeFjbP0Ooabn12cXNecmCYbo4j+csL1LemWu4
         xitLf/z4N8XQAC0GegTCX+qhIfVurHwzxHmeDmIFZ0m+G2yVvifItlSWB4HrWeNtq4nW
         Y9EQ==
X-Gm-Message-State: AOAM531vAlayh2F+SO4hR80o3FJNn14VHdJU2YMrHvnQaA+isdYuzDjb
        j0xlxpioPPQiY8u57hHBwW2RRZAnpH7vJ0mIE4/Fr1L6jZE=
X-Google-Smtp-Source: ABdhPJzC5bdBhz03oVkaK+E87pEZIqovGzW//4BAUBwEFgEahQ/wGQXo8XGxcbvjVJw0FYa/0y0Wve3lHwiwhYTo0A0=
X-Received: by 2002:ab0:45c6:: with SMTP id u64mr748318uau.58.1606839060547;
 Tue, 01 Dec 2020 08:11:00 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
In-Reply-To: <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 11:10:49 -0500
Message-ID: <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolaus,

On Tue, Dec 1, 2020 at 9:38 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Let's work on a fix for the fix now.
>

Are you quite sure the chip-select of the tpo,td028ttec1 panel
is active-high? A quick google produced a datasheet which
seems to indicate that XCS is active-low?

See page 17 here:
http://www.lcd-source.com/datasheet/TPO/TD028TTEC1.pdf

It is of course possible that you are driving that line behind
some inverting circuitry. Hardware designers seem to do that
all the time, if they need to go from one voltage domain to
the other, etc.
