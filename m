Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538F32730C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgIURP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIURPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:15:25 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B0C061755;
        Mon, 21 Sep 2020 10:15:25 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so16238760iow.4;
        Mon, 21 Sep 2020 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OfjpKCjgpFcyIPadh1UeQQlqIJ/XQ8FTUIY77xhbs1M=;
        b=a1xvXmosY39aq2upt7jpTrsD4onvVX8CyT0/UwKVqUS7KlrTR0AIZii4mUTvT32hmA
         i/0S+WQLWmKm3JW8G8i16TOuvz/hze0R9QTcDctff7exS5RH9aTEon6Ks4J2C1XrLpIq
         xFqUaJfXncTM1HMMug97koDCv/+ZeV9t5l7roUlBfTvxjwg2gkiOFv0kNRzglmFEmxoN
         En3Z/sxR3CXjsx4MCibYjSY7G0OvMc6K/zvr4xIUxmel8A8XPK7XyJDlKGlgPX/pOj4W
         qo32rdACDgyvcH4JPfCUN+ic9b57C4nWB5JEB9lk0ckIlmA52RJokQdnJ+2vUXBLEiBn
         bWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OfjpKCjgpFcyIPadh1UeQQlqIJ/XQ8FTUIY77xhbs1M=;
        b=nKKG9V/w8KvMSOVoklmH89RcKjlDooNE7kTwLZGdWTMYLS/sp5M++OLro5tMqk3CJF
         xX8JuGRV+eKgcodsiDn2SP2g9G4KxOM+6ELYbprgNuT39h0IDrbKFo3KBDRQeYKAveHd
         PeyQoMHvpPJsY2J8eb5CvePPoGg2S6WUhBg+2MfJhMuCracyM0Y702wzB7FJVCsYgCSz
         BsSmFHPGOaiRYLPW1zDHEp9fJRdAxDVnTHQs0RERioK5kP/kN5CI0/6+iWZnHS6LTFQz
         nd1j81u3v94t5T9j1+V9PIBXtXQFocsjwUlTl1snRoRMFmMJjZyNsf8rddGTvXzc76u0
         zzJA==
X-Gm-Message-State: AOAM532ezlIbOHwv4TQUAcbdncvXawK4e8yR2CTrn+K5w9jM7+07N5j9
        1d/wCosQs8eyP0pDpc9rPSSV+y0F/Xe9hfQ49rw=
X-Google-Smtp-Source: ABdhPJxZBxQ1fxsquRrTgaINgoIJXJR0GXEKUzOWZH8kFP5ZkKMxh6FQDWwyDbq36aMx3Yi3EhEDiEA2U3q/7QrGEac=
X-Received: by 2002:a02:734f:: with SMTP id a15mr907939jae.120.1600708524243;
 Mon, 21 Sep 2020 10:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921102731.747736-3-peron.clem@gmail.com>
 <20200921122918.kzzu623wui277nwr@gilmour.lan>
In-Reply-To: <20200921122918.kzzu623wui277nwr@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 21 Sep 2020 19:15:13 +0200
Message-ID: <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
Subject: Re: [PATCH v4 02/22] ASoC: sun4i-i2s: Change set_chan_cfg() params
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 21 Sep 2020 at 14:29, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 21, 2020 at 12:27:11PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > As slots and slot_width can be overwritter in case set_tdm() is
> > called. Avoid to have this logic in set_chan_cfg().
> >
> > Instead pass the required values as params to set_chan_cfg().
>
> It's not really clear here what the issue is, and how passing the slots
> and slot_width as arguments addresses it
>
> > This also fix a bug when i2s->slot_width is set for TDM but not
> > properly used in set_chan_cfg().
>
> Which bug?

Do you mean my commit log is too short or is it a real question to understa=
nd ?

To answer if set_tdm() is called then we set the i2s->slot_width and i2s->s=
lots.
But we use lrck_period =3D params_physical_width(params)
instead of lrck_period =3D i2s->slot_width ?  i2s->slot_width :
params_physical_width(params);

>
> Also, Fixes tag?

I think this only happens when 20/24bit is enabled so the issue has been
introduced in this series.

Clement

>
> Thanks!
> Maxime
