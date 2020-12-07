Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822792D13AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgLGO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:28:45 -0500
Received: from mail.zx2c4.com ([192.95.5.64]:58371 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgLGO2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:28:44 -0500
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7f50630c
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Dec 2020 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=rzp53da5aR0WWB/WSnM2Pj0jGdo=; b=QjyMxo
        HY+PIwmI7zYA/TuYzbl9AehiAJqnMS9R6K5KuH4vSf6q6PRTcGc7nJerbAJ52ts1
        pJGKONM6bv7fTK4mc4M6ElKFKHifmgV12oHn0G0NuIK46ycWkUVAlQ0PEGIuhNhn
        5Y0oftqYIgwmHN/6FqR/kbxCiQ761ZJU9ihVhoOw2UaM+kgFKskOiqpK4vdl5PSF
        hV2IUL+MYq2j0F5Pp+n8A1SlyTeQvRBQ/nA/UKmUsmOdREUw6iORJHC2Ib6/V9se
        GYq3xtSDXrGBx7qgDLTMkdbB+rRg+m2QUi8DLnE7d+VC6KBD85bdrn+pIncxFxwn
        CwslDz/Fh+wF+MRQ==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2f31bb70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Dec 2020 14:21:34 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id w127so1598081ybw.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:28:01 -0800 (PST)
X-Gm-Message-State: AOAM531+Bh13O+7Ea0DrtlxqaXOLM8D5TO23dSP5AsZTEsrFM0jWooXf
        8HZBuxicu+NtcTnONUntmkD/qaQ54vd1fF/aNwQ=
X-Google-Smtp-Source: ABdhPJwGURgCLGvJywrEFq2TcMT37HylTPY/STqpFyon72Qpufi0n2Ed6b9H2wY1SxHRHdRla8K1GsDnnDAfJKpXEJo=
X-Received: by 2002:a25:df05:: with SMTP id w5mr25622831ybg.20.1607351280649;
 Mon, 07 Dec 2020 06:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <X7dB9GCUeHa+Hosn@sol.localdomain> <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
In-Reply-To: <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Dec 2020 15:27:50 +0100
X-Gmail-Original-Message-ID: <CAHmME9pzcxQ1aufU7ycTcL+NQYV8P_wMKpetAuSogOw=2N9jRw@mail.gmail.com>
Message-ID: <CAHmME9pzcxQ1aufU7ycTcL+NQYV8P_wMKpetAuSogOw=2N9jRw@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Dec 1, 2020 at 1:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > is implemented. In most cases, these are special instructions, but in
> > > > some cases, such as on ARM, we may want to back this using firmware
> > > > calls, which are considerably more expensive.

This seems fine. But I suppose I'm curious to learn more about what
you have in mind for ARM. We've been assuming that arch_get_random is
not horribly expensive. Usually external RNGs that are horribly
expensive separate hardware take a different route and aren't hooked
into arch_get_random. When you say "we may want to back this using
firmware", does that mean it hasn't happened yet, and you're in a
position to direct the design otherwise? If so, would it be reasonable
to take a different route with that hardware, and keep arch_get_random
for when it's actually implemented by the hardware? Or are there
actually good reasons for keeping it one and the same?

On the other hand, rdrand on intel is getting slower and slower, to
the point where we've removed it from a few places that used to use
it. And I don't see anything terribly wrong with removing the extra
call in this path here. So need be, I'll offer my Reviewed-by. But I
wanted to get an understanding of the fuller story first.

Jason
