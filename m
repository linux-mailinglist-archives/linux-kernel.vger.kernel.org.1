Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2341B2A03FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgJ3LUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3LUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:20:46 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:20:46 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id m188so4822374ybf.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G9dXGMHL3LoWEWUdy1Ms+BhIgQ35oL2d5aGD3k8A1UE=;
        b=HqGvZhBVNP/Aty6lRkxtyeTfSpOJnW/80pgI0PLU4TQJYmLSG0M1XSw7w7i6FFlrvi
         3pIRW5VMXotOtXIRIt2rApfUcO7vyIdMH7GAgiBiIZyLRdQDG5i1TM74aYQLMcYA/ezh
         HcMWRVV5gcjRQru+OlFfIB3l8TkYUQAED7gMm3sfgHMhgfYEC0clXYhl/tUMerpH6voB
         6XimbfQZF5pGpP/VwXS9vpeLl1J2MT2KPnp144nKnafF/UF9GwiWkLPyH4XXCBEbv8f5
         Zeex7cHz/sIUzsLi2EeiP3deNt8t9KwddYNfMuhThMdmDiHR0AYdlHV+SHkPwPJYgpKr
         R9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G9dXGMHL3LoWEWUdy1Ms+BhIgQ35oL2d5aGD3k8A1UE=;
        b=G0e5Pv3kZZGtDEPf2MeRf2etsqRPZUDbbynUnbybkpfG8+nm3zTY2pub2x4XdFZ0Cs
         ySgvsAUxXnaZ9kl5FeMRaAOSMUOZJqvxEtIE3h5bGLNEiK6uTHtStQBohJNrisHYMGPF
         2OBRB5FiIGuB1mqpnpk0VE9RpK7tH+MeG07Zy59TiXWObV5bKWXglUZWn5tJVQzQCuas
         3Rkwo43whJDvvRTPy2tcsz9s9N1IbU6URZL62WPHmfHbmUKSNpwm3kc9q4V2X4OcAwE5
         sxZEI8CQoPNcdQ6LnaCoJyDhUlNYjF/suTsFD2ZUiSoP9R0V50bwtxkBTgf2m4JFBdfy
         blBg==
X-Gm-Message-State: AOAM531KmKOT2faFG958XX7XiuLXpGyYvLhBgYGXp2n375SiPy7HIIjE
        4DcmJRoptuMHDhr83Cti0HofoClhAPsLmt6m+emFwg==
X-Google-Smtp-Source: ABdhPJzra1pMG5DWzyNsqxZMtv8L71QZ9N4kNvy1uCXEHLUKRwFRdAqW8KJMoQPn5ok9GmGGT6GuLe6CgauTI6lkDu8=
X-Received: by 2002:a5b:389:: with SMTP id k9mr2590084ybp.75.1604056845834;
 Fri, 30 Oct 2020 04:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201029100546.28686-1-gilad@benyossef.com> <20201029100546.28686-2-gilad@benyossef.com>
 <3a4804a5-5d5c-1216-1503-c241cc24f3c2@gmail.com>
In-Reply-To: <3a4804a5-5d5c-1216-1503-c241cc24f3c2@gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Fri, 30 Oct 2020 13:20:41 +0200
Message-ID: <CAOtvUMdJxVSFhN4QMNL+eiF6OB2LevThcgDK34M-=JDXCoDXMA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] crypto: add eboiv as a crypto API template
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Ofir Drang <ofir.drang@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 30, 2020 at 12:33 PM Milan Broz <gmazyland@gmail.com> wrote:
>
> On 29/10/2020 11:05, Gilad Ben-Yossef wrote:
> >
> > +config CRYPTO_EBOIV
> > +     tristate "EBOIV support for block encryption"
> > +     default DM_CRYPT
> > +     select CRYPTO_CBC
> > +     help
> > +       Encrypted byte-offset initialization vector (EBOIV) is an IV
> > +       generation method that is used in some cases by dm-crypt for
> > +       supporting the BitLocker volume encryption used by Windows 8
> > +       and onwards as a backwards compatible version in lieu of XTS
> > +       support.
> > +
> > +       It uses the block encryption key as the symmetric key for a
> > +       block encryption pass applied to the sector offset of the block=
.
> > +       Additional details can be found at
> > +       https://www.jedec.org/sites/default/files/docs/JESD223C.pdf
>
> This page is not available. Are you sure this is the proper documentation=
?

You need to register at the JEDEC web site to get the PDF. The
registration is free though.

It's the only standard I am aware of that describe this mode, as
opposed to a paper.

>
> I think the only description we used (for dm-crypt) was original Ferguson=
's Bitlocker doc:
> https://download.microsoft.com/download/0/2/3/0238acaf-d3bf-4a6d-b3d6-0a0=
be4bbb36e/bitlockercipher200608.pdf


Yes, the JEDEC has a reference to that as well, but the white paper
doesn't actually describe the option without the diffuser.

>
> IIRC EBOIV was a shortcut I added to dm-crypt because we found no officia=
l terminology for this IV.
> And after lunchtime, nobody invented anything better, so it stayed as it =
is now :-)

Well, I still don't have any better name to offer, LOL :-)

Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
