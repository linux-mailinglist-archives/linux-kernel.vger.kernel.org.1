Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B62DDC77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 01:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgLRAvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 19:51:25 -0500
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:45206 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727177AbgLRAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 19:51:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8CA2E180A7FEA;
        Fri, 18 Dec 2020 00:50:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:196:355:379:599:800:960:966:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2525:2553:2566:2682:2685:2828:2829:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3698:3865:3867:3868:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4385:5007:7576:8957:9010:9012:9025:10004:10400:10848:11026:11232:11473:11658:11854:11914:12043:12297:12438:12555:12740:12895:12986:13071:13149:13161:13229:13230:13439:13894:14180:14181:14659:14721:21060:21080:21324:21451:21627:21660:21990:30054:30060:30062:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:49,LUA_SUMMARY:none
X-HE-Tag: horn93_441077427439
X-Filterd-Recvd-Size: 3580
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Dec 2020 00:50:42 +0000 (UTC)
Message-ID: <3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 17 Dec 2020 16:50:41 -0800
In-Reply-To: <20201217235615.43328-1-helgaas@kernel.org>
References: <20201217235615.43328-1-helgaas@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 17:56 -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> as lore.kernel.org because they use different styles, add advertising, and
> may disappear in the future.  The lore archives are more consistent and
> more likely to stick around, so prefer https://lore.kernel.org URLs when
> they exist.

Hi Bjorn.

I like the idea, thanks, but a couple notes.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -564,6 +564,17 @@ sub find_standard_signature {
>  	return "";
>  }
 
> +our $obsolete_archives = qr{(?xi:
> +	freedesktop.org/archives/dri-devel|
> +	lists.infradead.org|
> +	lkml.org|
> +	mail-archive.com|
> +	mailman.alsa-project.org/pipermail|
> +	marc.info|
> +	ozlabs.org/pipermail|
> +	spinics.net
> +)};

Strictly, these all need \Q \E escaping so uses like lkmlAorg do not match.


> @@ -3101,6 +3112,12 @@ sub process {
>  			}
>  		}
>  
> +# Check for mailing list archives other than lore.kernel.org
> +		if ($line =~ /(http|https):\/\/\S*$obsolete_archives/) {

The https?:// doesn't seem necessary.  Perhaps:

		if ($line =~ m{\b$obsolete_archives}) {

> +			WARN("PREFER_LORE_ARCHIVE",
> +			     "Use lore.kernel.org archive links when possible; see https://lore.kernel.org/lists.html\n" . $herecurr);

Perhaps:
			     "Prefer lore.kernel.org links. see: https://www.kernel.org/lore.html#linking-to-list-discussions-from-commits\n" . $herecurr);

So maybe instead:
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..c2a324d628a6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -564,6 +564,17 @@ sub find_standard_signature {
 	return "";
 }
 
+our $obsolete_archives = qr{(?xi:
+	\Qfreedesktop.org/archives/dri-devel\E |
+	\Qlists.infradead.org\E |
+	\Qlkml.org\E |
+	\Qmail-archive.com\E |
+	\Qmailman.alsa-project.org/pipermail\E |
+	\Qmarc.info\E |
+	\Qozlabs.org/pipermail\E |
+	\Qspinics.net\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -3101,6 +3112,12 @@ sub process {
 			}
 		}
 
+		# Check for mailing list archives other than lore.kernel.org
+		if ($rawline =~ m{\b$obsolete_archives}) {
+			WARN("PREFER_LORE_ARCHIVE",
+			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||


