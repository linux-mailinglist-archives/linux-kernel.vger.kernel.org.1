Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9E1C3073
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 02:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEDAXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 20:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgEDAXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 20:23:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7181020735;
        Mon,  4 May 2020 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588551789;
        bh=9D3uqPERL7oAXfzZ9KLtFQROHIPnp5MEZfYjm1gVk/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NzvjalZ8Bj52gIgQxdsZm/Y3F9jTl4f6+AVkoWq8iCjE1Kt/z91SuMv1Dn3jR4Z2w
         Gi1BtsYBVuheFdWYiCOfeO4dMbAsMOal2JEWTDMOtxjfisjSFXOeT/ylL3YlcwlFXF
         GmC7hfrXPTEsPNRtEXZRChtKZcU3Q23TCj0u+cIs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4B3D23520D7D; Sun,  3 May 2020 17:23:09 -0700 (PDT)
Date:   Sun, 3 May 2020 17:23:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Joe Perches <joe@perches.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
Message-ID: <20200504002309.GD2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-4-urezki@gmail.com>
 <20200501190555.GB7560@paulmck-ThinkPad-P72>
 <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
 <20200503234400.GB197097@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503234400.GB197097@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 07:44:00PM -0400, Joel Fernandes wrote:
> On Fri, May 01, 2020 at 01:52:46PM -0700, Joe Perches wrote:
> > On Fri, 2020-05-01 at 12:05 -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > > > with majority of commenting styles.
> > []
> > > on /* */ style?
> > > 
> > > I am (slowly) moving RCU to "//" for those reasons.  ;-)
> > 
> > I hope c99 comment styles are more commonly used soon too.
> > checkpatch doesn't care.
> > 
> > Perhaps a change to coding-style.rst
> > ---
> >  Documentation/process/coding-style.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index acb2f1b..fee647 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -565,6 +565,11 @@ comments is a little different.
> >  	 * but there is no initial almost-blank line.
> >  	 */
> >  
> > +.. code-block:: c
> > +
> > +	// Single line and inline comments may also use the c99 // style
> > +	// Block comments as well
> > +
> >  It's also important to comment data, whether they are basic types or derived
> >  types.  To this end, use just one data declaration per line (no commas for
> >  multiple data declarations).  This leaves you room for a small comment on each
> 
> Yeah that's fine with me. This patch just tries to keep it consistent. I am
> Ok with either style.

My approach has been gradual change.  Big-bang changes of this sort
cause quite a bit of trouble.  So I use "//" in new code and (sometimes)
convert nearby ones when making a change.

							Thanx, Paul
