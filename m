Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBF2C3391
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgKXVxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbgKXVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:53:39 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC2C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:53:39 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 34so394570pgp.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eeb46OLyUYe8CEL9RCpB8Rjzm+dAvCKxFRLMi+TWzE8=;
        b=chULQtPyZU6yH7LH9Yp7tHhjqYgjoH/GWfcXYNnyzcsX/9oaZ8SndhKiTvrV5Jl0gf
         wgqMrusVtyfvKDfRPq5mhhPWcCQMRgB8b+g/UM/D4ETE/soNATagXxJVyIyZBfZDP2xp
         oj6sM2Etbh5hyxPSxDiNIm9DarFLlh8NJZXQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eeb46OLyUYe8CEL9RCpB8Rjzm+dAvCKxFRLMi+TWzE8=;
        b=JjBJPNq6M+5iUwFX9NGXw8m3JaR1Tbge4akEmGA6XKUCqKwL+baLpuyXR3hS8xH2SJ
         PYtSSMePfM/gBMZQReGFIur4XmOF6kAAGU4RvFuGv7JKQ5ii/u/GrRx7r0MHWU4Cn48j
         fRSXFYDrwpJ5daDWFgVIDkCDm7R2A7Z8OwZNbEvsZyKw/8a6cnow5rc3QKgJ4MFk2sYx
         +W8+GCozLYx7BzFxUJQPW62JhQ5ztLO5yhg2bZuwZ/kB2T/pWl0VYUJQg+hG2LtIPNtp
         IEIjFop4W6jEWINpqMMtFT/b6BqjBSZ3MHWe1VVRNtcFUlLdOd1iQiDzD5BHVy36uASC
         me7A==
X-Gm-Message-State: AOAM533hclWvzIE57QA/RMa6twNvD98z1Gp0G4nVpCk+Xik+FCPrGZX+
        Dc5vAWKAJII5y0zY7IqjIPnzCg==
X-Google-Smtp-Source: ABdhPJw6zEGUFL/GNY35Zd2nreZVIKTgxe8pVomSyOaKn+0iiIMFnIMaIInVGOIjVD3bONDpe+e9uw==
X-Received: by 2002:a63:e0f:: with SMTP id d15mr361557pgl.310.1606254819180;
        Tue, 24 Nov 2020 13:53:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q126sm24093pfc.168.2020.11.24.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:53:38 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:53:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Printk specifiers for __user pointers
Message-ID: <202011241347.4AFCBDF62@keescook>
References: <20201120164412.GD619708@rowland.harvard.edu>
 <20201120134242.6cae9e72@gandalf.local.home>
 <X7uGlDg88bI6zebS@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7uGlDg88bI6zebS@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:53:24AM +0100, Petr Mladek wrote:
> On Fri 2020-11-20 13:42:42, Steven Rostedt wrote:
> > On Fri, 20 Nov 2020 11:44:12 -0500
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > To the VSPRINTF maintainers:
> > > 
> > > Documentation/core-api/printk-formats.rst lists a large number of format 
> > > specifiers for pointers of various sorts.  Yet as far as I can see, 
> > > there is no specifier meant for use with __user pointers.
> > > 
> > > The security implications of printing the true, unmangled value of a 
> > > __user pointer are minimal, since doing so does not leak any kernel 
> > > information.  So %px would work, but tools like checkpatch.pl don't like 
> > > it.
> 
> Just to be sure as I am not a security expert. Is there really that
> big difference in the risk? The following scenarios come to my mind:
> 
> 1. The address would show a well defined location in the userspace
>    application? Could it be used to attack the application?

Yes -- this is the primary risk in my view. Exposing addresses of any
kind can be a risk. While an unprivileged user may not have direct
access to dmesg, there tend to be many indirect ways to see its
contents. As such, exposing a userspace address (when not then also
terminating the process, as seen with the segv reporting) poses a
potential exposure risk. I admit it's not a LARGE risk, but modern
attacks use these kind of building blocks to construct all the steps to
reaching their target.

> 2. The address shows a location that is being accessed by kernel.
>    Could not it be used to pass a value that might be used to attack
>    kernel?

This is also a risk: it provides feedback about where something may be
as a target within a confused-deputy style attack. (i.e. set up one
process to confuse the kernel, and exploit it from another).

> > > Should a new specifier be added?  If not, should we simply use %px?
> > 
> > There's currently no user of '%pu' (although there is a '%pus'. Perhaps we
> > should have a '%pux'?
> > 
> > I would even state that if it is used, that if makes sure that the value is
> > indeed a user space pointer (goes through the same checks as accessing user
> > space), before its printed, otherwise it shows "(fault)" or something.
> 
> I have mixed feelings about this.
> 
> One one hand, it might make sense to mark locations where userspace
> address is printed. We could easily decide how to print them (hash or
> value) and we could check that it is really from a userspace one.
> 
> But I have few concerns:
> 
> 1. The existing "%pus" has a kind of opposite meaning. It says what
>    address space should be used when the kernel and userspace address
>    space is overlapping.
> 
> 2. There is the history with "%pk". It did not work because people did
>    not use it.
> 
> 3. I am not sure about the output when the address is not from
>    userspace. Printing ("fault") is not much helpful. Printing
>    hashed value might be confusing. Well, I am still not sure
>    that it is really safe to print real userspace addresses
>    by default.

I think this should just be %px. Or better yet, not printed at all. See
Linus's prior comments:
https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier

-- 
Kees Cook
