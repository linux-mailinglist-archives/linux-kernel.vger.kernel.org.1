Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17491C21F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 02:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgEBAaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 20:30:22 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:49068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgEBAaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:30:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6EF71837F24A;
        Sat,  2 May 2020 00:30:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:2899:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:9010:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:13095:13161:13229:13439:14181:14659:14721:21063:21080:21212:21433:21627:30034:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: mark00_3d34e379d4912
X-Filterd-Recvd-Size: 3347
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 00:30:20 +0000 (UTC)
Message-ID: <1c86e75bb56693bc2343d30e5baba09c783b02a2.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
From:   Joe Perches <joe@perches.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 01 May 2020 17:30:19 -0700
In-Reply-To: <5a1da586-0cc0-1900-477f-6fef61af7f95@intel.com>
References: <20200501231131.2389319-1-jacob.e.keller@intel.com>
         <e1e12e3f6992c00c005ba2b3bcf671c033a1dccc.camel@perches.com>
         <5a1da586-0cc0-1900-477f-6fef61af7f95@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 17:19 -0700, Jacob Keller wrote:
> 
> On 5/1/2020 4:42 PM, Joe Perches wrote:
> > On Fri, 2020-05-01 at 16:11 -0700, Jacob Keller wrote:
> > > NL_SET_ERR_MSG and NL_SET_ERR_MSG_MOD are used to report extended error
> > > responses about failure of a netlink command. These strings often end up
> > > going over the 80-column limit. Just like logging messages, it is
> > > preferred to leave the message all on a single line.
> > > 
> > > Add these to the exception list so that checkpatch.pl will no longer
> > > complain about the long lines due to use of these macros.
> > > 
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Andy Whitcroft <apw@canonical.com>
> > > Cc: Joe Perches <joe@perches.com>
> > > ---
> > >  scripts/checkpatch.pl | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index eac40f0abd56..5da3b06fbeaa 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -471,7 +471,8 @@ our $logFunctions = qr{(?x:
> > >  	WARN(?:_RATELIMIT|_ONCE|)|
> > >  	panic|
> > >  	MODULE_[A-Z_]+|
> > > -	seq_vprintf|seq_printf|seq_puts
> > > +	seq_vprintf|seq_printf|seq_puts|
> > > +	NL_SET_ERR_MSG(?:_MOD)?
> > >  )};
> > >  
> > >  our $allocFunctions = qr{(?x:
> > 
> > <shrug>  OK I guess.
> > 
> > What about GENL_SET_ERR_MSG ?
> > 
> 
> This appears in far fewer locations, but it does seem reasonable to add
> it to this list as well.
> 
> > btw:
> > 
> > There are some uses with what appear to be unnecessary newlines.
> > Maybe these newlines should be removed.
> 
> Yea, there's a number of places which seem to have put a newline break
> after the extack pointer.
> 
> A quick search shows that there are about 970 or so uses where we don't
> put a newline, and around 220 where we do.
> 
> I suppose I can make a series that cleans all of those up along with
> this patch.

That's not what I meant.
I don't care if there are multiple source lines used.
In fact, I think it's mostly nicer with multiple lines.

The ones I specified previously use:

	NL_SET_ERR_MSG_MOD(extack, "message\n");

where all the others uses are:

	NL_SET_ERR_MSG_MOD(extack, "message");

without the \n termination of the message.


