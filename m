Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206420AD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgFZH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFZH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:26:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45684C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:26:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g139so4583902lfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cw7fszpLiMfrIe/x4mrTm0zt4AL0ex45ZDoUuui7OOM=;
        b=ZNBlEuV7nuAwi/3xINotpkZFYoSyoduflbwP1WVpiojIx56BqAK7kAB9tJK6o/fSEC
         kbJfb9lc10mlxKYEK6VPvYNCqZca2+QVWuRjoUzKsHF+AjulUmncAkiX547o+rNQjwpV
         DjUN9kW/889p9CxCnaX7XjcwfTjtXzhhfaZuEHnbdkGA058NAM/YpNRc2lgnJiggajQj
         rJUBCd4BDJHmOJ0uxMEmRRktScwNi58yVxHF35EezzGlrAFWH03pdmx5wHrYCm2FK8eG
         xF54fddRx3qHIypr4FCCJ13OZ+t3ROCgWLBaWYTrfOtgRPP3oexWKBaRZ7k7DO1Dy7YC
         eNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cw7fszpLiMfrIe/x4mrTm0zt4AL0ex45ZDoUuui7OOM=;
        b=E9jlyBCdoCwGMHWoTv5C+eZtxuB+CoGv689/86z1X4sYaT7fujinIacuhdvPHb57eR
         esAgbqh6lRl2bSbCCa4U76HoBe8OInMhHehCVTOKS/lXAqgLANfZbDFNTgzQbdOIWjpe
         qUkQVGyO7I43vxhWjhUsTyOfwNn8nEr7daaJksYZbtxHF5uv3lykVxdzXJ/yJKcPUxAt
         pK8OFfWop0DOAnO5kyZQ39bHzYTrEvb9il1aMuBbyCyvnUpS74D7quMUfONFK5RiVEr7
         3X2RVedrSSt1hDkiyXt3lwrwL6eJF+iUISaXhiXj5O+mlaelwiWJ01ZUtMmIVj1+SIxl
         0vpQ==
X-Gm-Message-State: AOAM5318neNLr1Bnxx8s5pgMBZa/AVbewfxvjzZtGIGwhndel3E8CUuI
        kZe18sKg6WhiTSuLrnAY6+JTe5WpS+QlIMJo/qT/5vViN4ZZOw==
X-Google-Smtp-Source: ABdhPJwvCjTPMG3DGY417CWhy1Vn5ylVbzduY+Geu6YJsJsNdoK9hd2Lmls7tX2lk0jNLu/BbDnRv8U9BuFhqvHbPZ4=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr1058410lfn.122.1593156395726;
 Fri, 26 Jun 2020 00:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <CAFA6WYMF+JjrB9Cx9TdgDzMeQSvPZfMNapzD-MH4ALVoUoo1sQ@mail.gmail.com>
 <1593127902.13253.11.camel@HansenPartnership.com> <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
In-Reply-To: <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Jun 2020 12:56:24 +0530
Message-ID: <CAFA6WYOc8JGud2edy7KHwu3US32Z_HNJ51usNA2d=wy8fWoRbw@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 at 10:40, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 26 Jun 2020 at 05:01, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Thu, 2020-06-25 at 19:54 +0530, Sumit Garg wrote:
> > > On Wed, 24 Jun 2020 at 20:51, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > > > > Apologies for delay in my reply as I was busy with some other
> > > > > stuff.
> > > > >
> > > > > On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > [...]
> > > > > > it's about consistency with what the kernel types mean.  When
> > > > > > some checker detects your using little endian operations on a
> > > > > > big endian structure (like in the prink for instance) they're
> > > > > > going to keep emailing you about it.
> > > > >
> > > > > As mentioned above, using different terminology is meant to cause
> > > > > more confusion than just difference in endianness which is
> > > > > manageable inside TEE.
> > > > >
> > > > > And I think it's safe to say that the kernel implements UUID in
> > > > > big endian format and thus uses %pUb whereas OP-TEE implements
> > > > > UUID in little endian format and thus uses %pUl.
> > > >
> > > > So what I think you're saying is that if we still had uuid_be and
> > > > uuid_le you'd use uuid_le, because that's exactly the structure
> > > > described in the docs.  But because we renamed
> > > >
> > > > uuid_be -> uuid_t
> > > > uuid_le -> guid_t
> > > >
> > > > You can't use guid_t as a kernel type because it has the wrong
> > > > name?
> > >
> > > Isn't the rename commit description [1] pretty clear about which is
> > > the true UUID type from Linux point of view?
> >
> > I don't think the kernel code takes a position on eternal verity, just
> > on logical or arithmetic truth.  We just have to deal with both LE and
> > BE UUIDs so we have appropriate types for them and the LE type is now
> > named guid_t.  They're both equally correct to use provided the use
> > case matches the designed one. So does the name really matter?
>
> Yes it does. I guess I have provided enough reasoning for that. Also,
> the rename commit itself illustrates its importance and clarifies the
> use case for which they are meant to be used.
>
> > If we
> > did
> >
> > #define uuid_le_t guid_t
> >
> > would you be happy? (not that the kernel cares about karmic emotional
> > states either ...)
>
> It's not about me being happy but more about confusion and
> inconsistency it will bring.
>
> IMO, either kernel should be opinionated about UUID endianness like
> currently it is:
>
> uuid_t and its corresponding helpers (eg. UUID_INIT) follows BE format.
>
> or support both endianness for UUID (no common type: uuid_t) like we
> had earlier prior to rename commit:
>
> uuid_be_t and its corresponding helpers (eg. UUID_BE_INIT) follow BE format.
> uuid_le_t and its corresponding helpers (eg. UUID_LE_INIT) follow LE format.
>
> But even if we consider later case as well, I am still not sure if we
> can switch to uuid_le_t as it's been part of TEE core ABI
> (open_session) where UUID is passed in BE format (see LE to BE
> conversion in TEE client [1] and vice-versa in OP-TEE OS [2]) and
> won't be a backwards compatible change.
>
> [1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/tee_client_api.c#L595
> [2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/ree_fs_ta.c#L92

Sorry, the second reference is incorrect, correct one is:

[2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/tee/entry_std.c#L279

-Sumit

>
> -Sumit
>
> >
> > James
> >
