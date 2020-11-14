Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEBC2B3119
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 23:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKNWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 17:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKNWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 17:03:21 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A1FC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 14:03:20 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so19330920lfq.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tw519QnQqGiK6rupN/NcEfOuWk4WM7fN7+syGC2XjjA=;
        b=iRILio44OnjOmHzJbJnSRFvxcXfEg4UAb+d90OWmiWRGzN5lWl10mUvVXSv1ekhfFg
         g+c1PWrUK0ZEiZGHXqLPLpC4XPEqpZbhje+5ZSoLxHFCv6axPBQfGb38bu5sfBj4tXwJ
         0Ad7VqeKTxbRYDZ0b2jvnRFXDSV02KjcrxelUQYdb/diEONb1incflBsfMi5Lqq7f9A8
         QzxHwmW9vbAgMEeMGMfpIk0/DOK5rZMGWoiANcIbJOsK+LCIu6RMxUg+ZFIoCO10elaS
         qEPbCIY6ZSy0T+Lxc5Z4K7KwVPD2tT78sH+jmGAfosWwETu6bFgl4QbIOwgelHw83PaQ
         SncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tw519QnQqGiK6rupN/NcEfOuWk4WM7fN7+syGC2XjjA=;
        b=JMWleAntuIpTv6Xhkoj2H5vckzmb96rwvTf+UFTc5SI3iOC3126LX7hAkWXgwYAJlF
         hrQYDEL78QOjkePA1tmrIBhriyOVu5oZV+fB7MNgwX4QAuEvvN1mqz8gzAJWoD5L4wFR
         6D4S90Z06U4aZFhLAprJP5JcP7fTlnLMxRHGJ/+jKEaONIU5YlngJEaUfWw+FqLFr/fu
         4taj6HbzF0f5Kqu6zj9IB6jztla2h+O/UR8f4w2L+oTXsH1yd0YJB7aCuxm0vKL629zd
         lPC+7wUTX4faqBleIQhL4tmxgnq6kqTfosuy/vsr12pSMA+FkLVhdTuujpBx/LkGCmbF
         pGXg==
X-Gm-Message-State: AOAM533w1UE/fc48PSgW0rCCmJWMaE0mjuTFY8NFieLdMlTGZ0dLb+Lc
        SuGFjpghWtndZmFkmKVW942tfrO4/eKT8sFrNZ6jEA==
X-Google-Smtp-Source: ABdhPJxuieUCZuZY4/FA3Rv67o1ZRi+jEL8ixsARtgSR69Qd6QooGRmk1cuVPtNz3SmeIRGmGfr/S1QBdrtUKG7Qc+w=
X-Received: by 2002:a19:9c7:: with SMTP id 190mr2795765lfj.545.1605391398863;
 Sat, 14 Nov 2020 14:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com> <tencent_3801BEAE39670E174105E007@qq.com>
 <X6+SKQS6QJr25kF0@kroah.com> <d1d47715-482c-f598-a958-499d9fde21e0@flygoat.com>
 <X6+wGMUCCpu2liYR@kroah.com>
In-Reply-To: <X6+wGMUCCpu2liYR@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Sat, 14 Nov 2020 14:03:07 -0800
Message-ID: <CAOGAQeoqSXwWyo_hgY4ru+WyxLjHuMv9m0cmoA7O+-pEUEZryg@mail.gmail.com>
Subject: Re: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>,
        anup.patel@wdc.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thus I do think it shouldn't be retired as for now. If nobody comes in I'd
> > also willing to maintain
> > it.
>
> Ok, can someone submit a patch to update the MAINTAINERS file for this
> so we know who to route issues to over time?

I will send a patch to update MAINTAINERS for goldfish-rtc.
