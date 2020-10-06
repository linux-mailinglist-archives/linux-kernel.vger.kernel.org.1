Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18812853EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJFVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:35:58 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 14:35:58 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s15so59245vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIhoEkw7QDnbqFkt4C/9ORTsJfEnPY9bxYmbo8CQgVc=;
        b=AWXmY+d1jW5xLVG2U3KjH2+I/C9SAPMyWonGsFb/wqdX9qsJLV7BcxDMfPgm+XYkuq
         qW7X/XM4vvp58ZAGXnbJrxnOnQxHoYEjTqf8yi1DUMNER8y5ICvPGz2uHu9+x4k+CN67
         kCEPT9uxDaiJizFsMIpDft7iGunXpB8baaDaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIhoEkw7QDnbqFkt4C/9ORTsJfEnPY9bxYmbo8CQgVc=;
        b=OdJ/HulF3XqIBYMzqSx8ht2lBLj2tvzheh92u4bxTZrt0A4fxlUmwMu6m+GAVZ29f6
         veSwE3OmcMspQSEePu9OtlNVbW+VX6HuJbha7No7GyF4bwyytTY6MXW9J4xsIGT1sy7+
         munPSbeOti+fGZQAcELFElJ1AlGpGVdezkZIO5cLZP9k0daFzD9KvYEEBrybOJnWm9EY
         gs7GfUG4ETJMf6HEIPRlzZNwH0MyVFAEtQ4jVBIWS4IwYaI1H1a4EkbO4Ykztl1zXda6
         cdaukPe6zuZiBPmM5PDDQn+CNUOicjC/LMkW/7qcc3mq+UJC0PIBJ69Qy70YecuhWhiT
         0Heg==
X-Gm-Message-State: AOAM5325JrHYN4eBGVw17XQP/OxXu+Vq+Tqgeiv0XGblb5WesRouS6P/
        oCp7XccFVZUUhufFpkeqLOCveu0hOto0Ng==
X-Google-Smtp-Source: ABdhPJyZHxC1J6Fh1XOu+21pnx9MPR8j0Gy2r3c+KCW5mE9McILrKKihe9VxQMFxvm5rwOwdtS8SnQ==
X-Received: by 2002:a67:ea12:: with SMTP id g18mr10448vso.50.1602020157087;
        Tue, 06 Oct 2020 14:35:57 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 67sm13364vks.44.2020.10.06.14.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 14:35:56 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id h2so30900vso.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 14:35:55 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr17365vsp.34.1602020155557;
 Tue, 06 Oct 2020 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201006195848.707504-1-natechancellor@gmail.com>
In-Reply-To: <20201006195848.707504-1-natechancellor@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Oct 2020 14:35:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKud6KXYSXG79qOU-feKJqhOLeAf_eWuummotdBSyHcw@mail.gmail.com>
Message-ID: <CAD=FV=VKud6KXYSXG79qOU-feKJqhOLeAf_eWuummotdBSyHcw@mail.gmail.com>
Subject: Re: [PATCH] crypto: xor - Remove unused variable count in do_xor_speed
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 6, 2020 at 12:59 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> crypto/xor.c:101:4: warning: variable 'count' is uninitialized when used
> here [-Wuninitialized]
>                         count++;
>                         ^~~~~
> crypto/xor.c:86:17: note: initialize the variable 'count' to silence
> this warning
>         int i, j, count;
>                        ^
>                         = 0
> 1 warning generated.
>
> After the refactoring to use ktime that happened in this function, count
> is only assigned, never read. Just remove the variable to get rid of the
> warning.
>
> Fixes: c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1171
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  crypto/xor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Whoops!  Sorry for missing this in my review.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
