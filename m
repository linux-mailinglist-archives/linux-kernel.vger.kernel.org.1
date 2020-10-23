Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4DD297659
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbgJWSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:01:40 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:46618 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754121AbgJWSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:01:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E2C42180A90FD;
        Fri, 23 Oct 2020 18:01:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3871:3874:4321:5007:8603:10004:10400:10848:10967:11026:11232:11658:11783:11914:12043:12296:12297:12740:12895:13069:13161:13229:13311:13357:13439:13894:14181:14659:14721:21080:21324:21451:21627:21740:21741:30054:30060:30070:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: nail06_130978d2725b
X-Filterd-Recvd-Size: 2266
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Oct 2020 18:01:36 +0000 (UTC)
Message-ID: <c0210eade81060382884e1f38ca7f71742d02b61.camel@perches.com>
Subject: Re: [PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 23 Oct 2020 11:01:35 -0700
In-Reply-To: <20201023112226.4035e3f7@lwn.net>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
         <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
         <20201023112226.4035e3f7@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 11:22 -0600, Jonathan Corbet wrote:
> On Fri, 23 Oct 2020 18:32:48 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The include/linux/genalloc.h file defined this typedef:
> > 
> > 	typedef unsigned long (*genpool_algo_t)(unsigned long *map,unsigned long size,unsigned long start,unsigned int nr,void *data, struct gen_pool *pool, unsigned long start_addr);
[]
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
[]
> >      # Parse function prototypes
> > -    if ($x =~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> > +    if ($x =~ /typedef\s+(\w+\s*){1,}\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> 
> I sure wish we could find a way to make all these regexes more
> understandable and maintainable.  Reviewing a change like this is ... fun.

Perhaps using some of the checkpatch regex definitions like:

$Type
$Ident
$balanced_parens

would help improve readability.

And the regex above doesn't quite work for spacing after typedef.
The regex should allow space between the open parenthesis and the *

	typedef <Type> ( * <Ident> ) (args...);

And this regex does not find typedefs that use another typedef as <Ident> like:

arch/s390/include/asm/debug.h:typedef int (debug_header_proc_t) (debug_info_t *id,


