Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2C2C1ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgKXH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:26:40 -0500
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:51608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729915AbgKXH0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:26:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 89429180A7FD7;
        Tue, 24 Nov 2020 07:26:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3871:3872:3874:4321:5007:6120:7901:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13255:13311:13357:13439:14181:14659:14721:21080:21212:21627:21660:21740:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: grape01_14135a62736c
X-Filterd-Recvd-Size: 1629
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Nov 2020 07:26:37 +0000 (UTC)
Message-ID: <8f6f634f3c4e079fd16922f2dd1109f2974319b2.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add fix and improve warning msg for
 Non-standard signature
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Nov 2020 23:26:36 -0800
In-Reply-To: <CAKXUXMzcMWeM2M81b2PZ+D54LO6xd+m667vygWVF93Mnsq8QQg@mail.gmail.com>
References: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
         <20201123172430.12854-1-yashsri421@gmail.com>
         <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
         <CAKXUXMzcMWeM2M81b2PZ+D54LO6xd+m667vygWVF93Mnsq8QQg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-24 at 07:54 +0100, Lukas Bulwahn wrote:
> On Mon, Nov 23, 2020 at 6:33 PM Joe Perches <joe@perches.com> wrote:
[]
> Maybe a patch reduced to the very obvious synonyms helps newcomers or
> people with lousy memory to be reminded that it is called
> "Co-developed-by:" not "Co-authored-by".

I have no issue with proximity matching for nominally invalid uses.
I think the method used wasn't great though.
For trivial spelling defects, levenshtein might work well enough.



