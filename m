Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0727A2C71C2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbgK1VvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:03 -0500
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:36666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729662AbgK1S2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:28:42 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id D848918020B0F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 16:00:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D2046181D3028;
        Sat, 28 Nov 2020 16:00:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2525:2540:2565:2612:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:7809:7903:9010:9025:9388:10004:10049:10400:10848:11232:11657:11658:11914:12043:12048:12296:12297:12679:12740:12895:13019:13439:13894:14093:14097:14106:14181:14659:14721:14822:21080:21451:21627:21691:21740:21773:21781:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:245,LUA_SUMMARY:none
X-HE-Tag: rub33_0c07f4a27391
X-Filterd-Recvd-Size: 3363
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Nov 2020 16:00:06 +0000 (UTC)
Message-ID: <6e9917257cfd6774066446014051d39b784ba497.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>, apw@canonical.com, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 28 Nov 2020 08:00:04 -0800
In-Reply-To: <f96ff56c-7c39-2fed-dd8b-11971f8965bf@redhat.com>
References: <20201127214316.3045640-1-trix@redhat.com>
         <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
         <f96ff56c-7c39-2fed-dd8b-11971f8965bf@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-28 at 07:36 -0800, Tom Rix wrote:
> On 11/27/20 2:10 PM, Joe Perches wrote:
[]
> > I think an exception mechanism would be better than a specific
> > mechanism added to various entries.
> Can you give an example of what you mean ?

Inherit the parent prefix then add the basename(dirname) as a default.

For instance, changes to any subsystem of drivers/staging starts as
"staging: " and with "$basename(path): " appended.

So the MAINTAINERS entry for staging could be:

STAGING SUBSYSTEM
M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
L:	devel@driverdev.osuosl.org
S:	Supported
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
D:	"staging: "
F:	drivers/staging/

Any specified D: use would override the generic form.

And generic ARM changes could use the same mechanism with:

ARM PORT
M:	Russell King <linux@armlinux.org.uk>
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:	Odd Fixes
W:	http://www.armlinux.org.uk/
T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git
D:	"ARM: "
F:	arch/arm/
X:	arch/arm/boot/dts/

And media likewise:

MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
M:	Mauro Carvalho Chehab <mchehab@kernel.org>
L:	linux-media@vger.kernel.org
S:	Maintained
W:	https://linuxtv.org
Q:	http://patchwork.kernel.org/project/linux-media/list/
T:	git git://linuxtv.org/media_tree.git
D:	"media: "
F:	Documentation/admin-guide/media/
F:	Documentation/devicetree/bindings/media/
F:	Documentation/driver-api/media/
F:	Documentation/userspace-api/media/
F:	drivers/media/
F:	drivers/staging/media/
F:	include/linux/platform_data/media/
F:	include/media/
F:	include/uapi/linux/dvb/
F:	include/uapi/linux/ivtv*
F:	include/uapi/linux/media.h
F:	include/uapi/linux/meye.h
F:	include/uapi/linux/uvcvideo.h
F:	include/uapi/linux/v4l2-*
F:	include/uapi/linux/videodev2.h

etc...

> > >  # check MAINTAINERS entries for the right ordering too
> > > -			my $preferred_order = 'MRLSWQBCPTFXNK';
> > > +			my $preferred_order = 'MRLSWQBCPTFXNKD';
> > >  			if ($rawline =~ /^\+[A-Z]:/ &&
> > >  			    $prevrawline =~ /^[\+ ][A-Z]:/) {
> > >  				$rawline =~ /^\+([A-Z]):\s*(.*)/;
> > I'd prefer to keep the file and keyword list last.
> > 
> So change to
> 
> my $preferred_order = 'MRLSWQBCPTDFXNK'; 
> 
> ?

Right.  And update the preferred_order in scripts/parse-maintainers.pl too.



