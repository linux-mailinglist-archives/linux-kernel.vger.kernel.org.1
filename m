Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652D42C774F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 03:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgK2Cxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 21:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgK2Cxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 21:53:50 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E16C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 18:53:09 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f18so11152938ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 18:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drummond.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z0lqPkiUKcw4hoWEb756wuRPxVLj2QZ6yrKh9T2kOgI=;
        b=X/bkx06YJ3v398ihXZjgVhDZnmGs9qoPF2jx2MPLzwQS8kEfGrj9Pu48mEj2DNtE0V
         79bFSnZfzr19HDT/cMKNMesFey32MGn59mJdbEjJwqsTUKIntj2CBjgCADfKrgZbl6tM
         hplxd3adosuecyMlyhisyZ4oOsiXMB0dHjZuw4r8kQ5c1Ar+60d8htYEGw25qu++xZI0
         obKvB53JK6XggA0taW3TS3zoSjP2gg32Yk5joNJDGml/619etKHB9m1Zcfyo0Jy4uOF+
         Xn3zbWxid1ICt2tdlq1a2fCAor5m1RJ0NZ/BXwfFc09RgetnxiHiQpXpa5fG8nUW0Rt+
         cLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z0lqPkiUKcw4hoWEb756wuRPxVLj2QZ6yrKh9T2kOgI=;
        b=NbeS/2pzFGXzLEmC/U4S7yAx/TA/Z50ePCkiKsmxJF9YLhMCZ2IgtIz5yWW3uxUwoT
         BsBIM7fV8UpG7tkF2fkTo0gUZfBdFHk7GhyURIJnPZrjpfpas8cT1d4LONiupYvLnDCU
         7DRc+KFWLY/eN2lnNvnqL0Uar5az8F39KAq/76zVlPTRWI4FJ2YQ/pU0ooGFeNk6ljCJ
         rDACXff+BSjO7+Z1WyzFiUrBM421JZ83KAvombKoETIjt9uEx8e+f/I6joZGL5WzbrF2
         eSzyxUTjyFb1QrzeblahwzlTKjDDgdCiEbpcHOC3qjZUjpzB1PxlBGESzfo6JKuodD8y
         Qlpg==
X-Gm-Message-State: AOAM533Y5vcP4fRISsM64kbzRgZAFYSmX2vJMTABBk6PKybuOcpzox1R
        JGaz3aNn5qGI5/hjc0ax+HYwlnQ0X5naHPXPF+Sssw==
X-Google-Smtp-Source: ABdhPJwUmF6td/ePH5sIY/3U2r3PRVBkTd++J+PTy4VNsptfvM1GpidEl1sPiKDcxErrrG7KCTSxOKxhd1e01fPdiPE=
X-Received: by 2002:a05:651c:1195:: with SMTP id w21mr6591270ljo.427.1606618388217;
 Sat, 28 Nov 2020 18:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20201119221132.1515696-1-walt@drummond.us> <20201128052317.GY3576660@ZenIV.linux.org.uk>
 <CADCN6nyGW0=QS=J+704n-mtAqTxgVrKZC=P8d01NZ_pjssptew@mail.gmail.com>
In-Reply-To: <CADCN6nyGW0=QS=J+704n-mtAqTxgVrKZC=P8d01NZ_pjssptew@mail.gmail.com>
From:   Walt Drummond <walt@drummond.us>
Date:   Sat, 28 Nov 2020 18:52:57 -0800
Message-ID: <CADCN6nzdJom0DazzvnRREDKAjRBoNAVhNiQrL3hAXvU-=i4mpg@mail.gmail.com>
Subject: Re: [PATCH] x86/signals: Fix save/restore signal stack to correctly
 support sigset_t
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, brgerst@gmail.com, linux@dominikbrodowski.net,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, resending as Gmail decided to ignore "Plaintext mode")

Thanks Al.  I want to understand the nuance, so please bear with me as
I reason this out.   The cast in stone nature of this is due to both
the need to keep userspace and kernel space in sync (ie, you'd have to
coordinate libc and kernel changes super tightly to pull this off),
and any change in the size of struct rt_sigframe would break backwards
compatibility with older binaries, is that correct?

Thanks, appreciate the help here.
--Walt


On Sat, Nov 28, 2020 at 6:19 PM Walt Drummond <walt@drummond.us> wrote:
>
> Thanks Al.  I want to understand the nuance, so please bear with me as I =
reason this out.   The cast in stone nature of this is due to both the need=
 to keep userspace and kernel space in sync (ie, you'd have to coordinate l=
ibc and kernel changes super tightly to pull this off), and any change in t=
he size of struct rt_sigframe would break backwards compatibility with olde=
r binaries, is that correct?
>
> Thanks, appreciate the help here.
> --Walt
>
>
> On Fri, Nov 27, 2020 at 9:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> On Thu, Nov 19, 2020 at 02:11:33PM -0800, Walt Drummond wrote:
>> > The macro unsafe_put_sigmask() only handles the first 64 bits of the
>> > sigmask_t, which works today.  However, if the definition of the
>> > sigset_t structure ever changed,
>>
>> ... existing userland would get fucked over, since sigset_t is
>> present in user-visible data structures.  Including the ones
>> we are using that thing for - struct rt_sigframe, for starters.
>>
>> Layout of those suckers is very much cast in stone.  We *can't*
>> change it, no matter what we do kernel-side.
>>
>> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
