Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956A829830B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418004AbgJYSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:19:18 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:38384 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1417979AbgJYSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:19:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1EE5C837F24D;
        Sun, 25 Oct 2020 18:19:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3866:3867:3868:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: aunt05_1d1847e2726c
X-Filterd-Recvd-Size: 1516
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Oct 2020 18:19:16 +0000 (UTC)
Message-ID: <6c1c62cd8ac119a6d8a84f262f11eb509ba0e7cc.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: extend attributes check to handle more
 patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 25 Oct 2020 11:19:14 -0700
In-Reply-To: <CABJPP5Cec7jKfaygRaxm-z5gzhg-7cBX1GP46NRQDM6rfhg3Ww@mail.gmail.com>
References: <20201025101537.59133-1-dwaipayanray1@gmail.com>
         <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
         <CABJPP5Cec7jKfaygRaxm-z5gzhg-7cBX1GP46NRQDM6rfhg3Ww@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-25 at 23:40 +0530, Dwaipayan Ray wrote:
> On Sun, Oct 25, 2020 at 11:29 PM Joe Perches <joe@perches.com> wrote:
[]
> > Using $rawline would also change comments and that seems wrong.
> > Any reason to use $rawline instead of $line?
> Yes I used $line initially but changed it because quoted
> strings were being replaced.
> 
> Like:
> __attribute__((__section__("_ftrace_events")))

Right thanks, that's a very sensible tradeoff to reduce code complexity.


