Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011BD1C3082
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 02:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgEDAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 20:34:36 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:51966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgEDAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 20:34:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id ECBCE100F0724;
        Mon,  4 May 2020 00:34:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:8957:10004:10400:10848:11232:11658:11914:12043:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: crowd42_44dd700fc7262
X-Filterd-Recvd-Size: 2793
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 00:34:33 +0000 (UTC)
Message-ID: <86d49281dfa7c28b7079af84b5b5e9d70a454f8e.camel@perches.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Date:   Sun, 03 May 2020 17:34:31 -0700
In-Reply-To: <20200504002309.GD2869@paulmck-ThinkPad-P72>
References: <20200428205903.61704-1-urezki@gmail.com>
         <20200428205903.61704-4-urezki@gmail.com>
         <20200501190555.GB7560@paulmck-ThinkPad-P72>
         <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
         <20200503234400.GB197097@google.com>
         <20200504002309.GD2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-03 at 17:23 -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 07:44:00PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 01:52:46PM -0700, Joe Perches wrote:
[]
> > > Perhaps a change to coding-style.rst
> > > ---
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
[]
> > > @@ -565,6 +565,11 @@ comments is a little different.
> > >  	 * but there is no initial almost-blank line.
> > >  	 */
> > >  
> > > +.. code-block:: c
> > > +
> > > +	// Single line and inline comments may also use the c99 // style
> > > +	// Block comments as well
> > > +
> > >  It's also important to comment data, whether they are basic types or derived
> > >  types.  To this end, use just one data declaration per line (no commas for
> > >  multiple data declarations).  This leaves you room for a small comment on each
> > 
> > Yeah that's fine with me. This patch just tries to keep it consistent. I am
> > Ok with either style.
> 
> My approach has been gradual change.  Big-bang changes of this sort
> cause quite a bit of trouble.  So I use "//" in new code and (sometimes)
> convert nearby ones when making a change.

I think that's good too.

Mixing styles in the same compilation unit is not
generally the right thing to do.

But right now, c99 comments are not specified as
allowed in coding-style so it's likely appropriate
to add something like this there.


