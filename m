Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828642FDA32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392642AbhATTzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:55:47 -0500
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:52892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387509AbhATSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:44:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CB1C1365F;
        Wed, 20 Jan 2021 18:43:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7652:7875:10004:10400:10450:10455:10848:11026:11232:11473:11658:11914:12043:12295:12297:12438:12663:12740:12760:12895:13255:13439:14096:14097:14659:14721:19904:19999:21080:21324:21433:21451:21627:21660:21740:21741:30012:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lunch37_0515e5b2755c
X-Filterd-Recvd-Size: 4179
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jan 2021 18:43:23 +0000 (UTC)
Message-ID: <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols
 in assembly files
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 20 Jan 2021 10:43:22 -0800
In-Reply-To: <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com>
References: <20210120072547.10221-1-yashsri421@gmail.com>
         <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
         <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-20 at 18:23 +0530, Aditya wrote:
> On 20/1/21 2:51 pm, Joe Perches wrote:
> > On Wed, 2021-01-20 at 12:55 +0530, Aditya Srivastava wrote:
> > > Local symbols prefixed with '.L' do not emit symbol table entries, as
> > > they have special meaning for the assembler.
> > > 
> > > '.L' prefixed symbols can be used within a code region, but should be
> > > avoided for denoting a range of code via 'SYM_*_START/END' annotations.
> > > 
> > > Add a new check to emit a warning on finding the usage of '.L' symbols
> > > in '.S' files, if it lies within SYM_*_START/END annotation pair.
> > 
> > I believe this needs a test for $file as it won't work well on
> > patches as the SYM_*_START/END may not be in the patch context.
> > 
> Okay.
> 
> > Also, is this supposed to work for local labels like '.L<foo>:'?
> > I don't think a warning should be generated for those.
> > 
> Yes, currently it will generate warning for all symbols which start
> with .L and have non- white character symbol following it, if it is
> lying within SYM_*_START/END annotation pair.
> 
> Should I reduce the check to \.L_\S+ instead? (please note "_"
> following ".L")

Use grep first.  That would still match several existing labels.

> Pardon me, I'm not good with assembly :/

Spending time reading docs can help with that.

Mark?  Can you please comment about the below?

I believe the test should be:

	if ($realfile =~ /\.S$/ &&
	    $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
		WARN(...);
	}

so that only this code currently matches:

$ git grep -P '^\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L' -- '*.S'
arch/x86/boot/compressed/head_32.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
arch/x86/boot/compressed/head_32.S:SYM_FUNC_END(.Lrelocated)
arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lrelocated)
arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lpaging_enabled)
arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lno_longmode)
arch/x86/boot/pmjump.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
arch/x86/boot/pmjump.S:SYM_FUNC_END(.Lin_pm32)
arch/x86/entry/entry_64.S:SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
arch/x86/entry/entry_64.S:SYM_CODE_END(.Lbad_gs)
arch/x86/lib/copy_user_64.S:SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
arch/x86/lib/copy_user_64.S:SYM_CODE_END(.Lcopy_user_handle_tail)
arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_clac)
arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_8_clac)
arch/x86/lib/putuser.S:SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
arch/x86/lib/putuser.S:SYM_CODE_END(.Lbad_put_user_clac)
arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_START_LOCAL(.Lwakeup_idt)
arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_END(.Lwakeup_idt)


