Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB123B625
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgHDHzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgHDHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:55:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32330C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:55:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so42543129ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3zyBIEHe1KX9qNxAwpMVaTh2A3WCRXOiVSacQRwjOs=;
        b=jM2tc6eLQJ+v886eXT4NvieZhN54YypsQ9iiPuyziTIcoAg+m57300sIyY2D8/J4lu
         yEe8nUHw+lmIMYPtJrOUshNB4a/oioWzluXWTKHb0222I1nBMOy6QF6UCyRQgRTkvcO2
         JIeMav2bX6eohozoceUFF9z3a4SYv0rbnQ9knGOnco224fcl0QQU3MWb7ZM0VZMQDAwD
         greQ6YooY3xToPWTAVRGrk7+L1TOAbuCc29O+dGubPwN/2TQnl2NzEvAOAPL2PIR11KW
         dBICP2RvZgIb5hDtspToEPBQpXBDoVngjyTIlToYuYIpnfhs1BIiwxQWrnTlwIVrmujk
         UFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3zyBIEHe1KX9qNxAwpMVaTh2A3WCRXOiVSacQRwjOs=;
        b=b605z4qWbtJtEJ4l7896G8zqObNKpgnVhHvas8OrBqf7xM6bb0Lx0Th3dc+kgFpZ1E
         fCwg0FqMFPXQ0LJkZ7cthYrBVRf/g8+X0nx45K6urN+AIkhgOAmMzVaoK5aVM3s5vLzV
         ckdsh5Yjqpgs/Z0KDOHCQ7TmJ0+kEqbByCjDL5VPC7VirSY94ZWEfmSdcFd3dxJB+eXi
         n4nU3yXD0C2/Z1i+z6JGqzIZdjqqTe8QvTsu5LYYUqyMU/Q0icIkaXhHyTNuvd2EajLP
         yIFU4CJsBycKwf+mEXpVjtMFsnehtlplSCzA5mS7h7rQMfVGlU3sf/EHiSEgg81HovKC
         wSlw==
X-Gm-Message-State: AOAM530ZBkqAjB7T1BIhie7NZeuSIu8dxDTljuZxOk1zaTlkTVxnc+12
        Q7BRfRKLoOurO8lFAlUP8DrTmMx6mHIljaZ2t6Lc7Q==
X-Google-Smtp-Source: ABdhPJwqr5E8tIV2SbhEtxSA3RtRQtEAI6rR6homh8EtYJqH5kxvSau5HJ2Z64H9SvD8tbc4e1hqjCUX3t200cKPvKk=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr6241717ljo.286.1596527751593;
 Tue, 04 Aug 2020 00:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com>
 <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com> <CAHp75Vc8yXqCsZ79=YWZLJ3ObgA1AYLj0eqqK0e8sXvMWsf+Hg@mail.gmail.com>
In-Reply-To: <CAHp75Vc8yXqCsZ79=YWZLJ3ObgA1AYLj0eqqK0e8sXvMWsf+Hg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Aug 2020 09:55:40 +0200
Message-ID: <CACRpkdY+qb-d31cZjWtscSOMLxdvyaHc5xFbTd-k8AA0_fTXUg@mail.gmail.com>
Subject: Re: [GIT PULL 3/5] ARM: SoC changes for v5.9
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 9:34 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 4, 2020 at 10:02 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Mon, 3 Aug 2020 at 21:49, Arnd Bergmann <arnd@arndb.de> wrote:
> > > ARM: SoC changes for v5.9
> >
> > > Andy Shevchenko (1):
> > >       ARM: orion/gpio: Make use of for_each_requested_gpio()
> >
> > This change broke the arm build (I noticed it when building multi_v5_de=
fconfig):
> >
> > ../arch/arm/plat-orion/gpio.c:457:2: error: implicit declaration of
> > function =E2=80=98for_each_requested_gpio=E2=80=99
> > [-Werror=3Dimplicit-function-declaration]
> >   457 |  for_each_requested_gpio(chip, i, label) {
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > for_each_requested_gpio isn't in Linus (Torvalds) tree yet. It will be
> > fixed when he pulls Linus Walleij's GPIO tree which has the commit:
> >
> >  b3337eb24831 gpiolib: Introduce for_each_requested_gpio_in_range() mac=
ro
>
> Linus W. specifically created an immutable branch [1] for this.
> And I think I commented somewhere that entire branch should be pulled.

OK let's fix it by firing off the GPIO pull request ASAP.

Yours,
Linus Walleij
