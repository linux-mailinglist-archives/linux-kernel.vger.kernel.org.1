Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9D28663F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgJGRv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgJGRv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:51:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06566C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 10:51:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dt13so4203575ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPzK5wBGWXJ9ijQIa+MDEBmpqmiIgIO3bGZX4u/BEvA=;
        b=nJPlU34scXnjiguAFIm85t6n6hLkeHlGL7e06cFqc/xH6ug3oqr+c8thc4+lGHQ5fx
         lKeD7w/D2ioAqMwoDiwBD6S4hyshsY7Twe954sIGgO+/iQ0Mi/yPzn2W4I5yqilFTvtK
         v9c+EwouCRUoiD+AZDe+4a3vKd1upWDLYjNF/fAW6OpsCdzuxZHuiXYAcdXLN9wLKiGW
         CtnwYPgmru3RPJjTBUtiUqhEAteIsddfm3Bo5/m/f3kTOoxnPIhg9+f655c+DlQJctrk
         Te6UIWNqPBU/Lkg3oAYqY7CnP3BgTBbc1fXBLLvERFPXRemYRj95PRMVSvby7tJuuAzE
         Jqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPzK5wBGWXJ9ijQIa+MDEBmpqmiIgIO3bGZX4u/BEvA=;
        b=VNZ/9dcb8rjHYl+7DpEmFdcyFPMBUBSjU5S1wlgYNiYHrMRF4Glau14lPVqd96Ilr1
         xqTJyQiadKAw3Tk4VszjjH3xdncpDah4v4SLRsaOdXB/X4dFaEUQ9zK46O+Q3VIUHaGm
         kXtMi5dPfloUh5EDS9/SJey3rbMpF2y0gP61P+Ewl/CUZ1du1Nn06BgwNB03CGQdHx4I
         SZG9sDlPsjqJSmBa7QZKKes33uy7A+LguxE2LVu2lCzpTbgdipeKKZmbYVH1UyKcKgzP
         eoBu7+hlE4N17YsThTLxhBa1qfWZZBIPQvZ4vBGKRNOfsJdJhOmbBesXv8F75m3xsFFh
         f/ZA==
X-Gm-Message-State: AOAM530OPdEPevKP2NzJk1RvU59tv9bZoCuTXl7yK/NfibYaGyeUnSAQ
        Rk4kq19T+0xcjU3/EWvHM/y/Mkv/JsMksrLITDwNlQ==
X-Google-Smtp-Source: ABdhPJwXVJmp1Qp9M+2Fs5BW+I60lTtmt2Do0xLP53x9QM8x+a2tn+YyAAHGWKgvuYFp3ZpcVKtis4+aGvbyHP17gYk=
X-Received: by 2002:a17:906:4306:: with SMTP id j6mr4716173ejm.523.1602093115565;
 Wed, 07 Oct 2020 10:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <160197822988.7002.13716982099938468868.tip-bot2@tip-bot2>
 <20201007111447.GA23257@zn.tnic> <20201007164536.GJ5607@zn.tnic>
In-Reply-To: <20201007164536.GJ5607@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Oct 2020 10:51:42 -0700
Message-ID: <CAPcyv4hYEbFxtRYD+nPOhbLEPTHs3JVDAtWr8Y+-hfdwPY1v1w@mail.gmail.com>
Subject: Re: [tip: ras/core] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        stable <stable@vger.kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add kbuild robot so they can add this check to their reports ]

On Wed, Oct 7, 2020 at 9:47 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 07, 2020 at 01:14:47PM +0200, Borislav Petkov wrote:
> > On Tue, Oct 06, 2020 at 09:57:09AM -0000, tip-bot2 for Dan Williams wrote:
> > > +   /* Copy successful. Return zero */
> > > +.L_done_memcpy_trap:
> > > +   xorl %eax, %eax
> > > +.L_done:
> > > +   ret
> > > +SYM_FUNC_END(copy_mc_fragile)
> > > +EXPORT_SYMBOL_GPL(copy_mc_fragile)
> >
> > That export together with CONFIG_MODVERSIONS causes
> >
> > WARNING: modpost: EXPORT symbol "copy_mc_fragile" [vmlinux] version generation failed, symbol will not be versioned.
> >
> > here.
> >
> > I don't see why tho...
>
> It doesn't look like it is toolchain-specific and in both cases,
> copy_mc_fragile's checksum is 0.
>
> SUSE Leap 15.1:
>
> Name           : binutils
> Version        : 2.32-lp151.3.6.1
>
> $ grep -E "(copy_mc_fragile|copy_user_generic_unrolled)" Module.symvers
> 0x00000000      copy_mc_fragile vmlinux EXPORT_SYMBOL_GPL
> 0xecdcabd2      copy_user_generic_unrolled      vmlinux EXPORT_SYMBOL
>
> debian testing:
>
> Package: binutils
> Version: 2.35-2
>
> $ grep -E "(copy_mc_fragile|copy_user_generic_unrolled)" Module.symvers
> 0x00000000      copy_mc_fragile vmlinux EXPORT_SYMBOL_GPL
> 0xecdcabd2      copy_user_generic_unrolled      vmlinux EXPORT_SYMBOL

Yes, I'm seeing this too on Fedora, I'll take a look.
