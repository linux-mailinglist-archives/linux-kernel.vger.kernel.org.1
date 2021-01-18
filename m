Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3A2FACFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbhARVzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbhARVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:55:03 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD35C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:54:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e22so11987846iog.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMq+9Ew1U5NanRfurn/yAwtd0Hdhag4NKEz1bCE+wNU=;
        b=WlTPuct2SkAWUWeBGcVtznDDFmTeo+2RrkBNA9I2tk5xIAZwRsXHpxrGAbJR6SZWDP
         n+HlGUMT7lvZUtO+EPL5vdz8/lbgm66fKGWYS/41mo4Qu8/QelZxmzJEID8XWzqHTq/a
         2CvRt5kbzIZNtwoAPbZhMaMul8lAffnsUCM4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMq+9Ew1U5NanRfurn/yAwtd0Hdhag4NKEz1bCE+wNU=;
        b=Vr+9VkulkuksWVAkiWRKWKFqy8A9BQfODRuMQmdkhO6bOdLMRgHwt/Wo0NLlqb3sC7
         aiorMDLAQK/LNH1xt1Pgd31y6ucgQugIgyhKhXo2Ml96VioYH1axBjLO2VEAZ6AWkt1P
         f05GUrpaKaIxgDFsLxN50Wit42LqBiDuvKiWJnwfJCyRM96IXU7/BdNbpMK71HUB5Wvq
         Q3OH0PqIl9D57Tl5/KVtUNXJV58AKuQu3fvQ74uPdib9vFzgdamtBJm1/n7dGrp7Ou5/
         IkbKPr8yniCz11ln/uW5RrkEsYC+JsOIWvAfdo4OrEr9I6oUp0Nbx/EgZjDGFuEXvWvQ
         vEYg==
X-Gm-Message-State: AOAM5303JAhPbQG0+jmutAh8t4GBkH1tDelQlNCsNLrEpMBiPZDv8i0+
        CB41jzt+U34Hy+wKD6sEgr3yiIuATp+A6w==
X-Google-Smtp-Source: ABdhPJx0RI7ByRQTJUe9yA18o4Zlz2NdcxcaLDmkCcXWy4lDo80WW7sww8Kw9GPlgsd843x7gVJs1A==
X-Received: by 2002:a02:cc54:: with SMTP id i20mr1028812jaq.138.1611006862340;
        Mon, 18 Jan 2021 13:54:22 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id u9sm1724279iog.16.2021.01.18.13.54.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 13:54:21 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id d81so20529182iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:54:21 -0800 (PST)
X-Received: by 2002:a02:856d:: with SMTP id g100mr1082893jai.10.1611006861172;
 Mon, 18 Jan 2021 13:54:21 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com> <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
In-Reply-To: <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 13:54:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
Message-ID: <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Christoph Hellwig <hch@lst.de>
Cc:     Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 1:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So here's a slightly updated version of that patch, but apart from
> slightly better coverage - even if it's a driver that is disabled
> anyway - I'd like to point out that all my previous caveats still
> apply.

I have now booted that version to see that I didn't make any horribly
obvious mistakes.

And I must have screwed something up. I can actually use the machine
normally (I'm writing this running that kernel), but when I decided to
test the actual virtual console (as opposed to the GUI terminal
windows that use pty's), I can't even log in.

That *may* just be due to the inexcusably lazy and stupid "chunk
things up into 32 byte pieces" I did. Most programs shouldn't care,
tty's can return partial results anyway, but it's obviously a fairly
fundamental and silly change.

But it might well be some other conversion bug of mine even if I tried
to keep it fairly minimal and straight-forward.

So I suggest taking that patch with a lot of salt, and really treating
it as a very rough starting point (which was the point of it - trying
to actually boot it as-is was more of a "let's see if it survives at
all" thing).

                Linus
