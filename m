Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068F321CEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 07:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgGMFWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 01:22:55 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:47762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbgGMFWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:22:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B4B0B182240AB;
        Mon, 13 Jul 2020 05:22:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6299:7514:7903:9010:10010:10400:10848:11026:11232:11233:11658:11914:12043:12262:12296:12297:12438:12555:12663:12679:12740:12760:12895:12986:13141:13161:13229:13230:13439:14181:14659:14721:21080:21365:21433:21451:21627:21819:21939:21990:30003:30022:30054:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: scene76_1e0bdf926ee5
X-Filterd-Recvd-Size: 4087
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Jul 2020 05:22:51 +0000 (UTC)
Message-ID: <da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add Bruno Thomsen as reviewer of
 Kamstrup DTS
From:   Joe Perches <joe@perches.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Sun, 12 Jul 2020 22:22:50 -0700
In-Reply-To: <20200713025559.GZ21277@dragon>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
         <20200629114927.17379-3-bruno.thomsen@gmail.com>
         <20200713025559.GZ21277@dragon>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-13 at 10:56 +0800, Shawn Guo wrote:
> On Mon, Jun 29, 2020 at 01:49:27PM +0200, Bruno Thomsen wrote:
> > Add myself as reviewer of device trees for Kamstrup
> > Concentrators.
> > 
> > Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 496fd4eafb68..97fc112309af 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9282,6 +9282,11 @@ S:	Maintained
> >  F:	Documentation/hwmon/k8temp.rst
> >  F:	drivers/hwmon/k8temp.c
> >  
> > +KAMSTRUP CONCENTRATORS
> > +R:	Bruno Thomsen <bruno.thomsen@gmail.com>
> > +S:	Maintained
> > +F:	arch/arm/boot/dts/imx7d-flex-concentrator*.dts
> > +
> 
> I guess get_maintainer.pl should list you for patches touching the
> files, so it's not really required?  I'm worried about that MAINTAINERS
> file will get bloated quickly if we patch it for every single DTS
> file.

Right now, a little less than half of the .dts* files
have an author or other email address in them.

$ git ls-files arch/arm/boot/dts/*.dts* | wc -l
2105

$ git grep -P --name-only '<\S+@\S+>' arch/arm/boot/dts/*.dts* | wc -l
997

Some have multiple email addresses:

$ git grep -P '<\S+@\S+>' arch/arm/boot/dts/*.dts* | wc -l
1240

(and there are a few false positives in that regex)

I suppose that get_maintainer could handle .dts* files
the same way .yaml files are handled so any email address
in the file is added to patches that touch the file.

This is the commit that added the .yaml file handling:

commit 0c78c013762142bfe8fce34e7e968f83f0a4b891
Author: Joe Perches <joe@perches.com>
Date:   Thu Jun 4 16:50:01 2020 -0700

    get_maintainer: add email addresses from .yaml files
    
    .yaml files can contain maintainer/author addresses and it seems unlikely
    or unnecessary that individual MAINTAINER file section entries for each
    .yaml file will be created.
    
    So add the email addresses found in .yaml files to the default
    get_maintainer output.
    
    The email addresses are marked with "(in file)" when using the "--roles"
    or "--rolestats" options.

So something like:
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..4c3c69d7bed0 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -436,7 +436,7 @@ sub maintainers_in_file {
 
     return if ($file =~ m@\bMAINTAINERS$@);
 
-    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
+    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
 	open(my $f, '<', $file)
 	    or die "$P: Can't open $file: $!\n";
 	my $text = do { local($/) ; <$f> };


