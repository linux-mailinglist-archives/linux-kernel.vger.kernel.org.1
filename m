Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8115A28C187
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgJLTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:34:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7576C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:34:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d24so19498174lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IEcErwKura8IVO2XV3PGiHRSSS7854fDtA49nhFrcw=;
        b=a+gxzMp490jjatDYg1NAvpcsRkEU9T02SFYLU1fU2rakRbdcEbNM+TLkxTXZ7D0apX
         zKj1nkwdSnNkz8AYfbO198EuKs2R8WwiHVchARb3yavRlud4m/3KaNJwj1LU4RxaMfWm
         3UnEeLM99kCP0N66IxPsHHHI0WZvL/t3jgFCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IEcErwKura8IVO2XV3PGiHRSSS7854fDtA49nhFrcw=;
        b=K9rnefFVEmXJtxRFunfdPlEkQ6EfeEndgd0bD9AbhEOGeLWOa5BiCiNKdIWSpp8qyf
         6zYvRJcKxgX3w9ogmIAJPDHMnHa2WqCwWAcAQ24kIEG3pbLzqWONePUI4Bx3Wo9FOZFW
         9dDOA1cfqpewU7R8I3iflysDduOghZwBUJJS6frgvw0rnGg3rk+vNHouV/HozEeWpga4
         cVdyNcep5U9PSh70rXywKmicxLvnbeJwcjmXixn4FiBJ9CaYqs3BSZr/mdyojKAnwGzy
         VKE/WS5ER6aZI5tYvIZn66UZCToIW1mNUhgWZG+YFicdPxbc/GshRhfaSMxU24l7qdv/
         YeSA==
X-Gm-Message-State: AOAM531FbDkxH+ZMwdZbE3F9YPRie4h+Ad6ydhrO2xaZs1/h/yOwcycs
        rSuzsa949Vf3hyy7c1Etn4U6rukSGFsM9A==
X-Google-Smtp-Source: ABdhPJw72GLDan8fZOmne8rfuxyF3kKZAbmQ7EJwIjRHwHN3V3nWrJm2pQmFKC1w3wvchxgONAw7kQ==
X-Received: by 2002:a19:7418:: with SMTP id v24mr8588276lfe.440.1602531245943;
        Mon, 12 Oct 2020 12:34:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n125sm2899140lfd.7.2020.10.12.12.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:34:05 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id l2so19545479lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:34:05 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr2620988lfz.344.1602531244892;
 Mon, 12 Oct 2020 12:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic> <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
 <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
 <CAHk-=wgBHgmAoLG9A0b-2_2ZiL_OaXLyO2pbKOHm=u93NttSBQ@mail.gmail.com> <CAFULd4bHpJQau5kw8J93B2Xu1J_tYhShG6eWP88vRvhwxRZmdQ@mail.gmail.com>
In-Reply-To: <CAFULd4bHpJQau5kw8J93B2Xu1J_tYhShG6eWP88vRvhwxRZmdQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 12:33:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2hkPc049k01fxZ0p0K3QSABi0O0uN-NHoqLa0yz-DJw@mail.gmail.com>
Message-ID: <CAHk-=wg2hkPc049k01fxZ0p0K3QSABi0O0uN-NHoqLa0yz-DJw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:24 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> I don't think it is even possible to write to a part of a register in the asm. An example:

But this example is the *reverse* of what I worry about.

I worry about the asm writing not to a "part" of a register, but to
*more* than we told the compiler we'd write to.

If we told the compiler we're only writing to %al, then I could see
the compiler using %ah for something, and scheduling that "somethihng"
to after the inline asm that said it was only modifying the low bits.

Now, I do believe you're right that gcc (and probably clang) simply
doesn't track %ah liveness and clobbering separately from %al.

But it still stinks as a concept when this isn't actually documented
anywhere I can tell.

See my worry?

                Linus
