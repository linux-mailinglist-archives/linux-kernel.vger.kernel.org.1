Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F252F6D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbhANVUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbhANVUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:20:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9787023A9D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610659163;
        bh=5+1WXwCIi3E1ZhON2TFeIjHtRiwChsqgI+Rn2pS5P34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Epe3jAe/11FjBY0LHMOLO5rGCJJ2t6ELBW9fcE87+iz/SNp4zjrkCOIxJSYWtmNJB
         vHMipw2RCiZQrTdpP6sDReH7GoXcITiIqw2QCMa7yZMxFCEnPF+e4gdveEr5grWBfV
         KjfrOXqPvf8muH2zlFakJeSzDA/9wwhDOt5XNz6xGk1mM5Akxh3OebKTRskLIdz/Za
         xxJFJRzDgFgtpyM6skuxVtkgJuVmOkINVIlTxYGrItNdBwAGG7SxqVAZj9/Nfn1qMQ
         bdCJdkudIyK6pe39vyh43/tcwxwUjRV6WUMlNgij3kpg7oqGmEq5L+veRyRRnTjQwz
         3d72SGFBpvADA==
Received: by mail-oi1-f182.google.com with SMTP id p5so7431338oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:19:23 -0800 (PST)
X-Gm-Message-State: AOAM530T7pTKeGISpYF9P4McCliHX7LLeRHhEyr50DgnIRQh3OK/ypZJ
        8ObsjwnFLtLP1FfyrGEqqGgf9KllfpLc93R3nZM=
X-Google-Smtp-Source: ABdhPJxqnU7LWjnaGrNzlDTdj1wsHJs8b8gqDDmTpuHoHGEbXBS0P6btj/BhJ+hiWFjedt2LIni9g3mqXt8FQ17nwRY=
X-Received: by 2002:aca:e103:: with SMTP id y3mr3596800oig.11.1610659162777;
 Thu, 14 Jan 2021 13:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20210112203250.2576775-1-arnd@kernel.org> <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
 <4ad60e25-b1d5-9be1-a2bc-8bec9e4e85c1@linux.intel.com>
In-Reply-To: <4ad60e25-b1d5-9be1-a2bc-8bec9e4e85c1@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 14 Jan 2021 22:19:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0o3LVuVgLWYFHgdzWfi0MSa8MgggsP5RxApZgvxiJbwQ@mail.gmail.com>
Message-ID: <CAK8P3a0o3LVuVgLWYFHgdzWfi0MSa8MgggsP5RxApZgvxiJbwQ@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH 1/2] [v2] ALSA: hda: fix
 SND_INTEL_DSP_CONFIG dependency
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rander Wang <rander.wang@linux.intel.com>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 7:07 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 1/14/21 9:09 AM, Arnd Bergmann wrote:
> > On Tue, Jan 12, 2021 at 9:32 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> ---
> >> v2: fix various build issues in the first version, now passes
> >>      all randconfig builds I tried
> >
> > Please disregard this version, while I have a tree that passes
> > the randconfig builds now, this was not the patch from it that
> > I wanted to send...
>
> No worries, I reworked the PCI case completely. Still running tests to
> make sure there's no regression
> https://github.com/thesofproject/linux/pull/2683

Ok, I see. I had not realized that you already did the PCI bits as well,
and applied my original patch to your tree, as I had meant to
resend my "ASoC: SOF: ACPI: avoid reverse module dependency"
patch after fixing some additional build failures in it. I have
now applied the relevant commits from your branch to my
randconfig tree, and will let you know if that finds anything more.

From what I can tell so far, you already included the fixups that I had
locally, and more.

       Arnd
