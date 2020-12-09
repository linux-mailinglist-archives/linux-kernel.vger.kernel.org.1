Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192FB2D4976
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgLISu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731168AbgLISu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:50:29 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB53C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:49:49 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j12so2395902ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQgmlgyLspfkVp2FCuJol7fCS4Xdf4wtNQYwX+VG7Nw=;
        b=l9z1W9O3U56nYI143oRJfV5311iDCKWoNpQI2FpTYMgLxt+baGoxWXsWfCjBDlFppv
         rAUd7fVu8DpLcrjze29pY6oLvq0xYJP7cEPd6XDycAukgjlFYuQzQuX4l1Vn+rFYo+QG
         g0H/ZbO1qMBSjxsJ3u72sevhToBFpUIys5OjjfwTxJXvlMT9vw0djPPYnitBhWvDTwIs
         7h7pBmIigp3RjL1HLHtv9syoQVrWk1z9B/usq313vp4hILK+MZVWWt4zMlvyKlRNtd8R
         Zvktg6+bqd4FKFyge2x3pMdFgTKxZWE7SA3IUuoI4j9T45TRCTgKygftTDOjJPQf0WU0
         MI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQgmlgyLspfkVp2FCuJol7fCS4Xdf4wtNQYwX+VG7Nw=;
        b=MTfdZAMjNJPo3og7tci0+ADSaTzOJVro8c2wz0pr43WGxpqUvMdDhUq++lX6a2bI/z
         pIuOlWfL07K8VxiDoLEu2aUV2IgSK1Yw5+FsUqeF1jlVr48NC9SMjjTxgNCRrr12kEzy
         Yx5pgNNhC7iBWWDWusH7selQJHepdnDH+zrKn5z3d7YaKJho9BWrwxfwhjrjQTufDJ+L
         D9DmrL2Wonk2kkwBRHeDlCuwBcg4vJh2z8GPVWVZFRgTy+KpMXUmku2ol1QEMJ8z/7Wy
         x6R1CrmP25WCGrqRRrjKdKty4Ipc04b+kJBNavlyFiWdjSLG4MX5lJQye/NVC0cDRIH4
         x4lA==
X-Gm-Message-State: AOAM530G0MZvyOC2LhYsEMCjrQjHV8jhKqeqUun1qez3LCLgySDQbJoj
        vPIQLzJiulDgYq/SZLCd9XS63oppo+ZcSn0rfkoDmQ==
X-Google-Smtp-Source: ABdhPJwWx8l8bBnMkvN9ss6l6q8oVhzQWR8f+8nZwO3h65V9XTRisIADDH5OJNTJQwhw4qc206BtFEJH6Me4d/Cdh2M=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3014950otk.251.1607539788150;
 Wed, 09 Dec 2020 10:49:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607537948.git.andreyknvl@google.com> <f2ded589eba1597f7360a972226083de9afd86e2.1607537948.git.andreyknvl@google.com>
In-Reply-To: <f2ded589eba1597f7360a972226083de9afd86e2.1607537948.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Dec 2020 19:49:36 +0100
Message-ID: <CANpmjNMf1tOYTFojUQrHoscFxPPEed_vkBufgxVLduQ6dBvCUA@mail.gmail.com>
Subject: Re: [PATCH mm 1/2] kasan: don't use read-only static keys
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 at 19:24, Andrey Konovalov <andreyknvl@google.com> wrote:
> __ro_after_init static keys are incompatible with usage in loadable kernel
> modules and cause crashes. Don't use those, use normal static keys.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> This fix can be squashed into
> "kasan: add and integrate kasan boot parameters".
>
> ---
>  mm/kasan/hw_tags.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index c91f2c06ecb5..55bd6f09c70f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -43,11 +43,11 @@ static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>
>  /* Whether KASAN is enabled at all. */
> -DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);

Side-node: This appears to be just a bad interface; I think the macro
DEFINE_STATIC_KEY_FALSE_RO() is error-prone, if it can't be guaranteed
that this is always safe, since the presence of the macro encourages
its use and we'll inevitably run into this problem again.

>  EXPORT_SYMBOL(kasan_flag_enabled);

DEFINE_STATIC_KEY_FALSE_RO() + EXPORT_SYMBOL() is an immediate bug.
Given its use has not increased substantially since its introduction,
it may be safer to consider its removal.

Thanks,
-- Marco
