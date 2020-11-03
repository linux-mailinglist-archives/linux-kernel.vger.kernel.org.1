Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB612A502B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgKCTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:32:15 -0500
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:52518 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgKCTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:32:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7092218225AE2;
        Tue,  3 Nov 2020 19:32:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:7903:8526:10004:10400:10848:11232:11658:11914:12295:12297:12679:12740:12760:12895:13095:13149:13161:13181:13229:13230:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21660:21819:30003:30022:30029:30054:30062:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: iron68_570fe6d272bb
X-Filterd-Recvd-Size: 3437
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Nov 2020 19:32:12 +0000 (UTC)
Message-ID: <6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Date:   Tue, 03 Nov 2020 11:32:10 -0800
In-Reply-To: <CAKXUXMwH+tEBSV6xA952xQQFe+HvdJ5ew6V=n63sk89enj6p7Q@mail.gmail.com>
References: <20201103054810.21978-1-dwaipayanray1@gmail.com>
         <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com>
         <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
         <CAKXUXMwH+tEBSV6xA952xQQFe+HvdJ5ew6V=n63sk89enj6p7Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 09:10 +0100, Lukas Bulwahn wrote:
> Maybe you can coordinate among each other who would want to create
> suitable fix rules here?

Yes please.

> Also, start with the class of the most frequent mistakes for
> unexpected content after email addresses.
> 
> I imagine that a maintainer can simply run a tag sanitizing script
> which just cleans up those stupid mistakes before creating their git
> trees or sending git pulls to Linus.

Does anyone really do that?
It generally requires rebasing or post processing each commit after
being committed before another commit occurs.

> Let us try to add these
> sanitizing rules to checkpatch.pl with fix options for now; if that
> sanitizing feature becomes a monster script of its own within
> checkpatch.pl, we can refactor that into an independent script for
> cleaning up.

I rather doubt an independent script is going to be worthwhile
as these rules shouldn't be all that complex.

The only prefixes acceptable for a stable address should be
CC:|Cc:|cc:.  There are 2 uses in the last 100k commits for
Signed-off-by: and Acked-by: with stable addresses, those should have a
message/warning emitted in the future.

The forms used with those cc: stable addresses:

2777	stable without comment
1381	stable # comment
74	stable [ comment ]

So I suggest standardizing on no comment and # comment with any other
style getting a warning.

For non-stable <foo>-by: and cc: addresses and other signatures:

Likely any content after a email address other than a parenthesized
block should have some checkpatch message emitted.

This should be OK:

Signed-off-by: Full Name (comment) <address@domain.tld> (maintainer:...)

But perhaps this should not be OK:

Signed-off-by: Full Name (comment) <address@domain.tld> # comment

There are 316 uses of this # comment style in the last 100k commits
and 103 with (comment) after the address.
Maybe the # use should be ok, maybe not.

And anyone that uses a multiple comments in a name or a even
a single comment in the email address should also get warned.

The below should not be OK even if actually valid address forms:

Signed-off-by: Full (comment1) Name (comment2) <address@domain.tld>
Signed-off-by: Full Name <address@(comment)domain.tld>


