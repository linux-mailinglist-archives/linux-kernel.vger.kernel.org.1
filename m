Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806B1F5DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 23:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFJVmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 17:42:55 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:54690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgFJVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:42:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 727EE801B568;
        Wed, 10 Jun 2020 21:42:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6691:7903:9707:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12297:12438:12555:12663:12740:12760:12895:13163:13229:13439:14180:14181:14659:14721:21060:21080:21627:21740:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: wrist18_451733326dce
X-Filterd-Recvd-Size: 3194
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 21:42:52 +0000 (UTC)
Message-ID: <33204a397b2d9316e09ae9829e637894b304ea00.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add check for
 NONNETWORKING_BLOCK_COMMENT_STYLE
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 10 Jun 2020 14:42:51 -0700
In-Reply-To: <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
References: <20200610202640.9020-1-scott.branden@broadcom.com>
         <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
         <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 14:33 -0700, Scott Branden wrote:
> Hi Joe,
> 
> On 2020-06-10 2:16 p.m., Joe Perches wrote:
> > On Wed, 2020-06-10 at 13:26 -0700, Scott Branden wrote:
> > > NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
> > > doesn't seem to be any check for the standard block comment style.
> > > Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
> > > on first line of non-networking block comments.
> > I think there are _way_ too many instances of this form
> > in non-networking code to enable this.
> > 
> > $ git grep -P '^\s*/\*\s*\S.*[^\*][^\\]\s*$' -- '*.[ch]' | \
> >    grep -v -P '^(drivers/net/|net/)' | \
> >    wc -l
> > 51407
> That is true about many things that checkpatch now checks for that 
> didn't previously.

Not in that quantity of uses it doesn't.

I specifically did _not_ add this very same test
when I added the other comment tests.

> But, by adding to checkpatch the coding style clearly outlined in 
> coding-style.rst can be followed:

Well, because there are _so_ many false positives
that don't need change, I'm not adding this.

As is, I'm nacking it.

If you need it for your use, you should keep it in
your own tree.

> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3408,6 +3408,16 @@ sub process {
> > >   			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
> > >   		}
> > >   
> > > +# Non-Networking with an empty initial /*
> > > +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> > > +		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
> > > +		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
> > > +		    $rawline =~ /^\+[ \t]*\*/ &&
> > > +		    $realline > 2) {
> > > +			WARN("NONNETWORKING_BLOCK_COMMENT_STYLE",
> > > +			     "non-networking block comments use an empty /* on first line\n" . $hereprev);

_Maybe_ this test _might_ be useful if it did a file/patch
test and used CHK on file, but even then I'm very dubious.

			my $msg_level = \&WARN;
			$msg_level = \&CHK if ($file);
			&{msg_level}(etc...)


