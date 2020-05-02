Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885AA1C2823
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 22:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgEBUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 16:00:53 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:47680 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728107AbgEBUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:00:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 06F1B182CED5B;
        Sat,  2 May 2020 20:00:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:2892:2895:3138:3139:3140:3141:3142:3622:3865:3867:3868:3872:3873:4321:4470:5007:10004:10400:10848:11232:11658:11914:12048:12295:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21611:21627:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: glove61_5eb0837fb5c1c
X-Filterd-Recvd-Size: 1433
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 20:00:50 +0000 (UTC)
Message-ID: <57b725f495e422e80c062d2edd90abe99f40fd51.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Wang YanQing <udknight@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Date:   Sat, 02 May 2020 13:00:49 -0700
In-Reply-To: <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
References: <20200502185421.GB9082@udknight>
         <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-02 at 21:40 +0200, Markus Elfring wrote:
> > The check doesn't support below formats and it will emit diagnostics info for them:
[]
> Will the tolerance (and support) grow for such quotation character alternatives?

No.

> Does this information indicate a need to split possible changes into
> separate update steps?

No.

> * Which formula do you propose for the length calculation?

None.

