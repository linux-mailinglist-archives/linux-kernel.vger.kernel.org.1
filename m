Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4C2DFEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLURSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:18:37 -0500
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:56252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgLURSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:18:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3995118037D2A;
        Mon, 21 Dec 2020 17:17:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,coupons@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2197:2198:2199:2200:2393:2559:2562:2828:2903:2908:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3870:3871:3873:3874:4250:4321:4605:5007:7903:10004:10400:10848:11232:11233:11658:11914:12043:12297:12740:12895:13019:13069:13095:13161:13229:13311:13357:13439:13894:14181:14659:14721:21080:21221:21433:21627:21939:30054:30069:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tray82_421167e27459
X-Filterd-Recvd-Size: 2771
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Dec 2020 17:17:53 +0000 (UTC)
Message-ID: <fa637be6bb02336a3df6e3c3fdc800b9b17d079f.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: kconfig: add missing types to regex
From:   Joe Perches <coupons@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Mon, 21 Dec 2020 09:17:52 -0800
In-Reply-To: <5d7cef4f-071d-0504-74df-bd944a11dd70@fau.de>
References: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
         <1f3b50a6f343dd252c043b2e5b7d47bca8514ee7.camel@perches.com>
         <5d7cef4f-071d-0504-74df-bd944a11dd70@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-21 at 16:08 +0100, Nicolai Fischer wrote:
> On Sun, 2020-12-20 at 20:16 +0100, Joe Perches wrote:
> > On Mon, 2020-12-14 at 11:24 +0100, Nicolai Fischer wrote:
> > > Kconfig parsing does not recognise all type attributes.
> > > This adds the missing 'int', 'sting' and 'hex' types.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3321,7 +3321,7 @@ sub process {
> > >  				next if ($f =~ /^-/);
> > >  				last if (!$file && $f =~ /^\@\@/);
> > >  
> > > 
> > > -				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> > > +				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*["']/) {
> > >  					$is_start = 1;
> > >  				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
> > >  					$length = -1;
> > 
> > Another thing that could be done is to enforce the "extra 2 spaces"
> > indent by capturing the whitespace before the help keyword:
> > 
> > 				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
> > 
> > could be
> > 
> > 				} elsif ($lines[$ln - 1] =~ /^\+(\s*)help\s*$/) {
> > 
> > with $1 used to validate the extra indent.
> > 
> > 
> 
> 
> In case the indent does not match, should we display a new warning as in our previous patch?

Sure, but in a separate patch and ensure blank lines are ignored.

+                               if ($l !~ /^\ {2}/) {
+                                       $wrong_indent = 1;
                                }

The message you used:
+                               WARN("CONFIG_DESCRIPTION",
+                                       "help text is not indented 2 spaces more than the help keyword\n" . $herecurr);

is IMO a bit oddly phrased and could/should test only
the first line after the help keyword and show the help
line using $hereprev.



