Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F84291653
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJRHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 03:22:48 -0400
Received: from verein.lst.de ([213.95.11.211]:39359 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgJRHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 03:22:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D0B6F68B02; Sun, 18 Oct 2020 09:22:43 +0200 (CEST)
Date:   Sun, 18 Oct 2020 09:22:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Ian Kent <raven@themaw.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing
 causes regression in -next was Re: 5.9.0-next-20201015: autofs oops
 in update-binfmts
Message-ID: <20201018072243.GA15356@lst.de>
References: <20201016123530.GA30444@duo.ucw.cz> <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net> <20201017100234.GA3797@amd> <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 11:05:06AM -0700, Linus Torvalds wrote:
> On Sat, Oct 17, 2020 at 3:02 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Bad Linus!
> 
> Christ people.
> 
> The bug is in linux-next, not in mainline.  I've told the people
> involved already over a week ago.
> 
> I can't do anything about linux-next being broken and people not fixing it.

While it took longer than I would have preferred, Al has commited the
fix to his for-next tree a few days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=4c207ef48269377236cd38979197c5e1631c8c16
