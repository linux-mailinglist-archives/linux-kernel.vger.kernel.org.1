Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFF27094E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIRXzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRXzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 19:55:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823AFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 16:55:42 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJQDx-001LjX-0T; Fri, 18 Sep 2020 23:55:29 +0000
Date:   Sat, 19 Sep 2020 00:55:28 +0100
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
Message-ID: <20200918235528.GB3421308@ZenIV.linux.org.uk>
References: <000000000000762dee05af9ccd01@google.com>
 <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 04:31:33PM -0700, Andy Lutomirski wrote:

> check_zeroed_user() looks buggy.  It does:
> 
>        if (!user_access_begin(from, size))
>                return -EFAULT;
> 
>        unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> 
> This is wrong if size < sizeof(unsigned long) -- you read outside the
> area you verified using user_access_begin().

Read the code immediately prior to that.  from will be word-aligned,
and size will be extended accordingly.  If the area acceptable for
user_access_begin() ends *NOT* on a word boundary, you have a problem
and I would strongly recommend to seek professional help.

All reads in that thing are word-aligned and word-sized.  So I very
much doubt that your analysis is correct.
