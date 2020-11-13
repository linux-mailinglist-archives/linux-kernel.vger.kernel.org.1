Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487B2B2340
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKMSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgKMSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:03:09 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA89208D5;
        Fri, 13 Nov 2020 18:03:07 +0000 (UTC)
Date:   Fri, 13 Nov 2020 13:03:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
Message-ID: <20201113130305.42284c27@oasis.local.home>
In-Reply-To: <CAHk-=wjdQ8YFtxsgLx8XCqeiL-2AOoNAx2RwDFcq-C+uowbp9g@mail.gmail.com>
References: <20201113082930.27da4612@oasis.local.home>
        <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
        <20201113125419.3656d001@oasis.local.home>
        <CAHk-=wjdQ8YFtxsgLx8XCqeiL-2AOoNAx2RwDFcq-C+uowbp9g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 09:57:54 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Nov 13, 2020 at 9:54 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The issue is that grub padded the end of the ramdisk after loading it
> > into memory. I'm not sure how the bootconfig tool can fix this. Perhaps
> > make sure the ram disk size is 4 bytes aligned?  
> 
> Exactly. Since - as far as I can tell - the _only_ thing that actually
> generates that BOOTCONFIG_MAGIC marker is the bootconfig tool, you
> control the vertical and the horizontal. No need for some "heuristic"
> and searching for things.
> 
> And then that thing needs to be documented, so that if somebody else
> starts generating BOOTCONFIG_MAGIC markers, we have a hard rule in
> place that "look, the bootconfig is always aligned".
> 
> Might as well align it more than 4 bytes while at it and make it even stricter.
> 

OK, yes I agree with this.

Masami, can you send a patch to fix the bootconfig tool to make sure
that when it appends to the initrd that it makes sure the file size is
aligned. Would 32 bytes be big enough for an alignment?

-- Steve
