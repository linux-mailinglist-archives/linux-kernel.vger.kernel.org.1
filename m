Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F332DF44E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgLTHWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 02:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgLTHWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 02:22:30 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047AC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 23:21:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so16184039lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 23:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXiZzoYj9lJLqDb1wsKkQ4wESyAhEIsfYGKtUX0HLnc=;
        b=g/9cEBTAaK+DLhL3dladM+Lv1zA/K9YTJHlPOgkLfQmxtfptGUoPXQW2+CCSI0mB8+
         Dyx9GsSkWE2H+oLiI+VgTCIAPzkuzbw7fMp0CShaSUjaUpBwbPDB6//J4d+XYLgX1iUs
         ImtiwuRnWur7onCRWYeQTTRB2UJnINy4IBIos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXiZzoYj9lJLqDb1wsKkQ4wESyAhEIsfYGKtUX0HLnc=;
        b=p42yvFjrHjICBnLs0iuQ50gYUlmYZWAz+t7+b0gzBCciwNzgRa82VkX7Gi5IimOCnI
         44RdK75KJpNT/DGAx0ktJnGzTPcKBsBXNUQGMAfyZb+azqaZRgQU9zQZSbb4zZoQAw9c
         i2dtXs6iNmkFbJw+Vk4QiImdvx1WaMdXXJLCxj6EbXt7GD38oM9uVbcPKlHPAtQ7nKF1
         22Z0ds38ODjEQFxlPQRu1oL998aDnxfmUzzFn6AX6ZwhVkZAS3m8z5Nllx62HF0i7zCT
         bvVm33hZ06Y4h2WqpSgijtlhnMFKCyvBt5ZgvDWHL+8kQOT0kiFNl7KUt1KoymPdsK29
         qr+w==
X-Gm-Message-State: AOAM532DiiWTAMSDinviJwKvDeCpeWnzHt+lj8mpwYWf8c5PDUDzAMON
        y8+oPlSmYv319kGQ6HArNx7prZXdgz5EKW1b7qvgqg==
X-Google-Smtp-Source: ABdhPJyKcpw783Z4Vy8RwlYkXz5tHuH+rPVlxNPAqKkLC1ZwnAK5cnZ8AIANv1F0+LqufYEiMx9pk/Fl5Bpcriza+P8=
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr2165743ljp.269.1608448908747;
 Sat, 19 Dec 2020 23:21:48 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <20201220011835.GU15600@casper.infradead.org>
In-Reply-To: <20201220011835.GU15600@casper.infradead.org>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 20 Dec 2020 08:21:37 +0100
Message-ID: <CAM4kBBJCONeSBUwnH0rb3-cAn5THDFapQ8p8xt6+-VaobS_cWg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 2:18 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> > zsmalloc takes bit spinlock in its _map() callback and releases it
> > only in unmap() which is unsafe and leads to zswap complaining
> > about scheduling in atomic context.
> >
> > To fix that and to improve RT properties of zsmalloc, remove that
> > bit spinlock completely and use a bit flag instead.
>
> Isn't this just "I open coded bit spinlock to make the lockdep
> warnings go away"?

Not really because bit spinlock leaves preemption disabled.
