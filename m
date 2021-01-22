Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC4300C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbhAVTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:12:23 -0500
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:55932 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728962AbhAVTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:11:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 62056100E7B40;
        Fri, 22 Jan 2021 19:10:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1719:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2691:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6226:7652:9025:10010:10400:10450:10455:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13161:13208:13229:13255:13311:13357:13439:14181:14659:14721:19904:19999:21067:21080:21451:21627:21660:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: slip91_5f17ab72756e
X-Filterd-Recvd-Size: 2290
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Jan 2021 19:10:11 +0000 (UTC)
Message-ID: <27366417ad75e0300d4647f776ca61bb1b132507.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols
 in assembly files
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
Date:   Fri, 22 Jan 2021 11:10:10 -0800
In-Reply-To: <98d40817-1f80-c772-eb9e-a6c3c04625b3@gmail.com>
References: <20210120072547.10221-1-yashsri421@gmail.com>
         <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
         <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com>
         <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
         <98d40817-1f80-c772-eb9e-a6c3c04625b3@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-22 at 18:48 +0530, Aditya wrote:
> On 21/1/21 12:13 am, Joe Perches wrote:
> > I believe the test should be:
> > 
> > 	if ($realfile =~ /\.S$/ &&
> > 	    $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
> 
> Joe, with this regex, we won't be able to match
> "jmp  .L_restore
> SYM_FUNC_END(\name)"

I think that's not an issue.

> which was replaced in this patch in the discussion:
> https://groups.google.com/g/clang-built-linux/c/-drkmLgu-cU/m/phKe-Tb6CgAJ
> 
> Here, "jmp  .L_restore" was also replaced to fix the error.

Notice that this line was also replaced in the same patch:

 #ifdef CONFIG_PREEMPTION
-SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
+SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)


> However, if this
> regex(/^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) is
> correct, maybe we don't need to check for $file as we are now checking
> for just one line.
> 
> What do you think?

The test I wrote was complete, did not use $file and emits a
warning on the use of CODE_SYM_START_LOCAL_NOALIGN(.L_restore)

I think it's sufficient.

