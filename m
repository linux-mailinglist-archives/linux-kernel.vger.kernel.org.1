Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9491F2CDE6E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgLCTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:04:56 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:46258 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbgLCTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:04:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 72571182CED34;
        Thu,  3 Dec 2020 19:04:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:960:966:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1981:2194:2196:2197:2199:2200:2201:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3873:3874:4250:4321:4385:4605:5007:6119:6120:7903:7904:10004:10848:11232:11233:11658:11914:12043:12048:12291:12297:12555:12679:12683:12723:12737:12740:12895:13161:13229:13439:13894:14096:14097:14181:14659:14721:21063:21080:21221:21433:21611:21627:21740:21939:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ear41_3411058273be
X-Filterd-Recvd-Size: 5946
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Dec 2020 19:04:12 +0000 (UTC)
Message-ID: <40543766190a1d5e054e6573ae00112467acf964.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: correctly detect lines of help text
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de,
        linux-kernel-mentees@lists.linuxfoundation.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Date:   Thu, 03 Dec 2020 11:04:11 -0800
In-Reply-To: <7a81a3c0-2734-4799-5b34-0a6279c1e59d@infradead.org>
References: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
         <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
         <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
         <a83033e9fcc706be129e9c4c0d30a0542f13d406.camel@perches.com>
         <7a81a3c0-2734-4799-5b34-0a6279c1e59d@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 10:31 -0800, Randy Dunlap wrote:
> On 12/3/20 9:58 AM, Joe Perches wrote:
> > On Wed, 2020-12-02 at 10:59 -0800, Randy Dunlap wrote:
> > 
> > > There are also large hunks of block/Kconfig and drivers/hid/Kconfig
> > > that don't use any indentation for help text...
> > > in case that matters here.
> > 
> > Maybe something like this could help.
> > 
> > Indent the unindented help blocks by 2 spaces and reflow where appropriate.
> > 
> > ---
> >  block/Kconfig       | 105 +++++-----
> >  drivers/hid/Kconfig | 549 +++++++++++++++++++++++++++-------------------------
> >  2 files changed, 335 insertions(+), 319 deletions(-)
> 
> 
> LGTM. Thanks.

btw: there appears to be ~750 help sections in Kconfig files
that do not use 2 space indentation for the help content vs
the ~14000 help sections that do use 2 space indentation.

Maybe there's some value in standardizing on the 2 space style.

A trivial script to show the sections that don't use 2 spaces:

$ git grep -n -A1 -P "^\s*help\s*$" -- '*/Kconfig*' |
  grep -v '^--$' |
  perl -e 'while (<>) {
    my $line1 = $_;
    my $line2 = <>;

    my $l1 = $line1;
    my $l2 = $line2;

    chomp($l1);
    chomp($l2);

    $l1 =~ s/^.*:\d+:(\s*).*/$1/;
    $l2 =~ s/^.*-\d+-(\s*).*/$1/;

    if ("$l1  " ne "$l2") {
	print "$line1";
	print "$line2";
    }
}'

Change the ne to eq to see the matches.

For instance, a head -50 of the above is:

arch/Kconfig:84:	help
arch/Kconfig-85-	 This option enables a transparent branch optimization that
arch/Kconfig:127:	help
arch/Kconfig-128-	 If function tracer is enabled and the arch supports full
arch/Kconfig:167:	help
arch/Kconfig-168-	 Modern versions of GCC (since 4.4) have builtin functions
arch/Kconfig:1056:       help
arch/Kconfig-1057-          An architecture should select this if its syscall numbering is sparse
arch/alpha/Kconfig:147:	help
arch/alpha/Kconfig-148-	  XL-233 and XL-266-based Alpha systems.
arch/arm/Kconfig:1001:       help
arch/arm/Kconfig-1002-	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
arch/arm/Kconfig-nommu:9:	help
arch/arm/Kconfig-nommu-10-	 Say Y to manually set the base addresses and sizes.
arch/arm/Kconfig.debug:24:	help
arch/arm/Kconfig.debug-25-		Generate a warning if any W+X mappings are found at boot.
arch/arm/mach-aspeed/Kconfig:21:	help
arch/arm/mach-aspeed/Kconfig-22-	 Say yes if you intend to run on an Aspeed ast2400 or similar
arch/arm/mach-aspeed/Kconfig:31:	help
arch/arm/mach-aspeed/Kconfig-32-	 Say yes if you intend to run on an Aspeed ast2500 or similar
arch/arm/mach-aspeed/Kconfig:42:	help
arch/arm/mach-aspeed/Kconfig-43-	 Say yes if you intend to run on an Aspeed ast2600 or similar
arch/arm/mach-imx/Kconfig:230:	help
arch/arm/mach-imx/Kconfig-231-		This enables support for Freescale i.MX7 Dual processor.
arch/arm/mach-ixp4xx/Kconfig:41:    help
arch/arm/mach-ixp4xx/Kconfig-42-	  Say 'Y' here if you want your kernel to support the Giant
arch/arm/mach-ixp4xx/Kconfig:178:	help
arch/arm/mach-ixp4xx/Kconfig-179-		This board is currently inside the Linksys WRV54G Gateways.
arch/arm/mach-ixp4xx/Kconfig:216:	help
arch/arm/mach-ixp4xx/Kconfig-217-          IXP4xx provides two methods of accessing PCI memory space:
arch/arm/mach-omap1/Kconfig:61:	help
arch/arm/mach-omap1/Kconfig-62-          TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
arch/arm/mach-omap1/Kconfig:68:    	help
arch/arm/mach-omap1/Kconfig-69-	  TI OMAP 1610/1611B H2 board support. Say Y here if you have such
arch/arm/mach-omap1/Kconfig:75:    	help
arch/arm/mach-omap1/Kconfig-76-	  TI OMAP 1710 H3 board support. Say Y here if you have such
arch/arm/mach-omap1/Kconfig:88:    	help
arch/arm/mach-omap1/Kconfig-89-	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
arch/arm/mach-omap1/Kconfig:95:    	help
arch/arm/mach-omap1/Kconfig-96-	  The OSK supports an optional add-on board with a Quarter-VGA
arch/arm/mach-omap1/Kconfig:103:    	help
arch/arm/mach-omap1/Kconfig-104-	  Support for TI OMAP 730 Perseus2 board. Say Y here if you have such
arch/arm/mach-omap1/Kconfig:110:    	help
arch/arm/mach-omap1/Kconfig-111-	  Support for TI OMAP 850 F-Sample board. Say Y here if you have such
arch/arm/mach-omap1/Kconfig:126:	help
arch/arm/mach-omap1/Kconfig-127-	 Support for the Palm Zire71 PDA. To boot the kernel,
arch/arm/mach-omap1/Kconfig:175:	help
arch/arm/mach-omap1/Kconfig-176-          Support for generic OMAP-1510, 1610 or 1710 board with
arch/arm/mach-prima2/Kconfig:24:	help
arch/arm/mach-prima2/Kconfig-25-          Support for CSR SiRFSoC ARM Cortex A9 Platform


