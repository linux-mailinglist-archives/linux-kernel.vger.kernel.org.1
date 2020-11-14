Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039822B3118
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 23:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKNWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 17:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKNWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 17:02:04 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28055C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 14:02:03 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b17so15228578ljf.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jdPfASeyUaZSegeNQGUlLTP9owwyXDnGyI5s1lIRsOE=;
        b=gygl5tGsJy3uYb8anbA6WXzqVq1IFAo7EV/rhzkjhJmUfq5HhrQZ8ZYZCkfM87Rw5x
         9oARbIHO3qw+a7wmzrnH3hH2SiiWr3Ev7sMJFGxdCBQw5Za47+9PY8njf+fkOQ5ZyYHd
         PAq5I3gi/rG3tACjqIFstReGZKnGWcZh9z7WeY+CRRHlqWwWm26XIuPyTM4wQ0e9dPoD
         cqHtcE7MoxQQyEStDT/c22MDjRTEYzrCaxDhUJ+HrJKEy4o1iQVt7/zimnXPagWjTmc4
         HZzQHOIqJ+EDD/Mitqeb60hLiDGwnibRw9ZDtKl6yIuOpsMGTLPlivMPzPCFbLObeTMe
         5E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jdPfASeyUaZSegeNQGUlLTP9owwyXDnGyI5s1lIRsOE=;
        b=uTnHToBdciSKaQ07CejrcDKkmwy/MeidhIKR7+PQC/RYCKz4hVc34UFctgo7tfT8Ar
         pb4+UMeVeVS/hUt17R05O0y3C++yqZ+45Pp6Ad+cZRCS7wMhEuGoY+7SsY/vNce4PCnl
         R0JedO5yPlHDFH9CZ3gb8vnbrGY5jqKeEtF3pCOnWWDdz8qRVUirraAkGgJGmtUZ77Bn
         m5T/hpeuJd8fEJEbVejvZ/SzaRXo/loJpae2DNGeKJ4onQZaVpRs20Onpf7a9IqdEQV/
         CneGjVUjbLYoevqEtGobf0vsiC0a5schgVSy+qnmKokzcZHbc2smAkbfy8Md/1JlqDue
         qSMg==
X-Gm-Message-State: AOAM531eZ+IHsIn8smAwgtxoKfSiyyowClGYzK1uN0SrHrkWt7pn3rnW
        f1iTtlI9BoAdSTHCfcTZ21TwWvBZSFQTJcgH8MnMWQ==
X-Google-Smtp-Source: ABdhPJwAscjglmMM0RrEHgkWLXZaJ0iGvYz3xqiqtIY8kXqUFul9VBxmrPr1aTwT356eHA8cSC8L01U+8p3GOVGMmYY=
X-Received: by 2002:a2e:854a:: with SMTP id u10mr3922940ljj.443.1605391321182;
 Sat, 14 Nov 2020 14:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com> <tencent_3801BEAE39670E174105E007@qq.com>
In-Reply-To: <tencent_3801BEAE39670E174105E007@qq.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Sat, 14 Nov 2020 14:01:50 -0800
Message-ID: <CAOGAQepHauLriqfkxzMfyB=5MqUrX0XRTt==eSN=Q48CjKiEYQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hancai,

do you know if CONFIG_GOLDFISH_AUDIO is required for MIPS? I sent a
patch to retire it.

Regards,
Roman.

On Sat, Nov 14, 2020 at 12:06 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhc@lemote=
.com> wrote:
>
> Hi, All,
>
> Goldfish RTC works well on MIPS, and QEMU RISC-V emulator use Goldfish as=
 well, so I think  we should keep it in kernel.
>
> Huacai
>
>
> ------------------ Original ------------------
> From:  "Greg KH"<gregkh@linuxfoundation.org>;
> Date:  Sat, Nov 14, 2020 07:43 AM
> To:  "Roman Kiryanov"<rkir@google.com>;
> Cc:  "chenhc"<chenhc@lemote.com>; "Paul Walmsley"<paul.walmsley@sifive.co=
m>; "LKML"<linux-kernel@vger.kernel.org>; "Lingfeng Yang"<lfy@google.com>; =
"Rob Herring"<robh@kernel.org>;
> Subject:  Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
>
>
>
> On Fri, Nov 13, 2020 at 03:36:49PM -0800, Roman Kiryanov wrote:
> > +Greg KH
> >
> > On Fri, Nov 13, 2020 at 2:02 PM Roman Kiryanov <rkir@google.com> wrote:
> > >
> > > Hi Hancai,
> > >
> > > I see you added /arch/mips/boot/dts/loongson/loongson64v_4core_virtio=
.dts which
> > > refers to goldfish-rtc in 39c1485c8baa47aa20caefc1ec0a3410fbad6c81.
> > > We (Android Studio Emulator aka "goldfish") do not support MIPS anymo=
re.
> > > Do you know if goldfish-rtc still works and is assumed to be availabl=
e?
>
> I've dropped this patch from my trees now, please feel free to resend
> when you have an updated version.
>
> thanks,
>
> greg k-h
