Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC9278A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgIYOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:05:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D51C0613CE;
        Fri, 25 Sep 2020 07:05:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so2559343ljd.10;
        Fri, 25 Sep 2020 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P5Lh1BdcjdGoxHBFomiSE8cYOjJgzO3F1edDWGZmPWw=;
        b=PtwZhK0ge9QkKqChLoEtq9LR6R4jGVDROrjfS8cQLa9VNR9yOQwYzo8nOR+ECv3Mar
         YOgTOs5ASngbyNyUeby9EHk62mo/UajnBwLq8YxJ2R8Z3Sx+49t5IYqQ/HRauUvA6c+K
         1f+Wk27uKYRtzupivbh9DcqeFPQXBJDxIbml3qS+MXnU6w1QUaG6SFTDalJiN9pzPEyl
         J3Dd7L8NHJ4bcDIvtXHx/M+Ntf0g+ZCpLGAh9q4vw5wLxH3cNlnsZ7jvxLMaTfoiB36i
         E5U4aUtw0S1+3a3F7o4APA2wXBDxLOn8eiEIFZzzYR8VfDab7tPFijLbrUEDw5sMr1t6
         HQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P5Lh1BdcjdGoxHBFomiSE8cYOjJgzO3F1edDWGZmPWw=;
        b=nYotGQ4lu30FDQPIYe9ykIDUaZu+mWnA8hS9WoknaMrhp38NjdT9IA+WUb8fhsO8ze
         Uj423BS798nHhxxqYcVvy8L4NJFPQre4yPJhN134WjUDSYd0U7su/ueIn8cFIksVg1P6
         /pxGBCSXgbYBzYPj07jX+kCNG/cNG+aFXtF/ktx1X6zJjBek2MsggZQwH3xQMK1vwr5H
         tZ911fHKR4S+rPbDUgpnmM+rbLXdqpo+Fwun24aMdEBVs+eDH05bMhmIVMZ54AbEL5HF
         uQ/X6lpi+gw78Q/5EEsxxAGEOYS7EYbjG90WalbxSxXWtTd8s8RC/RVA42LzOI9r15Dr
         ibWA==
X-Gm-Message-State: AOAM531KKnu9Wg2CUY9vu6UZ76A2XdqZdveuQ1Hwlh2uxvB7aHxgsEaH
        F+cMgqhfNFm7Pw+30dxXLNEkVB7/Uu4ycZsiVOsRU4AkeXg=
X-Google-Smtp-Source: ABdhPJwlGnBCLZ0OcgkIuHwSyHm9m6LoYqW1jIie7382h8vZWVIW5KfLjYMOgwnziqlZTIU3oiDH9IqKJgKwfkoH+5E=
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr1357198ljg.356.1601042716465;
 Fri, 25 Sep 2020 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
 <20200924161113.GF4754@sirena.org.uk> <CADiBU3_b69g9vZf-J8p2_m5xDjn24XaUHn88foBsQ4MpBN829g@mail.gmail.com>
 <20200925113224.GB4841@sirena.org.uk>
In-Reply-To: <20200925113224.GB4841@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Sep 2020 22:05:05 +0800
Message-ID: <CADiBU3-qCLJBwopVtGZ15CH8W3xb3+Pv9iDxtNCLCqjHUFwrtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] regulator: rtmv20: Adds support for Richtek RTMV20
 load switch regulator
To:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Sep 25, 2020 at 12:07:50PM +0800, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.
>
Sorry, I press the wrong button to only reply one not reply all.
Loop in the mail list again.
> > > I can't help but feel that this looks like a register cache would be =
a
> > > simpler way of achieving this.
>
> > This is because of enable gpio limitation. If gpio low to high, all
> > registers will be reset.
> > And enable gpio high to low will cause I2C cannot be accessed.
> > That's why we need to apply register setting after hardware enable pin
> > be pulled high.
> > The consumption current for EN L vs H is also different from 1uA vs
> > 450uA defined as typical values.
>
> That's exactly the sort of situation that regmap caches are usually used
> for, mark the device as cache only when powering off then resync after
> power on.
>
Thx, I think I catch the point.
> > > > +             switch (props[i].len) {
> > > > +             case RTMV20_2BYTE_ACCES:
> > > > +             case RTMV20_1BYTE_ACCES:
>
> > > It feels like this should all be abstracted in the regmap with custom
> > > reg_read() and reg_write() operations - or have two regmaps for the t=
wo
> > > different register sizes.  Having the register sizes and endianness
> > > handling outside of regmap code seems like an abstraction failure.
>
> > Actually, it's the consecutive register address with two byte data.
> > Lower address defined as val_h, and the higher defined as val_l.
> > So I just use cpu_to_be16 to do the transformation.
>
> Oh, so just a straight regmap would be fine.
>
Thx.
> > From the above hardware description, do you have any suggestion to
> > achieve the register cache?
>
> Look at how other devices use regcache_cache_only().
>
Thx.
> > > Don't do this, the driver should not adjust the system state unless
> > > explicitly told to do so - we don't know if any state changes are saf=
e
> > > on a given board.
>
> > From my original coding,  it's put before regulator register.
> > After regulator registered, it will follow the regulator framework to
> > do the turn on/off and the other settings.
> > I think it won't affect the system state, just to keep IC as shutdown
> > mode (1uA) after chip vendor info check.
>
> It depends if the device was enabled before the driver started, and if
> anything started powering on when the device was powered on.
Sure, I'll re-check the flow.
