Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4404A2B230C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKMRyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:54:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgKMRyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:54:23 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8BE20791;
        Fri, 13 Nov 2020 17:54:21 +0000 (UTC)
Date:   Fri, 13 Nov 2020 12:54:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
Message-ID: <20201113125419.3656d001@oasis.local.home>
In-Reply-To: <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
References: <20201113082930.27da4612@oasis.local.home>
        <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 09:43:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Nov 13, 2020 at 5:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Fix alignment of bootconfig
> >
> > GRUB may align the init ramdisk size to 4 bytes, the magic number at the
> > end of the init ramdisk that denotes bootconfig is attached may not be at
> > the exact end of the ramdisk. The kernel needs to check back at least 4
> > bytes.  
> 
> I've pulled this, but this really smells to me.
> 
> Isn't the thing that actually _writes_ that BOOTCONFIG_MAGIC able to
> fix this properly? I'm looking at the bootconfig tool, and wondering
> why that doesn't know about the alignment thing, for example.
> 
> And the fact that this got screwed up means that the BOOTCONFIG
> documentation needs updating too, so that the rules are documented and
> proper.
>

The issue is with grub. It will pad the initrd that it is given to make
sure that it ends on a 4 byte memory boundary. That is the bootconfig
tool adds itself at the end of the ramdisk. But, after grub loads it
into memory, if the ramdisk loaded ends at an off by one from finishing
at a 4 byte boundary, grub will append 3 more bytes. It then passes that
ending to the kernel.

The issue is that grub padded the end of the ramdisk after loading it
into memory. I'm not sure how the bootconfig tool can fix this. Perhaps
make sure the ram disk size is 4 bytes aligned?

Masami, correct me if my above explanation is incorrect. Thanks!

-- Steve
