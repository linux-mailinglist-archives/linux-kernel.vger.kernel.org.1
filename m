Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B654A269B15
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOB20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOB2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:28:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D7C06174A;
        Mon, 14 Sep 2020 18:28:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so469176pln.10;
        Mon, 14 Sep 2020 18:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPAic55gNV1BGLuiljEZld/a/aSvryfxDczEePnb6II=;
        b=AAMfKea33UzA6uRvODrBSb62VDo1TzykDiq7BdA2Tlb4LvqB0Xop5Q2O7V8ILPtasQ
         FIhzqcMZi1suibRLmuS9WsIQ7B0rdDG7sbrhAzYIpfRJyeEY5qZCAniOzNLaoC1UzcI5
         kVlAO4PEGO0UjGLzqlZI3uhpsLNOwvQDLc09E6M+jOQElrXB4h3fSvoJD7IMS47lZi8K
         rUzGuVKaeFF3pde/Ft6K8dKZ6ypHTxB14kqfxUpXmG/FSeb+kh/DzAEcd6XoKzudJuXP
         L/iUZT8a4XyuHVphIwj46i+hxBhO2kQBk6CzxBg7tAl/GuegEWPLMfUB16H/MOFunnjJ
         ioZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nPAic55gNV1BGLuiljEZld/a/aSvryfxDczEePnb6II=;
        b=TDj2SPACMbi68r9men1d0G0zfl0OIKxEJvUC29tiVeQy2olVaD2kysqaeG71EU7TgF
         q+JBjCcv365ciaP68ggq1OxyGFUPHM1QOslMtiYgh9WyTX91K4wamOL8JwrX8z2utPd0
         RQD74lwdJZ5cB9bK/1aTPQm6PWXdAaqs92VU1IOoRyQJcq/I6u2f6B4BfueBGuwAufgH
         pC45Ohejtz16FJtiQBbQ/yNthvTJFhL5fFldg5lIeHwyzGjLWokov23635DvCDlgCByx
         j9T1yTes9D052wkYa0vzSAIOa0OEyPgv3cgVfEyz+3o1a+Wt+pWDHxCMyA0TKdoHJQwm
         T5YQ==
X-Gm-Message-State: AOAM532Wcu9Ud9Hj0A7mvAizxu4CQgvzxhbSl/dfK2bRC4baBtAiM+z/
        d5/84hCgpj1pfkw4cPHyrPI=
X-Google-Smtp-Source: ABdhPJwBqVH4CsmkwrGzBF83sUzIzqoBTHdj1c5i9y4vBgdr99Rs8tzpJx83T39G5WFGKVHmTCOKwQ==
X-Received: by 2002:a17:902:6b49:b029:d0:a5f8:5991 with SMTP id g9-20020a1709026b49b02900d0a5f85991mr17049034plt.7.1600133296566;
        Mon, 14 Sep 2020 18:28:16 -0700 (PDT)
Received: from Gentoo (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id z7sm11642182pfj.75.2020.09.14.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:28:15 -0700 (PDT)
Date:   Tue, 15 Sep 2020 06:58:00 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Message-ID: <20200915012800.GA17809@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Yuan Ming <yuanmingbuaa@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
 <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18:18 Mon 14 Sep 2020, Randy Dunlap wrote:
>HI--
>
>On 9/14/20 3:48 PM, Linux Kernel Mailing List wrote:
>> Commit:     50145474f6ef4a9c19205b173da6264a644c7489
>> Parent:     856deb866d16e29bd65952e0289066f6078af773
>> Refname:    refs/heads/master
>> Web:        https://git.kernel.org/torvalds/c/50145474f6ef4a9c19205b173d=
a6264a644c7489
>> Author:     Linus Torvalds <torvalds@linux-foundation.org>
>> AuthorDate: Mon Sep 7 11:45:27 2020 -0700
>> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Mon Sep 14 10:06:15 2020 -0700
>>=20
>>     fbcon: remove soft scrollback code
>>    =20
>>     This (and the VGA soft scrollback) turns out to have various nasty s=
mall
>>     special cases that nobody really is willing to fight.  The soft
>>     scrollback code was really useful a few decades ago when you typical=
ly
>>     used the console interactively as the main way to interact with the
>>     machine, but that just isn't the case any more.
>
>and:
>
>> Commit:     973c096f6a85e5b5f2a295126ba6928d9a6afd45
>> Parent:     06a0df4d1b8b13b551668e47b11fd7629033b7df
>> Refname:    refs/heads/master
>> Web:        https://git.kernel.org/torvalds/c/973c096f6a85e5b5f2a295126b=
a6928d9a6afd45
>> Author:     Linus Torvalds <torvalds@linux-foundation.org>
>> AuthorDate: Wed Sep 9 14:53:50 2020 -0700
>> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Mon Sep 14 10:06:15 2020 -0700
>>=20
>>     vgacon: remove software scrollback support
>
>
>
>diffstats:
>
>> ---
>>  drivers/video/fbdev/core/fbcon.c | 334 +-------------------------------=
-------
>>  1 file changed, 4 insertions(+), 330 deletions(-)
>
>>  arch/powerpc/configs/pasemi_defconfig |   1 -
>>  arch/powerpc/configs/ppc6xx_defconfig |   1 -
>>  arch/x86/configs/i386_defconfig       |   1 -
>>  arch/x86/configs/x86_64_defconfig     |   1 -
>>  drivers/video/console/Kconfig         |  46 -------
>>  drivers/video/console/vgacon.c        | 221 +--------------------------=
-------
>>  6 files changed, 1 insertion(+), 270 deletions(-)
>
>
>
>
>Now someone can remove the documentation for scrollback (and "no-scroll").=
=2E.
>
>
If you wont mind ...let me stab at it ...

Documentation/admin-guide/kernel-parameters.txt:        no-scroll       [VG=
A] Disables scrollback.
Documentation/fb/fbcon.rst:2. fbcon=3Dscrollback:<value>[k]
Documentation/fb/fbcon.rst:     The scrollback buffer is memory that is use=
d to preserve display
Documentation/fb/matroxfb.rst:   with 'video=3Dscrollback:0'.
Documentation/fb/sstfb.rst:  disable software scrollback, as it can oops ba=
dly ...
Documentation/fb/vesafb.rst:            * You'll get scrollback (the Shift-=
PgUp thing),
Documentation/fb/vesafb.rst:              the video memory can be used as s=
crollback buffer


~Bhaskar
>--=20
>~Randy
>

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9gGJ0ACgkQsjqdtxFL
KRUEdQgAhnWb6T+ZbTLIvspMNo8l6hojODLn587MDgOxq5Bh9ml2v87x/07eGebq
08gV+HUqyMPcKKS/n/zmhFGYoA17Ik49Gl5U6YWkA6ZFfcLgBCAR/oFo89proSdF
XDN4Ko01tXOri8CaYt4CQ/MQAcnJ7omSJMDimA9haECkcq9pbEf+1ycwcPeAxNRE
Sas3qrTZNINkaS9iWbsBWvupwJJKg0gMtkjNBUuNUQyemXV/KXXZXOCqo8CYwRVg
AvrLSgU3jkji4OOFMIk/393DZPhdDgKAnbsWLnCKQvmbrINqJl/N+C22wot1nDhL
ihJqyPNCBpa1WmkrJLmz8Sm0lDuOvA==
=XyrY
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
