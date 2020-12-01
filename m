Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E22CB0FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLAXlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgLAXlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:41:49 -0500
Date:   Wed, 2 Dec 2020 08:41:04 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606866069;
        bh=QemWKaRat5Kq8lV/mRDce6/IdvuDSMnWaQdnYgL0QEg=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=UxE7yoMOgMYR0uRariSYqzU5PpuXVX0cQ4wQbCaBAxW4rgqK5hA3BVRXw4aVygzM6
         nOy0iZMcMPpNfzchNgp6ijiAewTU945+rm+d00gvaHWa4/fYhBJJ5QV7pmekdY/+c5
         eX5M7snRmn9PhlJaYeC94G6uo37no63U+ptXQa2c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] bootconfig: Make size and checksum fields le32
Message-Id: <20201202084104.20d7f1223986d58a5547a662@kernel.org>
In-Reply-To: <20201201104818.4ea357d8@gandalf.local.home>
References: <160583933538.547349.272918354455492444.stgit@devnote2>
        <20201201104818.4ea357d8@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 10:48:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 20 Nov 2020 11:28:55 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hello,
> > 
> > This is a series of patches to make the size and the checksum fields
> > in the footer le32 instead of u32.
> > 
> > In the thread for alignment series[1], Steve pointed that the current
> > footer format didn't specify the endianness thus it is hard to apply
> > the bootconfig for cross-build initrd if the target endianness is
> > different from the host machine.
> > 
> > I've proposed that the hexadecimal ASCII string in the previous series
> > [2] but Linus pointed that making it le32 was enough.
> > 
> > So this just make those fields le32.
> > 
> > Thank you,
> > 
> > [1] https://lore.kernel.org/lkml/20201118112249.30d20147@gandalf.local.home/
> > [2] https://lore.kernel.org/linux-doc/CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com/
> > 
> > ---
> > 
> 
> I have this all tested. Is this something that should go into the current
> -rc release, or wait for the next merge window?

Hrm, this kind of things usually good for the next merge window because
it is only for the different endianess cross-build case. But the next
release will be LTS (6 years life cycle), so it is possible someone
hits this issue before EOL and (I guess) finally they need this series.

So if possible, could you push this in -rc release? I think this doesn't
change so much.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
