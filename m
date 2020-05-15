Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33021D59A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 15:07:02 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:44244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:07:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1C72D100E7B4D;
        Fri, 15 May 2020 19:07:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:966:967:973:982:988:989:1260:1277:1311:1313:1314:1336:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2197:2199:2200:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:5007:6117:6119:6750:7514:7808:7809:7903:9010:9025:10004:10400:10848:11026:11658:11914:12043:12297:12555:12679:12740:12760:12895:12986:13161:13221:13229:13255:13439:13848:13891:14181:14394:14659:14721:21080:21221:21324:21451:21627:30034:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: cake00_5a47450899a10
X-Filterd-Recvd-Size: 3250
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 19:07:00 +0000 (UTC)
Message-ID: <9a18b611813bb409fef15bc8927adab79eb9be43.camel@perches.com>
Subject: [PATCH] get_maintainer: Fix unexpected behavior for path/to//file
 (double slashes)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 12:06:59 -0700
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

get_maintainer behaves differently if there is a
double sequential forward slash in a filename because
the total number of slashes in a filename is used to
match MAINTAINERS file patterns.

For example:

# (with double slash)
$ ./scripts/get_maintainer.pl -f drivers/gpu/drm//lima
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS,commit_signer:3/42=7%)
Qiang Yu <yuq825@gmail.com> (commit_signer:36/42=86%,authored:24/42=57%)
Vasily Khoruzhick <anarsoul@gmail.com> (commit_signer:26/42=62%)
Krzysztof Kozlowski <krzk@kernel.org> (commit_signer:5/42=12%,authored:5/42=12%)
Emil Velikov <emil.velikov@collabora.com> (commit_signer:4/42=10%)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
linux-kernel@vger.kernel.org (open list)

# (without double slash)
$ ./scripts/get_maintainer.pl -f drivers/gpu/drm/lima
Qiang Yu <yuq825@gmail.com> (maintainer:DRM DRIVERS FOR LIMA)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA)
lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
linux-kernel@vger.kernel.org (open list)

So reduce consecutive double slashes to a single slash
by using File::Spec->canonpath().

from: https://perldoc.perl.org/File/Spec/Unix.html

canonpath()

No physical check on the filesystem, but a logical cleanup of a
path. On UNIX eliminates successive slashes and successive "/.".

Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Joe Perches <joe@perches.com>
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


