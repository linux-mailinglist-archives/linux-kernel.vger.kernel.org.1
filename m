Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B025DEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgIDQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgIDQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:03:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A69C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dOIY+PK7v5oRo5v+cKMlhJajAlAgTvbKby18sXReyKo=; b=njw9vtf+x7s/XbD1M1mN9ssGF1
        pcpg1z62txj7dfVjqiI1WH/FUB8/RetpZgNoNrWcm4U4Ss92fYyykPZ0T2cIY1eEaYLO719iYWKbl
        mxmrUmOfaMF0nm6fjWKVA//w2u6JTBPgUd+bROD8e7I5MM73z3maEJgvj2q/9s6J5aDaPV+tRlPaI
        Qw/72DSaudNTChK420y/d5r+R77lRJYw3VmpxtkkFTKYMymqlJZcMWPs5VCCV8+Ys28/8k+LYILxf
        vY0Gc4qHl8gT03OOuFz+ZubsUWqj8A2BY7lJGS/tNO7xmQzhSuaUmBw9l1qJztq1ZWBLATHLa6lxv
        tg9RxP9A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEBb-0006F1-G7; Fri, 04 Sep 2020 16:03:35 +0000
Date:   Fri, 4 Sep 2020 17:03:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
Message-ID: <20200904160335.GA23669@infradead.org>
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
 <20200904083109.GA9182@infradead.org>
 <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
 <20200904094617.GA27846@infradead.org>
 <CAAhSdy2x0ROqoTzzZRZgKCTL99WPy-8e4CQ921sf-=GQDm_gxA@mail.gmail.com>
 <f1be6ee1-0802-82ca-ffdb-4c294925cd9a@kylinos.com.cn>
 <20200904130044.GA7842@infradead.org>
 <CAAhSdy2N8L015z0-RirjXLjdzt+OrCtzzKzivsMeQXoH9Nc8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2N8L015z0-RirjXLjdzt+OrCtzzKzivsMeQXoH9Nc8Cw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 07:26:41PM +0530, Anup Patel wrote:
> On Fri, Sep 4, 2020 at 6:30 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Sep 04, 2020 at 08:58:25PM +0800, Qiu Wenbo wrote:
> > > I can confirm this patch also breaks K210 support. It seems that
> > > csr_read(CSR_TIME) will trigger an illegal instruction exception on K210.
> >
> > CSR_TIME is trapped by just about every implementation I know (which is
> > explicitly allowed by the spec).  That is why we should never use it
> > from common M-mode code.
> 
> Finally, I was able to replicate this issue by manually hacking QEMU to
> not emulatie TIME CSR for virt machine.
> 
> It seems this issue is only seen on older QEMU and Kendrtye K210.

You'd also see it when running nommu on Sifivie or just about any
hardware.  Whoever implement the TIME CSR for qemu made a mistake IMHO
as it doesn't match how most real hardware behaves.
