Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D52AE490
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgKKAEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKKAEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:04:39 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32123C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:04:37 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so15140387ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JzWWY6NuciTI33aQq96X3WiN1h2jDKoGrOwhs2Ifrxc=;
        b=DSw+pVH6EQmIKgMM49DrSxbYR8Ia08GpFokAgc4lncdWrInFkSMUP0k/INRLZEBshA
         H2s4OgDrG9h5nRuZF9VelAC2M2CMq1b94qV7D7IyW3sgxYCmDNn3qsfFlcskaARrnfZ4
         ap7L10qrulUSlTgUG7ZnTO4n1N/I+WLuiUtjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JzWWY6NuciTI33aQq96X3WiN1h2jDKoGrOwhs2Ifrxc=;
        b=HzHmD0VmTsfZAGtwdb4Iy5skxlpM8HpiyLGgOTUZJqCTityEG/5RSHt7P3INPytaVu
         wjMhlbgRnapT72LwJEIVzLeW/DSwTjQpNny/WUNO7XjgfVrLn1L0DwbU+BQDX/mIbyua
         bBsSlCphgW4Vr9hz8yhuxw3Si/hjQ02luzaH+cAPYJb/wsTawE506CJbwi9lURMzuOKa
         ByD8U0ggXMUHES0tTm5pZTlLeav2tplMN6GKjf61s/0X76Gnl9CtYJ/gj5olOalLmGL3
         HWIXRbSAPIgR3I7MtgqxoTAKBYVlKDCgflHhqjGzqsOWtwBSgv6tAwzaJ0G+2zElhqlN
         LiTQ==
X-Gm-Message-State: AOAM531OCyucz1OhecgieGimXnFC4bce0gTDCT1D0BlUDa0IFhqW1pge
        YrNlSpPmMUhF/0GkOftcS/zb2ELrnG0bSA==
X-Google-Smtp-Source: ABdhPJzcDdTh1waKZNY3h01ePToxI08FGutXmvvv2lytZVmiYqsFqXhOnBsbJaa923mdvnYcpfb79A==
X-Received: by 2002:a2e:969a:: with SMTP id q26mr9961037lji.32.1605053075607;
        Tue, 10 Nov 2020 16:04:35 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id y6sm41296lfc.235.2020.11.10.16.04.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:04:34 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id l2so742145lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:04:34 -0800 (PST)
X-Received: by 2002:a19:408b:: with SMTP id n133mr8002533lfa.564.1605053074001;
 Tue, 10 Nov 2020 16:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20201110144932.1.I54a30ec0a7eb1f1b791dc9d08d5e8416a1e8e1ef@changeid>
 <CAHp75VcfmJ6-cqCsZ6BjbghGDt+w-AbxGxLoWG61VVF2Knor-Q@mail.gmail.com>
In-Reply-To: <CAHp75VcfmJ6-cqCsZ6BjbghGDt+w-AbxGxLoWG61VVF2Knor-Q@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Nov 2020 16:03:57 -0800
X-Gmail-Original-Message-ID: <CAE=gft4vdBytT2=tCbv2aE3RRoDut5CiHdBODjXJamGM5yB3Bw@mail.gmail.com>
Message-ID: <CAE=gft4vdBytT2=tCbv2aE3RRoDut5CiHdBODjXJamGM5yB3Bw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Fix Jasperlake hostown offset
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Wednesday, November 11, 2020, Evan Green <evgreen@chromium.org> wrote:
>>
>> GPIOs that attempt to use interrupts get thwarted with a message like:
>> "pin 161 cannot be used as IRQ" (for instance with SD_CD). This is becau=
se
>> the JSL_HOSTSW_OWN offset is incorrect, so every GPIO looks like it's
>> owned by ACPI.
>
>
> Funny, I have created a similar patch few hours ago. Are you sure this is=
 enough? In mine I have also padcfglock updated. But I have to confirm that=
, that=E2=80=99s why I didn=E2=80=99t send it out.

Oh weird! I didn't check padcfglock since it didn't happen to be
involved in the bug I was tracking down. I was trying to clean out
some skeletons in my kernel closet [1] and debugged it down to this.

If you want to smash the two patches together I'm fine with that. Let
me know, and CC me if you do post something.
-Evan

[1] https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/=
master/overlay-dedede/sys-kernel/chromeos-kernel-5_4/files/0001-CHROMIUM-pi=
nctrl-intel-Allow-pin-as-IRQ-even-in-ACPI.patch
