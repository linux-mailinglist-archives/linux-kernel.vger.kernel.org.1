Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9928BB83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgJLPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:04:51 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:55620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388518AbgJLPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:04:51 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 79CB080081F3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:04:50 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C6683100E7B44;
        Mon, 12 Oct 2020 15:04:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3167:3622:3653:3867:3868:3872:4321:5007:7576:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:21972:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: scarf80_1d0107c271fb
X-Filterd-Recvd-Size: 1777
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 15:04:48 +0000 (UTC)
Message-ID: <f1d8b3871cc4fc9afea715c70b3615595223b576.camel@perches.com>
Subject: Re: [PATCH -v3] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 12 Oct 2020 08:04:47 -0700
In-Reply-To: <20201012142306.GB22829@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
         <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
         <20201010105421.GA24674@zn.tnic>
         <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
         <20201010161112.GC24674@zn.tnic>
         <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
         <20201012142148.GA22829@zn.tnic> <20201012142306.GB22829@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-12 at 16:23 +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -408,6 +408,7 @@ our $Lval	= qr{$Ident(?:$Member)*};
>  our $Int_type	= qr{(?i)llu|ull|ll|lu|ul|l|u};
>  our $Binary	= qr{(?i)0b[01]+$Int_type?};
>  our $Hex	= qr{(?i)0x[0-9a-f]+$Int_type?};
> +our $Hex_byte	= qr{(?i)0x[0-9a-f]{1,2}};

$Hex_byte needs to be generic and this needs to
have a trailing \b otherwise it would match
0x12 from 0x1234 and leave 34


