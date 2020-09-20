Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B60271453
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgITMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgITMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 08:38:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321DC061755;
        Sun, 20 Sep 2020 05:38:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so12474172ioo.1;
        Sun, 20 Sep 2020 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7yLC45oNPBKamsN5IPYHoKjdcmeugfCFnTTGzw/Mp7k=;
        b=Zq+i9zAbfyWQfSJr9OKDJifsxf3ndrkd5j44FWFcFw/Gmr1KeQdT8BMHR/9Buq0lvq
         Re9hE/hHEr6qlUlqI8PPwM+hCdLzTUREY2ROmHSm7xpyb0UT9XVJJ9ktPI29FsvUbQCd
         ZhAoYeoLInbl9H1KtclMlfY6fF1wx1lZ6dMSG5zoV4FB/HJd0tTL1jix9AjJ+GKgPYHG
         +NZaufQcn176FB/emFwPzkEfgB1g5o+PyR7Sk8N6QoHUC2sesVF8fMmj+tM9N6W4QFke
         omKqKMy1y1qQ8/oaC4RiY56moUZbSAsd1LyoQ07tvvsDoXrlRiPZ7o9mxgneHWiIOcA6
         u03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7yLC45oNPBKamsN5IPYHoKjdcmeugfCFnTTGzw/Mp7k=;
        b=ffodxADIxIecP9/duI2pYr4z5aN0taNZ7mY3ERIqObzcvEAGuSzCHlGz/w9UgPssPD
         gxH6Xh6foFvudYTdxr+nBb9gwYuPy24y2V3H8e6AvRPJq9kftI2N9WtwZ6Gn27OU3zPF
         UYU9mccDbu9qr4KhNBm2+QxB3brZgY7FhlNYSO/dJhGFjNSJcTMjWoKnyzXFahtM9/Jr
         gMm34miUmF4SklZpXJAxHOvL6H8wY7WlEM5F2SAWTMM/bdteGKAu7thxtPXNIT/bb+Ce
         PRKKmb5G1B4XYpVGMhly1kXltiPg9d5Unh5YJAHbqWZ25pp97EgFmt2SBJyMoFnwL9TY
         2Z2Q==
X-Gm-Message-State: AOAM53092mgE4DTANxIjWLU05hIoZl7fc1Xe6Sn7uQyFs9+mYU/ic/0M
        sNFqnycU3lvNygE1W5lpmTUvbc8BD62VmddJOqA=
X-Google-Smtp-Source: ABdhPJx3H7Q7/haYuNT6KsqJc7+aVqi2qaAKhZ/jyoP4KWhJYrllhDu11AA7rHaFz6tJ3aBBOB1B2vhVFwxHJf0xZK8=
X-Received: by 2002:a05:6638:168c:: with SMTP id f12mr36462448jat.16.1600605519510;
 Sun, 20 Sep 2020 05:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
 <20200729143927.47f5tbuaob4ph3lp@gilmour.lan> <20200729151548.GB5612@sirena.org.uk>
 <CAJiuCcdf=TNLPTUPzHP9NzPHqdxG06TRDkQfONY+ScK0DV_v5w@mail.gmail.com>
 <20200903205851.gdnpthserywsxrbs@gilmour.lan> <80b5a4e3-c8bc-9521-4ff1-12bb6424516f@sholland.org>
 <20200910143314.qku7po6htiiq5lzf@gilmour.lan> <57f8bdeb-14dc-583e-ffa8-43d7a9f1bb24@sholland.org>
 <20200917132128.e6z4gwoluipbzigm@gilmour.lan> <CAJiuCcdWQRVMeTLvxibZ37CF9BMiC_L2bWBDiin2Uz0CWq2FuQ@mail.gmail.com>
 <20200917140611.5qpsz24yfii5kzcn@gilmour.lan>
In-Reply-To: <20200917140611.5qpsz24yfii5kzcn@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 20 Sep 2020 14:38:28 +0200
Message-ID: <CAJiuCcfnXH44sBu6659Misvfxrrj2ZDmLmU5sABMwdrBBYd1Lg@mail.gmail.com>
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

Hi Maxime,

On Thu, 17 Sep 2020 at 16:06, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Clement,
>
> On Thu, Sep 17, 2020 at 03:55:45PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime and Samuel,
> >
> > On Thu, 17 Sep 2020 at 15:21, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, Sep 12, 2020 at 03:29:55PM -0500, Samuel Holland wrote:
> > > > On 9/10/20 9:33 AM, Maxime Ripard wrote:
> > > > > On Thu, Sep 03, 2020 at 09:54:39PM -0500, Samuel Holland wrote:
> > > > >> On 9/3/20 3:58 PM, Maxime Ripard wrote:
> > > > >>> On Thu, Sep 03, 2020 at 10:02:31PM +0200, Cl=C3=A9ment P=C3=A9r=
on wrote:
> > > > >>>> Hi Maxime,
> > > > >>>>
> > > > >>>> On Wed, 29 Jul 2020 at 17:16, Mark Brown <broonie@kernel.org> =
wrote:
> > > > >>>>>
> > > > >>>>> On Wed, Jul 29, 2020 at 04:39:27PM +0200, Maxime Ripard wrote=
:
> > > > >>>>>
> > > > >>>>>> It really looks like the polarity of LRCK is fine though. Th=
e first word
> > > > >>>>>> is sent with LRCK low, and then high, so we have channel 0 a=
nd then
> > > > >>>>>> channel 1 which seems to be the proper ordering?
> > > > >>
> > > > >> Which image file is this in reference to?
> > > > >>
> > > > >>>>> Yes, that's normal.
> > > > >>>>
> > > > >>>> Thank you very much for this test.
> > > > >>>>
> > > > >>>> So I will revert the following commit:
> > > > >>>>
> > > > >>>> ASoC: sun4i-i2s: Fix the LRCK polarity
> > > > >>>>
> > > > >>>> https://github.com/clementperon/linux/commit/dd657eae8164f7e4b=
afe8b875031a7c6c50646a9
> > > > >>>
> > > > >>> Like I said, the current code is working as expected with regar=
d to the
> > > > >>> LRCK polarity. The issue is that the samples are delayed and st=
art to be
> > > > >>> transmitted on the wrong phase of the signal.
> > > > >>
> > > > >> Since an I2S LRCK frame is radially symmetric, "wrong phase" and=
 "inverted
> > > > >> polarity" look the same. The only way to definitively distinguis=
h them is by
> > > > >> looking at the sample data.
> > > > >>
> > > > >> In "i2s-h6.png", the samples are all zeroes, so you're assuming =
that the first
> > > > >> sample transmitted (that is, when the bit clock starts transitio=
ning) was a
> > > > >> "left" sample.
> > > > >>
> > > > >> However, in "h6-i2s-start-data.png", there are pairs of samples =
we can look at.
> > > > >> I'm still assuming that similar samples are a left/right pair, b=
ut that's
> > > > >> probably a safe assumption. Here we see the first sample in each=
 pair is
> > > > >> transmitted with LRCK *high*, and the second sample in the pair =
is transmitted
> > > > >> with LRCK *low*. This is the opposite of your claim above.
> > > > >>
> > > > >> An ideal test would put left/right markers and frame numbers in =
the data
> > > > >> channel. The Python script below can generate such a file. Then =
you would know
> > > > >> how much startup delay there is, which channel the "first sample=
" came from, and
> > > > >> how each channel maps to the LRCK level.
> > > > >>
> > > > >> It would also be helpful to test DSP_A mode, where the LRCK sign=
al is
> > > > >> asymmetric and an inversion would be obvious.
> > > > >
> > > > > I had no idea that there was a wave module in Python, that's a gr=
eat
> > > > > suggestion, thanks!
> > > > >
> > > > > You'll find attached the screenshots for both the I2S and DSP_A f=
ormats.
> > > > > I zoomed out a bit to be able to have the first valid samples, bu=
t it
> > > > > should be readable.
> > > > >
> > > > > The code I used is there:
> > > > > https://github.com/mripard/linux/tree/sunxi/h6-i2s-test
> > > > >
> > > > > It's basically the v3, plus the DT bits.
> > > > >
> > > > > As you can see, in the i2s case, LRCK starts low and then goes up=
, with
> > > > > the first channel (0x2*** samples) transmitted first, so everythi=
ng
> > > > > looks right here.
> > > > >
> > > > > On the DSP_A screenshot, LRCK will be low with small bursts high,=
 and
> > > > > once again with the first channel being transmitted first, so it =
looks
> > > > > right to me too.
> > > >
> > > > Indeed, for H6 i2s0 with LRCK inversion in software, everything loo=
ks correct on
> > > > the wire.
> > > >
> > > > It's still concerning to me that the BSP has no evidence of this in=
version,
> > > > either for i2s0 or i2s1[1]. And the inversion seems not to be requi=
red for HDMI
> > > > audio on mainline either (but there could be an inversion on the HD=
MI side or on
> > > > the interconnect).
> > >
> > > One can only guess here, but it's also quite easy to fix it at the ca=
rd
> > > level (or maybe there's a similar inversion in the codecs, or whateve=
r).
> >
> > Thanks for the test and the explanation.
> >
> > Quite disturbing that there is no evidence of the LRCK inversion in
> > kernel vendor indeed...
> > Could it be an issue with the mainline code?
>
> I'm not sure what you mean here, this was tested with mainline?

Sorry i was not clear, I meant either there is an issue in the vendor
kernel that doesn't set properly the LRCK or maybe we did something or
forgot to do it that set this inversion.

But I just checked a device-tree used with a kernel vendor and indeed
codecs are inverted but not hdmi so the vendor kernel has an issue
here...

E.g this is what is used for Tanix TX6

daudio@0x05091000 {
    compatible =3D "allwinner,sunxi-tdmhdmi";
    reg =3D <0x00 0x5091000 0x00 0x74>;
    clocks =3D <0x04 0x4d>;
    status =3D "okay";
    phandle =3D <0x63>;
    device_type =3D "audiohdmi";
};

daudio@0x05092000 {
    compatible =3D "allwinner,sunxi-daudio";
    reg =3D <0x00 0x5092000 0x00 0x74>;
    clocks =3D <0x04 0x4e>;
    pinctrl-names =3D "default\0sleep";
    pinctrl-0 =3D <0x4f>;
    pinctrl-1 =3D <0x50>;
    pcm_lrck_period =3D <0x40>;
    slot_width_select =3D <0x20>;
    daudio_master =3D <0x04>;
    audio_format =3D <0x04>;
    signal_inversion =3D <0x03>;
    tdm_config =3D <0x01>;
    frametype =3D <0x00>;
    tdm_num =3D <0x02>;
    mclk_div =3D <0x01>;
    status =3D "okay";
    phandle =3D <0x65>;
    device_type =3D "daudio2";
};

daudio@0x0508f000 {
    compatible =3D "allwinner,sunxi-daudio";
    reg =3D <0x00 0x508f000 0x00 0x74>;
    clocks =3D <0x04 0x51>;
    pinctrl-names =3D "default\0sleep";
    pinctrl-0 =3D <0x52>;
    pinctrl-1 =3D <0x53>;
    pcm_lrck_period =3D <0x20>;
    slot_width_select =3D <0x20>;
    daudio_master =3D <0x04>;
    audio_format =3D <0x01>;
    signal_inversion =3D <0x01>;
    tdm_config =3D <0x01>;
    frametype =3D <0x00>;
    tdm_num =3D <0x03>;
    mclk_div =3D <0x01>;
    status =3D "okay";
    phandle =3D <0x67>;
    device_type =3D "daudio3";
};

Clement


>
> Maxime
