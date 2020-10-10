Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AF5289C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgJJAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728637AbgJJAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602288301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAHdT0YUcS3hlFVvV/a7Yb9xHClGFU2uZDMKfAvGGD8=;
        b=UEooeqJjQfwJs/4+fxivsOF1c32ROzLx1ojwdyS2Tm6ajyzZBgO+EhIqsStoU+u1RVbglD
        KEuGqgiH+uukNdYF07oeZfroWvrG8UCYWrXZf8Pwvfyljq02cq76CcwlVLO87XNbSb6XoL
        I5/CwBOnnuGteGkRvU+fhC8lUelAdLc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-krWQzIX9O1qhS11vdNntRw-1; Fri, 09 Oct 2020 20:02:53 -0400
X-MC-Unique: krWQzIX9O1qhS11vdNntRw-1
Received: by mail-qv1-f69.google.com with SMTP id c3so7066692qvj.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAHdT0YUcS3hlFVvV/a7Yb9xHClGFU2uZDMKfAvGGD8=;
        b=DEDTYdI4+AN+z3KzwH0ZCX08yctKO1IFzMqXRlAyK+XBb8Q78QwSqHUlo19hcdGpx3
         w3TkV7ydstxNoKYmogkivgYMLjOD/CL/1Lg0qG3dd/iiKTSK6LUcr2riWRAjrNLaHGVN
         gAVI/JQjuSDdV5y82OY1OF1aUMlUFINVLCfkh1VcKOGQwLjY6wFLiOj0wTD7N5PuE4FJ
         wJLYDbLngWcgt1x6uHGKBl8VsTKtcRhPblwuwX/lZYZu9WlUQc2/hgA9BmnSd8NHofb2
         TJBlf2hUzp8tKQ26ZLh6M1n3HqHQcGIsQt50b4TJOZQGpvmBWmUwpSt7bc+Dk084bEie
         IQBA==
X-Gm-Message-State: AOAM532H8VGQoRVmr5QFVYMQJdW2/CngmX7pzlzcfNOiQIT8CxBu83/j
        GsrNZ0KpS+AoZGU1S+8tjC99qv+cbo53QMuRF2Me5lV9C/UXpK4jrglbOOqDrEzY1ReoaYcJ9Fe
        QWb4pv41LB68FDp95bRd8k22xXiGq+9tfufL3SEOd
X-Received: by 2002:ac8:544f:: with SMTP id d15mr550613qtq.378.1602288173370;
        Fri, 09 Oct 2020 17:02:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTAsjduoXcqRRrUIMh+vSvUOH3iyoH4osH0nD+5G7WvhBO6AKdfe+6mxpDH02m/3KuNfgu9lpqZxcgAWuY2Ao=
X-Received: by 2002:ac8:544f:: with SMTP id d15mr550593qtq.378.1602288173091;
 Fri, 09 Oct 2020 17:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <202010092326.20482.linux@zary.sk> <CACO55tuj_=PUYuBnJLZgCEize_8Po0VnuDVPtkHLEZxL3RgF7Q@mail.gmail.com>
 <CAKb7UvggVn2c=jUNSfjf6r529n89xfNgVBpn3jnXznVh8Gs4+w@mail.gmail.com>
In-Reply-To: <CAKb7UvggVn2c=jUNSfjf6r529n89xfNgVBpn3jnXznVh8Gs4+w@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 10 Oct 2020 02:02:42 +0200
Message-ID: <CACO55tuAxbcXbC9zrT5rs34s=5uBugkbcikORU5868ka9bHdkw@mail.gmail.com>
Subject: Re: [Nouveau] nouveau broken on Riva TNT2 in 5.9.0-rc8: GPU not
 supported on big-endian
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ondrej Zary <linux@zary.sk>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:23 AM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Fri, Oct 9, 2020 at 5:54 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Fri, Oct 9, 2020 at 11:35 PM Ondrej Zary <linux@zary.sk> wrote:
> > >
> > > Hello,
> > > I'm testing 5.9.0-rc8 and found that Riva TNT2 stopped working:
> > > [    0.000000] Linux version 5.9.0-rc8+ (zary@gsql) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #326 SMP Fri Oct 9 22:31:40 CEST 2020
> > > ...
> > > [   14.771464] nouveau 0000:01:00.0: GPU not supported on big-endian
> > > [   14.771782] nouveau: probe of 0000:01:00.0 failed with error -38
> > >
> > > big-endian? WTF? The machine is x86.
> > >
> >
> > mhh, we reworked the endianess checks a bit and apparently that broke
> > something... I will give it some thoughts, but could you be so kind
> > and create an mmiotrace under 5.9 with nouveau? You won't need to
> > start X or anything while doing it. Just enable the trace and modprobe
> > nouveau and collect the trace.
>
> Looks like nvkm_device_endianness unconditionally reads out 0x4. I
> don't think that reg is there pre-NV11. At least NV4, NV5, NV10 and
> maybe NV15 (which is logically pre-NV11) don't support big-endian
> mode. Not sure about NV1A, which was the IGP of the series and IIRC
> logically pre-NV11 as well (but clearly could only be used with x86
> chips, since it was part of the motherboard).
>
> Aha, it's documented in rnndb:
>
> https://github.com/envytools/envytools/blob/master/rnndb/bus/pmc.xml
> <reg32 offset="0x004" name="ENDIAN" variants="NV1A-"/>
>

ohh, I should have checked there.. yeah, will write a fix for it then.
Before my patch we just always tried to switch it, but never threw an
error.

>   -ilia
>

