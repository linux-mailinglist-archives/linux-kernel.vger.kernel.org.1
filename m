Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108791D5795
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgEORWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:22:54 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:38548 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEORWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:22:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0812D182CED5B;
        Fri, 15 May 2020 17:22:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3870:3871:3872:3874:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12296:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14180:14659:14721:21060:21067:21080:21221:21324:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: able05_3631f4c4af504
X-Filterd-Recvd-Size: 2261
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 17:22:52 +0000 (UTC)
Message-ID: <ba9cbced1ccb0e7da5593b587bb179328cecd80e.camel@perches.com>
Subject: Re: get_maintainer.pl: unexpected behaviour for path/to//file
From:   Joe Perches <joe@perches.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 10:22:51 -0700
In-Reply-To: <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com>
References: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
         <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-15 at 05:31 -0700, Joe Perches wrote:
> On Fri, 2020-05-15 at 11:52 +0100, Emil Velikov wrote:
> > Hi Joe,
> > 
> > Recently I've noticed that get_maintainer behaves differently if there
> > is a double, sequential, forward slash in the path.
> > 
> > AFAICT there should be no distinction between the two. Or at least many
> > existing applications and scripts consider them one and the same.
> > 
> > I've tried fixing this, although my perl isn't quite up-to scratch.
> > Is this some weird bug or some intended feature?
> 
> Not really an intended feature.
> The code counts slashes for directory depth.
> 
> I suppose it might be simpler to do this:

Or perhaps a better alternative is:
---
 scripts/get_maintainer.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6d973f3685f9..484d2fbf5921 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -19,6 +19,7 @@ my $V = '0.26';
 use Getopt::Long qw(:config no_auto_abbrev);
 use Cwd;
 use File::Find;
+use File::Spec::Functions;
 
 my $cur_path = fastgetcwd() . '/';
 my $lk_path = "./";
@@ -532,6 +533,7 @@ if (!@ARGV) {
 
 foreach my $file (@ARGV) {
     if ($file ne "&STDIN") {
+	$file = canonpath($file);
 	##if $file is a directory and it lacks a trailing slash, add one
 	if ((-d $file)) {
 	    $file =~ s@([^/])$@$1/@;


