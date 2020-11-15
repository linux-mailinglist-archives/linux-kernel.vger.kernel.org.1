Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74232B32BD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 07:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKOGnW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Nov 2020 01:43:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41600 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgKOGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 01:43:20 -0500
Received: by mail-io1-f66.google.com with SMTP id t8so13964873iov.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 22:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FlCPIz21EkVPk8p6G6lCEs2golYaRENiMcOidNPlzCE=;
        b=Udcan16vCLe159jRV9ljXdZvCPtFbbXODhhwlQC8/lyMvjPvPeBT36W7CMt3uZ/UJd
         52esp9RMzGvrABGGpK9LT+a9A+zxVXgfjaXhaccR4sDl1pUQzpmeRfLTWHVYSl87Ow5k
         eBAvE/SSYmu5diFB3kgn+VZaR6SZN41ClE2grluVzR6uH5EJtbVHANFM9aOdk+VEE3eT
         pAnTz9KqkCJzfb5xG+iC4QgpWPMh0XyTIhXNfjsqCG4o8tGMTxeb5L+itbsSkojbqKF7
         GCPOMgkI+4lR6eGWqsOj9T8mfKOu+TKpwhjHalqNmjSVDeA4NeePWz/oqdNkNoWcxLzL
         DUSQ==
X-Gm-Message-State: AOAM532eIkB0WxHCcYEFcjO4azuhjSk7nClZle2saMYplg+bZoFRaKC/
        jmd0UACiAU6Lxwee+3uQhicPbrKczMbU2dUZrzzS417dULXQYg==
X-Google-Smtp-Source: ABdhPJxwE3eKgT/Hwxtb1X6oLPiFN90nlCj3CkEdEaN7YCVmrCrSzblnhY0wba39dtkDbgMgYlrdfM6jatqUj5A+zpQ=
X-Received: by 2002:a5d:97da:: with SMTP id k26mr4607093ios.13.1605422599905;
 Sat, 14 Nov 2020 22:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com> <tencent_3801BEAE39670E174105E007@qq.com> <CAOGAQepHauLriqfkxzMfyB=5MqUrX0XRTt==eSN=Q48CjKiEYQ@mail.gmail.com>
In-Reply-To: <CAOGAQepHauLriqfkxzMfyB=5MqUrX0XRTt==eSN=Q48CjKiEYQ@mail.gmail.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sun, 15 Nov 2020 14:43:08 +0800
Message-ID: <CAAhV-H72_yAt+r=P-3td=HkaeT3tAPg6VzPFaaMrmnf5deQo0g@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     Roman Kiryanov <rkir@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roman,

On Sun, Nov 15, 2020 at 6:02 AM Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Hancai,
>
> do you know if CONFIG_GOLDFISH_AUDIO is required for MIPS? I sent a
> patch to retire it.
Not required for MIPS.

Huacai
>
> Regards,
> Roman.
>
> On Sat, Nov 14, 2020 at 12:06 AM 陈华才 <chenhc@lemote.com> wrote:
> >
> > Hi, All,
> >
> > Goldfish RTC works well on MIPS, and QEMU RISC-V emulator use Goldfish as well, so I think  we should keep it in kernel.
> >
> > Huacai
> >
> >
> > ------------------ Original ------------------
> > From:  "Greg KH"<gregkh@linuxfoundation.org>;
> > Date:  Sat, Nov 14, 2020 07:43 AM
> > To:  "Roman Kiryanov"<rkir@google.com>;
> > Cc:  "chenhc"<chenhc@lemote.com>; "Paul Walmsley"<paul.walmsley@sifive.com>; "LKML"<linux-kernel@vger.kernel.org>; "Lingfeng Yang"<lfy@google.com>; "Rob Herring"<robh@kernel.org>;
> > Subject:  Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
> >
> >
> >
> > On Fri, Nov 13, 2020 at 03:36:49PM -0800, Roman Kiryanov wrote:
> > > +Greg KH
> > >
> > > On Fri, Nov 13, 2020 at 2:02 PM Roman Kiryanov <rkir@google.com> wrote:
> > > >
> > > > Hi Hancai,
> > > >
> > > > I see you added /arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts which
> > > > refers to goldfish-rtc in 39c1485c8baa47aa20caefc1ec0a3410fbad6c81.
> > > > We (Android Studio Emulator aka "goldfish") do not support MIPS anymore.
> > > > Do you know if goldfish-rtc still works and is assumed to be available?
> >
> > I've dropped this patch from my trees now, please feel free to resend
> > when you have an updated version.
> >
> > thanks,
> >
> > greg k-h
