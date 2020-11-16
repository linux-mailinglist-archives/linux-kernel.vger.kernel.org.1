Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F522B3D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgKPHHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgKPHHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:07:14 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD542071E;
        Mon, 16 Nov 2020 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605510434;
        bh=wUhv9Mn+eNrkbXQGu3NZ+R9ZWyCj/ts3jsRTH9hz+Ns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ndTAzqLlqe213Fmy+aZYw9aPe9MxpW1T9k4Sbj78839WtLoT1ekEo+e7tbfwmiAhs
         NM6qdv5c5BUbTDTF5Xk8vGy7UiJCccpB/G1KLQWZ3AsI/+VjrmrzBWJky/vSb1BKO2
         r3ZDwt2WELWfmaSynMLewaevz75oqTrhPRCe6eWw=
Date:   Mon, 16 Nov 2020 16:07:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
Message-Id: <20201116160710.c088d1f6b4ab957d93f9aa13@kernel.org>
In-Reply-To: <20201113130305.42284c27@oasis.local.home>
References: <20201113082930.27da4612@oasis.local.home>
        <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
        <20201113125419.3656d001@oasis.local.home>
        <CAHk-=wjdQ8YFtxsgLx8XCqeiL-2AOoNAx2RwDFcq-C+uowbp9g@mail.gmail.com>
        <20201113130305.42284c27@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 13:03:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 13 Nov 2020 09:57:54 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Fri, Nov 13, 2020 at 9:54 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > The issue is that grub padded the end of the ramdisk after loading it
> > > into memory. I'm not sure how the bootconfig tool can fix this. Perhaps
> > > make sure the ram disk size is 4 bytes aligned?  
> > 
> > Exactly. Since - as far as I can tell - the _only_ thing that actually
> > generates that BOOTCONFIG_MAGIC marker is the bootconfig tool, you
> > control the vertical and the horizontal. No need for some "heuristic"
> > and searching for things.
> > 
> > And then that thing needs to be documented, so that if somebody else
> > starts generating BOOTCONFIG_MAGIC markers, we have a hard rule in
> > place that "look, the bootconfig is always aligned".
> > 
> > Might as well align it more than 4 bytes while at it and make it even stricter.
> > 
> 
> OK, yes I agree with this.

OK, but note that the initrd_end can be modified by the bootloader anyway.

The bootloader can pass any "size" bigger than actual initramfs size
because initramfs is a cpio file which has a "TRAILER!!!" magic as the
end of file. This means kernel can ignore or use (as the bootconfig does)
for a tailing data storage.

But I agree that we need to document it, so that anyone can refer the
data format.

> Masami, can you send a patch to fix the bootconfig tool to make sure
> that when it appends to the initrd that it makes sure the file size is
> aligned. Would 32 bytes be big enough for an alignment?

OK, it is easy to me to update bootconfig tool to align up the total size
to 32bytes, but I think 4 bytes align is OK if we document it. Without
documentation, no one in the bootloader decides what is the correct
format.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
