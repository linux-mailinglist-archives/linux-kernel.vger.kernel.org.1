Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34ED2DB231
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgLORIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgLORIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:08:02 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF6C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:07:22 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id 2so19897183ilg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXcMQVRxxLeMuWVGiYndN3AoNdrpmXXu+WgZDK7JSOo=;
        b=X9/+MsjVJxTdVVNIAwOOKGLUTMl8i8t1w540FOTNJZdpRIu+fEb7R0GFZFLXb3mXaI
         0bRf60k0ipOiwqbhslK9jb/x4G0IT61oUFPqqfOyzs2V1Q+sY/WR6AsCvFZvl9Cq6YMf
         88lj99hVSdMj7Dt1zOj6Hl8R27Wu7AqXx04eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXcMQVRxxLeMuWVGiYndN3AoNdrpmXXu+WgZDK7JSOo=;
        b=giGUv0h6o8xes7xhaN/zipu5zY50GaA64T1pKiVYYmVb0R5JuL4Eorul+P9mLCH4A/
         KJ57bCHCEJlYcfTp+Q81F9SMMbZHRChklPFQ9nMbI2VJTVEI77/mR/xAJDKBF8lskAUQ
         4CMEa/ixkpqxXedQVGgn/SlOybZzjN1NyVmDD3n+SQnn3YTVQ+dAp/FNpcQ21vLhP9+e
         yuFoR+bwP6+lq8vXmX5FD/h0Lb+pwzwjV5jbipCGFSn0DfGnntejUYfmplNAAT2nnSkZ
         xjUwzfiIQq/pDuNk9raShbSsXX6T2MX96DX+DysynGkQzUJipLNkUUcIquTwGppX1B3n
         511w==
X-Gm-Message-State: AOAM532qlDQCTUv2wuEK+6UcCJlbcunQvDsDfQr42POnZCIN9nqmo1xe
        hP1MMmw647vyBC/I7AogpJ6RRP6AUhhnxveb
X-Google-Smtp-Source: ABdhPJxYoGz972H4/E/fWv7EYe0b/AFc5omBlj0SCBomWDFUWqS95xEe8qSHfaE7Lq9Z5SR/vlUZRg==
X-Received: by 2002:a05:6e02:673:: with SMTP id l19mr30436405ilt.102.1608052041090;
        Tue, 15 Dec 2020 09:07:21 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id y5sm13673322ilh.24.2020.12.15.09.07.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 09:07:19 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id k8so19901001ilr.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:07:19 -0800 (PST)
X-Received: by 2002:a92:c112:: with SMTP id p18mr43613680ile.89.1608052038827;
 Tue, 15 Dec 2020 09:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20201211170629.871085-1-ribalda@chromium.org> <6b933ad0-2b54-33de-4d74-c176efd4d110@linux.intel.com>
In-Reply-To: <6b933ad0-2b54-33de-4d74-c176efd4d110@linux.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 15 Dec 2020 18:07:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCsEXhwQhbpOup3DdM1v6GcvrreOopp+pzcZHsdkNAZPWQ@mail.gmail.com>
Message-ID: <CANiDSCsEXhwQhbpOup3DdM1v6GcvrreOopp+pzcZHsdkNAZPWQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
To:     "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz

On Mon, Dec 14, 2020 at 6:07 PM Gorski, Mateusz
<mateusz.gorski@linux.intel.com> wrote:
>
>
> > If dobj->control is not initialized we end up in an OOPs during
> > skl_tplg_complete:
> >
> > [   26.553358] BUG: kernel NULL pointer dereference, address:
> > 0000000000000078
> > [   26.561151] #PF: supervisor read access in kernel mode
> > [   26.566897] #PF: error_code(0x0000) - not-present page
> > [   26.572642] PGD 0 P4D 0
> > [   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
> > 5.4.81 #4
> > [   26.588232] Hardware name: HP Soraka/Soraka, BIOS
> > Google_Soraka.10431.106.0 12/03/2019
> > [   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]
> >
> > Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHL")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >   sound/soc/intel/skylake/skl-topology.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> > index 40bee10b0c65..0955cbb4e918 100644
> > --- a/sound/soc/intel/skylake/skl-topology.c
> > +++ b/sound/soc/intel/skylake/skl-topology.c
> > @@ -3619,19 +3619,20 @@ static void skl_tplg_complete(struct snd_soc_component *component)
> >
> >       list_for_each_entry(dobj, &component->dobj_list, list) {
> >               struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
> > -             struct soc_enum *se =
> > -                     (struct soc_enum *)kcontrol->private_value;
> > -             char **texts = dobj->control.dtexts;
> > +             struct soc_enum *se;
> > +             char **texts;
> >               char chan_text[4];
> >
> > -             if (dobj->type != SND_SOC_DOBJ_ENUM ||
> > -                 dobj->control.kcontrol->put !=
> > -                 skl_tplg_multi_config_set_dmic)
> > +             if (dobj->type != SND_SOC_DOBJ_ENUM || !kcontrol ||
> > +                 kcontrol->put != skl_tplg_multi_config_set_dmic)
> >                       continue;
> > +
> > +             se = (struct soc_enum *)kcontrol->private_value;
> > +             texts = dobj->control.dtexts;
> >               sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
> >
> >               for (i = 0; i < se->items; i++) {
> > -                     struct snd_ctl_elem_value val;
> > +                     struct snd_ctl_elem_value val = {};
> >
> >                       if (strstr(texts[i], chan_text)) {
> >                               val.value.enumerated.item[0] = i;
>
>
> Hi Ricardo,
>
> there is another thread regarding this issue (with fix provided by
> Lukasz Majczak), you can find it here:
>
>      https://www.spinics.net/lists/stable/msg431524.html

I saw it just after I sent it :(. The most embarrassing thing is that
we are working in the same project ;)

Sorry for the noise

>
>
> Thanks,
> Mateusz
>


-- 
Ricardo Ribalda
