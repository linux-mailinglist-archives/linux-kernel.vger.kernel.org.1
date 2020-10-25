Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594FB29835C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 20:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418514AbgJYTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 15:23:25 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:50434 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1418507AbgJYTXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 15:23:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DFF89100E7B42;
        Sun, 25 Oct 2020 19:23:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:857:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3871:3872:3874:4321:4605:5007:8603:8879:9121:10004:10400:10471:10848:10967:11026:11232:11233:11658:11914:12043:12297:12438:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14181:14659:14721:21080:21611:21627:21660:21773:30012:30054:30062:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: view04_0705c4a2726d
X-Filterd-Recvd-Size: 1750
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Oct 2020 19:23:22 +0000 (UTC)
Message-ID: <7e76d1c3239bf2d33889c4874bc9919fee6b6ebe.camel@perches.com>
Subject: Re: drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame
 size of 13472 bytes in function 'ltv350qv_power'
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Date:   Sun, 25 Oct 2020 12:23:21 -0700
In-Reply-To: <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
References: <202010260230.VivTG0Gb-lkp@intel.com>
         <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-25 at 12:17 -0700, Andrew Morton wrote:
> On Mon, 26 Oct 2020 02:15:37 +0800 kernel test robot <lkp@intel.com> wrote:
> > vim +/ltv350qv_power +192 drivers/video/backlight/ltv350qv.c
> 
> Odd - the code looks pretty normal.  It is possible that your compiler
> is (crazily) inlining ltv350qv_write_reg()?

There's a lot of stack used when gcc's compiler options include

           -fsanitize=object-size
               This option enables instrumentation of memory references using
               the "__builtin_object_size" function.  Various out of bounds
               pointer accesses are detected.

Perhaps this config enables it?


