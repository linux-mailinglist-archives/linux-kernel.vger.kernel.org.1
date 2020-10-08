Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC7287360
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgJHLbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJHLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B8C061755;
        Thu,  8 Oct 2020 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DwTSjvedulsO0opgiIotXj/b9knhE4+XuYMJtOMwQ+s=; b=gYyn7eK+f+PGv9vwKMOqbEALC1
        NaGp03IA4BNliBLtfEewPwon7oUI1y1lVimJ5tjHHooJEM3p+tVcA4e65JiYPCq/bvFrFsLxmNROP
        HMV8pumFA/1nw+F8twfAHMS7ybSgjbxFx/nrevtNr2/4XdkgZHwK5+/x9GaZBC4/UV2LmGgJjjHEy
        pd0EIk0W27EqeEIAx2JlNKaSB0ELpBaYFyQCwjHJEC92rmi1RV1Jk9DQ2FSzMB6YQluS5JPnfEjnq
        5vi3ZiQTyc3QU0UZpGasGRT6L8JvTsLpXoRPAUa1v/eHIpNkA2bpXgX3vsEMvc116o4Cgq6EApYBS
        K/k5FTBg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQU8t-0001YQ-83; Thu, 08 Oct 2020 11:31:27 +0000
Date:   Thu, 8 Oct 2020 12:31:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@protonmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <20201008113127.GA20115@casper.infradead.org>
References: <C674RBXSO9XN.1LXXU71QQNTF1@ArchWay>
 <20201008024706.GZ20115@casper.infradead.org>
 <20201008080306.25e89901@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008080306.25e89901@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 08:03:06AM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 8 Oct 2020 03:47:06 +0100
> Matthew Wilcox <willy@infradead.org> escreveu:
> 
> > On Thu, Oct 08, 2020 at 02:15:24AM +0000, Nícolas F. R. A. Prado wrote:
> > > > I have a feature request ... could you automarkup NULL as being
> > > > :c:macro?
> > > > Or maybe just anything matching \<[[:upper:]_[:digit:]]*\>
> > > > (i may have my regex syntax confused ... a word composed of any
> > > > arrangement of upper-case, digits and underscores.)  
> > > 
> > > I think what you are suggesting are two separate things.
> > > 
> > > For NULL, what you're interested in is that it appears in a monospaced font, as
> > > if written ``NULL``, right? As I don't think a cross-reference to "the NULL
> > > macro definition" would make much sense.
> > > 
> > > While "anything containing only upper-case, digits and underscores" would
> > > actually be for cross-referencing to the definition of the macro symbol in
> > > question, right?  
> > 
> > Well, maybe!  What I'd really like is to remove all the markup from
> > xarray.rst.  Jon managed to get rid of most of it with the (), but
> > there's still markup on:
> > 
> > LONG_MAX
> > NULL
> > -EBUSY
> > true
> > XA_MARK_[012]
> > XA_FLAGS_*
> > ENOMEM
> > EINVAL
> > 
> > I'm not sure there's much that automarkup can do about ``true``, but all
> > the others fit the all-caps-and-underscore-and-digits pattern.
> > 
> > I don't know how much we want errnos to link to anything in particular.
> > So maybe split these into 'well-known' (eg defined by ANSI C or POSIX)
> > definitions and things which are local macros:
> > 
> > LONG_MAX
> > NULL
> > -EBUSY
> > ENOMEM
> > EINVAL
> 
> Yeah, a nice improvement would be to auto-markup error codes and NULL as
> literal blocks.
> 
> > 
> > vs
> > 
> > XA_MARK_[012]
> 
> > XA_FLAGS_*
> 
> Actually, things that end with an * (but doesn't start with an *)
> are good candidates for being literals - although extra care should
> be taken on such case, as parsing those automatically will likely hit
> lots of false-positives.

I do apologise.  I was trying to be concise in email.  In the actual
text file, I currently have:

``XA_FLAGS_ALLOC``
``XA_FLAGS_ALLOC1``
``XA_FLAGS_LOCK_IRQ``
``XA_FLAGS_LOCK_BH``
``XA_FLAGS_TRACK_FREE``

> > I'm willing to add more inline kernel-doc to get this to work better.
> 
> Why? inline kernel-doc should be evaluated just like normal blocks.
> 
> Right now, kernel-doc handles constants like NULL and XA_FLAGS_* using
> two ways:
> 
> 	%FOO
> or
> 	``FOO``
> 
> The regex for those are:
> 
> 	my $type_constant = '\b``([^\`]+)``\b';
> 	my $type_constant2 = '\%([-_\w]+)';

Right, but that's in kernel-doc ... in a .rst file, I believe we have
to use the ``SYMBOL`` syntax.

