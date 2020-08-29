Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7360025658F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgH2HNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 03:13:35 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:50738 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgH2HNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:13:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7755018029138;
        Sat, 29 Aug 2020 07:13:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2560:2563:2682:2685:2693:2828:2859:2895:2914:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4184:4321:5007:6117:6119:7875:8603:9025:10004:10400:10848:11026:11232:11658:11914:12043:12295:12296:12297:12555:12679:12740:12760:12895:13161:13229:13439:14096:14097:14180:14181:14659:14721:21060:21080:21627:21795:21990:30012:30029:30034:30051:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: beds82_040d8132707c
X-Filterd-Recvd-Size: 3330
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 07:13:29 +0000 (UTC)
Message-ID: <fe4de2e9f0a492e66b870cddbadb820e3459cc7a.camel@perches.com>
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 00:13:28 -0700
In-Reply-To: <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
         <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 09:59 +0300, Denis Efremov wrote:
> Hi,
> 
> On 8/29/20 1:52 AM, Joe Perches wrote:
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content requests and it's possible to
> > overrun the buffer length.
> > 
> > Add a generic sysfs_emit mechanism that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > --- rK
> 
> It could be a good idea to update the docs to, i.e.:
> https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

Yes, thanks.

I have the below already, but Greg makes a sensible point
about the generic use of sysfs_emit for single values
which is ~95% of the actual uses, so likely there will be
two functions.  Given the multiple thousand instances,
using 2 functions would be smaller overall object code
as well.

Perhaps:

sysfs_emit (for single value output)
sysfs_emit_at (or sysfs_emit_pos ? or some better name?)

	int sysfs_emit(char *buf, const char *fmt, ...)
	int sysfs_emit_at(char *buf, int pos, const char *fmt, ...)

or maybe use

	int sysfs_emit_pos(char *buf, char *pos, const char *fmt, ...)

The multiple use emit_at with int as the 2nd parameter would
make the direct return easier than the char * which needs a
subtraction.

six of this/half dozen of that...

cheers...

---

Anyway, this will need updating, likely with better examples.

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index ab0f7795792b..13c7a86fa6c8 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -242,12 +242,9 @@ Other notes:
   is 4096.
 
 - show() methods should return the number of bytes printed into the
-  buffer. This is the return value of scnprintf().
+  buffer. This is the return value of sysfs_emit().
 
-- show() must not use snprintf() when formatting the value to be
-  returned to user space. If you can guarantee that an overflow
-  will never happen you can use sprintf() otherwise you must use
-  scnprintf().
+- show() methods should only use sysfs_emit to format output.

