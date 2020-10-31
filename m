Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1242A1569
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgJaLOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:14:39 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:35294 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgJaLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:14:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9ED681802912D;
        Sat, 31 Oct 2020 11:14:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3873:3874:4321:4470:5007:6119:7514:7903:8531:10004:10400:10848:11232:11658:11914:12043:12297:12555:12679:12740:12760:12895:13161:13229:13439:14181:14659:14721:21080:21324:21433:21451:21627:21660:21819:21939:30003:30022:30029:30030:30054:30056:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lake80_4c091ad2729e
X-Filterd-Recvd-Size: 3204
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 31 Oct 2020 11:14:36 +0000 (UTC)
Message-ID: <8b6d8af8ef3e3499f647c5895c79891e0b26ac6c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: improve handling of email comments
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Date:   Sat, 31 Oct 2020 04:14:35 -0700
In-Reply-To: <CABJPP5Ca8SNGmoE7GVc0OBotFhA6mLuX46QQETiVcQwTKHRosA@mail.gmail.com>
References: <20201030090704.40533-1-dwaipayanray1@gmail.com>
         <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
         <alpine.DEB.2.21.2010301255460.16621@felia>
         <8b9beccf81735f2e042447026a1043f8d21c2566.camel@perches.com>
         <CABJPP5Ca8SNGmoE7GVc0OBotFhA6mLuX46QQETiVcQwTKHRosA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-31 at 11:41 +0530, Dwaipayan Ray wrote:
> Names which have must quote characters without any comments are
> not warned about right now:
> 
> D. Ray <dwaipayanray1@gmail.com> doesn't throw any warning, while
> D. Ray (Dwai) <dwaipayanray1@gmail.com> does.

I agree that a comment in parentheses after the name and before
the email address is an issue that should be resolved.

I think your proposed solution isn't great through.

> Do you think this should be dealt separately from this patch?

I think the cc: stable@(?:vger\.)?kernel.org with additional
content on the same line should be separated from other email
addresses with additional content on the same line.

> Perhaps as another warning?

Dunno.

Try this git log grep:

$ git log --format=email -100000 | \
  grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' | \
  grep -v 'stable\@' | \
  grep -P '\>.+'

This finds any signature/cc line with content after an
email address that end with a close angle bracket that
doesn't go to the stable address.

Think about what content after that close angle bracket
should and shoud not be allowed.

There are a few variants here:

o comments (optional whitespace, followed by '#' or '[' or '(' or c89)
o misuse of quote (around the whole name and address)
o Odd commas after '>' likely from defective cut'n'paste use

Then add this to the first grep to avoid the comments as above

$ git log --format=email -100000 | \
  grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' | \
  grep -v 'stable\@' | \
  grep -P '\>.+' | \
  grep -vP '\>\s*(?:\#|\(|/\*|\[)'

Shouldn't all these be reported?
Are they if your patch is applied?

Then look at the addresses that do not have a close angle
bracket and also have more content after the email address.

$ git log --format=email -100000 | \
  grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' | \
  grep -v 'stable@' | \
  grep -vP '<[\w\.\@\+\-]+>' | \
  grep -vP '[\w\.\@\+\-]+$'

What of all of these should be reported?

Happy testing...

