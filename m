Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1060029511E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503182AbgJUQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:51:03 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:58960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2444579AbgJUQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:51:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 13750182CED28;
        Wed, 21 Oct 2020 16:51:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2689:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3871:3872:3874:4321:5007:10007:10128:10400:10848:11232:11658:11914:12295:12297:12555:12740:12760:12895:13019:13069:13161:13229:13311:13357:13439:14181:14659:14721:14799:21080:21222:21326:21627:21660:21740:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: ink53_4217b0127249
X-Filterd-Recvd-Size: 2566
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 16:51:00 +0000 (UTC)
Message-ID: <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Wed, 21 Oct 2020 09:50:59 -0700
In-Reply-To: <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
         <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
         <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 08:28 -0700, Joe Perches wrote:
> On Wed, 2020-10-21 at 08:18 -0700, Joe Perches wrote:
> > I might add that check to the line below where
> > the repeated words are checked against long
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3062,6 +3062,7 @@ sub process {
> >  
> >  				next if ($first ne $second);
> >  				next if ($first eq 'long');
> > +				next if ($first =~ /^$Hex$/;
> 
> oops.  with a close parenthesis added of course...

That doesn't work as $Hex expects a leading 0x.

But this does...

The negative of this approach is it would also not emit
a warning on these repeated words: (doesn't seem too bad)

$ grep -P '^[0-9a-f]{2,}$' /usr/share/dict/words
abed
accede
acceded
ace
aced
ad
add
added
baa
baaed
babe
bad
bade
be
bead
beaded
bed
bedded
bee
beef
beefed
cab
cabbed
cad
cede
ceded
dab
dabbed
dad
dead
deaf
deb
decade
decaf
deed
deeded
deface
defaced
ebb
ebbed
efface
effaced
fa
facade
face
faced
fad
fade
faded
fed
fee
feed
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..79d7a4cba19e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3062,6 +3062,7 @@ sub process {
 
 				next if ($first ne $second);
 				next if ($first eq 'long');
+				next if ($first =~ /^[0-9a-f]+$/i);
 
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&



