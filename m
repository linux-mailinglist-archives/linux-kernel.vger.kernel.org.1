Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC562AF967
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgKKUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgKKUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:00:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61030C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:00:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z3so2276974pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUj5Ux6T0pAvZX6aMMGDC3TkMnjTVY1hpdEEFVZyifc=;
        b=u6lI2X8lX1/O15vgA1f7CK1H9a9YEcN+4UrDGICzNhQevAW7YiUdk9ZtClLxZ/fqzD
         4ygBaK6iPZ69ujXTrxDYGXozxaVMAWBjiX+PDclhR1b6k2cEl5HeQTeT5fuI/aQPws3S
         K0lGtFYGItBfxecSZk1TKRH49FHut34zzwrjb7myLQ64Z+/vSXx96dPi65y+X/y7W/vl
         tcxxISeKHvlPkZpoPIQAKgsmIU3Y8Rga8jS9x6jwj2hHdLGxQx2CCcGzpofIKH7NEVeq
         pamBM3liI3N47uoT9EmPfwh5BPHYfd6C2iYE1w1U2p9aAyCeqmdYn/yr++3zYUHqc3He
         kFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUj5Ux6T0pAvZX6aMMGDC3TkMnjTVY1hpdEEFVZyifc=;
        b=njCfFcZwDgrJGLT0EL6lAyT2IY6gyn989Th+Wc8H1cHy2wSb9PxKm8bFarVGw97k9Y
         +sOYUO8fJ4D4S0AuBqTKs622PEKh9vfu8z/sFxIUMEMHm9GdBfKu/NK4AqySIP74KCda
         xVIkM5nDXrs95J6ryoLlOFwBlJef5FvoViDEbfhtdaKyqP3zXW2n3SmnIxA73D2iVvFG
         5Ld8ugadB4iXaRvPPMQ96XesZxw0XNWp5qXC3+Zgf3vWCBuFF7oVBam9KO0L/hquRvxp
         yF15ZS/a9MvALwWyYC2HgQ0cJLYuqveqE3TRXJppPDVGvFiMu+mEj6hvhRcVnjbifWAU
         D1jg==
X-Gm-Message-State: AOAM532j9s1kChPuoHi00UU2aAXAD6uJrIPeDtvPHCTYN31ddDEbQxjt
        r2qRdyIm+JcmmrUXyBv+3BNsMgws5vsWsbmrMskw5g==
X-Google-Smtp-Source: ABdhPJwkUcYBtbuvz0wA+LPzuXGAy0FVPrRT5hucnF0lm1Je0RMJAtXomFgUQEXCakldEHfeFwvTAEmtCuGpTw9Jwwk=
X-Received: by 2002:a65:4b81:: with SMTP id t1mr24128814pgq.263.1605124848749;
 Wed, 11 Nov 2020 12:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20201026215236.3894200-1-arnd@kernel.org>
In-Reply-To: <20201026215236.3894200-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Nov 2020 12:00:37 -0800
Message-ID: <CAKwvOdnHWYXieOPbOWzXxC_5vLdQdW4FsLZyiMmtzfj6JH4UWA@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: fix clang pointer arithmetic warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Toshiharu Harada <haradats@nttdata.co.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 2:52 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about additions on NULL pointers being undefined in C:
>
> security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
>         securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
>
> Change the code to instead use a cast through uintptr_t to avoid
> the warning.
>
> Fixes: 9590837b89aa ("Common functions for TOMOYO Linux.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/tomoyo/securityfs_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 546281c5b233..0a5f00073ef1 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -223,7 +223,7 @@ static const struct file_operations tomoyo_operations = {
>  static void __init tomoyo_create_entry(const char *name, const umode_t mode,
>                                        struct dentry *parent, const u8 key)
>  {
> -       securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
> +       securityfs_create_file(name, mode, parent, (u8 *)(uintptr_t)key,
>                                &tomoyo_operations);
>  }
>
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
