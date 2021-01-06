Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24E82EBBB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAFJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAFJbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:31:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFD1A23110
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609925460;
        bh=AEpXdsrE5JKREcFpu6FTa0A3+Lm3TC2ygXxgVZvbRiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ssUHgab+xlU/+H4qyvtBbX40m7iPcwVJlGYM4IX0hDLb+yv2DjeS6oUHeLKabpPgP
         Gp8NLTzNj107gdAr/0lKafQZXprsQWTUfEuvA1Eys5ZSEewglZHr/CLBC7RDkT9RS2
         dRDeyhgL1IdNzy42WdhRTK63/UXdK9RsOY6xwOYIQP0p93VyWftk3jyvAbAEOg0nn+
         S4zMwivzpM5BY1sSDCAMPfMhfW1fpqRP6VMTS6MoZGPZtfqpOzGN1vqx//mEA8eeyh
         xV7jCTyC041+3RqiTjY2LFLi7tLr+YW7OxEDoo19BBrYMfVdCx4Zgao+hv9wElayqt
         bdYHiVcEIDfyg==
Received: by mail-oo1-f50.google.com with SMTP id y14so614574oom.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:30:59 -0800 (PST)
X-Gm-Message-State: AOAM5306IeWiDc7qlFbuagTdGegJ7nzy7/YvyXEOx7PztsdRq6Ci4WDg
        HtwEq7RO4bDqCgmZe0WhH5RnV01+8yvD9u+6OFM=
X-Google-Smtp-Source: ABdhPJxM7UasfYeKIHhnv5W454ns/4XqwHwyDFdt8OhYxwQZJfx6fDHCHg5ls3wHfkG+PAaDDTZZ9JPKz0GXfHCQ7OU=
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr2198217ooo.66.1609925459053;
 Wed, 06 Jan 2021 01:30:59 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com>
 <20210105190808.613050-1-arnd@kernel.org>
In-Reply-To: <20210105190808.613050-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Jan 2021 10:30:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1rp3d_H4uFN1hy_nASYTCZouH3x8ZhQ1JVvMYr+LsK_g@mail.gmail.com>
Message-ID: <CAK8P3a1rp3d_H4uFN1hy_nASYTCZouH3x8ZhQ1JVvMYr+LsK_g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: avoid reverse module dependency
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 8:07 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The SOF-ACPI driver is backwards from the normal Linux model, it has a
> generic driver that knows about all the specific drivers, as opposed to
> having hardware specific drivers that link against a common framework.
>
> This requires ugly Kconfig magic and leads to missed dependencies as
> seen in this link error:
>
> arm-linux-gnueabi-ld: sound/soc/sof/sof-pci-dev.o: in function `sof_acpi_probe':
> sof-pci-dev.c:(.text+0x1c): undefined reference to `snd_intel_dsp_driver_probe'
>
> Change it to use the normal probe order of starting with a specific
> device in a driver, turning the sof-acpi-dev.c driver into a library.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

There were a couple of build failures introduced by this version. I have
one that does build now, and can post that if others think this is the
direction they want to go.

      Arnd
