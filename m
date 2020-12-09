Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CED2D4877
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgLIR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgLIR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:59:12 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 09:58:32 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so4356453lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJaVhTpiMPaliRW1BsTVPR0HUZ5LPD9/lyKWp6voxZY=;
        b=W3TAZiMxgQtdmGJSBJFklYY9V2kwPDqdPrz6VB+jV0dmuZj2xY806aorny+f833fr0
         b8e17lxLA8lqeWSjVicsm8ZauNAfVbS1JSChtiKvqoRliqknYvhRrkhxg/15OsDnB8Ae
         F7O6VFdwmN7mFS6k9yL922iGj3GMtLKU5aDW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJaVhTpiMPaliRW1BsTVPR0HUZ5LPD9/lyKWp6voxZY=;
        b=MruqyttjjlYhAW/oiQ3qO8nTHBnpEIXaHbcMlOCSsrTyn2NHQxBVQ00XVJc96PUNox
         girE5mnLhi4fsdJH3fGqcNo8yHRp8oyv1z2Jj+Ce4WiGLzM57zaxmIYUBlp8OldCBH5p
         oMdEaLrQOmigREW+jGoggER1iX+tgDHXIS3Z5ba1PWy+E+1YLl29YrTHBZuUk5crjla0
         EWVA5j6GZvKfe0+6Pbhm6CMk3UaYycBgOteV2RCb/Nt7nB24iJcS7j5NFWMa4jZould/
         +EqRTyeRHiN0NqIXitbPEfFkpCBIe2Dui161fDX3JtYYKUNWbrWnRHg4ORNFCnoNT3XN
         gIHg==
X-Gm-Message-State: AOAM533+QU+IIf9akZoguPM65QCN3h+/GTCyBw6BOLwynMI26B5vNhza
        1kCuZZDJ6Afuf/OydPwN4bG8sdu834asvg==
X-Google-Smtp-Source: ABdhPJywQQVfQN7R9x6MqZGIfSNY3xfPhKgka1JXlWkxQ3iLip81ftpcnh+iYusVheMWqo253+xXfg==
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr1297886lfm.300.1607536710496;
        Wed, 09 Dec 2020 09:58:30 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w204sm242736lff.241.2020.12.09.09.58.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 09:58:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id y16so3473163ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:58:29 -0800 (PST)
X-Received: by 2002:a2e:5750:: with SMTP id r16mr1446782ljd.61.1607536708800;
 Wed, 09 Dec 2020 09:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-1-will@kernel.org> <20201209163950.8494-2-will@kernel.org>
In-Reply-To: <20201209163950.8494-2-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 09:58:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
Message-ID: <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 8:40 AM Will Deacon <will@kernel.org> wrote:
>
> @@ -3978,8 +3994,17 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
>
>         /* check if the page fault is solved */
>         vmf->pte -= (vmf->address >> PAGE_SHIFT) - (address >> PAGE_SHIFT);
> -       if (!pte_none(*vmf->pte))
> -               ret = VM_FAULT_NOPAGE;
> +       if (pte_none(*vmf->pte))
> +               goto out_unlock;
> +
> +       if (vmf->flags & FAULT_FLAG_PREFAULT_OLD) {
> +               pte_t pte = pte_mkyoung(*vmf->pte);
> +               if (ptep_set_access_flags(vmf->vma, address, vmf->pte, pte, 0))
> +                       update_mmu_cache(vmf->vma, address, vmf->pte);
> +       }

Oh, please dear God no.

First you incorrectly set it old, and then you conditionally make it
young again and as a result force an atomic rwm update and another TLB
flush for no good reason.

Just make sure that the FAULT_FLAG_PREFAULT_OLD never sets the
*actual* address to old.

And yes, that probably means that you need to change "alloc_set_pte()"
to actually pass in the real address, and leave "vmf->address" alone -
so that it can know which ones are prefaulted and which one is real,
but that sounds like a good idea anyway.

Then you can just make alloc_set_pte() do the right thing in the first
place, instead of doing this nasty "lets do it wrong and fix it up
later" horror.

                Linus
