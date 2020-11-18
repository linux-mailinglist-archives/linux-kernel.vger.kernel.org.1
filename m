Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD42B8027
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgKRPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgKRPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:11:38 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C90C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:11:36 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id m184so532905vkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FHgaiPdc6hWHwGeVuvhnD/G0Q2OZmnCa847N3dBr/g=;
        b=DXrB6GlBNI2LMOf7azAuPesx6O3qh/dbKZsl05gXZnHQi34GWIgCLUlFAyWbdqeNY8
         fct+Hkjro05f4XScINF0wD7ifGIBp/T2uoQfIw+S2AeTJ9OOI8hzcXAEtuAWxwzdDJUu
         IRUwBgYGD1C0x2vQjsGoTxR5dHVlu5fKp6NUpPhSCck0LQlTVHCy9/doAOA5/nDxGfw0
         6G5mWMeFuXj6HSjgDv4NoEjgW4Y8PCsxM9cpXqUfU1BDGX5tqZLAC2GG9VkHSyalt/sD
         RMz4powoe14WXa/QtMnyFkM72SKM2tjaCqlklhqxKfYmKmZkE2gzOGpBUm96k+9Ir7gB
         UWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FHgaiPdc6hWHwGeVuvhnD/G0Q2OZmnCa847N3dBr/g=;
        b=Ay/mQaPy/mAdYeMm2NrY7xsYQxcDqW0cQpMAObx3rjzbZouKZ85ZUO1sn3uvSB1IsL
         3Nj4vVfAXUkTiR6uuCNGFNNtYuY4Jstm/qAzy8C5rE+pxiTsm1+aQmqIHTPzeG9yTgiv
         mMj7JlIdTs/P62lAYHlpLeym12QBSWIiII5mx8LzfwP13Psids0DuTwpHPL7IrJfBEih
         chIlFdmYvTc2ffgLGZ5Tzsnf20pa2BepKlEcVliQI5uV+1LWyLIgksj6ws1uTF0bC/lK
         DinT0n6rxUNC975VfuO7+t0k9FA9xPmYz2OVK4Xf6SmNniHKrOX1GREQXy8ToDsSKuVA
         0ILw==
X-Gm-Message-State: AOAM531XaKv9pc1J97wriQyFoHkFweFRPoz3OpzmzAgPhuLPM9AYPrMa
        PyxyKx9v11eBUDZ+/3URiDNlM7xL+Zc=
X-Google-Smtp-Source: ABdhPJxslqHyW4iKvi37h8ORT+R71h3vEr1blQAwOeR/xiYn4O4GYQsTbAyUqnrj2abQw1YA97FwlQ==
X-Received: by 2002:ac5:c55c:: with SMTP id d28mr3629599vkl.19.1605712294240;
        Wed, 18 Nov 2020 07:11:34 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id l1sm1968488vke.4.2020.11.18.07.11.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 07:11:32 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id w123so538226vka.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:11:31 -0800 (PST)
X-Received: by 2002:a1f:9ed4:: with SMTP id h203mr3510835vke.1.1605712290721;
 Wed, 18 Nov 2020 07:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
In-Reply-To: <20201118150041.GF29991@casper.infradead.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 18 Nov 2020 10:10:52 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
Message-ID: <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:00 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Nov 18, 2020 at 09:46:15AM -0500, Willem de Bruijn wrote:
> > -static inline struct timespec64 ep_set_mstimeout(long ms)
> > +static inline struct timespec64 ep_set_nstimeout(s64 timeout)
> >  {
> > -     struct timespec64 now, ts = {
> > -             .tv_sec = ms / MSEC_PER_SEC,
> > -             .tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
> > -     };
> > +     struct timespec64 now, ts;
> >
> > +     ts = ns_to_timespec64(timeout);
> >       ktime_get_ts64(&now);
> >       return timespec64_add_safe(now, ts);
> >  }
>
> Why do you pass around an s64 for timeout, converting it to and from
> a timespec64 instead of passing around a timespec64?

I implemented both approaches. The alternative was no simpler.
Conversion in existing epoll_wait, epoll_pwait and epoll_pwait
(compat) becomes a bit more complex and adds a stack variable there if
passing the timespec64 by reference. And in ep_poll the ternary
timeout test > 0, 0, < 0 now requires checking both tv_secs and
tv_nsecs. Based on that, I found this simpler. But no strong
preference.
