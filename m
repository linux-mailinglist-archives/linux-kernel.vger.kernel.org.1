Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1C29E13C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgJ2Byc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgJ1V4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:56:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i26so625001pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKOyADoqO6XIKYtGo2tqwiIgySeXkjkWzT3F1YeXlI4=;
        b=vDZBjydJkf4Rf8qIX6yKI8rB5ujqYRh+pfZySOBSTFI4IFr9te3yOYB5YQDJvdvoBM
         I52fqrZbRgVhscQ9pi18seqxn+486OkVYAk179gK3aweg8oDKMuS9UU+vZ646u2xqBiu
         yPo+c6RuW0wZrOU4+n1LwLtxXFGOKXlUEAsT+spqt7uO5gILkD+I345rNGiUg1HXJfdH
         FynRciGqWJCOqEngoci+UK+0Pb5GPqhLuz6VxpwGtT2L3qFV4mJtg1f3waxRHuLibq+9
         UtQNj7zUWdYNemGo534SV4Eh/fufHbboaI57NWD4josoQWfQIlvPeW8KEtg0UoParREL
         UOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nKOyADoqO6XIKYtGo2tqwiIgySeXkjkWzT3F1YeXlI4=;
        b=nr8eeg2dxHh5kRznVDA/w15xQht9gg4stDeyYa4Kjg962YYB6LmxclPZCohdJNy2cN
         xYtAYJ1YMl0lUlMsyN4goAX97HNX9BX7kNnx0ElPBY1f5TezAYkLKGl380Wb7Svh8RGp
         YD57JIKNqj6++vhB9QgdPk7YtHbzLKdicntsoJCmfVBnF9KQZcvsQRXkc540Pgn2n6t0
         IFYXPvzJLqXiilJjiMugOQ3IG3Zm95lvNom97oaNQ7pp7B7a8yTVplcX2xzBdJV+iQ1D
         1ITRpWOYNtSYQy/BjUVHu99xgOobndPVDDts2zw+H7XQscDlI7riqtIDS4mQkSZfiFQB
         if3A==
X-Gm-Message-State: AOAM532tkmrdh6oyYlMHtE+kE8OW/DvUvmXpM9oGEOnQX9DmheAoYK7a
        S8zjJ6dSfcTfcFiqYtu+xmureN+u6wLGyw==
X-Google-Smtp-Source: ABdhPJxhz6ed3Lwt0YgD7jgiTgZE2GoBtk2tym3ijKfh50K2zs0+xfRt9wDgu0KuJHirur3TudIFGw==
X-Received: by 2002:a92:c7c7:: with SMTP id g7mr668651ilk.303.1603917951821;
        Wed, 28 Oct 2020 13:45:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p66sm491399ilb.48.2020.10.28.13.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:45:51 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 28 Oct 2020 16:45:49 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201028204549.GA2231038@rani.riverdale.lan>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
 <20201027200803.GL15580@zn.tnic>
 <20201027211422.GC1833548@rani.riverdale.lan>
 <20201028133909.GA27112@zn.tnic>
 <20201028164551.GA1989568@rani.riverdale.lan>
 <20201028194355.GB27112@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028194355.GB27112@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 08:43:55PM +0100, Borislav Petkov wrote:
> On Wed, Oct 28, 2020 at 12:45:51PM -0400, Arvind Sankar wrote:
> > You don't want to try to run the kernel from physical address 0 in any
> > case. The default is set to 16MiB to avoid low memory, historically to
> > avoid the 24-bit ISA DMA range.
> 
> Sure, that's why I wrote:
> 
> "... so I guess this should be a range > 0 specification but I guess not
> important."
> 
> So how about a sentence or two alluding to that fact in the help text of
> that option?

It's mentioned in the commit message for ceefccc93932, but yeah, it
would be useful to have in the help text I guess. But that's not really
related to this patch.

> 
> > This doesn't matter for the 64-bit kernel, which can be run from any
> > physical address independent of the RELOCATABLE/PHYSICAL_START settings.
> > It only matters on 32-bit, where VA and PA are tied together by
> > 	VA == __PAGE_OFFSET + PA
> 
> You mean the kernel text mapping I assume because we do
> 
> #define __va(x)                 ((void *)((unsigned long)(x)+PAGE_OFFSET))
> 
> on 64-bit too but that's the direct mapping of all physical memory.

Yes, I meant the virtual addresses of the kernel symbols: the 32-bit
kernel needs relocation processing to be loaded at a different physical
address, but the 64-bit kernel doesn't unless the virtual address is
also being changed.

> 
> > KERNEL_IMAGE_SIZE is _not_ the size of the kernel image, the name is
> > misleading.
> 
> So that needs fixing too, I guess.

It's become ABI I think: looks like it's included by that name in
vmcoreinfo for kexec crash dumps.

> 
> > It is the maximum VA that the kernel can occupy, it is used
> > to prepopulate the PMD-level pagetable for initial boot (level2_kernel_pgt)
> > and is also used to define MODULES_VADDR, so it _is_ talking about
> > mappings. If you have a 30MiB kernel that is placed at a starting VA of
> > 510MiB when KERNEL_IMAGE_SIZE is 512MiB, it won't boot.
> 
> ... because not the whole kernel will be mapped, sure. There's a comment
> above KERNEL_IMAGE_SIZE which could use some of that explanation.

Hm, it also looks like KERNEL_IMAGE_SIZE is entirely unused on 32-bit
except for this linker script check and for KASLR. I'll do a v2 cleaning
up those comments.

> 
> > Increasing vmlinux size can trigger the problem by pushing _end
> > beyond KERNEL_IMAGE_SIZE, but the problem occurs once _end -
> > __START_KERNEL_map exceeds KERNEL_IMAGE_SIZE, not when _end - _text
> > exceeds it, hence this patch.
> 
> Understood - in both cases, once _end goes beyond the 512MiB end of the
> PMD mapping, we've lost. Please add that part to the commit message too
> because we will forget.
> 

That's what this bit in the commit message was trying to explain:
  The check uses (_end - _text), but this is not enough. The initial PMD
  used in startup_64() (level2_kernel_pgt) can only map upto
  KERNEL_IMAGE_SIZE from __START_KERNEL_map, not from _text.
