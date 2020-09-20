Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8852712C4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgITH2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 03:28:42 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:55180 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgITH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 03:28:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id ACE941DF5;
        Sun, 20 Sep 2020 07:28:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4605:5007:7903:10010:10400:10848:11026:11232:11657:11658:11914:12043:12048:12295:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wave03_5c128222713a
X-Filterd-Recvd-Size: 2238
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Sep 2020 07:28:39 +0000 (UTC)
Message-ID: <cd22db94ad43f788b158d6633a5b26b9c0aee5ba.camel@perches.com>
Subject: Re: [PATCH] lib/scatterlist: Avoid a double memset
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        akpm@linux-foundation.org, natechancellor@gmail.com,
        geert+renesas@glider.be
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Sun, 20 Sep 2020 00:28:38 -0700
In-Reply-To: <20200920071544.368841-1-christophe.jaillet@wanadoo.fr>
References: <20200920071544.368841-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-20 at 09:15 +0200, Christophe JAILLET wrote:
> 'sgl' is zeroed a few lines below in 'sg_init_table()'. There is no need to
> clear it twice.
> 
> Remove the redundant initialization.

I didn't look very thoroughly, but there are at least
a few more of these with kcalloc and kzalloc like

block/bsg-lib.c-        size_t sz = (sizeof(struct scatterlist) * req->nr_phys_segments);
block/bsg-lib.c-
block/bsg-lib.c-        BUG_ON(!req->nr_phys_segments);
block/bsg-lib.c-
block/bsg-lib.c-        buf->sg_list = kzalloc(sz, GFP_KERNEL);
block/bsg-lib.c-        if (!buf->sg_list)
block/bsg-lib.c-                return -ENOMEM;
block/bsg-lib.c:        sg_init_table(buf->sg_list, req->nr_phys_segments);
---
drivers/target/target_core_rd.c-		sg = kcalloc(sg_per_table + chain_entry, sizeof(*sg),
drivers/target/target_core_rd.c-				GFP_KERNEL);
drivers/target/target_core_rd.c-		if (!sg)
drivers/target/target_core_rd.c-			return -ENOMEM;
drivers/target/target_core_rd.c-
drivers/target/target_core_rd.c:		sg_init_table(sg, sg_per_table + chain_entry);
---
net/rds/rdma.c-		sg = kcalloc(nents, sizeof(*sg), GFP_KERNEL);
net/rds/rdma.c-		if (!sg) {
net/rds/rdma.c-			ret = -ENOMEM;
net/rds/rdma.c-			goto out;
net/rds/rdma.c-		}
net/rds/rdma.c-		WARN_ON(!nents);
net/rds/rdma.c:		sg_init_table(sg, nents);


