Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1532C1858
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgKWWYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:24:12 -0500
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:34174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728161AbgKWWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:24:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 3C1C0100E7B43;
        Mon, 23 Nov 2020 22:24:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2731:2828:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4385:4559:4605:5007:6119:6120:7514:7809:7903:10004:10400:10848:11026:11232:11657:11658:11914:12043:12295:12296:12297:12438:12555:12679:12681:12740:12760:12895:12986:13095:13161:13181:13229:13439:14181:14659:14721:21080:21324:21433:21451:21611:21627:21939:21990:30012:30046:30054:30055:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:87,LUA_SUMMARY:none
X-HE-Tag: skin07_30012d527369
X-Filterd-Recvd-Size: 4485
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Nov 2020 22:24:08 +0000 (UTC)
Message-ID: <afd4d5199527b33c4c428090b8a3d360b9565549.camel@perches.com>
Subject: [RFC PATCH] Add a new "Frozen" status to MAINTAINERS subsystem
 entries
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>, Bernard Zhao <bernard@vivo.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Mon, 23 Nov 2020 14:24:07 -0800
In-Reply-To: <20201123214208.GB675342@ravnborg.org>
References: <20201119072957.108941-1-bernard@vivo.com>
         <20201123214208.GB675342@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-23 at 22:42 +0100, Sam Ravnborg wrote:
> For this old driver we should try to limit patches to bug fixing and
> infrastructure updates.

It might be useful to add a new "S:" entry type to these old drivers
as supported/maintained/obsolete may not really be appropriate.

How about something like "S: Frozen" and checkpatch could emit a
message similar to the one for unnecessary changes to obsolete code?

So using the below would emit:

$ ./scripts/checkpatch.pl -f drivers/gpu/drm/via/via_dma.c
WARNING: drivers/gpu/drm/via/via_dma.c is marked as 'frozen' in the MAINTAINERS hierarchy.  No unnecessary modifications please.

Maybe like the below (and fyi there's no additional git lookup overhead as
the initial obsolete check already caches the git result).

---
 MAINTAINERS           | 10 +++++++++-
 scripts/checkpatch.pl | 11 +++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f10105cac6f..6374d29180b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -88,7 +88,10 @@ Descriptions of section entries and preferred order
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
-			much other than throw the odd patch in. See below..
+			much other than throw the odd patch in.
+	   Frozen:	Old code that should not be modified unless changes
+			are to correct actual defects or API infrastructure.
+			Cleanup/style changes are not generally accepted.
 	   Orphan:	No current maintainer [but maybe you could take the
 			role as you write your new code].
 	   Obsolete:	Old code. Something tagged obsolete generally means
@@ -5718,6 +5721,11 @@ S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/udl/
 
+DRM DRIVER FOR VIA
+L:	dri-devel@lists.freedesktop.org
+S:	Frozen
+F:	drivers/gpu/drm/via/
+
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
 M:	Melissa Wen <melissa.srw@gmail.com>
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fdfd5ec09be6..79321cbfb761 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -902,8 +902,8 @@ sub seed_camelcase_file {
 
 our %maintained_status = ();
 
-sub is_maintained_obsolete {
-	my ($filename) = @_;
+sub is_maintained {
+	my ($filename, $test) = @_;
 
 	return 0 if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
 
@@ -911,7 +911,7 @@ sub is_maintained_obsolete {
 		$maintained_status{$filename} = `perl $root/scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback -f $filename 2>&1`;
 	}
 
-	return $maintained_status{$filename} =~ /obsolete/i;
+	return $maintained_status{$filename} =~ /$test/i;
 }
 
 sub is_SPDX_License_valid {
@@ -2633,9 +2633,12 @@ sub process {
 		}
 
 		if ($found_file) {
-			if (is_maintained_obsolete($realfile)) {
+			if (is_maintained($realfile, "obsolete")) {
 				WARN("OBSOLETE",
 				     "$realfile is marked as 'obsolete' in the MAINTAINERS hierarchy.  No unnecessary modifications please.\n");
+			} elsif (is_maintained($realfile, "frozen")) {
+				WARN("FROZEN",
+				     "$realfile is marked as 'frozen' in the MAINTAINERS hierarchy.  No unnecessary modifications please.\n");
 			}
 			if ($realfile =~ m@^(?:drivers/net/|net/|drivers/staging/)@) {
 				$check = 1;


