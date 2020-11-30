Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29672C8AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgK3R2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgK3R2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:28:22 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17864C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:27:42 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id v3so12067494ilo.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1Vd/fR6g8wKCZaURanPYDdeMR44y3LFyKTjW1Typqg=;
        b=HPx1RZXZNsy8M//eK/7kOCaSUaWAAX7fONUWyezM24Q2XUD0+BKVnoisJ0C4vGJAHb
         dpSYTjfScL0RG8De+OgMc4aBzQgOeaAScILDnBnSbZ6IYY5M5FdoGUJO9AhN24u8PqJ2
         //nIYs1U1gwGRjsRz8mWlNYQSuv+a0JUT/FUlar/szHwD5pMn525jAyIj0Lh4ISmrrnR
         yV+YjJNmM3Vg+8AiOLhZ3h3eX2eq+JKwdkaeElXR4FgkS57ZidtEVyXXTgRDDGKbX1wk
         +T6CJB8C4eCz6+7TxiF5ht0jijdg+yTIDFYbBsjIrOGSgLf2cGFPDFQHc7JpIp4QUdsQ
         7MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1Vd/fR6g8wKCZaURanPYDdeMR44y3LFyKTjW1Typqg=;
        b=m8vetBomDno+i0Y6oHyyrO5o7xAKIm6lL13qrk5Aw9wl4SrOUyuQjEi0ErKHAIN6Sa
         oklKrtq6fYOP0Ed1WD22Tuycsv8vaTrxyT+oq/IwQXLKSyywreHA0zl0oXCoHqNWFM6s
         bnmsLOptWXraxmsQFt9b9sVcuhi0tFS65d6F8hgMdMjD8vR0oPgRKxHp76Mk1vz0M+ST
         YUjRJKDmkF9vAtZQm3iYXopkPeciHzwyPbkt9PYWBeBZZ7CtuG4199tTCQCzz1tj58Qa
         nvQqKqVQTyBZ6FcX/CD55o0kxeMhX/yUJjWjvyPu8G0WEuehNzIwJ2izwbo5AVVI0zIH
         zMVQ==
X-Gm-Message-State: AOAM532ehTy4CHFwaX86RQ6ucGDP838CeZCdP/K7nkGSOyET/jQDrDT4
        EzuvHiXi6nlvFXZvWsDP6UebuQZVbUhTc4Um3qs=
X-Google-Smtp-Source: ABdhPJzc1TmhusDdrQNhIh4x01OuKc5+8edgdoreT8fMqA8YQZsrXmqQSAslZWMfzsvzZ3iuByUoOGEhdE/6dOkpDm4=
X-Received: by 2002:a92:d203:: with SMTP id y3mr19643539ily.206.1606757261315;
 Mon, 30 Nov 2020 09:27:41 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
In-Reply-To: <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 30 Nov 2020 09:27:30 -0800
Message-ID: <CAKdAkRRq=GK7N1PDJ4zLfJVSsrd1BB=u69aXtJHh=sW4vn5LOg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Nov 27, 2020 at 3:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 27, 2020 at 12:51 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> >  - Some DT patches for the Rockchip RK3399 platform,
> >    in particular fixing the MMC device ordering that
> >    recently became nondeterministic with async probe.
>
> Uhhuh.
>
> I didn't realize this MMC breakage happened.
>
> That's just an MMC bug. Other subsystems have been able to do async
> probing without making device ordering be random.
>
> So this really smells wrong, and I just never realized.
>
> Added Douglas Anderson to the cc - the whole PROBE_PREFER_ASYNCHRONOUS
> behavior appears broken.
>
> You basically should do the device numbering synchronously (or better
> yet - asynchronously, but single-threaded for the subsystem), and then
> asynchronously probe the actual device details after you've numbered
> them reliably.

Generally speaking it is either unnecessary for a lot of devices where
we do not care what number they get, harmful (why do I need to probe
i2c touchscreen and touchpad sequentially if I do not care which one
comes first but my boot will take 0.5 seconds longer if I serialize),
or impossible (if device is hit-pluggable). For many years userspace
has been moving away from static device assignments and we should not
be going back.

There are some devices that are special because it is hard to deal
with devices shifting during early boot, and for them maintaining
static ordering might be beneficial for now, but they are exceptions.

>
> This is not something new - we do this for pretty much all the other
> block devices, and MMC is just doing things wrong.
>
> See SCSI probing for the traditional horrible cases (where just
> spinning up a disk could take tens of seconds).  "Slow probing" is not
> an excuse of "random ordering".

And still my external USB disk will get a "random" /dev/sdX depending
on when I plug it in relative to all other USB sticks.

Thanks.

-- 
Dmitry
