Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A955274FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIWE0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWE0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:26:23 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AEFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 21:26:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKwM1-004Hvh-Hd; Wed, 23 Sep 2020 04:26:05 +0000
Date:   Wed, 23 Sep 2020 05:26:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: WARNING in ex_handler_uaccess
Message-ID: <20200923042605.GG3421308@ZenIV.linux.org.uk>
References: <000000000000762dee05af9ccd01@google.com>
 <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
 <20200918235528.GB3421308@ZenIV.linux.org.uk>
 <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
 <20200919001714.GC3421308@ZenIV.linux.org.uk>
 <bc5d889c-17f0-dcb8-d174-f21b321cf85b@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5d889c-17f0-dcb8-d174-f21b321cf85b@rasmusvillemoes.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:22:19PM +0200, Rasmus Villemoes wrote:

> So, not sure how the above got triggered, but I notice there might be an
> edge case in check_zeroed_user():
> 
> 	from -= align;
> 	size += align;
> 
> 	if (!user_read_access_begin(from, size))
> 		return -EFAULT;
> 
> 	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> 
> 
> Suppose size is (size_t)-3 and align is 3. What's the convention for
> access_ok(whatever, 0)? Is that equivalent to access_ok(whatever, 1), or
> is it always true (or $ARCH-dependent)?

It's usually true...

> But, AFAICT, no current caller of check_zeroed_user can end up passing
> in a size that can overflow to 0. E.g. for the case at hand, size cannot
> be more than SIZE_MAX-24.

Might be worth slapping if (unlikely(!size)) return -EFAULT; // overflow
just before user_read_access_begin() to be sure...
