Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C017B1BAD78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgD0TDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 15:03:33 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:46360 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD0TDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:03:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B39EF837F27E;
        Mon, 27 Apr 2020 19:03:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3870:3871:3872:4321:5007:10004:10400:10481:10848:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:19900:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tub42_1ecb9cba3653a
X-Filterd-Recvd-Size: 1529
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 19:03:31 +0000 (UTC)
Message-ID: <ce8be38d71da0a9020a42359152dad7ee217d18c.camel@perches.com>
Subject: Re: [PATCH 3/3] mtd: lpddr: Move function print_drs_error to
 lpddr_cmds.c
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Date:   Mon, 27 Apr 2020 12:03:30 -0700
In-Reply-To: <5cc0d2e83e971693d974235608c8d96fe94c849d.1588013366.git.gustavo@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
         <5cc0d2e83e971693d974235608c8d96fe94c849d.1588013366.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 14:04 -0500, Gustavo A. R. Silva wrote:
> Function print_drs_error is only used in drivers/mtd/lpddr/lpddr_cmds.c
> so, better to move it there.
[]
> diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
[]
> @@ -94,6 +94,39 @@ struct mtd_info *lpddr_cmdset(struct map_info *map)
>  }
>  EXPORT_SYMBOL(lpddr_cmdset);
>  
> +static inline void print_drs_error(unsigned int dsr)

There's no need for inline as it's used once.


