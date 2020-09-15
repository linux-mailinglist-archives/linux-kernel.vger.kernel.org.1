Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CCF269C32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIOC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:57:48 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:20677 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgIOC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:57:47 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 08F2vWq7020755
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:57:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 08F2vWq7020755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600138652;
        bh=Xr7JFdXVt/ll5q4+mjcGj6Ps1QBbwreBkSd+NgA5XrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XaSuOwF46BEvFEDe0rudvGLTZpKvHIfCYwrM77QrUH49wbW+T2L9D9jpcvlqg8o9d
         Q43BjY9RScM9U/qf2PQNgg/npJBv/VoyKkllwfLQ7TEh1lEll9Ob8MyE/XueIv9HFo
         l4HwB2jhht4DbiZVoakP8SS9viI1l6B6f4nwj9d16wcUn85f1E5UK7rKSYqUPf1F2c
         QL+OoIEbmhbVRH6JfgFIGkzqU8fixg4AVsntRJQwjragiEpPDFyc+9NiGsSPJsKmwn
         TFHC1RJsmDfhl2cPpD5gd324NQtWOw4Bm9F7h6/y9bkbfwm7/FEqyYpauLzNCDwxXM
         mY4iYwblETv/g==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id d9so1108757pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:57:32 -0700 (PDT)
X-Gm-Message-State: AOAM532yoAEQ7m6JHRr8HpJqks3kErlVyfgri0fkkMswikGx4CTFYxi3
        5JXDCdd7rWuYlrNpVn2XOpmLsmTgq0XxAVHhG5A=
X-Google-Smtp-Source: ABdhPJwAci5nrPTDQk4x6YanE/cLg7pvckGJhnz36MKR4oId/Qfhoe7LRHaqjlGJklNI43OrNW2b7Wpqp3vQZYkRGec=
X-Received: by 2002:a62:5b47:: with SMTP id p68mr16069667pfb.153.1600138651681;
 Mon, 14 Sep 2020 19:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-9cd01270-7c54-4bf5-810d-e1b7de352e11-1600106229398@3c-app-gmx-bs03>
In-Reply-To: <trinity-9cd01270-7c54-4bf5-810d-e1b7de352e11-1600106229398@3c-app-gmx-bs03>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Sep 2020 11:56:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARw0aRmKLb+8mxZbzxvB0YQ2_ak5LpcpQy+=3HrtiFA1g@mail.gmail.com>
Message-ID: <CAK7LNARw0aRmKLb+8mxZbzxvB0YQ2_ak5LpcpQy+=3HrtiFA1g@mail.gmail.com>
Subject: Re: [question] KBUILD_OUTPUT and modules install (with INSTALL_MOD_PATH)
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:57 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Hi,
>
> i try to use modules_install target after building kernel with KBUILD_OUTPUT set
>
> KBUILD_OUTPUT: /media/data_nvme/git/kernel/build #kernel source is in /media/data_nvme/git/kernel/BPI-R2-4.14
>
> kernel is build successfully, but i fail on running the make modules_install target
>
>   ERROR: Kernel configuration is invalid.
>          include/generated/autoconf.h or include/config/auto.conf are missing.
>          Run 'make oldconfig && make prepare' on kernel src to fix it.
>
> Makefile:648: include/config/auto.conf: No such file or directory
> make: *** [Makefile:719: include/config/auto.conf] Error 1
>
> it looks it is ignoring the KBUILD_OUTPUT variable, as both files are present


KBUILD_OUTPUT is an environment variable.

Did you set (export) it
before doing 'make modules_install'?



> $ ls /media/data_nvme/git/kernel/build/include/config/auto.conf
> /media/data_nvme/git/kernel/build/include/config/auto.conf
> $ ls /media/data_nvme/git/kernel/build/include/generated/autoconf.h
> /media/data_nvme/git/kernel/build/include/generated/autoconf.h
>
> i also tried adding KERNEL_DIR var, but also without success
>
> sudo make ARCH=$ARCH KERNEL_DIR=$KBUILD_OUTPUT INSTALL_MOD_PATH=/media/$USER/BPI-ROOT/ modules_install



This is no variable like KERNEL_DIR.

"git grep KERNEL_DIR" obviously has no hit
in the kernel directory.






> $KBUILD_OUTPUT is definitely set to right directory (checked on beginning of my function)
>
> this message seems to be triggered by Makefile in root (here i tried to add the KBUILD_OUTPUT in the test before include without success)
>
>  718 include/config/auto.conf:
>  719     $(Q)test -e include/generated/autoconf.h -a -e $@ || (      \
>  720     echo >&2;                           \
>  721     echo >&2 "  ERROR: Kernel configuration is invalid.";       \
>  722     echo >&2 "         include/generated/autoconf.h or $@ are missing.";\
>
> any idea?
>
> regards Frank
>


-- 
Best Regards
Masahiro Yamada
