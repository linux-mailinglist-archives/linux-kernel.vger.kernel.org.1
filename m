Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558C42CDFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgLCU3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgLCU3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:29:37 -0500
Date:   Thu, 3 Dec 2020 12:28:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607027336;
        bh=3GM43n+ykpZXsrys2IYlOfIbVi376Zl7mMWmJ3lZbYw=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=n364KfYSfk6dKoaT1hGl5ZKC4bJ+y4HlL5vvt+0xHoc+94/W/P+VkpbB/m8OCXizm
         BQ/475H+qPEnifOSp+z7qF8dfi5erHXmT4iWeGmEV4w6HS6pEwXFbyyPoY6YBY/WOQ
         R7dWLpju9pF/P10HGLjtZQXyY4dLFnzx8XC0pcZ8=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v3 1/1] kasan: fix object remain in offline per-cpu
 quarantine
Message-Id: <20201203122854.c8d5ed270ec9cfc7c17569d9@linux-foundation.org>
In-Reply-To: <CAAeHK+z+DPNysrUwfeu27h6sKdn5DDE=BL4t96KiF0mRBNPs+Q@mail.gmail.com>
References: <1606895585-17382-1-git-send-email-Kuan-Ying.Lee@mediatek.com>
        <1606895585-17382-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
        <CAAeHK+z+DPNysrUwfeu27h6sKdn5DDE=BL4t96KiF0mRBNPs+Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 13:46:59 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> >  #define QLIST_INIT { NULL, NULL, 0 }
> > @@ -188,6 +190,11 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
> >         local_irq_save(flags);
> >
> >         q = this_cpu_ptr(&cpu_quarantine);
> > +       if (q->offline) {
> > +               qlink_free(&info->quarantine_link, cache);
> 
> Hi Kuan-Ying,
> 
> This needs to be rebased onto the mm tree: it has some KASAN patches
> that touch this code and rename the info variable to meta.

Yup.  I'm taking care of that.
