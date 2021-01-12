Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1162F3D04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437592AbhALVeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436954AbhALUch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:32:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E53EB23120
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610483517;
        bh=GY2dA0tnQaLR9kEC3NT4xt1yRQpDneTbZbrAIKrMDus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NECVjxVoRln3d4p1r5Ulst7EhYowHP8qioQf/sAQDaOxnilA1DmINtX3aRy0F6gG1
         Irc41z9hx6ObGoAEx03mWjl7VrIDzHgMJ6dgZsRQLqPbutbM9LH1er+Wmb4YQ+Jaqy
         yasUDIprrPZebVSs8YRhihGkJCasksBWNrqM0HR0lk353Ux40ffjjqYJHaEEuPgVrQ
         kXYFG6rxaEKJsf7DusfkIZ3wuK9fFo20Jo/QqcUuAWVj99SxoJpLLlv1EwiUQpabni
         yXxwmaVTPFGobikiujLpi7njtrQkUEztji41fImb5SAGLnkDpn+uSD0I6rYf/pM7yY
         vmReBAbI6nmOQ==
Received: by mail-oi1-f172.google.com with SMTP id s2so3760838oij.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:31:56 -0800 (PST)
X-Gm-Message-State: AOAM531LVXE/TgZV3Y/9Xx1c2ZE6ddYiTVGhhwtv5hl29kjVztBkkqC8
        GSLaH3B5ycEMenaZBVFeHD0GrzUC6u37XXTfnJ4=
X-Google-Smtp-Source: ABdhPJzUs07y/E2oEl4yvSU0ct0rH7Wcp5EwXovXPevceHZU7X0QfVzhdASEM7Yl9Iad9GELmZOfgrhXc42/sMTWcZU=
X-Received: by 2002:aca:44d:: with SMTP id 74mr629231oie.4.1610483516212; Tue,
 12 Jan 2021 12:31:56 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com>
 <20210105190808.613050-1-arnd@kernel.org> <59a36212-2412-2dd3-62f2-69c6f65312b1@linux.intel.com>
 <s5hv9c2qmy4.wl-tiwai@suse.de> <ed4b4b5b-0cde-3d08-bbbf-3f0d90ce46ea@linux.intel.com>
In-Reply-To: <ed4b4b5b-0cde-3d08-bbbf-3f0d90ce46ea@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 12 Jan 2021 21:31:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3eOt_5cYsJQuTtFJqLpX0ZS_GGk=x-pJk4Lg=mdVX-_g@mail.gmail.com>
Message-ID: <CAK8P3a3eOt_5cYsJQuTtFJqLpX0ZS_GGk=x-pJk4Lg=mdVX-_g@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH] ASoC: SOF: Intel: avoid reverse
 module dependency
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:17 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> Since this is going to be a really invasive change, and past
> >> experience shows that mucking with Kconfigs will invariably raise a
> >> number of broken corner cases, if there is support from
> >> Mark/Takashi/Jaroslav on this idea, we should first test it in the SOF
> >> tree so that we get a good test coverage and don't break too many eggs
> >> in Mark's tree. We would also need to concurrently change our CI
> >> scripts which are dependent on module names.
> >
> > I'm in favor of the way Arnd proposed.  It's more straightforward and
> > less code.
>
> Thanks Takashi for the feedback.
>
> Since yesterday I looked at another problem where we can have unmet
> dependencies between SoundWire (m) and SOF (y), so we probably need to
> rethink all this. We had similar issue with SOF and HDaudio before, it's
> time to revisit all this.

I think I ran into the same thing yesterday, and came up with a patch for
that one as well. I think it should be independent of the other one but I did
not try it by itself.

I'll send it along with a fixed version of the one in this thread, together the
have now survived a few hundred randconfig builds.

       Arnd
