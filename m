Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4E28C8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgJMG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:57:53 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:55726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727353AbgJMG5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:57:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C2FB8182CED34;
        Tue, 13 Oct 2020 06:57:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4321:5007:6119:9108:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12555:12740:12760:12895:13069:13072:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21627:21660:21819:30003:30022:30025:30026:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: name14_1e1732027201
X-Filterd-Recvd-Size: 2127
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Oct 2020 06:57:51 +0000 (UTC)
Message-ID: <a15a6cc0ddea068d78113f5e315eaba6f52b917a.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix missing whitespace in formatted email
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Mon, 12 Oct 2020 23:57:50 -0700
In-Reply-To: <20201013063642.39810-1-dwaipayanray1@gmail.com>
References: <20201013063642.39810-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-13 at 12:06 +0530, Dwaipayan Ray wrote:
> Commit 0c01921e56f9 ("checkpatch: add new warnings to author signoff
> checks.") introduced new checks for author sign off. The format_email
> procedure was modified to add comment blocks to the formatted email. But
> no space was added between the email address and mail comment.
> 
> This causes wrong email formatting in cases where the email is in the form
> "author@example.com (Comment block)". The space between the address and
> comment block is removed, which causes incorrect parsing of the
> formatted email.
> 
> An evaluation on checkpatch brought up this case. For example,
> on commit 1129d31b55d5 ("ima: Fix ima digest hash table key calculation"),
> the following warning was reported:
> 
> WARNING:BAD_SIGN_OFF: email address 'David.Laight@aculab.com (big endian
> system concerns)' might be better as 'David.Laight@aculab.com(big endian
> system concerns)'

Strictly, a comment or multiple comments can exist
in any part of an email

"John (Jon) Smith (Smitty) <jsmith@domain.tld> (tld is the best tld)

> Add a single space in between the address and comment when the
> extracted comment is not empty.

So after the address is not necessarily the best
location for a comment.


