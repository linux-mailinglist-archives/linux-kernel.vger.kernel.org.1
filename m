Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8792BC214
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgKUUb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgKUUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:31:58 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3560C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 12:31:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so2243760lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 12:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d/b7Hy04mhwjDpN6XL4TWAKPlQGwHadj3yQZ49j5Bk=;
        b=TwbsGRk2hSuldi031hRpur/5BVIv3rNiJ9E5XiM8UJQvom7OcU2G7vYCoWEB++lNt3
         NS8HT09uklpHK7k8Jf2vSKrZe4xpUsm4HZ5aiwFIfa9w9sYukVKKFOFthSIBDTp7D7wq
         mN9+ljC9HM2O2ufc1q/PC59kn6NdZ8CQ9hmmADrW2Tq1dZWk6iWUcQ022tVYxETgiUsV
         jwO5AvBkOZzVSwuYpXRPJZMqwXwW/t37AxNSbOxEREqi8G2T2ewCF/MJ0LcRuCDQV4dl
         cAGucVsHqGzhTmUlgPDmkm5PkuHT9nxSQI/7bl8p4x6EugC5O9X2jprnD9cck6TYBkKE
         Jy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d/b7Hy04mhwjDpN6XL4TWAKPlQGwHadj3yQZ49j5Bk=;
        b=WUf/HAclALs6MRT00bDYl5jlAFu5oJ3Ak6mRejHQy+M55npZkU8XLmGHAP7lIo0W9q
         aOg23zR815nnjkKh4+SELJuuAy3e2rhKX3dbTMww535EMpfR5Uz6sBTUBJ6Qiq5pR9HD
         hvKnoHP49kYPTsjNf2pftgCUek5UGTWCrc5+QY/QUwZUZ15uSCb7LWjEcWb48ES7WvV2
         Gl9r+lj/e4fMRh4CNaw3j0mVSN0ohd7SNC06MhDkSfnt9nkMC56DcKCz0Pt0Yy6YwzRU
         HyLg45vU8rFbu3UGREnmxP82avSdHulfNKMuePsu89KZL1x1jNLwv2fTwRwHEPPwyHsV
         xK7Q==
X-Gm-Message-State: AOAM533qoUFkPXoQKvZr1tXHc9QaZ+FIDyUtdGE+RBo9hFOeQD/dflIS
        tQXhCDVe7ImU3MLbEZkqPWgwiiZnxTKPu+xUGpE=
X-Google-Smtp-Source: ABdhPJwqJBgxkEiVS/mKJFtZOtD5D9pfov++RYKrPoOWaURnCAeie5c+HkF6OgZ6MS7f8U7m/YUWIoBCkHoOGiZ3sEU=
X-Received: by 2002:a19:4147:: with SMTP id o68mr10937840lfa.365.1605990715231;
 Sat, 21 Nov 2020 12:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20201121161706.104631-1-dwaipayanray1@gmail.com> <185d4505b35be4b9d039f430b3f95e7c33ed6a49.camel@perches.com>
In-Reply-To: <185d4505b35be4b9d039f430b3f95e7c33ed6a49.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 22 Nov 2020 02:01:23 +0530
Message-ID: <CABJPP5AsOwPDYrqMAZ5Vdo8kz55Uccq0jPFfzvB4NTWHDhkJ8A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add --fix option for INCLUDE_LINUX
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 1:35 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-11-21 at 21:47 +0530, Dwaipayan Ray wrote:
> > Provide fix option to INCLUDE_LINUX check to replace asm
> > includes.
> >
> > Macros of type:
> >  #include <asm/percpu.h>
> >
> > are corrected to:
> >  #include <linux/percpu.h>
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5468,8 +5468,11 @@ sub process {
> >                                               CHK("ARCH_INCLUDE_LINUX",
> >                                                   "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
> >                                       } else {
> > -                                             WARN("INCLUDE_LINUX",
> > -                                                  "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
> > +                                             if (WARN("INCLUDE_LINUX",
> > +                                                      "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
> > +                                                 $fix) {
> > +                                                     $fixed[$fixlinenr] =~ s/\<asm\/$file\>/\<linux\/$file\>/;
>
> $file can include a slash.
>
> e.g.: arch/arm/kernel/atags_parse.c:#include <asm/mach/arch.h>
>
> Probably simpler to use /Q /E quoting.
>
>
Thanks. I will do that.

Regards,
Dwaipayan.
