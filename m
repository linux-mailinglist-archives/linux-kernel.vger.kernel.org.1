Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8A2A3DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 08:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgKCH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 02:28:09 -0500
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:59148 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgKCH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:28:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 88E3F1730877;
        Tue,  3 Nov 2020 07:28:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:6119:7514:7875:8545:9108:10004:10400:10848:11232:11658:11914:12043:12297:12663:12740:12760:12895:13069:13072:13095:13160:13229:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21451:21627:21660:21819:30003:30022:30026:30029:30030:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: blade17_1707ebf272b6
X-Filterd-Recvd-Size: 2792
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Nov 2020 07:28:07 +0000 (UTC)
Message-ID: <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Date:   Mon, 02 Nov 2020 23:28:06 -0800
In-Reply-To: <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com>
References: <20201103054810.21978-1-dwaipayanray1@gmail.com>
         <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 11:28 +0530, Dwaipayan Ray wrote:
> On Tue, Nov 3, 2020 at 11:18 AM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > 
> > checkpatch doesn't report warnings for many common mistakes
> > in emails. Some of which are trailing commas and incorrect
> > use of email comments.
> > 
> > At the same time several false positives are reported due to
> > incorrect handling of mail comments. The most common of which
> > is due to the pattern:
> > 
> > <stable@vger.kernel.org> # X.X
> > 
> > Improve email parsing mechanism in checkpatch.
> > 
> > What is added:
> > 
> > - Support for multiple name/address comments.
> > - Improved handling of quoted names.
> > - Sanitize improperly formatted comments.
> > - Sanitize trailing semicolon or dot after email.
[]
> What do you think? Should warnings for the names which should
> be quoted be reported considering this result?

Clearly the quote suggestion is unnecessary.

I think that "cc: stable@(?:vger\.)?kernel\.org" should be
treated differently from other forms of invalid/odd address lines.

My suggestion is that the case insensitive form of

Cc: stable@vger.kernel.org

or only another similar case insensitive forms with a
# comment separator like

Cc: <stable@vger.kernel.org> # some comment

be acceptable for stable.

All other forms with stable@ should emit some message.

And other <foo>-by: and cc: addresses should only have a form like

Signed-off-by: "Full.Name" (possible comment) <email@domain.tld>
or
Signed-off-by: Full Name (possible comment) <email@domain.tld>

etc..

and any additional content after .tld in the email address be flagged
with some message like "unexpected content after email address" rather
than "might be better as".

What do you think best?

