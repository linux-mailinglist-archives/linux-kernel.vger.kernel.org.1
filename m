Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483B9279665
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 05:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgIZD2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 23:28:05 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:46534 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729134AbgIZD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 23:28:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1B17C1822326F;
        Sat, 26 Sep 2020 03:28:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3874:4321:4605:5007:8603:10004:10400:10848:11026:11232:11658:11914:12296:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14180:14659:14721:14819:21080:21627:21740:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: comb22_38090052716d
X-Filterd-Recvd-Size: 2302
Received: from XPS-9350 (cpe-23-242-83-182.socal.res.rr.com [23.242.83.182])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Sep 2020 03:28:02 +0000 (UTC)
Message-ID: <16c9a13fb945065cd1fc9f0b9ece1862e42867e0.camel@perches.com>
Subject: Re: [PATCH next 0/2] printk: fix reading beyond buffer
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 20:28:00 -0700
In-Reply-To: <20200926015526.8921-1-john.ogness@linutronix.de>
References: <20200926015526.8921-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-26 at 04:01 +0206, John Ogness wrote:
> Hello,
> 
> Marek Szyprowski reported [0] a problem with a particular printk
> usage. This particular usage performs thousands of LOG_CONT calls.
> The printk.c implementation was only limiting the growing record by
> the maximum size available in the ringbuffer, thus creating a record
> that was several kilobytes in size. This in and of itself is not
> a problem.

Perhaps another mechanism would be to change the code to
add a backspace before the rotor and have the printk
ringbuffer actually backspace on \h when position > 0

Something like:
---
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..8a36443b4866 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -257,7 +258,7 @@ int __init rd_load_image(char *from)
                kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
 #if !defined(CONFIG_S390)
                if (!(i % 16)) {
-                       pr_cont("%c\b", rotator[rotate & 0x3]);
+                       pr_cont("\h%c\b", rotator[rotate & 0x3]);
                        rotate++;
                }
 #endif

