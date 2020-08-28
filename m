Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0E256056
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgH1SRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 14:17:31 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:35428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726677AbgH1SR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:17:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A8F7B5DC5;
        Fri, 28 Aug 2020 18:17:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3872:3874:4321:5007:6119:7903:10004:10400:11026:11232:11658:11914:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:21795:21990:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: goose22_600e06e27077
X-Filterd-Recvd-Size: 1995
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 18:17:24 +0000 (UTC)
Message-ID: <23029e176062d707bdd5ca1d360f9bedcec3aaa6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in
 git
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Aug 2020 11:17:23 -0700
In-Reply-To: <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
         <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 14:23 +0200, Rasmus Villemoes wrote:
> On 25/08/2020 02.09, Joe Perches wrote:
> > If a file exists in git and checkpatch is used without the -f
> > flag for scanning a file, then checkpatch will scan the file
> > assuming it's a patch

[]

> > +sub git_is_single_file {
> > +	my ($filename) = @_;
> > +
> > +	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> > +
> > +	my $output = `${git_command} ls-files -- $filename`;
> > +	my $count = $output =~ tr/\n//;
> > +	return $count eq 1 && $output =~ m{^${filename}$};
> > +}
> 
> Isn't that somewhat expensive to do for each file?

Just FYI:  Not really.

On my 4 year old laptop git ls-files -- <file> takes
about .02 seconds.

$ time git ls-files -- 'net/l2tp/l2tp_ip.c'
net/l2tp/l2tp_ip.c

real	0m0.013s
user	0m0.009s
sys	0m0.004s

Even uncached, it's quite quick.

# sync; echo 3 > /proc/sys/vm/drop_caches
$ time git ls-files -- 'net/l2tp/l2tp_ip.c'
net/l2tp/l2tp_ip.c

real	0m0.079s
user	0m0.004s
sys	0m0.037s

cheers, Joe

