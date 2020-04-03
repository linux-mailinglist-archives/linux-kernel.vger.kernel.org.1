Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52919CECB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbgDCDMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 23:12:55 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:40854 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389171AbgDCDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 23:12:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1AA50100E7B42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Apr 2020 03:12:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3653:3865:3866:3867:3870:3871:3872:3873:4250:4321:5007:7514:7903:8957:9010:10004:10400:10471:10848:11026:11232:11658:11914:12043:12296:12297:12555:12679:12740:12760:12895:13255:13439:13972:14181:14659:14721:21080:21324:21611:21627:21660:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: yard82_537bf120b152d
X-Filterd-Recvd-Size: 3199
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Apr 2020 03:12:53 +0000 (UTC)
Message-ID: <8611a73f58a162f9dd5edca5f60fdca262a17756.camel@perches.com>
Subject: checkpatch doesn't recognize register or volatile declarations (was
 Re: [Outreachy kernel] [PATCH] staging: ralink-gdma: Move blank line to fix
 warning)
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Apr 2020 20:10:57 -0700
In-Reply-To: <3492c120971177bb0b523d78565130981acd1eda.camel@gmail.com>
References: <20200402082309.839063-1-jbwyatt4@gmail.com>
         <alpine.DEB.2.21.2004021129490.3014@hadrien>
         <3492c120971177bb0b523d78565130981acd1eda.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding lkml)

On Thu, 2020-04-02 at 18:21 -0700, John B. Wyatt IV wrote:
> On Thu, 2020-04-02 at 11:31 +0200, Julia Lawall wrote:
> > On Thu, 2 Apr 2020, John B. Wyatt IV wrote:
> > 
> > > Move a blank line within a struct to fix/silence a style warning.
> > > 
> > > Reported by checkpatch.
> > > 
> > > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > > ---
> > > Note:
> > > ralink-gdma does not build; even with make allyesconfig.
> > > I did not find a menu option with make menuconfig.
> > > 
> > >  drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c
> > > b/drivers/staging/ralink-gdma/ralink-gdma.c
> > > index eabf1093328e..9c398048daac 100644
> > > --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> > > +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> > > @@ -122,9 +122,9 @@ struct gdma_dma_dev {
> > >  	struct gdma_data *data;
> > >  	void __iomem *base;
> > >  	struct tasklet_struct task;
> > > +
> > 
> > Adding a blank line here is not correct. checkpatch is confused. 
> 
> It is not, but I was unsure of how this should be addressed. Thank you
> for letting me know.
> 
> The second version of the patch removes the blank line.
> 
> > Perhaps
> > it lacks a pattern considering wolatile to indicate a type.
> 
> I have CC'ed Joe Perches on this.
> 

Well, perhaps this, but it might cause other undesired change.
I haven't tested it much.

Maybe for older c, this list should even include "auto" too.

btw: the linux kernel sources do not have a single instance of
     auto as far as I can tell with a trivial search.

---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67..e906a8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -372,6 +372,8 @@ our $InitAttribute = qr{$InitAttributeData|$InitAttributeConst|$InitAttributeIni
 # We need \b after 'init' otherwise 'initconst' will cause a false positive in a check
 our $Attribute	= qr{
 			const|
+			volatile|
+			register|
 			__percpu|
 			__nocast|
 			__safe|


