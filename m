Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61F22B14A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 04:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgKMDXW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 22:23:22 -0500
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:56438 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725929AbgKMDXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 22:23:22 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 22:23:21 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 09A73181CA0BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:16:29 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 20FA2182CED34;
        Fri, 13 Nov 2020 03:16:28 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1513:1515:1516:1518:1521:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3872:3873:5007:6261:7514:7875:7903:8603:9036:9040:9108:10004:10400:10848:10967:11232:11658:11914:12297:12663:12740:12895:13069:13311:13357:14096:14097:14181:14721:14777:21080:21451:21627:21740:21795:21796:30026:30036:30051:30054:30056:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: drink26_140126d2730b
X-Filterd-Recvd-Size: 2063
Received: from pixel3.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (Authenticated sender: rostedt@goodmis.org)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 03:16:27 +0000 (UTC)
Date:   Thu, 12 Nov 2020 22:16:24 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20201113112108.77486a0475216ada6f8e03a0@kernel.org>
References: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org> <160520205132.303174.4876760192433315429.stgit@devnote2> <CADjb_WSx+sbxAz=p5dCN5PXzR5Zq2Nb3kgup-r8qNM1ftUMzDw@mail.gmail.com> <20201113112108.77486a0475216ada6f8e03a0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] bootconfig: Extend the magic check range to the preceding 3 bytes
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
CC:     Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Steven Rostedt <rostedt@goodmis.org>
Message-ID: <3FAD1266-B73D-41C8-A81C-E61867317240@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 12, 2020 9:21:08 PM EST, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>On Fri, 13 Nov 2020 09:27:38 +0800
>Chen Yu <yu.chen.surf@gmail.com> wrote:
>
>> On Fri, Nov 13, 2020 at 1:27 AM Masami Hiramatsu
><mhiramat@kernel.org> wrote:
>> >
>> > Since Grub may align the size of initrd to 4 if user pass
>> > initrd from cpio, we have to check the preceding 3 bytes as well.
>> >
>> > Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for
>indicating bootconfig explicitly")
>> > Reported-by: Chen Yu <yu.chen.surf@gmail.com>
>> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> > ---
>> Works for me, thanks!
>> Tested-by: Chen Yu <yu.chen.surf@gmail.com>
>
>Thank you Chen!
>
>Steve, could you merge this fix? 
>

I'm testing it now.

-- Steve

>Thank you,
>
>> 
>> Best,
>> Chenyu

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
