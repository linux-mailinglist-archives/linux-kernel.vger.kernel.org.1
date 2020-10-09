Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A037289BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391128AbgJIWXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:23:51 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34860 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgJIWXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:23:50 -0400
Received: by mail-ua1-f67.google.com with SMTP id z19so3589340uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MC2fdfaVlH+mre+0j68WIGjdkJNggJpOVWSfFdZZdnw=;
        b=az91tVZTUBdxnuI9LV+dxxyMWTqdA/bHYPhGfvSsKwDnirOHCpbo4oT7zAEWqCprPG
         P24C7AX6QCDeP+LgDEt/d5nK4W16DTqukAQYYJduzJT9HdwAH0sMWR8jtu3E2Dd4LtWk
         j+f1KZs5XJW1OYXwTBCWiVxS1u0RfpuKqEUiRKW4vQELEwMlE2XctXVtdeDZuh1afM6o
         E3krHczNLaFgOWcJlfoCSY/J4iTgZ9TkoWE7QdJGOoAOgDFultTNgq2dd82vtIfwyJaW
         5Gf1P1qWWlA4zo2OVET3UhegqpbTADu07er8mLxLUnvOTirta7rEcId9BLN3o+wcc5HJ
         ll8w==
X-Gm-Message-State: AOAM530HMo9X7nt96DIDgTZ/MdvCBIXl0d7PpJCpE2bfgQoBocYES6fx
        Nv96OtGRXbEJeCohA518eMtcYbE+rPW6W8iBW8E=
X-Google-Smtp-Source: ABdhPJxRORGEoBoiWaD7aBjfjM/aj4zhCreHXHY13cwCyqx2s3N45kFjyL/xYEYp1WZ89Nylw49RNQox0CWiW8A+VrU=
X-Received: by 2002:ab0:2117:: with SMTP id d23mr8803869ual.15.1602282229545;
 Fri, 09 Oct 2020 15:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <202010092326.20482.linux@zary.sk> <CACO55tuj_=PUYuBnJLZgCEize_8Po0VnuDVPtkHLEZxL3RgF7Q@mail.gmail.com>
In-Reply-To: <CACO55tuj_=PUYuBnJLZgCEize_8Po0VnuDVPtkHLEZxL3RgF7Q@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 9 Oct 2020 18:23:38 -0400
Message-ID: <CAKb7UvggVn2c=jUNSfjf6r529n89xfNgVBpn3jnXznVh8Gs4+w@mail.gmail.com>
Subject: Re: [Nouveau] nouveau broken on Riva TNT2 in 5.9.0-rc8: GPU not
 supported on big-endian
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Ondrej Zary <linux@zary.sk>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 5:54 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Fri, Oct 9, 2020 at 11:35 PM Ondrej Zary <linux@zary.sk> wrote:
> >
> > Hello,
> > I'm testing 5.9.0-rc8 and found that Riva TNT2 stopped working:
> > [    0.000000] Linux version 5.9.0-rc8+ (zary@gsql) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #326 SMP Fri Oct 9 22:31:40 CEST 2020
> > ...
> > [   14.771464] nouveau 0000:01:00.0: GPU not supported on big-endian
> > [   14.771782] nouveau: probe of 0000:01:00.0 failed with error -38
> >
> > big-endian? WTF? The machine is x86.
> >
>
> mhh, we reworked the endianess checks a bit and apparently that broke
> something... I will give it some thoughts, but could you be so kind
> and create an mmiotrace under 5.9 with nouveau? You won't need to
> start X or anything while doing it. Just enable the trace and modprobe
> nouveau and collect the trace.

Looks like nvkm_device_endianness unconditionally reads out 0x4. I
don't think that reg is there pre-NV11. At least NV4, NV5, NV10 and
maybe NV15 (which is logically pre-NV11) don't support big-endian
mode. Not sure about NV1A, which was the IGP of the series and IIRC
logically pre-NV11 as well (but clearly could only be used with x86
chips, since it was part of the motherboard).

Aha, it's documented in rnndb:

https://github.com/envytools/envytools/blob/master/rnndb/bus/pmc.xml
<reg32 offset="0x004" name="ENDIAN" variants="NV1A-"/>

  -ilia
