Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA2300AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbhAVRX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:23:29 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:40820 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbhAVRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:18:41 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 10MHGkoP002150
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 02:16:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 10MHGkoP002150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611335807;
        bh=7aau9PxHAnafi3oN/+zYS2Ze6Rbf+rezoEjEKMGwl64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YGOsWqaNsmf+wzo00P/vgj4tiiwRF4DAsjbWzNuN9aVQ5ZbFAKmLTT735z4luR2eI
         0DbilIvrM1q76JQHdH856F6yYkQTFKYbqiz8+8WX2blBchcDe5A7eEGLTATh87b2g8
         3fK52xChFLXNDuwt5/T4Q1zliTECgANWJkQFiw02jbF/eFLXAfbl3B/DWSNADZcZ4p
         /lGpQeOF1QC56jMhr/AB7NOUljCZN8bf5VM8vUhPP4vW8HbqV8AJ8opyRfO6/C5cl2
         GX9S1cy0d8SIHJCcfYe3UovDqXrk9ZMi1MDnQP8AGzklwEglxWiPVvRNtakrclz/8c
         WhC908Ms5/SVg==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id kx7so4189151pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:16:46 -0800 (PST)
X-Gm-Message-State: AOAM5337/p4oOBQ0+t5L1gDJ8O9YgLpZ2rBG21H9pEgr+r9lpIrxlW0Q
        nzvK9JQeewd1HlxnbB/L7XnuRtIEqM7OCtPKzzM=
X-Google-Smtp-Source: ABdhPJyIpuytC3J01xxbf81AvLuBj6hKCfZI3jpuSNWvD/lf2L3no27thkc33mJZ8H6f2BuGLCHuysP9EfRtkS8RSTg=
X-Received: by 2002:a17:90a:3481:: with SMTP id p1mr6615432pjb.198.1611335806227;
 Fri, 22 Jan 2021 09:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20210121170736.2266-1-scott.branden@broadcom.com>
 <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
 <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
 <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
 <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com> <64d3d8cb83e09d03927dba998a09e8b37e06dece.camel@perches.com>
In-Reply-To: <64d3d8cb83e09d03927dba998a09e8b37e06dece.camel@perches.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 23 Jan 2021 02:16:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQM5zYu3J-zP1AFPSKqiFL0rmnud9WyNFDNMmg3Dgw00w@mail.gmail.com>
Message-ID: <CAK7LNAQM5zYu3J-zP1AFPSKqiFL0rmnud9WyNFDNMmg3Dgw00w@mail.gmail.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 12:51 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2021-01-22 at 07:06 +0900, Masahiro Yamada wrote:
> > I use Ubuntu, where /usr/bin/python is a symlink
> > to /usr/bin/python3.
>
> Odd, here:
>
> $ lsb_release -a
> No LSB modules are available.
> Distributor ID: Ubuntu
> Description:    Ubuntu 20.10
> Release:        20.10
> Codename:       groovy
>
> $ ls /usr/bin/python -la
> lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> python2
>
>
>

Hmm, presumably I changed the symlink path by myself
although I do not remember...  Sorry for confusion.





-- 
Best Regards
Masahiro Yamada
