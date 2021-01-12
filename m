Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE32F24CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405217AbhALAZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404247AbhALAOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:14:54 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A07CC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:14:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id l200so523015oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RK9+ZwGuMfadOja4DSavfCGwo/bU8cgsSne+yBSfP5I=;
        b=PmoCQ3JAQBDfUOPLeqpIBoUCHTaKS6Ax/xOjX1tp+OSU1h8xuoD8lCX5h6cRqJVuQB
         a3JVdDmbEgUkuQXET5DjI4/LSD0gMLwrEr6a8m7AsJM2DzYrDhB7onjt+tUfcMg9kx5w
         EphVF3F3OMjLoK4ymjJh3Z1rNVXwgnZvwiJQ2/bgxqG7b6e0zuOpNNSLNJwvMi/SrTcF
         XcGv+8qcVOZ1jTsQrW/kpoUezZK6k7ovyBQ82XL5X53KWMluXVVPQEuSzLXU43qPxJmI
         EtbyikGvZKqZv49MkCfhyEFOV0OAIwWcn2q1LgvdHlr6lhMg0S+CH0MeTBO9DFqi8GsF
         221A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RK9+ZwGuMfadOja4DSavfCGwo/bU8cgsSne+yBSfP5I=;
        b=WSO/onOqk02sBdKpb3kW0R66SknQWtECIaMXepVnDEFK8NCmtfLw1bAVgGLcPRUiZr
         WDPMwQrCGLByQwIG8Oz486RrGfoqZ+FzhvB/1sI1QQIQN/NBy8Uvizsbge22P9cX7kUl
         Olq6gM8KIpawTh3/Y4msxaJqS+HesQAkT3+jdVg0wIMjQJEf9Tvvp9VN4i9mv3eSCEzT
         typB5dcC+NZANvLT61MAsNyqKZnA0YA3seoDKLckfiH+CAA01JaQP7/oj3Au0PE7WMk0
         O7retNX5DhchbMOGIRuIL9f6sfLEjGSI8B18qUcWHKJWN6Lj1/IjeELGKyE3iXS7ofl+
         yLiA==
X-Gm-Message-State: AOAM5304WdKDp8JE9CIppxFa7ApZkH+G1Y7NNiArHul1LYCgytLTjnBd
        yYMghlYZ/pMktpTpqdl1DZddTsZ+ZCG3SNpq
X-Google-Smtp-Source: ABdhPJw6piuaPwUMUchBCRSbIdi0zKD8EACiWsGF0x0DrZiZAM+GfyutPQZNvR59AScBlTxwEgRYng==
X-Received: by 2002:aca:3145:: with SMTP id x66mr796346oix.29.1610410453359;
        Mon, 11 Jan 2021 16:14:13 -0800 (PST)
Received: from [192.168.86.73] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id e10sm287777otr.73.2021.01.11.16.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 16:14:12 -0800 (PST)
Subject: Re: Old platforms: bring out your dead
To:     chase rayfield <cusbrar1@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org>
 <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
 <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <1f6e936c-4947-4952-fae2-c05d03e0cd2c@landley.net>
Date:   Mon, 11 Jan 2021 18:26:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 8:55 AM, chase rayfield wrote:
> On Mon, Jan 11, 2021 at 3:09 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> 
>>
>> I'm not sure I understand the reasoning for doing this. The SPARC architecture
>> isn't going to see any new hardware developments in the future after Oracle
>> let go of most of the SPARC developers. So it's not that we need to make room
>> for new hardware.
>>
> My take is that there *would* be more interest in Sparc sun4m / Sun4d
> from enthusiasts at the very least if it was possible to actually boot
> the bloat hog that is Linux these days in a fully usable configuration
> that probably means some modifications to SILO and Linux required.

You can trim current linux down a bit, it's just non-obvious how. Unfortunately
there's an "expert" menu and CONFIG_EMBEDDED and if you touch anything there's
suddenly a hundred extra options in your config with no explanation of what they do.

At least 50% of what you want is probably disabling the printk strings that
aren't visible at your default verbosity level, but alas you must open pandora's
box to access those options...

> The problem is as I understand it, SILO only sets up a 16Mb mapping
> (either due to having to assume 4MB minimum dram stick size or due to
> mapping limitations not sure, most of these machines have at least
> 16MB in slot one...these days though that wasn't the case for sun4c),
> loads Linux into it and says good Luck. This isn't enough for a modern
> kernel with any  hardware support built in. So you might for instance
> get a kernel to fit but only if you dropped all of networking support
> etc... I'm guessing the fix for this would be to modify silo to map a
> larger amount in a way that Linux expects so it can remap it as it
> likes, or just have SILO map the full memory as Linux would. Anyway
> that is THE main demotivation for these architectures.... otherwise
> they have plenty of ram and performance to do basic router/server
> tasks sans SSL.

A lot of people with hardware like this haven't stopped using it, they've just
stopped fighting with kernel upgrades. (Common issue in the embedded world. Not
really a fun thing for security, but )

> This has been the status quo for since the last of the 2.6 series of
> kernels which it was still possible to just barely squeeze a usable
> kernel out of... If someone wanted to take a few hours and fix this
> issue, and keep these architectures around I'd be happy to "buy them a
> round of pizza", though I recognize that many people that work on this
> already have nice jobs, and just don't have time.

My https://github.com/landley/toybox/blob/master/scripts/mkroot.sh ~250 line
bash script generates the simplest kernel configs for a bunch of platforms to
boot qemu to a shell prompt, but you then have to open the "expert" menu and
_disable_ stuff in order to get the size down from there.

> Also Sparc would probably be a good project for someone to extend/test

Sparc has a runtime relocation I've never understood but did manage to break
once, resulting in a long thread to fix:

http://lists.landley.net/pipermail/aboriginal-landley.net/2011-December/001964.html

Between that and the weird save half the stack register thing with function
calls on some sort of "wheel"... there's a _reason_ I haven't been able to talk
Rich into adding support for it to musl.

> Andi Keen's Linux LTO patch set so we could reduce the kernel binary
> size that way also even if sun4 architectures are dropped, it would
> still be useful for embedded sparc. Also there is a port of Temlib to
> the Mister hardware now, 3 cores roughly equivalent to a mid 90s
> machine, at least 128MB ram is possible ( more if a way to map the ARM
> system memory also 1GB is available there, it would have higher
> latency though).
> 
> It is perfectly viable to build Sparc v7 or v8 32bit binaries in a
> chroot on a fast machine also, and I would recommend this if you wish
> to retain sanity rather than attempting cross compiler voodoo, unless
> that is your thing.

It is, sadly, my thing. The above 250 line bash script builds:

aarch64  armv7l  i686        mips    powerpc      s390x  x86_64
armv4l   armv7m  m68k        mips64  powerpc64    sh2eb
armv5l   i486    microblaze  mipsel  powerpc64le  sh4

That's toybox booting to a shell prompt and a linux kernel configured for qemu
for each target. Adding new targets looks something like:

elif [ "$TARGET" == m68k ]; then
  QEMU="m68k -M q800" KARCH=m68k KARGS=ttyS0 VMLINUX=vmlinux
KCONF=MMU,M68040,M68KFPU_EMU,MAC,SCSI_MAC_ESP,MACINTOSH_DRIVERS,ADB,ADB_MACII,NET_CORE,MACSONIC,SERIAL_PMACZILOG,SERIAL_PMACZILOG_TTYS,SERIAL_PMACZILOG_CONSOLE
elif [ "$TARGET" = s390x ]; then
  QEMU="s390x" KARCH=s390 VMLINUX=arch/s390/boot/bzImage
KCONF=MARCH_Z900,PACK_STACK,NET_CORE,VIRTIO_NET,VIRTIO_BLK,SCLP_TTY,SCLP_CONSOLE,SCLP_VT220_TTY,SCLP_VT220_CONSOLE,S390_GUEST

(Well, modulo thunderbird being unable to an indent a line that goes off the
right edge of the screen. The mozilla foundation somehow managed to spend half a
billion dollars in 2019 but it wasn't on thunderbird, I can tell you that.)

Anyway, I wrote a couple FAQ entries trying to explain the worst of it:

  https://landley.net/toybox/faq.html#cross
  https://landley.net/toybox/faq.html#mkroot

> Anyways it could be that people that want this get around to fixing
> SILO eventually and just sit on this last kernel version... *shrugs*

They're never sitting on the _last_ kernel version. They're generally way back
from there. Been true forever off of x86 (and now arm):

https://lore.kernel.org/lkml/201002211025.11588.rob@landley.net/T/

> Chase

Rob
