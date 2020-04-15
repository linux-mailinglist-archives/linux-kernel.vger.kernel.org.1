Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BB1A9519
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635341AbgDOHty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 03:49:54 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:45180 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635311AbgDOHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F013918015D9D;
        Wed, 15 Apr 2020 07:49:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:3873:4321:5007:6737:8660:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13148:13230:13311:13357:13439:14659:14721:21080:21451:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: juice76_900e1bed61f58
X-Filterd-Recvd-Size: 2008
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Apr 2020 07:49:49 +0000 (UTC)
Message-ID: <e9b90677b2d97c556c400e3744518942e0b58d41.camel@perches.com>
Subject: Re: [PATCH] Bitmap: Optimized division operation to shift operation
From:   Joe Perches <joe@perches.com>
To:     Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Date:   Wed, 15 Apr 2020 00:47:39 -0700
In-Reply-To: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
References: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 15:27 +0800, Wang Qing wrote:
> On some processors, the / operate will call the compiler`s div lib,
> which is low efficient. Bitmap is performance sensitive, We can
> replace the / operation with shift.

Seems more like bad compilers than useful code changes
unless you can specify what compilers and what processors.

> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
[]
> @@ -337,7 +337,7 @@ static inline int bitmap_equal(const unsigned long *src1,
>  		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
>  	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
>  	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
> -		return !memcmp(src1, src2, nbits / 8);
> +		return !memcmp(src1, src2, nbits >> 3);


