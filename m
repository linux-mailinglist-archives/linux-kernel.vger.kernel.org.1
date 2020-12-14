Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CAE2D974F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgLNLVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437219AbgLNLUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:20:50 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076DC0613CF;
        Mon, 14 Dec 2020 03:20:10 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id z12so6112108pjn.1;
        Mon, 14 Dec 2020 03:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETJkm2h9mUdQRDtcG4X/2MD3yrQCIlxA3Hfl870jwj4=;
        b=r25mGmNkMaVymoukJdYxFlGJGfK3XkU1Ny6frMPmg1Fdb4iaEVZVO5QJxKuLBsNJCd
         9XIjrmInI0sKFHvqhJeTasbCPeKoST0dYXVhh4kAwaiDpK3laTHnDD+5gjnjupU8Mzwe
         JLq3IWBkN+fpgnsUsbkaGyuzOcZhMzCkaWWU0/f/zXhUnxzXpa89XE5mmqtgUXmywH2O
         1ElETGTCZHt/SjBNRVeHXfxYwdu5YNvQMXijPywj125EwbqRD7balLvykrWwlfNoQg6j
         sQyhCi1yW6GLYyDZA2T4UUiKctuaj0MJDVQL9YFMTS/kBY2AQQGLnYxqG9bbWAIj9TUP
         KShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETJkm2h9mUdQRDtcG4X/2MD3yrQCIlxA3Hfl870jwj4=;
        b=m4EH+dIxDKEWHj/OugtKAY/Z4bfqdtDUHusT6fVYTtMaJZm2TTu6ECsz4csH9x2ff/
         B4k/+kw7fxl7KsWwL83QjNsil1ayHDtRZMwfXM4g80y1+z6aVQtcMSiyot1sWQ1fDYBp
         vkcCcMquiRUtvUu8VjNyBmf+AWKxga+z+8IMtogATNPNiFmiWdPcfmHf9b2rLfeQUDZM
         h3k5lRT4iK/1athnIv4sqP8GzyXKllvoTO3t1ZoEaO5sIr7aEwkEzu4qEAJsNEGjmdv0
         vz3oKYrwyPh619W2BQFYSqZDSUBp7noMR9p0Qxn9oq/ISTfhYLXBi0jidPU+bM2sq4CB
         Ga0Q==
X-Gm-Message-State: AOAM532V3EMtO6zpD+iXij95fSxEli161w13K7lwo6O8W3e0D0Z/A7t+
        otxXp8+WkYT5u1jGgDxw9dT6nz6FkrgRRhTKJyo=
X-Google-Smtp-Source: ABdhPJxx632u2IOxtU3Khq37YXRxCyhybqvc7sZw19fW3k6MMlCDyqHRfIJROCTqqmNg6nOj9Dnnq1qLiQh0tpkR8Rw=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr25511515pjb.129.1607944809447;
 Mon, 14 Dec 2020 03:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20201211190335.16501-1-rdunlap@infradead.org> <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
 <ec8e703f-e1ea-1253-edc9-311f0ee3e8fd@infradead.org> <CAHp75Vf-QcdL+FOd=8fUUQ0+ORC-RVKG+3Yqrar1J7wZMSDF+A@mail.gmail.com>
 <3d5a5c8f-4bb1-6205-ae76-354473d59a18@infradead.org>
In-Reply-To: <3d5a5c8f-4bb1-6205-ae76-354473d59a18@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Dec 2020 13:19:52 +0200
Message-ID: <CAHp75Vc3_ye3Ph0uVYdcsKr0QY5RGSaHmCgU1A2q-U2GCAafsQ@mail.gmail.com>
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 2:53 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 12/12/20 11:07 AM, Andy Shevchenko wrote:
> > On Sat, Dec 12, 2020 at 7:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:

...

> > Here [1] is the rationale behind annotation vs. ifdeffery.
> >
> > [1]: https://lore.kernel.org/patchwork/patch/732981/
> >
> Thanks for the link.  I'll send a v2.
>
> Could we add that to the Linux BKP (Best Known Practices)
> document?

Perhaps. The author of that is Arnd, maybe he has something to add.

-- 
With Best Regards,
Andy Shevchenko
