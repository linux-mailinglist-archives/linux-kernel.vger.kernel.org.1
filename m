Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA142B2C53
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgKNI7u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Nov 2020 03:59:50 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43624 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgKNI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:59:50 -0500
Received: by mail-il1-f194.google.com with SMTP id k1so10661895ilc.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 00:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnRBIXl3Fe3njvQOAu3kkDy57kGIeRkfxE4PMnJy5a4=;
        b=oHm9h4LnG4Ubgts8448zwE3X0dxQTV+LKdlBI0q6xO3XSJdiWpypNNhHfKiwUIgRmR
         pDPlWbU9a6l6ovBcKBlTFccGQ4lMDWpbuTXgWiWQ1mqX+D7lrriZXeVW2Fdm3dCJTDtY
         qaSZJEcauY7gtIijPi3bejq6mp0PEcgDYWWiQPCcgBNDolvM5Yz3Ae/xYALtVE4Gopir
         Y3DlvkvSLBvn7wobT5jJRNNd8GfLNX6f2jxuENLjU+Qc51NuzahlOOFwcOkoonzxnt+R
         Iafq/2NM21kFMJT1l+ujFE5Y6/ufkuhZd6UYtK8sXyYk2CCllTJBrRfCMW23V5FJRBaQ
         Z2TQ==
X-Gm-Message-State: AOAM530rH5j8to0l7k+2hM27uY2igdHogqFQ719/wTs88zhnzJKPBSXa
        1jCa4vqu1fg9u2DoU7CHQuZYE2hEtGZnYXoC+9w=
X-Google-Smtp-Source: ABdhPJx/h9R0+oiwa6YZNLylbIIVmwTkg0ApqupNp6akgXvsLBljLGIzrmaLvjBE2+uZZsbI2NLqMT3FYw0tR/kwhy0=
X-Received: by 2002:a92:85c5:: with SMTP id f188mr2823212ilh.173.1605344389441;
 Sat, 14 Nov 2020 00:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com> <tencent_3801BEAE39670E174105E007@qq.com> <X6+SP0RGUUAL40ty@kroah.com>
In-Reply-To: <X6+SP0RGUUAL40ty@kroah.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sat, 14 Nov 2020 16:59:37 +0800
Message-ID: <CAAhV-H5uak2Txvj3-yZz5HJxiE8tUKyGEibVa8LkqJOYn2+ACQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Roman Kiryanov <rkir@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg,

On Sat, Nov 14, 2020 at 4:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 14, 2020 at 04:06:24PM +0800, 陈华才 wrote:
> > Hi, All,
> >
> > Goldfish RTC works well on MIPS, and QEMU RISC-V emulator use Goldfish
> > as well, so I think  we should keep it in kernel.
>
> And more importantly, if you rely on this, are you willing to maintain
> it?
I think it will break the booting of MIPS/RISCV QEMU virtual machines,
because RTC is an necessary device.

For the maintenance, I don't know whether Goldfish RTC depends on the
code under drivers/platform/goldfish. If not, I think I can maintain
it (I think other parts of Goldfish will be removed, I'm able to
maintain RTC but I'm not able to maintain the whole).

Huacai

>
> thanks,
>
> gre gk-h
