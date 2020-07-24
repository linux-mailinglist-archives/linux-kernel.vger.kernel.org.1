Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6E22CC64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGXRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:41:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C75C0619D3;
        Fri, 24 Jul 2020 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FqA68UqnOeQNPrtAxIPD6HxDZJOq+LeV5TLg5WJK564=; b=tTM2agWtok77q/6gAZ99y3VZr6
        bJ0GpUJIBK3iWQ1er3crAkmqP1V/ffr+nLRMlz7aBe+8mO3OYV8Vz8duluPsXkYCCSYSclR1x5ydI
        6mKtUi6KX6vKb6ir8tBXUqdfdsqYtWJTMBtCVTsVWEtD1OkTuki0BXgg5vgxcbhWL3iqKx3FPZHP0
        1TY1+2QjUlGuImoOaw/JHxhT5LsSZmIsVuwENnU+Jz1NDhiAVux41JQyXP67q78NjrgKOleVuoSey
        rEPhOT7zK3iLRsIxwHtZQSgRgLLzMfADFF1gBApJsjKBJjROavdV6S+33kKf+yE4dAXD/mhkw4hQn
        amToRNUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jz1hK-0006ef-Qi; Fri, 24 Jul 2020 17:41:30 +0000
Date:   Fri, 24 Jul 2020 18:41:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
Message-ID: <20200724174130.GC23808@casper.infradead.org>
References: <20200724132200.51fd2065@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724132200.51fd2065@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:22:00PM -0400, Steven Rostedt wrote:
> I like how RST can help make for a better grouping of our documents
> and put it into other formats. But I have to rant a little because I'm
> currently experiencing some of the frustration that Peter commonly
> complains about.

Thanks for bringing this up in such a constructive manner.
I'm sympathetic to these concerns.

> Then I went to Documentation/filesystems/path-lookup.rst, and found
> myself constantly re-reading the same paragraph over again, and losing
> track of what I'm reading. I realized it wasn't due to the writing, but
> due to the constant inserted markup of quotes, that makes it terribly
> annoying to read, and unfortunately, not enjoyable at all.
> 
> For example:
> 
> > It is tempting to describe the second kind as starting with a
> > component, but that isn't always accurate: a pathname can lack both
> > slashes and components, it can be empty, in other words.  This is
> > generally forbidden in POSIX, but some of those "xxx``at``" system calls
> > in Linux permit it when the ``AT_EMPTY_PATH`` flag is given.  For
> > example, if you have an open file descriptor on an executable file you
> > can execute it by calling `execveat() <execveat_>`_ passing
> > the file descriptor, an empty path, and the ``AT_EMPTY_PATH`` flag.
> 
> All those `` are throwing me off to understanding what is being written.
> 
> I don't even know what those are suppose to represent.

Great example.  Some people definitely go too far with rst markup, and
we generally try to discourage it.  And I'm pretty sure we take patches
to remove excessive markup where it's gone too far [1].

You can see how this renders in html at
https://www.kernel.org/doc/html/latest/filesystems/path-lookup.html or
run 'make htmldocs' to build it locally.  Personally, I don't think
the markup style it uses works very well in the html either.

I'd like to see this paragraph written as:

> It is tempting to describe the second kind as starting with a
> component, but that isn't always accurate: a pathname can lack both
> slashes and components, it can be empty, in other words.  This is
> generally forbidden in POSIX, but some of the "*at()" system calls
> in Linux permit it when the ``AT_EMPTY_PATH`` flag is given.  For
> example, if you have an open file descriptor on an executable file you
> can execute it by calling execveat() passing the file descriptor, an
> empty path, and the ``AT_EMPTY_PATH`` flag.

I think we're all pretty comfortable seeing function names adorned with
a closing pair of parens.  The ``...`` to adorn constants feels OK to me,
but maybe not to you?  If that feels excessive, can you suggest something
that would distinguish between POSIX and AT_EMPTY_PATH?

[1] Too far being a subjective measure, of course.  My preferences
are on display in core-api/xarray.rst
