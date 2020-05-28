Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D341E6F89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 00:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437307AbgE1Wsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 18:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437205AbgE1Wsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:48:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1F8C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tRXkEJLeN0Bj0Z07YR7RqUj1nPvkZcl0lZrrdyv9YmE=; b=eODnKoUf1A2PUGd6BFsgnLJ7NX
        URRkvddhJ7qz/+5Njl05HnQB59EjgbOwZrF9dR4c55B05IFpuqNt0bTIbYwBselEvbhyWpANsjn7P
        Ky97FTpholXkQtogb1FVJeWfZcfeEvBD9ZGa0giv10SqaczDPZqLNjA/tMuP83pChK7TDx06Gktxv
        pgpEIBJmHjTjY0Fi/ZeZ/Z+7rzRDR9pEgGFHqwVfvjTTwovuh9ucHBplreel9TzmmdmoO7lpBJxti
        c7uhfyKQFlWaqCz99ea9ecGeuxLRvKwmreMyFcr0tRjkmI6Vx44yJJnqjbJIeo7k0k/ukJlC5bm4G
        yCzX9TyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeRKH-0004fJ-PE; Thu, 28 May 2020 22:48:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAA159834F3; Fri, 29 May 2020 00:48:35 +0200 (CEST)
Date:   Fri, 29 May 2020 00:48:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Subject: Re: [PATCH 0/6] x86/entry: disallow #DB more
Message-ID: <20200528224835.GU2483@worktop.programming.kicks-ass.net>
References: <20200528201937.038455891@infradead.org>
 <CAJhGHyCua-oTww9U26CJvfojxdfQGewH1T-JUro7gLKucT2+kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCua-oTww9U26CJvfojxdfQGewH1T-JUro7gLKucT2+kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:42:46AM +0800, Lai Jiangshan wrote:
> On Fri, May 29, 2020 at 4:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > These patches disallow #DB during NMI/#MC and allow removing a lot of fugly code.
> >
> 
> Hello
> 
> Will #DB be allowed in #DF?

No, that whole thing is noinstr.
