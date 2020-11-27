Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F632C6D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgK0WIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgK0WFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:05:53 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D20C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:05:52 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id j10so7435195lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhQQTyukA0hBMXZZ9IFzOlq0mvJ89vDkRZ3YCulgyfQ=;
        b=KslCAcATqBJOGXCSY+koKy4jqBiVmAo+dzC834xJuW1iV9pRl7H+bNhUXlI5qRk00l
         C2YT5zjSYjfbrVnXH6zVAmSZondZmvx5rpc1jXSOl9dVtudU29NpJqElbfCJ+7pN28v2
         uACCJ2w3EHGN++ZtcbrJ5jyVpAApKGIwkJJVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhQQTyukA0hBMXZZ9IFzOlq0mvJ89vDkRZ3YCulgyfQ=;
        b=YpswI7rYTdFFS2LU1KV17o01Rh9Gr2vWeh+Kg3S6Ds3/Eibd8V2mNtdJCG9NhNWOxC
         meaBBwCwFJKIjASV8x+Tjj3fhiaTzdudCTDBi/D4RLd7+i+Ien4VpXj1M8G2sKP7fDTr
         pf701pPqeBbId92xplorxQ1YqZZYyIUmpju9D8R2vM/M3X/bcUJkGvN8zslk87TcogPE
         WLPj9XYQpdc+gjMgI8PtFgsZC6sBEWaAYsJ+oEarwKOwjkg28JQeGo5LN6q/7gfYrEM3
         G1l5IfF+Cxj+8MUgnJeb4cmLl//Bd91sO3ntzO9OiFyHvO0fSFvjtp5tFFs5432mXK+X
         Vv/Q==
X-Gm-Message-State: AOAM530fUwo3U+06RJGLj+4cbKcdOPewgjMbu7INlTiWd6zJDu54VEWg
        hiBcjvsyyCDIznpLJ6MMxBBXpNqZQ7kNuQ==
X-Google-Smtp-Source: ABdhPJymxPNep+MJ2/lqa6gSz53ID9Zb3UwKNO1STo0GxHeaXnvxavfjfhCWyINpDHt+dQRA92wWQw==
X-Received: by 2002:a2e:8792:: with SMTP id n18mr4445256lji.417.1606514751060;
        Fri, 27 Nov 2020 14:05:51 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c17sm839788lfr.135.2020.11.27.14.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 14:05:50 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id q13so8244896lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:05:49 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr4183355lff.105.1606514749548;
 Fri, 27 Nov 2020 14:05:49 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
 <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
 <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com> <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
In-Reply-To: <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 14:05:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU4DCuwQ4pXshRbwDCUQB31ScaeuDo1tjoZ0_PjhLHzQ@mail.gmail.com>
Message-ID: <CAHk-=wjU4DCuwQ4pXshRbwDCUQB31ScaeuDo1tjoZ0_PjhLHzQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Emese Revfy <re.emese@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 1:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>     33.68%  cc1plus

So a third of the time is the _single_ invocation of cc1plus, which
happens from scrips/gcc-plugin.sh doing that

     $HOSTCC -c -x c++ -std=gnu++98 - -fsyntax-only

thing. Which is purely to verify that plugins work.

Ugh.

Emese - I'm talking to myself while I'm looking at why "make
allmodconfig" is so unbearably slow. This is part of it.

              Linus
