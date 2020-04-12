Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF761A600E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgDLTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 15:47:54 -0400
Received: from smtprelay.hostedemail.com (smtprelay0152.hostedemail.com [216.40.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA4C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 12:47:54 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 6A56818013526;
        Sun, 12 Apr 2020 19:47:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2731:2828:2894:3138:3139:3140:3141:3142:3352:3622:3865:3868:3872:4321:4362:5007:6117:6119:7809:7875:10004:10400:10848:11232:11657:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:13846:14096:14097:14181:14659:14721:21080:21212:21451:21627:21740:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tooth14_7ef77ec3d0010
X-Filterd-Recvd-Size: 2969
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Apr 2020 19:47:52 +0000 (UTC)
Message-ID: <c1f28a6b5ae0fc1b6575d74c72363921ff74da44.camel@perches.com>
Subject: Re: Request to sort MAINTAINERS again just before an -rc1 release
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 12 Apr 2020 12:45:46 -0700
In-Reply-To: <CAHk-=whs8jNmbrXVyOekWD2zugN=jweHrspPqYVx59+0c5BWhQ@mail.gmail.com>
References: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
         <af4673918a3f6bfba51118d68d554d4a1ff3dad4.camel@perches.com>
         <CAHk-=whs8jNmbrXVyOekWD2zugN=jweHrspPqYVx59+0c5BWhQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-12 at 11:08 -0700, Linus Torvalds wrote:
> On Sat, Apr 11, 2020 at 9:45 AM Joe Perches <joe@perches.com> wrote:
> > Please consider running and committing:
> > 
> > $ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order
> 
> Ok, done. Let's see how painful this ends up being..

Thanks.

Hopefully, it's not too bad as were only 4 diff sections
for MAINTAINERS between your tree and the latest -next
before these changes.

$ diff -urN MAINTAINERS ../next/MAINTAINERS
--- MAINTAINERS	2020-04-12 12:40:53.261770465 -0700
+++ ../next/MAINTAINERS	2020-04-11 22:10:49.051770733 -0700
@@ -2259,6 +2259,8 @@
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/dts/rtd*
+F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
 
@@ -5959,6 +5961,7 @@
 S:	Maintained
 F:	include/linux/dim.h
 F:	lib/dim/
+F:	Documentation/networking/net_dim.rst
 
 DZ DECSTATION DZ11 SERIAL DRIVER
 M:	"Maciej W. Rozycki" <macro@linux-mips.org>
@@ -9155,6 +9158,17 @@
 F:	scripts/kconfig/
 F:	scripts/Kconfig.include
 
+KCSAN
+M:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kcsan.rst
+F:	include/linux/kcsan*.h
+F:	kernel/kcsan/
+F:	lib/Kconfig.kcsan
+F:	scripts/Makefile.kcsan
+
 KDUMP
 M:	Dave Young <dyoung@redhat.com>
 M:	Baoquan He <bhe@redhat.com>
@@ -9386,6 +9400,13 @@
 F:	include/keys/
 F:	security/keys/
 
+KFIFO:
+M:	Stefani Seibold <stefani@seibold.net>
+S:	Maintained
+F:	lib/kfifo.c
+F:	include/linux/kfifo.h
+F:	samples/kfifo/
+
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
 M:	Daniel Thompson <daniel.thompson@linaro.org>


