Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A751ACF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbgDPSND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgDPSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:13:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252BFC061A0C;
        Thu, 16 Apr 2020 11:13:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rh22so1984335ejb.12;
        Thu, 16 Apr 2020 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BujPtYkPgE5qbv/kcmnLou5PuLayVpEmjsVIPVlZ6c=;
        b=MI3PIN03g9mte9tt/J80yvDslXb3w5cZmZDi6gm4zlUVzFOR9lZnuarDbb8wWGmYJm
         NKMmuKGIWz9Nz2eRwTDCAUTxmweTc9el3ER8sG3w1TZGBshbNfx0vMTldgm65Cdlll78
         WZ0BOuepmKQy15b9XnY3Qdn8gQLvqy1E4Q2orei2X8a6KbkHoOcwwOtIxXnDlFnjGLph
         WJlmU9GbCvAa/WFA3EY+gzuUHVqwVyMe8Qx3igEX0O4wX4MUu293I9QfiuaXqLadpIhX
         KsQFZRC2lLEBWh/0JvCD2aW0+aa7shBCg2fiEqcRiFN3SmaW39m+JikfaII+EJxJHEzA
         2dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BujPtYkPgE5qbv/kcmnLou5PuLayVpEmjsVIPVlZ6c=;
        b=oLL1r9gIwybtF1nsOLKzkb08QzxpwjJq54Whs04wHb//67N3rUGeIRSkxigTOty0W7
         9+ISw4OHMUUtZD+yPQBjh/sOgdKee0Mpdni5utdsD/CmSbM01plMZMRCflUYR3SKxUFU
         WCNJkBWNylMWGOXPw/VJgV1dmfQO3e9LyWEx6kY2Pb84ZGcXSJ4HkBMhLsDrHvPV3S8u
         rU+wEd1wh75JFwhbyN0yE/GxFWQx17ZpfkVlPCsOS8EBmxlWSHxXQZZkmhSwnOrQa5Ko
         JHzL8BORE+S0RNXjK8/QWDz7rBz0j2iZJiJLhcZxdU3KhvKxHDL3wgX4yJrl6iO3oc12
         fInA==
X-Gm-Message-State: AGi0PuaBEjj1tzAeoy40lDOgM9m9b5RCEBY5d8+rI4OP2qL5lt7RoDaO
        ASGANwH9xyQquQqXwe+31hT1MUXT2lTqousjfWE=
X-Google-Smtp-Source: APiQypIkLNljPlUdohCkcdi0muKk9NtkNh8bkA9dgBVjbBN/j84bykCU96fEtuK2GZpJZGQwXkyrDlqZd1lfhqCqzrA=
X-Received: by 2002:a17:906:2962:: with SMTP id x2mr10118232ejd.233.1587060779605;
 Thu, 16 Apr 2020 11:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
 <20200414200017.226136-3-martin.blumenstingl@googlemail.com> <1ja73bbtqt.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1ja73bbtqt.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 20:12:48 +0200
Message-ID: <CAFBinCAtSPTHfbr5KGNFFg3eo_d2p2q59fQfMXu+XkOb8WVrDQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: meson: meson8b: Fix the polarity of the RESET_N lines
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Apr 16, 2020 at 12:38 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> >
> >       if (id >= ARRAY_SIZE(meson8b_clk_reset_bits))
> >               return -EINVAL;
> >
> >       reset = &meson8b_clk_reset_bits[id];
> >
> > +     if (assert == reset->active_low)
> > +             value = 0;
> > +     else
> > +             value = BIT(reset->bit_idx);
>
> if (assert ^ reset->active_low)
>         value = BIT(reset->bit_idx);
I can do that, but I prefer "!=" over "^" because the result is
expected to be a bool (and because I'm not used to reading "^" for
logical comparisons)
will this work for you as well?


Martin
