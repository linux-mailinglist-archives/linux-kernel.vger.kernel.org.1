Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE624263B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHLHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:43:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A3C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:43:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f12so1056169wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ga6T3Cy+kh1TnFrSU/BgLt86L1Ae+2hwNAjs8j02oF8=;
        b=hol+hh8JjG7+8Td5Y3AZkrMiWi6c+FnjZIx0uZ4RnrL55vZ7MusPGjbo/QfAgeQmJ1
         o9lkuGe+HE4Ohw3X382P5Kqpd3BPeuEwO8oeqL501BcCWdME9Mh4lbl96TzX4Gnjx1nb
         yUMwCY92PsBTHeo7NxMJbPtWsyl6AgtUQfKrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ga6T3Cy+kh1TnFrSU/BgLt86L1Ae+2hwNAjs8j02oF8=;
        b=U3V4CY994IA91V0eVC3VRuTXyjdxBwhKBcSTo7kJ+vKt8nCoHsxwqf8L6ciByNCIeS
         N2c2qELquHSDHI0gxhNQJ353K+G82XnFlL1Fff1aVSinOU71fg+rgOqe37uhtgOYl+h6
         jf7R7yX7jWh9iBSCClPQVDze6M1Y9yOpxxO8dQitbunAwjjY1TXqeVYz2jFeM9iKxPiH
         ykhnyz/032+Qn9BVaa/9nQa9MBkJa8eECJLrPAuYFZGQn+HFMI6cmHYpxwarDEXAzK6v
         U2d4g91eexXPzW3VP3CJlWko82BKMCa367GekO8zbeJA8oWfz+pzSAS0DjarEy0KSpYv
         PKIQ==
X-Gm-Message-State: AOAM531AgBq1TNGmZiIxOw+1OXfaXzVKjCNDVnZIrSfOOjrS/nQrPa8w
        faYYOHaw6wRyVVblSgvq/e+FDxOdK4rKJDrI/xhMmA==
X-Google-Smtp-Source: ABdhPJyoyVFNUCQzV+GdngHdYV/Kl2T2efj6sEyjpzqgjLkdb1V9rB0pF/Z+jW3c9VLxtezHJOrfD4PS+K7JdIvDJww=
X-Received: by 2002:adf:c981:: with SMTP id f1mr32180609wrh.14.1597218213822;
 Wed, 12 Aug 2020 00:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
 <DM6PR11MB3642AC7F8EC47EB48B384D4797450@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de> <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de> <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
 <20200811145353.GG6967@sirena.org.uk> <d78f9adc-d583-f0f2-ce38-3c9175c939b8@linux.intel.com>
 <20200811172209.GM6967@sirena.org.uk> <CAGvk5PqGi7cXthLHFi4NyypxFiGnoHvD9vp+5nJdH-_VkVvcKw@mail.gmail.com>
 <s5hr1scz908.wl-tiwai@suse.de> <CAGvk5Pp+Gk5Uk-iLdhVPWuCL0FiL9OhsaAtwkotay5JAYUNxdQ@mail.gmail.com>
 <s5hlfikz6y8.wl-tiwai@suse.de>
In-Reply-To: <s5hlfikz6y8.wl-tiwai@suse.de>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Wed, 12 Aug 2020 15:43:22 +0800
Message-ID: <CAGvk5Pq3rEGJX=WjriPfWg_sEAVWHGZ9S=4iySNfYaHX7Xcw0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago board
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8812=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 12 Aug 2020 08:53:42 +0200,
> Yu-Hsuan Hsu wrote:
> >
> > Takashi Iwai <tiwai@suse.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Wed, 12 Aug 2020 05:09:58 +0200,
> > > Yu-Hsuan Hsu wrote:
> > > >
> > > > Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:22=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Tue, Aug 11, 2020 at 11:54:38AM -0500, Pierre-Louis Bossart wr=
ote:
> > > > >
> > > > > > > constraint logic needs to know about this DSP limitation - it=
 seems like
> > > > > > > none of this is going to change without something new going i=
nto the
> > > > > > > mix?  We at least need a new question to ask about the DSP fi=
rmware I
> > > > > > > think.
> > > > >
> > > > > > I just tested aplay -Dhw: on a Cyan Chromebook with the Ubuntu =
kernel 5.4,
> > > > > > and I see no issues with the 240 sample period. Same with 432, =
960, 9600,
> > > > > > etc.
> > > > >
> > > > > > I also tried just for fun what happens with 256 samples, and I =
don't see any
> > > > > > underflows thrown either, so I am wondering what exactly the pr=
oblem is?
> > > > > > Something's not adding up. I would definitively favor multiple =
of 1ms
> > > > > > periods, since it's the only case that was productized, but the=
re's got to
> > > > > > me something a side effect of how CRAS programs the hw_params.
> > > > >
> > > > > Is it something that goes wrong with longer playbacks possibly (e=
g,
> > > > > someone watching a feature film or something)?
> > > >
> > > > Thanks for testing!
> > > >
> > > > After doing some experiments, I think I can identify the problem mo=
re precisely.
> > > > 1. aplay can not reproduce this issue because it writes samples
> > > > immediately when there are some space in the buffer. However, you c=
an
> > > > add --test-position to see how the delay grows with period size 256=
.
> > > > > aplay -Dhw:1,0 --period-size=3D256 --buffer-size=3D480 /dev/zero =
-d 1 -f dat --test-position
> > > > Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48=
000
> > > > Hz, Stereo
> > > > Suspicious buffer position (1 total): avail =3D 0, delay =3D 2064, =
buffer =3D 512
> > > > Suspicious buffer position (2 total): avail =3D 0, delay =3D 2064, =
buffer =3D 512
> > > > Suspicious buffer position (3 total): avail =3D 0, delay =3D 2096, =
buffer =3D 512
> > > > ...
> > >
> > > Isn't this about the alignment of the buffer size against the period
> > > size, not the period size itself?  i.e. in the example above, the
> > > buffer size isn't a multiple of period size, and DSP can't handle if
> > > the position overlaps the buffer size in a half way.
> > >
> > > If that's the problem (and it's an oft-seen restriction), the right
> > > constraint is
> > >   snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> > >
> > >
> > > Takashi
> > Oh sorry for my typo. The issue happens no matter what buffer size is
> > set. Actually, even if I want to set 480, it will change to 512
> > automatically.
> > Suspicious buffer position (1 total): avail =3D 0, delay =3D 2064, buff=
er
> > =3D 512 <-this one is the buffer size
>
> OK, then it means that the buffer size alignment is already in place.
>
> And this large delay won't happen if you use period size 240?
>
>
> Takashi
Yes! If I set the period size to 240, it will not print "Suspicious
buffer position ..."

Yu-Hsuan

>
> > > > 2. Since many samples are moved to DSP(delay), the measured rate of
> > > > the ring-buffer is high. (I measured it by alsa_conformance_test,
> > > > which only test the sampling rate in the ring buffer of kernel not
> > > > DSP)
> > > >
> > > > 3. Since CRAS writes samples with a fixed frequency, this behavior
> > > > will take all samples from the ring buffer, which is seen as underr=
un
> > > > by CRAS. (It seems that it is not a real underrun because that avai=
l
> > > > does not larger than buffer size. Maybe CRAS should also take dalay
> > > > into account.)
> > > >
> > > > 4. In spite of it is not a real underrun, the large delay is still =
a
> > > > big problem. Can we apply the constraint to fix it? Or any better
> > > > idea?
> > > >
> > > > Thanks,
> > > > Yu-Hsuan
> > > >
> >
