Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF972DF194
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 21:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgLSUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 15:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgLSUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 15:40:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDEC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 12:39:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o17so14426674lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6WEkkm6ItmYR5Nc7WLcGl8iPUHvmHopSYUb1uCJQT0=;
        b=OyMepeYRv3SqqZn1639l0dapTnd3++utPvIHPn/lAKEKQz8ez3nMhl3LxHjUrjCAch
         bIwOnC79LDNLzECuWXDHNLtLFoZNVW9RT1K4iYWHcjnyQjwDShXfShciNOARkm4QAzWd
         rztJriJMwLJToBCHJ5xgY++4IZUL1rg5qu4qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6WEkkm6ItmYR5Nc7WLcGl8iPUHvmHopSYUb1uCJQT0=;
        b=fYGMCFdIdjxFp4fQfW2Pl4aRE4p8VpJMTOvaXB+JR9QBa3yfPs7meAkf7661M4B2un
         NIQZfdb2LV10J3mgIUiNi1QwiR4A0D6zdHdbTurvsonRKJ/j6PSsy5clswSh0BDPX0aM
         w08pvJlKjUcs2a3JEugG2gsq5J69eHPHr9SHS1W8UCD6ACe+njziALLc4Dn4W08CnPqJ
         l0LUjvz+t6MeTq6Xb2+8JXhd5MGudy9uTkPnUseN2qY9BbAsjLocMZ7yXK0oMj5c0+nN
         YjNyV5rw6tXmpmObXafNHegw7eVUnWHKBiMxWUsS5cxCJNSdMMT+CJX3UxyWOpQveLEN
         1Usw==
X-Gm-Message-State: AOAM533eiGa2e27iZMkVA4DJs/CH1BVJ2xNevJXHdQ6wZQ+kQjEXHTWP
        5FWffN0f2g2sTkI+JtZpcToHR/1cBsr4Dg==
X-Google-Smtp-Source: ABdhPJyjkZfpgZOwIHQpw/SPP/bzOKHOp78sEzIULxWz4wxYMJltJnQmRn1HR1f2eVkW6b5XCPVg3w==
X-Received: by 2002:a19:42c2:: with SMTP id p185mr1832061lfa.423.1608410393568;
        Sat, 19 Dec 2020 12:39:53 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j7sm1407537lfg.114.2020.12.19.12.39.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 12:39:53 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l11so14475468lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 12:39:53 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr4369075ljc.411.1608410073306;
 Sat, 19 Dec 2020 12:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
 <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box> <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box> <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
 <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box>
In-Reply-To: <20201219124103.w6isern3ywc7xbur@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Dec 2020 12:34:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
Message-ID: <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 4:41 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> @@ -2884,19 +2966,18 @@ void filemap_map_pages(struct vm_fault *vmf,
>                 if (vmf->pte)
>                         vmf->pte += xas.xa_index - last_pgoff;
>                 last_pgoff = xas.xa_index;
> -               if (alloc_set_pte(vmf, page))
> -                       goto unlock;
> +               if (pte_none(*vmf->pte))
> +                       do_set_pte(vmf, page);
> +               /* no need to invalidate: a not-present page won't be cached */
> +               update_mmu_cache(vma, vmf->address, vmf->pte);
>                 unlock_page(head);
> -               goto next;
> +               continue;

This can't be right.

Look at what happens if "pte_none()" is not true.. It won't install
the new pte, but it also won't drop the ref to the page.

So I think it needs to be

-               if (alloc_set_pte(vmf, page))
+               if (!pte_none(*vmf->pte))
                        goto unlock;
+               do_set_pte(vmf, page);

instead, so that the "if somebody else already filled the page table"
case gets handled right.

Hmm?

              Linus
