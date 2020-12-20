Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39272DF49C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 10:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLTJ0n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Dec 2020 04:26:43 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41299 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgLTJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 04:26:42 -0500
Received: by mail-wr1-f51.google.com with SMTP id a12so7621545wrv.8;
        Sun, 20 Dec 2020 01:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PrcFQyXgDxVl5IPzK8WqBb5XMYDudyd6Wbz/pNJDrYU=;
        b=Vxkd1Jk9CXI2VMksX7sdRUD46RMmcoBMCPpHRhMqiydjXN4DBaimhPoYy83Ke6o4yE
         LYLHSJmPic78yQjQ1pQw7CbxAy+uxYsNUF0C+zPrxZWofMg/REjRIq8PHy9xMySKwW9p
         QuKznT6hjSWauUPB3zRf58aYiOsD+Qez+okfNim00h9RUH4zQ7Eby/YGQwrR78kCyuGH
         L8R1w1m4P+pXd41FRul6w7RrI5CwAVCX5URVlpuMyjfS6paq5EXyswmqRB5xb/4lkr7B
         ZMI2XVnjZvIR8Hj0U2IqezLWKHzRYvYcK1b4VX9RGUtsD7cOsDkHfDhh+llKSUTffSaT
         e9uw==
X-Gm-Message-State: AOAM531fjMIik0Bq5q1V2K1eAmg7NXhRPIgX1c8yIQPzC9f+3NzDtoIt
        IaMCCO6C17FF9Qo07ZTF4fVam/UL/wzCw3F/Rls=
X-Google-Smtp-Source: ABdhPJzH7xqo/OCXD9vfd+WzUHPEyail85ouugds8QQI9RMWGZ6Lxwx+ZWoEmx5jOebidAzD0+xcPBiPHkvRq53VhGU=
X-Received: by 2002:adf:eb07:: with SMTP id s7mr12692947wrn.414.1608456361226;
 Sun, 20 Dec 2020 01:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201219214054.GB3132151@ravnborg.org>
 <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com> <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com>
In-Reply-To: <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com>
From:   Romain Dolbeau <romain@dolbeau.org>
Date:   Sun, 20 Dec 2020 10:25:49 +0100
Message-ID: <CADuzgbqZQ5oMxUh5XhmzqGpVgU+m6L-42TucOhACDviKYpaCMg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
To:     Julian Calaby <julian.calaby@gmail.com>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim. 20 déc. 2020 à 09:54, Julian Calaby <julian.calaby@gmail.com> a écrit :
> If I want to run them, assuming the hardware still works, I need to
> netboot them as I cannot find working, compatible HDDs for them as
> everything has switched to SATA or SAS.

SCSI2SD (<http://www.codesrc.com/mediawiki/index.php/SCSI2SD>)
are a bit expensive, but solve that problem (I own both a V5 and a V6,
both work well in my SPARCstations, tried sun4c and sun4m).
As it takes micro-sd cards, it's quite easy to keep multiple OSes
on hand.

> Then there's the issue of finding a monitor as they're not
> electrically compatible with VGA

Huh? There is Sun's 13W3-to-vga adapters and cables, and many
monitors will sync to Sun's frequency (though not the most recent
LCDs whose analog circuitry is pathetic compared to old-school
CRTs). Some framebuffers will output 1280x1024 (rarer than for
1152x900), and some can be coerced to do almost anything with
some Forth knowledge (see e.g.
<https://github.com/rdolbeau/SunTurboGX>, again blowing my
own horn here sorry...).

> (...) booting one up for fun is simply impractical

An SCSI2SD and either a null-modem serial cable or a
Sun keyboard/13w3 cable/17"LCD combo and you're good to
go. You might need another unix-like box to netboot the system.

> I believe that Gentoo is architecture-neutral enough that it'd work,
> but I believe that you'll have to compile everything - there'll be no
> pre-built anything for sparc32

Trying gentoo is on my todo list... has been for a long time :-(

> and as it's fairly slow hardware by
> today's standards, that's going to take a long time, however you could
> probably use distcc and cross-compilers to speed it up.

Isn't that what Qemu is for ? :-) I've managed to recompile LLVM
and clang in NetBSD 9 for my SS20, one by cross-compiling
(LLVM requires too much memory), the other in QEmu.
Unfortunately, Qemu doesn't yet support mt-tcg (multithreaded
emulation) for sparc so single-core only - still faster than the HW,
mostly because of incomparably faster I/O.

> If there were more people using it or more testing, or more distros
> supporting it - not just (theoretically?) working on it - then I'd be
> fighting to keep it.

I wish I had some arguments for that point... I will just re-mention Qemu,
as it makes testing quite easy and reasonably not-too-slow.

Cordially,

-- 
Romain Dolbeau
