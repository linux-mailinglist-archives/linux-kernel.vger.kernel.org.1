Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E042EC944
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 05:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbhAGEBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 23:01:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhAGEBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 23:01:12 -0500
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxMTN-00050Q-AQ
        for linux-kernel@vger.kernel.org; Thu, 07 Jan 2021 04:00:29 +0000
Received: by mail-oo1-f71.google.com with SMTP id p66so3321986ooa.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 20:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oB+VPXmJ5ngbLdpq6YE49ucI1D/rfct5S9a9aSXZ/SU=;
        b=t7NGhyNIDhs5PY6DcqZCRE82q8BcT3D/XFhwNdZTWsQhg5l2DM/HB/zlEmXzjcQ947
         diSHIN91fT9T7/WmqTa8BmwAKFYxZTVExxaUyPukwVAStzncyICa8QRsyTYZGvQYP76V
         lIO6RrCahI2DfkaNPsoY94ospPT+orkEeGebR14Uj3z6ScsvBxNNNjphRxjoC6f45LRo
         x3tgddgLet9/iXBKwvUPEyuOl3qLkybkmkuO/6DC99ZttMQdWVkOtZqvDu29zw+sykDX
         PaIdSPQcoGyjQSvlcxBZu5qYKhmV6ZO6FU+aLcJV19PrVjRm4f4BV/tIekZJXY41QeF0
         nGQQ==
X-Gm-Message-State: AOAM531veZ5sQ+5H7sQLW/l1wYqoSnEImIVvN/WUgYOVY1k2aW52DlqS
        uOS+C/czSNx3e/j+ajkyRcJQKX2/CdKaov5qGdDz6/dy0pc1NixwdQeSS6dGbSyS+CPULHNfkAj
        5tFlQ+nsTU8b6Insxs1euVd4fZwJwev9Y0AzaDis74jdMS0WtBp1PuOMy2g==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr5313059otk.262.1609992028240;
        Wed, 06 Jan 2021 20:00:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA1vf7fyf7N42CsYG20iYZFQxxNLgectNoTSl3eoacAhaho85G7ft/GlA6rdZHyKPtEYClOYBSz+JaDCGZyhU=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr5313050otk.262.1609992027962;
 Wed, 06 Jan 2021 20:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20210104140853.228448-1-kai.heng.feng@canonical.com> <alpine.DEB.2.22.394.2101051425560.864696@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2101051425560.864696@eliteleevi.tm.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 7 Jan 2021 12:00:16 +0800
Message-ID: <CAAd53p7==ttVR+XQchOLDwreK-4qov4FZQ8Q55HVx5egWDd7BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack detection
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 9:00 PM Kai Vehmanen
<kai.vehmanen@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, 4 Jan 2021, Kai-Heng Feng wrote:
>
> > Instead of queueing jackpoll_work, runtime resume the codec to let it
> > use different jack detection methods based on jackpoll_interval.
>
> hmm, but jackpoll_work() does the same thing, right? So end result should
> be the same.

It depends on the jackpoll_interval value. But yes the end result
should be the same.

>
> > This matches SOF driver's behavior with commit a6e7d0a4bdb0 ("ALSA: hda:
> > fix jack detection with Realtek codecs when in D3"). Since SOF only uses
> > Realtek codec, we don't need any additional check for the resume.
>
> This is not quite correct. First, SOF does support any HDA codec, not just
> Realteks (see e.g. https://github.com/thesofproject/linux/issues/1807),
> and second, this doesn't really match the hda_intel.c patch you mention.
> SOF implements a more conservative approach where we basicly assume
> codec->forced_resume=1 to always apply, and do not implement support for
> codec->relaxed_resume. So the above patch doesn't fully apply to SOF as
> the design is not same.

OK, I assumed SOF always use Realtek codec, so codec->forced_resume=1
is always applied like the other patch.
I'll remove this section.

>
> > diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> > index 6875fa570c2c..df59c79cfdfc 100644
> > --- a/sound/soc/sof/intel/hda-codec.c
> > +++ b/sound/soc/sof/intel/hda-codec.c
> > @@ -93,8 +93,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
> >                * has been recorded in STATESTS
> >                */
> >               if (codec->jacktbl.used)
> > -                     schedule_delayed_work(&codec->jackpoll_work,
> > -                                           codec->jackpoll_interval);
> > +                     pm_request_resume(&codec->core.dev);
>
> I think this change is still good. Just drop the but about Realtek
> codecs from commit message and maybe s/matches/aligns/.

OK, will do.

Kai-Heng

>
> Br, Kai
