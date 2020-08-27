Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBEB2549DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 17:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgH0Ptr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 11:49:47 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:40072 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgH0Ptq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:49:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 287CB8384369;
        Thu, 27 Aug 2020 15:49:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3871:3873:3874:4321:5007:8603:10004:10400:10848:11026:11232:11658:11914:12114:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21990:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: veil31_321096a2706e
X-Filterd-Recvd-Size: 1317
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 15:49:43 +0000 (UTC)
Message-ID: <f939c3d239443a68e0aff7148b1c245ffc18643d.camel@perches.com>
Subject: Re: [PATCH] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 08:49:41 -0700
In-Reply-To: <741486db-29e8-e24e-32c1-9559e3a76a06@linux.com>
References: <20200827151923.40067-1-efremov@linux.com>
         <741486db-29e8-e24e-32c1-9559e3a76a06@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 18:28 +0300, Denis Efremov wrote:
> > @@ -1013,10 +1013,7 @@ static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
> >  	size = sizeof(struct udf_bitmap) +
> >  		(sizeof(struct buffer_head *) * nr_groups);
> 
> I missed that this size is a good place to use struct_size for
> overflow checking. I will send v2 instead.

And you could cuddle the

	if (!bitmap)
		return NULL;

by removing the blank line between the alloc and test.


