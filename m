Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774E92A91DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKFI5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:57:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09639C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:57:38 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so855494lfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDbRRGn34zXTBJ75beQCb48hBrXPldiexvEsZ0HXAgw=;
        b=vPAj/NPMq+kZPDTqhNOlXhs13YOHtQWsU/BGtoxbD//dfTm6r07YObI4TBsQA36J8D
         vWGT2aFa2VLD69eizZmhrXhmsOiedzgIYcJPRSjN0ylCXly3pSBuofkVg21AoGTwthvu
         F1igEwb4uHkJf70qaHHLSpBCrsfpHj/xd/7wDUw+bsCj7X+RIXp8TP9zvABnyBn9sGQ/
         g99Zb2pkOEqa7tTsSC1Ep3yaegCxOI89uVZ1wrbA+ZBlKlpIshnOpZvkRArZQWgTZCJi
         T0wt8j3DU2C1DUZQzVdB34f30qubk/SPdguieuUx36aU+tz6Wa7R1ccvXzOls35MGDv4
         x1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDbRRGn34zXTBJ75beQCb48hBrXPldiexvEsZ0HXAgw=;
        b=rbgFd+Ygi2V6IkewsVhsFgdXNsYsHIvjNX5vfpzsqpI8OEK/FhohRRL6HupYOPadpM
         PxC+p8rY9abNVC/PpIOjaRRg4xhKZZMGplJw/4it5lDOVfjeyJphsfhkZm9usnLSzuJH
         00+VDG3nyRZ74EHK8BWD8TO0ub76IhE64rlBP18w5myzgs0UgVKM0CYqfGL3MsIt0Lds
         Vrwsud5WMvkJnZ98Q3nGMYjpW9ct9Z9jWMlGUeeBz1B/Clq1jyXNGdetFqOjcq6iieW0
         z7cI2hNc1GNjaBC6uWmGswLOBQOqpmDKttxac4FgH3Xxmi1txZgbkX3FDURlTbmHweTt
         STAg==
X-Gm-Message-State: AOAM531XYo3RUE334+vmBXW/kKQp3DgEcM4zqBdQuc4kRdeb5LY8LYJp
        0BhjtDC9jHLZg1J43vetNX2ZKZxungBPRjtf12I0u2TaR6I8yw==
X-Google-Smtp-Source: ABdhPJyiBvhbwjuNJtxtQFv0OEV20PHDsdlVuc7QPzzJby5XvH2n9z2dVzk2KL3kyldL3uqTaJSzoDbAIoAoMmJp8K0=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr451651lfm.333.1604653056413;
 Fri, 06 Nov 2020 00:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20201030154519.1245983-1-arnd@kernel.org> <20201030154919.1246645-1-arnd@kernel.org>
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 09:57:25 +0100
Message-ID: <CACRpkdYxJPdy4UY929V5oAXkwx_wxsszxk+iz_C+es5VBVGFbA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 4:49 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> On machines such as ARMv5 that trap unaligned accesses, these
> two functions can be slow when each access needs to be emulated,
> or they might not work at all.
>
> Change them so that each loop is only used when both the src
> and dst pointers are naturally aligned.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
