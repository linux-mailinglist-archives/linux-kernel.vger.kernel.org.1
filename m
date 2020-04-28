Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645BB1BC4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 18:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgD1QKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 12:10:50 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:33800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728615AbgD1QKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:10:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 62773180A68C6;
        Tue, 28 Apr 2020 16:10:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:8957:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:30012:30054:30070:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: owl46_23d38036f883f
X-Filterd-Recvd-Size: 1658
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Apr 2020 16:10:46 +0000 (UTC)
Message-ID: <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de,
        mcroce@redhat.com
Date:   Tue, 28 Apr 2020 09:10:44 -0700
In-Reply-To: <20200428020223.GA28074@udknight>
References: <20200428020223.GA28074@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 10:02 +0800, Wang YanQing wrote:
> According to submitting-patches.rst, 'Fixes:' tag has a little
> stricter condition about the one line summary:
> ...
> Do not split the tag across multiple
> lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> parsing scripts
> ...
> 
> And there is no 'Fixes:' tag format checker in checkpatch to check
> the commit id length too, so let's add dedicated checker to check
> these conditions for 'Fixes:' tag.

There's no need to duplicate functionality like this.
Put this additional Fixes: logic into the existing block.

(and don't take advise from Markus too seriously when it
comes to English grammar or wording.  He is not an arbiter
of taste for this code)


