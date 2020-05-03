Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B532A1C2DA4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgECPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:46:26 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:38026 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728595AbgECPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:46:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 743E31AA68;
        Sun,  3 May 2020 15:46:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1566:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3872:4321:5007:8957:10004:10400:10848:11026:11232:11473:11658:11914:12297:12555:12740:12760:12895:13069:13255:13311:13357:13439:14659:21080:21451:21627:21990:30054:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: linen69_721df84ad8f1e
X-Filterd-Recvd-Size: 1355
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 May 2020 15:46:24 +0000 (UTC)
Message-ID: <83ef442fc90cbfce1d8566e43e9af2bd2089b4e1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add support for title acrosses three lines
 in commit id description
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Sun, 03 May 2020 08:46:22 -0700
In-Reply-To: <20200503123435.GD10332@udknight>
References: <20200503123435.GD10332@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-03 at 20:34 +0800, Wang YanQing wrote:
> The current GIT_COMMIT_ID will report error when the title in commit id
> description acrosses three lines, take changelog of commit 87b0f983f66f
> ("net: mscc: ocelot: fix untagged packet drops when enslaving to vlan
> aware bridge") as a example.

I think it's a diminishing returns problem.

What percentage of commits in the last 10000
has this issue?


