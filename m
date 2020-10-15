Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5E28F5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbgJOPjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbgJOPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:39:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E793C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:39:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so5107154ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Slk8cn+BfeWlfZ9E0ny1/5HWw7JqKVPgKKusuTz/J0=;
        b=L9Jw0LEZoaO1GHN/Hn10A6u8/a+1uXuPpuX7GqIK2/f2F6cg17oWeVEJKRZWw79YXC
         ZV2fiXWEmLB9zeb/NftA3OFkQdq9bQq7qo2OH0dYMvEOtob02qk6MGChr36R8jM8JtW4
         1UHQeglKub5/6se9zTdIKPB7VmEVsg0PnYJf2z7boe6Kmotco1XTNey9pd//9f7HIU1N
         lreBFrTTpGrVtkr7xPnibLqTklQFq9NCtZaRJc+lV3ijgAr6JtZ7TM/iekhE//+1leO9
         UIOGy/X+3ooU6KvqXhO6eMEaOn1VzdtteGVcJbeHl2dx9vLv3QznY8OcJI6qZIy35Tod
         9h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4Slk8cn+BfeWlfZ9E0ny1/5HWw7JqKVPgKKusuTz/J0=;
        b=rDIegvO+c4LvPDU+BIYP2CS6loyUPgOuE3EjnF3jz51FHo4Ca1u7xNDLweJDGMOdGs
         0FbVjjV48i4T1W7UrbA6MxgRg/WfbGG9qfgFxW1Ke09xQA202Hmgga8G1Q7DXekmJ6Jj
         dcvrA2iCDnnUIwGKO+Wi9c6g139VU3K8s0SLw/HDu+ihcCfLvqKZiM4ckrCdBfTVAUCM
         XN/BNTpIXwa1CsaooYq498p32lVBO2UPxTD2D+w1ZdWBD5ndbGAwyuT+SV+edlUqEy5H
         xU7SFIrhdNIyyuLF+zMEVgc8OTRUTFNWaaZWzXupa7/FFv+c1LOQxwNx68RKw3DUNeHX
         0zCg==
X-Gm-Message-State: AOAM53244qJ5hMB7HH2aiv4AqNSnwG0bRKK3BglfW7pPDj6yWtyl0TxZ
        nSKudICqI/oiNYpZ+0p1ifM=
X-Google-Smtp-Source: ABdhPJw9u0d4xDP12jxoJV7DAuWZd9xp4VO/+BkQEWCIIWbXTd1q7uFMd8DWJfg7sOWQKSBspPyG9g==
X-Received: by 2002:a02:a802:: with SMTP id f2mr4080270jaj.47.1602776343776;
        Thu, 15 Oct 2020 08:39:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e11sm2886026ioq.48.2020.10.15.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 08:39:03 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 15 Oct 2020 11:39:01 -0400
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
Message-ID: <20201015153901.GA593731@rani.riverdale.lan>
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
 <1653ace9164c4a3a8be50b3d2c9ff816@AcuMS.aculab.com>
 <20201015144515.GA572410@rani.riverdale.lan>
 <4a8c47b5eeb44b789abbb617f0a95993@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a8c47b5eeb44b789abbb617f0a95993@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 03:24:09PM +0000, David Laight wrote:
> > I think the comment is unclear now that you bring it up, but the problem
> > it actually addresses is not that the data is held in registers: in the
> > sha256_transform() case mentioned in the commit message, for example,
> > the data is in fact in memory even before this change (it's a 256-byte
> > array), and that together with the memory clobber is enough for gcc to
> > assume that the asm might use it. But with clang, if the address of that
> > data has never escaped -- in this case the data is a local variable
> > whose address was never passed out of the function -- the compiler
> > assumes that the asm cannot possibly depend on that memory, because it
> > has no way of getting its address.
> 
> Ok, slightly different from what i thought.
> But the current comment is just wrong.

Should I fix up the comment in the same commit, or do a second one after
moving the macro?

> > i.e. something like:
> > 	static inline void barrier_data(void *ptr, size_t size)
> > 	{
> > 		asm volatile("" : "+m"(*(char (*)[size])ptr));
> 
> I think it has to be a struct with an array member?

I don't think so, this is actually an example in gcc's documentation:

  An x86 example where the string memory argument is of unknown length.

	asm("repne scasb"
	: "=c" (count), "+D" (p)
        : "m" (*(const char (*)[]) p), "0" (-1), "a" (0));

  If you know the above will only be reading a ten byte array then you
  could instead use a memory input like: "m" (*(const char (*)[10]) p).

> 
> > 	}
> > plus some magic to disable the VLA warning, otherwise it causes a build
> > error.
> 
> It shouldn't if the size is a compile time constant.
> And given this is an instruction to the compiler it better be.

Ah right. I saw the warning when playing with something else where size
could be constant or variable depending on the call.

> > 
> > With a memory clobber, the compiler has to keep x and y at different
> > addresses, since the first barrier_data() might have saved the address
> > of x.
> 
> Maybe "+m"(*ptr) : "r"(ptr) would work.

Nothing that can only modify what ptr points to could avoid this, since
that storage is dead after the barrier.

> OTOH a "memory" clobber at the bottom of a function isn't going to
> cause bloat.
> 
> The explicit ranged memory access (without "memory") probably has its
> uses - but only if the full "memory" clobber causes grief.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
