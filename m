Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED021B343
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGJKh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgGJKhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:37:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F5C08C5CE;
        Fri, 10 Jul 2020 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bLQUWGosuDOICgYvygdtLWCJR0ZUfdkcaPQINPRR0Fs=; b=wHZp/ckIeJyfy2rsivBGqdlqAH
        /NACrPJN7ycdaD8IIKzaDqi49Puow66CNeTQiAXbOiq7/jXYHWNbDhkDWCq5gQPK4H6rz+NSb22Y/
        7AxVVq1WTAVs3Rm408Q51A48hEBYllOwsMmKruPw6ApQvem4yVLsgkLMfQvcBtYhfm6uw7lLkg2/y
        vdza/pp0q0YRpb1+OboMfFP3XpG4Bij0/49sPKkK7xs7231X3WsL6FZaN508h6R+nqjPAlD4ms/bq
        BjrU/dKX8RGCFuRa/Eazm7baPKmDt8qo7AfaUnju9WNZXT2MInDwbq9rGXLObVvL09NOTN/JHsLOA
        6iID+89Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtqOz-0000wl-Ba; Fri, 10 Jul 2020 10:37:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 109263003E5;
        Fri, 10 Jul 2020 12:37:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E13BE2B5130C7; Fri, 10 Jul 2020 12:37:07 +0200 (CEST)
Date:   Fri, 10 Jul 2020 12:37:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <20200710103707.GF4800@hirez.programming.kicks-ass.net>
References: <202007091110.205DC6A9@keescook>
 <20200709204255.GA29288@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709204255.GA29288@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 09:42:56PM +0100, Will Deacon wrote:
> On Thu, Jul 09, 2020 at 11:11:30AM -0700, Kees Cook wrote:
> > The security contact list gets regular reports contained in archive
> > attachments. This tends to add some back-and-forth delay in dealing with
> > security reports since we have to ask for plain text, etc.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Documentation/admin-guide/security-bugs.rst | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> > index dcd6c93c7aac..c32eb786201c 100644
> > --- a/Documentation/admin-guide/security-bugs.rst
> > +++ b/Documentation/admin-guide/security-bugs.rst
> > @@ -21,11 +21,18 @@ understand and fix the security vulnerability.
> >  
> >  As it is with any bug, the more information provided the easier it
> >  will be to diagnose and fix.  Please review the procedure outlined in
> > -admin-guide/reporting-bugs.rst if you are unclear about what
> > +:doc:`reporting-bugs` if you are unclear about what
> >  information is helpful.  Any exploit code is very helpful and will not
> >  be released without consent from the reporter unless it has already been
> >  made public.
> >  
> > +Please send plain text emails without attachments where possible.
> > +It is much harder to have a context-quoted discussion about a complex
> > +issue if all the details are hidden away in attachments.  Think of it like a
> > +:doc:`regular patch submission <../process/submitting-patches>`
> > +(even if you don't have a patch yet): describe the problem and impact, list
> > +reproduction steps, and follow it with a proposed fix, all in plain text.
> > +
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Hopefully "plain text" implies unencrypted as much as it does "not html".

Or that RST crap :-(
