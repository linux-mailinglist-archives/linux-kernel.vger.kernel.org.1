Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C792ECDE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:33:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37135 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:33:06 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxSac-0001fq-Pv
        for linux-kernel@vger.kernel.org; Thu, 07 Jan 2021 10:32:22 +0000
Received: by mail-lf1-f71.google.com with SMTP id w11so5905737lff.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/Y5buNtMZu8paZ5pdJK7XpNPN8q/w0jqWstP/iLbT4=;
        b=m4s/j11tjOgTsfLN/79pIhhJQV50z+BQj0yMTOMGIRh5hKG+XPZF1fmtPm5hLcg6CO
         5fyyQNosnifKMQ6PWGyM1v75/U/WJM3a33IQvgeAiPaZQhV7z++fRxwXEwFuNElOHUPQ
         TRRrFwMPEcITl4nSL1PDEsGwtnTB6jd93CY6BLHlYH729YMrAP5tyBHxAyc8Mo9yEQv7
         Ju0VCUG2QlfpHu9uAR2YoYXofMhZyGBU6Iu+OFMlYRnx0J4/pdGwPl3hrmmqXY42rJis
         SN0pRQ/B6AsCNBUGGLfYl96rIAMhpEOHyjNBnWS6mUwjrGTn7eXsDfitVDGytF+w2JmY
         4ACQ==
X-Gm-Message-State: AOAM531NK+3zDE8hFwwkpYl1554ct4p7qvi/RHYi2zWJ2PxasjSvKV/v
        qd519xRZFfE8qAVqHJ9/9ryKHtQ3H5bPsFyxxroLrdRdEZQBpbHqW1FBtnKcyfjUMwsZN39wFIS
        JEDsyn4lYWH5sW2JDqC0llu/VYo130Kkl4T/DM0In3Ggs19ZTRVaMKoQG4Q==
X-Received: by 2002:a19:dc5:: with SMTP id 188mr3947106lfn.513.1610015542116;
        Thu, 07 Jan 2021 02:32:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvjI7EOWLxlJykcG6C96lN66Kbefk0r7+QFwEUXJQvjuBr5gTp9PCQ7STZfkhNmOn0+mGm3OC0x4+P2PVAzZA=
X-Received: by 2002:a19:dc5:: with SMTP id 188mr3947096lfn.513.1610015541825;
 Thu, 07 Jan 2021 02:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
 <20210104140853.228448-3-kai.heng.feng@canonical.com> <alpine.DEB.2.22.394.2101051354300.864696@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2101051354300.864696@eliteleevi.tm.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 7 Jan 2021 18:32:09 +0800
Message-ID: <CAAd53p7JvPAYt3NGQU-cCEDtLaL8L+vBoSyYbYSD-bkKS-g50g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
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

On Tue, Jan 5, 2021 at 8:28 PM Kai Vehmanen
<kai.vehmanen@linux.intel.com> wrote:
>
> Hey,
>
> On Mon, 4 Jan 2021, Kai-Heng Feng wrote:
>
> > System takes a very long time to suspend after commit 215a22ed31a1
> > ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
> > [   90.065964] PM: suspend entry (s2idle)
>
> the patch itself looks good, but can you explain a bit more in what
> conditions you hit the delay?

If both controller and codec are suspended, I can 100% reproduce the issue.

>
> I tried to reproduce the delay on multiple systems (with tip of
> tiwai/master), but with no luck. I can see hda_jackpoll_work() called, but
> at this point runtime pm has been disabled already (via
> __device_suspend()) and snd_hdac_is_power_on() will return true even when
> pm_runtime_suspended() is true as well (which is expected as runtime-pm is
> disabled at this point for system suspend). End result is codec is not
> powered up in hda_jackpoll_work() and suspend is not delayed.

On my system snd_hdac_is_power_on() calls hda_set_power_state() which
takes long time to write to (suspended) codec.
I am not sure why it doesn't power up codec on your system.

>
> The patch still seems correct. You would hit the problem you describe if
> jackpoll_interval was set to a non-zero value (not the case on most
> systems supported by SOF, but still a possibility). I'm still curious how
> you hit the problem. At minimum, we are missing a scenario in our testing.

The issue happens with zero jackpoll_interval.

Kai-Heng

>
> Br, Kai
