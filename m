Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE527F2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgI3UA2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 16:00:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:00:28 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MrOq7-1kjHaP1ozn-00oZRE; Wed, 30 Sep 2020 22:00:26 +0200
Received: by mail-qv1-f47.google.com with SMTP id q10so1606685qvs.1;
        Wed, 30 Sep 2020 13:00:26 -0700 (PDT)
X-Gm-Message-State: AOAM530GCJaz7LV70OaTyWlu9gUefXZeo61PyxdY5XAj761Wk1fLSBxp
        HrlCbTR5JsB5b2+ennTCzp1UxtSCUVpQ/24GnSQ=
X-Google-Smtp-Source: ABdhPJyWWzEsXMV+slu96RS1qTkNBFb/0nnpZW+XtD+lfJd3MrcE3uu0eFCwIRrOZ9OSXzKQaZzQk9XaiBVgiCB1pIc=
X-Received: by 2002:a0c:b39a:: with SMTP id t26mr4299788qve.19.1601496025174;
 Wed, 30 Sep 2020 13:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200930105442.3f642f6c@aktux> <20200930164446.GB219887@roeck-us.net>
In-Reply-To: <20200930164446.GB219887@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Sep 2020 22:00:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
Message-ID: <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andreas Kemnade <andreas@kemnade.info>, rydberg@bitmath.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:l33NlXdtX+Mu6Oa+/YyShoCbG5gauRlL/D2D1spm6U9gdRS4jm4
 nsioQqsufdyTQidCoTcKA6iMExJ9qqihKtcbtpC+Zmopwxf59Q+y44OJuLupivEyIZAPvAD
 7qtZKRPLWIW0JdxwnU+Qq+2OhJuuqc3OFYKCtBuscCjn/HFA3yGiCIScBRWkAagAcvvH6Ew
 ofBwTX2eN7s/jKtGrEe+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T3J0tC7JDik=:n5a3p4ioCXTRafvfk2bmNi
 D/U8ka8ivWGqPvrt3EGWssn7Wb8vTirN2ogOzye797aJxeLSJDaIKdKP3LvEaluPS8u9vdwbh
 H2fctfw0Ta5wfnbENBFGor4ThmqQF6S/Vm6gmLesMglVOcE3b5mvlix8kMliHPNHUzkYss+Gx
 BFGOQhwL11nd+7SjsY9l3VC49j5iScJxN5WaPysgiDzkefWV57ojyR6VPiTRFJVaDD8uXIEIL
 BKwFsFa7yYRGuxXN5DU7DIRAXgJpmYQy7ww4em1sevMe/JzAw8/o7HrimiYdLUwYCe3aVwYic
 Ly77p3p/25sIJPnNpfhIEz1fWtQxMqFBzMgz4zsDSEKRjwxKJmKPmgsHmEDNnFRDE7H3mMd7A
 fku/yEyuC2D7/G0gwHHD1m9eWHPRqUKl0YI+UCkGqBj+BOFfle2/Dd8Z0TzVt7c3efribqfh2
 UUL1dMhhP66/RQyW+kRVTH9VMY8Q+yZpyup4sIlFROL1h0iJt2y/to2E4aJOnN9q3ZN8RYGc2
 dpFeQjnDz4LeVR6QPU/9zBqbXK5WXTAvTJNp9rj062UokKUzV2hJtXgaLZMiI93KJenI1yy42
 y3Sii4jivj0eXdMJNT0DMEeHb1yx07E2MTt2Bai2AxstZEAU63jEg0vxmFANPVqCkFEw6T0x5
 aW8U0FKXG1Ls3ZDH6Gn+4D/27Fjrg+Na1Qkfh6eDv3O8U0P0zEDczklIwb3WgJVO0dIA6d+0M
 RtN68AKklqwCm8BB3IJcNZv24NFmaPayAniuWNaHAv2efstMRDForzymdPTFrcDpFKC87q/Gk
 qo8a9oczVI0TctLqcX+62koiqy8+pAFeC38HJLPblf2AgCx8gb85n4ykKGvdSIlDfxLjg8n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Sep 30, 2020 at 10:54:42AM +0200, Andreas Kemnade wrote:
> > Hi,
> >
> > after the $subject patch I get lots of errors like this:
>
> For reference, this refers to commit fff2d0f701e6 ("hwmon: (applesmc)
> avoid overlong udelay()").
>
> > [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> > [  120.378621] applesmc: LKSB: write data fail
> > [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> > [  120.512787] applesmc: LKSB: write data fail
> >
> > CPU sticks at low speed and no fan is turning on.
> > Reverting this patch on top of 5.9-rc6 solves this problem.
> >
> > Some information from dmidecode:
> >
> > Base Board Information
> >         Manufacturer: Apple Inc.
> >         Product Name: Mac-7DF21CB3ED6977E5
> >         Version: MacBookAir6,2
> >
> > Handle 0x0020, DMI type 11, 5 bytes OEM Strings         String 1: Apple ROM Version.  Model:       …,
> > Handle 0x0020, DMI type 11, 5 bytes
> > OEM Strings
> >         String 1: Apple ROM Version.  Model:        MBA61.  EFI Version:  122.0.0
> >         String 2: .0.0.  Built by:     root@saumon.  Date:         Wed Jun 10 18:
> >         String 3: 10:36 PDT 2020.  Revision:     122 (B&I).  ROM Version:  F000_B
> >         String 4: 00.  Build Type:   Official Build, Release.  Compiler:     Appl
> >         String 5: e clang version 3.0 (tags/Apple/clang-211.10.1) (based on LLVM
> >         String 6: 3.0svn).
> >
> > Writing to things in /sys/devices/platform/applesmc.768 gives also the
> > said errors.
> > But writing 1 to fan1_maunal and 5000 to fan1_output turns the fan on
> > despite error messages.
> >
> Not really sure what to do here. I could revert the patch, but then we'd gain
> clang compile failures. Arnd, any idea ?

It seems that either I made a mistake in the conversion and it sleeps for
less time than before, or my assumption was wrong that converting a delay to
a sleep is safe here.

The error message indicates that the write fails, not the read, so that
is what I'd look at first. Right away I can see that the maximum time to
retry is only half of what it used to be, as we used to wait for
0x10, 0x20, 0x40, 0x80, ..., 0x20000 microseconds for a total of
0x3fff0 microseconds (262ms), while my patch went with the 131ms
total delay based on the comment saying "/* wait up to 128 ms for a
status change. */".

Since there is sleeping wait, I see no reason the timeout couldn't
be extended a lot, e.g. to a second, as in

#define APPLESMC_MAX_WAIT 0x100000

If that doesn't work, I'd try using mdelay() in place of
usleep_range(), such as

           mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC)));

This adds back a really nasty latency, but it should avoid the
compile-time problem.

Andreas, can you try those two things? (one at a time,
not both)

       Arnd
