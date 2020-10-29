Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75C29F3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJ2STL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:19:11 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:54544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgJ2STK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:19:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 11EB9100E7B42;
        Thu, 29 Oct 2020 18:19:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,coupons@perches.com,,RULES_HIT:41:69:355:379:800:960:966:968:973:988:989:1042:1260:1277:1311:1313:1314:1345:1437:1472:1515:1516:1518:1534:1542:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2538:2553:2559:2562:2734:2736:2828:3138:3139:3140:3141:3142:3351:3855:3865:3866:3867:3868:3870:3871:3874:4250:4321:4385:5007:6117:6119:7809:7901:8784:9149:10004:10400:10450:10455:10848:11658:11914:12043:12050:12262:12291:12295:12296:12297:12438:12555:12679:12683:12700:12737:12740:12760:12895:12986:13017:13018:13019:13439:13972:14093:14096:14097:14181:14345:14659:14721:14824:19904:19999:21067:21080:21212:21220:21365:21433:21451:21611:21627:21740:21772:21773:21939:30012:30054:30067:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:9,LUA_SUMMARY:none
X-HE-Tag: heat72_0c1867e2728f
X-Filterd-Recvd-Size: 3640
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Oct 2020 18:19:06 +0000 (UTC)
Message-ID: <0d249f3a1dfb74c7d37716d2b3024345b0a27512.camel@perches.com>
Subject: drivers/char/agp/hp-agp.c - mismatch between SPDX and MODULE_LICENSE
From:   Joe Perches <coupons@perches.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu, 29 Oct 2020 11:19:05 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(SPDX mismatches found using this grep)

$ git grep --name-only 'MODULE_LICENSE("GPL and add' -- '*.c' | xargs grep SPDX
drivers/char/agp/hp-agp.c:// SPDX-License-Identifier: GPL-2.0-only
drivers/dma-buf/selftest.c:/* SPDX-License-Identifier: MIT */
drivers/gpu/drm/ttm/ttm_module.c:/* SPDX-License-Identifier: GPL-2.0 OR MIT */
drivers/gpu/drm/vboxvideo/vbox_drv.c:// SPDX-License-Identifier: MIT
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:// SPDX-License-Identifier: GPL-2.0 OR MIT

Back in 2003, the (fullhist) commit below perhaps inappropriately
removed license text that allowed arbitrary changes to source
code while adding 'MODULE_LICENSE("GPL and additional rights");'

Today, the license for this file is:

// SPDX-License-Identifier: GPL-2.0-only

So there is a mismatch between the SPDX identifier and the
MODULE_LICENSE in the file.

So the SPDX identifier now seems inappropriate.
Perhaps that can be rectified somehow...
 
commit 229f2fcdfa1377fb20174e6990460d8c60d33ada
Author: Dave Jones <davej@codemonkey.org.uk>
Date:   Tue Dec 3 01:22:23 2002 -0100

    rework as per Linus' suggestion. Chipset drivers are now seperate modules
    that use the pci driver interfaces, and register with the agpgart backend.
---
 drivers/char/agp/hp-agp.c | 98 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
index b1911f1dce7a..a733f38a3928 100644
--- a/drivers/char/agp/hp-agp.c
+++ b/drivers/char/agp/hp-agp.c
@@ -1,29 +1,5 @@
 /*
- * AGPGART module version 0.99
- * Copyright (C) 1999 Jeff Hartmann
- * Copyright (C) 1999 Precision Insight, Inc.
- * Copyright (C) 1999 Xi Graphics, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * JEFF HARTMANN, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM, 
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
- * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





