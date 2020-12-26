Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8A2E2F21
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgLZVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:08:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321DC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:07:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h22so16000422lfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLzZOIgPa8iJ9Qz8oeEG2djATaWpwCUP0i8Tl1Hc7Zg=;
        b=N6fEfq+jWauozbcMHPf/B0M4w8Cb6kqr3VPP7Q+3/4QNRt+Netvh3QJmjtws1fK7sj
         SLs93EdyJRwwErvnET7KD+AF9lnNMk7UFHq2G7xO97r/ulDnrwYmuUUpcMLSiJJNLzHx
         Fexyl7FzYf0NKSWDJXi29vPxcqWkkF8u2MRX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLzZOIgPa8iJ9Qz8oeEG2djATaWpwCUP0i8Tl1Hc7Zg=;
        b=LWDiZ57wgFQ/1vViV5EziFUeU5ZqF0oVGWTtLVKt/u16Wx2ljKyhJW+E5huOs4dWYj
         wGoepA1nt+xDyyesdNSg49RFClaI6NiQAFSXNWl+z8lefL0OEwQJUjM+QXlu3+UJTW3p
         yjElhACn/zaI74322kh1ONsr6CLHhTYqvftvIgZd2DR7B4h6dhDoJL+PNxUvhKhcslEf
         yHLExX8bbVpQXAngZWzaHGtsW2cuIeXFSh667bQQdsMe3zt6zIX4sbP+EFa3IFqJ3IRP
         R0xA5wVj0f4Pf9CWGqELUonYh13mb6kDWl3IqRGIYgUaND/EH6ytRiERE6DPabyRyCX2
         d+WA==
X-Gm-Message-State: AOAM531eQ3QQcdgn1zJbYrFNd/NWnXjrwkgBoUIMNpPZBH0TtRECMf5x
        WmxsjnAwKhFp7kpwflkXae4QU6HWol1Sgg==
X-Google-Smtp-Source: ABdhPJzTGGu17cFe8YG62BrApp39ghJzVEyJ8rKhRqAV1agh0hOpKNdXE57nLNS0T+OW6Hw3XNMxzw==
X-Received: by 2002:a19:86c1:: with SMTP id i184mr15508170lfd.563.1609016851846;
        Sat, 26 Dec 2020 13:07:31 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o138sm4362604lfa.171.2020.12.26.13.07.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 13:07:31 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m12so15926158lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:07:30 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr17054973lfc.253.1609016850481;
 Sat, 26 Dec 2020 13:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box> <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box> <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box>
In-Reply-To: <20201226204335.dikqkrkezqet6oqf@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Dec 2020 13:07:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbUdvTShO5woNpM8w9rd655XwxKwHoz_r_HWReyx1oAw@mail.gmail.com>
Message-ID: <CAHk-=wgbUdvTShO5woNpM8w9rd655XwxKwHoz_r_HWReyx1oAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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

I was going to just apply this patch, because I like it so much, but
then I decided to take one last look, and:

On Sat, Dec 26, 2020 at 12:43 PM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> +static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> +{
> +       struct mm_struct *mm = vmf->vma->vm_mm;
> +
> +       /* Huge page is mapped? No need to proceed. */
> +       if (pmd_trans_huge(*vmf->pmd))
> +               return true;

doesn't this cause us to leak a locked page?

I get the feeling that every single "return true" case here should
always unlock the page and - with the exception of a successful
do_set_pmd() - do a "put_page()".

Which kind of argues that we should just do it in the caller (and get
an extra ref in the do_set_pmd() case, so that the caller can always
do

        if (filemap_map_pmd(..)) {
                unlock_page(page);
                put_page(page);
                rcu_read_unlock();
                return;
        }

andf then there are no odd cases inside that filemap_map_pmd() function. Hmm?

Other than that, I really find it all much more legible.

Of course, if I'm wrong about the above, that just proves that I'm
missing something and it wasn't so legible after all..

              Linus
