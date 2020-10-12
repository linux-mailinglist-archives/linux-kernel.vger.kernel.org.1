Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3E28C259
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgJLU3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgJLU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:29:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC87C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:29:37 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id s17so8961049qvr.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/bmJ0xS/t+paSfxBz6VHen1esJkSFeYNVD1TnMG3w+I=;
        b=rKpeglS+cpj0cL4bLQG4qjJD2EdoXxZrsjKeMWtx7dvIcEoiQzv/rIZg216uiA9WQ0
         7pzrRoDItnu7MHHjA3KixwliSEdhKdxiaSMH6kjaM07yqkjVfBGHGDd0ValdgMFEsrpl
         3a7Bodt9PDW7bfc/9T3IVMYMPTXODxf8HNe4pvqp3W5MVGMJ6MwGO8ETKfE/LJwkI6s6
         Kt2AJpnUGtUxFaFCNNVxjXz43NYVE8h8cXibfKLRfysaTlT8Sdix0RuX2jOaFcZBpesk
         GyVKnGa3ZL5dNpciyVpn8/cvcVTFVzwPF2FY8eAImXAFmB8TGZeCeurNSWNAkntbkyE2
         XuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/bmJ0xS/t+paSfxBz6VHen1esJkSFeYNVD1TnMG3w+I=;
        b=fvtgbq1BB2QA6fAhQcqT8MADAOam2EbdC925pC0L6Zc3XhOrNr6TmKRWvdZOn9RdiR
         Qn/KMXr4GYwhk1F7Do8YTxvba9HlXmOYpFyArHzQFnHP4oCuWWMElTXF3J0f62BMVPd8
         2taSAugNjSmL8+AlNwH9+Kl4iQgDD3v0foo9XYmJXUSMrGFO0C8pTrxJoLQWLuXZ9gNc
         Q71J11UIvWT5rshUQUjhftcRruRgsZLjrGFZssV03XSj9aE6yc4ru9XtAppRC2zMXMDQ
         XuvW//oGzqXOFqwO99IeRoDTFLBe4HC4EwWE+z7U8fOsGNBNyUBVWKqimUvMKZc62kcO
         2H8g==
X-Gm-Message-State: AOAM530yOBWCp2RcCSEMonLLbu74ykXXzAt3we8sx3o5KTcvdR31570w
        nTV6g5oIdwP4XuHSvAdEfWk=
X-Google-Smtp-Source: ABdhPJwY19w/9W1PqSbaafYH8/UDp/yMeo6P+cwc7yrl4WnYHsbghRE48dsMtMYj2Pg6WsonaNrzPg==
X-Received: by 2002:ad4:59cf:: with SMTP id el15mr13217971qvb.17.1602534576720;
        Mon, 12 Oct 2020 13:29:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h68sm13493307qkf.30.2020.10.12.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:29:36 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 12 Oct 2020 16:29:34 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
Message-ID: <20201012202934.GB818459@rani.riverdale.lan>
References: <20201012110557.GK25311@zn.tnic>
 <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
 <20201012185547.GK22829@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012185547.GK22829@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:55:47PM +0200, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 08:41:32PM +0200, Uros Bizjak wrote:
> > On Mon, Oct 12, 2020 at 8:11 PM Linus Torvalds <
> > torvalds@linux-foundation.org> wrote:
> > 
> > > On Mon, Oct 12, 2020 at 4:06 AM Borislav Petkov <bp@suse.de> wrote:
> > > >
> > > > * Use XORL instead of XORQ to avoid a REX prefix and save some bytes in
> > > > the .fixup section, by Uros Bizjak.
> > >
> > > I think this one is actually buggy.
> > >
> > > For the 1-byte case, it does this:
> > >
> > >      __get_user_asm(x_u8__, ptr, retval, "b", "=q");
> > >
> > > and ends up doing "xorl" on a register that we told the compiler is a
> > > byte register (with that "=q")
> > >
> > > Yes, it uses "%k[output]" to turn that byte register into the word
> > > version of the register, but there's no fundamental reason why the
> > > register might not be something like "%ah".
> > >
> > 
> > GCC does not distinguish between %ah and %al and it is not possible to pass
> > "%ah" to the assembly. To access the high part of the %ax register, %h
> > modifier has to be used in the assembly template.
> 
> Btw, did those get documented in the meantime? I can find them only in
> gcc sources:
> 
>    k --  likewise, print the SImode name of the register.
>    h -- print the QImode name for a "high" register, either ah, bh, ch or dh.

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers

