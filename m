Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7020BBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 23:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFZV4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 17:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgFZV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:56:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68364C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:56:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so10703797wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s24mstSCNQlTFolgjec0iiKMpvfLNvCEazKvZzeEqpA=;
        b=g+CAS8UlAQOOsv4s7ohlbFkbJmOpPZq5OC7QRzoSqEzhhgE34Acd5sfrAMN8Uu9C3O
         WjP+DC/W4+0jp5qX9LvxioOw4eodRT/6RRpQpqrwVQ3/k7qf0G9GOfAGstoLym1Coe0G
         Xph832bBIMuzUv0udF9hevqW5Jxiwdj/IOadY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s24mstSCNQlTFolgjec0iiKMpvfLNvCEazKvZzeEqpA=;
        b=ZGTvE0fwVM/HXWJllxb+9aAOXEPxDqj9y0V5fA6QYjxCBLEk2LwfhVZcpVTMUdcLM1
         Z9rCAfvwBoXVExX5UIntLfkngGcW4esgaWD6wfaHV0CwmlwKXdkeCWEc8HoDVfd8lYcU
         MJD0oyzl3eIuJAspeCKadfrg9VQum/+6rwLAJ+gJGjwK0ZuWBX7OmiW+QDMJNbKZHlzd
         FioxLr/HRq50DCxvlNuUk3hIVKPJX6uVRiFKLY/UZmiOTGWLsR2RONfxTVW3JTYNlIhW
         sWRa6uTok1ECXUiRgSWNC3YnnhjiOIPWcJVy2FetMbIBI9pFcsvgv3FmNxTRlSYwtYRj
         tNEA==
X-Gm-Message-State: AOAM532BYomoQAfIfe2waafqViW9EU/BTBK4V3oj25Us+BaDUb0+RJaR
        1ClM769KUznm9fbv40Jg5jKQpPGY6Z40X8hvLa4l
X-Google-Smtp-Source: ABdhPJxvUiPRna7ukmDfkDR7tOrY35okfuOqyyzB1yZ0cFFCHPw0NEqSkR/UuIDigPHl1bx2wJyIWsX7BstpN+VvZ3U=
X-Received: by 2002:a1c:9d09:: with SMTP id g9mr5333593wme.31.1593208583105;
 Fri, 26 Jun 2020 14:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200625234516.31406-1-atish.patra@wdc.com> <20200625234516.31406-2-atish.patra@wdc.com>
 <5e2ce2ae-5458-8579-576a-76721f7d3b08@gmx.de>
In-Reply-To: <5e2ce2ae-5458-8579-576a-76721f7d3b08@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 26 Jun 2020 14:56:11 -0700
Message-ID: <CAOnJCUKnB7kLdTh1-NaFNw4p6EammETzhUa-Uniq2rrC-7AaQg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] efi: Fix gcc error around __umoddi3 for 32 bit builds
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 7:43 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/26/20 1:45 AM, Atish Patra wrote:
> > 32bit gcc doesn't support modulo operation on 64 bit data. It results in
> > a __umoddi3 error while building EFI for 32 bit.
> >
> > Use bitwise operations instead of modulo operations to fix the issue.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  drivers/firmware/efi/libstub/alignedmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
> > index cc89c4d6196f..1de9878ddd3a 100644
> > --- a/drivers/firmware/efi/libstub/alignedmem.c
> > +++ b/drivers/firmware/efi/libstub/alignedmem.c
> > @@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
> >       *addr = ALIGN((unsigned long)alloc_addr, align);
> >
> >       if (slack > 0) {
> > -             int l = (alloc_addr % align) / EFI_PAGE_SIZE;
> > +             int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
>
> Here you rely on the compiler to silently convert the division by
> EFI_PAGE_SIZE into a right shift. Wouldn't it be cleaner to use
> EFI_PAGE_SHIFT to explicitly avoid a dependency on __udivdi3()?
>
> slack = (align >> EFI_PAGE_SHIFT) - 1;
> ...
> int l = (alloc_addr & (align - 1)) >> EFI_PAGE_SHIFT;
>

Sure. I will update it in the next version. Thanks for the suggestion.
> Best regards
>
> Heinrich
>
> >
> >               if (l) {
> >                       efi_bs_call(free_pages, alloc_addr, slack - l + 1);
> >
>


-- 
Regards,
Atish
