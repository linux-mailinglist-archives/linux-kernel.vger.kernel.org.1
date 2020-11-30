Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3F2C8C74
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgK3SQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbgK3SQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:16:30 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DAFC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:15:49 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id r18so19400395ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H93VChb+sVDTZJCSL0yt9I/1R/7Lu+WEYlaSl0sXgTA=;
        b=eXzgCuN7073pTNG0csTzX/DdnH7UPcUOnbwk6PaAVilE/XN5tq15kUHWr+pOO1gOnH
         qp97XkMGlfswR8jtOJQIcLCC6iRSBQXSw5z6gNL1p6WjoFI3JhOhaDsAZiZxOTT5ZNif
         /dANSWfNakGAJAYTp9w8DgQ/8/5XMhUFXSJtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H93VChb+sVDTZJCSL0yt9I/1R/7Lu+WEYlaSl0sXgTA=;
        b=N343p0Rx/HMylK7G7WcnrwpV2jk8BcGfRzvlLtqRIrHSMZ1bbnQHfjUmXyVRGpWmk3
         MYLY7DqD1C6vV19LFbejHNKgIiNzQW39w9B1JaKZAaLhQ3Y1o+D3zAnhJfdg3b9y0aZy
         bh3IC6oCX1l0VRKN3FHuGbSFuVkVylPbkGu85sAKzKVNzCe18l2NqmkrpeJkmZiSPzea
         NlrsUcksK7/f1qYTZ16jDIMvsKGmz7I3/v1PXB4YRofMFI9ufyghzHzYf+2lPO141qyX
         Kay820LEzSWmpjcAjG5ltXwCNPXXv3qK9lqVpFOmeuAkP7C7xlF3vswnZ8vSzdw7lIeL
         MqIA==
X-Gm-Message-State: AOAM5336R0EMt2+FqCOIGWwc38fXHGxT1Qj8IuHbXLyNNSA4UiWf5Wze
        cI2M8xGeao0C1RXOVaycY0Y5wS/ujrZwuA==
X-Google-Smtp-Source: ABdhPJytb1hu/4ssCbmI9v8aImoZEIrqkdOyMz5l82UNnnDkZYzbxO0B0FX2loCpPMvIvdJdze9hrg==
X-Received: by 2002:a2e:85cf:: with SMTP id h15mr11097819ljj.436.1606760147977;
        Mon, 30 Nov 2020 10:15:47 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u17sm2542730lfq.144.2020.11.30.10.15.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:15:46 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id s30so23428198lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:15:46 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr9347723lfy.352.1606760145852;
 Mon, 30 Nov 2020 10:15:45 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com> <20201130180523.GZ1551@shell.armlinux.org.uk>
In-Reply-To: <20201130180523.GZ1551@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Nov 2020 10:15:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZhkMu5UFgmD2Yt96S_nrhMzTTXfqOwgBe4nsg0R_M6Q@mail.gmail.com>
Message-ID: <CAHk-=wgZhkMu5UFgmD2Yt96S_nrhMzTTXfqOwgBe4nsg0R_M6Q@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Doug Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:05 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> If you think that /dev/sda for example is always the machine's internal
> HDD, that is wrong.

Yes. See the whole part about

 "Note that it really is only the internal devices that matter. Once you
  start plugging in an external USB hug and random devices, ordering
  clearly won't be reliable.

  So this is not a "everything must be ordered". But people who think
  that that then means "everythinbg can be random" are wrong"

in my email.

And the key word here is:

> I have a HP Pavilion laptop with its internal HDD with a Windows
> installation. Because I didn't want to destroy that in any way, I
> bought an external USB3 SATA enclosure and SSD, and installed Debian
> Stable on there.

.. but it will still generally be stable with the same hardware
configuration, and not fluctuate randomly from boot to boot when the
hardware is the same.

Is it a guarantee? No. External plugged in hardware can change things.
In fact, when you have things like Thunderbolt involved, since it just
looks like PCI, even the PCI probing order won't be the same with or
without the plugged-in device.

But again: avoid randomness. The difference between non-random and
random is that one is predictable and one is not.

Predictability is good. It's not necessariyl always achievable, but
it's very much something we should strive for VERY HARD.

Predictability and reproducibility help debugging enormously. It means
that things like "git bisect" work a lot better. It makes user reports
much more understandable when two users with identical hardware see
identical issues.

Seriously. Anybody who argues against reproducibility is so far out to
lunch that it's not even funny.

You seem to argue on a complete technicality.

            Linus
