Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940A4270964
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgISARY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgISARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:17:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE2C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 17:17:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJQZ0-001MQx-FB; Sat, 19 Sep 2020 00:17:14 +0000
Date:   Sat, 19 Sep 2020 01:17:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>,
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
Message-ID: <20200919001714.GC3421308@ZenIV.linux.org.uk>
References: <000000000000762dee05af9ccd01@google.com>
 <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
 <20200918235528.GB3421308@ZenIV.linux.org.uk>
 <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 05:07:43PM -0700, Andy Lutomirski wrote:
> On Fri, Sep 18, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Sep 18, 2020 at 04:31:33PM -0700, Andy Lutomirski wrote:
> >
> > > check_zeroed_user() looks buggy.  It does:
> > >
> > >        if (!user_access_begin(from, size))
> > >                return -EFAULT;
> > >
> > >        unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> > >
> > > This is wrong if size < sizeof(unsigned long) -- you read outside the
> > > area you verified using user_access_begin().
> >
> > Read the code immediately prior to that.  from will be word-aligned,
> > and size will be extended accordingly.  If the area acceptable for
> > user_access_begin() ends *NOT* on a word boundary, you have a problem
> > and I would strongly recommend to seek professional help.
> >
> > All reads in that thing are word-aligned and word-sized.  So I very
> > much doubt that your analysis is correct.
> 
> Maybe -ETOOTIRED, but I seriously question the math in here.  Suppose
> from == (unsigned long *)1 and size == 1.  Then align is 1, and we do:
> 
> from -= align;
> size += align;
> 
> So now from = 0 and size = 2.  Now we do user_access_begin(0, 2) and
> then immediately read 4 or 8 bytes.  No good.

Could you explain what kind of insane hardware manages to do #PF-related
checks (including SMAP, whatever) with *sub*WORD* granularity?

If it's OK with 16bit read from word-aligned address, but barfs on 64bit
one...  I want to know what the hell had its authors been smoking.
