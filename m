Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A362CC65D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgLBTPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:15:33 -0500
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:55188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgLBTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:15:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3D95518224D6B;
        Wed,  2 Dec 2020 19:14:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3874:4321:4605:5007:6120:7875:10004:10128:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:13972:14096:14097:14659:14721:14819:21080:21433:21611:21627:21939:30003:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: map52_230a82a273b5
X-Filterd-Recvd-Size: 2515
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 19:14:50 +0000 (UTC)
Message-ID: <fa4e75fa79a89b20f903364acc604cf0796b5421.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: correctly detect lines of help text
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Wed, 02 Dec 2020 11:14:49 -0800
In-Reply-To: <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
References: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
         <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
         <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-02 at 10:59 -0800, Randy Dunlap wrote:
> On 12/2/20 10:54 AM, Joe Perches wrote:
[]
> > Indentation can vary in the help blocks.  For instance:
> > 
> > arch/Kconfig:   help
> > arch/Kconfig-     Functions will have the stack-protector canary logic added in>
> > arch/Kconfig-     of the following conditions:
> > arch/Kconfig-
> > arch/Kconfig-     - local variable's address used as part of the right hand sid>
> > arch/Kconfig-       assignment or function argument
> > arch/Kconfig-     - local variable is an array (or union containing an array),
> > arch/Kconfig-       regardless of array type or length
> > arch/Kconfig-     - uses register local variables
> > arch/Kconfig-
> > 
> > This doesn't allow blank lines for multi-paragraph help text either.
> > 
> > I think keyword parsing is necessary and some false positives are
> > inevitable as the parsing logic in a line-by-line analyzer will
> > always be incomplete.
> 
> There are also large hunks of block/Kconfig and drivers/hid/Kconfig
> that don't use any indentation for help text...
> in case that matters here.

Maybe a wholesale conversion of Kconfig help text could be done moving
any help block not already as the last entry to be the last entry and
indenting any paragraph help text not already indented 2 extra spaces.

Should be reasonably scriptable given the parser logic available in
scripts/kconfig/.

Something akin to the scripts/parse-maintainers.pl script.

