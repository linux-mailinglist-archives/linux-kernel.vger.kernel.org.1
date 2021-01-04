Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680E72E9B76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbhADQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbhADQ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:59:11 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CAEC061796
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 08:58:30 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwTBb-006pYa-1h; Mon, 04 Jan 2021 16:58:27 +0000
Date:   Mon, 4 Jan 2021 16:58:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: in_compat_syscall() on x86
Message-ID: <20210104165827.GJ3579531@ZenIV.linux.org.uk>
References: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 12:16:56PM +0000, David Laight wrote:
> On x86 in_compat_syscall() is defined as:
>     in_ia32_syscall() || in_x32_syscall()
> 
> Now in_ia32_syscall() is a simple check of the TS_COMPAT flag.
> However in_x32_syscall() is a horrid beast that has to indirect
> through to the original %eax value (ie the syscall number) and
> check for a bit there.
> 
> So on a kernel with x32 support (probably most distro kernels)
> the in_compat_syscall() check is rather more expensive than
> one might expect.
> 
> It would be muck better if both checks could be done together.
> I think this would require the syscall entry code to set a
> value in both the 64bit and x32 entry paths.
> (Can a process make both 64bit and x32 system calls?)

Yes, it bloody well can.

And I see no benefit in pushing that logics into syscall entry,
since anything that calls in_compat_syscall() more than once
per syscall execution is doing the wrong thing.  Moreover,
in quite a few cases we don't call the sucker at all, and for
all of those pushing that crap into syscall entry logics is
pure loss.

What's the point, really?
