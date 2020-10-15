Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3145028F510
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgJOOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgJOOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:45:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC390C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:45:18 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j17so1576687ilr.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fI/o5S8juNGYXFdI5b1qwY0a7V7eY5Ml3ywLDameOjQ=;
        b=Lf/eU/22MxiEP6gKIgO6KHnpaQiOo4EQ85yhnHC4thfPT9Eg5niuG3h5HuDitvb/jQ
         2gh5f8uldxtDG69AGNGkheNuIAUOkDJLSEzZKzQg043MDnbK3laPWVdc+mmgrBz2sh6u
         tH/TqeidxlLCSKPJIufzCjzgZXTNXVLuMTZ0FP7Tmw+4FsH4+eGV/FdTm54LsCjtJRLW
         k6PCQ2IvOQaqx8IvB3dGselUo/FFX662wKSOMWLif02mVjV17SYrX30bpWHNWixYrhGe
         vOPiOIj0ByuzGMxyWlScR/IIr1zuuyaZ/tRscQPOAtrMYGy2EodZ6DGFMjWG2L6+XbbV
         0Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fI/o5S8juNGYXFdI5b1qwY0a7V7eY5Ml3ywLDameOjQ=;
        b=ZIhTXoDHIgeVJP9B7AnpXSN7EuKlxKnXl2VbzMRhihP7MNTlds6OPHq4cj7732Iiwd
         xpU+wTlUxzrXw2pnB3OdwAe0aVtuHgc3u93ByRbAOY3UOq/M9oudu77hq9W9NvXWCwkx
         kVgxv563zfevVYDB9dZkfxymP/H0Fbv1QKPk4Cx0xmY9/UJH/G/ddmzVeTd5eMj/IJZW
         2OB6ozMXWOyEu3soEcVd+lRk6dJSsjYx5iWDrkTto/QAGtv8VsGOYu8Oma14oS3XokYs
         rngI/2yKfS72UaEyyG/RFoLlKhdbJcOZhemiMTNQwO8kReddKG7gJ5P2U4KNN5NyNi2U
         oKOA==
X-Gm-Message-State: AOAM530wgsORnf0sy2iHDcXQ5MlbgLqfzUzn4l+8sHdtIxT+BehmFpyN
        d4w83S1e4x1B2I+tcFBW38I=
X-Google-Smtp-Source: ABdhPJxNeG5OHdDLh7lA+PmhMzkak2Vv/tuYzjj9ahUIkdTxQjmPWnyl8+TZQa0QZjOMdnlfpxqVAg==
X-Received: by 2002:a05:6e02:664:: with SMTP id l4mr3544032ilt.81.1602773118225;
        Thu, 15 Oct 2020 07:45:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v18sm2652622ilj.12.2020.10.15.07.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:45:17 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 15 Oct 2020 10:45:15 -0400
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
Message-ID: <20201015144515.GA572410@rani.riverdale.lan>
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
 <1653ace9164c4a3a8be50b3d2c9ff816@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1653ace9164c4a3a8be50b3d2c9ff816@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 08:50:05AM +0000, David Laight wrote:
> From: Arvind Sankar
> > Sent: 14 October 2020 22:27
> ...
> > +/*
> > + * This version is i.e. to prevent dead stores elimination on @ptr
> > + * where gcc and llvm may behave differently when otherwise using
> > + * normal barrier(): while gcc behavior gets along with a normal
> > + * barrier(), llvm needs an explicit input variable to be assumed
> > + * clobbered. The issue is as follows: while the inline asm might
> > + * access any memory it wants, the compiler could have fit all of
> > + * @ptr into memory registers instead, and since @ptr never escaped
> > + * from that, it proved that the inline asm wasn't touching any of
> > + * it. This version works well with both compilers, i.e. we're telling
> > + * the compiler that the inline asm absolutely may see the contents
> > + * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> > + */
> > +# define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
> 
> That comment doesn't actually match the asm statement.
> Although the asm statement probably has the desired effect.
> 
> The "r"(ptr) constraint only passes the address of the buffer
> into the asm - it doesn't say anything at all about the associated
> memory.
> 
> What the "r"(ptr) actually does is to force the address of the
> associated data to be taken.
> This means that on-stack space must actually be allocated.
> The "memory" clobber will then force the registers caching
> the variable be written out to stack.
> 

I think the comment is unclear now that you bring it up, but the problem
it actually addresses is not that the data is held in registers: in the
sha256_transform() case mentioned in the commit message, for example,
the data is in fact in memory even before this change (it's a 256-byte
array), and that together with the memory clobber is enough for gcc to
assume that the asm might use it. But with clang, if the address of that
data has never escaped -- in this case the data is a local variable
whose address was never passed out of the function -- the compiler
assumes that the asm cannot possibly depend on that memory, because it
has no way of getting its address.

Passing ptr to the inline asm tells clang that the asm knows the
address, and since it also has a memory clobber, that it may use the
data. This is somewhat suboptimal, since if the data was some small
structure that the compiler was just holding in registers originally,
forcing it out to memory is a bad thing to do.

> If you only want to force stores on a single data structure
> you actually want:
> #define barrier_data(ptr) asm volatile("" :: "m"(*ptr))
> although it would be best then to add an explicit size
> and associated cast.
> 

i.e. something like:
	static inline void barrier_data(void *ptr, size_t size)
	{
		asm volatile("" : "+m"(*(char (*)[size])ptr));
	}
plus some magic to disable the VLA warning, otherwise it causes a build
error.

But I think that might lead to even more subtle issues by dropping the
memory clobber. For example (and this is actually done in
sha256_transform() as well, though the zero'ing simply doesn't work with
any compiler, as it's missing the barrier_data()'s):

	unsigned long x, y;
	... do something secret with x/y ...
	x = y = 0;
	barrier_data(&x, sizeof(x));
	barrier_data(&y, sizeof(y));
	return;

Since x is not used after its barrier_data(), I think the compiler would
be within its rights to turn that into:

	xorl	%eax, %eax
	leaq	-16(%rbp), %rdx	// &x == -16(%rbp)
	movq	%eax, (%rdx)	// x = 0;
	// inline asm for barrier_data(&x, sizeof(x));
	movq	%eax, (%rdx)	// y = 0; (!)
	// inline asm for barrier_data(&y, sizeof(y));

which saves one instruction by putting y at the same location as x, once
x is dead.

With a memory clobber, the compiler has to keep x and y at different
addresses, since the first barrier_data() might have saved the address
of x.
