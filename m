Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4A2DC6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgLPSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731667AbgLPSmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:42:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6FC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:41:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o19so25288256lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCn/jCPPDZXlf9ePKIfj8E1795/GsgQ/JdHgm4LtjQA=;
        b=HIyDgDllo8p73lQ4EedSHwaWwaKKnRLXD1OwFgDxoxIQ/SZX+nE8RY1+JFfOMMNOfE
         pT2IwSFXNJFAjZI13/AKsRY8MFWCn7BCOxnwBrXezhQDGQjEmdbhveZeljr1A0JfDmgQ
         CZuKFp6T5JFWi+Qfv7n8eEGxFkOSFelNXYySU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCn/jCPPDZXlf9ePKIfj8E1795/GsgQ/JdHgm4LtjQA=;
        b=NBwMsdWQmCF/fPjOU/SBUXuDUFGMh+KiRZZ6DmIDumXHAq68+XMrBTI3YdEpWxdHd2
         YmPNPVVtMhDO/YNRcJw1ACMfSVH1Y6qFac2f3JvHmP3yhA6cxp2RBK/S0TleocEoa2fN
         dN7Q5eFSCrAvQVZf8k7imACmF1UjfFa2SFvSk2sy5PcpcDoGCqNJC44L/odJX8mklrYF
         fcqAsiQuaaNRHs9huvE+DOcEw7ZhJiIXr/7KWXGuUCxq8kf28zA2i4eRKStclN7adum9
         3nGxAwNitoPDMxYLzTos0UObxjSkgTJ0VpBg/xwwptby8Yx3YNun7JbrjcJAFCLt1IeV
         30qg==
X-Gm-Message-State: AOAM532mRf4ZBlUZT7p9cSLNLR+2dO7VLCMH48/8nnKSvBseB8WVTRoK
        vCrEJIcRTIYoTOdwNoP7/cRreeeVZ08vKQ==
X-Google-Smtp-Source: ABdhPJweoWqERL1JY7tb4otcWZIwxznefBFSYu0c24qqTiJamC9kM+/RB1KBHIpqeIJqUggfr/LSHg==
X-Received: by 2002:a2e:7d18:: with SMTP id y24mr8322203ljc.384.1608144115569;
        Wed, 16 Dec 2020 10:41:55 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x26sm312500lfe.173.2020.12.16.10.41.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 10:41:54 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id a9so50911594lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:41:53 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr8684864lfr.487.1608144113096;
 Wed, 16 Dec 2020 10:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-1-will@kernel.org> <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck> <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com> <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box> <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box>
In-Reply-To: <20201216170703.o5lpsnjfmoj7f3ml@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 10:41:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
Message-ID: <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
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

On Wed, Dec 16, 2020 at 9:07 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> If this looks fine, I'll submit a proper patch.

That patch looks good to me.

It would be good if somebody else looked it through - maybe I like it
just because I got to pee in the snow and make my mark. But i think
that filemap_map_pages() now looks a lot more understandable, and
having that pte_offset_map_lock() outside the loop should be good.

In particular, it will make it much easier to then make arguments
about things like

 - increase the page mapping count

 - check that the page is not locked

 - check that the page still has a mapping

we can say "we know we hold the page table lock, and we increased the
page mapping count, and we saw that the page still had a mapping and
was not locked after that".

And that means that with some trivial memory ordering rules, we can
know that any concurrent "truncate()" that got the page lock after we
checked it, will get held up at

        if (page_mapped(page)) {
                unsigned int nr = thp_nr_pages(page);
                unmap_mapping_pages(mapping, page->index, nr, false);
        }

in truncate_cleanup_page(), and that means that we can safely map the
page _without_ ever actually even doing a "trylock_page()" at all.

Before this patch of yours, that logic would have been broken, because
the page table lock wasn't actually held for the whole first iteration
of that loop in filemap_map_pages().

And getting rid of the trylock_page() in that path gets rid of _the_
major page lock  case for at least one class of loads.

So I like the patch. But I would _really_ like for somebody else to
look at it, and look at my thinking above.

Because maybe I'm missing something.

                Linus
