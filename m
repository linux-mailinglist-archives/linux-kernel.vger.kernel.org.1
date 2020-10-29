Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E129ED09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgJ2NgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgJ2NgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:36:11 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602062087E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603978570;
        bh=IhR3DmS+TZFpEiDkNsRmgsp+IEHMhN3+bzXx9omzx9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YMyXrxe1WtVV8tjgeLyeSLPArUsrTL2qopihARvFEIkv3UZVOsSpLREKASe4Wdd9X
         Ovu4KQosYZGDbOOLQ0zfb/0UeVm++ypZ/pqGBxQkAIrJXpR/N3mfyuLur37CGdCYju
         b8ri02vas+QKo45iDQ5hlV3csuc13qHjpghCECGQ=
Received: by mail-qt1-f170.google.com with SMTP id m14so1772920qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:36:10 -0700 (PDT)
X-Gm-Message-State: AOAM532sLot88WESlz3VQv39v/uD5zkLpzWK8bc++xat33dUSmRscf/x
        in0aUjapMQJs2ujtBWBxCbesXNaW95x8dd3QfYo=
X-Google-Smtp-Source: ABdhPJyllJWRoRHUbmSi+EHUwklSFogJ3xnSp99foXZgNRCVuhlkRPXhAHN029mfek4WeiyfTUzhe2lY91yrRuN2OWc=
X-Received: by 2002:ac8:7955:: with SMTP id r21mr3553963qtt.204.1603978569360;
 Thu, 29 Oct 2020 06:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160342.3705327-1-arnd@kernel.org> <20201026160342.3705327-2-arnd@kernel.org>
 <20201026165543.GA42952@C02TD0UTHF1T.local>
In-Reply-To: <20201026165543.GA42952@C02TD0UTHF1T.local>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 29 Oct 2020 14:35:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2W-BcRyxx7+JXr+MCBLSuLzLdEDzM8LMk5y1rjaEuXbw@mail.gmail.com>
Message-ID: <CAK8P3a2W-BcRyxx7+JXr+MCBLSuLzLdEDzM8LMk5y1rjaEuXbw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: hide more compat_vdso code
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 5:55 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 26, 2020 at 05:03:29PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When CONFIG_COMPAT_VDSO is disabled, we get a warning
> > about a potential out-of-bounds access:
> >
> > arch/arm64/kernel/vdso.c: In function 'aarch32_vdso_mremap':
> > arch/arm64/kernel/vdso.c:86:37: warning: array subscript 1 is above array bounds of 'struct vdso_abi_info[1]' [-Warray-bounds]
> >    86 |  unsigned long vdso_size = vdso_info[abi].vdso_code_end -
> >       |                            ~~~~~~~~~^~~~~
> >
> > This is all in dead code however that the compiler is unable to
> > eliminate by itself.
> >
> > Change the array to individual local variables that can be
> > dropped in dead code elimination to let the compiler understand
> > this better.
> >
> > Fixes: 0cbc2659123e ("arm64: vdso32: Remove a bunch of #ifdef CONFIG_COMPAT_VDSO guards")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This looks like a nice cleanup to me! I agree we don't need the array
> here.
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

I see the patch now conflicts with "mm: forbid splitting special mappings"
in -mm, by Dmitry Safonov. I have rebased my patch on top, should
I send it to Andrew for inclusion in -mm then?

      Arnd
