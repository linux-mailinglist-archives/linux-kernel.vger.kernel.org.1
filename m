Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87182ADFA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbgKJTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732780AbgKJTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:33:12 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA1C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:33:12 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so6337985pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bVjE0o1La0vuqbe9Q9gJA2ETxHgT+N/xkwnKtkivcw=;
        b=s1cqnATCWM7oNY3aiJoLpeDFEQuWQlSfpyQNB2JvoWM8Apv4WGuq9Om9dvQk9KJZjn
         XfXebvMIeIU9mAUal818Hr8Fx5fpTFVCS7cYVW+kPXKUEkH5HiaJ0Xwtqh865r5p4ILh
         dtZQFRruy+QRyB9mb/tKrFC1Kc9rYGJ0F2yuAHKGyRD+NR/pwswJLZ2ZbGtXQA3sgHAH
         HJkXH1N8gjfo6ALEzz9IYaQsHW1VAoDfxFNFe0C2e69x1U2CSqbjEBMo9LorfhdlxLh2
         B8fuMGrnqmr96EAgSySiiLvDw6xBwBlYuQyVPPLOhM6Hdimups3UoSBfvao1LKs5fZzG
         Ox+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bVjE0o1La0vuqbe9Q9gJA2ETxHgT+N/xkwnKtkivcw=;
        b=jv0PXEzUNxr6gX4p95qnb1KjGP3G9xERfpslguADIiUYMNc6Md4utEwmXAwBJyXn1V
         Y3esHJyITVUAVN43uc+OFLgLkrEldq/PdbLLksJhI5P279f6Mhk+VH6sMCDw7bDP19N0
         Kl2b0AOpIexsAKVDKiRPPSg1x1846HJcrEB/mHagPQaKdu7JundzIChPjcuPpHxgxYf5
         OQZUd2PLHMtXU21X6EJW6LNVprHrRdT4jHSUju5I0P7CPyFy7cxrCrgzZ2yi3dOnVroP
         9YZE/jPErXLmq0XrajyFrICRji9fNY3I5MUSPv23s2DfzCkM8s4+SVquaCsVR/2vw2+f
         jmFg==
X-Gm-Message-State: AOAM5333g4pG+h9xxVjWjsKBOjOIrhiNr93nHLD6VNHviRhlQlTM7Qc9
        sDmKY/tJ0k56OLuRQXiNcYHpw59qnU7ew5FiYSgS/w==
X-Google-Smtp-Source: ABdhPJxBRK4n0QInJzhZOqASXbZHeNS+srj74UjBMrycGhWIhVVwg2T65AT53LHz1oIJrA2J56v37k+3NEgqoZwC2fU=
X-Received: by 2002:a63:b55e:: with SMTP id u30mr17659192pgo.381.1605036791754;
 Tue, 10 Nov 2020 11:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201109205155.1207545-1-ndesaulniers@google.com>
 <CAMj1kXEoSF7UXNjJS4A6VtDVbpe7kfqxdZkMS3Sxf1Sr=PvdLA@mail.gmail.com>
 <CAKwvOdmEu+mf0fVW+4gt1q7F3SkFcLvTbgjivv1qnTo3sBAO7A@mail.gmail.com> <CAMj1kXEC6TvkYScMPk0++6atLZe1yrkrUwMRkat33WEwym9t0g@mail.gmail.com>
In-Reply-To: <CAMj1kXEC6TvkYScMPk0++6atLZe1yrkrUwMRkat33WEwym9t0g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 11:33:00 -0800
Message-ID: <CAKwvOd=+8XmsHE8kNyk21T-2kOfvqfBGL7BdFYwYRUtDpOjbSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: avoid ADRL pseudo-instruction
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 1:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 9 Nov 2020 at 22:09, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > I didn't see anything in linux-next today, or
> > https://www.armlinux.org.uk/developer/patches/ Incoming or Applied.
> >
> > Did it just get merged into the for-next branch, or is for-next not
> > getting pulled into linux-next?
>
>
> It should appear tomorrow.

Yep, LGTM.
-- 
Thanks,
~Nick Desaulniers
