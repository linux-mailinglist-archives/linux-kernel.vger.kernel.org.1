Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601E92E818A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLaSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 13:08:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgLaSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 13:08:31 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kv2MV-00051y-NC
        for linux-kernel@vger.kernel.org; Thu, 31 Dec 2020 18:07:47 +0000
Received: by mail-lf1-f70.google.com with SMTP id a10so12276012lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 10:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0V7U/gNm+Y+R6u7qQmRsQkwPnBjsroHOTb3lajqSuRM=;
        b=Vni43KGWFVMzH0ywiThOop7okFOHIqKTeL6Uh17UXDF3nTDpwGDdktfCFVzisb7mSe
         YkmyvmrqBjG94iDms+hGmRfnRPqZsLglVydjQfq25nJNU0uYXwwyaifNuK2SL4fNw89P
         JNeBDaWq/qfkuM1ZdhvkHbD7qODkPkgwgR0HXYDIvGimSaMjWdpfDAglNjhR/U1qIo1b
         Ie5WxQVwQBvz0I7DsX4faxk8f86v0YPFyetVJ17zeT96ibYlorDhfBappBaou4kyJ5fS
         xG1UzqE2SSxJGdSFlJNPmbcEsTAJwugwwQlR/4ylRClU5ig8FEI8PNCuaRO9H4m98R9v
         tjNw==
X-Gm-Message-State: AOAM532HtWbbPBMSKPdEVFvwjYszPwub/XnLuDt9dAhHTy2iwqTPB0Fa
        951i4EQwIcpDeB+J5y+cGS0wnBwT+goOx4heoiCrTSV6WnJAvhs0sdv6abZAJnO8ePBTa/2XXch
        3CSmy7fmQ3KUC/c+8NIVXukl/+XMsmm2zyZ2uiEzWnyoXVIRyfvjbAD2ulA==
X-Received: by 2002:a19:8316:: with SMTP id f22mr27363180lfd.10.1609438066998;
        Thu, 31 Dec 2020 10:07:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKnCfGocE3EH8dPTyyxTDZeVYd6vD0uGtU7jtolwNyuue4/jjmMeNyR3I806TvGD2AdPoRwTjn7s4wRb+yE00=
X-Received: by 2002:a19:8316:: with SMTP id f22mr27363162lfd.10.1609438066739;
 Thu, 31 Dec 2020 10:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20201229133817.190160-1-kai.heng.feng@canonical.com> <s5hsg7mb63l.wl-tiwai@suse.de>
In-Reply-To: <s5hsg7mb63l.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 1 Jan 2021 02:07:34 +0800
Message-ID: <CAAd53p4GxNnbWKRDxck0=Qz5JTyKTSubswbG+LQ=y2ntJ=KvqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: Intel: hda: Modify existing helper to
 disable WAKEEN
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Amery Song <chao.song@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 6:52 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 29 Dec 2020 14:38:14 +0100,
> Kai-Heng Feng wrote:
> >
> > Modify hda_codec_jack_wake_enable() to also support disable WAKEEN.
> > This is a preparation for next patch.
> >
> > No functional change intended.
>
> Maybe it's better to mention that this patch moves the WAKEEN
> disablement call out of hda_codec_jack_check() into
> hda_codec_jack_wake_enable(), too.

Ok, will update the commit log in v2.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  sound/soc/sof/intel/hda-codec.c | 16 +++++++---------
> >  sound/soc/sof/intel/hda-dsp.c   |  6 ++++--
> >  sound/soc/sof/intel/hda.h       |  2 +-
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> > index 6875fa570c2c..bc9ac4abdab5 100644
> > --- a/sound/soc/sof/intel/hda-codec.c
> > +++ b/sound/soc/sof/intel/hda-codec.c
> > @@ -63,16 +63,18 @@ static int hda_codec_load_module(struct hda_codec *codec)
> >  }
> >
> >  /* enable controller wake up event for all codecs with jack connectors */
> > -void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
> > +void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable)
> >  {
> >       struct hda_bus *hbus = sof_to_hbus(sdev);
> >       struct hdac_bus *bus = sof_to_bus(sdev);
> >       struct hda_codec *codec;
> >       unsigned int mask = 0;
> >
> > -     list_for_each_codec(codec, hbus)
> > -             if (codec->jacktbl.used)
> > -                     mask |= BIT(codec->core.addr);
> > +     if (enable) {
> > +             list_for_each_codec(codec, hbus)
> > +                     if (codec->jacktbl.used)
> > +                             mask |= BIT(codec->core.addr);
> > +     }
> >
> >       snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, mask);
> >  }
> > @@ -81,12 +83,8 @@ void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
> >  void hda_codec_jack_check(struct snd_sof_dev *sdev)
> >  {
> >       struct hda_bus *hbus = sof_to_hbus(sdev);
> > -     struct hdac_bus *bus = sof_to_bus(sdev);
> >       struct hda_codec *codec;
> >
> > -     /* disable controller Wake Up event*/
> > -     snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
> > -
> >       list_for_each_codec(codec, hbus)
> >               /*
> >                * Wake up all jack-detecting codecs regardless whether an event
> > @@ -97,7 +95,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
> >                                             codec->jackpoll_interval);
> >  }
> >  #else
> > -void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev) {}
> > +void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable) {}
> >  void hda_codec_jack_check(struct snd_sof_dev *sdev) {}
> >  #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
> >  EXPORT_SYMBOL_NS(hda_codec_jack_wake_enable, SND_SOC_SOF_HDA_AUDIO_CODEC);
> > diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
> > index 2b001151fe37..7d00107cf3b2 100644
> > --- a/sound/soc/sof/intel/hda-dsp.c
> > +++ b/sound/soc/sof/intel/hda-dsp.c
> > @@ -617,7 +617,7 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
> >
> >  #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
> >       if (runtime_suspend)
> > -             hda_codec_jack_wake_enable(sdev);
> > +             hda_codec_jack_wake_enable(sdev, true);
> >
> >       /* power down all hda link */
> >       snd_hdac_ext_bus_link_power_down_all(bus);
> > @@ -683,8 +683,10 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
> >
> >  #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
> >       /* check jack status */
> > -     if (runtime_resume)
> > +     if (runtime_resume) {
> > +             hda_codec_jack_wake_enable(sdev, false);
> >               hda_codec_jack_check(sdev);
> > +     }
> >
> >       /* turn off the links that were off before suspend */
> >       list_for_each_entry(hlink, &bus->hlink_list, list) {
> > diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
> > index 9ec8ae0fd649..a3b6f3e9121c 100644
> > --- a/sound/soc/sof/intel/hda.h
> > +++ b/sound/soc/sof/intel/hda.h
> > @@ -650,7 +650,7 @@ void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev);
> >   */
> >  void hda_codec_probe_bus(struct snd_sof_dev *sdev,
> >                        bool hda_codec_use_common_hdmi);
> > -void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev);
> > +void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable);
> >  void hda_codec_jack_check(struct snd_sof_dev *sdev);
> >
> >  #endif /* CONFIG_SND_SOC_SOF_HDA */
> > --
> > 2.29.2
> >
