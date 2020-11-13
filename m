Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268182B293E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKMXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKMXhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:37:03 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001BFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 15:37:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z21so16535785lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+46JEsM3e3gjqj5mbSdzpRZCKdpg4uEldnhJK0kKto=;
        b=KlXJIgTougW6ZKQvcuur27xXhEfKPSrCoQqvmf2EYOFV/RAdM24ysrqUT3yvn1ihfv
         TGuJ7t2pOIrvJwCWwvzJw3P/kFIoA/PM9PKQLjdycdZrs5iGsoPTmE37+uNmjqwEC80D
         Bs3oWNp1rDRsL6VYZRunCSNmQgI4XAMP5g8a+rUbYwIHIZdTCx5Y94XWaqKDdckF2PtD
         nuvkEopeQBWVXmjlJI6H1nort5qDaf+Oa1tBy2fwGTe0bMcUE1HkigNFLmtx+5zwDfjy
         QsBiPLMt+dkAAqOWpTCVJPr2YWQaFUzP7sFW8BWR8lyrT2hgrswsau8nIGdLI99/+gRZ
         S16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+46JEsM3e3gjqj5mbSdzpRZCKdpg4uEldnhJK0kKto=;
        b=Nsmn3d9kgHaAUo5QKTIcSCtiRwiNgugtBVSmqLN7Orqf7ngT4ZzxwFVaecDwDD++mI
         5pVknlozcsCfR7CQcYIovDqK6FLxurYbLEuM6t9UwkbxnaAht9SKAM4ak4MQE8T3DhVU
         2JBCnOCUjJQrd3q0mApJM3wKb8lVXRhuKSb1l4zIG7hZDvlH/OR/FzmELR+RkWDIC0o8
         FzFCco0IYpkv20CslxPfXu8umYsRymR/+PnbwOgTIwwIL0xCBy2Zvt7tbSIkws7rZhAj
         SXatjNtyRSNzoOwYLF3EJOeOjdSDnuIQJKHYEn+918C7+Dz3whdz5rm8jPgPPZ0fDMm2
         EKZA==
X-Gm-Message-State: AOAM5337ZER8T1zd6euMUOu9ukvQG9g25pnqWEg4JCpUzS0VguVxVX8A
        rYeH+R5LetAQhuAOw4IeKlaJpES6m6LQ0wXnqs1wig==
X-Google-Smtp-Source: ABdhPJyp2rLyZgMwg7DC1z0Ek+NzkHSwFruSgvLL43LAYH0uNva0uZUIfFK/B0eGXdbEt+hD/FCQ+/xkOJobeTgGxSU=
X-Received: by 2002:ac2:4c2a:: with SMTP id u10mr1580011lfq.226.1605310620231;
 Fri, 13 Nov 2020 15:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com> <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
In-Reply-To: <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Fri, 13 Nov 2020 15:36:49 -0800
Message-ID: <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     chenhc@lemote.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Greg KH

On Fri, Nov 13, 2020 at 2:02 PM Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Hancai,
>
> I see you added /arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts which
> refers to goldfish-rtc in 39c1485c8baa47aa20caefc1ec0a3410fbad6c81.
> We (Android Studio Emulator aka "goldfish") do not support MIPS anymore.
> Do you know if goldfish-rtc still works and is assumed to be available?
>
> On Fri, Nov 13, 2020 at 1:18 PM Rob Herring <robh@kernel.org> wrote:
> >
> > > > What about the binding and MAINTAINERS?
> > >
> > > My bad, I will update those files too.
> >
> > Though the binding is still used in arch/mips/generic/board-ranchu.c
> > and arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts. The
> > latter was just added recently, so maybe premature to remove things?
>
> Thank you for catching this.
>
> Regards,
> Roman.
