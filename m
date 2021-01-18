Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC32FAD12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbhARWFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbhARWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:04:39 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:03:53 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u17so35797135iow.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmpYwUNdr+rzX8LoCj7WnsumrrYlK3+Y6xiLf7Go+mc=;
        b=B6vRXq95C8RQIvWa7d7RRwNNKW9nce0IoW229pBAKW3t+tshh0JNkgyESfEXbMJkar
         RCZ4QPO4YNU+j1Tzu2VZghho/YcL7DKPjWj2DcGOUwyfLCb1MpeSiOjhcHPvBZK/fTOX
         KkB1+GapG2CBXuLmtxWThwHQez1t3EkHnnGw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmpYwUNdr+rzX8LoCj7WnsumrrYlK3+Y6xiLf7Go+mc=;
        b=TA5/Qg3/fj8ls3j39e8BljTBeXH2/hq8z6yFX64wooq3JjW0PYSEK+qtOTWGWN1Gj+
         KltLgDnYiZyxWWLWqV58kJX/2RHjh7dAuKm7oTXyynUz2/FivDcUUVdpnFHVck3PvhB7
         UxiRwgeCoENEX5gfBeuhFQVM7GIou00xfrPyqLY5DY0Ij69BSm2j0EsnTR4oeJ+WMaOJ
         cDupuKniBmvUfubQizZuX5V1NEFmZjPS7X1fchtCzow0NUDkBrvXiGMCdwpiOWM4t81z
         iotAHWlCLltue2xHVtKd6B5T0y/7TmdoCTzec4yE2GOyzJLfL2aHh/dWLGshllBPH8yR
         piWQ==
X-Gm-Message-State: AOAM530CI8FmSxNLNAE1IqYGjqSZnyCE6GGznvwfXX8Vm2clb7O4fWEM
        NwJn48mC/sbnF16oRoe2cRA9LsMnJkpEFw==
X-Google-Smtp-Source: ABdhPJxdgFe7WVJXps+2TUhzOYY6BopvtsAPdrxyCTEJcG/ns/aUTmc6i9XWNL1TAgtIo1ERrbliRA==
X-Received: by 2002:a5e:c00e:: with SMTP id u14mr831748iol.194.1611007432369;
        Mon, 18 Jan 2021 14:03:52 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id a18sm10873638ilt.52.2021.01.18.14.03.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 14:03:51 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id p72so10969067iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:03:51 -0800 (PST)
X-Received: by 2002:a92:85c7:: with SMTP id f190mr942562ilh.234.1611007431670;
 Mon, 18 Jan 2021 14:03:51 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com>
 <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com> <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
In-Reply-To: <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 14:03:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com>
Message-ID: <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com>
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

On Mon, Jan 18, 2021 at 1:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But it might well be some other conversion bug of mine even if I tried
> to keep it fairly minimal and straight-forward.

Duh. I completely forgot to handle the canon_copy_from_read_buf()
case. So ICANON mode was entirely scrogged and would just return
-EFAULT.

That would do it. I'm surprised how well everything I did actually
worked - because all my normal terminal apps (shell, editor etc)
obviously end up not using icanon at all.

I'll have a third patch in a moment, but while it's ready I want to
actually reboot and confirm it first.

             Linus
