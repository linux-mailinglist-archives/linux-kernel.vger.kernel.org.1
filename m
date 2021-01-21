Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE112FE9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbhAUMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbhAUMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:19:30 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:18:48 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 3so2236347ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57AM8icar+jGSxplZHMhnmQzzwwYkYXlIzTACz0r6os=;
        b=mrwPDJW8zJbcrE6VbygJi8d6Nt2bZY1UnmKfpiafqEi+8BH6tlj84OQ4d2stOL1JH2
         g7vhm7cvTeb3S5WBAjUeiNoHeO3k5Uy8ktomtVmtQFufJsrFSrZimK7YqR/YH8ufNcHU
         3lCl3M2eAHhfy7eJmKYnOxHJe8N0PI0WTcLxsakHt1OI8iNj2A9fwaIqDEIEXjJa0tq6
         8QyOskpDggEHFRRtnn/brtamFtio5tHhOOtMchBkrE74oEr/+wPEKiIP848sbbmCVxNZ
         o84OC66Fpt1YwhZ3KqrjJjI3tRvAumGD9OOcmmJGnh+XFTJnk7/zyMS90wirK9rxrZVd
         zYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57AM8icar+jGSxplZHMhnmQzzwwYkYXlIzTACz0r6os=;
        b=gREhRjQfJoiGg5t7u/2t5AKoJ4MW2FwtHKmSYzWq28Oe5o97Po3aj9ifJL6nGizWbL
         7p6PSImfcP7QSRw4iFBGtVSqnrMYx1K4kSh6FkN/QPppD5M1Izh7zOJeLJkDeWKhUng4
         WXpjkHapJOxQnsp3zCaqqQTEzovcgAybSxbUxnPp63qUUwqSuzdsIgIWqZTOhS6NHoox
         S8O8HZ8Jx3baPwdvyINu75PuMl/v0nXWn6IyIypOmaDpEjbhyEay8szNZTOTqpe/h5qC
         xypu8PrXTK3IzEn3l1lTaeAvneSf0IoWecr8+KmJseWWf2Flv1WA/WiJPfXIfCi0xySo
         JOLA==
X-Gm-Message-State: AOAM533ggO1IICKNQfPKUgJ56eZAqWKQprB2YVZicFmSdb581HEsog9H
        mJum1aM559Zubz82FkV7ZDgRqEswYchr20/o36X5xg==
X-Google-Smtp-Source: ABdhPJywRPY4LyL+xF5n+34tfCMmuy4d6FH8zYoKAPB3QO9pVF+5xI5zmXvgGcg+KtqdBQmCxvtgBSEuF4OCSVc1S2I=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr1096787ljk.74.1611231527091;
 Thu, 21 Jan 2021 04:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20210120132834.2375048-1-arnd@kernel.org> <20210120132834.2375048-3-arnd@kernel.org>
In-Reply-To: <20210120132834.2375048-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:18:36 +0100
Message-ID: <CACRpkdZEH0DhSuR1Km0LHkV3pMFQ42uexNLgDb1aegLYduiNtg@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: remove u300 bus driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

There is a theoretical possibility that someone else would be using
the driver as it is not actually a U300 thing, "DDC I2C" is probably
used in a bunch of old ST things but I don't think they ever had
mainline support, and with the ARCH guard in Kconfig we should
be safe. If someone needs it later they can resurrect it from git.

Yours,
Linus Walleij
