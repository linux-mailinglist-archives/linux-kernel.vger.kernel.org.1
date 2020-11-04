Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B650B2A5FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKDIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDIf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:35:27 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A139422264
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604478926;
        bh=9NEFiKOJMd/gcEFN0QsFwhrwg4OmXEdvT7F7d8Wl+Zs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HIb5JrL9Ftex70B7LCl1GcBjI4jQlRjolqP+nPejzsx4R5sjcM2+j5iRF4OBjkChv
         dU2quEuqYPOVFeqtAVitzXKHaPYijN39C0pUTaRMyPVmMvhVVCSP2XiKCK3UGAUi7h
         115WOsBN3HdFom4SgKVGSPwAEIgIpXPaSzNmLxh0=
Received: by mail-ot1-f46.google.com with SMTP id n11so18646328ota.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:35:26 -0800 (PST)
X-Gm-Message-State: AOAM5304yUfDn+sARY+Sf7n5ek5yFzax4cxN1cHPtUv2Jgs3AeUGQt3j
        SFp/Jv5FrCncO3dadBhRS97f0yon0aapHpoAho8=
X-Google-Smtp-Source: ABdhPJxUL4gMf9+E8ahcvPdaqC+CR9QjRycCnGgeuUvQ3U2BK9f2ObPIWl2Pt02dVj/B+2eo2UBRhimi4ko2yzWaWHw=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr17341065ots.90.1604478925845;
 Wed, 04 Nov 2020 00:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20201031094345.6984-1-rppt@kernel.org> <CAMo8BfLCfpZcQC3oqEvExSqZ+dT2sVDjcXoaO_XKALn4rGjoog@mail.gmail.com>
 <20201031171608.GB14628@kernel.org> <CAMo8BfJ4ai4UHD36JZb2ETiFe9SeqpVQw5tsNLrSF8sUx11ccQ@mail.gmail.com>
In-Reply-To: <CAMo8BfJ4ai4UHD36JZb2ETiFe9SeqpVQw5tsNLrSF8sUx11ccQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Nov 2020 09:35:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFmi4+1FmLk-0kSL8sSMDgftLTArwf_6hONLkyMJk+srg@mail.gmail.com>
Message-ID: <CAMj1kXFmi4+1FmLk-0kSL8sSMDgftLTArwf_6hONLkyMJk+srg@mail.gmail.com>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 18:44, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Sat, Oct 31, 2020 at 10:16 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Oct 31, 2020 at 09:37:09AM -0700, Max Filippov wrote:
> > > On Sat, Oct 31, 2020 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > Please let me know how do you prefer to take it upstream.
> > > > If needed this can go via memblock tree.
> > >
> > > Going through the memblock tree sounds right to me.
> >
> > Can I treat this as Ack?
>
> Sure, for the xtensa part:
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
>

Could we get this queued up please?
