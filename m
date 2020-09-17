Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906BF26DD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgIQOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgIQN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:56:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD0C061353;
        Thu, 17 Sep 2020 06:55:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so2280119ioo.1;
        Thu, 17 Sep 2020 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2jrBKqKQYC6+vUb3ebXkO1vJePh1ZuqzCyAnBTQWz08=;
        b=bPyMVM6NEQR7Qz2I3gkQq4PfWQkY4ABpxZkCX364BqmAgtMi3KZ0pLxHIuPiKB8kVz
         LBf0pQhZcPaJJ/FY2KYphDrKPh3vHE1dGBICHj0CP3JvDw5EpF8zpb7HEFjRgrGrmBEr
         45x2kaUN8dtZl+IcF0csmcG08cMruUza9vV5LlVKvCOGPH9mYqKz1veGOa9tusBefxsx
         y5RP0Z3xCABg3Cpf9F27onzefISiQzqOXJAj6vSKLSipFwJNK8vAXUSTVZg2Bq0IWVxF
         Wovdj4MNnaLZ6+LP388lBagSDtz4/3n8QmCvI23AP7FUMHhUdv+MwZFmhTolt+SLPCvP
         PiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2jrBKqKQYC6+vUb3ebXkO1vJePh1ZuqzCyAnBTQWz08=;
        b=V68YkpyF9B3nhtUSo8SAZMottTbtnX6RANRWCYipJSVn75HYZdg9AD1I9ZXfS4eD01
         t3U61Ymc0YatcGLGOzQYOBd6PaWbf8R5FC6OgprH6z67lfYuSnyFL/r3mtTMq6MTl191
         KbGqQ67jnyNYeWvtnLjnXefbeP4RY6T9zbF40dGBnGz07yioh38kQVknP/RtYoeFLRwc
         y9ProEWE9oKo0E4n58dHw+BIlAVOGDLlS8rAUsyrOfbnHiI7+FTTQUvokeeSU4sIgLWq
         eC/wtm5VmJv0rNkV7+wfqZXfTzytlPBD2PUpTU3cA68N8Qm40eRH8sOB8Bx6oe/WSf8L
         2hMA==
X-Gm-Message-State: AOAM532GkHxL78dpi+ZZAP9ifphUi0cwivS/0KYP7sXgt1SXptZ1enmB
        F5HZMtvfAgrq5sLLyp185w5Pb8YD6OTdIJxiBmU=
X-Google-Smtp-Source: ABdhPJw38P4GTdYIQhTX2C1j1TDaFP7ucC25qrcwBgz9aXTHrGXpHgn8N9b40QJ1hCeE5yPvuPYIiKqxNafH8lnCiDw=
X-Received: by 2002:a02:734f:: with SMTP id a15mr27150294jae.120.1600350956955;
 Thu, 17 Sep 2020 06:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiuCcf_LHrJ6QdZgH8HyN6TRiT+GiD+t4UggFCrz-VwVHXV6w@mail.gmail.com>
 <20200504120942.lnrxnnmykqnvw3fb@gilmour.lan> <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
 <20200729143927.47f5tbuaob4ph3lp@gilmour.lan> <20200729151548.GB5612@sirena.org.uk>
 <CAJiuCcdf=TNLPTUPzHP9NzPHqdxG06TRDkQfONY+ScK0DV_v5w@mail.gmail.com>
 <20200903205851.gdnpthserywsxrbs@gilmour.lan> <80b5a4e3-c8bc-9521-4ff1-12bb6424516f@sholland.org>
 <20200910143314.qku7po6htiiq5lzf@gilmour.lan> <57f8bdeb-14dc-583e-ffa8-43d7a9f1bb24@sholland.org>
 <20200917132128.e6z4gwoluipbzigm@gilmour.lan>
In-Reply-To: <20200917132128.e6z4gwoluipbzigm@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 17 Sep 2020 15:55:45 +0200
Message-ID: <CAJiuCcdWQRVMeTLvxibZ37CF9BMiC_L2bWBDiin2Uz0CWq2FuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and Samuel,

On Thu, 17 Sep 2020 at 15:21, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sat, Sep 12, 2020 at 03:29:55PM -0500, Samuel Holland wrote:
> > On 9/10/20 9:33 AM, Maxime Ripard wrote:
> > > On Thu, Sep 03, 2020 at 09:54:39PM -0500, Samuel Holland wrote:
> > >> On 9/3/20 3:58 PM, Maxime Ripard wrote:
> > >>> On Thu, Sep 03, 2020 at 10:02:31PM +0200, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > >>>> Hi Maxime,
> > >>>>
> > >>>> On Wed, 29 Jul 2020 at 17:16, Mark Brown <broonie@kernel.org> wrot=
e:
> > >>>>>
> > >>>>> On Wed, Jul 29, 2020 at 04:39:27PM +0200, Maxime Ripard wrote:
> > >>>>>
> > >>>>>> It really looks like the polarity of LRCK is fine though. The fi=
rst word
> > >>>>>> is sent with LRCK low, and then high, so we have channel 0 and t=
hen
> > >>>>>> channel 1 which seems to be the proper ordering?
> > >>
> > >> Which image file is this in reference to?
> > >>
> > >>>>> Yes, that's normal.
> > >>>>
> > >>>> Thank you very much for this test.
> > >>>>
> > >>>> So I will revert the following commit:
> > >>>>
> > >>>> ASoC: sun4i-i2s: Fix the LRCK polarity
> > >>>>
> > >>>> https://github.com/clementperon/linux/commit/dd657eae8164f7e4bafe8=
b875031a7c6c50646a9
> > >>>
> > >>> Like I said, the current code is working as expected with regard to=
 the
> > >>> LRCK polarity. The issue is that the samples are delayed and start =
to be
> > >>> transmitted on the wrong phase of the signal.
> > >>
> > >> Since an I2S LRCK frame is radially symmetric, "wrong phase" and "in=
verted
> > >> polarity" look the same. The only way to definitively distinguish th=
em is by
> > >> looking at the sample data.
> > >>
> > >> In "i2s-h6.png", the samples are all zeroes, so you're assuming that=
 the first
> > >> sample transmitted (that is, when the bit clock starts transitioning=
) was a
> > >> "left" sample.
> > >>
> > >> However, in "h6-i2s-start-data.png", there are pairs of samples we c=
an look at.
> > >> I'm still assuming that similar samples are a left/right pair, but t=
hat's
> > >> probably a safe assumption. Here we see the first sample in each pai=
r is
> > >> transmitted with LRCK *high*, and the second sample in the pair is t=
ransmitted
> > >> with LRCK *low*. This is the opposite of your claim above.
> > >>
> > >> An ideal test would put left/right markers and frame numbers in the =
data
> > >> channel. The Python script below can generate such a file. Then you =
would know
> > >> how much startup delay there is, which channel the "first sample" ca=
me from, and
> > >> how each channel maps to the LRCK level.
> > >>
> > >> It would also be helpful to test DSP_A mode, where the LRCK signal i=
s
> > >> asymmetric and an inversion would be obvious.
> > >
> > > I had no idea that there was a wave module in Python, that's a great
> > > suggestion, thanks!
> > >
> > > You'll find attached the screenshots for both the I2S and DSP_A forma=
ts.
> > > I zoomed out a bit to be able to have the first valid samples, but it
> > > should be readable.
> > >
> > > The code I used is there:
> > > https://github.com/mripard/linux/tree/sunxi/h6-i2s-test
> > >
> > > It's basically the v3, plus the DT bits.
> > >
> > > As you can see, in the i2s case, LRCK starts low and then goes up, wi=
th
> > > the first channel (0x2*** samples) transmitted first, so everything
> > > looks right here.
> > >
> > > On the DSP_A screenshot, LRCK will be low with small bursts high, and
> > > once again with the first channel being transmitted first, so it look=
s
> > > right to me too.
> >
> > Indeed, for H6 i2s0 with LRCK inversion in software, everything looks c=
orrect on
> > the wire.
> >
> > It's still concerning to me that the BSP has no evidence of this invers=
ion,
> > either for i2s0 or i2s1[1]. And the inversion seems not to be required =
for HDMI
> > audio on mainline either (but there could be an inversion on the HDMI s=
ide or on
> > the interconnect).
>
> One can only guess here, but it's also quite easy to fix it at the card
> level (or maybe there's a similar inversion in the codecs, or whatever).

Thanks for the test and the explanation.

Quite disturbing that there is no evidence of the LRCK inversion in
kernel vendor indeed...
Could it be an issue with the mainline code?

But still regarding the kernel vendor, it seems logical to have a
frame-inversion in the device-tree for the HDMI I2S node.
I will drop the revert patch and re-add the frame inversion in the next ser=
ies.

Regards,
Clement

>
> > Even so, your research is sufficient justification for me that the code=
 is
> > correct as-is (with the inversion). Thank you very much for collecting =
the data!
>
> You're welcome, thanks for that script :)
>
> maxime
