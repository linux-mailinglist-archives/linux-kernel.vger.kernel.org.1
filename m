Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4B2FCDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbhATKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:14:36 -0500
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:51660 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731194AbhATJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:21:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EEF9C8384364;
        Wed, 20 Jan 2021 09:21:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:960:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3870:3871:3872:4321:5007:7652:10004:10400:10450:10455:10848:11232:11658:11914:12297:12740:12760:12895:13069:13255:13311:13357:13439:14659:19904:19999:21080:21324:21433:21451:21627:21660:21740:21741:30012:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: flesh62_610477627559
X-Filterd-Recvd-Size: 1671
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jan 2021 09:21:04 +0000 (UTC)
Message-ID: <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols
 in assembly files
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 20 Jan 2021 01:21:03 -0800
In-Reply-To: <20210120072547.10221-1-yashsri421@gmail.com>
References: <20210120072547.10221-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-20 at 12:55 +0530, Aditya Srivastava wrote:
> Local symbols prefixed with '.L' do not emit symbol table entries, as
> they have special meaning for the assembler.
> 
> '.L' prefixed symbols can be used within a code region, but should be
> avoided for denoting a range of code via 'SYM_*_START/END' annotations.
> 
> Add a new check to emit a warning on finding the usage of '.L' symbols
> in '.S' files, if it lies within SYM_*_START/END annotation pair.

I believe this needs a test for $file as it won't work well on
patches as the SYM_*_START/END may not be in the patch context.

Also, is this supposed to work for local labels like '.L<foo>:'?
I don't think a warning should be generated for those.


