Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A729A82B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895943AbgJ0Jrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:47:53 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41268 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409758AbgJ0Jrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:47:52 -0400
Received: by mail-yb1-f195.google.com with SMTP id c129so695554yba.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFwSSyZ6tdGB8SL5Ua5qFlSStYifHOLGWVo06VaDKtE=;
        b=m+imZfafWY+ffQCSP9jpxAMp9R1J/cBxpZbxvgQpEJfZCaSX7R47xuAP36sbK44knV
         cgUhtOYWDSBTJYWqUVjhlAtKXcOikjlxgukry146VWZeoiB4YZc9oLQsuWQLL5Bcq0aO
         YtdGCPE5cMqrp2asIQP7G8NXjDYrHwCjAO6ligJmxhBxJehfihrjJ/tTQMNOs5gOp+Gj
         my+8XDjGEEPbm36krBQi1B13UEEbg3YFRwRwjNo/GldAn7xgG2YnjqZr8UXxi1BygpEQ
         eKDI4Ym/RzTv+A0PbufKhlwg8/rHP9DJy2yTFQBrtFgZMnkgIcv3kwAmhESgof27manG
         /g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFwSSyZ6tdGB8SL5Ua5qFlSStYifHOLGWVo06VaDKtE=;
        b=GoLufC6HRNytUAgA+HoEV/qW2XNlAg4F5ucBKPPUDMddaJzXdazVpaQcuo5mkKVYnq
         +2S8c1HJLB+AoItDx/jrxugKmEfPQ9i8r5/N301E6Wg6jexFptk18tYg/q/L3g1JZuxl
         0ylM0wzl5ekBY7U09c3ZYA1tCSJby4wmIg/LfwCEoxxD/vok4yo2/bDCLRvYS2f6j10o
         j+wmJBSUs+oCr4G7/rlhupm9qB34bSHCQS+O9Wx5hmc4ZNSI7EaArxYf5P/FOMSnLo0y
         T6v+7tN+2gffYgtVs9sg/6/y1h21oF8yGiJFh9oKXR82wtOng0JmbX7oVJtls07v/mj1
         jFmQ==
X-Gm-Message-State: AOAM530olfqLtpTr895w6VbFIObLcTiVt4bKr5xTy/A65pNQgX9F1XIF
        fOXzWW6D7enphuVPOQAaVM4+31VsB3rfG/unSKZ6SFylGQ8=
X-Google-Smtp-Source: ABdhPJyph5gsq+nqB5mMcP9mSU+qtaIoNqzNScqx0eqPFEqFZXGM4LM4/7E6TyNrTCXjjykO8YIjQONGWxWAa4ZPbsg=
X-Received: by 2002:a25:b792:: with SMTP id n18mr2094133ybh.93.1603792070514;
 Tue, 27 Oct 2020 02:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201026192117.3811525-1-arnd@kernel.org>
In-Reply-To: <20201026192117.3811525-1-arnd@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Oct 2020 10:47:39 +0100
Message-ID: <CANiq72n72FMnNnWveSZOj_3_beXKX03CVL8=cQqqa8QyK-PKig@mail.gmail.com>
Subject: Re: [PATCH v2] ctype.h: remove duplicate isdigit() helper
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:57 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> +#ifdef __has_builtin
> +#define has_builtin(x) __has_builtin(x)
> +#else
> +#define has_builtin(x) (0)
> +#endif

Could this be

    #ifndef __has_builtin
    # define __has_builtin(x) 0
    #endif

? i.e. mimicking what we do for `__has_attribute`.

It would also be a nice idea to put a reminder comment like:

    /*
     * __has_builtin is supported on gcc >= 10, clang >= 3 and icc >= 21.
     * In the meantime, to support gcc < 10, we implement __has_builtin
     * by hand.
     */

Cheers,
Miguel
