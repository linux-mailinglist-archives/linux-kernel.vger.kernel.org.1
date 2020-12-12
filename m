Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049982D8997
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 20:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501884AbgLLTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 14:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439851AbgLLTIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 14:08:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D21C0613CF;
        Sat, 12 Dec 2020 11:08:13 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 11so9328897pfu.4;
        Sat, 12 Dec 2020 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5d5sPO8wx8zg1h0wCHE+9bPaBcmdRWM6UrfrsupVMMc=;
        b=I4OSGFP7adVI2ndfGQCPd0SwsK0rx+RD89j2Ej0NhjJdJZxcAtOfopLm9JNrPX+Dkn
         ULhDz9H0HMmyR9xWD9vYPYzjXnipk/Cls0Z4BVJqYrdD9wj/4UN5+I0h/wc07o1GfloE
         VQfdIZYS60dMNRNWobU9VT1kbU8EgufZsOGmzaUCguaP2UlLQLp7U13i6o2sLABR3iMr
         CpmQHjBPytw4zv54by5HyL3KkhBCwXTcWUbCkAZrZSdNsoAKwuS9x0nIh5n8W69SFU+w
         8rLdxSYwZe3GiGLgoFQZDgdInSANtr8BeQ8OILsT91okbprBNJIPFQVGHFKPitaKnXHc
         QRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5d5sPO8wx8zg1h0wCHE+9bPaBcmdRWM6UrfrsupVMMc=;
        b=oCkURlSdQk0+6PrO8Up/3D37KlocvwPqJgFowqPAKYF2+g3zWoWR21Jq/FudAv1vQD
         fmDiXPIBDK7P33YVmuXGLafyvxY5zotj5ZvnKqxKsE2wrec4CBECI6iYAFnaHvNvtSXX
         nPX57LrCDfVq3GSi35415NYaBTNUtU9bQ3sd2y60f4lb5QHoeQYfSDD1BuiXAibYgi9s
         jAz8kCM6U85sC0pfj9z/lTIaBL0wLsOGej/ftRuuXRv4RlOskzwpLJ8/4lpzEv/2fPfj
         IoeEIeH98KeJFI7P0Lr7xe2Edr8mDDkv86/Bsv+ZtA1H2oqIhhQvBIarvHrbAqt6WKV8
         Qxsw==
X-Gm-Message-State: AOAM531+6h6yl0pH+UK/RSYWsOAvvQ/nhz1z4bjnpBwFvnKwytt14zpe
        w1ofUkaL12iVJka1z/1diwDj90DJm+KbaePHs7Dp7QeOvmlFfw==
X-Google-Smtp-Source: ABdhPJwIo8+CSrfwuqpfmjq9ZWxFW0pVBxXGpMsZYdRxEl6zmWBOcTi2FNyscHh9XJZPIEcWp3lP/mMKjZvjTlDD6nY=
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id
 195-20020a6219cc0000b029019e321ba22emr9954366pfz.73.1607800092741; Sat, 12
 Dec 2020 11:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20201211190335.16501-1-rdunlap@infradead.org> <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
 <ec8e703f-e1ea-1253-edc9-311f0ee3e8fd@infradead.org>
In-Reply-To: <ec8e703f-e1ea-1253-edc9-311f0ee3e8fd@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Dec 2020 21:07:56 +0200
Message-ID: <CAHp75Vf-QcdL+FOd=8fUUQ0+ORC-RVKG+3Yqrar1J7wZMSDF+A@mail.gmail.com>
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 7:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 12/12/20 5:24 AM, Andy Shevchenko wrote:
> > On Fri, Dec 11, 2020 at 9:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:

...

> >> +#ifdef CONFIG_PM_SLEEP
> >>  static int surface_gpe_suspend(struct device *dev)
> >
> > Perhaps __maybe_unused ?
>
> Yes, I am aware of that option.
> I don't know why it would be preferred though.

Here [1] is the rationale behind annotation vs. ifdeffery.

[1]: https://lore.kernel.org/patchwork/patch/732981/

-- 
With Best Regards,
Andy Shevchenko
