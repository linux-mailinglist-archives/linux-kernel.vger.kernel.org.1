Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D302DF4F1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgLTJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 04:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgLTJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 04:54:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE859C0613CF;
        Sun, 20 Dec 2020 01:53:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so16530074lfg.10;
        Sun, 20 Dec 2020 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YAPbCIAtqizrJjOjmuHJe0YU4+eOKzCw3UhT/xACS9Y=;
        b=uNilJg+VN8l7sryqjTpuWhaIkxynXcIN41x9XJKmGYAGIs5aZWmW/0DBN6jNqqhQY0
         UBXllN5HoBhxs4KJ3Wg6cJJIRE9YYKbj4nfirBBLbasKBgCxnMcz48a/4ou+yH1YFxti
         9Ru+YPYej4SEadN0aXRIEx94AhAll7JQmTU/Tpo02R2l8e8ljSHVDOwclOZ2QJepGbsJ
         JvRMakTbA1G9MzUVQI26yOf5GV+6pgpasquFlLJ+ZKMw5N2e28q+8588Z5s4DCMjjkcB
         C3Zo+rUDuLtBMUrsxGE177n1u8gURcC7RQXV3fEMJjz0p/xuA/ebuL0tSRprvuK4SL9W
         QtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YAPbCIAtqizrJjOjmuHJe0YU4+eOKzCw3UhT/xACS9Y=;
        b=nigUBfcoTmt0fULknfrARwUerNma2cw17MEFC8owD6sr58iuQOkSwl1uTWIWo6Z53K
         lF1FgPWZl/Dg419ycHrDfFZSqcyZCoS7iyMOwc5zMq3CDojMrQFu9vbWWUbxuP0PBy7f
         arTxnRdt+tnUleC+x094djHNhzyMpPp0qzkce/GNFGF9m12D53jy2DbQ6gg75GCVoHsj
         tiM58KAas0mup9ryhxckx/EA3e+rQNUuHqV18qNKHrpBiZHeurSnX/O72+1j7DusWjVu
         1j8/GexrCrhWJh1QhlL3UQS+IeREG9mE2NIso+lbyg5yiqu9XlMgxAOmd1WM4eSVbR5G
         hwWw==
X-Gm-Message-State: AOAM533+as12jalY4lRv9mNKu3JXUEYX7PdpswU8JfH6qBbp35e/bQ/U
        6mqHG65ONXukshlBKIAtixXTJYLWwKhWTmOnpV4=
X-Google-Smtp-Source: ABdhPJyidYH/jZQnw8Yhn8T6FbcUyLfAuAEQdKHRksNb1LZ6nZOU7Bd0rbXg/ehKJFE9d0W5zXdIIX+UmNiH7Kxw8iI=
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr5183276lja.435.1608458022771;
 Sun, 20 Dec 2020 01:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201219214054.GB3132151@ravnborg.org>
 <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
 <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com> <CADuzgbqZQ5oMxUh5XhmzqGpVgU+m6L-42TucOhACDviKYpaCMg@mail.gmail.com>
In-Reply-To: <CADuzgbqZQ5oMxUh5XhmzqGpVgU+m6L-42TucOhACDviKYpaCMg@mail.gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 20 Dec 2020 20:53:30 +1100
Message-ID: <CAGRGNgXoC04Uco3Fd8O8i2Hu-0WM3-W3CiLAZ0e_1j7Z8ZzUGw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
To:     Romain Dolbeau <romain@dolbeau.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        David S Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        gentoo-sparc@lists.gentoo.org, info@temlib.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sun, Dec 20, 2020 at 8:26 PM Romain Dolbeau <romain@dolbeau.org> wrote:
>
> Le dim. 20 d=C3=A9c. 2020 =C3=A0 09:54, Julian Calaby <julian.calaby@gmai=
l.com> a =C3=A9crit :
> > If I want to run them, assuming the hardware still works, I need to
> > netboot them as I cannot find working, compatible HDDs for them as
> > everything has switched to SATA or SAS.
>
> SCSI2SD (<http://www.codesrc.com/mediawiki/index.php/SCSI2SD>)
> are a bit expensive, but solve that problem (I own both a V5 and a V6,
> both work well in my SPARCstations, tried sun4c and sun4m).
> As it takes micro-sd cards, it's quite easy to keep multiple OSes
> on hand.

I'd forgotten about that. Fair point =3D)

> > Then there's the issue of finding a monitor as they're not
> > electrically compatible with VGA
>
> Huh? There is Sun's 13W3-to-vga adapters and cables, and many
> monitors will sync to Sun's frequency (though not the most recent
> LCDs whose analog circuitry is pathetic compared to old-school
> CRTs). Some framebuffers will output 1280x1024 (rarer than for
> 1152x900), and some can be coerced to do almost anything with
> some Forth knowledge (see e.g.
> <https://github.com/rdolbeau/SunTurboGX>, again blowing my
> own horn here sorry...).

Yeah, my issue is that I have no CRTs anymore - all my monitors are
LCDs and none of them sync to the frequencies SUNs use.

So yeah, you can make adapters (i have home-made adapters to convert
both ways) however out of the 4 monitors I own with VGA ports, none of
them sync to Sun frequencies.

> > (...) booting one up for fun is simply impractical
>
> An SCSI2SD and either a null-modem serial cable or a
> Sun keyboard/13w3 cable/17"LCD combo and you're good to
> go. You might need another unix-like box to netboot the system.

That's almost exactly what I was planning to do, but I'd still be
lacking a Linux distro to run.

> > I believe that Gentoo is architecture-neutral enough that it'd work,
> > but I believe that you'll have to compile everything - there'll be no
> > pre-built anything for sparc32
>
> Trying gentoo is on my todo list... has been for a long time :-(

Same.

IIRC there's some ancient versions that have the bits to netboot a
SparcStation so you can then do the necessary stuff to install the
minimal binaries and stuff, at which point you can do the various
configurations, pull in the latest portage tree and emerge world,
however the last time I tried this, the disk I was using - my last one
- failed somewhere in the middle of that process.

> > and as it's fairly slow hardware by
> > today's standards, that's going to take a long time, however you could
> > probably use distcc and cross-compilers to speed it up.
>
> Isn't that what Qemu is for ? :-) I've managed to recompile LLVM
> and clang in NetBSD 9 for my SS20, one by cross-compiling
> (LLVM requires too much memory), the other in QEmu.
> Unfortunately, Qemu doesn't yet support mt-tcg (multithreaded
> emulation) for sparc so single-core only - still faster than the HW,
> mostly because of incomparably faster I/O.

My distcc plan was to have it talk to a cross compiler on my x86
desktop. I never got to the point where it would have actually used
it.

> > If there were more people using it or more testing, or more distros
> > supporting it - not just (theoretically?) working on it - then I'd be
> > fighting to keep it.
>
> I wish I had some arguments for that point... I will just re-mention Qemu=
,
> as it makes testing quite easy and reasonably not-too-slow.

QEMU is somewhat slow and never _exactly_ the same as real hardware,
so I can see why distros might not use it as a build machine or
whatever. And if they do build for QEMU and it doesn't work on real
hardware, then we have a distro that's only for virtual hardware and
that seems pointless.

You're right that with the right bits and pieces resurrecting a
Sparc32 machine is relatively "easy", however there's still no modern
distros supporting this ancient hardware so the upstream kernel has
most likely bitrotted.

I still don't think it's worth saving.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
