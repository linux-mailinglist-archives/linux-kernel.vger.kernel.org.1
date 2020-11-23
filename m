Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA732C145C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgKWTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgKWTQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:16:17 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622FEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:16:16 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so15807814pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9538eMr7aJDlDb1g4y3QM7S0Xn5CPIOZqgBkgQyEew=;
        b=HVIOI1N8BpRRmemcOHgkUnvdsalkMTGSBAkQKySKRl+EaxAnvJW1thXWldtCIb2CSX
         BqJTbUX50xNglKSb6q38iIcID0EawRG0gipdkKec05YbI01nl6dWvJgEhUMHMQ3BMg+e
         xjRE2zhlMP4qBRJ/tERjI1C/Pm5jHOdfvzF3WziJWVVcFEEzz5qFGZF5cBjrfn9QkVdU
         yTpQjfrFJ6s/8y82lEBPOzGsphLJU3FGpdIgtH3DdpzSOw/Fn3iybtBQwW4rT5ZJaltf
         gjdGYByujCypGd6SKSZO0KdnisqlxH5/YJb6He5+Kh/5EER9tghgpDe68W2GUljT+JY6
         Q2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9538eMr7aJDlDb1g4y3QM7S0Xn5CPIOZqgBkgQyEew=;
        b=og5dylJbVZ0k6HJNRevkM9rC+Bi2ZvuB9yiOx4VvYlrNL7TUVOywkP+ZEMkj+12gy/
         HVOEmiS7CY9vG+BEGD7xc3vs+nGiS8XeLhCnO0NPL1fLM4YIdo7IgIqlJUdWtZyNC6Yr
         4jim1yxX+mk2vmUwoKxy6FPz3IkdQRjB0ezcoe3Axs8BtQEFr0TnaW174jqoAGBR+76W
         zww0wCmZAuRnT9LkufKpSd8KKN28d9BS04869LazM0CX3kfucbhJFNrhzZwuQqIssmm+
         160hwpNwfDz8L4w3GgTRxuNgYGFc1TEVI588spA4koxVQsZ6Cx1Yw7Bl+dD7gg1JuYPb
         tSjw==
X-Gm-Message-State: AOAM531siveQMwXN09PkaY+Sx//w2LDKzFPdg40Wl4re/TgufcQLr6Te
        gzpU2YukHD4/iq4F2zW9eX6WKc4AcE0uIlldEg3Smg==
X-Google-Smtp-Source: ABdhPJygGOEcLeEkNyiZQiTYzdHTXe+NYucO6TfYGWymj6LqpNTMAPbN7qhum/I7mugKOtr2pQpZpKVBhtti/+S5nC0=
X-Received: by 2002:a63:eb11:: with SMTP id t17mr787835pgh.286.1606158975788;
 Mon, 23 Nov 2020 11:16:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <52518837b34d607abbf30855b3ac4cb1a9486946.1605305978.git.andreyknvl@google.com>
 <CACT4Y+ZaRgqpgPRe5k5fVrhd_He5_6N55715YzwWcQyvxYUNRQ@mail.gmail.com> <CAAeHK+xv2UQyD1MtAiu8d=cRbJDNXQaaA-Qh+Eut3gRnLbJEMA@mail.gmail.com>
In-Reply-To: <CAAeHK+xv2UQyD1MtAiu8d=cRbJDNXQaaA-Qh+Eut3gRnLbJEMA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Nov 2020 20:16:04 +0100
Message-ID: <CAAeHK+ydCcdtn7u=nyBDxqffk_eTKA=sOTQzTnQuNZj81HxEJQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 17/19] kasan: clean up metadata allocation and usage
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 7:54 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > > @@ -168,6 +173,9 @@ void quarantine_put(struct kmem_cache *cache, void *object)
> > >         struct qlist_head temp = QLIST_INIT;
> > >         struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> > >
> > > +       if (!meta)
> > > +               return;
> >
> > Humm... is this possible? If yes, we would be leaking the object here...
> > Perhaps BUG_ON with a comment instead.
>
> No, this isn't possible. Will turn this into a warning and add a comment.

Actually, looking as this some more, looks like with this change this
becomes possible. I think the best approach here is to not put such
objects into quarantine, and return proper value from
____kasan_slab_free() to avoid a leak. I'll fix this in the next
version.

Thanks!
