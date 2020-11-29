Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305842C7876
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 09:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgK2Iuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 03:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2Iuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 03:50:50 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226ED2074B;
        Sun, 29 Nov 2020 08:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606639809;
        bh=Mm0a7/3fGjnPfTe5viPPHz9/JebvKW3hdOaYFV/K51Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X59JSlAp9tTjzZx9RiK3zx8pxI/4twlG0x2h6xHROimp7SJqIGu56iVgKYQAbJMkD
         7g4LckTzCUh5GD7T8VpvdFXvJFD8UygN/lfgzm3GCQVOFnJEluIeJubqdMJy3R2eLh
         c3H0mOeuckE/cLdo3XmYztgrT2vBA7IAHYLl2XFM=
Date:   Sun, 29 Nov 2020 17:50:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-Id: <20201129175005.7e07a9f799e888ffd5f4ed67@kernel.org>
In-Reply-To: <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124174647.GI4009@zn.tnic>
        <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 09:45:39 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Tue, Nov 24, 2020 at 9:46 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Nov 24, 2020 at 11:19:33AM +0100, Borislav Petkov wrote:
> > > In any case, at least the case where I give it
> > >
> > > 0x48 0xcf 0x48 0x83
> > >
> > > and say that buf size is 4, should return an error because the second
> > > insn is incomplete. So I need to go look at that now.
> >
> > Ok, got it:
> >
> > ./arch/x86/tools/insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x826fdf9c)
> > insn buffer:
> > 0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90
> > supplied buf size: 15, ret 0
> > supplied buf size: 2, ret 0
> > supplied buf size: 3, ret 0
> > supplied buf size: 4, ret 0
> > supplied buf size: 1, ret -22
> >
> > the current decoder simply decodes the *first* insn in the buffer it
> > encounters and that's it.
> >
> > When you give it a buffer of size smaller than the first instruction:
> >
> > supplied buf size: 1, ret -22
> >
> > while the first insn is 2 bytes long:
> >
> > 0x48 0xcf (IRETQ)
> >
> > then it signals an error.
> >
> > Andy, does that work for your use cases?
> 
> Is -22 (-EINVAL) the same error it returns if you pass in garbage?
> How hard would it be to teach it to return a different error code when
> the buffer is too small?
> 

Good point. I think we can return, e.g. -EFAULT if we failed in get_next(). Then, we can read out next page, for example.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
