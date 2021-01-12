Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081E72F3CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437482AbhALVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436895AbhALUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:20:31 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3912C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:19:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u26so6810152iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hqBhnD/YzU63I8fHxCwq5RnpR9+xGyHPmW1V90kKSXE=;
        b=WvjLszQeGk0CFa474M0yChwiiM3glOYsxHTou4p63gbdsVL6cS5rlyO4XY3k5pfXiL
         QVhejmGASkdxp4uwpIeHitUR2rtAOGEvhHAeEB+evGPrFcNiUUG9YA0sKgTuNZOarUZx
         UV+mew40rVFnMSiVod6kUwe7EOYvFD4y2bK+ymv4UOV6T4OrgC81qqLPK0d04F+qBzbQ
         3Z/G7EbYwFAgH86Iau6up4H2BfCoBafQAALka6NcJlEE5W3S98L7OnnsVDZMEhXSTLCs
         nvJavo0EydXQcHyadE8NxnIow5uG2M6goFfuexczgJ0RUyHXoi23O8aKDVE6yhUCvSc2
         PjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hqBhnD/YzU63I8fHxCwq5RnpR9+xGyHPmW1V90kKSXE=;
        b=ZlryAUIhkbEpv76YB5YZUg+6O82RqzKZCr0L9rZeQ1yLVYSSrRDshSjzYKo9ioUv4T
         t7K/OBMVw08b72VllxGPOTBjou/YCvMjTnyYcF3qNhP3ZHt097wG/wEMoIf8Cgnpo+fF
         kKnVk+lzNLpkW3gN+1d6E/PsrW0pmJPTPHWLCpjyE0VPGtA+PQtm2BGanys1zmlUUtxE
         rOH+XDwdpXKJ2A3PAx21ItXm6vVBMntsB8FDUHFSJsk++vvpjCw7Cq7AbdBfZ/2F7wGE
         nC2IkUZgHndJ0FRTL8LOge3SMFprlytMgeOAwM6ebgGoPkj1M54VIobpyBDKEXDWp1Q2
         xz2A==
X-Gm-Message-State: AOAM530AODsRxHTi+heg5CEW6yB9u9lcHhkhNm/nL/nU1EJZBOpLh5hc
        KvrdAa/7bhCi31NjqyBhbvHSBBHLAxOUKpl0e9c=
X-Google-Smtp-Source: ABdhPJyPeblMR/1wzzZ8m4nFrXKaJGmWrubgj6M4b44eeTcXk49LIQoTeKzdkjYkdbT+y2h/KicOo1C6QtyZwIQDJPg=
X-Received: by 2002:a92:c002:: with SMTP id q2mr849018ild.186.1610482790007;
 Tue, 12 Jan 2021 12:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20201230154104.522605-1-arnd@kernel.org> <20210112191634.GA1587546@ubuntu-m3-large-x86>
In-Reply-To: <20210112191634.GA1587546@ubuntu-m3-large-x86>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 21:19:38 +0100
Message-ID: <CA+icZUVRWowSyE17e1Gmdkdy+JetvaGW0y61MBOJ07W2N8QH=Q@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 8:16 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 04:40:40PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang cannt evaluate this function argument at compile time
> > when the function is not inlined, which leads to a link
> > time failure:
> >
> > ld.lld: error: undefined symbol: __compiletime_assert_414
> > >>> referenced by mremap.c
> > >>>               mremap.o:(get_extent) in archive mm/built-in.a
> >
> > Mark the function as __always_inline to avoid it.
> >
> > Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I would like to see some movement on getting this fixed in 5.11. As it
> stands, this is one of three __compiletime_assert references with
> CONFIG_UBSAN_UNSIGNED_OVERFLOW. If we want to keep the BUILD_BUG()
> around, I think this is fine. Alternatively, turning it into a runtime
> check would be fine too.
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>

I have this patch in my custom 5.11 queue.

Feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> > ---
> >  mm/mremap.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index c5590afe7165..1cb464a07184 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -336,8 +336,9 @@ enum pgt_entry {
> >   * valid. Else returns a smaller extent bounded by the end of the source and
> >   * destination pgt_entry.
> >   */
> > -static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
> > -                     unsigned long old_end, unsigned long new_addr)
> > +static __always_inline unsigned long get_extent(enum pgt_entry entry,
> > +                     unsigned long old_addr, unsigned long old_end,
> > +                     unsigned long new_addr)
> >  {
> >       unsigned long next, extent, mask, size;
> >
> > --
> > 2.29.2
>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210112191634.GA1587546%40ubuntu-m3-large-x86.
