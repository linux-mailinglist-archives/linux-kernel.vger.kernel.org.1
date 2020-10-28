Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0FC29D444
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgJ1Vur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgJ1Vuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:50:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C655C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:50:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l2so494283qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UmdsUTh3B9YwBmIyRk8PHKy+xdS4Bu60NprWzgHMHHA=;
        b=qjVuFgKj9zWsRxvsKEVSihx5n/yAdbp8OnbLa4TE04FvO3iYWLYq/tNQ85l9qCkQbi
         uRSw8paRf6SA4WsvIUHd2wq6UOoDmahP722uMotiK/zipWXxx2KEoKOho5Snoqdx3ozC
         T3VYvx7m+MTaXCxc+fNobOPRPnPCZHN7UzDomGuXEUg3YwI6TinUY62sZBdSBe3MI9kp
         XWIJwmsbj7tTJ5KZpRpkhNXAzNGmyprVCqihIP4a3mPl8m2APyF1JQrIZsfu8PHLShhS
         osrvE21ERtv5h6BQYoZcZHrLk0qDpc4lRtEpXUsNO8uzUKWazVXsxZxH+xCvHiejHrAF
         DdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UmdsUTh3B9YwBmIyRk8PHKy+xdS4Bu60NprWzgHMHHA=;
        b=eGkewA2EWJTqO3+9PUfNa8l1lVhQXUM93qmzTDXvb98qxq0jcrHqxM2/hCcjJqrpCe
         ocbaOUXPKfGC7HFPMjws/tEXnBk8gEvKeu6LHE59G+C40lODJ783zDYDBdsuhkQZzJJF
         qKrypAfXCnRMT6rVnFuvrgvZ38xII94GRhl5VHygyvpoegf6DXSlRrA7XIkZOETb+0EC
         m9xtDQDAAnMXPDGetVqCR8q8e2+GLxFbrwG9UeuL0/50BHTNU2zQG1M+m3MuUg/kLAO7
         D/bLAbFcI+Q0SsxfII7LWK2U+L6J1P+IQ/EAe5mVqjFpzSTmUts9JmUUKpM8/9KzC0na
         4FAw==
X-Gm-Message-State: AOAM533wgmpvMVnYrjpl1xS8h7fYla9K7uHiJ06jg+yz/1uEpULSJQZ4
        EKRNPZSqtME/iwrpIgkJUakr0WqLdgsmUQ==
X-Google-Smtp-Source: ABdhPJyUSI4BD7MozZPTcQSlqo0UBBLrHZ6NGqwy4GLOZuJWHi+Ja2eeJ7GYHfBit5Ia1WFJd7Jrng==
X-Received: by 2002:ac8:76c7:: with SMTP id q7mr7980077qtr.39.1603903554700;
        Wed, 28 Oct 2020 09:45:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e1sm3222646qkm.35.2020.10.28.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 09:45:53 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 28 Oct 2020 12:45:51 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201028164551.GA1989568@rani.riverdale.lan>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
 <20201027200803.GL15580@zn.tnic>
 <20201027211422.GC1833548@rani.riverdale.lan>
 <20201028133909.GA27112@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028133909.GA27112@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:39:09PM +0100, Borislav Petkov wrote:
> On Tue, Oct 27, 2020 at 05:14:22PM -0400, Arvind Sankar wrote:
> > This is indeed just a small correctness fixlet, but I'm not following
> > the rest of your comments.
> 
> I'm just trying to make sense of that house of cards we have here.
> 
> > PHYSICAL_START has an effect independent of the setting of
> > RELOCATABLE.
> 
> Theoretically you can set PHYSICAL_START to 0x0:
> 
> config PHYSICAL_START
>         hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
>         default "0x1000000"
>         help
>           This gives the physical address where the kernel is loaded.
> 
>           If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
>           bzImage will decompress itself to above physical address and
>           run from there.
> 	  ^^^^^^^^^^^^^^
> 
> and disable RELOCATABLE:
> 
> CONFIG_PHYSICAL_START=0x0
> # CONFIG_RELOCATABLE is not set
> 
> but then you hit this:
> 
> ld: per-CPU data too large - increase CONFIG_PHYSICAL_START
> 
> full output at the end of the mail.

You don't want to try to run the kernel from physical address 0 in any
case. The default is set to 16MiB to avoid low memory, historically to
avoid the 24-bit ISA DMA range.

> > That said, AFAICT, RELOCATABLE and PHYSICAL_START look like historical
> > artifacts at this point: RELOCATABLE should be completely irrelevant for
> > the 64-bit kernel, and there's really no reason to be able to configure
> > the start VA of the kernel, that should just be constant independent of
> > PHYSICAL_START.
> 
> See the CONFIG_PHYSICAL_START help text. Apparently there has been a
> use case where one can set PHYSICAL_START to the region where a kdump
> kernel is going to be loaded and that kdump kernel is a vmlinux and not
> a bzImage and thus not relocatable.

This doesn't matter for the 64-bit kernel, which can be run from any
physical address independent of the RELOCATABLE/PHYSICAL_START settings.
It only matters on 32-bit, where VA and PA are tied together by
	VA == __PAGE_OFFSET + PA
On 64-bit, the kernel's location in VA space and physical space can be
independently moved around, so a kernel that starts at 16MiB in VA space
can be loaded anywhere above 16MiB in physical space.

> 
> Going back to the question at hand, if you think about it, the kernel
> image *is* between _text or _stext and _end. And KERNEL_IMAGE_SIZE is
> exactly what it is - the size of the kernel image.
> 
> Now, if you were talking about a kernel *mapping* size, then I'd
> understand but this check is for the kernel *image* size.
> 

KERNEL_IMAGE_SIZE is _not_ the size of the kernel image, the name is
misleading. It is the maximum VA that the kernel can occupy, it is used
to prepopulate the PMD-level pagetable for initial boot (level2_kernel_pgt)
and is also used to define MODULES_VADDR, so it _is_ talking about
mappings. If you have a 30MiB kernel that is placed at a starting VA of
510MiB when KERNEL_IMAGE_SIZE is 512MiB, it won't boot.

> But reading that commit message again:
> 
>     these build-time and link-time checks would have prevented the
>     vmlinux size regression.
> 
> this *is* talking about vmlinux size and that starts at _text...
> 

Increasing vmlinux size can trigger the problem by pushing _end beyond
KERNEL_IMAGE_SIZE, but the problem occurs once _end - __START_KERNEL_map
exceeds KERNEL_IMAGE_SIZE, not when _end - _text exceeds it, hence this
patch.
