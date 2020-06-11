Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E541F61C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFKGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 02:32:10 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:46840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbgFKGcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:32:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 73FCA1800A66D;
        Thu, 11 Jun 2020 06:32:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2197:2199:2393:2525:2560:2563:2612:2682:2685:2692:2828:2859:2917:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:6119:6691:7903:8603:8957:8985:9025:9388:10004:10400:10848:11026:11232:11658:11854:11914:12043:12295:12297:12438:12555:12663:12682:12740:12760:12776:12895:12903:13161:13229:13439:14180:14181:14659:14721:14849:21060:21080:21221:21324:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: flock27_180cb4426dd1
X-Filterd-Recvd-Size: 4769
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 06:32:07 +0000 (UTC)
Message-ID: <8f16717e0b275cc9a8970f62a7e46e7a97f8e5fa.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore CamelCase for inttypes.h format
 specifiers
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 23:32:06 -0700
In-Reply-To: <f524dfb7-ba0b-1a12-9325-457f5e9d7136@broadcom.com>
References: <20200610203307.9344-1-scott.branden@broadcom.com>
         <1b2d9ead79a5a035a287b7ecba8655b2c633d5cd.camel@perches.com>
         <a3d5f2c5-40fb-c97d-8365-423213926e89@broadcom.com>
         <6e2e2095f1b6839ec78d41233fa8d908d1bd2bbe.camel@perches.com>
         <f524dfb7-ba0b-1a12-9325-457f5e9d7136@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 23:01 -0700, Scott Branden wrote:
> Hi Joe,
> 
> A few questions about changes below.
> 
> On 2020-06-10 3:22 p.m., Joe Perches wrote:
> > On Wed, 2020-06-10 at 14:48 -0700, Scott Branden wrote:
> > > On 2020-06-10 2:09 p.m., Joe Perches wrote:
> > > > On Wed, 2020-06-10 at 13:33 -0700, Scott Branden wrote:
> > > > > Ignore CamelCase for inttypes.h for fixed integer types format specifiers.
> > > > > (ex. PRIx32 for uint32_t).
> > > > Personally, I don't like those.
> > > Checkpatch is run against a lot of code outside of the linux kernel but
> > > following linux coding style.
> > I know.  I don't have any strong feeling about this either.
> > 
> > But _this_ checkpatch is specifically for the linux-kernel.
> > 
> > I just don't want to encourage a bunch of uses of these
> > somewhat useless defines internal to linux-kernel sources.
> > 
> > > There is nothing personal about this, they are the format specifiers in
> > > inttypes.h for fixed width types .
> > True.  It's impersonal to me too.
> > 
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > > > @@ -5157,6 +5157,8 @@ sub process {
> > > > >    			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
> > > > >    #Ignore Page<foo> variants
> > > > >    			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
> > > > > +#Ignore inttypes.h scanf/printf format specifiers for fixed size integer types
> > > > > +			    $var !~ /^(?:PRI|SCN)[dxoui](8|16|32|64|PTR|MAX)?$/ &&
> > There are missing format specifiers.
> > If this is done, the test should be against a variable
> > 
> > Something like:
> > 
> > our $inttype_format = qr{(?x:
> > 		(?:PRI|SCN)
> > 		[diouxX]
> > 		(?:FAST|LEAST)?
> > 		(?:8|16|32|64|MAX|PTR)
> > };
> I can try adding the "X" and FAST|LEAST.
> But I am not familiar enough with perl or the checkpatch script to 
> understand
> what you mean by test should be against a variable vs what I have done.
> > btw: what about 24, 48, 96, 128 and 256?
> I can't find those values described for inttypes.h format specifiers.

There are others outside of linux.
http://cmod.gforge.inria.fr/doxygen/group__POSIX%E2%88%B7std%E2%88%B7inttypes%E2%88%B7__Snippet.html

> Where are you looking at those values from?
> > > > >    #Ignore SI style variants like nS, mV and dB
> > > > >    #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
> > > > >    			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

Like this:
---
 scripts/checkpatch.pl | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..112ea055eba1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -565,6 +565,14 @@ our $C90_int_types = qr{(?x:
 	(?:(?:un)?signed\s+)?int
 )};
 
+# inttype.h formats
+our $inttype_formats = qr{(?x:
+	(?:PRI|SCN)
+	[diouxX]
+	(?:FAST|LEAST)?
+	(?:8|16|32|64|MAX|PTR)
+)};
+
 our @typeListFile = ();
 our @typeListWithAttr = (
 	@typeList,
@@ -5151,7 +5159,8 @@ sub process {
 #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
-			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
+			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/ &&
+			    $var !~ /^$inttype_formats$/) {
 				while ($var =~ m{($Ident)}g) {
 					my $word = $1;
 					next if ($word !~ /[A-Z][a-z]|[a-z][A-Z]/);


